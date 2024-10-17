Return-Path: <linux-iio+bounces-10687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C99A2B1D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1BC1C21460
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2471DF98D;
	Thu, 17 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv67ybF7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFE15B12F
	for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186755; cv=none; b=H1a/myvNbQUiCqgg5bnSXHxqqe4F9sK9mXe3K5tqd0arYoXDgN0pP6eghMXjPOwEKJfkWbSMo0AnAh6AlsXpOojptYgrhEH9jeZGuqmzEhUDTG85LiMlKlcFddkF5UwQSZeq7HpEN4wvouzhHgjtNGxBXtZxCfHVjqL68pppdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186755; c=relaxed/simple;
	bh=kutmQdYYfGGRwby2oYR2rC6rt1fHNuBR7H5WmWuVgsI=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk19ppm80aHq7t/BkjJUYpK9qYa/F7/ilZp4gMTDDildDIwT/XU+RHZMF2yXTsmrBgDOmInCdatj6Mwt/C7yZz6sugOM7d5I1VWAN5Z11qt5kJGEzqjnyyNOZbq0E4oaGc033USbA8nyj9XHVlJX8q6Z/6LqjHAdKLvbooRk1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv67ybF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D13C4CEC3;
	Thu, 17 Oct 2024 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729186755;
	bh=kutmQdYYfGGRwby2oYR2rC6rt1fHNuBR7H5WmWuVgsI=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Kv67ybF7OjdSdrYgKSKtEi0iZyWvwXNOTqZpbONl2B3ef6CwSzmWdbYtsRxUIr69q
	 tGn6+6vHDGjh0kZj7MDHfpuWHwCumOTEqByOd0CSYMmHf0sLl/LpSogccYYisU+oge
	 FPV9ghfI78DlirIeikxmIter+5QJSvmG5tSwae9Uq2CyUxvcqZI2dfJUWjKNFVsSYB
	 I9oZ2jHzksbIFtDPvSuK8NFTKCiK+WRD+uhFYz0oBE2mADgjw80aOcf7hdZZpDjAHI
	 5MX0GbBSh9HrPCTujsXoCfqE4k6nzleg0xzt9+8XO63jshtP7GGqGgJaQ3tPnmgVsU
	 Ud4IfQvOu3OSA==
Date: Thu, 17 Oct 2024 18:39:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.13
Message-ID: <20241017183906.104ce8c1@jic23-huawei>
In-Reply-To: <20241017183303.5e9b9890@jic23-huawei>
References: <20241017183303.5e9b9890@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2024 18:33:03 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d=
7b:
>=20
>   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-6.13a
>=20
> for you to fetch changes up to f548c11a85ff08e3c6ac7fdf995cb98bf95c9acf:
>=20
>   iio: light: rpr0521: Use generic iio_pollfunc_store_time() (2024-10-15 =
18:59:51 +0100)

Hi Greg,

Please ignore this. There is is a spurious empty file.

However, given I've sent it.

I wasn't 100% sure on how to generate a pull request when I had a merge
of Linus' tree in the middle of it.
Doing git request-pull v6.12-rc2 ....
seemed to include all the right patches and makes sense to me, but if
there is a better way do let me know.

Jonathan

>=20
> ----------------------------------------------------------------
> IIO: 1st set of new device support, features and cleanup for 6.13
>=20
> Two merges of other trees.
>=20
> 6.12-rc2:
> To pull in the move of unaligned.h from include/asm to include/linux
> This was to resolve issues in linux-next.
>=20
> pwm/duty_offset-for6.13-rc1
> PWM infrastructure that is use in the AD7625 ADC driver.
>=20
> New device support
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> adi,ad7173
> - Add support for the AD4113 8 channel ADC.
> adi,ad7606
> - Add support for the AD7606C-16 and AD7606C-18 which have higher precisi=
on
>   and support bipolar and differential channels. A lot of driver
>   rework was needed to add the additional flexibility needed to support
>   these parts.
> adi,ad7625
> - New driver supporting AD7625, AD7626, AD7960 and AD7961 LVDS connected
>   ADCs. Interface uses a combination of a PWM control and an IIO backend
>   (currently a custom FPGA IP).
> adi,ad8460
> - New driver for the ad8460 Waveform DAC. This high speed device is
>   driven by a custom IP via a DMAEngine buffer.
> bosch,bmi270
> - New driver for this 6-axis IMU. A later patch adds SPI support.
> gehc,pmc-adc
> - New driver for this GE Healthcare ADC 16-channel 16 bit ADC.
> invensense,mpu6050
> - Add support for IAM-20680HT and IAM-20680HP variants of the IAM-20680
>   IMU that have better specifications in various ways including larger
>   FIFO sizes.
> vishay,vl6030
> - Support the veml7700, a stripped down veml6030 ambient light sensor.
> - Support the veml6035 ambient light sensor.
>=20
> Features
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> liteon,ltr390
> - Allow configuration of sampling frequency
> - Support suspend and resume
> - Add interrupt support including threshold events + control over
>   event reporting persistence.
> st,vl53l0x
> - Add support for continuous mode via IIO buffer support and a dataready
>   trigger.
> ti,tmp0006
> - Add triggered buffer support using data ready interrupt.
> vishay,vl6030
> - Add regulator control support.
> vishay,vl6070
> - Add regulator control support.
> vishay,vl6180
> - Allow configuration of waiting between continuous samples.
> - Use the interrupt, if available, for single shot captures
> - Support continuous mode via the IIO triggered buffer interfaces.
>=20
> Cleanups and minor fixes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> tools/event monitor
> - Free dev_dir_name.
> treewide
> - Introduce aligned_s64 type for timestamps to replace
>   s64 __aligned(8). Initial use in a few drivers - many others to follow.
> - Use dev_get_platform_data() instead of open-coding the access.
> - InvenSense email address and maintainer updates to reflect
>   move to the tdk domain after acquisition.
> - Switch platform drivers from remove_new() back to remove() now all
>   rework this was enabling is done.
> - More use of device_for_each_child_node_scoped() to remove need for manu=
al
>   caling of fwnode_handle_put() in early exits from the loop.
> - Use IIO_MAP() macro to replace some open-coded versions.
> - Constify struct iio_map arrays.
> - Use irq_get_trigger_type(irq) rather than
>   irqd_get_trigger_type(irq_get_irq_data(irq);
> core
> - unsigned to unsigned int.
> adi,ad3552r
> - Fix to low a limit on max SPI clock speed. No rush to upstream this
>   one as the binding that uses the higher speed will merge via this
>   tree once ready.
> adi,ad5770r
> - Use get_unaligned_le16() instead of open-coding. Note this caused
>   a merge issue in linux-next as unaligned.h has moved.
> adi,ad7606
> - Use read_avail() callback to handle the various _available attributes.
> - Wrap up all data related to channel scaling into a single structure as
>   the use of this gets more complex for the -16 and -18 parts.
> adi,adf4371
> - Use chip_info structures and spi_get_device_match_data()
> - Drop spi_set_drvdata() as unused.
> - Reduce scope of struct clock as only touched in probe().
> - Use dev_err_probe() where appropriate.
> adi,axi-dac
> - Improve register naming to make field and register association clearer.
> - Fix a wrong register bit.
> amlogic,meson8-saradc
> - Allow the meson8-saradc to have the amlogic,hhi-sysctrl property.
> bosch,bmp280
> - Use u8 for the DMA buffer to avoid implication of other types given it
>   can contain be24 data.
> - Use unsigned types to store raw values to make it clear they cannot be
>   negative.
> - Drop unnecessary check for errors after IIR filter update.
> - Support soft reset to get device to know state on driver load.
> - Use bulk reads to retrieve the humidity calibration data.
> dynaimage,al3010
> - Make sure to powerdown device in error paths.
> invensense,icm42600
> - Add missing i2c_device-id tables.
> kionix,kmx61
> - Drop ACPI IDs that are not associated with valid ACPI vendor IDs
>   and for which there is no evidence they are in use in real devices.
> liteon,ltrf261a
> - Document a bad compatible that we are supporting because it is in
>   the wild in the Valve Steam Deck via ACPI PRP0001.
> maxim,max1363
> - Use get_unaligned_be16() instead of open-coding. Note this caused
>   a merge issue in linux-next as unaligned.h has moved.
> mediatek,mt6360
> - Use get_unaligned_be16() instead of open-coding. Note this caused
>   a merge issue in linux-next as unaligned.h has moved.
> microchip,pac1921
> - Drop various unnecessary type casts that were suggested by
>   Wconversion compiler warnings which we do not use in IIO.
>   Remove them because they hurt readability in cases where it is clear
>   not overflow can occur.
> rohm,rpr0521
> - Use iio_poll_func_store_time() rather than open-coding a similar soluti=
on.
> semtech,sx9324
> - Make sx_common_get_raw_register() local to the only code that uses it.
> - Drop unnecessary acpi.h include.
> st,vl53l0x
> - Check the part ID register and print an info message if it is not what
>   is expected.
> vishay,veml6030
> - Fix DT binding file name to include vishay
> - Use regmap_set_bits() for case where all bits are set.
> - Use dev_err_probe() where appropriate.
> - Add missing delay after powering up in resume path.
> - Drop a processed accessor for the white channel as there is no public
>   information to allow a specific scale to be established.
> - Use read_avail() to replace explicit custom _available attributes.
> vishay,veml6070
> - Use guard() to allow early returns.
> - Add a devm callback to unregister the i2c device.
> - Use devm_iio_device_register() to simplify removal code.
>=20
> Various other minor improvements not called out explicitly.
>=20
> ----------------------------------------------------------------
> Abhash Jha (13):
>       iio: proximity: vl53l0x-i2c: Added sensor ID check
>       iio: proximity: vl53l0x-i2c: Added continuous mode support
>       iio: adc: max1363: Convert to get_unaligned_be16
>       iio: light: ltr390: Added configurable sampling frequency support
>       iio: light: ltr390: Suspend and Resume support
>       iio: light: ltr390: Interrupts and threshold event support
>       iio: light: ltr390: Add interrupt persistance support
>       iio: light: ltr390: Replaced mask values with GENMASK()
>       iio: adc: mt6360-adc: Converted to use get_unaligned_be16()
>       iio: dac: ad5770r: Convert to get_unaligned_le16
>       iio: light: vl6180: Add configurable inter-measurement period suppo=
rt
>       iio: light: vl6180: Added Interrupt support for single shot access
>       iio: light: vl6180: Add support for Continuous Mode
>=20
> Alex Lanzano (3):
>       dt-bindings: iio: imu: add bmi270 bindings
>       iio: imu: Add i2c driver for bmi270 imu
>       iio: imu: bmi270: Add spi driver for bmi270 imu
>=20
> Alexandru Ardelean (8):
>       iio: adc: ad7606: add 'bits' parameter to channels macros
>       iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
>       iio: adc: ad7606: move scale_setup as function pointer on chip-info
>       iio: adc: ad7606: wrap channel ranges & scales into struct
>       iio: adc: ad7606: rework available attributes for SW channels
>       dt-bindings: iio: adc: document diff-channels corner case for some =
ADCs
>       dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts
>       iio: adc: ad7606: add support for AD7606C-{16,18} parts
>=20
> Andy Shevchenko (32):
>       iio: imu: fxos8700: Drop unused acpi.h
>       iio: proximity: sx_common: Unexport sx_common_get_raw_register_conf=
ig()
>       iio: proximity: sx_common: Drop unused acpi.h
>       types: Complement the aligned types with signed 64-bit one
>       iio: imu: st_lsm6dsx: Use aligned data type for timestamp
>       iio: hid-sensor: Use aligned data type for timestamp
>       iio: accel: hid-sensor-accel-3d: Get platform data via dev_get_plat=
data()
>       iio: adc: ad7266: Get platform data via dev_get_platdata()
>       iio: adc: ad7791: Get platform data via dev_get_platdata()
>       iio: adc: ad7887: Get platform data via dev_get_platdata()
>       iio: adc: ad7793: Get platform data via dev_get_platdata()
>       iio: adc: ltc2497: Get platform data via dev_get_platdata()
>       iio: dac: ad5504: Get platform data via dev_get_platdata()
>       iio: dac: ad5791: Get platform data via dev_get_platdata()
>       iio: dac: m62332: Get platform data via dev_get_platdata()
>       iio: dac: max517: Get platform data via dev_get_platdata()
>       iio: frequency: ad9523: Get platform data via dev_get_platdata()
>       iio: frequency: adf4350: Get platform data via dev_get_platdata()
>       iio: gyro: hid-sensor-gyro-3d: Get platform data via dev_get_platda=
ta()
>       iio: imu: st_lsm6dsx: Get platform data via dev_get_platdata()
>       iio: light: hid-sensor-als: Get platform data via dev_get_platdata()
>       iio: light: hid-sensor-prox: Get platform data via dev_get_platdata=
()
>       iio: light: lm3533-als: Get platform data via dev_get_platdata()
>       iio: magnetometer: hid-sensor-magn-3d: Get platform data via dev_ge=
t_platdata()
>       iio: orientation: hid-sensor-incl-3d: Get platform data via dev_get=
_platdata()
>       iio: orientation: hid-sensor-rotation: Get platform data via dev_ge=
t_platdata()
>       iio: position: hid-sensor-custom-intel-hinge: Get platform data via=
 dev_get_platdata()
>       iio: pressure: hid-sensor-press: Get platform data via dev_get_plat=
data()
>       iio: light: cm32181: Remove duplicate ACPI handle check
>       iio: imu: inv_mpu6050: Use upper_16_bits()/lower_16_bits() helpers
>       iio: imu: kmx61: Drop most likely fake ACPI ID
>       iio: Convert unsigned to unsigned int
>=20
> Angelo Dureghello (3):
>       dt-bindings: iio: dac: ad3552r: fix maximum spi speed
>       iio: dac: adi-axi-dac: fix wrong register bitfield
>       iio: dac: adi-axi-dac: update register names
>=20
> Antoni Pokusinski (2):
>       iio: temperature: tmp006: add triggered buffer support
>       dt-bindings: iio: temperature: tmp006: document interrupt
>=20
> Bjorn Andersson (1):
>       iio: adc: qcom-spmi-adc5: Tidy up adc5_get_fw_data() error messages
>=20
> Christophe JAILLET (4):
>       iio: addac: ad74xxx: Constify struct iio_chan_spec=E2=80=8B
>       iio: adc: Constify struct iio_map
>       iio: adc: Convert to IIO_MAP()
>       iio: light: al3010: Fix an error handling path in al3010_probe()
>=20
> Colin Ian King (1):
>       iio: pressure: rohm-bm1390: Remove redundant if statement
>=20
> David Lechner (1):
>       iio: adc: ad7944: add namespace to T_QUIET_NS
>=20
> Dumitru Ceclan (3):
>       dt-bindings: adc: ad7173: add support for ad4113
>       iio: adc: ad7173: order chipID by value
>       iio: adc: ad7173: add support for ad4113
>=20
> Guillaume Stols (2):
>       iio: adc: ad7606: Fix typo in the driver name
>       iio: adc: ad7606: Sort includes in alphabetical order
>=20
> Herve Codina (4):
>       dt-bindings: vendor-prefixes: Add an entry for GE HealthCare
>       dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
>       iio: adc: Add support for the GE HealthCare PMC ADC
>       MAINTAINERS: add the GE HealthCare PMC ADC driver entry
>=20
> Hridesh MG (1):
>       staging: iio: Fix alignment warning
>=20
> Ivin Joel Abraham (1):
>       docs: iio: fix grammatical error
>=20
> Jason Liu (1):
>       iio: imu: inv_icm42600: add inv_icm42600 id_table
>=20
> Javier Carrasco (26):
>       dt-bindings: iio: light: veml6030: rename to add manufacturer
>       iio: light: veml6030: make use of regmap_set_bits()
>       iio: adc: qcom-pm8xxx-xoadc: use scoped device_for_each_child_node()
>       iio: adc: qcom-spmi-vadc: use scoped device_for_each_child_node()
>       iio: adc: sun20i-gpadc: use scoped device_for_each_child_node()
>       iio: adc: ad5755: use scoped device_for_each_child_node()
>       iio: light: veml6070: add action for i2c_unregister_device
>       iio: light: veml6070: use guard to handle mutex
>       iio: light: veml6070: use device managed iio_device_register
>       iio: light: veml6070: add support for a regulator
>       dt-bindings: iio: light: vishay,veml6075: add vishay,veml6070
>       iio: light: veml6070: add devicetree support
>       iio: light: veml6070: use dev_err_probe in probe function
>       iio: light: veml6030: add set up delay after any power on sequence
>       iio: light: veml6030: use dev_err_probe()
>       dt-bindings: iio: light: veml6030: add vdd-supply property
>       iio: light: veml6030: add support for a regulator
>       iio: light: veml6030: use read_avail() for available attributes
>       iio: light: veml6030: drop processed info for white channel
>       iio: light: veml6030: power off device in probe error paths
>       dt-bindings: iio: light: veml6030: add veml6035
>       iio: light: veml6030: add support for veml6035
>       iio: light: veml6035: fix read_avail in no_irq case for veml6035
>       dt-bindings: iio: light: veml6030: add veml7700
>       iio: light: veml6030: add support for veml7700
>       MAINTAINERS: add entry for VEML6030 ambient light sensor driver
>=20
> Jean-Baptiste Maneyrol (5):
>       dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu60=
50
>       iio: imu: inv_mpu6050: add support for IAM-20680HT/HP
>       MAINTAINERS: iio: migrate invensense email address to tdk domain
>       dt-bindings: iio: imu: migrate InvenSense email to TDK group domain
>       MAINTAINERS: iio: imu: add entry for InvenSense MPU-6050 driver
>=20
> Jonathan Cameron (17):
>       iio: accel: adxl380: use irq_get_trigger_type()
>       iio: accel: fxls8962af: use irq_get_trigger_type()
>       iio: adc: ti-ads1015: use irq_get_trigger_type()
>       iio: common: st: use irq_get_trigger_type()
>       iio: gyro: fxas21002c: use irq_get_trigger_type()
>       iio: gyro: mpu3050: use irq_get_trigger_type()
>       iio: humidity: hts221: use irq_get_trigger_type()
>       iio: imu: bmi160: use irq_get_trigger_type()
>       iio: imu: bmi323: use irq_get_trigger_type()
>       iio: imu: inv_icm42600: use irq_get_trigger_type()
>       iio: imu: inv_mpu6050: use irq_get_trigger_type()
>       iio: imu: st_lsm6dsx: use irq_get_trigger_type()
>       iio: light: st_uvis25: use irq_get_trigger_type()
>       iio: magn: ak8974: use irq_get_trigger_type()
>       iio: pressure: bmp280: use irq_get_trigger_type()
>       Merge tag 'v6.12-rc2' into test2
>       Merge tag 'pwm/duty_offset-for-6.13-rc1' into togreg
>=20
> Mariel Tinaco (2):
>       dt-bindings: iio: dac: add docs for ad8460
>       iio: dac: support the ad8460 Waveform DAC
>=20
> Matteo Martelli (1):
>       iio: pac1921: remove unnecessary explicit casts
>=20
> Neil Armstrong (1):
>       dt-bindings: iio: adc: amlogic,meson-saradc: also allow meson8-sara=
dc to have amlogic,hhi-sysctrl property
>=20
> Nuno Sa (4):
>       iio: frequency: adf4371: make use of spi_get_device_match_data()
>       iio: frequency: adf4371: drop spi_set_drvdata()
>       iio: frequency: adf4371: drop clkin from struct adf4371_state
>       iio: frequency: adf4371: make use of dev_err_probe()
>=20
> Shreeya Patel (1):
>       iio: light: ltrf216a: Document device name for compatible
>=20
> Tarang Raval (1):
>       iio: imu: bmi323: remove redundant register definition
>=20
> Trevor Gamblin (3):
>       dt-bindings: iio: adc: add AD762x/AD796x ADCs
>       iio: adc: ad7625: add driver
>       docs: iio: new docs for ad7625 driver
>=20
> Uwe Kleine-K=C3=B6nig (11):
>       pwm: Add more locking
>       pwm: New abstraction for PWM waveforms
>       pwm: Provide new consumer API functions for waveforms
>       pwm: Add tracing for waveform callbacks
>       pwm: axi-pwmgen: Implementation of the waveform callbacks
>       pwm: stm32: Implementation of the waveform callbacks
>       pwm: Reorder symbols in core.c
>       pwm: Add kernel doc for members added to pwm_ops recently
>       pwm: stm32: Fix error checking for a regmap_read() call
>       iio: adc: ti-ads1119: Drop explicit initialization of struct i2c_de=
vice_id::driver_data to 0
>       iio: Switch back to struct platform_driver::remove()
>=20
> Vasileios Amoiridis (6):
>       iio: pressure: bmp280: Use bulk read for humidity calibration data
>       iio: pressure: bmp280: Add support for bmp280 soft reset
>       iio: pressure: bmp280: Remove config error check for IIR filter upd=
ates
>       iio: pressure: bmp280: Use unsigned type for raw values
>       iio: pressure: bmp280: Use char instead of s32 for data buffer
>       iio: light: rpr0521: Use generic iio_pollfunc_store_time()
>=20
> Yo-Jung (Leo) Lin (1):
>       iio: pressure: bmp280: Fix uninitialized variable
>=20
> Yu Jiaoliang (1):
>       iio: adc: Fix typos in comments across various files
>=20
> zhang jiao (1):
>       iio: event_monitor: Fix missing free in main
>=20
>  Documentation/devicetree/bindings/iio/adc/adc.yaml |   4 +
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |   3 +
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 120 +++
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 ++++
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml     |   1 +
>  .../devicetree/bindings/iio/adc/gehc,pmc-adc.yaml  |  86 ++
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   2 +-
>  .../devicetree/bindings/iio/dac/adi,ad8460.yaml    | 164 ++++
>  .../devicetree/bindings/iio/imu/bosch,bmi270.yaml  |  77 ++
>  .../bindings/iio/imu/invensense,icm42600.yaml      |   2 +-
>  .../bindings/iio/imu/invensense,mpu6050.yaml       |   7 +-
>  .../devicetree/bindings/iio/light/veml6030.yaml    |  64 --
>  .../bindings/iio/light/vishay,veml6030.yaml        | 104 +++
>  .../bindings/iio/light/vishay,veml6075.yaml        |   3 +-
>  .../bindings/iio/temperature/ti,tmp006.yaml        |   6 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  Documentation/iio/ad7625.rst                       |  91 ++
>  Documentation/iio/bno055.rst                       |   2 +-
>  Documentation/iio/index.rst                        |   1 +
>  MAINTAINERS                                        |  50 +-
>  drivers/iio/accel/adxl380.c                        |   7 +-
>  drivers/iio/accel/fxls8962af-core.c                |   3 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c            |   9 +-
>  drivers/iio/adc/Kconfig                            |  28 +-
>  drivers/iio/adc/Makefile                           |   2 +
>  drivers/iio/adc/ab8500-gpadc.c                     |   2 +-
>  drivers/iio/adc/ad7091r-base.h                     |   2 +-
>  drivers/iio/adc/ad7173.c                           |  38 +-
>  drivers/iio/adc/ad7266.c                           |   2 +-
>  drivers/iio/adc/ad7606.c                           | 475 +++++++++--
>  drivers/iio/adc/ad7606.h                           |  88 +-
>  drivers/iio/adc/ad7606_par.c                       |   6 +-
>  drivers/iio/adc/ad7606_spi.                        |   0
>  drivers/iio/adc/ad7606_spi.c                       |  73 +-
>  drivers/iio/adc/ad7625.c                           | 684 +++++++++++++++
>  drivers/iio/adc/ad7791.c                           |   4 +-
>  drivers/iio/adc/ad7793.c                           |   2 +-
>  drivers/iio/adc/ad7887.c                           |   4 +-
>  drivers/iio/adc/ad7944.c                           |   4 +-
>  drivers/iio/adc/ad_sigma_delta.c                   |   4 +-
>  drivers/iio/adc/at91-sama5d2_adc.c                 |   2 +-
>  drivers/iio/adc/at91_adc.c                         |   2 +-
>  drivers/iio/adc/axp20x_adc.c                       |  62 +-
>  drivers/iio/adc/axp288_adc.c                       |   2 +-
>  drivers/iio/adc/bcm_iproc_adc.c                    |   8 +-
>  drivers/iio/adc/da9150-gpadc.c                     |  26 +-
>  drivers/iio/adc/dln2-adc.c                         |   2 +-
>  drivers/iio/adc/ep93xx_adc.c                       |   2 +-
>  drivers/iio/adc/exynos_adc.c                       |   2 +-
>  drivers/iio/adc/gehc-pmc-adc.c                     | 228 +++++
>  drivers/iio/adc/imx8qxp-adc.c                      |   2 +-
>  drivers/iio/adc/imx93_adc.c                        |   2 +-
>  drivers/iio/adc/intel_mrfld_adc.c                  |   2 +-
>  drivers/iio/adc/lp8788_adc.c                       |  18 +-
>  drivers/iio/adc/ltc2497-core.c                     |  15 +-
>  drivers/iio/adc/max1363.c                          |   3 +-
>  drivers/iio/adc/max34408.c                         |   2 +-
>  drivers/iio/adc/meson_saradc.c                     |   2 +-
>  drivers/iio/adc/mp2629_adc.c                       |   4 +-
>  drivers/iio/adc/mt6360-adc.c                       |   2 +-
>  drivers/iio/adc/mxs-lradc-adc.c                    |   6 +-
>  drivers/iio/adc/npcm_adc.c                         |   2 +-
>  drivers/iio/adc/pac1921.c                          |  41 +-
>  drivers/iio/adc/palmas_gpadc.c                     |   2 +-
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c                |  10 +-
>  drivers/iio/adc/qcom-spmi-adc5.c                   |   4 +-
>  drivers/iio/adc/qcom-spmi-vadc.c                   |   7 +-
>  drivers/iio/adc/rcar-gyroadc.c                     |   2 +-
>  drivers/iio/adc/rn5t618-adc.c                      |   2 +-
>  drivers/iio/adc/stm32-adc-core.c                   |   2 +-
>  drivers/iio/adc/stm32-adc.c                        |   2 +-
>  drivers/iio/adc/stm32-dfsdm-adc.c                  |   2 +-
>  drivers/iio/adc/stm32-dfsdm-core.c                 |   2 +-
>  drivers/iio/adc/sun20i-gpadc-iio.c                 |   7 +-
>  drivers/iio/adc/sun4i-gpadc-iio.c                  |   9 +-
>  drivers/iio/adc/ti-ads1015.c                       |   3 +-
>  drivers/iio/adc/ti-ads1119.c                       |   2 +-
>  drivers/iio/adc/ti-ads1298.c                       |   2 +-
>  drivers/iio/adc/ti_am335x_adc.c                    |  10 +-
>  drivers/iio/adc/twl4030-madc.c                     |   4 +-
>  drivers/iio/adc/twl6030-gpadc.c                    |   2 +-
>  drivers/iio/adc/vf610_adc.c                        |   2 +-
>  drivers/iio/adc/xilinx-xadc-events.c               |   2 +-
>  drivers/iio/addac/ad74115.c                        |  18 +-
>  drivers/iio/addac/ad74413r.c                       |  21 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |   2 +-
>  drivers/iio/dac/Kconfig                            |  13 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/ad5504.c                           |   2 +-
>  drivers/iio/dac/ad5755.c                           |  11 +-
>  drivers/iio/dac/ad5770r.c                          |   3 +-
>  drivers/iio/dac/ad5791.c                           |   2 +-
>  drivers/iio/dac/ad8460.c                           | 944 +++++++++++++++=
++++++
>  drivers/iio/dac/adi-axi-dac.c                      | 137 +--
>  drivers/iio/dac/dpot-dac.c                         |   2 +-
>  drivers/iio/dac/lpc18xx_dac.c                      |   6 +-
>  drivers/iio/dac/m62332.c                           |   2 +-
>  drivers/iio/dac/max517.c                           |   2 +-
>  drivers/iio/dac/stm32-dac-core.c                   |   2 +-
>  drivers/iio/dac/stm32-dac.c                        |   2 +-
>  drivers/iio/dac/vf610_dac.c                        |   2 +-
>  drivers/iio/frequency/ad9523.c                     |   2 +-
>  drivers/iio/frequency/adf4350.c                    |   2 +-
>  drivers/iio/frequency/adf4371.c                    |  63 +-
>  drivers/iio/gyro/fxas21002c_core.c                 |   3 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |   8 +-
>  drivers/iio/gyro/mpu3050-core.c                    |   2 +-
>  drivers/iio/humidity/hid-sensor-humidity.c         |   4 +-
>  drivers/iio/humidity/hts221_buffer.c               |   3 +-
>  drivers/iio/imu/Kconfig                            |   1 +
>  drivers/iio/imu/Makefile                           |   1 +
>  drivers/iio/imu/bmi160/bmi160_core.c               |  11 +-
>  drivers/iio/imu/bmi270/Kconfig                     |  32 +
>  drivers/iio/imu/bmi270/Makefile                    |   7 +
>  drivers/iio/imu/bmi270/bmi270.h                    |  19 +
>  drivers/iio/imu/bmi270/bmi270_core.c               | 307 +++++++
>  drivers/iio/imu/bmi270/bmi270_i2c.c                |  53 ++
>  drivers/iio/imu/bmi270/bmi270_spi.c                |  85 ++
>  drivers/iio/imu/bmi323/bmi323.h                    |   1 -
>  drivers/iio/imu/bmi323/bmi323_core.c               |   8 +-
>  drivers/iio/imu/fxos8700_core.c                    |   1 -
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  10 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |  17 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |  17 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  29 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  10 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   4 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  10 +
>  drivers/iio/imu/kmx61.c                            |  25 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  18 +-
>  drivers/iio/inkern.c                               |   7 +-
>  drivers/iio/light/Kconfig                          |   4 +-
>  drivers/iio/light/al3010.c                         |  11 +-
>  drivers/iio/light/cm32181.c                        |   3 +-
>  drivers/iio/light/cm3605.c                         |   2 +-
>  drivers/iio/light/hid-sensor-als.c                 |   8 +-
>  drivers/iio/light/hid-sensor-prox.c                |   6 +-
>  drivers/iio/light/lm3533-als.c                     |   8 +-
>  drivers/iio/light/ltr390.c                         | 365 +++++++-
>  drivers/iio/light/ltrf216a.c                       |   1 +
>  drivers/iio/light/rpr0521.c                        |  14 +-
>  drivers/iio/light/st_uvis25_core.c                 |   3 +-
>  drivers/iio/light/veml6030.c                       | 532 +++++++++---
>  drivers/iio/light/veml6070.c                       |  63 +-
>  drivers/iio/light/vl6180.c                         | 255 +++++-
>  drivers/iio/magnetometer/ak8974.c                  |   2 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   6 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |   8 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |   8 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |   8 +-
>  drivers/iio/pressure/bmp280-core.c                 | 177 ++--
>  drivers/iio/pressure/bmp280.h                      |  13 +-
>  drivers/iio/pressure/hid-sensor-press.c            |   8 +-
>  drivers/iio/pressure/rohm-bm1390.c                 |   3 -
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c     |   2 +-
>  drivers/iio/proximity/srf04.c                      |   2 +-
>  drivers/iio/proximity/sx9324.c                     |  20 +
>  drivers/iio/proximity/sx9360.c                     |   1 -
>  drivers/iio/proximity/sx_common.c                  |  21 -
>  drivers/iio/proximity/sx_common.h                  |   4 -
>  drivers/iio/proximity/vl53l0x-i2c.c                | 174 +++-
>  drivers/iio/temperature/Kconfig                    |   2 +
>  drivers/iio/temperature/hid-sensor-temperature.c   |   4 +-
>  drivers/iio/temperature/tmp006.c                   | 134 ++-
>  drivers/iio/trigger/iio-trig-interrupt.c           |   2 +-
>  drivers/iio/trigger/stm32-timer-trigger.c          |   2 +-
>  drivers/pwm/core.c                                 | 857 +++++++++++++++=
----
>  drivers/pwm/pwm-axi-pwmgen.c                       | 148 +++-
>  drivers/pwm/pwm-stm32.c                            | 612 ++++++++-----
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |   6 +-
>  include/dt-bindings/iio/adc/gehc,pmc-adc.h         |  10 +
>  include/linux/iio/driver.h                         |   5 +-
>  include/linux/iio/iio-opaque.h                     |   2 +-
>  include/linux/iio/iio.h                            |  20 +-
>  include/linux/pwm.h                                |  60 +-
>  include/linux/types.h                              |   3 +-
>  include/trace/events/pwm.h                         | 134 ++-
>  include/uapi/linux/types.h                         |   1 +
>  tools/iio/iio_event_monitor.c                      |   1 +
>  181 files changed, 7167 insertions(+), 1425 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7625.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-ad=
c.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi27=
0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,ve=
ml6030.yaml
>  create mode 100644 Documentation/iio/ad7625.rst
>  create mode 100644 drivers/iio/adc/ad7606_spi.
>  create mode 100644 drivers/iio/adc/ad7625.c
>  create mode 100644 drivers/iio/adc/gehc-pmc-adc.c
>  create mode 100644 drivers/iio/dac/ad8460.c
>  create mode 100644 drivers/iio/imu/bmi270/Kconfig
>  create mode 100644 drivers/iio/imu/bmi270/Makefile
>  create mode 100644 drivers/iio/imu/bmi270/bmi270.h
>  create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
>  create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c
>  create mode 100644 drivers/iio/imu/bmi270/bmi270_spi.c
>  create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h
>=20


