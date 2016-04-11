//Generated JAVA file 
import weka.core.Instance; 
import weka.core.Instances; 
import weka.core.converters.ArffLoader; 
import java.io.File;

 import weka.core.converters.ConverterUtils.DataSource; 
import weka.core.Utils; 
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import java.util.Random;

// selected algorithms to train:
import weka.classifiers.bayes.NaiveBayes; 


// console example:
// java Generated /Users/mv/Documents/DIPLOMA/MLStudio/MLStudio/contact-lenses.arff -x 10 -s 1 -W0 "weka.classifiers.bayes.NaiveBayes" 

public class Generated {
public static void main(String[] args) throws Exception {
// load data
 Instances data = DataSource.read(args[0]);
// other options
int seed  = Integer.parseInt(Utils.getOption("s", args));
int folds = Integer.parseInt(Utils.getOption("x", args));
{
// train Naive Bayes
////////////////////////////////////////////////////////////
// setting CLASS attribute (att to use in classification) //
////////////////////////////////////////////////////////////

String clsIndex = "last";
if (clsIndex.length() == 0)
clsIndex = "last";
if (clsIndex.equals("first"))
data.setClassIndex(0);
else if (clsIndex.equals("last"))
data.setClassIndex(data.numAttributes() - 1);
else
data.setClassIndex(Integer.parseInt(clsIndex) - 1);

////////////////
// classifier //
////////////////
String[] tmpOptions;
String classname;
tmpOptions     = Utils.splitOptions(Utils.getOption("W0", args));
classname      = tmpOptions[0];
tmpOptions[0]  = "";
Classifier cls = (Classifier) Utils.forName(Classifier.class, classname, tmpOptions);

// output evaluation
System.out.println();
System.out.println("=== Setup ===");
System.out.println("Classifier: " + cls.getClass().getName() + " " + Utils.joinOptions(cls.getOptions()));
System.out.println("Dataset: " + data.relationName());
System.out.println();

// model output
cls.buildClassifier(data);
 System.out.println(cls);

// randomize data
Random rand = new Random(seed);
Instances randData = new Instances(data);
randData.randomize(rand);
if (randData.classAttribute().isNominal())
randData.stratify(folds);

// perform cross-validation
Evaluation eval = new Evaluation(randData);
for (int n = 0; n < folds; n++) {
Instances train = randData.trainCV(folds, n);
Instances test = randData.testCV(folds, n);
// the above code is used by the StratifiedRemoveFolds filter, the

// code below by the Explorer/Experimenter:
// Instances train = randData.trainCV(folds, n, rand);

// build and evaluate classifier

Classifier clsCopy = Classifier.makeCopy(cls);
clsCopy.buildClassifier(train);
eval.evaluateModel(clsCopy, test);
}

// output evaluation
System.out.println();
System.out.println("=== Cross-validation Setup ===");
 System.out.println("Folds: " + folds);
System.out.println("Seed: " + seed);
System.out.println();
System.out.println(eval.toSummaryString("=== " + folds + "-fold Cross-validation ===", false));
}
}

}