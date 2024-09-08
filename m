Return-Path: <linux-iio+bounces-9314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0689706A2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD25F1F2194D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0014EC50;
	Sun,  8 Sep 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9zDNhaR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4811DDC9
	for <linux-iio@vger.kernel.org>; Sun,  8 Sep 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791955; cv=none; b=nhPoi/NHer/C1blApVKnGxVdc4V351eSx+B7Jm3v8h/ZOGVzoxovDaSJMaD+wcm/k0dS9/0Dr1S6MeNXpVu43m/vc8LfI6InsX3cAjQzN44shjhz8K7vhV9hCWhhtQWAD/jb8KAEGRwK2hkWMuxm+Q26L150gy/S8LpTcUbtTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791955; c=relaxed/simple;
	bh=ux7rfyw4Yc7DzA31r1T+fXAYaOwvlBinNVGyrjuh9UI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=N9N4v5BHcG6LKbT7X4Ugou5Mw1WthHJzWMindmgCVkg4oOeQxToQPsT8YbmgoHui5UJ5GkO0HICmlbJ93BIw9ZCcOyCnVu1+gWgB5j9/ZTMQ+5qjyur5kHsXWojKHtwMzatNsOc0S0M7C+5HxEnJJ+UBJwhD4DwrEKXao5rhRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9zDNhaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F8C4CEC3;
	Sun,  8 Sep 2024 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725791955;
	bh=ux7rfyw4Yc7DzA31r1T+fXAYaOwvlBinNVGyrjuh9UI=;
	h=Date:From:To:Subject:From;
	b=L9zDNhaR3C3xSNw/bAsWFMxSjRIFnHdit2bKmqbol6QHH4Tha+JLsHNet/gyBjbJv
	 bc2iNil5uwVTxwlUKqX6Zqu0yTr64l4B54qUgMyjleL9bjERjXdueYHhjbqFlL84uo
	 U4tEqv7/1Yol+fJhkfkp6fJtKXBzxiSNIhwu56DkvmEq4HeXAjLKauBEdXVkyYEkBm
	 P+ASglr5aGoN3IhpycP+mtHSvjXvDo5KdH0WO44DO+zJ70tUPOf/D9qQe74aV8w4ft
	 FcMA+UhoGX9cvIeFR44iETU24X74RaH6g2+H3TLOFIb7+O9oH4vfZAgsQZfORZy3+7
	 QibNNjr9pN6Kg==
Date: Sun, 8 Sep 2024 11:39:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support, features and cleanup for
 6.12.
Message-ID: <20240908113909.24938c59@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit aead27d77f3e703f6056e12fb19f48a426df2fd7:

  Merge tag 'fpga-for-6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/=
kernel/git/fpga/linux-fpga into char-misc-next (2024-09-03 12:08:18 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.12b

for you to fetch changes up to 5ba0cb92584ba5e107c97001e09013c1da0772a8:

  iio: adc: axp20x_adc: add support for AXP717 ADC (2024-09-07 14:28:37 +01=
00)

----------------------------------------------------------------
IIO: 2nd set of new device support features and cleanup for 6.12

Late pull request as I was planing to include another series that
is waiting for a fix to end up in char-misc-next.  That can wait
for next cycle.

Includes one immutable branch merge from MFD to get a necessary header
change.

Usual mix of a few new drivers, additional device support for existing
drivers, new features and a bunch of cleanup across tree.

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

asahi-kasei,ak8975
- A few minor fixes as precursors to support for the AK09118 magnetometer
  that is very similar to the already supported AK09112
awinic,aw96103
- New driver for this capacitive proximity sensor.
x-powers,axp202
- Add support for the axp717 (including merge of MFD immutable branch).
sophgo,saradc
- New driver for this SOC ADC.

Features
=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad4695
- Add calibration support.
bosch,bmi323
- Ensure device is in lowest power state on suspend.

Cleanup and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
treewide
- Start to standardize formatting of id tables (ADC drivers done so far).
adi,ad5449
- Drop platform data support as long unused in upstream kernel.
bosch,bmc150
- Use fwnode_irq_get_by_name() in place of of_ variant.
- Use ACPI_HANDLE() to get the handle directly rather than via
  ACPI_COMPANION()
google,cros_ec_mkbp_proximity
- Include mod_devicetable.h instead of broader of.h
mirochip,mcp320x
- Drop vendorless compatible entries as not needed for backwards
  compatibility and should not be used in new boards.
st,lsm6dsx
- Use iio_read_acpi_mount_matrix() helper instead of open coding the
  same.
- Drop some unnecessary dev_fwnode() calls to check if a fwnode is
  available.  All the calls made handle this anyway.
xilinx,ams
- Use device_for_each_child_node_scoped() to avoid manual release of
  fwnode handle.

tools,generic-buffer
- Handle failure to allocate trigger name.
- Cleanup .*.cmd files if present.

----------------------------------------------------------------
Andy Shevchenko (5):
      iio: proximity: cros_ec_mkbp_proximity: Switch to including mod_devic=
etable.h for struct of_device_id definition
      iio: accel: bmc150: use fwnode_irq_get_byname()
      iio: accel: bmc150: Improve bmc150_apply_bosc0200_acpi_orientation()
      iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
      iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (2):
      iio: magnetometer: ak8975: Relax failure on unknown id
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Bartosz Golaszewski (1):
      iio: dac: ad5449: drop support for platform data

Chris Morgan (4):
      mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
      iio: adc: axp20x_adc: Add adc_en1 and adc_en2 to axp_data
      dt-bindings: iio: adc: Add AXP717 compatible
      iio: adc: axp20x_adc: add support for AXP717 ADC

Danila Tikhonov (2):
      dt-bindings: iio: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

David Lechner (4):
      iio: adc: ad4695: add 2nd regmap for 16-bit registers
      iio: adc: ad4695: implement calibration support
      doc: iio: ad4695: update for calibration support
      iio: ABI: document ad4695 new attributes

Denis Benato (1):
      iio: bmi323: peripheral in lowest power state on suspend

Javier Carrasco (1):
      iio: adc: xilinx-ams: use device_* to iterate over device child nodes

Jonathan Cameron (2):
      iio: adc: standardize on formatting for id match tables
      Merge remote-tracking branch 'mfd/ib-mfd-for-iio-power-6.12' into tog=
reg

Rob Herring (Arm) (1):
      iio: adc: mcp320x: Drop vendorless compatible strings

Thomas Bonnefille (2):
      dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add Sophgo CV1800B SARA=
DC
      iio: adc: sophgo-saradc: Add driver for Sophgo CV1800B SARADC

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

shuaijie wang (2):
      dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
      iio: proximity: aw96103: Add support for aw96103/aw96105 proximity se=
nsor

zhangjiao (1):
      tools: iio: rm .*.cmd when make clean

 Documentation/ABI/testing/sysfs-bus-iio            |   3 +
 .../bindings/iio/adc/sophgo,cv1800b-saradc.yaml    |  83 ++
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |  12 +
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |   4 +
 .../bindings/iio/proximity/awinic,aw96103.yaml     |  61 ++
 Documentation/iio/ad4695.rst                       |   7 +-
 drivers/iio/accel/bmc150-accel-core.c              |  10 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad4695.c                           | 241 +++++-
 drivers/iio/adc/ad7091r5.c                         |   6 +-
 drivers/iio/adc/ad7124.c                           |   4 +-
 drivers/iio/adc/ad7192.c                           |   6 +-
 drivers/iio/adc/ad7266.c                           |   4 +-
 drivers/iio/adc/ad7280a.c                          |   4 +-
 drivers/iio/adc/ad7291.c                           |   4 +-
 drivers/iio/adc/ad7292.c                           |   4 +-
 drivers/iio/adc/ad7298.c                           |   4 +-
 drivers/iio/adc/ad7476.c                           |  58 +-
 drivers/iio/adc/ad7606_par.c                       |   2 +-
 drivers/iio/adc/ad7606_spi.c                       |   4 +-
 drivers/iio/adc/ad7766.c                           |  14 +-
 drivers/iio/adc/ad7768-1.c                         |   2 +-
 drivers/iio/adc/ad7780.c                           |  10 +-
 drivers/iio/adc/ad7793.c                           |  20 +-
 drivers/iio/adc/ad7887.c                           |   4 +-
 drivers/iio/adc/ad7923.c                           |  18 +-
 drivers/iio/adc/ad9467.c                           |   4 +-
 drivers/iio/adc/aspeed_adc.c                       |   2 +-
 drivers/iio/adc/at91_adc.c                         |   2 +-
 drivers/iio/adc/axp20x_adc.c                       | 182 ++++-
 drivers/iio/adc/axp288_adc.c                       |   2 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   2 +-
 drivers/iio/adc/berlin2-adc.c                      |   2 +-
 drivers/iio/adc/ep93xx_adc.c                       |   2 +-
 drivers/iio/adc/exynos_adc.c                       |   2 +-
 drivers/iio/adc/hi8435.c                           |   2 +-
 drivers/iio/adc/hx711.c                            |   2 +-
 drivers/iio/adc/ina2xx-adc.c                       |  14 +-
 drivers/iio/adc/ingenic-adc.c                      |   2 +-
 drivers/iio/adc/lpc32xx_adc.c                      |   2 +-
 drivers/iio/adc/ltc2496.c                          |   2 +-
 drivers/iio/adc/ltc2497.c                          |   2 +-
 drivers/iio/adc/max1027.c                          |  16 +-
 drivers/iio/adc/max11100.c                         |   4 +-
 drivers/iio/adc/max1118.c                          |   4 +-
 drivers/iio/adc/max1241.c                          |   4 +-
 drivers/iio/adc/max34408.c                         |   4 +-
 drivers/iio/adc/max9611.c                          |   6 +-
 drivers/iio/adc/mcp320x.c                          |  10 -
 drivers/iio/adc/mp2629_adc.c                       |   4 +-
 drivers/iio/adc/mt6360-adc.c                       |   2 +-
 drivers/iio/adc/nau7802.c                          |   2 +-
 drivers/iio/adc/pac1921.c                          |   4 +-
 drivers/iio/adc/pac1934.c                          |   6 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   2 +-
 drivers/iio/adc/qcom-spmi-rradc.c                  |   2 +-
 drivers/iio/adc/rockchip_saradc.c                  |   2 +-
 drivers/iio/adc/rtq6056.c                          |   2 +-
 drivers/iio/adc/sophgo-cv1800b-adc.c               | 227 ++++++
 drivers/iio/adc/stm32-adc.c                        |   2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   2 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   2 +-
 drivers/iio/adc/stmpe-adc.c                        |   2 +-
 drivers/iio/adc/ti-adc0832.c                       |   4 +-
 drivers/iio/adc/ti-adc084s021.c                    |   4 +-
 drivers/iio/adc/ti-adc12138.c                      |   4 +-
 drivers/iio/adc/ti-adc161s626.c                    |   8 +-
 drivers/iio/adc/ti-ads1015.c                       |   4 +-
 drivers/iio/adc/ti-ads124s08.c                     |   2 +-
 drivers/iio/adc/ti-ads131e08.c                     |   4 +-
 drivers/iio/adc/ti-ads7924.c                       |   4 +-
 drivers/iio/adc/ti-ads7950.c                       |   2 +-
 drivers/iio/adc/ti-ads8344.c                       |   2 +-
 drivers/iio/adc/ti-ads8688.c                       |   6 +-
 drivers/iio/adc/ti-lmp92064.c                      |   2 +-
 drivers/iio/adc/ti-tlc4541.c                       |   8 +-
 drivers/iio/adc/xilinx-ams.c                       |  15 +-
 drivers/iio/dac/ad5449.c                           |  15 +-
 drivers/iio/imu/bmi323/bmi323_core.c               | 161 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  93 +--
 drivers/iio/magnetometer/Kconfig                   |   2 +-
 drivers/iio/magnetometer/ak8975.c                  |  79 +-
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/aw96103.c                    | 846 +++++++++++++++++=
++++
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |   2 +-
 drivers/mfd/axp20x.c                               |  25 +-
 include/linux/mfd/axp20x.h                         |  26 +
 include/linux/platform_data/ad5449.h               |  39 -
 tools/iio/Makefile                                 |   2 +-
 tools/iio/iio_generic_buffer.c                     |   4 +
 92 files changed, 2128 insertions(+), 382 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sophgo,cv1800=
b-saradc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,=
aw96103.yaml
 create mode 100644 drivers/iio/adc/sophgo-cv1800b-adc.c
 create mode 100644 drivers/iio/proximity/aw96103.c
 delete mode 100644 include/linux/platform_data/ad5449.h

