/*
 * generated by Xtext
 */
package rs.dsl.data.generator

import com.google.inject.Inject
import java.io.Serializable
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.xbase.compiler.ImportManager
import org.eclipse.xtext.xbase.compiler.StringBuilderBasedAppendable
import org.eclipse.xtext.xbase.compiler.TypeReferenceSerializer
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import rs.data.api.dao.IGeneralDAO
import rs.data.api.dao.ILongDAO
import rs.data.api.dao.IStringDAO
import rs.dsl.data.dataDsl.Entity
import rs.dsl.data.dataDsl.FactoryDefinition
import rs.dsl.data.dataDsl.Feature
import rs.dsl.data.dataDsl.PackageDeclaration
import java.util.Map
import java.util.HashMap
import rs.data.api.IDaoFactory

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class DataGenerator implements IGenerator {
	
	@Inject extension IQualifiedNameProvider
	@Inject extension TypeReferenceSerializer
	@Inject extension JvmTypesBuilder
	
	private Map<String, Entity> entities = new HashMap<String,Entity>()
	
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		for (e: resource.allContents.toIterable.filter(Entity)) {
			entities.put(getInterfaceName(e), e)
			fsa.generateFile(getFilename(getInterfaceName(e)), e.compileInterface)
			fsa.generateFile(getFilename(getDaoInterfaceName(e)), e.compileDaoInterface)
		}
		for (f: resource.allContents.toIterable.filter(FactoryDefinition)) {
			fsa.generateFile(getFilename(getFactoryInterfaceName(f)), f.compileFactoryInterface);
		}
	}
	
	/**************************** BO Interface *******************************/
	
	def compileInterface(Entity e) ''' 
    «val importManager = new ImportManager(true)» 
    «val body = interfaceBody(e, importManager)»
    package «getPackageName(getInterfaceName(e))»;
    
    «FOR i:importManager.imports»
    import «i»;
    «ENDFOR»
    
    «body»
  	'''
  
  	def interfaceBody(Entity e, ImportManager importManager) {
  		var String superTypes = null
  		if (e.superTypes != null) {
  			var isFirst = true
  			for (s : e.superTypes) {
  				if (!isFirst) superTypes = superTypes + ', '
  				else superTypes = ''
  				superTypes = superTypes + getTypeName(s, importManager)
  				isFirst = false
  			}
  		}
'''
/** 
  * BO Interface definition for «e.name».
  * <p>«e.documentation»</p> 
  */
public interface «getSimpleName(getInterfaceName(e))» «IF superTypes != null »extends «superTypes» «ENDIF»{
	«FOR f:e.features»
	«compileInterfaceConstant(f, importManager)»
	«ENDFOR»
	«FOR f:e.features»
	«compileInterfaceMethods(f, importManager)»
	«ENDFOR»
}
'''
   	}
   	
   	def String constantName(String camelCase) {
		return camelCase.replaceAll(
			String.format("%s|%s|%s",
				"(?<=[A-Z])(?=[A-Z][a-z])",
				"(?<=[^A-Z])(?=[A-Z])",
				"(?<=[A-Za-z])(?=[^A-Za-z])"
			),
			"_"
		).toUpperCase;
}

    def compileInterfaceConstant(Feature f, ImportManager importManager) 
'''
/** 
  * Attribute name for «f.name». 
  * @see {@link #get«f.name.toFirstUpper»()}
  * @see {@link #set«f.name.toFirstUpper»(«getTypeName(f.type, importManager)»)}
  */
public static final String «constantName(f.name)» = "«f.name»";
'''
  
    def compileDtoAttribute(Feature f, ImportManager importManager) 
'''
/** 
  * «f.documentation»
  * @see {@link #get«f.name.toFirstUpper»()}
  * @see {@link #set«f.name.toFirstUpper»(«getTypeName(f.type, importManager)»)}
  */
private «getTypeName(f.type, importManager)» «f.name»;
'''

    def compileInterfaceMethods(Feature f, ImportManager importManager) 
'''
/** 
  * Returns the «f.name» value.
  * <p>«f.documentation»</p> 
  * @return value of «f.name»
  * @see {@link #set«f.name.toFirstUpper»(«getTypeName(f.type, importManager)»)}
  */
public «getTypeName(f.type, importManager)» get«f.name.toFirstUpper»();

/** 
  * Sets the new value for «f.name».
  * <p>«f.documentation»</p> 
  * @param «f.name» - the new value to set
  * @see {@link #get«f.name.toFirstUpper»()}
  */
public void set«f.name.toFirstUpper»(«getTypeName(f.type, importManager)» «f.name»);
'''
  	
  	/************************** DAO Interface ******************************/

 	def compileDaoInterface(Entity e) ''' 
    «val importManager = new ImportManager(true)» 
    «val body = daoInterfaceBody(e, importManager)»
    package «getPackageName(getDaoInterfaceName(e))»;
    
    «FOR i:importManager.imports»
    import «i»;
    «ENDFOR»
    
    «body»
  	'''

  	def daoInterfaceBody(Entity e, ImportManager importManager) {
  		var String superTypes = null
  		var String parameters = null
  		if (e.superTypes != null) {
  			var isFirst = true
  			for (s : e.superTypes) {
  				var String typeName = null 
				if (s.identifier == 'rs.data.api.bo.ILongBO') {
					parameters = addParameter(parameters, "I extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(ILongDAO, e.newTypeRef('I')), importManager)
				} else if (s.identifier == 'rs.data.api.bo.IGeneralBO') {
					parameters = addParameter(parameters, "K extends "+getTypeName(e.newTypeRef(Serializable), importManager))
					parameters = addParameter(parameters, "I extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(IGeneralDAO), importManager)+"<K,I>"
				} else if (s.identifier == 'rs.data.api.bo.IStringBO') {
					parameters = addParameter(parameters, "I extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(IStringDAO), importManager)+"<I>"
				} else if (entities.containsKey(s.identifier)) {
  						typeName = getTypeName(e.newTypeRef(getDaoInterfaceName(entities.get(s.identifier)), e.newTypeRef(getInterfaceName(e)) ), importManager)
				}
  				if (typeName != null) {
 	  				if (!isFirst) superTypes = superTypes + ', '
  					else superTypes = ''
  					superTypes = superTypes + typeName
	  				isFirst = false
  				}
  			}
  		}
  		if (parameters != null) parameters = '<' + parameters + '>'
  		else parameters = ''
'''
/** 
  * DAO Interface definition for {@link «e.name»}.
  */
public interface «getSimpleName(getDaoInterfaceName(e))»«parameters» «IF superTypes != null »extends «superTypes» «ENDIF»{
}
'''
   	}
  	
 	/********************************** Factory Interface ********************************/
  	
	def compileFactoryInterface(FactoryDefinition f) ''' 
    «val importManager = new ImportManager(true)» 
    «val body = factoryInterfaceBody(f, importManager)»
    package «getPackageName(getFactoryInterfaceName(f))»;
    
    «FOR i:importManager.imports»
    import «i»;
    «ENDFOR»
    
    «body»
  	'''  	
  	
  	def factoryInterfaceBody(FactoryDefinition f, ImportManager importManager) {
'''
/** 
  * Factory Interface definition for «getSimpleName(f.name)».
  */
public interface «getSimpleName(getFactoryInterfaceName(f))» extends «getTypeName(f.newTypeRef(IDaoFactory), importManager)» {
	
	«FOR e:entities.values»
	«IF !e.options.contains('abstract')»
	/**
	  * Returns the DAO for {@link «getTypeName(f.newTypeRef(getInterfaceName(e)), importManager)»}.
	  * @return DAO implementation
	  */
	public «getTypeName(f.newTypeRef(getDaoInterfaceName(e)), importManager)» get«e.name»Dao();
	
	«ENDIF»
	«ENDFOR»
}
'''
	}  	
  	
  	
  	
  	/**********************************Utilities ********************************/
  	
  	def shortName(JvmTypeReference ref, ImportManager importManager) {
    	val result = new StringBuilderBasedAppendable(importManager)
    	ref.serialize(ref.eContainer, result);
    	result.toString
  	}
  	
  	def String getTypeName(JvmTypeReference obj, ImportManager importManager) {
		obj.shortName(importManager)
	}
	
	def dispatch String getPackageName(Entity e) {
		// Walk up the hierarchy and compute the path
		var String rc = null
		var container = e.eContainer
		while (container != null) {
			switch container {
				PackageDeclaration : {
					if (rc != null)	rc = container.name + "." + rc
					else rc = container.name
					container = container.eContainer
				}
				FactoryDefinition : {
					if (rc != null) rc = container.fullyQualifiedName.skipLast(1)+"."+rc
					else rc = container.fullyQualifiedName.skipLast(1).toString
					container = null
				}
			} 
		}
		return rc
	}
	
	def String getFactoryInterfaceName(FactoryDefinition f) {
		return f.fullyQualifiedName.skipLast(1)+".api."+f.fullyQualifiedName.lastSegment+"Factory"
	}
	
	def String getFactoryImplementationName(FactoryDefinition f) {
		return f.fullyQualifiedName.skipLast(1)+".impl."+f.fullyQualifiedName.lastSegment+"FactoryImpl"
	}
	
	def String getInterfaceName(Entity e) {
		return getPackageName(e)+".api.bo."+e.name
	}
	
	def String getImplementationName(Entity e) {
		return getPackageName(e)+".impl.bo."+e.name+"Impl"
	}
	
	def String getDtoName(Entity e) {
		return getPackageName(e)+".impl.dto."+e.name+"Dto"
	}
	
	def String getDaoInterfaceName(Entity e) {
		return getPackageName(e)+".api.dao."+e.name+"Dao"
	}
	
	def String getDaoImplementationName(Entity e) {
		return getPackageName(e)+".impl.dao."+e.name+"DaoImpl"
	}

	def dispatch String getPackageName(String className) {
		var arr = className.split("\\.")
		var n = arr.length-1
		var i = 0
		var String rc = null
		while (i < n) {
			if (rc == null) rc = arr.get(i)
			else rc = rc + '.' + arr.get(i)
			i = i + 1
		}
		return rc
	}
	
	def String getSimpleName(String className) {
		var rc = className.split("\\.")
		return rc.last
	}
	
	def String getFilename(String className) {
		var rc = className.split("\\.").join("/")
		return rc + ".java"
	}
	
	def String addParameter(String oldValue, String toAdd) {
		if (oldValue == null) return toAdd
		return oldValue + ', '+toAdd
	}
}
