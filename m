Return-Path: <linux-iio+bounces-17676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B649A7CE5C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D098188F18D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73977219303;
	Sun,  6 Apr 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Uqxe8fVp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054B2192E2
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948505; cv=none; b=q5877BVNIPttO5hqcqq2h7fOMccWsbuZ5D7QFmbZd9SUosu/6SLzx6TenU7yP/eLzpGNvD96PZQEc6wk05k5ESHJezOiRbUCaJuCDven0b8BekJ9UBbLjQigoD8SvlIOHa5KNGWNLRT+/E7T/k2GE6pQcqMw4C6PN+0uEFXYvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948505; c=relaxed/simple;
	bh=ay+xTJR2IrdrcHD1IxnpgcYFelhXY8L3iZkbNPrfP1E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG6tbXzLnwpp12x3xzGQZJrb9BS4Iy5CbxnLqqN1OT8MqhW46i7cPpZZMQ7MBjGhd7DlE8iANsNNXqBcZAshSHTm0ezegbLGOIpEdXF+b09pxB6irXwwDiiwf5p6VGal8USRPp8RO5ty+Z2NNl3ju6SEXvVJVIIdXAdO97MfrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Uqxe8fVp; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743948489; x=1744207689;
	bh=sMA5YyvYmxc1G4LMh+w0+E1kLShMLbnr9gaxENTQCgI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Uqxe8fVpt4IJY7+PLVvuHOeLGjoBia98w/mOhj90AIuudwI3eqNiIDUPb21R795mQ
	 6YWe7rPwj18zOICOQGU0Yc+0cYadHh+va6Kclf1bmEToRUZKobPc5eMIxbpVlKaz42
	 sXGdn+MIkQaEu2bwcNjQf8j+wTB9RUcXLLYOqnAHFP1hJuXlwrIi7NzvDCZheVAPyh
	 pJX9cHoei3Zg08lI7RbEWWQvcs6TnLTO+Qv0hPEPbFf82O7ZZEHe628N18uNmB0VEI
	 K/MRMMYNZOMkXh5lRlgEgqNCcLXXeoslPJv/ZYVz+y7bFIPtX+yy+caRCK8+XdTtLv
	 WSrkYxguJnMlA==
Date: Sun, 06 Apr 2025 14:08:03 +0000
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Message-ID: <20250406140706.812425-4-y.oudjana@protonmail.com>
In-Reply-To: <20250406140706.812425-1-y.oudjana@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 13483a8eab31b7ccf907adbed96e8144886e37ed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add drivers for sensors exposed by the Qualcomm Sensor Manager service,
which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
include accelerometers, gyroscopes, pressure sensors, proximity sensors
and magnetometers.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                                 |  18 +
 drivers/iio/accel/Kconfig                   |  10 +
 drivers/iio/accel/Makefile                  |   2 +
 drivers/iio/accel/qcom_smgr_accel.c         | 138 ++++
 drivers/iio/common/Kconfig                  |   1 +
 drivers/iio/common/Makefile                 |   1 +
 drivers/iio/common/qcom_smgr/Kconfig        |  16 +
 drivers/iio/common/qcom_smgr/Makefile       |   8 +
 drivers/iio/common/qcom_smgr/qcom_smgr.c    | 589 ++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/Makefile   |   3 +
 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c | 711 ++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h | 163 +++++
 drivers/iio/gyro/Kconfig                    |  10 +
 drivers/iio/gyro/Makefile                   |   2 +
 drivers/iio/gyro/qcom_smgr_gyro.c           | 138 ++++
 drivers/iio/magnetometer/Kconfig            |   9 +
 drivers/iio/magnetometer/Makefile           |   2 +
 drivers/iio/magnetometer/qcom_smgr_mag.c    | 138 ++++
 drivers/iio/pressure/Kconfig                |  10 +
 drivers/iio/pressure/Makefile               |   1 +
 drivers/iio/pressure/qcom_smgr_pressure.c   | 106 +++
 drivers/iio/proximity/Kconfig               |  10 +
 drivers/iio/proximity/Makefile              |   1 +
 drivers/iio/proximity/qcom_smgr_prox.c      | 106 +++
 include/linux/iio/common/qcom_smgr.h        |  64 ++
 25 files changed, 2257 insertions(+)
 create mode 100644 drivers/iio/accel/qcom_smgr_accel.c
 create mode 100644 drivers/iio/common/qcom_smgr/Kconfig
 create mode 100644 drivers/iio/common/qcom_smgr/Makefile
 create mode 100644 drivers/iio/common/qcom_smgr/qcom_smgr.c
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/Makefile
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
 create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
 create mode 100644 drivers/iio/gyro/qcom_smgr_gyro.c
 create mode 100644 drivers/iio/magnetometer/qcom_smgr_mag.c
 create mode 100644 drivers/iio/pressure/qcom_smgr_pressure.c
 create mode 100644 drivers/iio/proximity/qcom_smgr_prox.c
 create mode 100644 include/linux/iio/common/qcom_smgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 78467ad7a8fe..d0183c09cc3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20004,6 +20004,24 @@ F:=09Documentation/networking/device_drivers/cellu=
lar/qualcomm/rmnet.rst
 F:=09drivers/net/ethernet/qualcomm/rmnet/
 F:=09include/linux/if_rmnet.h
=20
+QUALCOMM SENSOR MANAGER IIO DRIVER
+M:=09Yassine Oudjana <y.oudjana@protonmail.com>
+L:=09linux-iio@vger.kernel.org
+L:=09linux-arm-msm@vger.kernel.org
+S:=09Maintained
+F:=09drivers/iio/accel/qcom_smgr_accel.c
+F:=09drivers/iio/common/qcom_smgr/Kconfig
+F:=09drivers/iio/common/qcom_smgr/Makefile
+F:=09drivers/iio/common/qcom_smgr/qcom_smgr.c
+F:=09drivers/iio/common/qcom_smgr/qmi/Makefile
+F:=09drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
+F:=09drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
+F:=09drivers/iio/gyro/qcom_smgr_gyro.c
+F:=09drivers/iio/magnetometer/qcom_smgr_mag.c
+F:=09drivers/iio/pressure/qcom_smgr_pressure.c
+F:=09drivers/iio/proximity/qcom_smgr_prox.c
+F:=09include/linux/iio/common/qcom_smgr.h
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:=09Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
 L:=09linux-arm-msm@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 8c3f7cf55d5f..d3253b856771 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -407,6 +407,16 @@ config IIO_CROS_EC_ACCEL_LEGACY
 =09  Sensor data is retrieved through IO memory.
 =09  Newer devices should use IIO_CROS_EC_SENSORS.
=20
+config IIO_QCOM_SMGR_ACCEL
+=09tristate "Qualcomm SSC Sensor Manager Accelerometer Sensor"
+=09depends on IIO_QCOM_SMGR
+=09select IIO_BUFFER
+=09select IIO_KFIFO_BUF
+=09help
+=09  Say yes here to get support for accelerometers connected to
+=09  a Qualcomm Snapdragon Sensor Core and accessed through its
+=09  Sensor Manager service.
+
 config IIO_ST_ACCEL_3AXIS
 =09tristate "STMicroelectronics accelerometers 3-Axis Driver"
 =09depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index ca8569e25aba..5f7fcd88a502 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -78,6 +78,8 @@ obj-$(CONFIG_STK8BA50)=09=09+=3D stk8ba50.o
=20
 obj-$(CONFIG_IIO_CROS_EC_ACCEL_LEGACY) +=3D cros_ec_accel_legacy.o
=20
+obj-$(CONFIG_IIO_QCOM_SMGR_ACCEL) +=3D qcom_smgr_accel.o
+
 obj-$(CONFIG_IIO_SSP_SENSORS_COMMONS) +=3D ssp_accel_sensor.o
=20
 obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) +=3D st_accel.o
diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qcom_s=
mgr_accel.c
new file mode 100644
index 000000000000..ce854312d1d9
--- /dev/null
+++ b/drivers/iio/accel/qcom_smgr_accel.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager accelerometer driver
+ *
+ * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_chan_spec qcom_smgr_accel_iio_channels[] =3D {
+=09{
+=09=09.type =3D IIO_ACCEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_X,
+=09=09.scan_index =3D 0,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_ACCEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Y,
+=09=09.scan_index =3D 1,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_ACCEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Z,
+=09=09.scan_index =3D 2,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_TIMESTAMP,
+=09=09.channel =3D -1,
+=09=09.scan_index =3D 3,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 64,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09},
+};
+
+static int qcom_smgr_accel_probe(struct platform_device *pdev)
+{
+=09struct iio_dev *iio_dev;
+=09struct qcom_smgr_iio_priv *priv;
+=09int ret;
+
+=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+=09if (!iio_dev)
+=09=09return -ENOMEM;
+
+=09priv =3D iio_priv(iio_dev);
+=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+=09priv->sensor->iio_dev =3D iio_dev;
+
+=09iio_dev->name =3D "qcom-smgr-accel";
+=09iio_dev->info =3D &qcom_smgr_iio_info;
+=09iio_dev->channels =3D qcom_smgr_accel_iio_channels;
+=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_accel_iio_channels);
+
+=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+=09=09=09=09=09  &qcom_smgr_buffer_ops);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09platform_set_drvdata(pdev, priv->sensor);
+
+=09return 0;
+}
+
+static void qcom_smgr_accel_remove(struct platform_device *pdev)
+{
+=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
+
+=09sensor->iio_dev =3D NULL;
+}
+
+static const struct platform_device_id qcom_smgr_accel_ids[] =3D {
+=09{ .name =3D "qcom-smgr-accel" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_accel_ids);
+
+static struct platform_driver qcom_smgr_accel_driver =3D {
+=09.probe =3D qcom_smgr_accel_probe,
+=09.remove =3D qcom_smgr_accel_remove,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr_accel",
+=09},
+=09.id_table =3D qcom_smgr_accel_ids,
+};
+module_platform_driver(qcom_smgr_accel_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager accelerometer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 1ccb5ccf3706..0ad8b3972087 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -8,5 +8,6 @@ source "drivers/iio/common/hid-sensors/Kconfig"
 source "drivers/iio/common/inv_sensors/Kconfig"
 source "drivers/iio/common/ms_sensors/Kconfig"
 source "drivers/iio/common/scmi_sensors/Kconfig"
+source "drivers/iio/common/qcom_smgr/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
 source "drivers/iio/common/st_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index d3e952239a62..f3f18484c91b 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -13,5 +13,6 @@ obj-y +=3D hid-sensors/
 obj-y +=3D inv_sensors/
 obj-y +=3D ms_sensors/
 obj-y +=3D scmi_sensors/
+obj-y +=3D qcom_smgr/
 obj-y +=3D ssp_sensors/
 obj-y +=3D st_sensors/
diff --git a/drivers/iio/common/qcom_smgr/Kconfig b/drivers/iio/common/qcom=
_smgr/Kconfig
new file mode 100644
index 000000000000..da1965185001
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/Kconfig
@@ -0,0 +1,16 @@
+#
+# Qualcomm Sensor Manager IIO
+#
+
+config IIO_QCOM_SMGR
+=09tristate "Qualcomm SSC Sensor Manager"
+=09depends on ARCH_QCOM
+=09depends on QCOM_RPROC_COMMON
+=09select QCOM_QMI_HELPERS
+=09select IIO_BUFFER
+=09help
+=09  Say yes here to build core support for the Sensor Manager (SMGR)
+=09  service provided by the Qualcomm Snapdragon Sensor Core (SSC).
+
+=09  To compile this driver as a module, choose M here: the
+=09  module will be called smgr.
diff --git a/drivers/iio/common/qcom_smgr/Makefile b/drivers/iio/common/qco=
m_smgr/Makefile
new file mode 100644
index 000000000000..84554cedd2e5
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Qualcomm Sensor Manager driver
+#
+
+obj-y +=3D qmi/
+
+obj-$(CONFIG_IIO_QCOM_SMGR)=09+=3D qcom_smgr.o
diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/common/=
qcom_smgr/qcom_smgr.c
new file mode 100644
index 000000000000..8d46be11d5b6
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager core driver
+ *
+ * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc/qcom_rproc.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/soc/qcom/qrtr.h>
+#include <linux/types.h>
+#include <net/sock.h>
+
+#include "qmi/sns_smgr.h"
+
+#define SMGR_TICKS_PER_SECOND=09=0932768
+#define SMGR_REPORT_RATE_HZ=09=09(SMGR_TICKS_PER_SECOND * 2)
+#define SMGR_VALUE_DIV=09=09=0965536
+
+struct qcom_smgr {
+=09struct device *dev;
+
+=09struct qmi_handle sns_smgr_hdl;
+=09struct sockaddr_qrtr sns_smgr_info;
+=09struct work_struct sns_smgr_work;
+
+=09u8 sensor_count;
+=09struct qcom_smgr_sensor *sensors;
+};
+
+static const char *const qcom_smgr_sensor_type_platform_names[] =3D {
+=09[SNS_SMGR_SENSOR_TYPE_ACCEL] =3D "qcom-smgr-accel",
+=09[SNS_SMGR_SENSOR_TYPE_GYRO] =3D "qcom-smgr-gyro",
+=09[SNS_SMGR_SENSOR_TYPE_MAG] =3D "qcom-smgr-mag",
+=09[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] =3D "qcom-smgr-prox-light",
+=09[SNS_SMGR_SENSOR_TYPE_PRESSURE] =3D "qcom-smgr-pressure",
+=09[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] =3D "qcom-smgr-hall-effect"
+};
+
+static void qcom_smgr_unregister_sensor(void *data)
+{
+=09struct platform_device *pdev =3D data;
+
+=09platform_device_unregister(pdev);
+}
+
+static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
+=09=09=09=09     struct qcom_smgr_sensor *sensor)
+{
+=09struct platform_device *pdev;
+=09const char *name =3D qcom_smgr_sensor_type_platform_names[sensor->type]=
;
+
+=09pdev =3D platform_device_register_data(smgr->dev, name, sensor->id,
+=09=09=09=09=09     &sensor, sizeof(sensor));
+=09if (IS_ERR(pdev)) {
+=09=09dev_err(smgr->dev, "Failed to register %s: %pe\n", name, pdev);
+=09=09return PTR_ERR(pdev);
+=09}
+
+=09return devm_add_action_or_reset(smgr->dev, qcom_smgr_unregister_sensor,
+=09=09=09=09=09pdev);
+}
+
+static int qcom_smgr_request_all_sensor_info(struct qcom_smgr *smgr,
+=09=09=09=09=09     struct qcom_smgr_sensor **sensors)
+{
+=09struct sns_smgr_all_sensor_info_resp resp =3D {};
+=09struct qmi_txn txn;
+=09u8 i;
+=09int ret;
+
+=09dev_dbg(smgr->dev, "Getting available sensors\n");
+
+=09ret =3D qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+=09=09=09   sns_smgr_all_sensor_info_resp_ei, &resp);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to initialize QMI TXN: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &tx=
n,
+=09=09=09       SNS_SMGR_ALL_SENSOR_INFO_MSG_ID,
+=09=09=09       SNS_SMGR_ALL_SENSOR_INFO_REQ_MAX_LEN, NULL,
+=09=09=09       NULL);
+=09if (ret) {
+=09=09dev_err(smgr->dev,
+=09=09=09"Failed to send available sensors request: %d\n", ret);
+=09=09qmi_txn_cancel(&txn);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_txn_wait(&txn, 5 * HZ);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* Check the response */
+=09if (resp.result) {
+=09=09dev_err(smgr->dev, "Available sensors request failed: 0x%x\n",
+=09=09=09resp.result);
+=09=09return -EREMOTEIO;
+=09}
+
+=09*sensors =3D devm_kzalloc(smgr->dev,
+=09=09=09=09sizeof(struct qcom_smgr_sensor) * resp.item_len,
+=09=09=09=09GFP_KERNEL);
+
+=09for (i =3D 0; i < resp.item_len; ++i) {
+=09=09(*sensors)[i].id =3D resp.items[i].id;
+=09=09(*sensors)[i].type =3D
+=09=09=09sns_smgr_sensor_type_from_str(resp.items[i].type);
+=09}
+
+=09return resp.item_len;
+}
+
+static int qcom_smgr_request_single_sensor_info(struct qcom_smgr *smgr,
+=09=09=09=09=09=09struct qcom_smgr_sensor *sensor)
+{
+=09struct sns_smgr_single_sensor_info_req req =3D {
+=09=09.sensor_id =3D sensor->id,
+=09};
+=09struct sns_smgr_single_sensor_info_resp resp =3D {};
+=09struct qmi_txn txn;
+=09u8 i;
+=09int ret;
+
+=09dev_vdbg(smgr->dev, "Getting single sensor info for ID 0x%02x\n",
+=09=09 sensor->id);
+
+=09ret =3D qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+=09=09=09   sns_smgr_single_sensor_info_resp_ei, &resp);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to initialize QMI transaction: %d\n",
+=09=09=09ret);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &tx=
n,
+=09=09=09       SNS_SMGR_SINGLE_SENSOR_INFO_MSG_ID,
+=09=09=09       SNS_SMGR_SINGLE_SENSOR_INFO_REQ_MAX_LEN,
+=09=09=09       sns_smgr_single_sensor_info_req_ei, &req);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to send sensor data request: %d\n",
+=09=09=09ret);
+=09=09qmi_txn_cancel(&txn);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_txn_wait(&txn, 5 * HZ);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* Check the response */
+=09if (resp.result) {
+=09=09dev_err(smgr->dev, "Single sensor info request failed: 0x%x\n",
+=09=09=09resp.result);
+=09=09return -EREMOTEIO;
+=09}
+
+=09sensor->data_type_count =3D resp.data_type_len;
+=09sensor->data_types =3D
+=09=09devm_kzalloc(smgr->dev,
+=09=09=09     sizeof(struct qcom_smgr_data_type_item) *
+=09=09=09=09     sensor->data_type_count,
+=09=09=09     GFP_KERNEL);
+=09if (!sensor->data_types)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < sensor->data_type_count; ++i) {
+=09=09sensor->data_types[i].name =3D devm_kstrdup_const(
+=09=09=09smgr->dev, resp.data_types[i].name, GFP_KERNEL);
+=09=09sensor->data_types[i].vendor =3D devm_kstrdup_const(
+=09=09=09smgr->dev, resp.data_types[i].vendor, GFP_KERNEL);
+
+=09=09sensor->data_types[i].range =3D resp.data_types[i].range;
+
+=09=09sensor->data_types[i].native_sample_rate_count =3D
+=09=09=09resp.native_sample_rates[i].rate_count;
+=09=09if (sensor->data_types[i].native_sample_rate_count) {
+=09=09=09sensor->data_types[i]
+=09=09=09=09.native_sample_rates =3D devm_kmemdup_array(
+=09=09=09=09smgr->dev, resp.native_sample_rates[i].rates,
+=09=09=09=09sensor->data_types[i].native_sample_rate_count,
+=09=09=09=09sizeof(u16), GFP_KERNEL);
+=09=09=09if (!sensor->data_types[i].native_sample_rates)
+=09=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09sensor->data_types[i].max_sample_rate =3D
+=09=09=09resp.data_types[i].max_sample_rate_hz;
+=09}
+
+=09return 0;
+}
+
+static int qcom_smgr_request_buffering(struct qcom_smgr *smgr,
+=09=09=09=09       struct qcom_smgr_sensor *sensor,
+=09=09=09=09       bool enable)
+{
+=09struct sns_smgr_buffering_req req =3D {
+=09=09/*
+=09=09 * Reuse sensor ID as a report ID to avoid having to keep track
+=09=09 * of a separate set of IDs
+=09=09 */
+=09=09.report_id =3D sensor->id,
+=09=09.notify_suspend_valid =3D false
+=09};
+=09struct sns_smgr_buffering_resp resp =3D {};
+=09struct qmi_txn txn;
+=09u16 sample_rate =3D 0;
+=09int ret;
+
+=09if (enable) {
+=09=09req.action =3D SNS_SMGR_BUFFERING_ACTION_ADD;
+
+=09=09/*
+=09=09 * Report rate and sample rate can be configured separately.
+=09=09 * The former is the rate at which buffering report indications
+=09=09 * are sent, while the latter is the actual sample rate of the
+=09=09 * sensor. If report rate is set lower than sample rate,
+=09=09 * multiple samples can be bundled and sent in one report.
+=09=09 * A report cannot have 0 samples, therefore report rate cannot
+=09=09 * be higher than sample rate.
+=09=09 *
+=09=09 * Fow now we default to the maximum sample rate and set the
+=09=09 * report rate such that every report contains only 1 sample.
+=09=09 * This gives us the lowest latency.
+=09=09 */
+=09=09if (sensor->data_types[0].native_sample_rates)
+=09=09=09sample_rate =3D sensor->data_types[0].native_sample_rates
+=09=09=09=09=09[sensor->data_types[0]
+=09=09=09=09=09=09 .native_sample_rate_count - 1];
+
+=09=09/*
+=09=09 * SMGR may support a lower maximum sample rate than natively
+=09=09 * supported by the sensor.
+=09=09 */
+=09=09if (sample_rate =3D=3D 0 ||
+=09=09    sample_rate > sensor->data_types[0].max_sample_rate)
+=09=09=09sample_rate =3D sensor->data_types[0].max_sample_rate;
+
+=09=09req.report_rate =3D sample_rate * SMGR_REPORT_RATE_HZ;
+
+=09=09req.item_len =3D 1;
+=09=09req.items[0].sensor_id =3D sensor->id;
+=09=09req.items[0].data_type =3D SNS_SMGR_DATA_TYPE_PRIMARY;
+
+=09=09req.items[0].sampling_rate =3D sample_rate;
+
+=09=09/*
+=09=09 * Unknown fields set to values frequently seen in dumps and
+=09=09 * known to be working (although many different random values
+=09=09 * appear to not cause any trouble).
+=09=09 */
+=09=09req.items[0].val1 =3D 3;
+=09=09req.items[0].val2 =3D 1;
+=09} else
+=09=09req.action =3D SNS_SMGR_BUFFERING_ACTION_DELETE;
+
+=09ret =3D qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+=09=09=09   sns_smgr_buffering_resp_ei, &resp);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to initialize QMI TXN: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &tx=
n,
+=09=09=09       SNS_SMGR_BUFFERING_MSG_ID,
+=09=09=09       SNS_SMGR_BUFFERING_REQ_MAX_LEN,
+=09=09=09       sns_smgr_buffering_req_ei, &req);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to send buffering request: %d\n",
+=09=09=09ret);
+=09=09qmi_txn_cancel(&txn);
+=09=09return ret;
+=09}
+
+=09ret =3D qmi_txn_wait(&txn, 5 * HZ);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* Check the response */
+=09if (resp.result) {
+=09=09dev_err(smgr->dev, "Buffering request failed: 0x%x\n",
+=09=09=09resp.result);
+=09=09return -EREMOTEIO;
+=09}
+
+=09/* Keep track of requested sample rate */
+=09sensor->data_types[0].cur_sample_rate =3D sample_rate;
+
+=09return 0;
+}
+
+static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
+=09=09=09=09=09       struct sockaddr_qrtr *sq,
+=09=09=09=09=09       struct qmi_txn *txn,
+=09=09=09=09=09       const void *data)
+{
+=09struct qcom_smgr *smgr =3D
+=09=09container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
+=09struct sns_smgr_buffering_report_ind *ind =3D
+=09=09(struct sns_smgr_buffering_report_ind *)data;
+=09struct qcom_smgr_sensor *sensor;
+=09u8 i;
+
+=09for (i =3D 0; i < smgr->sensor_count; ++i) {
+=09=09sensor =3D &smgr->sensors[i];
+
+=09=09/* Find sensor matching report */
+=09=09if (sensor->id !=3D ind->report_id)
+=09=09=09continue;
+
+=09=09if (!sensor->iio_dev)
+=09=09=09/* Corresponding driver was unloaded. Ignore remaining reports. *=
/
+=09=09=09return;
+
+=09=09/*
+=09=09 * Since we are matching report rate with sample rate, we only
+=09=09 * get a single sample in every report.
+=09=09 */
+=09=09iio_push_to_buffers_with_timestamp(sensor->iio_dev,
+=09=09=09=09=09=09   ind->samples[0].values,
+=09=09=09=09=09=09   ind->metadata.timestamp);
+
+=09=09break;
+=09}
+}
+
+static const struct qmi_msg_handler qcom_smgr_msg_handlers[] =3D {
+=09{
+=09=09.type =3D QMI_INDICATION,
+=09=09.msg_id =3D SNS_SMGR_BUFFERING_REPORT_MSG_ID,
+=09=09.ei =3D sns_smgr_buffering_report_ind_ei,
+=09=09.decoded_size =3D sizeof(struct sns_smgr_buffering_report_ind),
+=09=09.fn =3D qcom_smgr_buffering_report_handler,
+=09},
+=09{}
+};
+
+static int qcom_smgr_sensor_postenable(struct iio_dev *iio_dev)
+{
+=09struct qcom_smgr *smgr =3D dev_get_drvdata(iio_dev->dev.parent->parent)=
;
+=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
+=09struct qcom_smgr_sensor *sensor =3D priv->sensor;
+
+=09return qcom_smgr_request_buffering(smgr, sensor, true);
+}
+
+static int qcom_smgr_sensor_postdisable(struct iio_dev *iio_dev)
+{
+=09struct qcom_smgr *smgr =3D dev_get_drvdata(iio_dev->dev.parent->parent)=
;
+=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
+=09struct qcom_smgr_sensor *sensor =3D priv->sensor;
+
+=09return qcom_smgr_request_buffering(smgr, sensor, false);
+}
+
+const struct iio_buffer_setup_ops qcom_smgr_buffer_ops =3D {
+=09.postenable =3D &qcom_smgr_sensor_postenable,
+=09.postdisable =3D &qcom_smgr_sensor_postdisable
+};
+EXPORT_SYMBOL_GPL(qcom_smgr_buffer_ops);
+
+static int qcom_smgr_iio_read_raw(struct iio_dev *iio_dev,
+=09=09=09=09  struct iio_chan_spec const *chan, int *val,
+=09=09=09=09  int *val2, long mask)
+{
+=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09*val =3D priv->sensor->data_types[0].cur_sample_rate;
+=09=09return IIO_VAL_INT;
+=09case IIO_CHAN_INFO_SCALE:
+=09=09switch (chan->type) {
+=09=09case IIO_PROXIMITY:
+=09=09=09/*
+=09=09=09 * Proximity value is reported as (SMGR_VALUE_DIV - x)/SMGR_VALUE=
_DIV of
+=09=09=09 * the sensor range. As with sensor values, range is also reporte=
d as range
+=09=09=09 * in meters * SMGR_VALUE_DIV. Proximity in meters can be calcula=
ted as
+=09=09=09 * such:
+=09=09=09 *
+=09=09=09 * proximity =3D -value * range / SMGR_VALUE_DIV**2
+=09=09=09 *
+=09=09=09 * Since our denominator (val2) is an int, we cannot fit SMGR_VAL=
UE_DIV**2.
+=09=09=09 * Without losing too much accuracy, we can instead divide by 2 i=
n the
+=09=09=09 * numerator and denominator, and move the -1 coefficient to the
+=09=09=09 * denominator. This way we can exactly fit within the lower boun=
d of int.
+=09=09=09 */
+=09=09=09*val =3D priv->sensor->data_types[0].range / 2;
+=09=09=09*val2 =3D -SMGR_VALUE_DIV / 2 * SMGR_VALUE_DIV;
+=09=09=09return IIO_VAL_FRACTIONAL;
+=09=09default:
+=09=09=09/*
+=09=09=09 * Sensor values are generally reported as 1/SMGR_VALUE_DIVths of=
 the
+=09=09=09 * corresponding unit.
+=09=09=09 */
+=09=09=09*val =3D 1;
+=09=09=09*val2 =3D SMGR_VALUE_DIV;
+=09=09=09return IIO_VAL_FRACTIONAL;
+=09=09}
+=09case IIO_CHAN_INFO_OFFSET:
+=09=09/*
+=09=09 * Proximity values are inverted and start from the upper bound as e=
xplained above.
+=09=09 * No other channel types have an offset.
+=09=09 */
+=09=09*val =3D priv->sensor->data_types[0].range;
+=09=09*val2 =3D SMGR_VALUE_DIV;
+=09=09return IIO_VAL_FRACTIONAL;
+=09}
+
+=09return -EINVAL;
+}
+
+static int qcom_smgr_iio_write_raw(struct iio_dev *iio_dev,
+=09=09=09=09   struct iio_chan_spec const *chan, int val,
+=09=09=09=09   int val2, long mask)
+{
+=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09priv->sensor->data_types[0].cur_sample_rate =3D val;
+
+=09=09/*
+=09=09 * Send new SMGR buffering request with updated rates
+=09=09 * if buffer is enabled
+=09=09 */
+=09=09if (iio_buffer_enabled(iio_dev))
+=09=09=09return iio_dev->setup_ops->postenable(iio_dev);
+
+=09=09return 0;
+=09}
+
+=09return -EINVAL;
+}
+
+static int qcom_smgr_iio_read_avail(struct iio_dev *iio_dev,
+=09=09=09=09    struct iio_chan_spec const *chan,
+=09=09=09=09    const int **vals, int *type, int *length,
+=09=09=09=09    long mask)
+{
+=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
+=09const int samp_freq_vals[3] =3D {
+=09=091, 1, priv->sensor->data_types[0].cur_sample_rate
+=09};
+
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SAMP_FREQ:
+=09=09*type =3D IIO_VAL_INT;
+=09=09*vals =3D samp_freq_vals;
+=09=09*length =3D ARRAY_SIZE(samp_freq_vals);
+=09=09return IIO_AVAIL_RANGE;
+=09}
+
+=09return -EINVAL;
+}
+
+const struct iio_info qcom_smgr_iio_info =3D {
+=09.read_raw =3D qcom_smgr_iio_read_raw,
+=09.write_raw =3D qcom_smgr_iio_write_raw,
+=09.read_avail =3D qcom_smgr_iio_read_avail,
+};
+EXPORT_SYMBOL_GPL(qcom_smgr_iio_info);
+
+/* SMGR reports values for 3-axis sensors in north-east-down coordinates *=
/
+static const struct iio_mount_matrix qcom_smgr_iio_mount_matrix =3D {
+=09.rotation =3D {
+=09=09"0", "-1", "0",
+=09=09"-1", "0", "0",
+=09=09"0", "0", "1"
+=09}
+};
+
+static const struct iio_mount_matrix *
+qcom_smgr_iio_get_mount_matrix(const struct iio_dev *iio_dev,
+=09=09=09       const struct iio_chan_spec *chan)
+{
+=09return &qcom_smgr_iio_mount_matrix;
+}
+
+const struct iio_chan_spec_ext_info qcom_smgr_iio_ext_info[] =3D {
+=09IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qcom_smgr_iio_get_mount_matrix),
+=09{}
+};
+EXPORT_SYMBOL_GPL(qcom_smgr_iio_ext_info);
+
+static int qcom_smgr_probe(struct qrtr_device *qdev)
+{
+=09struct qcom_smgr *smgr;
+=09int i, j;
+=09int ret;
+
+=09smgr =3D devm_kzalloc(&qdev->dev, sizeof(*smgr), GFP_KERNEL);
+=09if (!smgr)
+=09=09return -ENOMEM;
+
+=09smgr->dev =3D &qdev->dev;
+
+=09smgr->sns_smgr_info.sq_family =3D AF_QIPCRTR;
+=09smgr->sns_smgr_info.sq_node =3D qdev->node;
+=09smgr->sns_smgr_info.sq_port =3D qdev->port;
+
+=09dev_set_drvdata(&qdev->dev, smgr);
+
+=09ret =3D qmi_handle_init(&smgr->sns_smgr_hdl,
+=09=09=09      SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
+=09=09=09      qcom_smgr_msg_handlers);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev,
+=09=09=09"Failed to initialize sensor manager handle: %d\n",
+=09=09=09ret);
+=09=09return ret;
+=09}
+
+=09ret =3D qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
+=09if (ret < 0) {
+=09=09dev_err(smgr->dev, "Failed to get available sensors: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+=09smgr->sensor_count =3D ret;
+
+=09/* Get primary and secondary sensors from each sensor ID */
+=09for (i =3D 0; i < smgr->sensor_count; i++) {
+=09=09ret =3D qcom_smgr_request_single_sensor_info(smgr,
+=09=09=09=09=09=09=09   &smgr->sensors[i]);
+=09=09if (ret < 0) {
+=09=09=09dev_err(smgr->dev,
+=09=09=09=09"Failed to get sensors from ID 0x%02x: %pe\n",
+=09=09=09=09smgr->sensors[i].id, ERR_PTR(ret));
+=09=09=09return ret;
+=09=09}
+
+=09=09for (j =3D 0; j < smgr->sensors[i].data_type_count; j++) {
+=09=09=09/* Default to maximum sample rate */
+=09=09=09smgr->sensors[i].data_types->cur_sample_rate =3D
+=09=09=09=09smgr->sensors[i].data_types->max_sample_rate;
+
+=09=09=09dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
+=09=09=09=09smgr->sensors[i].id, j,
+=09=09=09=09smgr->sensors[i].data_types[j].vendor,
+=09=09=09=09smgr->sensors[i].data_types[j].name);
+=09=09}
+
+=09=09qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
+=09}
+
+=09return 0;
+}
+
+static void qcom_smgr_remove(struct qrtr_device *qdev)
+{
+=09struct qcom_smgr *smgr =3D dev_get_drvdata(&qdev->dev);
+
+=09qmi_handle_release(&smgr->sns_smgr_hdl);
+}
+
+static const struct qrtr_device_id qcom_smgr_qrtr_match[] =3D {
+=09{
+=09=09.service =3D SNS_SMGR_QMI_SVC_ID,
+=09=09.instance =3D QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
+=09=09=09=09=09  SNS_SMGR_QMI_INS_ID)
+=09},
+=09{},
+};
+MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);
+
+static struct qrtr_driver qcom_smgr_driver =3D {
+=09.probe =3D qcom_smgr_probe,
+=09.remove =3D qcom_smgr_remove,
+=09.id_table =3D qcom_smgr_qrtr_match,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr",
+=09},
+};
+module_qrtr_driver(qcom_smgr_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/qcom_smgr/qmi/Makefile b/drivers/iio/common=
/qcom_smgr/qmi/Makefile
new file mode 100644
index 000000000000..e5722f0f8f68
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_IIO_QCOM_SMGR)=09+=3D sns_smgr.o
diff --git a/drivers/iio/common/qcom_smgr/qmi/sns_smgr.c b/drivers/iio/comm=
on/qcom_smgr/qmi/sns_smgr.c
new file mode 100644
index 000000000000..624e3074a051
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * QMI element info arrays and helper functions for Qualcomm Sensor Manage=
r
+ *
+ * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/module.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/types.h>
+
+#include "sns_smgr.h"
+
+static const struct qmi_elem_info sns_smgr_all_sensor_info_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_all_sensor_info, id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_all_sensor_info, id),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_all_sensor_info, type_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_all_sensor_info, type_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D SNS_SMGR_SENSOR_TYPE_MAX_LEN,
+=09=09.elem_size =3D sizeof(char),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_all_sensor_info, type),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+const struct qmi_elem_info sns_smgr_all_sensor_info_resp_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_all_sensor_info_resp,
+=09=09=09=09=09  result),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x02,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_all_sensor_info_resp, result),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_all_sensor_info_resp,
+=09=09=09=09=09  item_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_all_sensor_info_resp,
+=09=09=09=09   item_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN,
+=09=09.elem_size =3D sizeof(struct sns_smgr_all_sensor_info),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_all_sensor_info_resp, items),
+=09=09.ei_array =3D sns_smgr_all_sensor_info_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_all_sensor_info_resp_ei);
+
+const struct qmi_elem_info sns_smgr_single_sensor_info_req_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_req, sensor_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x01,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_req,
+=09=09=09=09   sensor_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_single_sensor_info_req_ei);
+
+static const struct qmi_elem_info sns_smgr_single_sensor_info_data_type_ei=
[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09sensor_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   sensor_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09data_type),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   data_type),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type, name_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   name_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 0xff,
+=09=09.elem_size =3D sizeof(char),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   name),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09vendor_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   vendor_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 0xff,
+=09=09.elem_size =3D sizeof(char),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   vendor),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type, val1),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   val1),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09max_sample_rate_hz),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   max_sample_rate_hz),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type, val2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   val2),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09current_ua),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   current_ua),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type, range),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   range),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_data_type,
+=09=09=09resolution),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_data_type,
+=09=09=09=09   resolution),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+static const struct qmi_elem_info sns_smgr_single_sensor_info_native_sampl=
e_rates_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_native_sample_rates, rate_coun=
t),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_native_sampl=
e_rates,
+=09=09=09=09   rate_count),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN,
+=09=09.elem_size =3D sizeof(u16),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_native_sampl=
e_rates,
+=09=09=09=09   rates),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+const struct qmi_elem_info sns_smgr_single_sensor_info_resp_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, result),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x02,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   result),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, data_type_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data_type_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D
+=09=09=09sizeof(struct sns_smgr_single_sensor_info_data_type),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data_types),
+=09=09.ei_array =3D sns_smgr_single_sensor_info_data_type_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, data1_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data1_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D sizeof(u32),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data1),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, data2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x11,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data2),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, data3_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x12,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data3_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_8_BYTE,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D sizeof(u64),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x12,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data3),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp,
+=09=09=09native_sample_rates_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x13,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   native_sample_rates_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D sizeof(
+=09=09=09struct sns_smgr_single_sensor_info_native_sample_rates),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x13,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   native_sample_rates),
+=09=09.ei_array =3D sns_smgr_single_sensor_info_native_sample_rates_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_single_sensor_info_resp, data5_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x14,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data5_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D sizeof(u32),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x14,
+=09=09.offset =3D offsetof(struct sns_smgr_single_sensor_info_resp,
+=09=09=09=09   data5),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_single_sensor_info_resp_ei);
+
+static const struct qmi_elem_info sns_smgr_buffering_req_item_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req_item,
+=09=09=09=09=09  sensor_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_req_item, sensor_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req_item,
+=09=09=09=09=09  data_type),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_req_item, data_type),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req_item,
+=09=09=09=09=09  val1),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req_item,
+=09=09=09=09   val1),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req_item,
+=09=09=09=09=09  sampling_rate),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req_item,
+=09=09=09=09   sampling_rate),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req_item,
+=09=09=09=09=09  val2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req_item,
+=09=09=09=09   val2),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+static const struct qmi_elem_info sns_smgr_buffering_req_notify_suspend_ei=
[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_req_notify_suspend,
+=09=09=09proc_type),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req_notify_suspend,
+=09=09=09=09   proc_type),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_req_notify_suspend,
+=09=09=09send_indications_during_suspend),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req_notify_suspend,
+=09=09=09=09   send_indications_during_suspend),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+const struct qmi_elem_info sns_smgr_buffering_req_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_req, report_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x01,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req, report_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_req, action),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x02,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req, action),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req,
+=09=09=09=09=09  report_rate),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req, report_rate),
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_req, item_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x04,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req, item_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D SNS_SMGR_DATA_TYPE_COUNT,
+=09=09.elem_size =3D sizeof(struct sns_smgr_buffering_req_item),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x04,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req, items),
+=09=09.ei_array =3D sns_smgr_buffering_req_item_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_OPT_FLAG,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req,
+=09=09=09=09=09  notify_suspend_valid),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_req,
+=09=09=09=09   notify_suspend_valid),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_req,
+=09=09=09=09=09  notify_suspend),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_req, notify_suspend),
+=09=09.ei_array =3D sns_smgr_buffering_req_notify_suspend_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_req_ei);
+
+const struct qmi_elem_info sns_smgr_buffering_resp_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_resp, result),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x02,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_resp, result),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_resp, report_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_resp, report_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_resp, ack_nak),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x11,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_resp, ack_nak),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_resp_ei);
+
+static const struct qmi_elem_info sns_smgr_buffering_report_metadata_ei[] =
=3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_metadata, val1),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_metadata,
+=09=09=09=09   val1),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D
+=09=09=09sizeof_field(struct sns_smgr_buffering_report_metadata,
+=09=09=09=09     sample_count),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_metadata,
+=09=09=09=09   sample_count),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_metadata, timestamp),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_metadata,
+=09=09=09=09   timestamp),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_metadata, val2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_metadata,
+=09=09=09=09   val2),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+static const struct qmi_elem_info sns_smgr_buffering_report_sample_ei[] =
=3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_4_BYTE,
+=09=09.elem_len =3D 3,
+=09=09.elem_size =3D sizeof(u32),
+=09=09.array_type =3D STATIC_ARRAY,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_sample,
+=09=09=09=09   values),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_sample, val1),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_report_sample, val1),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_sample, val2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_report_sample, val2),
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_2_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(
+=09=09=09struct sns_smgr_buffering_report_sample, val3),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_report_sample, val3),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+
+const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[] =3D {
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
+=09=09=09=09=09  report_id),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x01,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_ind,
+=09=09=09=09   report_id),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
+=09=09=09=09=09  metadata),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x02,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_ind,
+=09=09=09=09   metadata),
+=09=09.ei_array =3D sns_smgr_buffering_report_metadata_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_DATA_LEN,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
+=09=09=09=09=09  samples_len),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_ind,
+=09=09=09=09   samples_len),
+=09},
+=09{
+=09=09.data_type =3D QMI_STRUCT,
+=09=09.elem_len =3D SNS_SMGR_SAMPLES_MAX_LEN,
+=09=09.elem_size =3D sizeof(struct sns_smgr_buffering_report_sample),
+=09=09.array_type =3D VAR_LEN_ARRAY,
+=09=09.tlv_type =3D 0x03,
+=09=09.offset =3D
+=09=09=09offsetof(struct sns_smgr_buffering_report_ind, samples),
+=09=09.ei_array =3D sns_smgr_buffering_report_sample_ei,
+=09},
+=09{
+=09=09.data_type =3D QMI_UNSIGNED_1_BYTE,
+=09=09.elem_len =3D 1,
+=09=09.elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
+=09=09=09=09=09  val2),
+=09=09.array_type =3D NO_ARRAY,
+=09=09.tlv_type =3D 0x10,
+=09=09.offset =3D offsetof(struct sns_smgr_buffering_report_ind, val2),
+=09},
+=09{
+=09=09.data_type =3D QMI_EOTI,
+=09},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_report_ind_ei);
+
+static const char *smgr_sensor_type_names[SNS_SMGR_SENSOR_TYPE_COUNT] =3D =
{
+=09[SNS_SMGR_SENSOR_TYPE_ACCEL] =3D "ACCEL",
+=09[SNS_SMGR_SENSOR_TYPE_GYRO] =3D "GYRO",
+=09[SNS_SMGR_SENSOR_TYPE_MAG] =3D "MAG",
+=09[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] =3D "PROX_LIGHT",
+=09[SNS_SMGR_SENSOR_TYPE_PRESSURE] =3D "PRESSURE",
+=09[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] =3D "HALL_EFFECT"
+};
+
+enum qcom_smgr_sensor_type sns_smgr_sensor_type_from_str(const char *str)
+{
+=09enum qcom_smgr_sensor_type i;
+
+=09for (i =3D SNS_SMGR_SENSOR_TYPE_UNKNOWN + 1;
+=09     i < SNS_SMGR_SENSOR_TYPE_COUNT; i++)
+=09=09if (!strcmp(str, smgr_sensor_type_names[i]))
+=09=09=09return i;
+
+=09return SNS_SMGR_SENSOR_TYPE_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(sns_smgr_sensor_type_from_str);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h b/drivers/iio/comm=
on/qcom_smgr/qmi/sns_smgr.h
new file mode 100644
index 000000000000..a741dfd87452
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SSC_SNS_SMGR_H__
+#define __SSC_SNS_SMGR_H__
+
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/types.h>
+
+/*
+ * The structures of QMI messages used by the service were determined
+ * purely by watching transactions between proprietary Android userspace
+ * components and SSC. along with comparing values reported by Android API=
s
+ * to values received in response messages. Due to that, the purpose or
+ * meaning of many fields remains unknown. Such fields are named "val*",
+ * "data*" or similar. Furthermore, the true maximum sizes of some message=
s
+ * with unknown array fields may be different than defined here.
+ */
+
+#define SNS_SMGR_QMI_SVC_ID=09=09=090x0100
+#define SNS_SMGR_QMI_SVC_V1=09=09=091
+#define SNS_SMGR_QMI_INS_ID=09=09=0950
+
+#define SNS_SMGR_ALL_SENSOR_INFO_MSG_ID=09=090x05
+#define SNS_SMGR_SINGLE_SENSOR_INFO_MSG_ID=090x06
+#define SNS_SMGR_BUFFERING_MSG_ID=09=090x21
+#define SNS_SMGR_BUFFERING_REPORT_MSG_ID=090x22
+
+#define SNS_SMGR_ALL_SENSOR_INFO_REQ_MAX_LEN=09=090x0
+#define SNS_SMGR_ALL_SENSOR_INFO_RESP_MAX_LEN=09=090x3e
+#define SNS_SMGR_SINGLE_SENSOR_INFO_REQ_MAX_LEN=09=090x4
+#define SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN=090x110
+#define SNS_SMGR_BUFFERING_REQ_MAX_LEN=09=09=090x30
+#define SNS_SMGR_BUFFERING_RESP_MAX_LEN=09=09=090x1e
+
+/* TODO: find actual maximums */
+#define SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN=090x10
+#define SNS_SMGR_SENSOR_TYPE_MAX_LEN=09=090x10
+#define SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN=090x20
+#define SNS_SMGR_SAMPLES_MAX_LEN=09=090x100
+
+enum sns_smgr_buffering_action {
+=09SNS_SMGR_BUFFERING_ACTION_ADD=09 =3D 1,
+=09SNS_SMGR_BUFFERING_ACTION_DELETE =3D 2,
+};
+
+struct sns_smgr_all_sensor_info {
+=09u8 id;
+=09u8 type_len;
+=09char type[SNS_SMGR_SENSOR_TYPE_MAX_LEN];
+};
+
+struct sns_smgr_all_sensor_info_resp {
+=09u16 result;
+=09u8 item_len;
+=09struct sns_smgr_all_sensor_info items[SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN]=
;
+};
+
+struct sns_smgr_single_sensor_info_req {
+=09u8 sensor_id;
+};
+
+struct sns_smgr_single_sensor_info_data_type {
+=09u8 sensor_id;
+=09u8 data_type;
+=09u8 name_len;
+=09char name[0xff];
+=09u8 vendor_len;
+=09char vendor[0xff];
+=09/*
+=09 * Might be separate u8 or u16 fields, but taken as a u32 it is seen
+=09 * to hold the value 1 for all sensors in dumps.
+=09 */
+=09u32 val1;
+=09u16 max_sample_rate_hz;
+=09u16 val2;
+=09u16 current_ua;
+=09u32 range;
+=09u32 resolution;
+};
+
+struct sns_smgr_single_sensor_info_native_sample_rates {
+=09u8 rate_count;
+=09u16 rates[SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN];
+};
+
+struct sns_smgr_single_sensor_info_resp {
+=09u16 result;
+=09u8 data_type_len;
+=09struct sns_smgr_single_sensor_info_data_type data_types[SNS_SMGR_DATA_T=
YPE_COUNT];
+=09u8 data1_len;
+=09u32 data1[SNS_SMGR_DATA_TYPE_COUNT];
+=09u32 data2;
+=09u8 data3_len;
+=09u64 data3[SNS_SMGR_DATA_TYPE_COUNT];
+=09u8 native_sample_rates_len;
+=09struct sns_smgr_single_sensor_info_native_sample_rates
+=09=09native_sample_rates[SNS_SMGR_DATA_TYPE_COUNT];
+=09u8 data5_len;
+=09u32 data5[SNS_SMGR_DATA_TYPE_COUNT];
+};
+
+struct sns_smgr_buffering_req_item {
+=09u8 sensor_id;
+=09u8 data_type;
+=09u16 val1;
+=09u16 sampling_rate;
+=09u16 val2;
+};
+
+struct sns_smgr_buffering_req_notify_suspend {
+=09u16 proc_type;
+=09u16 send_indications_during_suspend;
+};
+
+struct sns_smgr_buffering_req {
+=09u8 report_id;
+=09u8 action;
+=09u32 report_rate;
+=09u8 item_len;
+=09struct sns_smgr_buffering_req_item items[SNS_SMGR_DATA_TYPE_COUNT];
+=09u8 notify_suspend_valid;
+=09struct sns_smgr_buffering_req_notify_suspend notify_suspend;
+};
+
+struct sns_smgr_buffering_resp {
+=09u16 result;
+=09u8 report_id;
+=09u8 ack_nak;
+};
+
+struct sns_smgr_buffering_report_metadata {
+=09u32 val1;
+=09u8 sample_count;
+=09u32 timestamp;
+=09u32 val2;
+};
+
+struct sns_smgr_buffering_report_sample {
+=09u32 values[3];
+=09u8 val1;
+=09u8 val2;
+=09u16 val3;
+};
+
+struct sns_smgr_buffering_report_ind {
+=09u8 report_id;
+=09struct sns_smgr_buffering_report_metadata metadata;
+=09u8 samples_len;
+=09struct sns_smgr_buffering_report_sample samples[SNS_SMGR_SAMPLES_MAX_LE=
N];
+=09u8 val2;
+};
+
+extern const struct qmi_elem_info sns_smgr_all_sensor_info_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_single_sensor_info_req_ei[];
+extern const struct qmi_elem_info sns_smgr_single_sensor_info_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_req_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[];
+
+extern enum qcom_smgr_sensor_type sns_smgr_sensor_type_from_str(const char=
 *str);
+
+#endif /* __SSC_SNS_SMGR_H__ */
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 3e193ee0fb61..b9ee2c3b5bc5 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -147,6 +147,16 @@ config IIO_ST_GYRO_3AXIS
 =09  Also need to enable at least one of I2C and SPI interface drivers
 =09  below.
=20
+config IIO_QCOM_SMGR_GYRO
+=09tristate "Qualcomm SSC Sensor Manager Gyroscope Sensor"
+=09depends on IIO_QCOM_SMGR
+=09select IIO_BUFFER
+=09select IIO_KFIFO_BUF
+=09help
+=09  Say yes here to get support for gyroscopes connected to
+=09  a Qualcomm Snapdragon Sensor Core and accessed through its
+=09  Sensor Manager service.
+
 config IIO_ST_GYRO_I2C_3AXIS
 =09tristate "STMicroelectronics gyroscopes 3-Axis I2C Interface"
 =09depends on I2C && IIO_ST_GYRO_3AXIS
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 0319b397dc3f..63ff40acdedc 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -28,6 +28,8 @@ itg3200-y               :=3D itg3200_core.o
 itg3200-$(CONFIG_IIO_BUFFER) +=3D itg3200_buffer.o
 obj-$(CONFIG_ITG3200)   +=3D itg3200.o
=20
+obj-$(CONFIG_IIO_QCOM_SMGR_ACCEL) +=3D qcom_smgr_gyro.o
+
 obj-$(CONFIG_IIO_SSP_SENSORS_COMMONS) +=3D ssp_gyro_sensor.o
=20
 obj-$(CONFIG_IIO_ST_GYRO_3AXIS) +=3D st_gyro.o
diff --git a/drivers/iio/gyro/qcom_smgr_gyro.c b/drivers/iio/gyro/qcom_smgr=
_gyro.c
new file mode 100644
index 000000000000..4cb55c6fe9e8
--- /dev/null
+++ b/drivers/iio/gyro/qcom_smgr_gyro.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager gyroscope driver
+ *
+ * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_chan_spec qcom_smgr_gyro_iio_channels[] =3D {
+=09{
+=09=09.type =3D IIO_ANGL_VEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_X,
+=09=09.scan_index =3D 0,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_ANGL_VEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Y,
+=09=09.scan_index =3D 1,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_ANGL_VEL,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Z,
+=09=09.scan_index =3D 2,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_TIMESTAMP,
+=09=09.channel =3D -1,
+=09=09.scan_index =3D 3,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 64,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09},
+};
+
+static int qcom_smgr_gyro_probe(struct platform_device *pdev)
+{
+=09struct iio_dev *iio_dev;
+=09struct qcom_smgr_iio_priv *priv;
+=09int ret;
+
+=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+=09if (!iio_dev)
+=09=09return -ENOMEM;
+
+=09priv =3D iio_priv(iio_dev);
+=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+=09priv->sensor->iio_dev =3D iio_dev;
+
+=09iio_dev->name =3D "qcom-smgr-gyro";
+=09iio_dev->info =3D &qcom_smgr_iio_info;
+=09iio_dev->channels =3D qcom_smgr_gyro_iio_channels;
+=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_gyro_iio_channels);
+
+=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+=09=09=09=09=09  &qcom_smgr_buffer_ops);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09platform_set_drvdata(pdev, priv->sensor);
+
+=09return 0;
+}
+
+static void qcom_smgr_gyro_remove(struct platform_device *pdev)
+{
+=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
+
+=09sensor->iio_dev =3D NULL;
+}
+
+static const struct platform_device_id qcom_smgr_gyro_ids[] =3D {
+=09{ .name =3D "qcom-smgr-gyro" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_gyro_ids);
+
+static struct platform_driver qcom_smgr_gyro_driver =3D {
+=09.probe =3D qcom_smgr_gyro_probe,
+=09.remove =3D qcom_smgr_gyro_remove,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr_gyro",
+=09},
+=09.id_table =3D qcom_smgr_gyro_ids,
+};
+module_platform_driver(qcom_smgr_gyro_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager gyroscope driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kc=
onfig
index 3debf1320ad1..917c123f08bb 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,15 @@ config MMC35240
 =09  To compile this driver as a module, choose M here: the module
 =09  will be called mmc35240.
=20
+config IIO_QCOM_SMGR_MAG
+=09tristate "Qualcomm SSC Sensor Manager Magnetometer"
+=09depends on IIO_QCOM_SMGR
+=09select IIO_BUFFER
+=09select IIO_KFIFO_BUF
+=09help
+=09  Say yes here to get support for magnetometers connected to a Qualcomm
+=09  Snapdragon Sensor Core and accessed through its Sensor Manager servic=
e.
+
 config IIO_ST_MAGN_3AXIS
 =09tristate "STMicroelectronics magnetometers 3-Axis Driver"
 =09depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/M=
akefile
index 9297723a97d8..7576c226239b 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_MAG3110)=09+=3D mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) +=3D hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)=09+=3D mmc35240.o
=20
+obj-$(CONFIG_IIO_QCOM_SMGR_MAG) +=3D qcom_smgr_mag.o
+
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) +=3D st_magn.o
 st_magn-y :=3D st_magn_core.o
 st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
diff --git a/drivers/iio/magnetometer/qcom_smgr_mag.c b/drivers/iio/magneto=
meter/qcom_smgr_mag.c
new file mode 100644
index 000000000000..dc197db509bc
--- /dev/null
+++ b/drivers/iio/magnetometer/qcom_smgr_mag.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager magnetometer driver
+ *
+ * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_chan_spec qcom_smgr_mag_iio_channels[] =3D {
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_X,
+=09=09.scan_index =3D 0,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Y,
+=09=09.scan_index =3D 1,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_MAGN,
+=09=09.modified =3D true,
+=09=09.channel2 =3D IIO_MOD_Z,
+=09=09.scan_index =3D 2,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 's',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+=09=09.ext_info =3D qcom_smgr_iio_ext_info
+=09},
+=09{
+=09=09.type =3D IIO_TIMESTAMP,
+=09=09.channel =3D -1,
+=09=09.scan_index =3D 3,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 64,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09},
+};
+
+static int qcom_smgr_mag_probe(struct platform_device *pdev)
+{
+=09struct iio_dev *iio_dev;
+=09struct qcom_smgr_iio_priv *priv;
+=09int ret;
+
+=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+=09if (!iio_dev)
+=09=09return -ENOMEM;
+
+=09priv =3D iio_priv(iio_dev);
+=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+=09priv->sensor->iio_dev =3D iio_dev;
+
+=09iio_dev->name =3D "qcom-smgr-mag";
+=09iio_dev->info =3D &qcom_smgr_iio_info;
+=09iio_dev->channels =3D qcom_smgr_mag_iio_channels;
+=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_mag_iio_channels);
+
+=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+=09=09=09=09=09  &qcom_smgr_buffer_ops);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09platform_set_drvdata(pdev, priv->sensor);
+
+=09return 0;
+}
+
+static void qcom_smgr_mag_remove(struct platform_device *pdev)
+{
+=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
+
+=09sensor->iio_dev =3D NULL;
+}
+
+static const struct platform_device_id qcom_smgr_mag_ids[] =3D {
+=09{ .name =3D "qcom-smgr-mag" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_mag_ids);
+
+static struct platform_driver qcom_smgr_mag_driver =3D {
+=09.probe =3D qcom_smgr_mag_probe,
+=09.remove =3D qcom_smgr_mag_remove,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr_mag",
+=09},
+=09.id_table =3D qcom_smgr_mag_ids,
+};
+module_platform_driver(qcom_smgr_mag_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager magnetometer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index d2cb8c871f6a..ca1053472969 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -67,6 +67,16 @@ config IIO_CROS_EC_BARO
 =09  To compile this driver as a module, choose M here: the module
 =09  will be called cros_ec_baro.
=20
+config IIO_QCOM_SMGR_PRESSURE
+=09tristate "Qualcomm SSC Sensor Manager Pressure Sensor"
+=09depends on IIO_QCOM_SMGR
+=09select IIO_BUFFER
+=09select IIO_KFIFO_BUF
+=09help
+=09  Say yes here to get support for pressure sensors connected to
+=09  a Qualcomm Snapdragon Sensor Core and accessed through its Sensor
+=09  Manager service.
+
 config DLHL60D
 =09tristate "All Sensors DLHL60D and DLHL60G low voltage digital pressure =
sensors"
 =09depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 6482288e07ee..0e4a1fbef7b8 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BMP280_SPI) +=3D bmp280-spi.o
 obj-$(CONFIG_DLHL60D) +=3D dlhl60d.o
 obj-$(CONFIG_DPS310) +=3D dps310.o
 obj-$(CONFIG_IIO_CROS_EC_BARO) +=3D cros_ec_baro.o
+obj-$(CONFIG_IIO_QCOM_SMGR_PROX) +=3D qcom_smgr_pressure.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   +=3D hid-sensor-press.o
 obj-$(CONFIG_HP03) +=3D hp03.o
 obj-$(CONFIG_HSC030PA) +=3D hsc030pa.o
diff --git a/drivers/iio/pressure/qcom_smgr_pressure.c b/drivers/iio/pressu=
re/qcom_smgr_pressure.c
new file mode 100644
index 000000000000..66e165ad5c9a
--- /dev/null
+++ b/drivers/iio/pressure/qcom_smgr_pressure.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager pressure sensor driver
+ *
+ * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_chan_spec qcom_smgr_pressure_iio_channels[] =3D {
+=09{
+=09=09.type =3D IIO_PRESSURE,
+=09=09.scan_index =3D 0,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_OFFSET) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SAMP_FREQ)
+=09},
+=09{
+=09=09.type =3D IIO_TIMESTAMP,
+=09=09.channel =3D -1,
+=09=09.scan_index =3D 3,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 64,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09},
+};
+
+static int qcom_smgr_pressure_probe(struct platform_device *pdev)
+{
+=09struct iio_dev *iio_dev;
+=09struct qcom_smgr_iio_priv *priv;
+=09int ret;
+
+=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+=09if (!iio_dev)
+=09=09return -ENOMEM;
+
+=09priv =3D iio_priv(iio_dev);
+=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+=09priv->sensor->iio_dev =3D iio_dev;
+
+=09iio_dev->name =3D "qcom-smgr-pressure";
+=09iio_dev->info =3D &qcom_smgr_iio_info;
+=09iio_dev->channels =3D qcom_smgr_pressure_iio_channels;
+=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_pressure_iio_channels);
+
+=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+=09=09=09=09=09  &qcom_smgr_buffer_ops);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09platform_set_drvdata(pdev, priv->sensor);
+
+=09return 0;
+}
+
+static void qcom_smgr_pressure_remove(struct platform_device *pdev)
+{
+=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
+
+=09sensor->iio_dev =3D NULL;
+}
+
+static const struct platform_device_id qcom_smgr_pressure_ids[] =3D {
+=09{ .name =3D "qcom-smgr-pressure" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_pressure_ids);
+
+static struct platform_driver qcom_smgr_pressure_driver =3D {
+=09.probe =3D qcom_smgr_pressure_probe,
+=09.remove =3D qcom_smgr_pressure_remove,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr_pressure",
+=09},
+=09.id_table =3D qcom_smgr_pressure_ids,
+};
+module_platform_driver(qcom_smgr_pressure_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager pressure sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index a562a78b7d0d..486514e54cc1 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -46,6 +46,16 @@ config HX9023S
 =09  To compile this driver as a module, choose M here: the
 =09  module will be called hx9023s.
=20
+config IIO_QCOM_SMGR_PROX
+=09tristate "Qualcomm SSC Sensor Manager Proximity Sensor"
+=09depends on IIO_QCOM_SMGR
+=09select IIO_BUFFER
+=09select IIO_KFIFO_BUF
+=09help
+=09  Say yes here to get support for proximity sensors connected to
+=09  a Qualcomm Snapdragon Sensor Core and accessed through its Sensor
+=09  Manager service.
+
 config IRSD200
 =09tristate "Murata IRS-D200 PIR sensor"
 =09select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefil=
e
index c5e76995764a..c3dab31e1fc1 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AS3935)=09=09+=3D as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) +=3D cros_ec_mkbp_proximity.o
 obj-$(CONFIG_HX9023S)=09=09+=3D hx9023s.o
+obj-$(CONFIG_IIO_QCOM_SMGR_PROX) +=3D qcom_smgr_prox.o
 obj-$(CONFIG_IRSD200)=09=09+=3D irsd200.o
 obj-$(CONFIG_ISL29501)=09=09+=3D isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)=09+=3D pulsedlight-lidar-lite-v2.o
diff --git a/drivers/iio/proximity/qcom_smgr_prox.c b/drivers/iio/proximity=
/qcom_smgr_prox.c
new file mode 100644
index 000000000000..2900fb7b7a20
--- /dev/null
+++ b/drivers/iio/proximity/qcom_smgr_prox.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager proximity sensor driver
+ *
+ * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+static const struct iio_chan_spec qcom_smgr_prox_iio_channels[] =3D {
+=09{
+=09=09.type =3D IIO_PROXIMITY,
+=09=09.scan_index =3D 0,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 32,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_OFFSET) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09=09      BIT(IIO_CHAN_INFO_SAMP_FREQ)
+=09},
+=09{
+=09=09.type =3D IIO_TIMESTAMP,
+=09=09.channel =3D -1,
+=09=09.scan_index =3D 3,
+=09=09.scan_type =3D {
+=09=09=09.sign =3D 'u',
+=09=09=09.realbits =3D 32,
+=09=09=09.storagebits =3D 64,
+=09=09=09.endianness =3D IIO_LE,
+=09=09},
+=09},
+};
+
+static int qcom_smgr_prox_probe(struct platform_device *pdev)
+{
+=09struct iio_dev *iio_dev;
+=09struct qcom_smgr_iio_priv *priv;
+=09int ret;
+
+=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+=09if (!iio_dev)
+=09=09return -ENOMEM;
+
+=09priv =3D iio_priv(iio_dev);
+=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+=09priv->sensor->iio_dev =3D iio_dev;
+
+=09iio_dev->name =3D "qcom-smgr-prox";
+=09iio_dev->info =3D &qcom_smgr_iio_info;
+=09iio_dev->channels =3D qcom_smgr_prox_iio_channels;
+=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_prox_iio_channels);
+
+=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+=09=09=09=09=09  &qcom_smgr_buffer_ops);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
+=09if (ret) {
+=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+=09=09=09ERR_PTR(ret));
+=09=09return ret;
+=09}
+
+=09platform_set_drvdata(pdev, priv->sensor);
+
+=09return 0;
+}
+
+static void qcom_smgr_prox_remove(struct platform_device *pdev)
+{
+=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
+
+=09sensor->iio_dev =3D NULL;
+}
+
+static const struct platform_device_id qcom_smgr_prox_ids[] =3D {
+=09{ .name =3D "qcom-smgr-prox-light" },
+=09{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_prox_ids);
+
+static struct platform_driver qcom_smgr_prox_driver =3D {
+=09.probe =3D qcom_smgr_prox_probe,
+=09.remove =3D qcom_smgr_prox_remove,
+=09.driver=09=3D {
+=09=09.name =3D "qcom_smgr_prox",
+=09},
+=09.id_table =3D qcom_smgr_prox_ids,
+};
+module_platform_driver(qcom_smgr_prox_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager proximity sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/common/qcom_smgr.h b/include/linux/iio/commo=
n/qcom_smgr.h
new file mode 100644
index 000000000000..756cb83e26ec
--- /dev/null
+++ b/include/linux/iio/common/qcom_smgr.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __QCOM_SMGR_H__
+#define __QCOM_SMGR_H__
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/types.h>
+
+enum qcom_smgr_sensor_type {
+=09SNS_SMGR_SENSOR_TYPE_UNKNOWN,
+=09SNS_SMGR_SENSOR_TYPE_ACCEL,
+=09SNS_SMGR_SENSOR_TYPE_GYRO,
+=09SNS_SMGR_SENSOR_TYPE_MAG,
+=09SNS_SMGR_SENSOR_TYPE_PROX_LIGHT,
+=09SNS_SMGR_SENSOR_TYPE_PRESSURE,
+=09SNS_SMGR_SENSOR_TYPE_HALL_EFFECT,
+
+=09SNS_SMGR_SENSOR_TYPE_COUNT
+};
+
+enum qcom_smgr_data_type {
+=09SNS_SMGR_DATA_TYPE_PRIMARY,
+=09SNS_SMGR_DATA_TYPE_SECONDARY,
+
+=09SNS_SMGR_DATA_TYPE_COUNT
+};
+
+struct qcom_smgr_data_type_item {
+=09const char *name;
+=09const char *vendor;
+
+=09u32 range;
+
+=09size_t native_sample_rate_count;
+=09u16 *native_sample_rates;
+
+=09u16 max_sample_rate;
+=09u16 cur_sample_rate;
+};
+
+struct qcom_smgr_sensor {
+=09u8 id;
+=09enum qcom_smgr_sensor_type type;
+
+=09u8 data_type_count;
+=09/*
+=09 * Only SNS_SMGR_DATA_TYPE_PRIMARY is used at the moment, but we store
+=09 * SNS_SMGR_DATA_TYPE_SECONDARY when available as well for future use.
+=09 */
+=09struct qcom_smgr_data_type_item *data_types;
+
+=09struct iio_dev *iio_dev;
+};
+
+struct qcom_smgr_iio_priv {
+=09struct qcom_smgr_sensor *sensor;
+};
+
+extern const struct iio_buffer_setup_ops qcom_smgr_buffer_ops;
+extern const struct iio_info qcom_smgr_iio_info;
+extern const struct iio_chan_spec_ext_info qcom_smgr_iio_ext_info[];
+
+#endif /* __QCOM_SMGR_H__ */
--=20
2.49.0



