Return-Path: <linux-iio+bounces-21508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D9AFFBBE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0272B7A5F05
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650228C2B7;
	Thu, 10 Jul 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1mJNoAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27528BA85;
	Thu, 10 Jul 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134791; cv=none; b=SPo7kwLVFtE8ixSG2yrgpM6fHwncqyKFA6i6N7CAtSB0e8NKtwMlFTQ7r06LY6EJx/OMzeTTPbcbbvvYusiIfbG2Z2gn+2PD2CFvDz2vPAuAjtTOob2X6rgsH1LEWadBhj2Mps/c0PWbtU73FHXdgR07e6qhpSKPAPyYFJJ3ZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134791; c=relaxed/simple;
	bh=htRBoIczoOp4Og0zBNLXEu3VzyqYOQLKOWW9CuTS4P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tALkl+fScufXHnLSq+B9Rogg+c+mULroE2+A+pH3uBnJSieSWV0JdzJPFmx6z/Wa/T9Qt1MAj8aLUmbmLErovVFPiaCnI4P+sYs/QhrSrkkiixWGVW3hnXqpSsuDIWg5i1fSHRz3DF0CVgWxJs0BtD73K/tq8MuShe17RWu2gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1mJNoAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADE1C113D0;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134791;
	bh=htRBoIczoOp4Og0zBNLXEu3VzyqYOQLKOWW9CuTS4P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H1mJNoAG+2kwLVK+nDgKLqHBuslTvQX88225bZealu/P8efc0vB/BCbRyYYuvYL3s
	 Bon42fm2cY6nHxA1ZEOc74+MyhKg8DgGthhjl1Fjb/+s/1lcvqSEEx6w3pLbnlvJ9y
	 YqpO5TG/De+aX8wL7IV6NQiX/vLcr18UW/328buLHZlrmihtQxFDOlBfVTD1BBOBbv
	 ODBwyPIyOd+qpnPDlW65iM8zkNXoboTnx8S4quwZ/fH5nb8HFFIP7uKDS+3/Hf2pXW
	 hBJ8Z0erJpD8tK7+FxXp/hPYFfpHGbAPmnbRRmJz4+s0jxEzfsVU5Ch5TmsuDT85Fh
	 hW69/8HaVaTgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC15C83F1A;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Date: Thu, 10 Jul 2025 09:06:30 +0100
Subject: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
In-Reply-To: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752134788; l=60335;
 i=y.oudjana@protonmail.com; s=20250710; h=from:subject:message-id;
 bh=Gc2DH6kkSHNi0gOWRr3ov8zs35p+GBLQEFu50V4nhIY=;
 b=06M8Y/NmwP6lOO74zhclohdS5l/XNU4VY+imNJ1++JKcDhE7pmdxLrtQVgZjEcqUuZABWAshp
 kABwHDnbSzgBuy2bHhHPAqy2pE1PdUhD3zfwRTAMYZYbGm0twNacZqh
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=kZKEHR1e5QKCbhElU9LF/T1SbfTr8xzy2cO8fN70QgY=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20250710 with
 auth_id=455
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a driver for sensors exposed by the Qualcomm Sensor Manager service,
which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
include accelerometers, gyroscopes, pressure sensors, proximity sensors
and magnetometers.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                                     |  13 +
 drivers/iio/accel/qcom_smgr_accel.c             | 138 ++++
 drivers/iio/common/Kconfig                      |   1 +
 drivers/iio/common/Makefile                     |   1 +
 drivers/iio/common/qcom_smgr/Kconfig            |  16 +
 drivers/iio/common/qcom_smgr/Makefile           |   8 +
 drivers/iio/common/qcom_smgr/qcom_smgr.c        | 840 ++++++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/Makefile       |   3 +
 drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c | 713 ++++++++++++++++++++
 drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h | 161 +++++
 include/linux/iio/common/qcom_smgr.h            |  80 +++
 11 files changed, 1974 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5a472a544cfe2ad87691209c34d7bafe058ba42..0fb91c9bce431fc899776ff10b728ecdc957f51a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20702,6 +20702,19 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
+QUALCOMM SENSOR MANAGER IIO DRIVER
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/common/qcom_smgr/Kconfig
+F:	drivers/iio/common/qcom_smgr/Makefile
+F:	drivers/iio/common/qcom_smgr/qcom_smgr.c
+F:	drivers/iio/common/qcom_smgr/qmi/Makefile
+F:	drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c
+F:	drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h
+F:	include/linux/iio/common/qcom_smgr.h
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qcom_smgr_accel.c
new file mode 100644
index 0000000000000000000000000000000000000000..ce854312d1d9386300785f1965d5886c16995806
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
+static const struct iio_chan_spec qcom_smgr_accel_iio_channels[] = {
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_X,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Y,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Z,
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	},
+};
+
+static int qcom_smgr_accel_probe(struct platform_device *pdev)
+{
+	struct iio_dev *iio_dev;
+	struct qcom_smgr_iio_priv *priv;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(iio_dev);
+	priv->sensor = *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
+	priv->sensor->iio_dev = iio_dev;
+
+	iio_dev->name = "qcom-smgr-accel";
+	iio_dev->info = &qcom_smgr_iio_info;
+	iio_dev->channels = qcom_smgr_accel_iio_channels;
+	iio_dev->num_channels = ARRAY_SIZE(qcom_smgr_accel_iio_channels);
+
+	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
+					  &qcom_smgr_buffer_ops);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&pdev->dev, iio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv->sensor);
+
+	return 0;
+}
+
+static void qcom_smgr_accel_remove(struct platform_device *pdev)
+{
+	struct qcom_smgr_sensor *sensor = platform_get_drvdata(pdev);
+
+	sensor->iio_dev = NULL;
+}
+
+static const struct platform_device_id qcom_smgr_accel_ids[] = {
+	{ .name = "qcom-smgr-accel" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, qcom_smgr_accel_ids);
+
+static struct platform_driver qcom_smgr_accel_driver = {
+	.probe = qcom_smgr_accel_probe,
+	.remove = qcom_smgr_accel_remove,
+	.driver	= {
+		.name = "qcom_smgr_accel",
+	},
+	.id_table = qcom_smgr_accel_ids,
+};
+module_platform_driver(qcom_smgr_accel_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager accelerometer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 1ccb5ccf3706609fc57a4ade7c6a4354fa41c6bd..0ad8b39720874ca64a5560384e8cb6ae78fac1cf 100644
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
index d3e952239a62191decd0bf3e84c7b59cc46bcfb3..f3f18484c91b9215f9302985fcc7e0aa401a7a4e 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -13,5 +13,6 @@ obj-y += hid-sensors/
 obj-y += inv_sensors/
 obj-y += ms_sensors/
 obj-y += scmi_sensors/
+obj-y += qcom_smgr/
 obj-y += ssp_sensors/
 obj-y += st_sensors/
diff --git a/drivers/iio/common/qcom_smgr/Kconfig b/drivers/iio/common/qcom_smgr/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..30baee9b0eff2bf90a6047f14c4dfb9d70d28792
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/Kconfig
@@ -0,0 +1,16 @@
+#
+# Qualcomm Sensor Manager IIO
+#
+
+config IIO_QCOM_SMGR
+	tristate "Qualcomm SSC Sensor Manager"
+	depends on ARCH_QCOM
+	depends on QRTR_SMD
+	select QCOM_QMI_HELPERS
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for the Sensor Manager (SMGR)
+	  service provided by the Qualcomm Snapdragon Sensor Core (SSC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called smgr.
diff --git a/drivers/iio/common/qcom_smgr/Makefile b/drivers/iio/common/qcom_smgr/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..84554cedd2e5f2f13c04df884e1b51d3b9d8a9cf
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Qualcomm Sensor Manager driver
+#
+
+obj-y += qmi/
+
+obj-$(CONFIG_IIO_QCOM_SMGR)	+= qcom_smgr.o
diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/common/qcom_smgr/qcom_smgr.c
new file mode 100644
index 0000000000000000000000000000000000000000..79d1160f7a5c32f1a9e0a20f29e304e5cb18be8f
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
@@ -0,0 +1,840 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Sensor Manager driver
+ *
+ * Copyright (c) 2021-2025, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc/qcom_rproc.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/soc/qcom/qrtr.h>
+#include <linux/types.h>
+#include <net/sock.h>
+
+#include "qmi/qmi_sns_smgr.h"
+
+MODULE_IMPORT_NS("QRTR");
+
+#define SMGR_TICKS_PER_SECOND		32768
+#define SMGR_REPORT_RATE_HZ		(SMGR_TICKS_PER_SECOND * 2)
+#define SMGR_VALUE_DECIMAL_OFFSET	16
+
+static int qcom_smgr_request_all_sensor_info(struct qcom_smgr *smgr,
+					     struct qcom_smgr_sensor **sensors)
+{
+	struct sns_smgr_all_sensor_info_resp resp = {};
+	struct qmi_txn txn;
+	u8 i;
+	int ret;
+
+	dev_dbg(smgr->dev, "Getting available sensors\n");
+
+	ret = qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+			   sns_smgr_all_sensor_info_resp_ei, &resp);
+	if (ret < 0) {
+		dev_err(smgr->dev, "Failed to initialize QMI TXN: %d\n", ret);
+		return ret;
+	}
+
+	ret = qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &txn,
+			       SNS_SMGR_ALL_SENSOR_INFO_MSG_ID,
+			       SNS_SMGR_ALL_SENSOR_INFO_REQ_MAX_LEN, NULL,
+			       NULL);
+	if (ret) {
+		dev_err(smgr->dev,
+			"Failed to send available sensors request: %d\n", ret);
+		qmi_txn_cancel(&txn);
+		return ret;
+	}
+
+	ret = qmi_txn_wait(&txn, 5 * HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Check the response */
+	if (resp.result) {
+		dev_err(smgr->dev, "Available sensors request failed: 0x%x\n",
+			resp.result);
+		return -EREMOTEIO;
+	}
+
+	*sensors = devm_kzalloc(smgr->dev,
+				sizeof(struct qcom_smgr_sensor) * resp.item_len,
+				GFP_KERNEL);
+
+	for (i = 0; i < resp.item_len; ++i) {
+		(*sensors)[i].id = resp.items[i].id;
+		(*sensors)[i].type =
+			sns_smgr_sensor_type_from_str(resp.items[i].type);
+	}
+
+	return resp.item_len;
+}
+
+static int qcom_smgr_request_single_sensor_info(struct qcom_smgr *smgr,
+						struct qcom_smgr_sensor *sensor)
+{
+	struct sns_smgr_single_sensor_info_req req = {
+		.sensor_id = sensor->id,
+	};
+	struct sns_smgr_single_sensor_info_resp resp = {};
+	struct qmi_txn txn;
+	u8 i;
+	int ret;
+
+	dev_vdbg(smgr->dev, "Getting single sensor info for ID 0x%02x\n",
+		 sensor->id);
+
+	ret = qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+			   sns_smgr_single_sensor_info_resp_ei, &resp);
+	if (ret < 0) {
+		dev_err(smgr->dev, "Failed to initialize QMI transaction: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &txn,
+			       SNS_SMGR_SINGLE_SENSOR_INFO_MSG_ID,
+			       SNS_SMGR_SINGLE_SENSOR_INFO_REQ_MAX_LEN,
+			       sns_smgr_single_sensor_info_req_ei, &req);
+	if (ret < 0) {
+		dev_err(smgr->dev, "Failed to send sensor data request: %d\n",
+			ret);
+		qmi_txn_cancel(&txn);
+		return ret;
+	}
+
+	ret = qmi_txn_wait(&txn, 5 * HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Check the response */
+	if (resp.result) {
+		dev_err(smgr->dev, "Single sensor info request failed: 0x%x\n",
+			resp.result);
+		return -EREMOTEIO;
+	}
+
+	sensor->data_type_count = resp.data_type_len;
+	sensor->data_types =
+		devm_kzalloc(smgr->dev,
+			     sizeof(struct qcom_smgr_data_type_item) *
+				     sensor->data_type_count,
+			     GFP_KERNEL);
+	if (!sensor->data_types)
+		return -ENOMEM;
+
+	for (i = 0; i < sensor->data_type_count; ++i) {
+		sensor->data_types[i].name = devm_kstrdup_const(
+			smgr->dev, resp.data_types[i].name, GFP_KERNEL);
+		sensor->data_types[i].vendor = devm_kstrdup_const(
+			smgr->dev, resp.data_types[i].vendor, GFP_KERNEL);
+
+		sensor->data_types[i].range = resp.data_types[i].range;
+
+		sensor->data_types[i].native_sample_rate_count =
+			resp.native_sample_rates[i].rate_count;
+		if (sensor->data_types[i].native_sample_rate_count) {
+			sensor->data_types[i]
+				.native_sample_rates = devm_kmemdup_array(
+				smgr->dev, resp.native_sample_rates[i].rates,
+				sensor->data_types[i].native_sample_rate_count,
+				sizeof(u16), GFP_KERNEL);
+			if (!sensor->data_types[i].native_sample_rates)
+				return -ENOMEM;
+		}
+
+		sensor->data_types[i].max_sample_rate =
+			resp.data_types[i].max_sample_rate_hz;
+	}
+
+	return 0;
+}
+
+static int qcom_smgr_request_buffering(struct qcom_smgr *smgr,
+				       struct qcom_smgr_sensor *sensor,
+				       bool enable)
+{
+	struct sns_smgr_buffering_req req = {
+		/*
+		 * Reuse sensor ID as a report ID to avoid having to keep track
+		 * of a separate set of IDs
+		 */
+		.report_id = sensor->id,
+		.notify_suspend_valid = false
+	};
+	struct sns_smgr_buffering_resp resp = {};
+	struct qmi_txn txn;
+	u16 sample_rate = 0;
+	int ret;
+
+	if (enable) {
+		req.action = SNS_SMGR_BUFFERING_ACTION_ADD;
+
+		/*
+		 * Report rate and sample rate can be configured separately.
+		 * The former is the rate at which buffering report indications
+		 * are sent, while the latter is the actual sample rate of the
+		 * sensor. If report rate is set lower than sample rate,
+		 * multiple samples can be bundled and sent in one report.
+		 * A report cannot have 0 samples, therefore report rate cannot
+		 * be higher than sample rate.
+		 *
+		 * Fow now we default to the maximum sample rate and set the
+		 * report rate such that every report contains only 1 sample.
+		 * This gives us the lowest latency.
+		 */
+		if (sensor->data_types[0].native_sample_rates)
+			sample_rate = sensor->data_types[0].native_sample_rates
+					[sensor->data_types[0]
+						 .native_sample_rate_count - 1];
+
+		/*
+		 * SMGR may support a lower maximum sample rate than natively
+		 * supported by the sensor.
+		 */
+		if (sample_rate == 0 ||
+		    sample_rate > sensor->data_types[0].max_sample_rate)
+			sample_rate = sensor->data_types[0].max_sample_rate;
+
+		req.report_rate = sample_rate * SMGR_REPORT_RATE_HZ;
+
+		req.item_len = 1;
+		req.items[0].sensor_id = sensor->id;
+		req.items[0].data_type = SNS_SMGR_DATA_TYPE_PRIMARY;
+
+		req.items[0].sampling_rate = sample_rate;
+
+		/*
+		 * Unknown fields set to values frequently seen in dumps and
+		 * known to be working (although many different random values
+		 * appear to not cause any trouble).
+		 */
+		req.items[0].val1 = 3;
+		req.items[0].val2 = 1;
+	} else
+		req.action = SNS_SMGR_BUFFERING_ACTION_DELETE;
+
+	ret = qmi_txn_init(&smgr->sns_smgr_hdl, &txn,
+			   sns_smgr_buffering_resp_ei, &resp);
+	if (ret < 0) {
+		dev_err(smgr->dev, "Failed to initialize QMI TXN: %d\n", ret);
+		return ret;
+	}
+
+	ret = qmi_send_request(&smgr->sns_smgr_hdl, &smgr->sns_smgr_info, &txn,
+			       SNS_SMGR_BUFFERING_MSG_ID,
+			       SNS_SMGR_BUFFERING_REQ_MAX_LEN,
+			       sns_smgr_buffering_req_ei, &req);
+	if (ret < 0) {
+		dev_err(smgr->dev, "Failed to send buffering request: %d\n",
+			ret);
+		qmi_txn_cancel(&txn);
+		return ret;
+	}
+
+	ret = qmi_txn_wait(&txn, 5 * HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Check the response */
+	if (resp.result) {
+		dev_err(smgr->dev, "Buffering request failed: 0x%x\n",
+			resp.result);
+		return -EREMOTEIO;
+	}
+
+	/* Keep track of requested sample rate */
+	sensor->data_types[0].cur_sample_rate = sample_rate;
+
+	return 0;
+}
+
+static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
+					       struct sockaddr_qrtr *sq,
+					       struct qmi_txn *txn,
+					       const void *data)
+{
+	struct qcom_smgr *smgr =
+		container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
+	const struct sns_smgr_buffering_report_ind *ind = data;
+	struct qcom_smgr_sensor *sensor;
+	struct qcom_smgr_iio_data iio_data;
+	int temp;
+	u8 i, j;
+
+	for (i = 0; i < smgr->sensor_count; ++i) {
+		sensor = &smgr->sensors[i];
+
+		/* Find sensor matching report */
+		if (sensor->id == ind->report_id)
+			break;
+	}
+
+	if (i == smgr->sensor_count) {
+		dev_warn_ratelimited(smgr->dev,
+			"Received buffering report with unknown ID: %02x",
+			ind->report_id);
+		return;
+	}
+
+	/*
+	 * Construct data to be passed to IIO. Since we are matching report rate
+	 * with sample rate, we only get a single sample in every report.
+	 */
+	for (j = 0; j < ARRAY_SIZE(ind->samples[0].values); ++j)
+		iio_data.values[j] = ind->samples[0].values[j];
+
+	/*
+	 * SMGR reports sensor data in 32-bit fixed-point values, with 16 bits
+	 * holding the integer part and the other 16 bits holding the numerator
+	 * of a fraction with the denominator 2**16.
+	 *
+	 * Proximity sensor values are reported differently from other sensors.
+	 * The value reported is a boolean (0 or 1, still in the same fixed-point
+	 * format) where 1 means the sensor is activated, i.e. something is
+	 * within its range. Use the reported range to pass an actual distance
+	 * value to IIO. We pass the sensor range when nothing is within range
+	 * (sensor maxed out) and 0 when something is within range (assume
+	 * sensor is covered).
+	 */
+	if (sensor->type == SNS_SMGR_SENSOR_TYPE_PROX_LIGHT) {
+		temp = le32_to_cpu(iio_data.values[0]);
+		temp >>= SMGR_VALUE_DECIMAL_OFFSET;
+		temp = ~temp & 1;
+		temp *= sensor->data_types[0].range;
+		iio_data.values[0] = cpu_to_le32(temp);
+	}
+
+	iio_push_to_buffers(sensor->iio_dev, &iio_data);
+}
+
+static const struct qmi_msg_handler qcom_smgr_msg_handlers[] = {
+	{
+		.type = QMI_INDICATION,
+		.msg_id = SNS_SMGR_BUFFERING_REPORT_MSG_ID,
+		.ei = sns_smgr_buffering_report_ind_ei,
+		.decoded_size = sizeof(struct sns_smgr_buffering_report_ind),
+		.fn = qcom_smgr_buffering_report_handler,
+	},
+	{ }
+};
+
+static int qcom_smgr_sensor_postenable(struct iio_dev *iio_dev)
+{
+	struct qcom_smgr *smgr = dev_get_drvdata(iio_dev->dev.parent);
+	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
+	struct qcom_smgr_sensor *sensor = priv->sensor;
+
+	return qcom_smgr_request_buffering(smgr, sensor, true);
+}
+
+static int qcom_smgr_sensor_predisable(struct iio_dev *iio_dev)
+{
+	struct qcom_smgr *smgr = dev_get_drvdata(iio_dev->dev.parent);
+	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
+	struct qcom_smgr_sensor *sensor = priv->sensor;
+
+	dev_info(smgr->dev, "disable buffering %02x\n", sensor->id);
+	return qcom_smgr_request_buffering(smgr, sensor, false);
+}
+
+static const struct iio_buffer_setup_ops qcom_smgr_buffer_ops = {
+	.postenable = &qcom_smgr_sensor_postenable,
+	.predisable = &qcom_smgr_sensor_predisable
+};
+
+/* SMGR reports values for 3-axis sensors in north-east-down coordinates */
+static const struct iio_mount_matrix qcom_smgr_iio_mount_matrix = {
+	.rotation = {
+		"0", "-1", "0",
+		"-1", "0", "0",
+		"0", "0", "1"
+	}
+};
+
+static const struct iio_mount_matrix *
+qcom_smgr_iio_get_mount_matrix(const struct iio_dev *iio_dev,
+			       const struct iio_chan_spec *chan)
+{
+	return &qcom_smgr_iio_mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info qcom_smgr_iio_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qcom_smgr_iio_get_mount_matrix),
+	{ }
+};
+
+static int qcom_smgr_iio_read_raw(struct iio_dev *iio_dev,
+				  struct iio_chan_spec const *chan, int *val,
+				  int *val2, long mask)
+{
+	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = priv->sensor->data_types[0].cur_sample_rate;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 1 << SMGR_VALUE_DECIMAL_OFFSET;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qcom_smgr_iio_write_raw(struct iio_dev *iio_dev,
+				   struct iio_chan_spec const *chan, int val,
+				   int val2, long mask)
+{
+	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!iio_device_claim_direct(iio_dev))
+			return -EBUSY;
+
+		priv->sensor->data_types[0].cur_sample_rate = val;
+
+		iio_device_release_direct(iio_dev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qcom_smgr_iio_read_avail(struct iio_dev *iio_dev,
+				    struct iio_chan_spec const *chan,
+				    const int **vals, int *type, int *length,
+				    long mask)
+{
+	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = priv->samp_freq_vals;
+		*length = ARRAY_SIZE(priv->samp_freq_vals);
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info qcom_smgr_iio_info = {
+	.read_raw = qcom_smgr_iio_read_raw,
+	.write_raw = qcom_smgr_iio_write_raw,
+	.read_avail = qcom_smgr_iio_read_avail,
+};
+
+static const struct iio_chan_spec qcom_smgr_accel_iio_channels[] = {
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_X,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Y,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Z,
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	}
+};
+
+static const struct iio_chan_spec qcom_smgr_gyro_iio_channels[] = {
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = true,
+		.channel2 = IIO_MOD_X,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Y,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = true,
+		.channel2 = IIO_MOD_Z,
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	}
+};
+
+static const struct iio_chan_spec qcom_smgr_mag_iio_channels[] = {
+	{
+		.type = IIO_MAGN,
+		.modified = true,
+		.channel2 = IIO_MOD_X,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_MAGN,
+		.modified = true,
+		.channel2 = IIO_MOD_Y,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_MAGN,
+		.modified = true,
+		.channel2 = IIO_MOD_Z,
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = qcom_smgr_iio_ext_info
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	}
+};
+
+static const struct iio_chan_spec qcom_smgr_prox_iio_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ)
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	},
+};
+
+static const struct iio_chan_spec qcom_smgr_pressure_iio_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
+		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ)
+	},
+	{
+		.type = IIO_TIMESTAMP,
+		.channel = -1,
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 64,
+			.endianness = IIO_LE,
+		},
+	}
+};
+
+static const char *const qcom_smgr_sensor_type_device_names[] = {
+	[SNS_SMGR_SENSOR_TYPE_ACCEL] = "qcom-smgr-accel",
+	[SNS_SMGR_SENSOR_TYPE_GYRO] = "qcom-smgr-gyro",
+	[SNS_SMGR_SENSOR_TYPE_MAG] = "qcom-smgr-mag",
+	[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] = "qcom-smgr-prox-light",
+	[SNS_SMGR_SENSOR_TYPE_PRESSURE] = "qcom-smgr-pressure",
+	[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] = "qcom-smgr-hall-effect"
+};
+
+static const struct iio_chan_spec *const qcom_smgr_sensor_type_iio_channels[] = {
+	[SNS_SMGR_SENSOR_TYPE_ACCEL] = qcom_smgr_accel_iio_channels,
+	[SNS_SMGR_SENSOR_TYPE_GYRO] = qcom_smgr_gyro_iio_channels,
+	[SNS_SMGR_SENSOR_TYPE_MAG] = qcom_smgr_mag_iio_channels,
+	[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] = qcom_smgr_prox_iio_channels,
+	[SNS_SMGR_SENSOR_TYPE_PRESSURE] = qcom_smgr_pressure_iio_channels,
+	[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] = NULL /* Unsupported */
+};
+
+static const size_t qcom_smgr_sensor_type_num_channels[] = {
+	[SNS_SMGR_SENSOR_TYPE_ACCEL] = ARRAY_SIZE(qcom_smgr_accel_iio_channels),
+	[SNS_SMGR_SENSOR_TYPE_GYRO] = ARRAY_SIZE(qcom_smgr_gyro_iio_channels),
+	[SNS_SMGR_SENSOR_TYPE_MAG] = ARRAY_SIZE(qcom_smgr_mag_iio_channels),
+	[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] = ARRAY_SIZE(qcom_smgr_prox_iio_channels),
+	[SNS_SMGR_SENSOR_TYPE_PRESSURE] = ARRAY_SIZE(qcom_smgr_pressure_iio_channels)
+};
+
+static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
+				     struct qcom_smgr_sensor *sensor)
+{
+	struct iio_dev *iio_dev;
+	struct qcom_smgr_iio_priv *priv;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(smgr->dev, sizeof(*priv));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(iio_dev);
+	priv->sensor = sensor;
+
+	priv->samp_freq_vals[0] = 1;
+	priv->samp_freq_vals[1] = 1;
+	priv->samp_freq_vals[2] = priv->sensor->data_types[0].max_sample_rate;
+
+	iio_dev->name = qcom_smgr_sensor_type_device_names[sensor->type];
+	iio_dev->info = &qcom_smgr_iio_info;
+	iio_dev->channels = qcom_smgr_sensor_type_iio_channels[sensor->type];
+	iio_dev->num_channels = qcom_smgr_sensor_type_num_channels[sensor->type];
+
+	sensor->iio_dev = iio_dev;
+
+	ret = devm_iio_kfifo_buffer_setup(smgr->dev, iio_dev,
+					  &qcom_smgr_buffer_ops);
+	if (ret) {
+		dev_err(smgr->dev, "Failed to setup buffer: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = devm_iio_device_register(smgr->dev, iio_dev);
+	if (ret) {
+		dev_err(smgr->dev, "Failed to register IIO device: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_smgr_probe(struct qrtr_device *qdev)
+{
+	struct qcom_smgr *smgr;
+	int i, j;
+	int ret;
+
+	smgr = devm_kzalloc(&qdev->dev, sizeof(*smgr), GFP_KERNEL);
+	if (!smgr)
+		return -ENOMEM;
+
+	smgr->dev = &qdev->dev;
+
+	smgr->sns_smgr_info.sq_family = AF_QIPCRTR;
+	smgr->sns_smgr_info.sq_node = qdev->node;
+	smgr->sns_smgr_info.sq_port = qdev->port;
+
+	dev_set_drvdata(&qdev->dev, smgr);
+
+	ret = qmi_handle_init(&smgr->sns_smgr_hdl,
+			      SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
+			      qcom_smgr_msg_handlers);
+	if (ret < 0)
+		return dev_err_probe(smgr->dev, ret,
+			"Failed to initialize sensor manager handle\n");
+
+	ret = devm_add_action_or_reset(smgr->dev,
+				       (void(*)(void *))qmi_handle_release,
+				       &smgr->sns_smgr_hdl);
+	if (ret)
+		return ret;
+
+	ret = qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
+	if (ret < 0)
+		return dev_err_probe(smgr->dev, ret,
+			"Failed to get available sensors\n");
+
+	smgr->sensor_count = ret;
+
+	/* Get primary and secondary sensors from each sensor ID */
+	for (i = 0; i < smgr->sensor_count; i++) {
+		ret = qcom_smgr_request_single_sensor_info(smgr,
+							   &smgr->sensors[i]);
+		if (ret < 0)
+			return dev_err_probe(smgr->dev, ret,
+				"Failed to get sensors from ID 0x%02x\n",
+				smgr->sensors[i].id);
+
+		for (j = 0; j < smgr->sensors[i].data_type_count; j++) {
+			/* Default to maximum sample rate */
+			smgr->sensors[i].data_types->cur_sample_rate =
+				smgr->sensors[i].data_types->max_sample_rate;
+
+			dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
+				smgr->sensors[i].id, j,
+				smgr->sensors[i].data_types[j].vendor,
+				smgr->sensors[i].data_types[j].name);
+		}
+
+		/* Skip if sensor type is not supported */
+		if (smgr->sensors[i]->type == SNS_SMGR_SENSOR_TYPE_UNKNOWN ||
+		    !qcom_smgr_sensor_type_iio_channels[smgr->sensors[i]->type])
+			continue;
+
+		ret = qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
+		if (ret)
+			return dev_err_probe(smgr->dev, ret,
+				"Failed to register sensor 0x%02x\n",
+				smgr->sensors[i].id);
+	}
+
+	return 0;
+}
+
+static const struct qrtr_device_id qcom_smgr_qrtr_match[] = {
+	{
+		.service = SNS_SMGR_QMI_SVC_ID,
+		/* Found on MSM8953 */
+		.instance = QRTR_INSTANCE_CONST(0, 1)
+	},
+	{
+		.service = SNS_SMGR_QMI_SVC_ID,
+		/* Found on MSM8974 and MSM8226 */
+		.instance = QRTR_INSTANCE_CONST(1, 0)
+	},
+	{
+		.service = SNS_SMGR_QMI_SVC_ID,
+		/* Found on MSM8996 and SDM660 */
+		.instance = QRTR_INSTANCE_CONST(1, 50)
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);
+
+static struct qrtr_driver qcom_smgr_driver = {
+	.probe = qcom_smgr_probe,
+	.id_table = qcom_smgr_qrtr_match,
+	.driver	= {
+		.name = "qcom_smgr",
+	},
+};
+module_qrtr_driver(qcom_smgr_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/qcom_smgr/qmi/Makefile b/drivers/iio/common/qcom_smgr/qmi/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..e69208db495f999e962a651340405ee3632bf463
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_IIO_QCOM_SMGR)	+= qmi_sns_smgr.o
diff --git a/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c b/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c
new file mode 100644
index 0000000000000000000000000000000000000000..1b58e266280d0b26a8d62f1ba64edc5ac3136b1e
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.c
@@ -0,0 +1,713 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * QMI element info arrays and helper functions for Qualcomm Sensor Manager
+ *
+ * Copyright (c) 2021-2025, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/module.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/types.h>
+
+#include "qmi_sns_smgr.h"
+
+static const struct qmi_elem_info sns_smgr_all_sensor_info_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_all_sensor_info, id),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_all_sensor_info, id),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_all_sensor_info, type_len),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_all_sensor_info, type_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = SNS_SMGR_SENSOR_TYPE_MAX_LEN,
+		.elem_size = sizeof(char),
+		.array_type = VAR_LEN_ARRAY,
+		.offset = offsetof(struct sns_smgr_all_sensor_info, type),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+const struct qmi_elem_info sns_smgr_all_sensor_info_resp_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_all_sensor_info_resp,
+					  result),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset =
+			offsetof(struct sns_smgr_all_sensor_info_resp, result),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_all_sensor_info_resp,
+					  item_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_all_sensor_info_resp,
+				   item_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN,
+		.elem_size = sizeof(struct sns_smgr_all_sensor_info),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_all_sensor_info_resp, items),
+		.ei_array = sns_smgr_all_sensor_info_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_all_sensor_info_resp_ei);
+
+const struct qmi_elem_info sns_smgr_single_sensor_info_req_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_req, sensor_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_req,
+				   sensor_id),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_single_sensor_info_req_ei);
+
+static const struct qmi_elem_info sns_smgr_single_sensor_info_data_type_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			sensor_id),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   sensor_id),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			data_type),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   data_type),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type, name_len),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   name_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 0xff,
+		.elem_size = sizeof(char),
+		.array_type = VAR_LEN_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   name),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			vendor_len),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   vendor_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 0xff,
+		.elem_size = sizeof(char),
+		.array_type = VAR_LEN_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   vendor),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type, val1),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   val1),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			max_sample_rate_hz),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   max_sample_rate_hz),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type, val2),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   val2),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			current_ua),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   current_ua),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type, range),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   range),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_data_type,
+			resolution),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_data_type,
+				   resolution),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+static const struct qmi_elem_info sns_smgr_single_sensor_info_native_sample_rates_ei[] = {
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_native_sample_rates, rate_count),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_native_sample_rates,
+				   rate_count),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN,
+		.elem_size = sizeof(u16),
+		.array_type = VAR_LEN_ARRAY,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_native_sample_rates,
+				   rates),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+const struct qmi_elem_info sns_smgr_single_sensor_info_resp_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, result),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   result),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, data_type_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data_type_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size =
+			sizeof(struct sns_smgr_single_sensor_info_data_type),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data_types),
+		.ei_array = sns_smgr_single_sensor_info_data_type_ei,
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, data1_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data1_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size = sizeof(u32),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data1),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, data2),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x11,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data2),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, data3_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x12,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data3_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_8_BYTE,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size = sizeof(u64),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x12,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data3),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp,
+			native_sample_rates_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x13,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   native_sample_rates_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size = sizeof(
+			struct sns_smgr_single_sensor_info_native_sample_rates),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x13,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   native_sample_rates),
+		.ei_array = sns_smgr_single_sensor_info_native_sample_rates_ei,
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_single_sensor_info_resp, data5_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x14,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data5_len),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size = sizeof(u32),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x14,
+		.offset = offsetof(struct sns_smgr_single_sensor_info_resp,
+				   data5),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_single_sensor_info_resp_ei);
+
+static const struct qmi_elem_info sns_smgr_buffering_req_item_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req_item,
+					  sensor_id),
+		.array_type = NO_ARRAY,
+		.offset =
+			offsetof(struct sns_smgr_buffering_req_item, sensor_id),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req_item,
+					  data_type),
+		.array_type = NO_ARRAY,
+		.offset =
+			offsetof(struct sns_smgr_buffering_req_item, data_type),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req_item,
+					  val1),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_req_item,
+				   val1),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req_item,
+					  sampling_rate),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_req_item,
+				   sampling_rate),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req_item,
+					  val2),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_req_item,
+				   val2),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+static const struct qmi_elem_info sns_smgr_buffering_req_notify_suspend_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_req_notify_suspend,
+			proc_type),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_req_notify_suspend,
+				   proc_type),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_req_notify_suspend,
+			send_indications_during_suspend),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_req_notify_suspend,
+				   send_indications_during_suspend),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+const struct qmi_elem_info sns_smgr_buffering_req_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_req, report_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct sns_smgr_buffering_req, report_id),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_req, action),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct sns_smgr_buffering_req, action),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req,
+					  report_rate),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_buffering_req, report_rate),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_req, item_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x04,
+		.offset = offsetof(struct sns_smgr_buffering_req, item_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = SNS_SMGR_DATA_TYPE_COUNT,
+		.elem_size = sizeof(struct sns_smgr_buffering_req_item),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x04,
+		.offset = offsetof(struct sns_smgr_buffering_req, items),
+		.ei_array = sns_smgr_buffering_req_item_ei,
+	},
+	{
+		.data_type = QMI_OPT_FLAG,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req,
+					  notify_suspend_valid),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct sns_smgr_buffering_req,
+				   notify_suspend_valid),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_req,
+					  notify_suspend),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset =
+			offsetof(struct sns_smgr_buffering_req, notify_suspend),
+		.ei_array = sns_smgr_buffering_req_notify_suspend_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_req_ei);
+
+const struct qmi_elem_info sns_smgr_buffering_resp_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_resp, result),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct sns_smgr_buffering_resp, result),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_resp, report_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct sns_smgr_buffering_resp, report_id),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_resp, ack_nak),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x11,
+		.offset = offsetof(struct sns_smgr_buffering_resp, ack_nak),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_resp_ei);
+
+static const struct qmi_elem_info sns_smgr_buffering_report_metadata_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_metadata, val1),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_report_metadata,
+				   val1),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size =
+			sizeof_field(struct sns_smgr_buffering_report_metadata,
+				     sample_count),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_report_metadata,
+				   sample_count),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_metadata, timestamp),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_report_metadata,
+				   timestamp),
+	},
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_metadata, val2),
+		.array_type = NO_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_report_metadata,
+				   val2),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+static const struct qmi_elem_info sns_smgr_buffering_report_sample_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_4_BYTE,
+		.elem_len = 3,
+		.elem_size = sizeof(u32),
+		.array_type = STATIC_ARRAY,
+		.offset = offsetof(struct sns_smgr_buffering_report_sample,
+				   values),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_sample, val1),
+		.array_type = NO_ARRAY,
+		.offset =
+			offsetof(struct sns_smgr_buffering_report_sample, val1),
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_sample, val2),
+		.array_type = NO_ARRAY,
+		.offset =
+			offsetof(struct sns_smgr_buffering_report_sample, val2),
+	},
+	{
+		.data_type = QMI_UNSIGNED_2_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(
+			struct sns_smgr_buffering_report_sample, val3),
+		.array_type = NO_ARRAY,
+		.offset =
+			offsetof(struct sns_smgr_buffering_report_sample, val3),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+
+const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[] = {
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
+					  report_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct sns_smgr_buffering_report_ind,
+				   report_id),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
+					  metadata),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct sns_smgr_buffering_report_ind,
+				   metadata),
+		.ei_array = sns_smgr_buffering_report_metadata_ei,
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
+					  samples_len),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x03,
+		.offset = offsetof(struct sns_smgr_buffering_report_ind,
+				   samples_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = SNS_SMGR_SAMPLES_MAX_LEN,
+		.elem_size = sizeof(struct sns_smgr_buffering_report_sample),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x03,
+		.offset =
+			offsetof(struct sns_smgr_buffering_report_ind, samples),
+		.ei_array = sns_smgr_buffering_report_sample_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
+					  val2),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct sns_smgr_buffering_report_ind, val2),
+	},
+	{
+		.data_type = QMI_EOTI,
+	},
+};
+EXPORT_SYMBOL_GPL(sns_smgr_buffering_report_ind_ei);
+
+static const char *smgr_sensor_type_names[SNS_SMGR_SENSOR_TYPE_COUNT] = {
+	[SNS_SMGR_SENSOR_TYPE_ACCEL] = "ACCEL",
+	[SNS_SMGR_SENSOR_TYPE_GYRO] = "GYRO",
+	[SNS_SMGR_SENSOR_TYPE_MAG] = "MAG",
+	[SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] = "PROX_LIGHT",
+	[SNS_SMGR_SENSOR_TYPE_PRESSURE] = "PRESSURE",
+	[SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] = "HALL_EFFECT"
+};
+
+enum qcom_smgr_sensor_type sns_smgr_sensor_type_from_str(const char *str)
+{
+	enum qcom_smgr_sensor_type i;
+
+	for (i = SNS_SMGR_SENSOR_TYPE_UNKNOWN + 1;
+	     i < SNS_SMGR_SENSOR_TYPE_COUNT; i++)
+		if (!strcmp(str, smgr_sensor_type_names[i]))
+			return i;
+
+	return SNS_SMGR_SENSOR_TYPE_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(sns_smgr_sensor_type_from_str);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm Sensor Manager QMI service helpers");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h b/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h
new file mode 100644
index 0000000000000000000000000000000000000000..5d0d622b9381bd053f13d5e6a01ee9fbd0d59470
--- /dev/null
+++ b/drivers/iio/common/qcom_smgr/qmi/qmi_sns_smgr.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __QMI_SNS_SMGR_H__
+#define __QMI_SNS_SMGR_H__
+
+#include <linux/iio/common/qcom_smgr.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/types.h>
+
+/*
+ * The structures of QMI messages used by the service were determined
+ * purely by watching transactions between proprietary Android userspace
+ * components and SSC. along with comparing values reported by Android APIs
+ * to values received in response messages. Due to that, the purpose or
+ * meaning of many fields remains unknown. Such fields are named "val*",
+ * "data*" or similar. Furthermore, the true maximum sizes of some messages
+ * with unknown array fields may be different than defined here.
+ */
+
+#define SNS_SMGR_QMI_SVC_ID			0x0100
+
+#define SNS_SMGR_ALL_SENSOR_INFO_MSG_ID		0x05
+#define SNS_SMGR_SINGLE_SENSOR_INFO_MSG_ID	0x06
+#define SNS_SMGR_BUFFERING_MSG_ID		0x21
+#define SNS_SMGR_BUFFERING_REPORT_MSG_ID	0x22
+
+#define SNS_SMGR_ALL_SENSOR_INFO_REQ_MAX_LEN		0x0
+#define SNS_SMGR_ALL_SENSOR_INFO_RESP_MAX_LEN		0x3e
+#define SNS_SMGR_SINGLE_SENSOR_INFO_REQ_MAX_LEN		0x4
+#define SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN	0x110
+#define SNS_SMGR_BUFFERING_REQ_MAX_LEN			0x30
+#define SNS_SMGR_BUFFERING_RESP_MAX_LEN			0x1e
+
+/* TODO: find actual maximums */
+#define SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN	0x10
+#define SNS_SMGR_SENSOR_TYPE_MAX_LEN		0x10
+#define SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN	0x20
+#define SNS_SMGR_SAMPLES_MAX_LEN		0x100
+
+enum sns_smgr_buffering_action {
+	SNS_SMGR_BUFFERING_ACTION_ADD	 = 1,
+	SNS_SMGR_BUFFERING_ACTION_DELETE = 2,
+};
+
+struct sns_smgr_all_sensor_info {
+	u8 id;
+	u8 type_len;
+	char type[SNS_SMGR_SENSOR_TYPE_MAX_LEN];
+};
+
+struct sns_smgr_all_sensor_info_resp {
+	u16 result;
+	u8 item_len;
+	struct sns_smgr_all_sensor_info items[SNS_SMGR_ALL_SENSOR_INFO_MAX_LEN];
+};
+
+struct sns_smgr_single_sensor_info_req {
+	u8 sensor_id;
+};
+
+struct sns_smgr_single_sensor_info_data_type {
+	u8 sensor_id;
+	u8 data_type;
+	u8 name_len;
+	char name[0xff];
+	u8 vendor_len;
+	char vendor[0xff];
+	/*
+	 * Might be separate u8 or u16 fields, but taken as a u32 it is seen
+	 * to hold the value 1 for all sensors in dumps.
+	 */
+	u32 val1;
+	u16 max_sample_rate_hz;
+	u16 val2;
+	u16 current_ua;
+	u32 range;
+	u32 resolution;
+};
+
+struct sns_smgr_single_sensor_info_native_sample_rates {
+	u8 rate_count;
+	u16 rates[SNS_SMGR_NATIVE_SAMPLE_RATES_MAX_LEN];
+};
+
+struct sns_smgr_single_sensor_info_resp {
+	u16 result;
+	u8 data_type_len;
+	struct sns_smgr_single_sensor_info_data_type data_types[SNS_SMGR_DATA_TYPE_COUNT];
+	u8 data1_len;
+	u32 data1[SNS_SMGR_DATA_TYPE_COUNT];
+	u32 data2;
+	u8 data3_len;
+	u64 data3[SNS_SMGR_DATA_TYPE_COUNT];
+	u8 native_sample_rates_len;
+	struct sns_smgr_single_sensor_info_native_sample_rates
+		native_sample_rates[SNS_SMGR_DATA_TYPE_COUNT];
+	u8 data5_len;
+	u32 data5[SNS_SMGR_DATA_TYPE_COUNT];
+};
+
+struct sns_smgr_buffering_req_item {
+	u8 sensor_id;
+	u8 data_type;
+	u16 val1;
+	u16 sampling_rate;
+	u16 val2;
+};
+
+struct sns_smgr_buffering_req_notify_suspend {
+	u16 proc_type;
+	u16 send_indications_during_suspend;
+};
+
+struct sns_smgr_buffering_req {
+	u8 report_id;
+	u8 action;
+	u32 report_rate;
+	u8 item_len;
+	struct sns_smgr_buffering_req_item items[SNS_SMGR_DATA_TYPE_COUNT];
+	u8 notify_suspend_valid;
+	struct sns_smgr_buffering_req_notify_suspend notify_suspend;
+};
+
+struct sns_smgr_buffering_resp {
+	u16 result;
+	u8 report_id;
+	u8 ack_nak;
+};
+
+struct sns_smgr_buffering_report_metadata {
+	u32 val1;
+	u8 sample_count;
+	u32 timestamp;
+	u32 val2;
+};
+
+struct sns_smgr_buffering_report_sample {
+	u32 values[3];
+	u8 val1;
+	u8 val2;
+	u16 val3;
+};
+
+struct sns_smgr_buffering_report_ind {
+	u8 report_id;
+	struct sns_smgr_buffering_report_metadata metadata;
+	u8 samples_len;
+	struct sns_smgr_buffering_report_sample samples[SNS_SMGR_SAMPLES_MAX_LEN];
+	u8 val2;
+};
+
+extern const struct qmi_elem_info sns_smgr_all_sensor_info_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_single_sensor_info_req_ei[];
+extern const struct qmi_elem_info sns_smgr_single_sensor_info_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_req_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_resp_ei[];
+extern const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[];
+
+extern enum qcom_smgr_sensor_type sns_smgr_sensor_type_from_str(const char *str);
+
+#endif /* __SSC_SNS_SMGR_H__ */
diff --git a/include/linux/iio/common/qcom_smgr.h b/include/linux/iio/common/qcom_smgr.h
new file mode 100644
index 0000000000000000000000000000000000000000..fdd3de12bb0a48f1fb9e51cd0463c9a9b9ed500f
--- /dev/null
+++ b/include/linux/iio/common/qcom_smgr.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __QCOM_SMGR_H__
+#define __QCOM_SMGR_H__
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/types.h>
+
+enum qcom_smgr_sensor_type {
+	SNS_SMGR_SENSOR_TYPE_UNKNOWN,
+	SNS_SMGR_SENSOR_TYPE_ACCEL,
+	SNS_SMGR_SENSOR_TYPE_GYRO,
+	SNS_SMGR_SENSOR_TYPE_MAG,
+	SNS_SMGR_SENSOR_TYPE_PROX_LIGHT,
+	SNS_SMGR_SENSOR_TYPE_PRESSURE,
+	SNS_SMGR_SENSOR_TYPE_HALL_EFFECT,
+
+	SNS_SMGR_SENSOR_TYPE_COUNT
+};
+
+enum qcom_smgr_data_type {
+	SNS_SMGR_DATA_TYPE_PRIMARY,
+	SNS_SMGR_DATA_TYPE_SECONDARY,
+
+	SNS_SMGR_DATA_TYPE_COUNT
+};
+
+struct qcom_smgr_data_type_item {
+	const char *name;
+	const char *vendor;
+
+	u32 range;
+
+	size_t native_sample_rate_count;
+	u16 *native_sample_rates;
+
+	u16 max_sample_rate;
+	u16 cur_sample_rate;
+};
+
+struct qcom_smgr_sensor {
+	u8 id;
+	enum qcom_smgr_sensor_type type;
+
+	u8 data_type_count;
+	/*
+	 * Only SNS_SMGR_DATA_TYPE_PRIMARY is used at the moment, but we store
+	 * SNS_SMGR_DATA_TYPE_SECONDARY when available as well for future use.
+	 */
+	struct qcom_smgr_data_type_item *data_types;
+
+	struct iio_dev *iio_dev;
+};
+
+struct qcom_smgr_iio_priv {
+	struct qcom_smgr_sensor *sensor;
+
+	int samp_freq_vals[3];
+};
+
+
+struct qcom_smgr_iio_data {
+	u32 values[3];
+	u64 timestamp;
+};
+
+struct qcom_smgr {
+	struct device *dev;
+
+	struct qmi_handle sns_smgr_hdl;
+	struct sockaddr_qrtr sns_smgr_info;
+	struct work_struct sns_smgr_work;
+
+	u8 sensor_count;
+	struct qcom_smgr_sensor *sensors;
+};
+
+#endif /* __QCOM_SMGR_H__ */

-- 
2.50.0



