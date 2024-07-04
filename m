Return-Path: <linux-iio+bounces-7292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B842927132
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA59B1C221D6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3A1A38E0;
	Thu,  4 Jul 2024 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCIQiCrV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBF18637
	for <linux-iio@vger.kernel.org>; Thu,  4 Jul 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080341; cv=none; b=UIZPm4NpmTLTmGOPbdaikmJDD5oTx+WyZoBMe3lRcSG2ouvvDlM6PYsbXAKMycGGG4Fgx+1U5//LrlHVIPj45MSkkT3K8LcBFXglZfzchXj7/OTVPom6jVdzlHesRnFXacRXBAQ7nv0n7l2SkZj4xsW6NgZML3QnBqPYNbgsKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080341; c=relaxed/simple;
	bh=ppqSObE8lB0OmlBubuR/cy92wKRHjGqBbtKbFf+A98g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=EVg8PjZuxmFhCPlZR9TGo8AyHgZAQOfttMGvivWFsG1+hTETF9JZ1bbmn7yrT7eAOaSX4qosmCT72EPbB67xD0BjkLFSbh2tnu0I1urNBLp4KZ5hhyOoceAYBmmKTpLwz9qbtZ0wfunJ2l7l1Q//m2kejo1mLSJ1IwXqzMfU0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCIQiCrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9450C3277B;
	Thu,  4 Jul 2024 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720080341;
	bh=ppqSObE8lB0OmlBubuR/cy92wKRHjGqBbtKbFf+A98g=;
	h=Date:From:To:Subject:From;
	b=CCIQiCrVjQ7Qznb0xIYGzaeng46Aulh7o8CUCYJdy4yg7pXWW6nI4XB3Bgjz7CkYM
	 FdmBo2XHTLJzv+pFvUBFShoVNqlPbwi02cD6xxdXGB0FU5LxfzaKtSQtOjOjChcEta
	 m9IRL+AOQ/nUhc8QNeZld4Yo5cx8Yf4+THb5c5ZmtVW/ZIx94WGf5xVJYfnhuWWTyi
	 AE0K83mQvluZx/ojrKMeb54fZYxU+r1nnexLhT1/GLGjlVZMhNuariZp/HMa7MXoMm
	 rbc3pwFW2DOX9OUdaCCOFWgxOWYGQpeZKiCGSjwZVcMXfXrPfY6+iUL8IVzXeoVt3R
	 fjnWR7L8qqlrA==
Date: Thu, 4 Jul 2024 09:05:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set new device support features etc for 6.11
Message-ID: <20240704090535.06322620@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 20460472952043a4735e9abc1fd9de8e024d1c9e:

  Merge tag 'v6.10-rc4' into char-misc-next (2024-06-17 08:31:12 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.11b

for you to fetch changes up to 529d2e1900642eba6df28307e26e19793e227546:

  iio: adc: ad7173: Fix uninitialized symbol is_current_chan (2024-07-02 19=
:43:46 +0100)

----------------------------------------------------------------
IIO: 2nd set of new device support, features and cleanup for 6.11

The big one here is we finally have Paul Cercueil's (and others)
DMA buffer support for IIO devices enabling high speed zero
copy transfer of data to and from sensors supported by IIO (and for
example USB).  This should aid with upstream support of a range of
higher performance ADCs and DACs.

Two merges from other trees
- spi/spi_devm_optimize used for simplification in ad7944.
- dmaengine/topic_dma_vec to enable the DMABUF series.

One feature with impact outside IIO.
- Richer set of dev_err_probe() like helpers to cover ERR_PTR() cases.

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
adi,ad7173
- Add support for AD4111, AD4112, AD4114, AD4115 and ADC4116 pseudo
  differential ADCs. Major driver rework was needed to enabled these.
adi,ad7944
- Use devm_spi_optimize_message() to avoid a local devm cleanup
  callback. This is the example case from the patch set, others will
  follow.
mediatek,mt6359-auxadc
- New driver for this ADC IP found in MT6357, MT6358 and MT6359 PMICs.
st,accel
- Add support for the LIS2DS12 accelerometer
ti,ads1119
- New driver for this 16 bit 2-differential or 4-single ended channel
  ADC.

Features
=3D=3D=3D=3D=3D=3D=3D=3D
dt-bindings
- Introduce new common-mode-channel property to help handle pseudo
  differential ADCs where we have something that looks like one side
  of differential input, but which is only suited for use with a
  slow moving reference.
adi,adf4350
- Support use as a clock provider.
iio-hmwon
- Support reading of labels from IIO devices by their consumers and
  use this in the hwmon bridge.

Cleanup and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Treewide
- Use regmap_clear_bits() / regmap_set_bits() to simplify open coded
  equivalents.
- Use devm_regulator_get_enable_read_voltage() to replace equivalent
  opencoded boilerplate. In some cases enabled complete conversion to
  devm handling and removal of explicit remove() callbacks.
- Introduce dev_err_ptr_probe() and other variants and make use of
  of them in a couple of examples driver cleanups. Will find use in
  many more drivers soon.
adi,ad7192
- Introduce local struct device *dev and use dev_err_probe() to give
  more readable code.
adi,adi-axi-adc/dac
- Improved consistency of messages using dev_err_probe()
adi,adis
- Split the trigger handling into cases that needed paging and those that
  don't resulting in more readable code.
- Use cleanup.h to simplify error paths via scoped cleanup.
- Add adis specific lock helpers and make use of them in a number of driver=
s.
adi,ad7192
- Update maintainer (Alisa-Dariana Roman)
adi,ad7606
- dt-binding cleanup.
avago,apds9306
- Add a maintainer entry (Subhajit Ghosh)
linear,ltc2309
- Fix a wrong endian type.
st,stm32-dfsdm
- Fix a missing port property in the dt-binding.
st,sensors
- Relax whoami match failure to a warning print rather than probe failure.
  This enables fallback compatibles to existing parts from those that don't
  necessarily even exit yet.

----------------------------------------------------------------
Alisa-Dariana Roman (2):
      iio: adc: ad7192: Clean up dev
      MAINTAINERS: Update AD7192 driver maintainer

AngeloGioacchino Del Regno (3):
      dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
      math.h: Add unsigned 8 bits fractional numbers type
      iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC

Antoniu Miclaus (2):
      dt-bindings: iio: adf4350: add clk provider prop
      iio: frequency: adf4350: add clk provider

David Lechner (19):
      iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_regulator_get_enable_read_voltage
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: remove hx711_remove()
      iio: adc: hx711: use dev_err_probe()
      iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
      iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: drop ads8688_remove()
      iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
      iio: adc: ad7944: use devm_spi_optimize_message()

Dumitru Ceclan (9):
      dt-bindings: iio: adc: Add common-mode-channel property
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad_sigma_delta: add disable_one callback
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: add support for special inputs
      iio: adc: ad7173: refactor device info structs
      iio: adc: ad7173: document sampling frequency behaviour
      iio: adc: ad7173: Add support for AD411x devices

Guillaume Stols (2):
      dt-bindings: iio: adc: adi,ad7606: add missing datasheet link
      dt-bindings: iio: adc: adi,ad7606: comment and sort the compatible na=
mes

Jonathan Cameron (4):
      iio: adc: ltc2309: Fix endian type passed to be16_to_cpu()
      Merge tag 'dmaengine_topic_dma_vec' into togreg
      Merge tag 'spi-devm-optimize' into togreg
      iio: adc: ad7173: Fix uninitialized symbol is_current_chan

Jo=C3=A3o Paulo Gon=C3=A7alves (2):
      dt-bindings: iio: adc: add ti,ads1119
      iio: adc: ti-ads1119: Add driver

Kaustabh Chakraborty (3):
      iio: accel: st_accel: add support for LIS2DS12
      dt-bindings: iio: st-sensors: add LIS2DS12 accelerometer
      iio: st_sensors: relax WhoAmI check in st_sensors_verify_id()

Nuno Sa (13):
      iio: imu: adis_buffer: split trigger handling
      iio: imu: adis: move to the cleanup magic
      iio: imu: adis: add cleanup based lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: gyro: adis16260: make use of the new lock helpers
      iio: imu: adis16400: make use of the new lock helpers
      iio: imu: adis16480: make use of the new lock helpers
      iio: imu: adis16475: make use of the new lock helpers
      iio: imu: adis: remove legacy lock helpers
      dev_printk: add new dev_err_probe() helpers
      iio: temperature: ltc2983: convert to dev_err_probe()
      iio: backend: make use of dev_err_cast_probe()
      iio: common: scmi_iio: convert to dev_err_probe()

Olivier Moysan (1):
      dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on dfsdm audio port

Paul Cercueil (7):
      dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
      Documentation: dmaengine: Document new dma_vec API
      iio: core: Add new DMABUF interface infrastructure
      iio: buffer-dma: Enable support for DMABUFs
      iio: buffer-dmaengine: Support new DMABUF based userspace API
      Documentation: iio: Document high-speed DMABUF based API

Sean Anderson (3):
      iio: Add iio_read_channel_label to inkern API
      hwmon: iio: Add labels from IIO channels
      iio: xilinx-ams: Add labels

Subhajit Ghosh (1):
      MAINTAINERS: Add AVAGO APDS9306

Trevor Gamblin (43):
      iio: adc: adi-axi-adc: improve probe() error messaging
      iio: accel: fxls8962af-core: Make use of regmap_set_bits(), regmap_cl=
ear_bits()
      iio: accel: kxsd9: Make use of regmap_clear_bits()
      iio: accel: msa311: make use of regmap_clear_bits()
      iio: adc: ad4130: make use of regmap_clear_bits()
      iio: adc: axp20x_adc: make use of regmap_set_bits()
      iio: adc: axp288_adc: make use of regmap_set_bits()
      iio: adc: bcm_iproc_adc: make use of regmap_clear_bits()
      iio: adc: cpcap-adc: make use of regmap_clear_bits(), regmap_set_bits=
()
      iio: adc: fsl-imx25-gcq: make use of regmap_clear_bits(), regmap_set_=
bits()
      iio: adc: ina2xx-adc: make use of regmap_clear_bits()
      iio: adc: intel_mrfld_adc: make use of regmap_clear_bits()
      iio: adc: meson_saradc: make use of regmap_clear_bits(), regmap_set_b=
its()
      iio: adc: mp2629_adc: make use of regmap_clear_bits(), regmap_set_bit=
s()
      iio: adc: berlin2-adc: make use of regmap_clear_bits(), regmap_set_bi=
ts()
      iio: adc: qcom-spmi-rradc: make use of regmap_clear_bits(), regmap_se=
t_bits()
      iio: adc: rn5t618-adc: make use of regmap_set_bits()
      iio: adc: sc27xx_adc: make use of regmap_clear_bits(), regmap_set_bit=
s()
      iio: adc: stm32-dfsdm-adc: make use of regmap_clear_bits(), regmap_se=
t_bits()
      iio: dac: ltc2688: make use of regmap_set_bits()
      iio: dac: stm32-dac-core: make use of regmap_set_bits()
      iio: gyro: bmg160_core: make use of regmap_clear_bits()
      iio: gyro: mpu3050-core: make use of regmap_clear_bits(), regmap_set_=
bits()
      iio: health: afe4403: make use of regmap_clear_bits(), regmap_set_bit=
s()
      iio: health: afe4404: make use of regmap_clear_bits(), regmap_set_bit=
s()
      iio: health: max30100: make use of regmap_set_bits()
      iio: health: max30102: make use of regmap_set_bits()
      iio: imu: inv_icm42600: make use of regmap_clear_bits(), regmap_set_b=
its()
      iio: light: adux1020: make use of regmap_clear_bits(), regmap_set_bit=
s()
      iio: light: iqs621-als: make use of regmap_clear_bits()
      iio: light: isl29018: make use of regmap_clear_bits()
      iio: light: st_uvis25_core: make use of regmap_clear_bits()
      iio: light: veml6030: make use of regmap_clear_bits()
      iio: magnetometer: ak8974: make use of regmap_set_bits()
      iio: magnetometer: mmc35240: make use of regmap_set_bits()
      iio: pressure: bmp280-core: make use of regmap_clear_bits()
      iio: proximity: sx9324: make use of regmap_set_bits()
      iio: proximity: sx9360: make use of regmap_set_bits()
      iio: proximity: sx9500: make use of regmap_clear_bits(), regmap_set_b=
its()
      iio: proximity: sx_common: make use of regmap_clear_bits(), regmap_se=
t_bits()
      iio: temperature: mlx90632: make use of regmap_clear_bits()
      iio: trigger: stm32-timer-trigger: make use of regmap_clear_bits(), r=
egmap_set_bits()
      iio: dac: adi-axi-dac: improve probe() error messaging

 Documentation/devicetree/bindings/iio/adc/adc.yaml |  11 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 194 ++++-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   5 +-
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |  33 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   4 +
 .../devicetree/bindings/iio/adc/ti,ads1119.yaml    | 155 ++++
 .../bindings/iio/frequency/adi,adf4350.yaml        |   6 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |   1 +
 Documentation/driver-api/dmaengine/client.rst      |   9 +
 Documentation/driver-api/dmaengine/provider.rst    |  10 +
 Documentation/driver-api/driver-model/devres.rst   |   3 +
 Documentation/iio/iio_dmabuf_api.rst               |  54 ++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |  17 +-
 drivers/dma/dma-axi-dmac.c                         |  40 +
 drivers/hwmon/iio_hwmon.c                          |  45 +-
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/accel/fxls8962af-core.c                |  18 +-
 drivers/iio/accel/kxsd9.c                          |   5 +-
 drivers/iio/accel/msa311.c                         |   8 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |  81 ++
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   5 +
 drivers/iio/adc/Kconfig                            |  24 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/ad4130.c                           |   4 +-
 drivers/iio/adc/ad7124.c                           |  14 +-
 drivers/iio/adc/ad7173.c                           | 676 ++++++++++++-----
 drivers/iio/adc/ad7192.c                           | 134 ++--
 drivers/iio/adc/ad7266.c                           |  33 +-
 drivers/iio/adc/ad7292.c                           |  36 +-
 drivers/iio/adc/ad7793.c                           |  24 +-
 drivers/iio/adc/ad7944.c                           |  80 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   1 +
 drivers/iio/adc/adi-axi-adc.c                      |   9 +-
 drivers/iio/adc/aspeed_adc.c                       |  30 +-
 drivers/iio/adc/axp20x_adc.c                       |   5 +-
 drivers/iio/adc/axp288_adc.c                       |   4 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   8 +-
 drivers/iio/adc/berlin2-adc.c                      |  24 +-
 drivers/iio/adc/cpcap-adc.c                        |  46 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  16 +-
 drivers/iio/adc/hx711.c                            |  78 +-
 drivers/iio/adc/ina2xx-adc.c                       |   3 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |   4 +-
 drivers/iio/adc/ltc2309.c                          |  45 +-
 drivers/iio/adc/max1363.c                          |  28 +-
 drivers/iio/adc/meson_saradc.c                     | 101 ++-
 drivers/iio/adc/mp2629_adc.c                       |  19 +-
 drivers/iio/adc/mt6359-auxadc.c                    | 606 +++++++++++++++
 drivers/iio/adc/qcom-spmi-rradc.c                  |  50 +-
 drivers/iio/adc/rn5t618-adc.c                      |   5 +-
 drivers/iio/adc/sc27xx_adc.c                       |  41 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  29 +-
 drivers/iio/adc/ti-adc108s102.c                    |  28 +-
 drivers/iio/adc/ti-ads1119.c                       | 825 +++++++++++++++++=
++++
 drivers/iio/adc/ti-ads8688.c                       |  59 +-
 drivers/iio/adc/xilinx-ams.c                       | 107 +--
 drivers/iio/buffer/industrialio-buffer-dma.c       | 178 ++++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  62 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |  45 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   3 +-
 drivers/iio/dac/ad3552r.c                          |  28 +-
 drivers/iio/dac/adi-axi-dac.c                      |   9 +-
 drivers/iio/dac/ltc2688.c                          |   5 +-
 drivers/iio/dac/stm32-dac-core.c                   |   5 +-
 drivers/iio/frequency/adf4350.c                    | 124 +++-
 drivers/iio/gyro/adis16136.c                       |  26 +-
 drivers/iio/gyro/adis16260.c                       |  19 +-
 drivers/iio/gyro/bmg160_core.c                     |   4 +-
 drivers/iio/gyro/mpu3050-core.c                    |  35 +-
 drivers/iio/health/afe4403.c                       |   9 +-
 drivers/iio/health/afe4404.c                       |   9 +-
 drivers/iio/health/max30100.c                      |   5 +-
 drivers/iio/health/max30102.c                      |   5 +-
 drivers/iio/iio_core.h                             |   4 +
 drivers/iio/imu/adis.c                             |  11 +-
 drivers/iio/imu/adis16400.c                        |  72 +-
 drivers/iio/imu/adis16475.c                        |  44 +-
 drivers/iio/imu/adis16480.c                        |  63 +-
 drivers/iio/imu/adis_buffer.c                      |  41 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  14 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   9 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   4 +-
 drivers/iio/industrialio-backend.c                 |   8 +-
 drivers/iio/industrialio-buffer.c                  | 459 ++++++++++++
 drivers/iio/industrialio-core.c                    |  23 +-
 drivers/iio/inkern.c                               |   6 +
 drivers/iio/light/adux1020.c                       |  13 +-
 drivers/iio/light/iqs621-als.c                     |   4 +-
 drivers/iio/light/isl29018.c                       |   6 +-
 drivers/iio/light/st_uvis25_core.c                 |   4 +-
 drivers/iio/light/veml6030.c                       |   4 +-
 drivers/iio/magnetometer/ak8974.c                  |  10 +-
 drivers/iio/magnetometer/mmc35240.c                |   8 +-
 drivers/iio/pressure/bmp280-core.c                 |   4 +-
 drivers/iio/proximity/sx9324.c                     |   5 +-
 drivers/iio/proximity/sx9360.c                     |   5 +-
 drivers/iio/proximity/sx9500.c                     |  12 +-
 drivers/iio/proximity/sx_common.c                  |   9 +-
 drivers/iio/temperature/ltc2983.c                  | 262 +++----
 drivers/iio/temperature/mlx90632.c                 |   4 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |  34 +-
 drivers/spi/spi.c                                  |  28 +
 .../dt-bindings/iio/adc/mediatek,mt6357-auxadc.h   |  21 +
 .../dt-bindings/iio/adc/mediatek,mt6358-auxadc.h   |  22 +
 .../dt-bindings/iio/adc/mediatek,mt6359-auxadc.h   |  22 +
 include/linux/dev_printk.h                         |   8 +
 include/linux/dmaengine.h                          |  33 +
 include/linux/iio/adc/ad_sigma_delta.h             |  14 +
 include/linux/iio/buffer-dma.h                     |  31 +
 include/linux/iio/buffer_impl.h                    |  33 +
 include/linux/iio/consumer.h                       |  10 +
 include/linux/iio/imu/adis.h                       |  66 +-
 include/linux/math.h                               |   2 +
 include/linux/spi/spi.h                            |   2 +
 include/uapi/linux/iio/buffer.h                    |  22 +
 119 files changed, 4447 insertions(+), 1494 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt63=
59-auxadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.ya=
ml
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst
 create mode 100644 drivers/iio/adc/mt6359-auxadc.c
 create mode 100644 drivers/iio/adc/ti-ads1119.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h

