Return-Path: <linux-iio+bounces-27728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BEBD1D833
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63EBF30141C3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41A389DE1;
	Wed, 14 Jan 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NbHOC7bs"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B526389452;
	Wed, 14 Jan 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382880; cv=none; b=JPj7AbF9WWF89hxdcss1ytbd8j3RhyXYJWTM0P7dqgEMYe1B0Frf5i00hH73DV8YW8Inx6GM44BtvRQO/Lhgq1sDiVNIS3kAgP0Y0r3EFY9IwcWbD+/gqYh+RufbbIkDovCpuLoMyTaAqzMCv3aOpa8DY7IsgqjvFykhLNGBGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382880; c=relaxed/simple;
	bh=4T+0WHvdsRCcbh+YvOkT11L3y6xwyw+dQUZPKgyLeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3KrXxHRMvncMu3tO+UzstxhlPUbKQ0ttARtx3zCtXR8o0AcyXnBg2JxQTnVXr0CRuMCAaAD7l0Ep/yBkoIvYLHngaLi7tXzVq8MstWBGtANPmqzLDNzd7U4OeqFDhF/N+Sch7NkIOv2AV4rPabJFu5IASnSd0JQrcMked5/Im4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NbHOC7bs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768382872;
	bh=4T+0WHvdsRCcbh+YvOkT11L3y6xwyw+dQUZPKgyLeL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbHOC7bsPr55yT1x599eFZku/IvWsLPWLiqt1O5/wJRdvkgdwTM8OKAMo6PD/4g1q
	 Wel/5pk5Z7/bB1nShb23l1S8Ij2jW43VLKXwi+BUNj8F3LTq05NCp/hHV2LJcJvcbh
	 YL6nmLc4j+6N0rxWD3GjDuaBZyxXETOYJSF49AEzfgTHHl4RfbYFfjz3e+06W3LU5G
	 4sYbNTytl+ZVXX+kXVOYv6k8yR64qllZX8hl9F/I/kOSIy1kIMgv2vbpy+UrBzjY08
	 RbsorzaUwq9N50S7BuLrvVH5yQOUJYRGUbQLtI+LcXmJ5TP3/s2bkEnQA7FB3bbSja
	 h1wsR7udvCN+Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE25517E1525;
	Wed, 14 Jan 2026 10:27:51 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	sboyd@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 04/10] spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
Date: Wed, 14 Jan 2026 10:27:36 +0100
Message-ID: <20260114092742.13231-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices connected over the SPMI bus may be big, in the sense
that those may be a complex of devices managed by a single chip
over the SPMI bus, reachable through a single SID.

Add new functions aimed at managing sub-devices of a SPMI device
spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
for adding a new subdevice and removing it respectively, and also
add their devm_* variants.

The need for such functions comes from the existence of	those
complex Power Management ICs (PMICs), which feature one or many
sub-devices, in some cases with these being even addressable on
the chip in form of SPMI register ranges.

Examples of those devices can be found in both Qualcomm platforms
with their PMICs having PON, RTC, SDAM, GPIO controller, and other
sub-devices, and in newer MediaTek platforms showing similar HW
features and a similar layout with those also having many subdevs.

Also, instead of generally exporting symbols, export them with a
new "SPMI" namespace: all users will have to import this namespace
to make use of the newly introduced exports.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-devres.c | 24 ++++++++++++
 drivers/spmi/spmi.c        | 78 ++++++++++++++++++++++++++++++++++++++
 include/linux/spmi.h       | 16 ++++++++
 3 files changed, 118 insertions(+)

diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
index 62c4b3f24d06..c3e889fe1b6e 100644
--- a/drivers/spmi/spmi-devres.c
+++ b/drivers/spmi/spmi-devres.c
@@ -60,5 +60,29 @@ int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl
 }
 EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
 
+static void devm_spmi_subdevice_remove(void *sub_sdev)
+{
+	spmi_subdevice_remove(sub_sdev);
+}
+
+struct spmi_subdevice *devm_spmi_subdevice_alloc_and_add(struct device *dev,
+							 struct spmi_device *sparent)
+{
+	struct spmi_subdevice *sub_sdev;
+	int ret;
+
+	sub_sdev = spmi_subdevice_alloc_and_add(sparent);
+	if (IS_ERR(sub_sdev))
+		return sub_sdev;
+
+	ret = devm_add_action_or_reset(dev, devm_spmi_subdevice_remove, sub_sdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return sub_sdev;
+}
+EXPORT_SYMBOL_NS_GPL(devm_spmi_subdevice_alloc_and_add, "SPMI");
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SPMI devres helpers");
+MODULE_IMPORT_NS("SPMI");
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 29567c0620ae..5f6e1a7a85f1 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -19,6 +19,7 @@
 
 static bool is_registered;
 static DEFINE_IDA(ctrl_ida);
+static DEFINE_IDA(spmi_subdevice_ida);
 
 static void spmi_dev_release(struct device *dev)
 {
@@ -31,6 +32,19 @@ static const struct device_type spmi_dev_type = {
 	.release	= spmi_dev_release,
 };
 
+static void spmi_subdev_release(struct device *dev)
+{
+	struct spmi_device *sdev = to_spmi_device(dev);
+	struct spmi_subdevice *sub_sdev = container_of(sdev, struct spmi_subdevice, sdev);
+
+	ida_free(&spmi_subdevice_ida, sub_sdev->devid);
+	kfree(sub_sdev);
+}
+
+static const struct device_type spmi_subdev_type = {
+	.release	= spmi_subdev_release,
+};
+
 static void spmi_ctrl_release(struct device *dev)
 {
 	struct spmi_controller *ctrl = to_spmi_controller(dev);
@@ -87,6 +101,18 @@ void spmi_device_remove(struct spmi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(spmi_device_remove);
 
+/**
+ * spmi_subdevice_remove() - Remove an SPMI subdevice
+ * @sub_sdev:	spmi_device to be removed
+ */
+void spmi_subdevice_remove(struct spmi_subdevice *sub_sdev)
+{
+	struct spmi_device *sdev = &sub_sdev->sdev;
+
+	device_unregister(&sdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(spmi_subdevice_remove, "SPMI");
+
 static inline int
 spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
 {
@@ -428,6 +454,58 @@ struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(spmi_device_alloc);
 
+/**
+ * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
+ * @sparent:	SPMI parent device with previously registered SPMI controller
+ *
+ * Returns:
+ * Pointer to newly allocated SPMI sub-device for success or error pointer.
+ */
+struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
+{
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sdev;
+	int ret;
+
+	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
+	if (!sub_sdev)
+		return ERR_PTR(-ENOMEM);
+
+	sdev = &sub_sdev->sdev;
+	sdev->ctrl = sparent->ctrl;
+	sdev->usid = sparent->usid;
+
+	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(sub_sdev);
+		return ERR_PTR(ret);
+	}
+	sub_sdev->devid = ret;
+
+	device_initialize(&sdev->dev);
+	sdev->dev.parent = &sparent->dev;
+	sdev->dev.bus = &spmi_bus_type;
+	sdev->dev.type = &spmi_subdev_type;
+
+	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
+			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
+	if (ret)
+		goto err_put_dev;
+
+	ret = device_add(&sdev->dev);
+	if (ret) {
+		dev_err(&sdev->dev, "Can't add device, status %pe\n", ERR_PTR(ret));
+		goto err_put_dev;
+	}
+
+	return sub_sdev;
+
+err_put_dev:
+	put_device(&sdev->dev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
+
 /**
  * spmi_controller_alloc() - Allocate a new SPMI controller
  * @parent:	parent device
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index 28e8c8bd3944..7cea0a5b034b 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -69,6 +69,22 @@ int spmi_device_add(struct spmi_device *sdev);
 
 void spmi_device_remove(struct spmi_device *sdev);
 
+/**
+ * struct spmi_subdevice - Basic representation of an SPMI sub-device
+ * @sdev:	Sub-device representation of an SPMI device
+ * @devid:	Platform Device ID of an SPMI sub-device
+ */
+struct spmi_subdevice {
+	struct spmi_device	sdev;
+	unsigned int		devid;
+};
+
+struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent);
+void spmi_subdevice_remove(struct spmi_subdevice *sdev);
+
+struct spmi_subdevice *devm_spmi_subdevice_alloc_and_add(struct device *dev,
+							 struct spmi_device *sparent);
+
 /**
  * struct spmi_controller - interface to the SPMI master controller
  * @dev:	Driver model representation of the device.
-- 
2.52.0


