/**
 */
package rs.dsl.data.dataDsl.impl;

import java.util.Collection;

import org.eclipse.emf.common.notify.Notification;
import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

import org.eclipse.emf.ecore.util.EDataTypeEList;
import org.eclipse.emf.ecore.util.EObjectContainmentEList;
import org.eclipse.emf.ecore.util.InternalEList;

import rs.dsl.data.dataDsl.AbstractElement;
import rs.dsl.data.dataDsl.DataDslPackage;
import rs.dsl.data.dataDsl.FactoryDefinition;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Factory Definition</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link rs.dsl.data.dataDsl.impl.FactoryDefinitionImpl#getOptions <em>Options</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.impl.FactoryDefinitionImpl#getName <em>Name</em>}</li>
 *   <li>{@link rs.dsl.data.dataDsl.impl.FactoryDefinitionImpl#getElements <em>Elements</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class FactoryDefinitionImpl extends MinimalEObjectImpl.Container implements FactoryDefinition
{
  /**
   * The cached value of the '{@link #getOptions() <em>Options</em>}' attribute list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getOptions()
   * @generated
   * @ordered
   */
  protected EList<String> options;

  /**
   * The default value of the '{@link #getName() <em>Name</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getName()
   * @generated
   * @ordered
   */
  protected static final String NAME_EDEFAULT = null;

  /**
   * The cached value of the '{@link #getName() <em>Name</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getName()
   * @generated
   * @ordered
   */
  protected String name = NAME_EDEFAULT;

  /**
   * The cached value of the '{@link #getElements() <em>Elements</em>}' containment reference list.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getElements()
   * @generated
   * @ordered
   */
  protected EList<AbstractElement> elements;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected FactoryDefinitionImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  protected EClass eStaticClass()
  {
    return DataDslPackage.Literals.FACTORY_DEFINITION;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<String> getOptions()
  {
    if (options == null)
    {
      options = new EDataTypeEList<String>(String.class, this, DataDslPackage.FACTORY_DEFINITION__OPTIONS);
    }
    return options;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public String getName()
  {
    return name;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public void setName(String newName)
  {
    String oldName = name;
    name = newName;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, DataDslPackage.FACTORY_DEFINITION__NAME, oldName, name));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EList<AbstractElement> getElements()
  {
    if (elements == null)
    {
      elements = new EObjectContainmentEList<AbstractElement>(AbstractElement.class, this, DataDslPackage.FACTORY_DEFINITION__ELEMENTS);
    }
    return elements;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs)
  {
    switch (featureID)
    {
      case DataDslPackage.FACTORY_DEFINITION__ELEMENTS:
        return ((InternalEList<?>)getElements()).basicRemove(otherEnd, msgs);
    }
    return super.eInverseRemove(otherEnd, featureID, msgs);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object eGet(int featureID, boolean resolve, boolean coreType)
  {
    switch (featureID)
    {
      case DataDslPackage.FACTORY_DEFINITION__OPTIONS:
        return getOptions();
      case DataDslPackage.FACTORY_DEFINITION__NAME:
        return getName();
      case DataDslPackage.FACTORY_DEFINITION__ELEMENTS:
        return getElements();
    }
    return super.eGet(featureID, resolve, coreType);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @SuppressWarnings("unchecked")
  @Override
  public void eSet(int featureID, Object newValue)
  {
    switch (featureID)
    {
      case DataDslPackage.FACTORY_DEFINITION__OPTIONS:
        getOptions().clear();
        getOptions().addAll((Collection<? extends String>)newValue);
        return;
      case DataDslPackage.FACTORY_DEFINITION__NAME:
        setName((String)newValue);
        return;
      case DataDslPackage.FACTORY_DEFINITION__ELEMENTS:
        getElements().clear();
        getElements().addAll((Collection<? extends AbstractElement>)newValue);
        return;
    }
    super.eSet(featureID, newValue);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eUnset(int featureID)
  {
    switch (featureID)
    {
      case DataDslPackage.FACTORY_DEFINITION__OPTIONS:
        getOptions().clear();
        return;
      case DataDslPackage.FACTORY_DEFINITION__NAME:
        setName(NAME_EDEFAULT);
        return;
      case DataDslPackage.FACTORY_DEFINITION__ELEMENTS:
        getElements().clear();
        return;
    }
    super.eUnset(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public boolean eIsSet(int featureID)
  {
    switch (featureID)
    {
      case DataDslPackage.FACTORY_DEFINITION__OPTIONS:
        return options != null && !options.isEmpty();
      case DataDslPackage.FACTORY_DEFINITION__NAME:
        return NAME_EDEFAULT == null ? name != null : !NAME_EDEFAULT.equals(name);
      case DataDslPackage.FACTORY_DEFINITION__ELEMENTS:
        return elements != null && !elements.isEmpty();
    }
    return super.eIsSet(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public String toString()
  {
    if (eIsProxy()) return super.toString();

    StringBuffer result = new StringBuffer(super.toString());
    result.append(" (options: ");
    result.append(options);
    result.append(", name: ");
    result.append(name);
    result.append(')');
    return result.toString();
  }

} //FactoryDefinitionImpl
