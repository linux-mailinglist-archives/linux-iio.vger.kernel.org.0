Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0992D4CA6C0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Mar 2022 14:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiCBN4o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 08:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiCBN4i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 08:56:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BC41333
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 05:55:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8547EB81FE8
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B065C004E1;
        Wed,  2 Mar 2022 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646229347;
        bh=UW7GuXw9LjeDwc8oTNzhxy51Mo0/CLhkN6y7OiNpjA8=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=qzvYCQlTUgqtR9qAAzGzOLmh5i7ZkigFMRokCjUyzj1eofbOBceODyPhyO6swIuTi
         syqv+7MpRt40wK9FD1AgYe7U6/efmGwKnsy7DLztiEm6B79ztsWVMpB4uzhtTFwj5P
         uMlZBej1FOYgr/E1/ryqyBSkrQRxSxpRWcw+m+lMIhOnWTd+rihfEdD/vVtcmcdOeD
         a8M3n57B53CaHW+1GnZ8msMyzKK23ZQZpXIaQySb6c6n1MhdABjzn850kMi1gW5tUq
         XlOQJWrLMgUNmZiBgHewc9YGhukOjgRdzNuS6EHHSnCTax+wel5ljpKvpqZVPsHzc7
         flLnYm7P0FJiA==
Date:   Wed, 2 Mar 2022 14:02:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO new device support, features, fixes and cleanups for
 5.18
Message-ID: <20220302140256.279c7c51@jic23-huawei>
In-Reply-To: <20220302135101.353b9470@jic23-huawei>
References: <20220302135101.353b9470@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Mar 2022 13:51:01 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac=
07:
>=20
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-5.18a
>=20
> for you to fetch changes up to 0bf126163c3e7e6d722622073046aed567a5551e:
>=20
>   iio: adc: xilinx-ams: Fix single channel switching sequence (2022-03-02=
 13:39:08 +0000)
>=20
> ----------------------------------------------------------------

Hi Greg,

A few quick comments on this pull request:

I had 7 patches in my fixes-togreg branch but as we are so late in the
cycle I have cherrypicked them into to the togreg branch and added
Stable markings where not previously present.  These fixes and most of the
rest of the pull have been in linux-next for a while. The ltc2688 driver
was the other late addition and that looks to be fine in linux-next
today and had some build coverage in another branch for a few days.

I'm seeing 2 merge conflicts with char-misc-next
1) Trivial .mailmap context one.
2) A more complex issue with namespace change crossing with a fix for=20
 drivers/iio/accel/fxls8962af-core.c

The resolution I would recommend is to update the naming
of the spi_regmap in the relevant EXPORT_SYMBOL_NS_GPL()
and to update the i2c_regmap export to use
EXPORT_SYMBOL_NS_GP() instead of non NS version with the same
namespace as for the spi regmap.
This is the same resolution that Mark used when this occured
in linux-next.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
drivers/iio/accel/fxls8962af-core.c?id=3D3cb2e4090000aa0b06be7766ca6e82e6f2=
843818

Thanks for your help. As ever much appreciated!

Jonathan

> First set of new device support, fixes, cleanups and features for IIO in =
5.18
>=20
> This cycle we had quite a few series that applied similar changes
> to lots of drivers. To keep this description manageable I have
> called those out in their own section rather than per driver.
>=20
> Particularly pleased to see the long running AFE precision series
> going in this cycle.
>=20
> Series includes some late breaking fixes.
>=20
> New device support
> * adi,ada4250 amplifier
>   - New driver and dt bindings for this programmable gain amplifier.
> * adi,admv1014 microwave down-converter
>   - New driver, dt bindings and some device specific ABI that
>     may be generalized as more drivers for devices similar to this
>     are added.
> * adi,admv4420 K Band down-converter.
>   - New driver and dt bindings.
> * adi,adxl367 accelerometer driver.
>   - New driver, dt-bindings + some new IIO ABI definitions to support
>     reference magnitude events where an estimate of the acceleration
>     due to gravity has been removed.
>   - A few fixes as follow up patches.
> * adi,ltc2688 DAC with toggle and dither modes.
>   - New driver and bindings. Includes some new driver specific (for now)
>     ABI for handling toggle mode and the addition of a dither waveform to
>     the DAC output.
> * AFE (analog front end) add support for additional types of analog device
>   in front of an ADC.
>   - RTD temperature sensors with dt bindings.
>   - Temperature transducers wit dt bindings.
>   - Related cleanup and features listed in other sections below.
> * maxim,ds3502 potentiometer.
>   - Add support to ds1803 driver which required significant rework.
> * mediatek,mt2701-auxadc driver
>   - Add mediatek,mt8186-auxadc - id table and chip specific info only.
> * semtech,sx9324, semtech,ax9360
>   - Substantial refactoring of sx9310 to extract core logic for reuse
>     into a separate module
>   - New driver using this supporting sx9324 proximity sensors.
>   - New driver using this supporting sx9360 proximity sensors.
> * silan,sc7a20
>   - Compatible with the st,lis2dh (or nearly anyway) so add ID and
>     chip specific info to enable support. Also silan vendor ID added
>     for dt-bindings.
>=20
> Staging graduation
> * adi,ad7280a monitoring ADC for stacked lithium-ion batteries in
>   electric cars and similar.
>   - Substantial rework of driver required to bring inline with current
>     IIO best practice. An unusual device in IIO so some interesting featu=
res
>     we may see more of in future.
>=20
> Multiple driver/core cleanup
> - Use sysfs_emit() in simple locations where there is no path to change
>   to various core created attributes.
> - Trivial white space fixes around inconsistency between space after { and
>   before } in id tables.
> - Introduce new handling for fractional types to avoid repeated similar
>   implementations. Use this in 3 drivers. Note this is also targeted
>   at future use in the AFE driver and was motivated by discussions
>   around the precision related work on that driver.
> - of related header cleanups - drop of*.h and add mod_devicetable.h as
>   appropriate.
> - Move a number of symbol exports into IIO_* namespaces.  Two categories,
>   1) Library used by multiple drivers e.g. st_sensors
>   2) Core driver module exporting functions used by bus specific modules.
>   A few related cleanups in this set.
> - Switch from CONFIG_PM_* guards to new DEFINE_SIMPLE_DEV_PM_OPS() and
>   similar to simplify drivers and take advantage of these new macros
>   allowing the compiler to do the job or removing unused code without
>   the need for __maybe_unused markings. Conversion of other drivers to
>   these new macros ongoing.
>=20
> Features
> * adi,adf4350
>   - Switch from of specific to generic device properties enabling use with
>     other firmware types.
> * adi,adx345
>   - Switch from of specific to generic device properties.
>   - Add ACPI ID ADS0345
>   - Related driver cleanup.
> * adi,hmc425a
>   - Switch from of specific to generic device properties.
> * afe analog rescaler driver
>   - Wider range of types supported for scale.
>   - Support offset.
>   - Kunit tests.
> * atlas,ezo-sensor
>   - Convert from of to device properties.
> * fsl,mma8452
>   - Support mount matrix.
> * infineon,dps310:
>   - Add ACPI ID IFX3100.
> * invensense,mpu6050
>   - Convert to generic device properties.
> * maxim,ds1803
>   - Add out_raw_available before supporting more devices.
>   - Convert from of specific to device properties.
> * samsung,ssp_sensors
>   - Convert from of specific to device properties.
> * st,stm32-timer trigger
>   - Convert from of specific to device properties.
> * ti,hdc101x
>   - Add ACPI ID TXNW1010.
> * ti,tsc2046:
>   - Add read_raw support to enable use of iio_hwmon and similar.
>=20
> Fixes / cleanup.
> * mailmap
>   - Update for Cai Huoqing
> * MAINTAINERS
>   - Fix Analog Devices related links.
>   - Add entry for ADRF6780
>   - Add entry for ADMV1013
>   - Add entry for AD7293
>   - Add entry for ADMV8818
>   - Update files listed for adis-lib
> * iio core:
>   - Fix wrong comment about current_mode being something a driver should
>     ever access.
>   - Use struct_size() rather than open coding in industrialio-hw-consumer
> * adi,axl355
>   - Use units.h definitions instead of local versions.
> * adi,adis-lib
>   - Simplify *updated_bits() macro
>   - Whitespace cleanup.
> * afe - Note many of these fixes only apply to particular configurations
>   so the problems have probably not been seen in the wild, but will be
>   visible with new usecases enabled this cycle.
>   - Fix application of consumer scale for IIO_VAL_INT.
>   - Apply a scale of 1 when no scale is provided.
>   - Make best effort to establish a valid offset value for fractional
>     cases.
>   - Use s64 for scale calculations where parameters may be signed.
>   - Tidy up include order.
>   - Improve accuracy for small fractional sales
>   - Reduce risk of integer overflow.
> * ams,as3935
>   - Use devm_delayed_work_autocancel() to replace open coded equivalent.
> * aspeed,adc
>   - Fix wrong use of divider flag.
> * atmel,sama5d2-adc
>   - Relax atmel,trigger-edge-type to optional.
>   - Drop Ludovic Desroches from listed maintainers of the dt-binding
>     inline with previous MAINTAINERS entry update.
> * fsl,mma8452
>   - Fix probing when i2c_device_id used.
>   - dev_get_drvdata() on the iio_dev->dev, no longer returns iio_dev.
>     Use dev_to_iio_dev() instead. Note the original path in here
>     worked more by luck than design.
> * invensense,mpu6050
>   - Drop ACPI_PTR() protection to avoid an unused warning.
>   - Use fact ACPI_COMPANION() returns null when ACPI_HANDLE() does to
>     simplify handling.
> * motorola,cpcap-adc
>   - Drop unused assignment.
> * qcom,spmi-adc
>   - Fix wrong example of 'reg' in binding document.
> * renesas,rzg2l-adc
>   - Trivial typo fix.
> * semtech,sx9360
>   - Fix wrong register handling for event generation.
> * st_sensors
>   - Allow manual disabling of I2C or SPI module if not needed for a parti=
cular
>     board. Default is still to enable the bus specific module if
>     appropriate bus is supported.
> * st,lsm6dsx
>   - dev_get_drvdata() on the iio_dev->dev, no longer returns iio_dev.
>     Use dev_to_iio_dev() instead.
> * ti,palmas-gpadc
>   - Split the interrupt fields in the dt-binding example
> * ti,tsc2046
>   - Rework state machine to improve readability after recent debugging of
>     an issue fixed elsewhere.
>   - Add a sanity check to avoid very large memory allocations if a crazy
>     delay is specified.
> * ti,twl6030
>   - Add error handling if devm_request_threaded_irq() fails.
> * xilinx,ams
>   - Use devm_delayed_work_autocancel() instead of open coding equivalent.
>   - Fix missing required clock entry in dt-binding.
>   - Fix miss counting of channels resulting in ps channels not
>     being enabled.
>   - Fix incorrect values written to sequencer registers.
>   - Fix sequence for single channel reading.
>=20
> ----------------------------------------------------------------
> Andy Shevchenko (25):
>       math.h: Introduce data types for fractional numbers
>       iio: adc: rn5t618: Re-use generic struct u16_fract
>       iio: adc: twl4030-madc: Re-use generic struct s16_fract
>       iio: adc: qcom-vadc-common: Re-use generic struct u32_fract
>       iio: dac: ad5592r: Drop leftover header inclusion
>       iio: chemical: bme680: Switch from of headers to mod_devicetable.h
>       iio: amplifiers: hmc425a: Make use of device properties
>       iio: frequency: adf4350: Make use of device properties
>       iio: humidity: dht11: Switch from of headers to mod_devicetable.h
>       iio: temperature: mlx90632: Switch from of headers to mod_devicetab=
le.h
>       iio: temperature: maxim_thermocouple: Switch from of headers to mod=
_devicetable.h
>       iio: accel: adxl355: Replace custom definitions with generic from u=
nits.h
>       iio: imu: inv_mpu6050: Drop wrong use of ACPI_PTR()
>       iio: imu: inv_mpu6050: Check ACPI companion directly
>       iio: imu: inv_mpu6050: Make use of device properties
>       iio: ssp_sensors: Make use of device properties
>       iio: chemical: atlas-ezo-sensor: Make use of device properties
>       iio: trigger: stm32-timer: Make use of device properties
>       iio: accel: adxl345: Convert to use dev_err_probe()
>       iio: accel: adxl345: Set driver_data for OF enumeration
>       iio: accel: adxl345: Get rid of name parameter in adxl345_core_prob=
e()
>       iio: accel: adxl345: Make use of device properties
>       iio: accel: adxl345: Extract adxl345_powerup() helper
>       iio: accel: adxl345: Drop comma in terminator entries
>       iio: accel: adxl345: Remove unneeded blank lines
>=20
> Antoniu Miclaus (12):
>       MAINTAINERS: fix Analog Devices links
>       MAINTAINERS: add maintainer for ADRF6780 driver
>       MAINTAINERS: add maintainer for AD7293 driver
>       MAINTAINERS: add maintainer for ADMV1013 driver
>       MAINTAINERS: add maintainer for ADMV8818 driver
>       iio: frequency: admv1014: add support for ADMV1014
>       dt-bindings: iio: frequency: add admv1014 binding
>       Documentation: ABI: testing: admv1014: add ABI docs
>       MAINTAINERS: add maintainer for ADMV1014 driver
>       dt-bindings: iio: amplifiers: add ada4250 doc
>       iio: amplifiers: ada4250: add support for ADA4250
>       MAINTAINERS: add maintainer for ADA4250 driver
>=20
> Billy Tsai (1):
>       iio: adc: aspeed: Add divider flag to fix incorrect voltage reading.
>=20
> Cai Huoqing (1):
>       mailmap: Update email address for Cai Huoqing
>=20
> Christophe JAILLET (2):
>       iio: as3935: Use devm_delayed_work_autocancel()
>       iio: adc: xilinx-ams: Use devm_delayed_work_autocancel() to simplif=
y code
>=20
> Colin Ian King (1):
>       iio: adc: cpcap-adc: remove redundant assignment to variable cal_da=
ta_diff
>=20
> Cosmin Tanislav (5):
>       iio: introduce mag_referenced
>       iio: ABI: document mag_referenced
>       iio: ABI: add note about configuring other attributes during buffer=
 capture
>       dt-bindings: iio: accel: add ADXL367
>       iio: accel: add ADXL367 driver
>=20
> Cristian Pop (2):
>       dt-bindings: iio: frequency: Add ADMV4420 doc
>       iio: frequency: admv4420.c: Add support for ADMV4420
>=20
> Dan Carpenter (1):
>       iio: accel: adxl367: unlock on error in adxl367_buffer_predisable()
>=20
> Eugen Hristev (1):
>       dt-bindings: iio: adc: atmel,sama5d2-adc: make atmel,trigger-edge-t=
ype non-mandatory
>=20
> Guodong Liu (2):
>       dt-bindings: iio: adc: Add compatible for Mediatek MT8186
>       iio: adc: mt8186: Add compatible node for mt8186
>=20
> Gustavo A. R. Silva (1):
>       iio: hw_consumer: Use struct_size() helper in kzalloc()
>=20
> Gwendal Grignou (8):
>       iio:proximity:sx9310: Add frequency in read_avail
>       iio:proximity:sx9310: Extract common Semtech sensor logic
>       iio:proximity:sx9324: Add SX9324 support
>       dt-bindings:iio:proximity: Add sx9324 binding
>       iio:proximity:sx9324: Add dt_binding support
>       iio:proximity:sx9360: Add sx9360 support
>       dt-bindings:iio:proximity: Add sx9360 binding
>       iio:proximity:sx9360: Add dt-binding support
>=20
> Haibo Chen (2):
>       iio: imu: st_lsm6dsx: use dev_to_iio_dev() to get iio_dev struct
>       iio: accel: mma8452: use the correct logic to get mma8452_data
>=20
> Hans de Goede (2):
>       iio: mma8452: Fix probe failing when an i2c_device_id is used
>       iio: mma8452: Add support for the "mount-matrix" device property
>=20
> Jagath Jog J (7):
>       iio: potentiometer: ds1803: Alignment to match the open parenthesis
>       iio: potentiometer: ds1803: Add available functionality
>       iio: potentiometer: ds1803: Add channel information in device data
>       iio: potentiometer: ds1803: Change to firmware provided data
>       iio: potentiometer: ds1803: Add device specific read_raw function
>       iio: potentiometer: ds1803: Add support for Maxim DS3502
>       dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
>=20
> Jan Luebbe (1):
>       dt-bindings: iio: adc: microchip,mcp3201: fix interface type (I2C -=
> SPI)
>=20
> Jiasheng Jiang (1):
>       iio: adc: Add check for devm_request_threaded_irq
>=20
> Jonathan Cameron (115):
>       iio:chemical:atlas: Trivial white space cleanup to add space before=
 }
>       iio:light:pa12203001: Tidy up white space change to add spaces afte=
r { and before }
>       iio:light:vcnl4035: Trivial whitespace cleanup to add space before }
>       iio:light:us5182: White space cleanup of spacing around {} in id ta=
bles
>       iio:light:ltr501: White space cleanup of spacing around {} in id ta=
bles
>       iio:proximity:ping: White space cleanup of spacing around {} in id =
tables
>       iio:proximity:rfd77402: White space cleanup of spacing around {} in=
 id tables
>       iio:proximity:srf04: White space cleanup of spacing around {} in id=
 tables
>       iio:proximity:srf08: White space cleanup of spacing around {} in id=
 tables
>       iio:frequency:admv1013: White space cleanup of spacing around {} in=
 id tables
>       iio:adc:mt6577_auxadc: Tidy up white space around {} in id tables
>       iio:adc:hi8435: Tidy up white space around {} in id tables
>       iio:adc:ti-adc084s021: Tidy up white space around {}
>       iio:light:tsl2722: Fix inconsistent spacing before } in id table
>       iio:proximity:vl53l0x: Tidy up white space around {} in id tables
>       iio:accel:dmard09: Tidy up white space around {} in id table
>       iio:accel:mma9551_core: Move exports into IIO_MMA9551 namespace
>       iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
>       iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
>       iio:accel:bma400: Move exports into IIO_BMA400 namespace
>       iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
>       iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
>       iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
>       iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
>       iio:accel:bmc150: Move exports into IIO_BMC150 namespace
>       iio:accel:bmi088: Move exports into IIO_BMI088 namespace
>       iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespace
>       iio:st-sensors: Remove duplicate MODULE_*
>       iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
>       iio:adc:ad_sigma_delta: Move exports into IIO_AD_SIGMA_DELTA namesp=
ace
>       iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.
>       iio:adc:ad76060: Move exports into IIO_AD7606 namespace.
>       iio:common:meas-spec: Move exports into IIO_MEAS_SPEC_SENSORS
>       iio:common:ssp_sensors: Move exports into IIO_SSP_SENSORS namespace
>       iio:dac:ad5592r: Move exports into IIO_AD5592R namespace
>       iio:dac:ad5686: Move exports into IIO_AD5686 namespace
>       iio:imu:adis: Move exports into IIO_ADISLIB namespace
>       iio:pressure:zpa2326: Move exports into IIO_ZPA2326 namespace
>       iio:pressure:ms5611: Move exports into IIO_MS5611 namespace
>       iio:pressure:mpl115: Move exports into IIO_MPL115 namespace
>       iio:magnetometer:rm3100: Move exports to IIO_RM3100 namespace
>       iio:magnetometer:bmc150: Move exports to IIO_BMC150_MAGN namespace
>       iio:magnetometer:hmc5843: Move exports to IIO_HMC5843 namespace
>       iio:light:st_uvis25: Move exports to IIO_UVIS25 namespace
>       iio:chemical:bme680: Move exports to IIO_BME680 namespace
>       iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr=
() etc
>       iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr=
() etc
>       iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() e=
tc
>       iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr()
>       iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_sleep_=
ptr() etc
>       iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_=
ptr()
>       iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to pm_slee=
p_ptr()
>       iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr=
() etc
>       iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()=
 etc
>       iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr(=
) etc
>       iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()=
 etc
>       iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_sleep_=
ptr() etc
>       iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to pm_sleep_=
ptr()
>       iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_sleep_=
ptr() etc
>       iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to pm_slee=
p_ptr() etc
>       iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to pm_slee=
p_ptr() etc
>       iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to pm_sl=
eep_ptr() etc
>       iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to pm_slee=
p_ptr() etc
>       iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to pm_sl=
eep_ptr() etc
>       iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to pm_sl=
eep_ptr() etc
>       iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to pm_sleep_p=
tr() etc
>       iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to pm_sleep_pt=
r() etc
>       iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr(=
) etc
>       iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
>       iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr()=
 etc
>       iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
>       iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr()=
 etc
>       iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
>       iio:adc:stm32*: Use pm[_sleep]_ptr() etc to avoid need to make pm _=
_maybe_unused
>       staging:iio:adc:ad7280a: Fix handing of device address bit reversin=
g.
>       staging:iio:adc:ad7280a: Register define cleanup.
>       staging:iio:adc:ad7280a: rename _read() to _read_reg()
>       staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
>       staging:iio:adc:ad7280a: Use bitfield ops to managed fields in tran=
sfers.
>       staging:iio:adc:ad7280a: Switch to standard event control
>       staging:iio:adc:ad7280a: Standardize extended ABI naming
>       staging:iio:adc:ad7280a: Drop unused timestamp channel.
>       staging:iio:adc:ad7280a: Trivial comment formatting cleanup
>       staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
>       staging:iio:adc:ad7280a: Cleanup includes
>       staging:iio:ad7280a: Reflect optionality of irq in ABI
>       staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
>       staging:iio:adc:ad7280a: Use device properties to replace platform =
data.
>       staging:iio:adc:ad7280a: Drop buggy support for early termination o=
f AUX alert.
>       dt-bindings:iio:adc:ad7280a: Add binding
>       iio:adc:ad7280a: Document ABI for cell balance switches
>       staging:iio:adc:ad7280a: Remove shift from cb_mask state cache.
>       staging:iio:adc:ad7280a: Use more conservative delays to allow 105C=
 operation.
>       iio:adc:ad7280a: Move out of staging
>=20
> Jongpil Jung (1):
>       iio: sx9360: fix iio event generation
>=20
> Kai-Heng Feng (3):
>       iio: pressure: dps310: Add ACPI HID table
>       iio: humidity: hdc100x: Add ACPI HID table
>       iio: accel: adxl345: Add ACPI HID table
>=20
> Lad Prabhakar (1):
>       iio: adc: rzg2l_adc: Fix typo
>=20
> Lars-Peter Clausen (13):
>       iio: core: Use sysfs_emit()
>       iio: dmaengine-buffer: Use sysfs_emit()
>       iio: ad7192: Use sysfs_emit()
>       iio: ad9523: Use sysfs_emit()
>       iio: as3935: Use sysfs_emit()
>       iio: ina2xx-adc: sysfs_emit()
>       iio: lm3533: Use sysfs_emit()
>       iio: max31856: Use sysfs_emit()
>       iio: max31865: Use sysfs_emit()
>       iio: max9611: Use sysfs_emit()
>       iio: ms_sensors: Use sysfs_emit()
>       iio: scd4x: Use sysfs_emit()
>       iio: sps30: Use sysfs_emit()
>=20
> Liam Beguin (15):
>       iio: inkern: apply consumer scale on IIO_VAL_INT cases
>       iio: inkern: apply consumer scale when no channel scale is available
>       iio: inkern: make a best effort on offset calculation
>       iio: afe: rescale: use s64 for temporary scale calculations
>       iio: afe: rescale: reorder includes
>       iio: afe: rescale: expose scale processing function
>       iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>       iio: afe: rescale: add offset support
>       iio: afe: rescale: fix accuracy for small fractional scales
>       iio: afe: rescale: reduce risk of integer overflow
>       iio: test: add basic tests for the iio-rescale driver
>       iio: afe: rescale: add RTD temperature sensor support
>       iio: afe: rescale: add temperature transducers
>       dt-bindings: iio: afe: add bindings for temperature-sense-rtd
>       dt-bindings: iio: afe: add bindings for temperature transducers
>=20
> Miquel Raynal (1):
>       iio: core: Fix the kernel doc regarding the currentmode iio_dev ent=
ry
>=20
> Nathan Chancellor (1):
>       iio: accel: adxl367: Fix handled initialization in adxl367_irq_hand=
ler()
>=20
> Nicolas Ferre (1):
>       dt-bindings: iio: adc: at91-sama5d2: update maintainers entry
>=20
> Nikita Yushchenko (1):
>       iio: st_sensors: don't always auto-enable I2C and SPI interface dri=
vers
>=20
> Nuno S=C3=A1 (6):
>       MAINTAINERS: add missing files to the adis lib
>       adis: simplify 'adis_update_bits' macros
>       iio: adis: stylistic changes
>       iio: dac: add support for ltc2688
>       iio: ABI: add ABI file for the LTC2688 DAC
>       dt-bindings: iio: Add ltc2688 documentation
>=20
> Oleksij Rempel (3):
>       iio: adc: tsc2046: rework the trigger state machine
>       iio: adc: tsc2046: add .read_raw support
>       iio: adc: tsc2046: add sanity check to avoid to big allocations
>=20
> Rob Herring (2):
>       dt-bindings: iio/adc: ti,palmas-gpadc: Split interrupt fields in ex=
ample
>       dt-bindings: iio/adc: qcom,spmi-iadc: Fix 'reg' property in example
>=20
> Robert Hancock (4):
>       dt-bindings: iio: adc: zynqmp_ams: Add clock entry
>       iio: adc: xilinx-ams: Fixed missing PS channels
>       iio: adc: xilinx-ams: Fixed wrong sequencer register settings
>       iio: adc: xilinx-ams: Fix single channel switching sequence
>=20
> Samuel Holland (3):
>       dt-bindings: vendor-prefixes: Add silan vendor prefix
>       dt-bindings: iio: st: Add Silan SC7A20 accelerometer
>       iio: accel: st_accel: Add support for Silan SC7A20
>=20
>  .mailmap                                           |    1 +
>  Documentation/ABI/testing/sysfs-bus-iio            |   31 +
>  .../ABI/testing/sysfs-bus-iio-adc-ad7280a          |   13 +
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688          |   86 ++
>  .../ABI/testing/sysfs-bus-iio-frequency-admv1014   |   23 +
>  Documentation/ABI/testing/sysfs-bus-iio-sx9324     |   28 +
>  .../devicetree/bindings/iio/accel/adi,adxl367.yaml |   79 +
>  .../devicetree/bindings/iio/adc/adi,ad7280a.yaml   |   77 +
>  .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |    2 -
>  .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
>  .../bindings/iio/adc/microchip,mcp3201.yaml        |    2 +-
>  .../bindings/iio/adc/qcom,spmi-iadc.yaml           |    2 +-
>  .../bindings/iio/adc/ti,palmas-gpadc.yaml          |    6 +-
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    8 +
>  .../bindings/iio/afe/temperature-sense-rtd.yaml    |  101 ++
>  .../bindings/iio/afe/temperature-transducer.yaml   |  114 ++
>  .../bindings/iio/amplifiers/adi,ada4250.yaml       |   50 +
>  .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |  146 ++
>  .../bindings/iio/frequency/adi,admv1014.yaml       |  134 ++
>  .../bindings/iio/frequency/adi,admv4420.yaml       |   55 +
>  .../bindings/iio/proximity/semtech,sx9324.yaml     |  161 ++
>  .../bindings/iio/proximity/semtech,sx9360.yaml     |   89 ++
>  .../devicetree/bindings/iio/st,st-sensors.yaml     |    3 +
>  .../devicetree/bindings/trivial-devices.yaml       |    2 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
>  MAINTAINERS                                        |  123 +-
>  drivers/iio/accel/Kconfig                          |   62 +-
>  drivers/iio/accel/Makefile                         |    3 +
>  drivers/iio/accel/adis16201.c                      |    1 +
>  drivers/iio/accel/adis16209.c                      |    1 +
>  drivers/iio/accel/adxl313_core.c                   |    6 +-
>  drivers/iio/accel/adxl313_i2c.c                    |    1 +
>  drivers/iio/accel/adxl313_spi.c                    |    1 +
>  drivers/iio/accel/adxl345.h                        |    7 +-
>  drivers/iio/accel/adxl345_core.c                   |   56 +-
>  drivers/iio/accel/adxl345_i2c.c                    |   35 +-
>  drivers/iio/accel/adxl345_spi.c                    |   35 +-
>  drivers/iio/accel/adxl355_core.c                   |   11 +-
>  drivers/iio/accel/adxl355_i2c.c                    |    1 +
>  drivers/iio/accel/adxl355_spi.c                    |    1 +
>  drivers/iio/accel/adxl367.c                        | 1588 ++++++++++++++=
++++++
>  drivers/iio/accel/adxl367.h                        |   23 +
>  drivers/iio/accel/adxl367_i2c.c                    |   90 ++
>  drivers/iio/accel/adxl367_spi.c                    |  164 ++
>  drivers/iio/accel/adxl372.c                        |    4 +-
>  drivers/iio/accel/adxl372_i2c.c                    |    1 +
>  drivers/iio/accel/adxl372_spi.c                    |    1 +
>  drivers/iio/accel/bma180.c                         |    9 +-
>  drivers/iio/accel/bma400_core.c                    |    6 +-
>  drivers/iio/accel/bma400_i2c.c                     |    1 +
>  drivers/iio/accel/bma400_spi.c                     |    1 +
>  drivers/iio/accel/bmc150-accel-core.c              |    8 +-
>  drivers/iio/accel/bmc150-accel-i2c.c               |    1 +
>  drivers/iio/accel/bmc150-accel-spi.c               |    1 +
>  drivers/iio/accel/bmi088-accel-core.c              |    8 +-
>  drivers/iio/accel/bmi088-accel-spi.c               |    1 +
>  drivers/iio/accel/da280.c                          |    6 +-
>  drivers/iio/accel/da311.c                          |    6 +-
>  drivers/iio/accel/dmard06.c                        |   10 +-
>  drivers/iio/accel/dmard09.c                        |    2 +-
>  drivers/iio/accel/dmard10.c                        |    7 +-
>  drivers/iio/accel/fxls8962af-core.c                |    6 +-
>  drivers/iio/accel/fxls8962af-i2c.c                 |    1 +
>  drivers/iio/accel/fxls8962af-spi.c                 |    1 +
>  drivers/iio/accel/kxsd9-i2c.c                      |    1 +
>  drivers/iio/accel/kxsd9-spi.c                      |    1 +
>  drivers/iio/accel/kxsd9.c                          |    6 +-
>  drivers/iio/accel/mc3230.c                         |    6 +-
>  drivers/iio/accel/mma7455_core.c                   |    6 +-
>  drivers/iio/accel/mma7455_i2c.c                    |    1 +
>  drivers/iio/accel/mma7455_spi.c                    |    1 +
>  drivers/iio/accel/mma7660.c                        |   11 +-
>  drivers/iio/accel/mma8452.c                        |   54 +-
>  drivers/iio/accel/mma9551.c                        |   12 +-
>  drivers/iio/accel/mma9551_core.c                   |   36 +-
>  drivers/iio/accel/mma9553.c                        |   12 +-
>  drivers/iio/accel/ssp_accel_sensor.c               |    1 +
>  drivers/iio/accel/st_accel.h                       |    2 +
>  drivers/iio/accel/st_accel_buffer.c                |    5 -
>  drivers/iio/accel/st_accel_core.c                  |   88 +-
>  drivers/iio/accel/st_accel_i2c.c                   |    6 +
>  drivers/iio/accel/st_accel_spi.c                   |    1 +
>  drivers/iio/accel/stk8312.c                        |   11 +-
>  drivers/iio/accel/stk8ba50.c                       |   11 +-
>  drivers/iio/adc/Kconfig                            |   11 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/ab8500-gpadc.c                     |   14 +-
>  drivers/iio/adc/ad7091r-base.c                     |    4 +-
>  drivers/iio/adc/ad7091r5.c                         |    1 +
>  drivers/iio/adc/ad7124.c                           |    1 +
>  drivers/iio/adc/ad7192.c                           |    5 +-
>  drivers/iio/adc/ad7280a.c                          | 1111 ++++++++++++++
>  drivers/iio/adc/ad7606.c                           |    4 +-
>  drivers/iio/adc/ad7606_par.c                       |    1 +
>  drivers/iio/adc/ad7606_spi.c                       |    1 +
>  drivers/iio/adc/ad7780.c                           |    1 +
>  drivers/iio/adc/ad7791.c                           |    1 +
>  drivers/iio/adc/ad7793.c                           |    1 +
>  drivers/iio/adc/ad_sigma_delta.c                   |   20 +-
>  drivers/iio/adc/aspeed_adc.c                       |    4 +-
>  drivers/iio/adc/at91_adc.c                         |    7 +-
>  drivers/iio/adc/cpcap-adc.c                        |    2 +-
>  drivers/iio/adc/exynos_adc.c                       |    9 +-
>  drivers/iio/adc/hi8435.c                           |    2 +-
>  drivers/iio/adc/ina2xx-adc.c                       |    2 +-
>  drivers/iio/adc/max9611.c                          |    2 +-
>  drivers/iio/adc/mt6577_auxadc.c                    |   16 +-
>  drivers/iio/adc/palmas_gpadc.c                     |   10 +-
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   15 +-
>  drivers/iio/adc/qcom-spmi-vadc.c                   |   24 +-
>  drivers/iio/adc/qcom-vadc-common.c                 |   92 +-
>  drivers/iio/adc/rcar-gyroadc.c                     |    6 +-
>  drivers/iio/adc/rn5t618-adc.c                      |    7 +-
>  drivers/iio/adc/rockchip_saradc.c                  |    9 +-
>  drivers/iio/adc/rzg2l_adc.c                        |    4 +-
>  drivers/iio/adc/stm32-adc-core.c                   |   17 +-
>  drivers/iio/adc/stm32-adc.c                        |   12 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c                  |   11 +-
>  drivers/iio/adc/stm32-dfsdm-core.c                 |   19 +-
>  drivers/iio/adc/ti-adc084s021.c                    |    2 +-
>  drivers/iio/adc/ti-tsc2046.c                       |  269 +++-
>  drivers/iio/adc/twl4030-madc.c                     |    9 +-
>  drivers/iio/adc/twl6030-gpadc.c                    |   10 +-
>  drivers/iio/adc/vf610_adc.c                        |    7 +-
>  drivers/iio/adc/xilinx-ams.c                       |   26 +-
>  drivers/iio/afe/iio-rescale.c                      |  288 +++-
>  drivers/iio/amplifiers/Kconfig                     |   11 +
>  drivers/iio/amplifiers/Makefile                    |    1 +
>  drivers/iio/amplifiers/ada4250.c                   |  403 +++++
>  drivers/iio/amplifiers/hmc425a.c                   |    6 +-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |    2 +-
>  drivers/iio/buffer/industrialio-hw-consumer.c      |    4 +-
>  drivers/iio/chemical/atlas-ezo-sensor.c            |   32 +-
>  drivers/iio/chemical/atlas-sensor.c                |   17 +-
>  drivers/iio/chemical/bme680_core.c                 |    4 +-
>  drivers/iio/chemical/bme680_i2c.c                  |    1 +
>  drivers/iio/chemical/bme680_spi.c                  |    3 +-
>  drivers/iio/chemical/scd4x.c                       |    2 +-
>  drivers/iio/chemical/sps30.c                       |    2 +-
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   28 +-
>  drivers/iio/common/ssp_sensors/ssp_dev.c           |   40 +-
>  drivers/iio/common/ssp_sensors/ssp_iio.c           |    7 +-
>  drivers/iio/common/st_sensors/Kconfig              |    2 -
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  |    7 +-
>  drivers/iio/common/st_sensors/st_sensors_core.c    |   28 +-
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     |    2 +-
>  drivers/iio/common/st_sensors/st_sensors_spi.c     |    2 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |    9 +-
>  drivers/iio/dac/Kconfig                            |   11 +
>  drivers/iio/dac/Makefile                           |    1 +
>  drivers/iio/dac/ad5592r-base.c                     |    5 +-
>  drivers/iio/dac/ad5592r.c                          |    1 +
>  drivers/iio/dac/ad5593r.c                          |    1 +
>  drivers/iio/dac/ad5686-spi.c                       |    1 +
>  drivers/iio/dac/ad5686.c                           |    4 +-
>  drivers/iio/dac/ad5696-i2c.c                       |    1 +
>  drivers/iio/dac/ltc2688.c                          | 1071 +++++++++++++
>  drivers/iio/dac/m62332.c                           |   11 +-
>  drivers/iio/dac/stm32-dac-core.c                   |   16 +-
>  drivers/iio/dac/stm32-dac.c                        |    9 +-
>  drivers/iio/dac/vf610_dac.c                        |    7 +-
>  drivers/iio/frequency/Kconfig                      |   20 +
>  drivers/iio/frequency/Makefile                     |    2 +
>  drivers/iio/frequency/ad9523.c                     |    2 +-
>  drivers/iio/frequency/adf4350.c                    |  103 +-
>  drivers/iio/frequency/admv1013.c                   |    2 +-
>  drivers/iio/frequency/admv1014.c                   |  823 ++++++++++
>  drivers/iio/frequency/admv4420.c                   |  398 +++++
>  drivers/iio/gyro/Kconfig                           |   37 +-
>  drivers/iio/gyro/adis16136.c                       |    1 +
>  drivers/iio/gyro/adis16260.c                       |    1 +
>  drivers/iio/gyro/ssp_gyro_sensor.c                 |    1 +
>  drivers/iio/gyro/st_gyro_buffer.c                  |    4 -
>  drivers/iio/gyro/st_gyro_core.c                    |    5 +-
>  drivers/iio/gyro/st_gyro_i2c.c                     |    1 +
>  drivers/iio/gyro/st_gyro_spi.c                     |    1 +
>  drivers/iio/humidity/dht11.c                       |    3 +-
>  drivers/iio/humidity/hdc100x.c                     |    7 +
>  drivers/iio/humidity/htu21.c                       |    1 +
>  drivers/iio/imu/adis.c                             |   67 +-
>  drivers/iio/imu/adis16400.c                        |    1 +
>  drivers/iio/imu/adis16460.c                        |    1 +
>  drivers/iio/imu/adis16475.c                        |    1 +
>  drivers/iio/imu/adis16480.c                        |    1 +
>  drivers/iio/imu/adis_buffer.c                      |   10 +-
>  drivers/iio/imu/adis_trigger.c                     |    5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    5 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   15 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +-
>  drivers/iio/imu/kmx61.c                            |   10 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    4 +-
>  drivers/iio/imu/st_lsm9ds0/Kconfig                 |   28 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |    3 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    1 +
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    1 +
>  drivers/iio/industrialio-buffer.c                  |    4 +-
>  drivers/iio/industrialio-core.c                    |    2 +-
>  drivers/iio/industrialio-event.c                   |    1 +
>  drivers/iio/inkern.c                               |   40 +-
>  drivers/iio/light/apds9300.c                       |   10 +-
>  drivers/iio/light/bh1780.c                         |   12 +-
>  drivers/iio/light/cm3232.c                         |    9 +-
>  drivers/iio/light/isl29018.c                       |   10 +-
>  drivers/iio/light/isl29125.c                       |    7 +-
>  drivers/iio/light/jsa1212.c                        |   11 +-
>  drivers/iio/light/lm3533-als.c                     |    6 +-
>  drivers/iio/light/ltr501.c                         |   20 +-
>  drivers/iio/light/pa12203001.c                     |    4 +-
>  drivers/iio/light/rpr0521.c                        |    7 +-
>  drivers/iio/light/st_uvis25_core.c                 |    4 +-
>  drivers/iio/light/st_uvis25_i2c.c                  |    1 +
>  drivers/iio/light/st_uvis25_spi.c                  |    1 +
>  drivers/iio/light/stk3310.c                        |   11 +-
>  drivers/iio/light/tcs3414.c                        |    7 +-
>  drivers/iio/light/tcs3472.c                        |    7 +-
>  drivers/iio/light/tsl2563.c                        |   10 +-
>  drivers/iio/light/tsl2772.c                        |    2 +-
>  drivers/iio/light/tsl4531.c                        |   10 +-
>  drivers/iio/light/us5182d.c                        |    6 +-
>  drivers/iio/light/vcnl4035.c                       |    2 +-
>  drivers/iio/magnetometer/Kconfig                   |   35 +-
>  drivers/iio/magnetometer/ak8975.c                  |   12 +-
>  drivers/iio/magnetometer/bmc150_magn.c             |    8 +-
>  drivers/iio/magnetometer/bmc150_magn_i2c.c         |    1 +
>  drivers/iio/magnetometer/bmc150_magn_spi.c         |    1 +
>  drivers/iio/magnetometer/hmc5843_core.c            |    8 +-
>  drivers/iio/magnetometer/hmc5843_i2c.c             |    1 +
>  drivers/iio/magnetometer/hmc5843_spi.c             |    1 +
>  drivers/iio/magnetometer/mag3110.c                 |   10 +-
>  drivers/iio/magnetometer/mmc35240.c                |    9 +-
>  drivers/iio/magnetometer/rm3100-core.c             |    8 +-
>  drivers/iio/magnetometer/rm3100-i2c.c              |    1 +
>  drivers/iio/magnetometer/rm3100-spi.c              |    1 +
>  drivers/iio/magnetometer/st_magn_buffer.c          |    4 -
>  drivers/iio/magnetometer/st_magn_core.c            |    5 +-
>  drivers/iio/magnetometer/st_magn_i2c.c             |    1 +
>  drivers/iio/magnetometer/st_magn_spi.c             |    1 +
>  drivers/iio/potentiometer/Kconfig                  |    6 +-
>  drivers/iio/potentiometer/ds1803.c                 |  169 ++-
>  drivers/iio/pressure/Kconfig                       |   35 +-
>  drivers/iio/pressure/dps310.c                      |    7 +
>  drivers/iio/pressure/mpl115.c                      |    2 +-
>  drivers/iio/pressure/mpl115_i2c.c                  |    1 +
>  drivers/iio/pressure/mpl115_spi.c                  |    1 +
>  drivers/iio/pressure/mpl3115.c                     |   10 +-
>  drivers/iio/pressure/ms5611_core.c                 |    4 +-
>  drivers/iio/pressure/ms5611_i2c.c                  |    1 +
>  drivers/iio/pressure/ms5611_spi.c                  |    1 +
>  drivers/iio/pressure/ms5637.c                      |    1 +
>  drivers/iio/pressure/st_pressure_buffer.c          |    5 -
>  drivers/iio/pressure/st_pressure_core.c            |    5 +-
>  drivers/iio/pressure/st_pressure_i2c.c             |    1 +
>  drivers/iio/pressure/st_pressure_spi.c             |    1 +
>  drivers/iio/pressure/zpa2326.c                     |   12 +-
>  drivers/iio/pressure/zpa2326_i2c.c                 |    1 +
>  drivers/iio/pressure/zpa2326_spi.c                 |    1 +
>  drivers/iio/proximity/Kconfig                      |   34 +
>  drivers/iio/proximity/Makefile                     |    3 +
>  drivers/iio/proximity/as3935.c                     |   26 +-
>  drivers/iio/proximity/ping.c                       |    4 +-
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    7 +-
>  drivers/iio/proximity/rfd77402.c                   |    9 +-
>  drivers/iio/proximity/srf04.c                      |   12 +-
>  drivers/iio/proximity/srf08.c                      |    6 +-
>  drivers/iio/proximity/sx9310.c                     |  741 ++-------
>  drivers/iio/proximity/sx9324.c                     | 1068 +++++++++++++
>  drivers/iio/proximity/sx9360.c                     |  893 +++++++++++
>  drivers/iio/proximity/sx9500.c                     |    8 +-
>  drivers/iio/proximity/sx_common.c                  |  572 +++++++
>  drivers/iio/proximity/sx_common.h                  |  157 ++
>  drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
>  drivers/iio/temperature/max31856.c                 |    4 +-
>  drivers/iio/temperature/max31865.c                 |    4 +-
>  drivers/iio/temperature/maxim_thermocouple.c       |    5 +-
>  drivers/iio/temperature/mlx90614.c                 |   12 +-
>  drivers/iio/temperature/mlx90632.c                 |    2 +-
>  drivers/iio/temperature/tmp006.c                   |    6 +-
>  drivers/iio/temperature/tmp007.c                   |    6 +-
>  drivers/iio/temperature/tsys01.c                   |    1 +
>  drivers/iio/temperature/tsys02d.c                  |    1 +
>  drivers/iio/test/Kconfig                           |   10 +
>  drivers/iio/test/Makefile                          |    1 +
>  drivers/iio/test/iio-test-rescale.c                |  710 +++++++++
>  drivers/iio/trigger/Kconfig                        |    2 +-
>  drivers/iio/trigger/stm32-timer-trigger.c          |   23 +-
>  drivers/staging/iio/accel/adis16203.c              |    1 +
>  drivers/staging/iio/accel/adis16240.c              |    1 +
>  drivers/staging/iio/adc/Kconfig                    |   11 -
>  drivers/staging/iio/adc/Makefile                   |    1 -
>  drivers/staging/iio/adc/ad7280a.c                  | 1044 -------------
>  drivers/staging/iio/adc/ad7280a.h                  |   37 -
>  include/linux/iio/adc/qcom-vadc-common.h           |   15 +-
>  include/linux/iio/afe/rescale.h                    |   36 +
>  include/linux/iio/iio.h                            |    2 +-
>  include/linux/iio/imu/adis.h                       |   60 +-
>  include/linux/math.h                               |   12 +
>  include/uapi/linux/iio/types.h                     |    1 +
>  tools/iio/iio_event_monitor.c                      |    1 +
>  298 files changed, 12334 insertions(+), 2950 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adm=
v1014
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl3=
67.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a=
.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature=
-sense-rtd.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature=
-transducer.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,=
ada4250.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688=
.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmv1014.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmv4420.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semte=
ch,sx9324.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semte=
ch,sx9360.yaml
>  create mode 100644 drivers/iio/accel/adxl367.c
>  create mode 100644 drivers/iio/accel/adxl367.h
>  create mode 100644 drivers/iio/accel/adxl367_i2c.c
>  create mode 100644 drivers/iio/accel/adxl367_spi.c
>  create mode 100644 drivers/iio/adc/ad7280a.c
>  create mode 100644 drivers/iio/amplifiers/ada4250.c
>  create mode 100644 drivers/iio/dac/ltc2688.c
>  create mode 100644 drivers/iio/frequency/admv1014.c
>  create mode 100644 drivers/iio/frequency/admv4420.c
>  create mode 100644 drivers/iio/proximity/sx9324.c
>  create mode 100644 drivers/iio/proximity/sx9360.c
>  create mode 100644 drivers/iio/proximity/sx_common.c
>  create mode 100644 drivers/iio/proximity/sx_common.h
>  create mode 100644 drivers/iio/test/iio-test-rescale.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
>  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
>  create mode 100644 include/linux/iio/afe/rescale.h

