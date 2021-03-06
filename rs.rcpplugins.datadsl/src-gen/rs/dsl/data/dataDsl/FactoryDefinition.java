/**
 */
package rs.dsl.data.dataDsl;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Factory Definition</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link rs.dsl.data.dataDsl.FactoryDefinition#getOptions <em>Options</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.FactoryDefinition#getName <em>Name</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.FactoryDefinition#getElements <em>Elements</em>}</li>
 * </ul>
 * </p>
 *
 * @see rs.dsl.data.dataDsl.DataDslPackage#getFactoryDefinition()
 * @model
 * @generated
 */
public interface FactoryDefinition extends EObject
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
   * @see rs.dsl.data.dataDsl.DataDslPackage#getFactoryDefinition_Options()
   * @model unique="false"
   * @generated
   */
  EList<String> getOptions();

  /**
   * Returns the value of the '<em><b>Name</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Name</em>' attribute isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Name</em>' attribute.
   * @see #setName(String)
   * @see rs.dsl.data.dataDsl.DataDslPackage#getFactoryDefinition_Name()
   * @model
   * @generated
   */
  String getName();

  /**
   * Sets the value of the '{@link rs.dsl.data.dataDsl.FactoryDefinition#getName <em>Name</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Name</em>' attribute.
   * @see #getName()
   * @generated
   */
  void setName(String value);

  /**
   * Returns the value of the '<em><b>Elements</b></em>' containment reference list.
   * The list contents are of type {@link rs.dsl.data.dataDsl.AbstractElement}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Elements</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Elements</em>' containment reference list.
   * @see rs.dsl.data.dataDsl.DataDslPackage#getFactoryDefinition_Elements()
   * @model containment="true"
   * @generated
   */
  EList<AbstractElement> getElements();

} // FactoryDefinition
