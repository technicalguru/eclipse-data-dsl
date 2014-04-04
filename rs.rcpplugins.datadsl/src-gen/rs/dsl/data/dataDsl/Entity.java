/**
 */
package rs.dsl.data.dataDsl;

import org.eclipse.emf.common.util.EList;

import org.eclipse.xtext.common.types.JvmParameterizedTypeReference;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Entity</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link rs.dsl.data.dataDsl.Entity#getOptions <em>Options</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.Entity#getSuperTypes <em>Super Types</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.Entity#getFeatures <em>Features</em>}</li>
 * </ul>
 * </p>
 *
 * @see rs.dsl.data.dataDsl.DataDslPackage#getEntity()
 * @model
 * @generated
 */
public interface Entity extends AbstractElement
{
  /**
   * Returns the value of the '<em><b>Options</b></em>' attribute list.
   * The list contents are of type {@link java.lang.String}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Options</em>' attribute list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Options</em>' attribute list.
   * @see rs.dsl.data.dataDsl.DataDslPackage#getEntity_Options()
   * @model unique="false"
   * @generated
   */
  EList<String> getOptions();

  /**
   * Returns the value of the '<em><b>Super Types</b></em>' containment reference list.
   * The list contents are of type {@link org.eclipse.xtext.common.types.JvmParameterizedTypeReference}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Super Types</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Super Types</em>' containment reference list.
   * @see rs.dsl.data.dataDsl.DataDslPackage#getEntity_SuperTypes()
   * @model containment="true"
   * @generated
   */
  EList<JvmParameterizedTypeReference> getSuperTypes();

  /**
   * Returns the value of the '<em><b>Features</b></em>' containment reference list.
   * The list contents are of type {@link rs.dsl.data.dataDsl.Feature}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Features</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Features</em>' containment reference list.
   * @see rs.dsl.data.dataDsl.DataDslPackage#getEntity_Features()
   * @model containment="true"
   * @generated
   */
  EList<Feature> getFeatures();

} // Entity
