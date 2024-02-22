Return-Path: <linux-iio+bounces-2916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C4860238
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 20:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA70D1F2574A
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E5D6E5FF;
	Thu, 22 Feb 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLtnpp4h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD86AF8B
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628797; cv=none; b=Q45m5DuG11DMNssFDwnc1XLWhwsAnjd8CKHxy6upi9h6zT9NfEANNmQ8xdzPL3YT65nJ01gkvQNQ+DLmV62z65AaY5KlD1g1iwj4dgeTIwYJk5071+89AYCS3pkjGJugy5xr8BhXC6WG4SnOPKyfmKApZbqvNaNsS6w+nn5nDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628797; c=relaxed/simple;
	bh=azGVtbj0Pqd5zw73+UI/1irNFNvcKv0rAGPQ1/CNEmw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VipZm0xGidu5B9MU/PQ+7JWCcWs9MW3rPudqkZwJyl9gzjiK6bqbNV3yOAInc6HmbWIXsz0EKiM1L1Ybl2pv4MEpL3Jk56twbUETOzBEQtw+7PWkdLaYMYNOHa/4yg/Uh7ugUDBw1ClGX/MTlpAE1SgKDqsTl5enJT8nqTkXhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLtnpp4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E37CC433C7;
	Thu, 22 Feb 2024 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708628796;
	bh=azGVtbj0Pqd5zw73+UI/1irNFNvcKv0rAGPQ1/CNEmw=;
	h=Date:From:To:Subject:From;
	b=jLtnpp4hL+iXec4Buy4APpu1d+nCjxgdHssUKBhd7y9/nFXUZ8fXDEv3b+sZBRV3a
	 n1+fJ+29fHYVGbVih667PMVcPKBbGYehzA7pJ5ZJ2gWDe4GHOaxBwkBZibJF7xm3gP
	 rhRhXtO4fzPfh2AL3AO0ovGeeCbZgNNwAUX+8lOknZ8FN0ga8NiUCmLQRteUxxhUak
	 jCBW2sJs5OCEoxjgKAvUyu/eXOPXUBCplaHT57JFVKwhoEkaTp6YiQUuLw71G4qkVV
	 2uOv8V6t/UptM+uytdCJqW5qzAIfR/q+bAM5ZBELFdkEiboB+83cCFWiwbpALwp9XN
	 MYewDWc+Edbwg==
Date: Thu, 22 Feb 2024 19:06:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support, features and cleanup
 for 6.9
Message-ID: <20240222190623.44f36707@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.9a

for you to fetch changes up to 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1:

  iio: imu: bmi323: Add ACPI Match Table (2024-02-19 19:34:44 +0000)

----------------------------------------------------------------
IIO: 1st set of new device support, features and cleanup for 6.9

IIO Backend support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

New approach from Nuno Sa to the problem of reuse of drivers with
IIO devices that are actually the combination of a highspeed chip
and an FPGA core handling the data capture and flows. It will hopefully
also apply to some other split designs. The ad9467 and axi-adi drivers
are converted over to this framework.

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,admfm2000
- New driver for this dual microwave down converter.
ams,as73211
- Add support for as7331 UV sensor.
richtek,rtq6056
- Add support for related parts RTQ6053 and RTQ6059
st,lsm6dsx
- Add ASM330LHHXG1 accelerometer and gyro support (mainly IDs)
ti,ads1298
- New driver for this medical ADC.

Features
=3D=3D=3D=3D=3D=3D=3D=3D

tests
- Unit tests for the gain-time-scale helper library.
bosch,bmi088
- I2C support.
bosh,bmi160
- Add 10EC5280 ACPI ID. Used in a number of devices that won't get fixed.
  The ID is actually a PCI ID belonging to realtech. No response was receiv=
ed
  to earlier attempts to notify them of this.
  The manufacturers of some devices have replied to say they will not fix
  this incorrect ID. Add the ID and hope it isn't a problem.
bosch,bmi323
- Add BOSC0200 ACPI ID. Note this is a duplicate of one in the bmc150
  driver (it appears these parts share a windows driver).
  Both drivers perform an ID check that is safe on the other part before
  successfully probing.
hid-sensors-als
- Add color temperature and chromaticity support. Note this is a replacement
  for the series reverted in 6.8 that correctly handles all the potential
  channel combinations.
honeywell,hsc030pa
- Triggered buffer support (after driver cleanup).
honeywell,mprls00025pa
- Improved error handling.
- New DT binding to allow use of part number triplet as provided in data sh=
eet
  to specify equivalent of most of the binding more efficiently.
- SPI support.
memsic,mxc4005
- ACPI ID MDA6655 as seen in the Chuwi Minibook X 2023
ti,hdc3020
- Add threshold event support (after some driver cleanup)
veml,vcnl4000
- Switch to high resolution proximity measurement.

Cleanup
=3D=3D=3D=3D=3D=3D=3D
Various minor typo fixes and better use of defines etc.

Treewide
- Stop using ACPI_PTR(). The savings in space are small and not worth
  the complexity of __maybe_unused of ifdef guards.  To avoid use in
  new IIO drivers based on copy and paste, clean it out.
- cleanup.h based handling of iio_device_claim_direct_mode()/
  iio_device_release_direct_mode() using scope_cond_guard().
  In many drivers this is combined with other automated cleanup
  to give maximum simplifications.
  An initial set of drivers are converted over to this infrastructure.

Tools
- Use rewinddir() instead of seekdir() to return to start of file.

core
- Make iio_bus_type constant.

adi,ad16475
- Use irq_get_trigger_type() instead of opencoding.
adi,ad16480
- Use irq_get_trigger_type() instead of opencoding.
adi,ad-sigma-delta
- Avoid overwriting IRQ flags if provided by firmware.
ams,as73211
- Use IIO_VAL_FRACTIONAL for scales to simplify the code and potentially
  improve accuracy.
gts-library
- Use a div64_u64() instead of a loop to do a division.
honeywell,mprls00025pa
- Clean up dt-binding doc.
- Drop defaults when DT binding not providing values. Very unlikely
  these were useful given they were wrong for vast majority of supported
  devices.
- Whitespace cleanup
miramems,da280
- Use i2c_get_match_data() to replace hand rolled ACPI matching code.
semtech,sx9324
- Avoid unnecessary copying of property strings.
st,lsm6dsx
- Improve docs, particularly wrt to making addition of new device
  support less noisy.
st,lsm9ds0
- Use dev_err_probe() in all probe() error handling.
- Improved header includes.
- Tidy up termination of ID tables.
ti,ads1014
- Correct upper bound on PGA (wrong value had no actual impact)
ti,afe4403/4404
- devm_ useage to simplify error handling in probe() and allow() remove to
  be dropped.
voltage-divider
- Add dt-binding for io-channel-cells to allow such a device to be both
  an IIO consumer and IIO producer at the same time.

----------------------------------------------------------------
Amit Dhingra (1):
      MAINTAINERS: correct file entry for AD7091R

Andrew Davis (4):
      iio: health: afe4403: Use devm action helper for regulator disable
      iio: health: afe4403: Use devm IIO helpers
      iio: health: afe4404: Use devm action helper for regulator disable
      iio: health: afe4404: Use devm IIO helpers

Basavaraj Natikar (2):
      iio: hid-sensor-als: Add light color temperature support
      iio: hid-sensor-als: Add light chromaticity support

ChiYuan Huang (2):
      dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 fam=
ily
      iio: adc: rtq6056: Add support for the whole RTQ6056 family

Colin Ian King (1):
      iio: invensense: remove redundant initialization of variable period

David Lechner (1):
      iio: core: use INDIO_ALL_BUFFER_MODES in iio_buffer_enabled()

Dimitri Fedrau (3):
      iio: humidity: hdc3020: switch to 16bit register defines
      dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
      iio: humidity: hdc3020: add threshold events support

Hans de Goede (1):
      iio: accel: da280: Simplify id-matching

Javier Carrasco (3):
      iio: light: as73211: use IIO_VAL_FRACTIONAL for intensity scales
      dt-bindings: iio: light: as73211: add support for as7331
      iio: light: as73211: add support for as7331

Jesus Gonzalez (1):
      Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices

Jonathan Cameron (34):
      iio: accel: da280: Stop using ACPI_PTR()
      iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef CONFIG_=
ACPI
      iio: accel: mma9551: Drop ACPI_PTR() usage
      iio: accel: mma9553: Drop ACPI_PTR() usage
      iio: accel: mxc4005: Drop ACPI_PTR() usage
      iio: accel: mxc6255: Drop ACPI_PTR() usage
      iio: accel: stk8ba50: Drop ACPI_PTR() usage
      iio: accel: bmc150: Drop ACPI_PTR()
      iio: gyro: bmg160: Drop ACPI_PTR() usage
      iio: humidity: hts221: Drop ACPI_PTR() usage
      iio: imu: fxos8700: Drop ACPI_PTR() usage
      iio: imu: kmx61: Drop ACPI_PTR() usage
      iio: light: jsa1212: Drop ACPI_PTR() usage
      iio: light: ltr501: Drop ACPI_PTR() usage
      iio: light: rpr0521: Drop ACPI_PTR() usage
      iio: light: stk3310: Drop ACPI_PTR() usage
      iio: light: us5182d: Drop ACPI_PTR() usage
      iio: magnetometer: bmc150: Drop ACPI_PTR() usage
      iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
      iio: potentiometer: max5487: Drop ACPI_PTR() usage
      iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: locking: introduce __cleanup() based direct mode claiming infras=
tructure
      iio: dummy: Use automatic lock and direct mode cleanup.
      iio: accel: adxl367: Use automated cleanup for locks and iio direct m=
ode.
      iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_mo=
de()
      iio: adc: max1363: Use automatic cleanup for locks and iio mode claim=
ing.
      iio: proximity: sx9360: Use automated cleanup for locks and IIO mode =
claiming.
      iio: proximity: sx9324: Use automated cleanup for locks and IIO mode =
claiming.
      iio: proximity: sx9310: Use automated cleanup for locks and IIO mode =
claiming.
      iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
      iio: adc: ad7091r-base: Use auto cleanup of locks.

Jonathan LoBue (2):
      iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
      iio: imu: bmi323: Add ACPI Match Table

Jun Yan (1):
      iio: accel: bmi088: add i2c support for bmi088 accel driver

Justin Stitt (1):
      iio: sx9324: avoid copying property strings

Kim Seer Paller (2):
      dt-bindings: iio: frequency: add admfm2000
      iio: frequency: admfm2000: New driver

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: improve kernel docs and comments
      iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1

Matti Vaittinen (3):
      iio: test: test gain-time-scale helpers
      MAINTAINERS: add IIO GTS tests
      iio: gts-helper: Fix division loop

Mike Looijmans (2):
      dt-bindings: iio: adc: ti-ads1298: Add bindings
      iio: adc: ti-ads1298: Add driver

Mohammed Billoo (1):
      iio: adc: ti-ads1015: Use correct pga upper bound

M=C3=A5rten Lindahl (1):
      iio: light: vcnl4000: Set ps high definition for 4040/4200

Naresh Solanki (1):
      dt-bindings: iio: afe: voltage-divider: Add io-channel-cells

Nikita Mikhailevich (1):
      iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer

Nuno Sa (10):
      iio: buffer-dmaengine: make use of the 'struct device *' argument
      iio: imu: adis16475: make use of irq_get_trigger_type()
      iio: imu: adis16480: make use of irq_get_trigger_type()
      iio: adc: ad_sigma_delta: allow overwriting the IRQ flags
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: update bindings for backend framework
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

Petre Rodan (17):
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add pressure-t=
riplet
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
      iio: pressure: mprls0025pa fix off-by-one enum
      iio: pressure: mprls0025pa improve driver error resilience
      iio: pressure: mprls0025pa remove defaults
      iio: pressure: mprls0025pa whitespace cleanup
      iio: pressure: mprls0025pa refactor to split core and i2c parts.
      iio: pressure: mprls0025pa add triplet property
      iio: pressure: mprls0025pa add SPI driver
      tools: iio: replace seekdir() in iio_generic_buffer
      dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
      iio: pressure: hsc030pa: use signed type to hold div_64() result
      iio: pressure: hsc030pa: include cleanup
      iio: pressure: hsc030pa: update datasheet URLs
      iio: pressure: hsc030pa add mandatory delay
      iio: pressure: hsc030pa add triggered buffer

Randy Dunlap (1):
      iio: dummy_evgen: remove Excess kernel-doc comments

Ricardo B. Marliere (1):
      iio: core: make iio_bus_type const

Srinivas Pandruvada (2):
      iio: hid-sensor-als: Assign channels dynamically
      iio: hid-sensor-als: Remove hardcoding of values for enums

andy.shevchenko@gmail.com (3):
      iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
      iio: st_sensors: lsm9ds0: Don't use "proxy" headers
      iio: st_sensors: lsm9ds0: Use common style for terminator in ID tables

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   8 +-
 .../bindings/iio/adc/richtek,rtq6056.yaml          |   9 +-
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |  80 +++
 .../bindings/iio/afe/voltage-divider.yaml          |  11 +
 .../bindings/iio/frequency/adi,admfm2000.yaml      | 127 ++++
 .../bindings/iio/humidity/ti,hdc3020.yaml          |   3 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   4 +-
 .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
 .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |   3 +
 .../iio/pressure/honeywell,mprls0025pa.yaml        |  98 ++-
 MAINTAINERS                                        |  22 +-
 drivers/iio/Kconfig                                |   9 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |   8 +-
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl367.c                        | 297 ++++----
 drivers/iio/accel/bmc150-accel-i2c.c               |  15 +-
 drivers/iio/accel/bmc150-accel-spi.c               |   3 +-
 drivers/iio/accel/bmi088-accel-i2c.c               |  70 ++
 drivers/iio/accel/da280.c                          |  66 +-
 drivers/iio/accel/kxcjk-1013.c                     |  33 +-
 drivers/iio/accel/mma9551.c                        |   4 +-
 drivers/iio/accel/mma9553.c                        |   4 +-
 drivers/iio/accel/mxc4005.c                        |   5 +-
 drivers/iio/accel/mxc6255.c                        |   4 +-
 drivers/iio/accel/st_accel_i2c.c                   |   5 +-
 drivers/iio/accel/stk8ba50.c                       |   4 +-
 drivers/iio/adc/Kconfig                            |  15 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad4130.c                           | 131 ++--
 drivers/iio/adc/ad7091r-base.c                     |  25 +-
 drivers/iio/adc/ad9467.c                           | 267 ++++---
 drivers/iio/adc/ad_sigma_delta.c                   |   7 +-
 drivers/iio/adc/adi-axi-adc.c                      | 385 +++--------
 drivers/iio/adc/max1363.c                          | 171 +++--
 drivers/iio/adc/rtq6056.c                          | 275 +++++++-
 drivers/iio/adc/ti-adc108s102.c                    |   4 +-
 drivers/iio/adc/ti-ads1015.c                       |   2 +-
 drivers/iio/adc/ti-ads1298.c                       | 769 +++++++++++++++++=
++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  11 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |   2 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |   2 -
 drivers/iio/dummy/iio_simple_dummy.c               | 185 +++--
 drivers/iio/frequency/Kconfig                      |  10 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/admfm2000.c                  | 282 ++++++++
 drivers/iio/gyro/bmg160_i2c.c                      |   4 +-
 drivers/iio/health/afe4403.c                       |  65 +-
 drivers/iio/health/afe4404.c                       |  65 +-
 drivers/iio/humidity/hdc3020.c                     | 445 ++++++++----
 drivers/iio/humidity/hts221_i2c.c                  |   4 +-
 drivers/iio/imu/adis16475.c                        |   8 +-
 drivers/iio/imu/adis16480.c                        |   9 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   9 +
 drivers/iio/imu/bmi323/bmi323_core.c               |  78 +--
 drivers/iio/imu/bmi323/bmi323_i2c.c                |  21 +
 drivers/iio/imu/fxos8700_i2c.c                     |   3 +-
 drivers/iio/imu/fxos8700_spi.c                     |   3 +-
 drivers/iio/imu/kmx61.c                            |   2 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  31 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  28 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  33 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |   5 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  21 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   6 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   4 +-
 drivers/iio/industrialio-backend.c                 | 418 +++++++++++
 drivers/iio/industrialio-core.c                    |   6 +-
 drivers/iio/industrialio-gts-helper.c              |  15 +-
 drivers/iio/light/Kconfig                          |   5 +-
 drivers/iio/light/as73211.c                        | 142 +++-
 drivers/iio/light/hid-sensor-als.c                 | 122 +++-
 drivers/iio/light/jsa1212.c                        |   4 +-
 drivers/iio/light/ltr501.c                         |   3 +-
 drivers/iio/light/max44000.c                       |   6 +-
 drivers/iio/light/rpr0521.c                        |   4 +-
 drivers/iio/light/stk3310.c                        |   4 +-
 drivers/iio/light/us5182d.c                        |   4 +-
 drivers/iio/light/vcnl4000.c                       |  36 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   3 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c         |   3 +-
 drivers/iio/magnetometer/mmc35240.c                |   4 +-
 drivers/iio/potentiometer/max5487.c                |   4 +-
 drivers/iio/pressure/Kconfig                       |  16 +-
 drivers/iio/pressure/Makefile                      |   2 +
 drivers/iio/pressure/hp206c.c                      |   6 +-
 drivers/iio/pressure/hsc030pa.c                    |  49 +-
 drivers/iio/pressure/hsc030pa.h                    |   7 +
 drivers/iio/pressure/hsc030pa_i2c.c                |   9 +-
 drivers/iio/pressure/hsc030pa_spi.c                |   7 +-
 drivers/iio/pressure/mprls0025pa.c                 | 313 ++++-----
 drivers/iio/pressure/mprls0025pa.h                 | 102 +++
 drivers/iio/pressure/mprls0025pa_i2c.c             | 100 +++
 drivers/iio/pressure/mprls0025pa_spi.c             |  92 +++
 drivers/iio/pressure/st_pressure_i2c.c             |   5 +-
 drivers/iio/proximity/sx9310.c                     | 114 ++-
 drivers/iio/proximity/sx9324.c                     | 178 +++--
 drivers/iio/proximity/sx9360.c                     | 115 ++-
 drivers/iio/test/Kconfig                           |  14 +
 drivers/iio/test/Makefile                          |   1 +
 drivers/iio/test/iio-test-gts.c                    | 513 ++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/hid-sensor-ids.h                     |   4 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 --
 include/linux/iio/backend.h                        |  72 ++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 include/linux/iio/iio.h                            |  30 +-
 tools/iio/iio_utils.c                              |   2 +-
 112 files changed, 5038 insertions(+), 1875 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adm=
fm2000.yaml
 create mode 100644 drivers/iio/accel/bmi088-accel-i2c.c
 create mode 100644 drivers/iio/adc/ti-ads1298.c
 create mode 100644 drivers/iio/frequency/admfm2000.c
 create mode 100644 drivers/iio/industrialio-backend.c
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c
 create mode 100644 drivers/iio/test/iio-test-gts.c
 delete mode 100644 include/linux/iio/adc/adi-axi-adc.h
 create mode 100644 include/linux/iio/backend.h

