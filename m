Return-Path: <linux-iio+bounces-16803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388EA6018D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2A0421D07
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8E1F193D;
	Thu, 13 Mar 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0oE8DnX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589C18A6B8
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895288; cv=none; b=rmpwMwmildoXVXHsbFMXiv0D35F64YRnqjRKp9yWWimVrG0gr0ovdGp1e0HbvVGRkKkXNkn6yyHSxgmOT4ZmkZgoalerUoFND7LtGaNXf7oRbExgYA0gr5NHjxPI9ipm4oNGKAJfzHTTCId+hQPEdK7h7T55TbVmCW7ezfttQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895288; c=relaxed/simple;
	bh=INC4BEBXG83dkMjflBr3rpJ0OQAClJL8rfrDR0pet4o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=tsMXtwmEjToXsgnElUMcEExht31iiEeC3cdJcaO1H1EiKCWCfYdBEK0zIL1FLDCqVHkaT1iG+ETUqXXpPmSgrH3R8TB05acWKShZauNzN+rhBTQnNGVlvKTt/192Kj/HHdVOSbM89mzBCQQKJjLLRbpAgILRgDBPeJLIG4N1mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0oE8DnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4793AC4CEDD;
	Thu, 13 Mar 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741895287;
	bh=INC4BEBXG83dkMjflBr3rpJ0OQAClJL8rfrDR0pet4o=;
	h=Date:From:To:Subject:From;
	b=M0oE8DnXkRv7GcwqFgCkGchyE3j6eYWQU4NHdFc38rnR/PdVGkVQj/UpRiCOnIEhY
	 QXP/kWvgxnUQxGy3g1Mm9vI0fSmOYQIMGL+bFYhJkqwC4qHg/jBIndhh4upqjsvdXT
	 dDUIz5J2mHCaVT33mOzgghnux3uEt+1jkkkKiJ06aI/Zd69SfXCJKcFymJo1O1XFKB
	 I8daKTSqAkSxlfd5vCLhTu+ner8Ve7WcdMYjjtN2bgmgzbh4N2+Sp71nwjRl4qrwWd
	 jtMUq0pF9ewNgGEJUJMCpKuqvhR74xiJjssEQfU0DwpWzxOGfORft9i5lUZmcg4Txe
	 xYkSnDPgdvczw==
Date: Thu, 13 Mar 2025 19:48:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features and cleanup for 6.15
Message-ID: <20250313194801.16035f96@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.15a

for you to fetch changes up to 8dbeb413806f9f810d97d25284f585b201aa3bdc:

  doc: iio: ad7380: describe offload support (2025-03-11 19:09:17 +0000)

----------------------------------------------------------------
IIO: New device support, features and cleanup for the 6.15 cycle.

The usual mixture of new drivers, support in existing drivers for new
devices, a range of features and general subsystem cleanup.

Two merges of immutable branches in here:
* SPI offload support. Culmination of a long effort to bring the ability
  to offload triggered sequences of SPI operations to specific hardware,
  allow high datarate acquisition over an SPI bus (if you have the right
  hardware / FPGA firmware)
* GPIO set-array-helper - enables code simplification.

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad3552r-hs:
- Add support for AD3541r and AD3542r via newly supported FPGA HDL.
adi,ad4030
- New driver supporting the AD4030, AD4630 AD4630-16, AD4640-24, AD4632-16,
  AD4632-24 1 and 2 channel high precision SPI ADCs.
adi,ad4851
- New driver and backend support for the AD4851, AD4852, AD4853, AD4854,
  AD4855, AD4846, AD4857, AD4858 and AD4858I high speed multichannel
  simultaneous sampling ADCs.
adi,ad7191
- New driver for this 24-bit ADC for precision bridge applications,
adi,ad7380
- Add support for the adaq4381-4 which is a 14-bit version of the
  already supported adaq4380-1
adi,adis16550
- New driver using the ADIS library (which needed extensions) for this
  IMU.
brcm,apds9160
- New driver for this proximity and ambient light sensor.
dynaimage,al3000a
- New driver for this illuminance sensor.
mcube,mc3230
- Add support for the mc3510c accelerometer with a different scale to exist=
ing
  supported parts (some rework preceded this)
nxp,imx93
- Add compatibles for imx94 and imx95 which are fully compatible with imx93.
rockchip,saradc
- Add support for the RK3528 ADC
- Add support for the RK3562 ADC
silab,si7210
- New driver to support this I2C Hall effect magnetic position sensor.
ti,ads7138
- New driver supporting the ADS7128 and AD7138 I2C ADCs.

Staging driver drop
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,adis16240
- Drop this impact sensor. Interesting part but complex hence never left
  staging due to ABI challenges. No longer readily available so drop driver.

New features
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Documentation
- A really nice overview document introduce ADC terminology and how
  it maps to IIO.
core
- New description for FAULT events, used in the ad7173.
- filter_type ABI used in ad4130.
buffer-dmaengine
- Split DMA channel request from buffer allocation (for SPI offload)
- Add a new _with_handle setup variant. (for SPI offload)
adi,adf4371
- Add control of reference clock type and support for frequency doubling
  where appropriate.
adi,ad4695
- Support SPI offload.
- Support oversampling control.
adi,ad5791
- Support SPI offload.
adi,ad7124
- Add channel calibration support.
adi,ad7380:
- Alert support (threshold interrupts)
- SPI offload support.
adi,ad7606
- Support writing registers when using backend enabling software control
  of modes.
adi,ad7944
- Support SPI offload.
adi,ad9832
- Use devm_regulator_get_enable() to simplify code.
adi,ad9834
- Use devm_regulator_get_enable() to simplify code.
adi,adxl345
- Improve IRQ handling code.
- Add debug access to registers.
bosch,bmi270
- Add temperature channel support.
- Add data ready trigger.
google,cross_ec
- Add trace events.
mcube,mc3230
- Add mount matrix support
- Add an OF match table.

Cleanup and minor bug fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Tree wide:
- Stop using iio_device_claim_direct_scoped() and introduce sparse friendly
  iio_device_claim/release_direct()

  The conditional scoped cleanup has proved hard to deal with, requiring
  workarounds for various compiler issues and in is rather non-intuitive
  so abandon that experiment. One of the attractions of that approach was
  that it made it much harder to have unbalanced   claim/release bugs so
  instead introduce a conditional-lock style boolean returning new pair
  of functions. These are inline in the header and have __acquire and
  __release calls allowing sparse to detect lack of balance.  There are
  occasional false positives but so far those have reflected complex code
  paths that benefited from cleanup anyway.
  The first set of driver conversions are in this pull request, more to
  follow next cycle. Various related cleanup in drivers.
  Removal of the _scoped code is completed and the definition removed.
- Use of str_enable_disable() and similar helpers.
- Don't set regmap cache to REGCACHE_NONE as that's the default anyway.
- Change some caches from RBTREE to MAPLE reflecting best practice.
- Use the new gpiod_multi_set_value_cansleep()
- Make sure to grab direct mode for some calibrations paths.
- Avoid using memcmp on structures when checking for matching channel confi=
gs.
  Instead just match field by field.
dt-bindings:
- Fix up indentation inconsistencies.
gts-helper:
- Simplify building of available scale table.
adi,ad-sigma-delta
- Make sure to disable channel after calibration done.
- Add error handling in configuring channel during calibration.
adi,ad2s1201
- use a bitmap_write() rather than directly accessing underlying storage.
adi,ad3552r-hs
- Fix a wrong error message.
- Make sure to use instruction mode for configuration.
adi,ad4695
- Add a conversion to ensure exit from conversion mode.
- Use custom regmap to handle required sclk rate change.
- Fix an out of bounds array access
- Simplify oversampling ratio handling.
adi,ad4851
- Fix a sign bug.
adi,ad5791
- Fix wrong exported number of storage bits.
adi,ad7124
- Disable all channels at probe to avoid strange initial configurations.
adi,ad7173
- Rework to allow static const struct ad_sigma_delta without need
  to make a copy.
adi,ad7623
- Drop a BSD license tag that the authors consider unnecessary.
adi,ad7768-1
- Fix channels sign description exposed to user space.
- Set MOSI idle state to avoid accidental device reset.
- Avoid some overkill locking.
adi,axi-dac
- Check if device interface is busy when enabling data stream.
- Add control of bus mode.
bosch,bmi270
- Move a struct definition to a c file as only used there.
vishay,veml6030
- Enable regmap cache to reduce bus traffic.
- Fix ABI bug around scale reporting.
vishay,vem6075
- Check array bounds to harden against broken hardware.

Various other minor tweaks and fixes not called out.

*

----------------------------------------------------------------
Alisa-Dariana Roman (3):
      dt-bindings: iio: adc: add AD7191
      iio: adc: ad7191: add AD7191
      docs: iio: add AD7191

Andy Shevchenko (3):
      iio: light: adux1020: Drop unneeded assignment for cache_type
      iio: magnetometer: af8133j: Drop unneeded assignment for cache_type
      iio: pressure: zpa2326: Drop unneeded assignment for cache_type

Angelo Dureghello (13):
      iio: dac: adi-axi-dac: modify stream enable
      iio: dac: adi-axi-dac: add bus mode setup
      iio: dac: ad3552r-hs: fix message on wrong chip id
      iio: dac: ad3552r-hs: use instruction mode for configuration
      iio: dac: ad3552r: share model data structures
      iio: dac: ad3552r-hs: add ad3541/2r support
      iio: dac: ad3552r-hs: update function name (non functional)
      iio: adc: adi-axi-adc: add struct axi_adc_info
      iio: adc: adi-axi-adc: add platform children support
      iio: adc: ad7606: protect register access
      iio: dac: adi-axi-dac: add io_mode check
      iio: ad7380: add support for SPI offload
      doc: iio: ad7380: describe offload support

Antoni Pokusinski (2):
      dt-bindings: iio: magnetometer: add binding for Si7210
      iio: magnetometer: si7210: add driver for Si7210

Antoniu Miclaus (12):
      dt-bindings: iio: adf4371: add refin mode
      iio: frequency: adf4371: add refin mode
      iio: frequency: adf4371: add ref doubler
      iio: backend: add API for interface get
      iio: backend: add support for data size set
      iio: backend: add API for oversampling
      iio: adc: adi-axi-adc: add interface type
      dt-bindings: iio: adc: add ad485x axi variant
      iio: adc: adi-axi-adc: set data format
      iio: adc: adi-axi-adc: add oversampling
      dt-bindings: iio: adc: add ad4851
      iio: adc: ad4851: add ad485x driver

Axel Haslam (1):
      iio: dac: ad5791: Add offload support

Bo Liu (4):
      iio: accel: msa311: convert to use maple tree register cache
      iio: accel: bma400: convert to use maple tree register cache
      iio: accel: bmi088: convert to use maple tree register cache
      iio: accel: kx022a: convert to use maple tree register cache

Colin Ian King (1):
      iio: light: Fix spelling mistake "regist" -> "register"

Dan Carpenter (2):
      iio: adc: ad4851: Fix signedness bug in ad4851_calibrate()
      iio: adc: ad4030: fix error pointer dereference in probe()

David Lechner (25):
      iio: adc: ad7173: move fwnode_irq_get_byname() call site
      iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      dt-bindings: trigger-source: add generic PWM trigger source
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs
      iio: dac: ad5791: fix storage
      iio: buffer-dmaengine: split requesting DMA channel from allocating b=
uffer
      iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_with_handl=
e()
      iio: adc: ad7944: don't use storagebits for sizing
      iio: adc: ad7944: add support for SPI offload
      doc: iio: ad7944: describe offload support
      dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
      iio: adc: ad4695: Add support for SPI offload
      doc: iio: ad4695: add SPI offload support
      iio: dac: ad5791: sort include directives
      gpiolib: add gpiod_multi_set_value_cansleep()
      iio: adc: ad7606: use gpiod_multi_set_value_cansleep
      iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
      iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
      iio: resolver: ad2s1210: use bitmap_write
      iio: adc: ad4695: fix out of bounds array access
      iio: adc: ad4695: simplify getting oversampling_ratio
      MAINTAINERS: remove adi,ad7606.yaml from SEPS525

Esteban Blanc (6):
      dt-bindings: iio: adc: add ADI ad4030, ad4630 and ad4632
      iio: adc: ad4030: add driver for ad4030-24
      iio: adc: ad4030: add averaging support
      iio: adc: ad4030: add support for ad4630-24 and ad4630-16
      iio: adc: ad4030: add support for ad4632-16 and ad4632-24
      docs: iio: ad4030: add documentation

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Switch to fsleep()

Folker Schwesinger (1):
      iio: buffer-dma: Fix docstrings

Frank Li (1):
      dt-bindings: iio: adc: Add i.MX94 and i.MX95 support

Guillaume Ranquet (2):
      iio: introduce the FAULT event type
      iio: adc: ad7173: add openwire detection support for single conversio=
ns

Guillaume Stols (6):
      dt-bindings: iio: dac: adi-axi-adc: add ad7606 variant
      iio: adc: ad7606: move the software mode configuration
      iio: adc: ad7606: move software functions into common file
      iio: adc: adi-axi-adc: add support for AD7606 register writing
      iio: adc: ad7606: change channel macros parameters
      iio: adc: ad7606: add support for writing registers when using backend

Gustavo Silva (4):
      iio: imu: bmi270: add temperature channel
      iio: imu: bmi270: move private struct declaration to source file
      iio: imu: bmi270: rename variable bmi270_device to data
      iio: imu: bmi270: add support for data ready interrupt trigger

Gwendal Grignou (1):
      iio: cros_ec: Trace EC sensors command

Javier Carrasco (4):
      iio: light: veml6030: extend regmap to support regfields
      iio: light: veml6030: extend regmap to support caching
      iio: gts-helper: export iio_gts_get_total_gain()
      iio: light: veml6030: fix scale to conform to ABI

Jonas Karlman (2):
      dt-bindings: iio: adc: Add rockchip,rk3528-saradc variant
      iio: adc: rockchip_saradc: Add support for RK3528

Jonathan Cameron (59):
      Merge tag 'spi-offload' into togreg
      iio: core: Rework claim and release of direct mode to work with spars=
e.
      iio: chemical: scd30: Use guard(mutex) to allow early returns
      iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
      iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
      iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
      iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
      iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
      iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
      iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
      iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
      iio: adc: rtq6056: Stop using iio_device_claim_direct_scoped()
      iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
      iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
      iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
      iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
      iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
      iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
      iio: dummy: Stop using iio_device_claim_direct_scoped()
      iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
      iio: light: bh1745: Stop using iio_device_claim_direct_scoped()
      iio: Drop iio_device_claim_direct_scoped() and related infrastructure
      Merge tag 'gpio-set-array-helper-v6.15-rc1' into togreg
      iio: accel: mma8452: Ensure error return on failure to matching overs=
ampling ratio
      iio: accel: mma8452: Factor out guts of write_raw() to simplify locki=
ng
      iio: accel: mma8452: Switch to sparse friendly iio_device_claim/relea=
se_direct()
      iio: accel: kx022a: Factor out guts of write_raw() to allow direct re=
turns
      iio: accel: kx022a: Switch to sparse friendly iio_device_claim/releas=
e_direct()
      iio: accel: msa311: Fix failure to release runtime pm if direct mode =
claim fails.
      iio: accel: msa311: Switch to sparse friendly iio_device_claim/releas=
e_direct()
      iio: accel: Switch to sparse friendly iio_device_claim/release_direct=
()
      iio: adc: stm32-dfsdm: Factor out core of reading INFO_RAW
      iio: adc: stm32-dfsdm: Switch to sparse friendly iio_device_claim/rel=
ease_direct()
      iio: adc: ad4030: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad7192: Factor out core of ad7192_write_raw() to simplify e=
rror handling.
      iio: adc: ad7192: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecess=
ary return value check
      iio: adc: ad7768-1: Switch to sparse friendly iio_device_claim/releas=
e_direct()
      iio: adc: ad7606: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad7791: Factor out core of ad7791_write_raw() to simplify e=
rror handling
      iio: adc: ad7791: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad7793: Factor out core of ad7793_write_raw() to simplify e=
rror handling
      iio: adc: ad7793: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad799x: Switch to sparse friendly iio_device_claim/release_=
direct()
      iio: adc: ad_sigma_delta: Switch to sparse friendly iio_device_claim/=
release_direct()
      iio: adc: at91-sama5d2: Move claim of direct mode up a level and use =
guard()
      iio: adc: at91-sama5d2: Switch to sparse friendly iio_device_claim/re=
lease_direct()
      iio: adc: max1027: Move claim of direct mode up one level and use gua=
rd()
      iio: adc: max1027: Switch to sparse friendly iio_device_claim/release=
_direct()
      iio: adc: max11410: Factor out writing of sampling frequency to simpl=
ify errro paths.
      iio: adc: max11410: Switch to sparse friendly iio_device_claim/releas=
e_direct()
      iio: adc: Switch to sparse friendly iio_device_claim/release_direct()
      staging: iio: accel: adis16240: Drop driver for this impact sensor

Jonathan Santos (3):
      iio: adc: ad7768-1: set MOSI idle state to prevent accidental reset
      Documentation: ABI: add wideband filter type to sysfs-bus-iio
      iio: adc: ad7768-1: remove unnecessary locking

Julien Stephan (8):
      iio: adc: ad7380: do not use iio_device_claim_direct_scoped anymore
      iio: adc: ad7380: enable regmap cache
      iio: adc: ad7380: do not store osr in private data structure
      iio: adc: ad7380: add alert support
      docs: iio: ad7380: add alert support
      iio: adc: ad7380: add adaq4381-4 support
      dt-bindings: iio: adc: ad7380: add adaq4381-4 compatible parts
      docs: iio: ad7380: add adaq4381-4

Jun Yan (2):
      iio: gyro: bmg160_i2c: add BMI088 to of_match_table
      iio: gyro: bmg160_spi: add of_match_table

Karan Sanghavi (1):
      iio: light: Add check for array bounds in veml6075_read_int_time_ms

Kever Yang (1):
      dt-bindings: iio: adc: Add rockchip,rk3562-saradc string

Krzysztof Kozlowski (2):
      dt-bindings: iio: Correct indentation and style in DTS example
      iio: Use str_enable_disable-like helpers

Lothar Rubusch (4):
      docs: iio: fix wrong driver name in documentation
      iio: accel: adxl345: reorganize measurement enable
      iio: accel: adxl345: add debug register access
      iio: accel: adxl345: reorganize irq handler

Marcelo Schmitt (4):
      Documentation: ABI: IIO: Add filter_type documentation
      Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
      iio: adc: ad4130: Add filter_type attributes
      Documentation: iio: Add ADC documentation

Matti Vaittinen (3):
      iio: gts: Simplify available scale table build
      iio: adc: Include cleanup.h when using guard()
      iio: adc: ti-ads7924 Drop unnecessary function parameters

Mikael Gonella-Bolduc (2):
      dt-bindings: iio: light: Add APDS9160 binding
      iio: light: Add APDS9160 ALS & Proximity sensor driver

Nuno S=C3=A1 (3):
      iio: backend: make sure to NULL terminate stack buffer
      iio: core: make use of simple_write_to_buffer()
      iio: adc: adi-axi-adc: replace of.h with mod_devicetable.h

Rob Herring (Arm) (1):
      iio: adc: stm32: Drop unnecessary DT property presence check

Robert Budai (6):
      iio: imu: adis: Add custom ops struct
      iio: imu: adis: Add reset to custom ops
      iio: imu: adis: Add DIAG_STAT register
      dt-bindings: iio: Add adis16550 bindings
      iio: imu: adis16550: add adis16550 support
      docs: iio: add documentation for adis16550 driver

Saalim Quadri (2):
      staging: iio: ad9832: Use devm_regulator_get_enable()
      staging: iio: ad9834: Use devm_regulator_get_enable()

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Simon Xue (1):
      iio: adc: rockchip_saradc: add rk3562

Svyatoslav Ryhel (2):
      dt-bindings: iio: light: al3010: add al3000a support
      iio: light: Add support for AL3000a illuminance sensor

Tobias Sperling (2):
      dt-bindings: iio: adc: Introduce ADS7138
      iio: adc: Add driver for ADS7128 / ADS7138

Trevor Gamblin (5):
      iio: adc: ad7625: drop BSD license tag
      iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
      iio: adc: ad4695: add custom regmap bus callbacks
      iio: adc: ad4695: add offload-based oversampling support
      doc: iio: ad4695: describe oversampling support

Uwe Kleine-K=C3=B6nig (13):
      iio: adc: ad7124: Micro-optimize channel disabling
      iio: adc: ad7124: Really disable all channels at probe time
      iio: adc: ad7173: Grab direct mode for calibration
      iio: adc: ad7192: Grab direct mode for calibration
      iio: adc: ad_sigma_delta: Disable channel after calibration
      iio: adc: ad4130: Fix comparison of channel setups
      iio: adc: ad7124: Fix comparison of channel configs
      iio: adc: ad7173: Fix comparison of channel configs
      iio: adc: ad4130: Adapt internal names to match official filter_type =
ABI
      iio: adc: ad_sigma_delta: Add error checking for ad_sigma_delta_set_c=
hannel()
      iio: adc: ad7124: Implement internal calibration at probe time
      iio: adc: ad7124: Implement system calibration
      iio: adc: ad7124: Benefit of dev =3D indio_dev->dev.parent in ad7124_=
parse_channel_config()

Vasiliy Doylov (5):
      dt-bindings: iio: accel: mc3230: document mc3510c
      iio: accel: mc3230: add mount matrix support
      iio: accel: mc3230: add OF match table
      iio: accel: mc3230: add multiple devices support
      iio: accel: mc3230: add mc3510c support

sunliming (1):
      iio: imu: adis: fix uninitialized symbol warning

 Documentation/ABI/testing/sysfs-bus-iio            |   12 +-
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |   20 +
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  110 ++
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |   13 +
 .../devicetree/bindings/iio/adc/adi,ad4851.yaml    |  153 ++
 .../devicetree/bindings/iio/adc/adi,ad7191.yaml    |  149 ++
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |    4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   72 +-
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml |    9 +-
 .../bindings/iio/adc/rockchip-saradc.yaml          |    2 +
 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    |   63 +
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |   18 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    5 +-
 .../bindings/iio/humidity/sciosense,ens210.yaml    |   12 +-
 .../devicetree/bindings/iio/imu/adi,adis16550.yaml |   74 +
 .../bindings/iio/light/brcm,apds9160.yaml          |   78 +
 .../bindings/iio/light/dynaimage,al3010.yaml       |    6 +-
 .../bindings/iio/magnetometer/silabs,si7210.yaml   |   48 +
 .../bindings/iio/temperature/maxim,max31865.yaml   |   20 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |    6 +-
 .../bindings/trigger-source/pwm-trigger.yaml       |   37 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 Documentation/iio/ad4030.rst                       |  180 +++
 Documentation/iio/ad4695.rst                       |  104 +-
 Documentation/iio/ad7191.rst                       |  119 ++
 Documentation/iio/ad7380.rst                       |   56 +-
 Documentation/iio/ad7944.rst                       |   24 +-
 Documentation/iio/adis16550.rst                    |  376 +++++
 Documentation/iio/adxl380.rst                      |    2 +-
 Documentation/iio/iio_adc.rst                      |  305 ++++
 Documentation/iio/index.rst                        |    4 +
 MAINTAINERS                                        |   51 +-
 drivers/iio/accel/adxl345.h                        |    1 -
 drivers/iio/accel/adxl345_core.c                   |   78 +-
 drivers/iio/accel/adxl367.c                        |  194 +--
 drivers/iio/accel/adxl372.c                        |    7 +-
 drivers/iio/accel/adxl380.c                        |    7 +-
 drivers/iio/accel/bma180.c                         |    7 +-
 drivers/iio/accel/bma400_core.c                    |    2 +-
 drivers/iio/accel/bmi088-accel-core.c              |    9 +-
 drivers/iio/accel/fxls8962af-core.c                |   21 +-
 drivers/iio/accel/kionix-kx022a.c                  |   78 +-
 drivers/iio/accel/mc3230.c                         |   95 +-
 drivers/iio/accel/mma8452.c                        |   86 +-
 drivers/iio/accel/msa311.c                         |   34 +-
 drivers/iio/adc/Kconfig                            |   56 +-
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/ad4000.c                           |   60 +-
 drivers/iio/adc/ad4030.c                           | 1230 +++++++++++++++
 drivers/iio/adc/ad4130.c                           |  139 +-
 drivers/iio/adc/ad4695.c                           | 1094 ++++++++++++--
 drivers/iio/adc/ad4851.c                           | 1315 ++++++++++++++++
 drivers/iio/adc/ad7091r-base.c                     |    1 +
 drivers/iio/adc/ad7124.c                           |  343 ++++-
 drivers/iio/adc/ad7173.c                           |  791 ++++++----
 drivers/iio/adc/ad7191.c                           |  554 +++++++
 drivers/iio/adc/ad7192.c                           |  124 +-
 drivers/iio/adc/ad7266.c                           |    7 +-
 drivers/iio/adc/ad7298.c                           |    7 +-
 drivers/iio/adc/ad7380.c                           |  917 +++++++++--
 drivers/iio/adc/ad7476.c                           |    7 +-
 drivers/iio/adc/ad7606.c                           |  174 ++-
 drivers/iio/adc/ad7606.h                           |  103 +-
 drivers/iio/adc/ad7606_bus_iface.h                 |   16 +
 drivers/iio/adc/ad7606_par.c                       |   52 +-
 drivers/iio/adc/ad7606_spi.c                       |  137 +-
 drivers/iio/adc/ad7625.c                           |   13 +-
 drivers/iio/adc/ad7768-1.c                         |   47 +-
 drivers/iio/adc/ad7779.c                           |  101 +-
 drivers/iio/adc/ad7791.c                           |   31 +-
 drivers/iio/adc/ad7793.c                           |   80 +-
 drivers/iio/adc/ad7887.c                           |    7 +-
 drivers/iio/adc/ad7923.c                           |    7 +-
 drivers/iio/adc/ad7944.c                           |  314 +++-
 drivers/iio/adc/ad799x.c                           |   14 +-
 drivers/iio/adc/ad9467.c                           |   23 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   24 +-
 drivers/iio/adc/adi-axi-adc.c                      |  305 +++-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   54 +-
 drivers/iio/adc/dln2-adc.c                         |    7 +-
 drivers/iio/adc/max1027.c                          |   37 +-
 drivers/iio/adc/max11410.c                         |   72 +-
 drivers/iio/adc/max1363.c                          |  165 +-
 drivers/iio/adc/max34408.c                         |    1 +
 drivers/iio/adc/pac1921.c                          |    1 +
 drivers/iio/adc/rockchip_saradc.c                  |   42 +-
 drivers/iio/adc/rtq6056.c                          |   46 +-
 drivers/iio/adc/stm32-adc-core.c                   |    6 +-
 drivers/iio/adc/stm32-adc.c                        |    7 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   76 +-
 drivers/iio/adc/ti-adc084s021.c                    |    9 +-
 drivers/iio/adc/ti-adc108s102.c                    |    7 +-
 drivers/iio/adc/ti-adc161s626.c                    |   14 +-
 drivers/iio/adc/ti-ads1119.c                       |   17 +-
 drivers/iio/adc/ti-ads124s08.c                     |    2 +-
 drivers/iio/adc/ti-ads1298.c                       |    7 +-
 drivers/iio/adc/ti-ads131e08.c                     |   14 +-
 drivers/iio/adc/ti-ads7138.c                       |  749 +++++++++
 drivers/iio/adc/ti-ads7924.c                       |    7 +-
 drivers/iio/adc/ti-tlc4541.c                       |    7 +-
 drivers/iio/addac/ad74413r.c                       |   14 +-
 drivers/iio/amplifiers/hmc425a.c                   |    3 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |    4 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  144 +-
 drivers/iio/chemical/ens160_core.c                 |   32 +-
 drivers/iio/chemical/scd30_core.c                  |   70 +-
 drivers/iio/common/cros_ec_sensors/Makefile        |    3 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    9 +-
 .../common/cros_ec_sensors/cros_ec_sensors_trace.c |   32 +
 .../common/cros_ec_sensors/cros_ec_sensors_trace.h |   56 +
 drivers/iio/dac/Kconfig                            |    3 +
 drivers/iio/dac/ad3552r-common.c                   |   50 +-
 drivers/iio/dac/ad3552r-hs.c                       |  333 +++-
 drivers/iio/dac/ad3552r-hs.h                       |    8 +
 drivers/iio/dac/ad3552r.c                          |   36 -
 drivers/iio/dac/ad3552r.h                          |    9 +-
 drivers/iio/dac/ad5791.c                           |  181 ++-
 drivers/iio/dac/ad8460.c                           |   18 +-
 drivers/iio/dac/adi-axi-dac.c                      |   35 +-
 drivers/iio/dummy/iio_simple_dummy.c               |  119 +-
 drivers/iio/frequency/adf4371.c                    |   45 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    1 +
 drivers/iio/gyro/bmg160_spi.c                      |   10 +
 drivers/iio/humidity/dht11.c                       |    3 +-
 drivers/iio/imu/Kconfig                            |   13 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |   35 +-
 drivers/iio/imu/adis16550.c                        | 1147 ++++++++++++++
 drivers/iio/imu/bmi270/bmi270.h                    |   17 +-
 drivers/iio/imu/bmi270/bmi270_core.c               |  374 ++++-
 drivers/iio/imu/bmi323/bmi323_core.c               |   44 +-
 drivers/iio/industrialio-backend.c                 |   64 +-
 drivers/iio/industrialio-core.c                    |    9 +-
 drivers/iio/industrialio-event.c                   |    2 +
 drivers/iio/industrialio-gts-helper.c              |  283 ++--
 drivers/iio/light/Kconfig                          |   22 +
 drivers/iio/light/Makefile                         |    2 +
 drivers/iio/light/adux1020.c                       |    1 -
 drivers/iio/light/al3000a.c                        |  209 +++
 drivers/iio/light/apds9160.c                       | 1594 ++++++++++++++++=
++++
 drivers/iio/light/bh1745.c                         |   18 +-
 drivers/iio/light/cm32181.c                        |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/veml6030.c                       |  608 ++++----
 drivers/iio/light/veml6075.c                       |    8 +-
 drivers/iio/magnetometer/Kconfig                   |   11 +
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/af8133j.c                 |    1 -
 drivers/iio/magnetometer/si7210.c                  |  446 ++++++
 drivers/iio/pressure/zpa2326_i2c.c                 |    1 -
 drivers/iio/pressure/zpa2326_spi.c                 |    1 -
 drivers/iio/proximity/irsd200.c                    |    3 +-
 drivers/iio/proximity/sx9310.c                     |   19 +-
 drivers/iio/proximity/sx9324.c                     |   19 +-
 drivers/iio/proximity/sx9360.c                     |   19 +-
 drivers/iio/resolver/ad2s1210.c                    |   17 +-
 drivers/iio/temperature/tmp006.c                   |   33 +-
 drivers/spi/Kconfig                                |   15 +
 drivers/spi/Makefile                               |    4 +
 drivers/spi/spi-offload-trigger-pwm.c              |  162 ++
 drivers/spi/spi-offload.c                          |  465 ++++++
 drivers/spi/spi.c                                  |   10 +
 drivers/staging/iio/accel/Kconfig                  |   12 -
 drivers/staging/iio/accel/Makefile                 |    1 -
 drivers/staging/iio/accel/adis16240.c              |  443 ------
 drivers/staging/iio/frequency/ad9832.c             |   37 +-
 drivers/staging/iio/frequency/ad9834.c             |   22 +-
 include/dt-bindings/iio/adc/adi,ad4695.h           |    7 +
 include/linux/gpio/consumer.h                      |   11 +
 include/linux/iio/adc/ad_sigma_delta.h             |    4 +-
 include/linux/iio/backend.h                        |   19 +
 include/linux/iio/buffer-dmaengine.h               |    7 +-
 include/linux/iio/iio-gts-helper.h                 |    1 +
 include/linux/iio/iio.h                            |   41 +-
 include/linux/iio/imu/adis.h                       |   34 +-
 include/linux/spi/offload/consumer.h               |   39 +
 include/linux/spi/offload/provider.h               |   47 +
 include/linux/spi/offload/types.h                  |   99 ++
 include/linux/spi/spi.h                            |   20 +
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_event_monitor.c                      |    4 +
 181 files changed, 16873 insertions(+), 3075 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4030.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7138.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds91=
60.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/sila=
bs,si7210.yaml
 create mode 100644 Documentation/devicetree/bindings/trigger-source/pwm-tr=
igger.yaml
 create mode 100644 Documentation/iio/ad4030.rst
 create mode 100644 Documentation/iio/ad7191.rst
 create mode 100644 Documentation/iio/adis16550.rst
 create mode 100644 Documentation/iio/iio_adc.rst
 create mode 100644 drivers/iio/adc/ad4030.c
 create mode 100644 drivers/iio/adc/ad4851.c
 create mode 100644 drivers/iio/adc/ad7191.c
 create mode 100644 drivers/iio/adc/ad7606_bus_iface.h
 create mode 100644 drivers/iio/adc/ti-ads7138.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trac=
e.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trac=
e.h
 create mode 100644 drivers/iio/imu/adis16550.c
 create mode 100644 drivers/iio/light/al3000a.c
 create mode 100644 drivers/iio/light/apds9160.c
 create mode 100644 drivers/iio/magnetometer/si7210.c
 create mode 100644 drivers/spi/spi-offload-trigger-pwm.c
 create mode 100644 drivers/spi/spi-offload.c
 delete mode 100644 drivers/staging/iio/accel/adis16240.c
 create mode 100644 include/linux/spi/offload/consumer.h
 create mode 100644 include/linux/spi/offload/provider.h
 create mode 100644 include/linux/spi/offload/types.h

