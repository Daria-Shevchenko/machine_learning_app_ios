// macOS Playground

import Cocoa
import CoreML
import CreateML

let outputFileName = "/Users/azamsharp/Desktop/MartianPricesModel.mlmodel"

guard let csvFile = Bundle.main.url(forResource: "Mars", withExtension: "csv"),
    let dataTable = try? MLDataTable(contentsOf: csvFile) else {
        fatalError("Unable to load data!")
}

let regressorColumns = ["price", "solarPanels","greenhouses","size"]
let regressorTable = dataTable[regressorColumns]

let (regressorTestingTable, regressorTrainingTable) = regressorTable.randomSplit(by: 0.2)

let regressor = try MLLinearRegressor(trainingData: regressorTrainingTable, targetColumn: "price")

let metadata = MLModelMetadata(author: "Shevchenko Daria", shortDescription: "Prediction of Martian Houses", version: "1.0")

try regressor.write(toFile: outputFileName, metadata: metadata)
