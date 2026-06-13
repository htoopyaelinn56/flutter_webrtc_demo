allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureNdk: Project.() -> Unit = {
        if (extensions.findByName("android") != null) {
            configure<com.android.build.gradle.BaseExtension> {
                ndkVersion = "30.0.14904198"
            }
        }
    }
    if (state.executed) {
        configureNdk()
    } else {
        afterEvaluate {
            configureNdk()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
