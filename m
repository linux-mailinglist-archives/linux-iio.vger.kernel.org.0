Return-Path: <linux-iio+bounces-2917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C192C8602F6
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87388B21F0C
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DC14B838;
	Thu, 22 Feb 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYR3xab3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B614B832
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629223; cv=none; b=Yi0zizGM4Z4hBBoBsAbm8JUckSg7MFUJWC0XxRDqdpJQP6qumd99macHleSBohJIjMOVDidGAnB7WzlgAY6CUdqvC1r5bReHEBfcGGHCzFTYFNdI5JV4U0/Bzz7HYrVzfDhplCaONeJqgwfgH+u9zfJEv5KR5bTBKcqmxPeP8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629223; c=relaxed/simple;
	bh=DD80+qruWl08px2ct5KuP+5T66CVp+CX4dgDxR/MpIA=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxJ9hsP+XKn6kYFyzdOXIAu8AQHUzUtXk1lSqiRNv5W4ZjbXzZFk4yiIyHqU2p1/eGDUCincnj2Ab7o93MG9l6f6OSwc71MJlHqC2kNLBB4jp7BOVNRrsXYsZtKBR2yCXUipU4dNxEeXHnvXjFlH2ffz3U6PpvpAc1B4gNLKnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYR3xab3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A81C433F1;
	Thu, 22 Feb 2024 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629223;
	bh=DD80+qruWl08px2ct5KuP+5T66CVp+CX4dgDxR/MpIA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=jYR3xab3p7Y4UJ8HMLbquKgknTgkLl5xEQumCT8CHxcgx0WZULQKXYvsXy4b8vwye
	 p9Ux9DMoq7YxPvcFkqZNq37IEwxg9UJR107Jp5B/d5zdNSs0lLSD1EArV54rNr7gHd
	 TAfpZurK1EI8s0BPmC5lL/e0w7z5pubsHRi9q/Ti6OckwMDexnFQYfUIVq+fm0Pou7
	 t9M22sa5FoxNW3yt8I/4u1mOoE/kFDBT3VDPriFUcZjEFKt/quwQY8gIQJZFuXuo+3
	 WLbC4oYgbe7rRE2a+RfVC9td2cRgGdj+kNuzKbgCsLK7ZFmdn6qWX6IMiMEtLNvkDS
	 ecje7IALVfujw==
Date: Thu, 22 Feb 2024 19:13:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features and
 cleanup for 6.9
Message-ID: <20240222191331.75b32286@jic23-huawei>
In-Reply-To: <20240222190623.44f36707@jic23-huawei>
References: <20240222190623.44f36707@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 19:06:23 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>=20
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-=
for-6.9a
>=20
> for you to fetch changes up to 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1:
>=20
>   iio: imu: bmi323: Add ACPI Match Table (2024-02-19 19:34:44 +0000)
>=20
Hi Greg,

There is a small conflict in here due to racing with a fix that went
through the dt tree.

Stephen has been carrying a fix up in linux-next which resolves it as expec=
ted.

https://lore.kernel.org/linux-next/20240219143945.1460f25f@canb.auug.org.au/

Thanks,

Jonathan

> ----------------------------------------------------------------
> IIO: 1st set of new device support, features and cleanup for 6.9
>=20
> IIO Backend support
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> New approach from Nuno Sa to the problem of reuse of drivers with
> IIO devices that are actually the combination of a highspeed chip
> and an FPGA core handling the data capture and flows. It will hopefully
> also apply to some other split designs. The ad9467 and axi-adi drivers
> are converted over to this framework.
>=20
> New device support
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> adi,admfm2000
> - New driver for this dual microwave down converter.
> ams,as73211
> - Add support for as7331 UV sensor.
> richtek,rtq6056
> - Add support for related parts RTQ6053 and RTQ6059
> st,lsm6dsx
> - Add ASM330LHHXG1 accelerometer and gyro support (mainly IDs)
> ti,ads1298
> - New driver for this medical ADC.
>=20
> Features
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> tests
> - Unit tests for the gain-time-scale helper library.
> bosch,bmi088
> - I2C support.
> bosh,bmi160
> - Add 10EC5280 ACPI ID. Used in a number of devices that won't get fixed.
>   The ID is actually a PCI ID belonging to realtech. No response was rece=
ived
>   to earlier attempts to notify them of this.
>   The manufacturers of some devices have replied to say they will not fix
>   this incorrect ID. Add the ID and hope it isn't a problem.
> bosch,bmi323
> - Add BOSC0200 ACPI ID. Note this is a duplicate of one in the bmc150
>   driver (it appears these parts share a windows driver).
>   Both drivers perform an ID check that is safe on the other part before
>   successfully probing.
> hid-sensors-als
> - Add color temperature and chromaticity support. Note this is a replacem=
ent
>   for the series reverted in 6.8 that correctly handles all the potential
>   channel combinations.
> honeywell,hsc030pa
> - Triggered buffer support (after driver cleanup).
> honeywell,mprls00025pa
> - Improved error handling.
> - New DT binding to allow use of part number triplet as provided in data =
sheet
>   to specify equivalent of most of the binding more efficiently.
> - SPI support.
> memsic,mxc4005
> - ACPI ID MDA6655 as seen in the Chuwi Minibook X 2023
> ti,hdc3020
> - Add threshold event support (after some driver cleanup)
> veml,vcnl4000
> - Switch to high resolution proximity measurement.
>=20
> Cleanup
> =3D=3D=3D=3D=3D=3D=3D
> Various minor typo fixes and better use of defines etc.
>=20
> Treewide
> - Stop using ACPI_PTR(). The savings in space are small and not worth
>   the complexity of __maybe_unused of ifdef guards.  To avoid use in
>   new IIO drivers based on copy and paste, clean it out.
> - cleanup.h based handling of iio_device_claim_direct_mode()/
>   iio_device_release_direct_mode() using scope_cond_guard().
>   In many drivers this is combined with other automated cleanup
>   to give maximum simplifications.
>   An initial set of drivers are converted over to this infrastructure.
>=20
> Tools
> - Use rewinddir() instead of seekdir() to return to start of file.
>=20
> core
> - Make iio_bus_type constant.
>=20
> adi,ad16475
> - Use irq_get_trigger_type() instead of opencoding.
> adi,ad16480
> - Use irq_get_trigger_type() instead of opencoding.
> adi,ad-sigma-delta
> - Avoid overwriting IRQ flags if provided by firmware.
> ams,as73211
> - Use IIO_VAL_FRACTIONAL for scales to simplify the code and potentially
>   improve accuracy.
> gts-library
> - Use a div64_u64() instead of a loop to do a division.
> honeywell,mprls00025pa
> - Clean up dt-binding doc.
> - Drop defaults when DT binding not providing values. Very unlikely
>   these were useful given they were wrong for vast majority of supported
>   devices.
> - Whitespace cleanup
> miramems,da280
> - Use i2c_get_match_data() to replace hand rolled ACPI matching code.
> semtech,sx9324
> - Avoid unnecessary copying of property strings.
> st,lsm6dsx
> - Improve docs, particularly wrt to making addition of new device
>   support less noisy.
> st,lsm9ds0
> - Use dev_err_probe() in all probe() error handling.
> - Improved header includes.
> - Tidy up termination of ID tables.
> ti,ads1014
> - Correct upper bound on PGA (wrong value had no actual impact)
> ti,afe4403/4404
> - devm_ useage to simplify error handling in probe() and allow() remove to
>   be dropped.
> voltage-divider
> - Add dt-binding for io-channel-cells to allow such a device to be both
>   an IIO consumer and IIO producer at the same time.
>=20
> ----------------------------------------------------------------
> Amit Dhingra (1):
>       MAINTAINERS: correct file entry for AD7091R
>=20
> Andrew Davis (4):
>       iio: health: afe4403: Use devm action helper for regulator disable
>       iio: health: afe4403: Use devm IIO helpers
>       iio: health: afe4404: Use devm action helper for regulator disable
>       iio: health: afe4404: Use devm IIO helpers
>=20
> Basavaraj Natikar (2):
>       iio: hid-sensor-als: Add light color temperature support
>       iio: hid-sensor-als: Add light chromaticity support
>=20
> ChiYuan Huang (2):
>       dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 f=
amily
>       iio: adc: rtq6056: Add support for the whole RTQ6056 family
>=20
> Colin Ian King (1):
>       iio: invensense: remove redundant initialization of variable period
>=20
> David Lechner (1):
>       iio: core: use INDIO_ALL_BUFFER_MODES in iio_buffer_enabled()
>=20
> Dimitri Fedrau (3):
>       iio: humidity: hdc3020: switch to 16bit register defines
>       dt-bindings: iio: humidity: hdc3020: add interrupt bindings in exam=
ple
>       iio: humidity: hdc3020: add threshold events support
>=20
> Hans de Goede (1):
>       iio: accel: da280: Simplify id-matching
>=20
> Javier Carrasco (3):
>       iio: light: as73211: use IIO_VAL_FRACTIONAL for intensity scales
>       dt-bindings: iio: light: as73211: add support for as7331
>       iio: light: as73211: add support for as7331
>=20
> Jesus Gonzalez (1):
>       Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices
>=20
> Jonathan Cameron (34):
>       iio: accel: da280: Stop using ACPI_PTR()
>       iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef CONFI=
G_ACPI
>       iio: accel: mma9551: Drop ACPI_PTR() usage
>       iio: accel: mma9553: Drop ACPI_PTR() usage
>       iio: accel: mxc4005: Drop ACPI_PTR() usage
>       iio: accel: mxc6255: Drop ACPI_PTR() usage
>       iio: accel: stk8ba50: Drop ACPI_PTR() usage
>       iio: accel: bmc150: Drop ACPI_PTR()
>       iio: gyro: bmg160: Drop ACPI_PTR() usage
>       iio: humidity: hts221: Drop ACPI_PTR() usage
>       iio: imu: fxos8700: Drop ACPI_PTR() usage
>       iio: imu: kmx61: Drop ACPI_PTR() usage
>       iio: light: jsa1212: Drop ACPI_PTR() usage
>       iio: light: ltr501: Drop ACPI_PTR() usage
>       iio: light: rpr0521: Drop ACPI_PTR() usage
>       iio: light: stk3310: Drop ACPI_PTR() usage
>       iio: light: us5182d: Drop ACPI_PTR() usage
>       iio: magnetometer: bmc150: Drop ACPI_PTR() usage
>       iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
>       iio: potentiometer: max5487: Drop ACPI_PTR() usage
>       iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
>       iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
>       iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
>       iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
>       iio: locking: introduce __cleanup() based direct mode claiming infr=
astructure
>       iio: dummy: Use automatic lock and direct mode cleanup.
>       iio: accel: adxl367: Use automated cleanup for locks and iio direct=
 mode.
>       iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_=
mode()
>       iio: adc: max1363: Use automatic cleanup for locks and iio mode cla=
iming.
>       iio: proximity: sx9360: Use automated cleanup for locks and IIO mod=
e claiming.
>       iio: proximity: sx9324: Use automated cleanup for locks and IIO mod=
e claiming.
>       iio: proximity: sx9310: Use automated cleanup for locks and IIO mod=
e claiming.
>       iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
>       iio: adc: ad7091r-base: Use auto cleanup of locks.
>=20
> Jonathan LoBue (2):
>       iio: accel: bmc150: Document duplicate ACPI entries with bmi323 dri=
ver
>       iio: imu: bmi323: Add ACPI Match Table
>=20
> Jun Yan (1):
>       iio: accel: bmi088: add i2c support for bmi088 accel driver
>=20
> Justin Stitt (1):
>       iio: sx9324: avoid copying property strings
>=20
> Kim Seer Paller (2):
>       dt-bindings: iio: frequency: add admfm2000
>       iio: frequency: admfm2000: New driver
>=20
> Lorenzo Bianconi (3):
>       iio: imu: st_lsm6dsx: improve kernel docs and comments
>       iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
>       dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
>=20
> Matti Vaittinen (3):
>       iio: test: test gain-time-scale helpers
>       MAINTAINERS: add IIO GTS tests
>       iio: gts-helper: Fix division loop
>=20
> Mike Looijmans (2):
>       dt-bindings: iio: adc: ti-ads1298: Add bindings
>       iio: adc: ti-ads1298: Add driver
>=20
> Mohammed Billoo (1):
>       iio: adc: ti-ads1015: Use correct pga upper bound
>=20
> M=C3=A5rten Lindahl (1):
>       iio: light: vcnl4000: Set ps high definition for 4040/4200
>=20
> Naresh Solanki (1):
>       dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
>=20
> Nikita Mikhailevich (1):
>       iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer
>=20
> Nuno Sa (10):
>       iio: buffer-dmaengine: make use of the 'struct device *' argument
>       iio: imu: adis16475: make use of irq_get_trigger_type()
>       iio: imu: adis16480: make use of irq_get_trigger_type()
>       iio: adc: ad_sigma_delta: allow overwriting the IRQ flags
>       dt-bindings: adc: ad9467: add new io-backend property
>       dt-bindings: adc: axi-adc: update bindings for backend framework
>       iio: buffer-dmaengine: export buffer alloc and free functions
>       iio: add the IIO backend framework
>       iio: adc: ad9467: convert to backend framework
>       iio: adc: adi-axi-adc: move to backend framework
>=20
> Olivier Moysan (1):
>       of: property: add device link support for io-backends
>=20
> Petre Rodan (17):
>       dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
>       dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add pressure=
-triplet
>       dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
>       iio: pressure: mprls0025pa fix off-by-one enum
>       iio: pressure: mprls0025pa improve driver error resilience
>       iio: pressure: mprls0025pa remove defaults
>       iio: pressure: mprls0025pa whitespace cleanup
>       iio: pressure: mprls0025pa refactor to split core and i2c parts.
>       iio: pressure: mprls0025pa add triplet property
>       iio: pressure: mprls0025pa add SPI driver
>       tools: iio: replace seekdir() in iio_generic_buffer
>       dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
>       iio: pressure: hsc030pa: use signed type to hold div_64() result
>       iio: pressure: hsc030pa: include cleanup
>       iio: pressure: hsc030pa: update datasheet URLs
>       iio: pressure: hsc030pa add mandatory delay
>       iio: pressure: hsc030pa add triggered buffer
>=20
> Randy Dunlap (1):
>       iio: dummy_evgen: remove Excess kernel-doc comments
>=20
> Ricardo B. Marliere (1):
>       iio: core: make iio_bus_type const
>=20
> Srinivas Pandruvada (2):
>       iio: hid-sensor-als: Assign channels dynamically
>       iio: hid-sensor-als: Remove hardcoding of values for enums
>=20
> andy.shevchenko@gmail.com (3):
>       iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
>       iio: st_sensors: lsm9ds0: Don't use "proxy" headers
>       iio: st_sensors: lsm9ds0: Use common style for terminator in ID tab=
les
>=20
>  .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   8 +-
>  .../bindings/iio/adc/richtek,rtq6056.yaml          |   9 +-
>  .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |  80 +++
>  .../bindings/iio/afe/voltage-divider.yaml          |  11 +
>  .../bindings/iio/frequency/adi,admfm2000.yaml      | 127 ++++
>  .../bindings/iio/humidity/ti,hdc3020.yaml          |   3 +
>  .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   4 +-
>  .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
>  .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |   3 +
>  .../iio/pressure/honeywell,mprls0025pa.yaml        |  98 ++-
>  MAINTAINERS                                        |  22 +-
>  drivers/iio/Kconfig                                |   9 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/accel/Kconfig                          |   8 +-
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/adxl367.c                        | 297 ++++----
>  drivers/iio/accel/bmc150-accel-i2c.c               |  15 +-
>  drivers/iio/accel/bmc150-accel-spi.c               |   3 +-
>  drivers/iio/accel/bmi088-accel-i2c.c               |  70 ++
>  drivers/iio/accel/da280.c                          |  66 +-
>  drivers/iio/accel/kxcjk-1013.c                     |  33 +-
>  drivers/iio/accel/mma9551.c                        |   4 +-
>  drivers/iio/accel/mma9553.c                        |   4 +-
>  drivers/iio/accel/mxc4005.c                        |   5 +-
>  drivers/iio/accel/mxc6255.c                        |   4 +-
>  drivers/iio/accel/st_accel_i2c.c                   |   5 +-
>  drivers/iio/accel/stk8ba50.c                       |   4 +-
>  drivers/iio/adc/Kconfig                            |  15 +-
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ad4130.c                           | 131 ++--
>  drivers/iio/adc/ad7091r-base.c                     |  25 +-
>  drivers/iio/adc/ad9467.c                           | 267 ++++---
>  drivers/iio/adc/ad_sigma_delta.c                   |   7 +-
>  drivers/iio/adc/adi-axi-adc.c                      | 385 +++--------
>  drivers/iio/adc/max1363.c                          | 171 +++--
>  drivers/iio/adc/rtq6056.c                          | 275 +++++++-
>  drivers/iio/adc/ti-adc108s102.c                    |   4 +-
>  drivers/iio/adc/ti-ads1015.c                       |   2 +-
>  drivers/iio/adc/ti-ads1298.c                       | 769 +++++++++++++++=
++++++
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  11 +-
>  .../iio/common/inv_sensors/inv_sensors_timestamp.c |   2 +-
>  drivers/iio/dummy/iio_dummy_evgen.c                |   2 -
>  drivers/iio/dummy/iio_simple_dummy.c               | 185 +++--
>  drivers/iio/frequency/Kconfig                      |  10 +
>  drivers/iio/frequency/Makefile                     |   1 +
>  drivers/iio/frequency/admfm2000.c                  | 282 ++++++++
>  drivers/iio/gyro/bmg160_i2c.c                      |   4 +-
>  drivers/iio/health/afe4403.c                       |  65 +-
>  drivers/iio/health/afe4404.c                       |  65 +-
>  drivers/iio/humidity/hdc3020.c                     | 445 ++++++++----
>  drivers/iio/humidity/hts221_i2c.c                  |   4 +-
>  drivers/iio/imu/adis16475.c                        |   8 +-
>  drivers/iio/imu/adis16480.c                        |   9 +-
>  drivers/iio/imu/bmi160/bmi160_i2c.c                |   9 +
>  drivers/iio/imu/bmi323/bmi323_core.c               |  78 +--
>  drivers/iio/imu/bmi323/bmi323_i2c.c                |  21 +
>  drivers/iio/imu/fxos8700_i2c.c                     |   3 +-
>  drivers/iio/imu/fxos8700_spi.c                     |   3 +-
>  drivers/iio/imu/kmx61.c                            |   2 +-
>  drivers/iio/imu/st_lsm6dsx/Kconfig                 |  31 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  28 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  33 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |   5 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  21 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   6 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   4 +-
>  drivers/iio/industrialio-backend.c                 | 418 +++++++++++
>  drivers/iio/industrialio-core.c                    |   6 +-
>  drivers/iio/industrialio-gts-helper.c              |  15 +-
>  drivers/iio/light/Kconfig                          |   5 +-
>  drivers/iio/light/as73211.c                        | 142 +++-
>  drivers/iio/light/hid-sensor-als.c                 | 122 +++-
>  drivers/iio/light/jsa1212.c                        |   4 +-
>  drivers/iio/light/ltr501.c                         |   3 +-
>  drivers/iio/light/max44000.c                       |   6 +-
>  drivers/iio/light/rpr0521.c                        |   4 +-
>  drivers/iio/light/stk3310.c                        |   4 +-
>  drivers/iio/light/us5182d.c                        |   4 +-
>  drivers/iio/light/vcnl4000.c                       |  36 +-
>  drivers/iio/magnetometer/bmc150_magn_i2c.c         |   3 +-
>  drivers/iio/magnetometer/bmc150_magn_spi.c         |   3 +-
>  drivers/iio/magnetometer/mmc35240.c                |   4 +-
>  drivers/iio/potentiometer/max5487.c                |   4 +-
>  drivers/iio/pressure/Kconfig                       |  16 +-
>  drivers/iio/pressure/Makefile                      |   2 +
>  drivers/iio/pressure/hp206c.c                      |   6 +-
>  drivers/iio/pressure/hsc030pa.c                    |  49 +-
>  drivers/iio/pressure/hsc030pa.h                    |   7 +
>  drivers/iio/pressure/hsc030pa_i2c.c                |   9 +-
>  drivers/iio/pressure/hsc030pa_spi.c                |   7 +-
>  drivers/iio/pressure/mprls0025pa.c                 | 313 ++++-----
>  drivers/iio/pressure/mprls0025pa.h                 | 102 +++
>  drivers/iio/pressure/mprls0025pa_i2c.c             | 100 +++
>  drivers/iio/pressure/mprls0025pa_spi.c             |  92 +++
>  drivers/iio/pressure/st_pressure_i2c.c             |   5 +-
>  drivers/iio/proximity/sx9310.c                     | 114 ++-
>  drivers/iio/proximity/sx9324.c                     | 178 +++--
>  drivers/iio/proximity/sx9360.c                     | 115 ++-
>  drivers/iio/test/Kconfig                           |  14 +
>  drivers/iio/test/Makefile                          |   1 +
>  drivers/iio/test/iio-test-gts.c                    | 513 ++++++++++++++
>  drivers/of/property.c                              |   2 +
>  include/linux/hid-sensor-ids.h                     |   4 +
>  include/linux/iio/adc/adi-axi-adc.h                |  68 --
>  include/linux/iio/backend.h                        |  72 ++
>  include/linux/iio/buffer-dmaengine.h               |   3 +
>  include/linux/iio/iio.h                            |  30 +-
>  tools/iio/iio_utils.c                              |   2 +-
>  112 files changed, 5038 insertions(+), 1875 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmfm2000.yaml
>  create mode 100644 drivers/iio/accel/bmi088-accel-i2c.c
>  create mode 100644 drivers/iio/adc/ti-ads1298.c
>  create mode 100644 drivers/iio/frequency/admfm2000.c
>  create mode 100644 drivers/iio/industrialio-backend.c
>  create mode 100644 drivers/iio/pressure/mprls0025pa.h
>  create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
>  create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c
>  create mode 100644 drivers/iio/test/iio-test-gts.c
>  delete mode 100644 include/linux/iio/adc/adi-axi-adc.h
>  create mode 100644 include/linux/iio/backend.h
>=20


