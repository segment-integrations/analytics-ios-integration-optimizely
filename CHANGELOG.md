Change Log
==========

Version 1.2.0 *(4th July, 2018)*
-------------------------------------------
*(Supports analytics-ios 3.0.3+ and Optimizely 1.2.2+)*

* [Enhancement](https://github.com/segment-integrations/analytics-ios-integration-optimizely/commit/92e4294cad798fff38b78f92419c6186eec1b263): Fix issues related to `use_frameworks!` and transitive static libraries

##### Transitioning from static library workarounds

If you are using `use_frameworks!` and workarounds you may need to follow extra-steps :
1. Make sure you are using CocoaPods 1.4+
   ```bash
   $ pod --version
   1.5.3
   ```
2. The `StaticLibWorkaround` subspec has been removed, use the default subspec instead
3. Remove references to the pod source files from your Xcode target if any
4. Remove any remaining workarounds (e.g. `post_install` hooks)
5. *(optional)*  if you don't directly depend on Optimizely you don't need to explicit depend on it anymore

###### Example

- Before
    ```ruby
    use_frameworks!

    pod 'Analytics'

    pod 'Segment-Optimizely/StaticLibWorkaround'
    pod 'Optimizely-iOS-SDK'

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                if config.build_settings['PRODUCT_NAME'] == 'Segment_Optimizely'
                    # ...
                end
            end
        end
    end
    ```

- After
    ```ruby
    use_frameworks!

    pod 'Analytics'
    pod 'Segment-Optimizely'
    ```


Version 1.1.2 *(14th June, 2017)*
-------------------------------------------
Relaxes Optimizely dependency 

Version 1.1.1 *(24th October, 2016)*
-------------------------------------------
Relaxes Analytics dependency 

Version 1.1.0 *(5th May, 2016)*
-------------------------------------------
Update Optimizely SDK to 1.4.2.

Version 1.0.1 *(28th March, 2016)*
-------------------------------------------
Changed the property experimentName is set to from the NSNotification object.

Version 1.0.0 *(22nd December, 2015)*
-------------------------------------------
*(Supports analytics-ios 3.0.3+ and Optimizely 1.2.2+)*

Initial stable release.
