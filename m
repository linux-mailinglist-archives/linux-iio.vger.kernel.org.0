Return-Path: <linux-iio+bounces-25132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2564BE2E8D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0F1A63E66
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB53314DC;
	Thu, 16 Oct 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cHC6PkIi"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469B2E172E;
	Thu, 16 Oct 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611461; cv=none; b=T/WW8BlGfX/9kCFSzSrin6G4KBBTE4o4TGWwnOvs4a5vSlAtofD9FLNi5Imf+j4hpWsXm6We6YVKUHC6I0YiMTa4EQmPVELXrbqt0JoXrZ/4JqcP4ht3EDZ8Z4FwbQfJVrXiHix/GjTvyqp6DN53F2gftNixR0gp2b1uUSo40EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611461; c=relaxed/simple;
	bh=cP0P8mnb1hkjMQYI1W3IQNrFA+nT6mCV9ZFGp5wTvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQHVLdVnheAlP/7OEIikW1yi2UJG/heClvmXf7tQ1LkmbELLc/7jvwomizYmlnamgT6gwq/YuuI9A8fwE/cJxMCN5P0xWp49oeZsg/psyQJNG1vz2KrBzKWSgPqGF44xClQ2yDWk3H1XnLl7OkjUOhvAtp8RPxz5GsiUpE1PhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cHC6PkIi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760611457;
	bh=cP0P8mnb1hkjMQYI1W3IQNrFA+nT6mCV9ZFGp5wTvcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHC6PkIiIxVMd1oWa9ZqBC672+2FDuWofLQ34PrbtfQlDX87wZxH1dvZD7SXA+usg
	 o5gD/AZyHUrMj9u2W+qYxI1uRYiNsAqzL+CRUrmrfgrLH64/wFKLyO4TjoDiQIHlNP
	 u7U5eRDYYizokYhc/gGrqxOwFWzdX4MJGGLNoASoYPiqDdGm+6Ch1U5Qvx/x+aM0yF
	 qq20FIwfbHt31wTHg+N6xKuQfD6uWMxbC/FjJ1CcR+wavRdEUHgsGTbOTm3skpa2WS
	 Qer40YEOrdAVtW33GxSv6NFUhGDp8i7pAy8xtV20AI6xk2PvlMWWSkAHdLvHnOpxSz
	 je/Q38F7SfMMA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B6D3A17E0FC2;
	Thu, 16 Oct 2025 12:44:16 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org,
	casey.connolly@linaro.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 2/8] spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
Date: Thu, 16 Oct 2025 12:43:56 +0200
Message-ID: <20251016104402.338246-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
References: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
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
 drivers/spmi/spmi.c        | 79 ++++++++++++++++++++++++++++++++++++++
 include/linux/spmi.h       | 16 ++++++++
 3 files changed, 119 insertions(+)

diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
index 62c4b3f24d06..8feebab0365b 100644
--- a/drivers/spmi/spmi-devres.c
+++ b/drivers/spmi/spmi-devres.c
@@ -60,5 +60,29 @@ int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl
 }
 EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
 
+static void devm_spmi_subdevice_remove(void *res)
+{
+	spmi_subdevice_remove(res);
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
index bcb71f25194f..37e91932a01d 100644
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
@@ -90,6 +104,18 @@ void spmi_device_remove(struct spmi_device *sdev)
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
@@ -431,6 +457,59 @@ struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(spmi_device_alloc);
 
+/**
+ * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
+ * @sparent:	SPMI parent device with previously registered SPMI controller
+ *
+ * Returns:
+ * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
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
+	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(sub_sdev);
+		return ERR_PTR(ret);
+	}
+
+	sdev = &sub_sdev->sdev;
+	sdev->ctrl = sparent->ctrl;
+	device_initialize(&sdev->dev);
+	sdev->dev.parent = &sparent->dev;
+	sdev->dev.bus = &spmi_bus_type;
+	sdev->dev.type = &spmi_subdev_type;
+
+	sub_sdev->devid = ret;
+	sdev->usid = sparent->usid;
+
+	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
+			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
+	if (ret)
+		goto err_put_dev;
+
+	ret = device_add(&sdev->dev);
+	if (ret) {
+		dev_err(&sdev->dev, "Can't add %s, status %pe\n",
+			dev_name(&sdev->dev), ERR_PTR(ret));
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
2.51.0


