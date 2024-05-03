Return-Path: <linux-iio+bounces-4781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA48BB352
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B055B21157
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D535029A;
	Fri,  3 May 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N51/dkOq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E319470
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761363; cv=none; b=dqMe2fUHMdJ5OsdGpBpBL+3rme7Iksmf/N/4SYJYNkz1ufLxEuY6RgWhUoaCXCU7iqRXnnoy24TQJl1IEuDgXWHoYPJdFeWKa/mGg9jZlwb6l3JROvYj+zTjFpROqtH9LZVmE83RoMhy6TPcjLw4MluLk0/RfHp8AFgNQDcBpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761363; c=relaxed/simple;
	bh=7vnNt3C/I5ZfvC4kgpOfYGQhT9rPUl7RnOGmn/TLMy8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=hV6US9ztVeU9JRWQlMj11sJvrnIiOJAATxSG3bGbAKO/1jjzHXaRIpkF++hwvuZm8zIWBB/gZEs2GXoHyrpMLxw/PN5cBjL0T0GyZ4KPyxL+5H9v+VgOsH/kz3pA5ex3zd1AgsfOkC3UU+RyeiIWwn07EddeuwDJCcOSgebcrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N51/dkOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7D1C116B1;
	Fri,  3 May 2024 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714761363;
	bh=7vnNt3C/I5ZfvC4kgpOfYGQhT9rPUl7RnOGmn/TLMy8=;
	h=Date:From:To:Subject:From;
	b=N51/dkOqTpdpqKM1bPpJrUVMEtPzeOwids/dAMxg2a1pGv8ezXv64ZVYmLO8siMAI
	 Ukb/Fpo8CF+2thDqR3ycp/m4L1fq9895br85S6MEKb7144qiksS5mBFnG8QJhJv2TI
	 yfLTByJEQWht9aTBErsBcPNQuRuK7wKPtORspOdiR9vtSaBQOh7qdMShKyjqnnHRsQ
	 JGiODcZVcT3oQXue48kAWB2+05v/DoN0DO65wk5DXjlsu7I2mG49DY7Is5BvLxv1OD
	 8C9pZuSsCWrONAk8sOpqSEYI9eNoO4/HSXH5BJi8WklbVVuPisbdVFoNfkEJody/7R
	 V6Qul2MX1w2zA==
Date: Fri, 3 May 2024 19:35:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL V2] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <20240503193551.369c018b@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:

  Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b-take2

for you to fetch changes up to 827dca3129708a8465bde90c86c2e3c38e62dd4f:

  iio: temperature: mcp9600: Fix temperature reading for negative values (2024-05-03 11:48:56 +0100)

----------------------------------------------------------------
IIO: 2nd set of new device support, features and cleanup for 6.10 (take 2)

The usual mixed bag from towards the end of the cycle.
Changes since take 1. Fixed the fixes tag and indeed fixed a rebase I
messed up on the same fix.

New devices support
===================

invensense,icm42600
- Support the ICM-42686-P a high range device going up to 32g and 4000 dps

New features
============

adi,ad7944
- Add support for chain mode in which many ADCs may be daisy chained and
  read out via a single long read.
adi,ad9467/backend library
- Add bus tuning related interfaces.
adi,axi-adc
- Add control for the AXI clock - seems always enabled early in boot for other
  reasons, but the driver should not rely on that..

Cleanups and minor or late breaking fixes
=========================================

Micrsoft/ACPI mount matrix handling.
- Replace several implementations of the Microsoft defined ROTM ACPI
  method with a single one.
multiple drivers
- Don't call the result of wait_for_completion() timeout as it's
  more accurate as time_left.
adi,ad7266
- Stop setting the iio_dev->masklength as it's done by the IIO core and
  should not be set from drivers.
adi,ad799x
- Some checkpatch type fixes.
adi,ad9839
- Ensure compelte MU_CNT1 is written during lock phase.
adi,axi-dac
- Fix inverted parameter.
adi,adis16475
- Drop documentation of non existent sysfs files.
avago,apds9306
- Fix an off by one error that overly restricts the range of persistence
  and adaptive thresholds that the driver accepts.
freescale,mxs-lradc
- Stop setting the iio_dev->masklength as it's done by the IIO core and
  should not be set from drivers.
invensense,timestamp library
- Fix timestamp vs interupt alignment and aovid soms glitches that
  occured when switching sampling frequency.
microchip,mcp3564
- Make use of device_for_each_child_node_scoped() to allow early release
  without manual fwnode_handle_put().
microchip,mcp9600
- Allow for negative temperatures.
microchip,pac1934
- Avoid an out of bounds array index.
richtek,rtq6056
- Use iio_device_claim_direct_scoped() to automate lock release and simplify
  the code.
sensortek,stk3110
- Drop a likely incorrect ACPI ID. No known users of this ID and it's
  not a valid ACPI ID.
ti,ads1015
- Make use of device_for_each_child_node_scoped() to allow early release
  without manual fwnode_handle_put().

----------------------------------------------------------------
Andy Shevchenko (1):
      iio: light: stk3310: Drop most likely fake ACPI ID

Dan Carpenter (1):
      iio: dac: adi-axi: fix a mistake in axi_dac_ext_info_set()

David Lechner (5):
      iio: adc: ad7266: don't set masklength
      iio: adc: mxs-lradc-adc: don't set masklength
      iio: buffer: initialize masklength accumulator to 0
      iio: adc: ad7944: add support for chain mode
      docs: iio: ad7944: add documentation for chain mode

Dimitri Fedrau (1):
      iio: temperature: mcp9600: Fix temperature reading for negative values

Gabriel Schwartz (1):
      iio: adc: rtq6056: Use automated cleanup for mode handling in write_raw

Gustavo Rodrigues (3):
      iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
      iio: adc: ad799x: add blank line to avoid warning messages
      iio: adc: ad799x: Prefer to use octal permission

Hans de Goede (4):
      iio: core: Add iio_read_acpi_mount_matrix() helper function
      iio: accel: kxcjk-1013: Use new iio_read_acpi_mount_matrix() helper
      iio: bmc150-accel-core: Use iio_read_acpi_mount_matrix() helper
      iio: accel: mxc4005: Read orientation matrix from ACPI ROTM method

Jean-Baptiste Maneyrol (4):
      dt-bindings: iio: imu: add icm42686 inside inv_icm42600
      iio: imu: inv_icm42600: add support of ICM-42686-P
      iio: invensense: fix interrupt timestamp alignment
      iio: invensense: fix timestamp glitches when switching frequency

Jonathan Cameron (1):
      iio: adc: mcp3564: Use device_for_each_child_node_scoped()

Lincoln Yuji (1):
      iio: adc: ti-ads1015: use device_for_each_child_node_scoped()

Marius Cristea (1):
      iio: adc: PAC1934: fix accessing out of bounds array index

Nuno Sa (8):
      dt-bindings: adc: axi-adc: add clocks property
      iio: adc: axi-adc: make sure AXI clock is enabled
      iio: backend: change docs padding
      iio: backend: add API for interface tuning
      iio: adc: adi-axi-adc: remove regmap max register
      iio: adc: adi-axi-adc: support digital interface calibration
      iio: adc: ad9467: support digital interface calibration
      iio: dac: ad9739a: write complete MU_CNT1 register during lock

Ramona Gradinariu (1):
      docs: iio: adis16475: fix device files tables

Subhajit Ghosh (1):
      iio: light: apds9306: Fix input arguments to in_range()

Wolfram Sang (8):
      iio: adc: ad_sigma_delta: use 'time_left' variable with wait_for_completion_timeout()
      iio: adc: exynos_adc: use 'time_left' variable with wait_for_completion_timeout()
      iio: adc: fsl-imx25-gcq: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: intel_mrfld_adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: stm32-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: stm32-dfsdm-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: adc: twl6030-gpadc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
      iio: pressure: zpa2326: use 'time_left' variable with wait_for_completion_interruptible_timeout()

 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   5 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |   1 +
 Documentation/iio/ad7944.rst                       |  30 +-
 Documentation/iio/adis16475.rst                    |   8 +-
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/bmc150-accel-core.c              |  44 +--
 drivers/iio/accel/kxcjk-1013.c                     |  80 +----
 drivers/iio/accel/mxc4005.c                        |  22 ++
 drivers/iio/adc/ad7266.c                           |   1 -
 drivers/iio/adc/ad7944.c                           | 186 +++++++++-
 drivers/iio/adc/ad799x.c                           |   7 +-
 drivers/iio/adc/ad9467.c                           | 374 ++++++++++++++++++---
 drivers/iio/adc/ad_sigma_delta.c                   |   6 +-
 drivers/iio/adc/adi-axi-adc.c                      | 127 ++++++-
 drivers/iio/adc/exynos_adc.c                       |  16 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  10 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |  12 +-
 drivers/iio/adc/mcp3564.c                          |  16 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |   1 -
 drivers/iio/adc/pac1934.c                          |   9 +
 drivers/iio/adc/rtq6056.c                          |  34 +-
 drivers/iio/adc/stm32-adc.c                        |  10 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  12 +-
 drivers/iio/adc/ti-ads1015.c                       |   5 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   8 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |  33 +-
 drivers/iio/dac/ad9739a.c                          |   5 +-
 drivers/iio/dac/adi-axi-dac.c                      |   6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  35 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  75 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  31 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  21 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  84 +++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   3 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   2 +-
 drivers/iio/industrialio-acpi.c                    |  85 +++++
 drivers/iio/industrialio-backend.c                 | 162 ++++++---
 drivers/iio/industrialio-buffer.c                  |   2 +-
 drivers/iio/light/apds9306.c                       |  12 +-
 drivers/iio/light/stk3310.c                        |   1 -
 drivers/iio/pressure/zpa2326.c                     |  10 +-
 drivers/iio/temperature/mcp9600.c                  |   3 +-
 include/linux/iio/backend.h                        |  74 ++--
 include/linux/iio/common/inv_sensors_timestamp.h   |   3 +-
 include/linux/iio/iio.h                            |  13 +
 46 files changed, 1282 insertions(+), 406 deletions(-)
 create mode 100644 drivers/iio/industrialio-acpi.c

