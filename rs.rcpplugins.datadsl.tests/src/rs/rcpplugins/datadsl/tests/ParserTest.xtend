/**
 * 
 */
package rs.rcpplugins.datadsl.tests

/**
 * Tests the interface generation.
 * @author ralph
 *
 */

import static org.junit.Assert.*
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith
import rs.dsl.data.DataInjectorProvider
import rs.dsl.data.dataDsl.Domainmodel
import rs.dsl.data.dataDsl.Entity
import rs.dsl.data.dataDsl.FactoryDefinition

@InjectWith(DataInjectorProvider)
@RunWith(XtextRunner)
class ParserTest {
     @Inject ParseHelper<Domainmodel> parser

	@Test 
	def void parseDomainmodel() {
  		val model = parser.parse(
    		"factory my.Model {
				entity MyEntity {
      				parent: MyEntity;
				}
    		}")
  		val factory = model.factories.head as FactoryDefinition
  		val entity = factory.elements.head as Entity
  		assertSame(entity, entity.features.head.type)
	} 
}