/**
 * 
 */
package rs.dsl.data.generator;

import com.google.inject.Inject
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.xbase.compiler.ImportManager
import org.eclipse.xtext.xbase.compiler.StringBuilderBasedAppendable
import org.eclipse.xtext.xbase.compiler.TypeReferenceSerializer
import rs.dsl.data.dataDsl.Entity
import rs.dsl.data.dataDsl.FactoryDefinition
import rs.dsl.data.dataDsl.PackageDeclaration
import rs.dsl.data.dataDsl.Feature

/**
 * Abstract implementations.
 * @author ralph
 *
 */
abstract class AbstractDataGenerator  implements IGenerator {

	@Inject extension IQualifiedNameProvider
	@Inject extension TypeReferenceSerializer

  	def shortName(JvmTypeReference ref, ImportManager importManager) {
    	val result = new StringBuilderBasedAppendable(importManager)
    	ref.serialize(ref.eContainer, result);
    	result.toString
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
					if (rc != null)	rc = container.getName()+"."+rc
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
	
	def String getGetterName(Feature f) {
		if (f.type.qualifiedName == 'boolean') {
			return 'is'+f.name.toFirstUpper
		}
		return 'get'+f.name.toFirstUpper
	}
	
	def String getSetterName(Feature f) {
		return 'set'+f.name.toFirstUpper
	}

}
