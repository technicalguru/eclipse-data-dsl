/*
* generated by Xtext
*/
package rs.dsl.data;

import org.eclipse.xtext.junit4.IInjectorProvider;

import com.google.inject.Injector;

public class DataUiInjectorProvider implements IInjectorProvider {
	
	public Injector getInjector() {
		return rs.dsl.data.ui.internal.DataActivator.getInstance().getInjector("rs.dsl.data.Data");
	}
	
}
