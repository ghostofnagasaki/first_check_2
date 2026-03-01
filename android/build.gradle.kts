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
    val applyNamespace: () -> Unit = {
        if (plugins.hasPlugin("com.android.library") || plugins.hasPlugin("com.android.application")) {
            val android = extensions.findByName("android")
            if (android != null && android is com.android.build.gradle.BaseExtension) {
                if (android.namespace == null) {
                    val fallbackNamespace = if (project.group.toString().isNotEmpty()) {
                        project.group.toString()
                    } else {
                        "com.example.${project.name.replace("-", "_").replace(":", ".")}"
                    }
                    android.namespace = fallbackNamespace
                }
            }
        }
    }
    if (project.state.executed) {
        applyNamespace()
    } else {
        project.afterEvaluate { applyNamespace() }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
