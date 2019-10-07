/**************************************************************************
Copyright 2019 Vietnamese-German-University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
***************************************************************************/
package org.vgu.ocl2psql.test.ocl;

import java.io.File;

import org.vgu.ocl2psql.main.OCL2PSQL;
import org.vgu.ocl2psql.ocl.exception.OclParseException;


public class TesterOCL2SQLParser {

    /**
     * @param args
     * @throws Exception
     */
    public static void main(String[] args)
            throws Exception {

        OCL2PSQL ocl2psql = new OCL2PSQL();
        File contextModel = new File("./src/main/resources/context-model/CarPerson_context.json");
        ocl2psql.setPlainUMLContextFromFile(contextModel.getAbsolutePath());
        ocl2psql.setDescriptionMode(true);
        
        test(ocl2psql, "self");
        test(ocl2psql, "self = caller");
        test(ocl2psql, "self.Person:name");
        test(ocl2psql, "self.Person:name = 'Hoang'");
        test(ocl2psql, "self.Person:ownedCars");
        test(ocl2psql, "self.Person:ownedCars->size()");
        test(ocl2psql, "self.Person:ownedCars->exists(c|c.Car:color = 'black')");
        test(ocl2psql, "Car::allInstances()->exists(c|c.Car:owners->exists(p|p = self))");
        test(ocl2psql, "Car::allInstances()->exists(c|c.Car:owners->exists(p|p.Person:ownedCars->size() < self.Person:ownedCars->size()))");
    
        test(ocl2psql, "Car::allInstances()");
        test(ocl2psql, "Automobile::allInstances()");
        test(ocl2psql, "Vehicle::allInstances()");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au)");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.Vehicle:category)");
//            test(ocl2psql, "Automobile::allInstances()->collect(au|au.Car:color)");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsTypeOf(Automobile))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsTypeOf(Car))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsTypeOf(Person))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsTypeOf(Vehicle))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsKindOf(Automobile))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsKindOf(Car))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsKindOf(Person))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclIsKindOf(Vehicle))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Automobile))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Car))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Bus))");
//            test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Person))");
//            test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Vehicle))");
        test(ocl2psql, "Automobile::allInstances()->collect(au|au.oclAsType(Car).Car:color)");
    }

    private static void test(OCL2PSQL ocl2psql, String oclExp) throws OclParseException {
//        System.out.println(oclExp);
        String finalStatementWithDescription = ocl2psql.mapToString(oclExp);
        System.out.println(finalStatementWithDescription);
        System.out.println();
    }
}
