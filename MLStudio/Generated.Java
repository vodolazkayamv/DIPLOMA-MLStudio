//Generated JAVA file 
import weka.core.Instance; 
import weka.core.Instances; 
import weka.core.converters.ArffLoader; 
import java.io.File;

import weka.classifiers.bayes.NaiveBayes; 
import weka.classifiers.meta.AdaBoostM1; 
import weka.classifiers.trees.J48; 


public class Generated {
public static void main(String[] args) throws Exception {
// load data
 ArffLoader loader = new ArffLoader(); 
loader.setFile(new File(args[0])); 
Instances structure = loader.getStructure(); 
structure.setClassIndex(structure.numAttributes() - 1);

{
// train Naive Bayes
NaiveBayes nb = new NaiveBayes(); 
nb.buildClassifier(structure);
// output generated model 
System.out.println(nb);
}


{
// train J48
J48 nb = new J48();
String[] options = weka.core.Utils.splitOptions("-C 0.25 -M 2");
nb.setOptions(options);
nb.buildClassifier(structure);
// output generated model 
System.out.println(nb);
}
}

}