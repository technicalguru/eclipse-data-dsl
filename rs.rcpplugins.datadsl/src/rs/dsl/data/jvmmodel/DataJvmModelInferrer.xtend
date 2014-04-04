package rs.dsl.data.jvmmodel

import com.google.inject.Inject
import java.util.List
import org.eclipse.emf.common.util.EList
import org.eclipse.xtext.common.types.JvmField
import org.eclipse.xtext.common.types.JvmOperation
import org.eclipse.xtext.common.types.JvmParameterizedTypeReference
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.common.types.JvmVisibility
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.xbase.jvmmodel.AbstractModelInferrer
import org.eclipse.xtext.xbase.jvmmodel.IJvmDeclaredTypeAcceptor
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import rs.data.api.IDaoFactory
import rs.dsl.data.dataDsl.AbstractElement
import rs.dsl.data.dataDsl.Entity
import rs.dsl.data.dataDsl.FactoryDefinition
import rs.dsl.data.dataDsl.Feature
import rs.dsl.data.dataDsl.PackageDeclaration
import rs.data.api.dao.ILongDAO
import rs.data.api.dao.IGeneralDAO
import rs.data.api.dao.IStringDAO
import java.util.Map
import org.eclipse.xtext.common.types.JvmType
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.common.types.JvmGenericType
import java.util.HashMap
import rs.data.api.bo.ILongBO

/**
 * <p>Infers a JVM model from the source model.</p> 
 *
 * <p>The JVM model should contain all elements that would appear in the Java code 
 * which is generated from the source model. Other models link against the JVM model rather than the source model.</p>     
 */
class DataJvmModelInferrer extends AbstractModelInferrer {

    /**
     * convenience API to build and initialize JVM types and their members.
     */
	@Inject extension JvmTypesBuilder
	@Inject extension IQualifiedNameProvider
	
	def dispatch void infer(FactoryDefinition factory, IJvmDeclaredTypeAcceptor acceptor, boolean isPreIndexingPhase) {
		for (AbstractElement e : factory.elements) {
			build(acceptor, e)
		}
		
		//buildFactoryInterface(acceptor, factory);
		//buildFactoryImplementation(acceptor, factory);
	}
	
	def dispatch void build(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		buildInterface(acceptor, e);
		//buildDaoInterface(acceptor, e);
		//buildTransferObject(acceptor, e);
		//buildImplementation(acceptor, e);
		//buildDaoImplementation(acceptor, e);
	}
	
	def dispatch void build(IJvmDeclaredTypeAcceptor acceptor, PackageDeclaration p) {
		for (AbstractElement e : p.elements) {
			build(acceptor, e)
		}
	}
	
	def void buildInterface(IJvmDeclaredTypeAcceptor acceptor, Entity e){
		var String qualifiedName = getInterfaceName(e) 

		var iface = e.toInterface(qualifiedName) [
//			documentation = "Interface definition for "+e.name+".\n<p>"+e.documentation+"</p>"
//			var EList<JvmParameterizedTypeReference> imps = e.getSuperTypes()
//			for (imp:imps) {
//				superTypes += imp.cloneWithProxies
//			}
//			for (feature : e.features) {
//				members += buildInterfaceConstant(feature)
//			}
//			for (feature : e.features) {
//				members += buildInterfaceGetter(feature)
//				members += buildInterfaceSetter(feature)
//			}
		]
		
		//fsa.generateFile(fileName, iface.flatten);
		acceptor.accept(iface)
    }
    
    /**
	 * Generates interface constant declaration
	 */
	def JvmField buildInterfaceConstant(Feature f){
		var String methodName = f.name.toUpperCase;
		var JvmTypeReference fieldType = f.newTypeRef("java.lang.String")
		return f.toField(methodName, fieldType) [
			documentation = "Property definition for {@link #get"+f.name.toFirstUpper+"()} and {@link #set"+f.name.toFirstUpper+"("+f.type.identifier+")}."
			setFinal(true)
			setStatic(true);
			setInitializer[append('''"«f.name»";''')]
			visibility = JvmVisibility.PUBLIC
		]
	}
    
    /**
	 * Generates interface getter declaration
	 */
	def JvmOperation buildInterfaceGetter(Feature f){
		var String methodName = "get"+f.name.toFirstUpper;
		var JvmTypeReference getterType = f.type
		return f.toMethod(methodName, getterType) [
			documentation = "Returns the <code>"+f.name+"</code> value.\n<p>"+f.documentation+"</p>\n@return value of <code>"+f.name+"</code>\n@see #set"+f.name.toFirstUpper+"("+f.type.identifier+")."
			setAbstract(true)
			visibility = JvmVisibility.PUBLIC
		]
	}
    
    /**
	 * Generates interface getter declaration
	 */
	def JvmOperation buildInterfaceSetter(Feature f){
		var String methodName = "set"+f.name.toFirstUpper;
		return f.toMethod(methodName, f.newTypeRef(Void.TYPE)) [
			documentation = "Sets the <code>"+f.name+"</code> value.\n<p>"+f.documentation+"</p>\n@param "+f.name+" - new value to set\n@see #get"+f.name.toFirstUpper+"()."
			parameters += f.type.toParameter(f.name, f.type)
			setAbstract(true)
			visibility = JvmVisibility.PUBLIC
		]
	}
	
	def void buildDaoInterface(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		var String qualifiedName = getDaoInterfaceName(e)
		
		var iface = e.toInterface(qualifiedName+"<B extends ILongBO>") [
			for (JvmParameterizedTypeReference superType : e.getSuperTypes) {
				documentation = "DAO interface for {@link "+e.fullyQualifiedName+"}.\n"
				if (superType.identifier == 'rs.data.api.bo.ILongBO') {
					superTypes += e.newTypeRef(ILongDAO)
				} else if (superType.identifier == 'rs.data.api.bo.IGeneralBO') {
					superTypes += e.newTypeRef(IGeneralDAO)
				} else if (superType.identifier == 'rs.data.api.bo.IStringBO') {
					superTypes += e.newTypeRef(IStringDAO)
				} else {
					//var dao = entityMap.get("dao:"+superType.fullyQualifiedName)
					//if (dao != null) superTypes += e.newTypeRef(getDaoInterfaceName(e))
				}
			}
			// Decide on supertype
			//superTypes += f.newTypeRef(IDaoFactory)
		]
		acceptor.accept(iface)
		
	}
	
	def void buildImplementation(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		var String qualifiedName = getImplementationName(e) 
	}
	
	def void buildDaoImplementation(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		var String qualifiedName = getDaoImplementationName(e) 
	}
	
	def void buildTransferObject(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		var String qualifiedName = getDtoName(e) 
	}
	
	def void buildFactoryInterface(IJvmDeclaredTypeAcceptor acceptor, FactoryDefinition f) {
		var String qualifiedName = getFactoryInterfaceName(f)
		var iface = f.toInterface(qualifiedName) [
			documentation = "Factory interface for "+f.name+".\n<p>"+f.documentation+"</p>"
			superTypes += f.newTypeRef(IDaoFactory)
			
			for (AbstractElement e : f.elements) {
				switch e {
					Entity : if (!e.options.contains('abstract')) members += buildFactoryInterfaceMethod(acceptor, e)
					PackageDeclaration : members += buildFactoryInterfaceMethods(acceptor, e)
				}
				
			}
		]
		acceptor.accept(iface)
	}
	
	def JvmOperation buildFactoryInterfaceMethod(IJvmDeclaredTypeAcceptor acceptor, Entity e) {
		var String methodName = "get"+e.name.toFirstUpper+"Dao";
		var JvmTypeReference getterType = e.newTypeRef(getDaoInterfaceName(e));
		return e.toMethod(methodName, getterType) [
			documentation = "Returns the DAO for {@link "+e.name+"}.\n"
			setAbstract(true)
			visibility = JvmVisibility.PUBLIC
		]
	}
	
	def List<JvmOperation> buildFactoryInterfaceMethods(IJvmDeclaredTypeAcceptor acceptor, PackageDeclaration f) {
		var List<JvmOperation> rc
		for (AbstractElement e : f.elements) {
			switch e {
				Entity : if (!e.options.contains('abstract')) rc += buildFactoryInterfaceMethod(acceptor, e)
				PackageDeclaration : rc += buildFactoryInterfaceMethods(acceptor, e)
			}
				
		}
		return rc
	}
	
	def void buildFactoryImplementation(IJvmDeclaredTypeAcceptor acceptor, FactoryDefinition f) {
		var String qualifiedName = getFactoryImplementationName(f)
	}
	
	def String getPackageName(Entity e) {
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
}

