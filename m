Return-Path: <linux-iio+bounces-3248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2886D3F5
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 21:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15721B2334C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC213F438;
	Thu, 29 Feb 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghd/n5f3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934213F42F
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237468; cv=none; b=Ts6Fqxz7p4Eb2YZDgxzy/je0a1aWWjyzfcWSWNTEZ/FN2cKXpVh4B6SIozfcyAAOh07lKcb42vFpSezRquxGmfEAHECariq8ZeJOymdv8iEfaOBy+OLQD3U0YzbHDcRDh9zU8nVsDTiT5HIIqlvQihLEXg4hXT4LADe8OLv2VZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237468; c=relaxed/simple;
	bh=iAVkpPRQcA2sjTW1B2oOKS6XhfoZ4dQZQeReju/rnuw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=o3LBpT1iOtRR6t2549GiAxUTp0vejXR+G3B/arhJSswMGHu+cra+2pvUli9NNsowkHgcEXNWSudly7WV+LpkjLZPZHaYj8Mov25TxMFoliRJAtwSsV58gTt5roZHMEnC7QCFm8xcWvNGIS55HxF+7tDFToAAcSimifrI5cUMsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghd/n5f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF639C433C7;
	Thu, 29 Feb 2024 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237467;
	bh=iAVkpPRQcA2sjTW1B2oOKS6XhfoZ4dQZQeReju/rnuw=;
	h=Date:From:To:Subject:From;
	b=Ghd/n5f3FGAIR1W8pdNai2/TakOl7Y2z2Ur1aW5eH4x/jB0IK1YIrqFEbymDgxTtI
	 TPoKEPFH8OWZ5UhX/KoQptejcvHUtKUoeZhY7H31uk018iCNFhWK83F85zMQG0E59T
	 1K/+j1tkKXGf+M1OEBwTYyjeYQ1w1w+qygheAv1TSZOb2r/Fk6AAgGVFcVdB57FhhD
	 M7qzsK1IpCIgh6lnwFZAALeXMw7UN+lnwno2ea0Tp40FVVgDfeqOB4myYq8j3IaVuz
	 +6/4z9saxNxZdHEcaEF/vvVaxZf4gzimdV2qxiIAZgWpJw8SCxf/KlJiM3l2oyqWmG
	 6AYW0/x9BcQ5w==
Date: Thu, 29 Feb 2024 20:10:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support features etc for 6.9.
Message-ID: <20240229201056.45abd048@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit d4551c189d6e6a3fcf7f625bd4b273e770fad35a:

  Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-02-25 14:11:41 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9b

for you to fetch changes up to 6b61aae323e30ba363616e1da23f591b164aca3f:

  dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency (2024-02-28 19:26:38 +0000)

----------------------------------------------------------------
IIO: 2nd set of new device support, cleanups and features for 6.9

New device support
=================
adi,hmc425a
- Add support for LTC6373 Instrumentation Amplifier.
microchip,pac1934
- New driver supporting PAC1931, PAC1932, PAC1933 and PAC1934 power monitoring
chips with accumulators.
voltafield,af8133j
- New driver for the AF8133J 3 axis magnetometer.

Docs
====

New general documentation of device buffers, and a specific section on
the adi,adis16475 IMU

Features
========

kionix,kxcjk-1013
 - Add support for ACPI ROTM (Microsoft defined ACPI method) to get rotation
   matrix.
ti,tmp117
- Add missing vcc-supply control and binding.

Cleanups and minor fixes
========================

Tree-wide
- Corrected headers to remove linux/of.h from a bunch of drivers
  that only had it to get to linux/mod_devicetable.h
- dt binding cleanup to drop redundant type from label properties.

adi,hmc425a
- Fix constraints on GPIO array sizes for different devices.
adi,ltc2983
- Use spi_get_device_match_data instead of open coding similar.
- Update naming of fw parsing function to reflect that it is not longer
  dt only.
- Set the chip name explicitly to reduce fragility resulting from different
  entries in the various ID tables.
bosch,bmg160
- Add spi-max-frequency property and limit to dt-binding.
microchip,mcp320x
- Use devm_* to simplify device removal and error handling.
nxp,imx93
- Drop a non existent 4th interrupt from bindings.
qcom,mp8xxx-xoadc
- Drop unused kerneldoc
renesas,isl29501
- Actually use the of_match table.
rockchip,saradc
- Fix channel bitmask
- Fix write masks
- Replace custom handling of optional reset control with how it should be
  done.
ti,ads1298
- Fix error code to not return a successfully obtained regulator.
- Avoid a divide by zero when setting frequency.
ti,hdc2010
- Add missing interrupts dt binding property
vishay,veml6075
- Make vdd-supply required in the dt-binding.

----------------------------------------------------------------
Arturas Moskvinas (1):
      iio: adc: mcp320x: Simplify device removal logic

Dan Carpenter (2):
      iio: adc: ti-ads1298: Fix error code in probe()
      iio: adc: ti-ads1298: prevent divide by zero in ads1298_set_samp_freq()

Dumitru Ceclan (5):
      dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
      dt-bindings: iio: hmc425a: add entry for LTC6373
      iio: amplifiers: hmc425a: move conversion logic
      iio: amplifiers: hmc425a: use pointers in match table
      iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier

Icenowy Zheng (3):
      dt-bindings: vendor-prefix: Add prefix for Voltafield
      dt-bindings: iio: magnetometer: Add Voltafield AF8133J
      iio: magnetometer: add a driver for Voltafield AF8133J magnetometer

Javier Carrasco (1):
      dt-bindings: iio: light: vishay,veml6075: make vdd-supply required

Jonathan Cameron (8):
      iio: light: vl6180: Drop unused linux/of.h include
      iio: light: al3320a: Drop unused linux/of.h include
      iio: light: al3010: Switch from linux/of.h to linux/mod_devicetable.h
      iio: adc: ads8688: Switch to mod_devicetable.h for struct of_device_id definition
      iio: accel: adxl372: Switch from linux/of.h to linux/mod_devicetable.h
      iio: accel: bma180: Switch from linux/of.h to linux/mod_devicetable.h
      iio: accel: kxsd9: Switch from linux/of.h to linux/mod_devicetable.h
      iio: dac: mcp4821: Switch to including mod_devicetable.h for struct of_device_id definition.

Josua Mayer (1):
      dt-bindings: iio: humidity: hdc20x0: add optional interrupts property

Krzysztof Kozlowski (3):
      dt-bindings: iio: adc: drop redundant type from label
      iio: adc: qcom-pm8xxx-xoadc: drop unused kerneldoc struct pm8xxx_chan_info member
      iio: proximity: isl29501: make use of of_device_id table

Marco Felsch (2):
      dt-bindings: iio: ti,tmp117: add optional label property
      dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency

Marius Cristea (2):
      dt-bindings: iio: adc: adding support for PAC193X
      iio: adc: adding support for PAC193x

Nuno Sa (3):
      iio: temperature: ltc2983: make use of spi_get_device_match_data()
      iio: temperature: ltc2983: rename ltc2983_parse_dt()
      iio: temperature: ltc2983: explicitly set the name in chip_info

Ondrej Jirman (1):
      MAINTAINERS: Add an entry for AF8133J driver

Peng Fan (1):
      dt-bindings: iio: adc: imx93: drop the 4th interrupt

Quentin Schulz (3):
      iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2
      iio: adc: rockchip_saradc: use mask for write_enable bitfield
      iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive

Ramona Gradinariu (3):
      docs: iio: Refactor index.rst
      docs: iio: add documentation for device buffers
      docs: iio: add documentation for adis16475 driver

Sean Rhodes (1):
      iio: accel: kxcjk-1013: Implement ACPI method ROTM to retrieve mount matrix.

Thomas Haemmerle (2):
      dt-bindings: iio: ti,tmp117: add vcc supply binding
      iio: temperature: tmp117: add support for vcc-supply

 .../ABI/testing/sysfs-bus-iio-adc-pac1934          |    9 +
 Documentation/devicetree/bindings/iio/adc/adc.yaml |    1 -
 .../bindings/iio/adc/microchip,pac1934.yaml        |  120 ++
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml |    4 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 -
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   47 +-
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |    8 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |    3 +
 .../bindings/iio/light/vishay,veml6075.yaml        |    1 +
 .../iio/magnetometer/voltafield,af8133j.yaml       |   60 +
 .../bindings/iio/temperature/ti,tmp117.yaml        |    8 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/adis16475.rst                    |  407 +++++
 Documentation/iio/iio_devbuf.rst                   |  152 ++
 Documentation/iio/index.rst                        |    9 +-
 MAINTAINERS                                        |   13 +
 drivers/iio/accel/adxl372_spi.c                    |    2 +-
 drivers/iio/accel/bma180.c                         |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |   87 +-
 drivers/iio/accel/kxsd9-spi.c                      |    2 +-
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/mcp320x.c                          |   29 +-
 drivers/iio/adc/pac1934.c                          | 1636 ++++++++++++++++++++
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    1 -
 drivers/iio/adc/rockchip_saradc.c                  |   17 +-
 drivers/iio/adc/ti-ads1298.c                       |    4 +-
 drivers/iio/adc/ti-ads8688.c                       |    2 +-
 drivers/iio/amplifiers/hmc425a.c                   |  274 +++-
 drivers/iio/dac/mcp4821.c                          |    2 +-
 drivers/iio/light/al3010.c                         |    2 +-
 drivers/iio/light/al3320a.c                        |    1 -
 drivers/iio/light/vl6180.c                         |    1 -
 drivers/iio/magnetometer/Kconfig                   |   12 +
 drivers/iio/magnetometer/Makefile                  |    1 +
 drivers/iio/magnetometer/af8133j.c                 |  528 +++++++
 drivers/iio/proximity/isl29501.c                   |    3 +-
 drivers/iio/temperature/ltc2983.c                  |   28 +-
 drivers/iio/temperature/tmp117.c                   |    9 +
 39 files changed, 3376 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 create mode 100644 Documentation/iio/adis16475.rst
 create mode 100644 Documentation/iio/iio_devbuf.rst
 create mode 100644 drivers/iio/adc/pac1934.c
 create mode 100644 drivers/iio/magnetometer/af8133j.c

