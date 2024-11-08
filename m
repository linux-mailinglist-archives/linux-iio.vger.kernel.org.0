Return-Path: <linux-iio+bounces-12019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B79C1872
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8BFB220EF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CF1DEFEA;
	Fri,  8 Nov 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vV1G+6Ho"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C291494D4;
	Fri,  8 Nov 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055926; cv=none; b=iN5n3umsBj30ZzwNaYCB/oTCxdIAJvRUZezVg+7J6Suc6hZd7UnEWkd2zV4OWUDKnut1QUGgyzmfLMr1Jc192VWNlsTlzK5X9l1dnACjuflqNfd7/XuzR2TLcRZubvWGGdZtRnr2T7mAmz56lNC0wgTZlPBZj5EOyVmM+QSO8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055926; c=relaxed/simple;
	bh=RcuQuZgZt8m3bIkSzDHFRUXoABDd4tCxmGDliTqlQNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fonc/VjUYiSLZmed1xDr+nJrYPKW8AtzJ29zPY8lyhB3y87vKBw9yZjVqey2unZapUA5JOIm3HwIDGnAnEp7J49SCf3kWT4IU5GpI/dHEUQgyP5wGAiFEiExXUoQmFLJH5Fm3gw9FiaNwVHxmc9McHOjQXrLgZwnSoALqX8SVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vV1G+6Ho; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731055924; x=1762591924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RcuQuZgZt8m3bIkSzDHFRUXoABDd4tCxmGDliTqlQNc=;
  b=vV1G+6Ho796u1B6zXL/05iMhQkACH1cvk1ACND4lU4WbfQw1WI5AGP81
   t0zpzhqdsLkVPP7pNUEbEr9WSZzhS68Dahgr6gt/N4WwxGWUZGGNDhZZF
   9kd2xr4MR+LZ0pUg+G0PAvahpOPtdaWyyBGUzRKMV3tGuomJRHrSypVHo
   MveDbAYySauXEPKoA9AYYq9OMuSBCeF6HJrHmA7xEu5kjAo7VAVLErJED
   Ls4vSUOjRTixB8cBvn4IFbN0Xbs4QTX0TyMvqlwR5kKYC+Pm2JCWkmK6s
   plrHeCDUA+ECH0yoMoYsK30og91d0V5/4QoUMZYfGhAKNUfzISbH2xmqy
   w==;
X-CSE-ConnectionGUID: zI5DMkGcRuGi35LBTBIEew==
X-CSE-MsgGUID: SlkkJ54RTMK2kvi3oI6mXQ==
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="33791006"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 01:52:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 01:51:49 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 8 Nov 2024 01:51:47 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<andy.shevchenko@gmail.com>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8] iio: adc: pac1921: Add ACPI support to Microchip pac1921
Date: Fri, 8 Nov 2024 10:50:12 +0200
Message-ID: <20241108085012.13147-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This patch implements ACPI support to Microchip pac1921.
The driver can read shunt resistor value and label from ACPI table.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

The patch was tested on minnowboard and sama5.

Differences related to previous versions:
v8:
- fix multiple coding style errors.
- in pac1921_match_acpi_device change error type to ENOMEM
at label is NULL branch.
- in pac1921_match_acpi_device when reading label,
change accesing method of string.
- change name of PAC1921_ACPI_GET_UOHMS_VALS to
PAC1921_ACPI_GET_uOHMS_VALS.
- add limits.h in include list.
- change integer constant in PAC1921_MAX_SHUNT_VALUE_OHMS
to INT_MAX / MICRO.
- change pac1921_shunt_is_invalid to pac1921_shunt_is_valid.
- in pac1921_match_acpi_device change name of variable rez to status.

v7:
- in pac1921_shunt_is_invalid remove brackets in return.
- in pac1921_match_acpi_device and pac1921_parse_of_fw move checking of
  shunt value and scale calculation to pac1921_probe.
- in pac1921_match_acpi_device change devm_kmemdup to devm_kstrdup
and add label check for NULL.
- in pac1921_match_acpi_device and pac1921_parse_of_fw remove unnecessary
entry arguments. Now indio_dev is the only entry argument.
- in pac1921_probe, pac1921_match_acpi_device and pac1921_parse_of_fw
  standardised structure accesing.

v6:
- set maximum acceptable value of shunt resistor to INT_MAX UOHMS
in devicetree, ACPI table and user input.
- in pac1921_match_acpi_device remove temp variable.

v5:
- set maximum acceptable value of shunt resistor to 2KOHM in devicetree,
ACPI table and user input. The chosen value is lesser than INT_MAX,
which is about 2.1KOHM.
- in pac1921_match_acpi_device and pac1921_parse_of_fw change to only
  read 32b values for resistor shunt.

v4:
- change name of pac1921_shunt_is_valid to pac1921_shunt_is_invalid.
- fix coding style.
- in pac1921_parse_of_fw change back to device_property_read_u32.

v3:
- simplify and make inline function pac1921_shunt_is_valid. Make argument u64.
- fix link to DSM documentation.
- in pac1921_match_acpi_device and pac1921_parse_of_fw, the shunt value is
read as u64.
- in pac1921_parse_of_fw remove code for reading label value from
devicetree.
- in pac1921_write_shunt_resistor cast the multiply result to u64 in order
to fix overflow.

v2:
- remove name variable from priv. Driver reads label attribute with
sysfs.
- define pac1921_shunt_is_valid function.
- move default assignments in pac1921_probe to original position.
- roll back coding style changes.
- add documentation for DSM(the linked document was used as reference).
- remove acpi_match_device in pac1921_match_acpi_device.
- remove unnecessary null assignment and comment.
- change name of function pac1921_match_of_device to
pac1921_parse_of_fw.

v1:
- initial version for review.

 drivers/iio/adc/pac1921.c | 98 +++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index b0f6727cfe38..e24015390503 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -14,6 +14,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/limits.h>
 
 /* pac1921 registers */
 #define PAC1921_REG_GAIN_CFG		0x00
@@ -67,6 +68,12 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_uOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236-7a7a742e55cb"
+/* The maximum accepted value of shunt_resistor in uOHMS <= INT_MAX */
+#define PAC1921_MAX_SHUNT_VALUE_OHMS		(INT_MAX / MICRO)
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -204,6 +211,11 @@ struct pac1921_priv {
 	} scan;
 };
 
+static inline bool pac1921_shunt_is_valid(u32 shunt_val)
+{
+	return shunt_val > 0 && shunt_val <= INT_MAX;
+}
+
 /*
  * Check if first integration after configuration update has completed.
  *
@@ -782,7 +794,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
-	u64 rshunt_uohm;
+	u32 rshunt_uohm;
 	int val, val_fract;
 	int ret;
 
@@ -793,8 +805,13 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	/* This check is to ensure val * MICRO won't overflow */
+	if (val > PAC1921_MAX_SHUNT_VALUE_OHMS)
+		return -EINVAL;
+
 	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	/* This check is to ensure rshunt_uohm is non-zero positive */
+	if (!pac1921_shunt_is_valid(rshunt_uohm))
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
@@ -1151,6 +1168,60 @@ static void pac1921_regulator_disable(void *data)
 	regulator_disable(regulator);
 }
 
+/*
+ * Documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ */
+static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
+{
+	acpi_handle handle;
+	union acpi_object *status;
+	guid_t guid;
+	char *label;
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	struct device *dev = &priv->client->dev;
+
+	guid_parse(PAC1921_DSM_UUID, &guid);
+	handle = ACPI_HANDLE(dev);
+
+	status = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_uOHMS_VALS, NULL);
+	if (!status)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = status->package.elements[0].integer.value;
+	ACPI_FREE(status);
+
+	status = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
+	if (!status)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read label from ACPI table\n");
+
+	label = devm_kstrdup(dev, status->package.elements[0].string.pointer, GFP_KERNEL);
+	if (!label)
+		return -ENOMEM;
+
+	indio_dev->label = label;
+	ACPI_FREE(status);
+
+	return 0;
+}
+
+static int pac1921_parse_of_fw(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	struct device *dev = &priv->client->dev;
+
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				       &priv->rshunt_uohm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot read shunt resistor property\n");
+
+	return 0;
+}
+
 static int pac1921_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1179,14 +1250,16 @@ static int pac1921_probe(struct i2c_client *client)
 	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
 	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
 
-	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
-				       &priv->rshunt_uohm);
-	if (ret)
+	if (ACPI_HANDLE(dev))
+		ret = pac1921_match_acpi_device(indio_dev);
+	else
+		ret = pac1921_parse_of_fw(indio_dev);
+	if (ret < 0)
 		return dev_err_probe(dev, ret,
-				     "Cannot read shunt resistor property\n");
-	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
-		return dev_err_probe(dev, -EINVAL,
-				     "Invalid shunt resistor: %u\n",
+				     "Parameter parsing error\n");
+
+	if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
 				     priv->rshunt_uohm);
 
 	pac1921_calc_current_scales(priv);
@@ -1246,11 +1319,18 @@ static const struct of_device_id pac1921_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pac1921_of_match);
 
+static const struct acpi_device_id pac1921_acpi_match[] = {
+	{ "MCHP1921" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
+
 static struct i2c_driver pac1921_driver = {
 	.driver	 = {
 		.name = "pac1921",
 		.pm = pm_sleep_ptr(&pac1921_pm_ops),
 		.of_match_table = pac1921_of_match,
+		.acpi_match_table = pac1921_acpi_match,
 	},
 	.probe = pac1921_probe,
 	.id_table = pac1921_id,

base-commit: 6415477ba63dea58b5cbf9ddcae75f18f33c71a4
-- 
2.43.0


