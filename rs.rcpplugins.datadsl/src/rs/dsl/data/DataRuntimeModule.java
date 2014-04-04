/*
 * generated by Xtext
 */
package rs.dsl.data;

import org.eclipse.xtext.generator.IGenerator;

import rs.dsl.data.generator.DataGenerator;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class DataRuntimeModule extends rs.dsl.data.AbstractDataRuntimeModule {

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Class<? extends IGenerator> bindIGenerator() {
		return DataGenerator.class;
	}

	
}