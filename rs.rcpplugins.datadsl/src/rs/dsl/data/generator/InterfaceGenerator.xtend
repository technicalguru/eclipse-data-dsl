/*
 * generated by Xtext
 */
package rs.dsl.data.generator

import com.google.inject.Inject
import java.io.Serializable
import java.util.HashMap
import java.util.Map
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.xbase.compiler.ImportManager
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import rs.data.api.IDaoFactory
import rs.data.api.dao.IGeneralDAO
import rs.data.api.dao.ILongDAO
import rs.data.api.dao.IStringDAO
import rs.dsl.data.dataDsl.Entity
import rs.dsl.data.dataDsl.FactoryDefinition
import rs.dsl.data.dataDsl.Feature
import javax.annotation.Generated
import rs.data.impl.AbstractDaoFactory

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class InterfaceGenerator extends AbstractDataGenerator {
	
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
			fsa.generateFile(getFilename(getFactoryImplementationName(f)), f.compileFactoryImplementation)
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
  * BO interface for «e.name».
  * <p>«e.documentation»</p> 
  */
@«getTypeName(e.newTypeRef(Generated), importManager)»("«getClass().simpleName»")
public interface «getSimpleName(getInterfaceName(e))» «IF superTypes != null »extends «superTypes» «ENDIF»{
	«FOR f:e.features»
	«compileInterfaceConstant(f, importManager)»
	«ENDFOR»
	«FOR f:e.features»
	«compileInterfaceMethods(f, importManager)»
	«ENDFOR»
	
	// PROTECTED REGION ID(«getProtectedRegionName(e, 'interface')») ENABLED START
	// Add your own interface definitions here
	// PROTECTED REGION END
}
'''
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
  
    def compileInterfaceMethods(Feature f, ImportManager importManager) 
'''
/** 
  * Returns the «f.name» value.
  * <p>«f.documentation»</p> 
  * @return value of «f.name»
  * @see {@link #«getSetterName(f)»(«getTypeName(f.type, importManager)»)}
  */
public «getTypeName(f.type, importManager)» «getGetterName(f)»();

/** 
  * Sets the new value for «f.name».
  * <p>«f.documentation»</p> 
  * @param «f.name» - the new value to set
  * @see {@link #«getGetterName(f)»()}
  */
public void «getSetterName(f)»(«getTypeName(f.type, importManager)» «getSetterArgumentName(f.name)»);
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
  		var boolean k = false
  		var boolean c = false
  		if (e.superTypes != null) {
  			var isFirst = true
  			for (s : e.superTypes) {
  				var String typeName = null 
				if (s.identifier == 'rs.data.api.bo.ILongBO') {
					parameters = addParameter(parameters, "C extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(ILongDAO, e.newTypeRef('C')), importManager)
					c = true
				} else if (s.identifier == 'rs.data.api.bo.IGeneralBO') {
					parameters = addParameter(parameters, "K extends "+getTypeName(e.newTypeRef(Serializable), importManager))
					parameters = addParameter(parameters, "C extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(IGeneralDAO), importManager)+"<K,C>"
					k = true
					c = true
				} else if (s.identifier == 'rs.data.api.bo.IStringBO') {
					parameters = addParameter(parameters, "C extends "+getTypeName(e.newTypeRef(getInterfaceName(e)), importManager))
					typeName = getTypeName(e.newTypeRef(IStringDAO), importManager)+"<C>"
					c = true
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
  * DAO interface for {@link «e.name»}.
«IF k»  * @param <K> entity key class
«ENDIF»«IF c»  * @param <C> entity interface class
«ENDIF»  */
@«getTypeName(e.newTypeRef(Generated), importManager)»("«getClass().simpleName»")
public interface «getSimpleName(getDaoInterfaceName(e))»«parameters» «IF superTypes != null »extends «superTypes» «ENDIF»{

	// PROTECTED REGION ID(«getProtectedRegionName(e, 'dao.interface')») ENABLED START
	// Add your own interface definitions here
	// PROTECTED REGION END

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
  * Factory interface for «getSimpleName(f.name)».
  */
@«getTypeName(f.newTypeRef(Generated), importManager)»("«getClass().simpleName»")
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

	// PROTECTED REGION ID(«getProtectedRegionName(f, 'factory.interface')») ENABLED START
	// Add your own interface definitions here
	// PROTECTED REGION END
}
'''
	}  	
  	
	/********************************** Factory Implementation ********************************/
  	
	def compileFactoryImplementation(FactoryDefinition f) ''' 
    «val importManager = new ImportManager(true)» 
    «val body = factoryImplementationBody(f, importManager)»
    package «getPackageName(getFactoryImplementationName(f))»;
    
    «FOR i:importManager.imports»
    import «i»;
    «ENDFOR»
    
    «body»
  	'''  	
  	
  	def factoryImplementationBody(FactoryDefinition f, ImportManager importManager) {
'''
/** 
  * Factory implementation for «getSimpleName(f.name)».
  */
@«getTypeName(f.newTypeRef(Generated), importManager)»("«getClass().simpleName»")
public class «getSimpleName(getFactoryImplementationName(f))» extends «getTypeName(f.newTypeRef(AbstractDaoFactory), importManager)» implements «getTypeName(f.newTypeRef(getFactoryInterfaceName(f)), importManager)» {
	
	«FOR e:entities.values»
	«IF !e.options.contains('abstract')»
	/**
	  * {@inheritDoc}
	  */
	@Override
	public «getTypeName(f.newTypeRef(getDaoInterfaceName(e)), importManager)» get«e.name»Dao() {
		// PROTECTED REGION ID(«getProtectedRegionName(e, 'factory.getdao.impl')») ENABLED START
		// Add your own code here
		return getDao(«getTypeName(f.newTypeRef(getDaoInterfaceName(e)), importManager)».class);
		// PROTECTED REGION END
	}
	
	«ENDIF»
	«ENDFOR»

	// PROTECTED REGION ID(«getProtectedRegionName(f, 'factory.impl')») ENABLED START
	// Add your own implementations here
	// PROTECTED REGION END

}
'''
	}  	
  	
  	
  	
}
