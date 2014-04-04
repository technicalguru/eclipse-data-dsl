/**
 */
package rs.dsl.data.dataDsl;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

import org.eclipse.xtext.xtype.XImportSection;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Domainmodel</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link rs.dsl.data.dataDsl.Domainmodel#getImportSection <em>Import Section</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.Domainmodel#getFactories <em>Factories</em>}</li>
 * </ul>
 * </p>
 *
 * @see rs.dsl.data.dataDsl.DataDslPackage#getDomainmodel()
 * @model
 * @generated
 */
public interface Domainmodel extends EObject
{
  /**
   * Returns the value of the '<em><b>Import Section</b></em>' containment reference.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Import Section</em>' containment reference isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Import Section</em>' containment reference.
   * @see #setImportSection(XImportSection)
   * @see rs.dsl.data.dataDsl.DataDslPackage#getDomainmodel_ImportSection()
   * @model containment="true"
   * @generated
   */
  XImportSection getImportSection();

  /**
   * Sets the value of the '{@link rs.dsl.data.dataDsl.Domainmodel#getImportSection <em>Import Section</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Import Section</em>' containment reference.
   * @see #getImportSection()
   * @generated
   */
  void setImportSection(XImportSection value);

  /**
   * Returns the value of the '<em><b>Factories</b></em>' containment reference list.
   * The list contents are of type {@link rs.dsl.data.dataDsl.FactoryDefinition}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Factories</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Factories</em>' containment reference list.
   * @see rs.dsl.data.dataDsl.DataDslPackage#getDomainmodel_Factories()
   * @model containment="true"
   * @generated
   */
  EList<FactoryDefinition> getFactories();

} // Domainmodel
