Return-Path: <linux-iio+bounces-10458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD799A551
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF1282A82
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2055218D99;
	Fri, 11 Oct 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yf2rDZtA"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A11E501C;
	Fri, 11 Oct 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654309; cv=none; b=N9oZePtPrYyvxH8B3BbIM8kPDJiaABb7ZNFTN4YKNsfX3m+LD1zGia6zjWJXsgBGvFlg5lUkMtAb6Ee5ldfoaI1S+VpD2OYO1bBQpshgeqHur0hspYJkQpTMZsn6tvBfQ64aceF4qGuJ1XT0WNwvpLCjvJgcO/4LTWpJ4+KSPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654309; c=relaxed/simple;
	bh=jA6Bduz+f3uu0Nv/cNJGLTISP4v5zEwytxuOSAtHnHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LCM+J106f9tAt2jzqgBZW30x7vd4v34zFmjZNkA3luhrEMZ4GpMVY7J0LwPKdXvUaBLzNS6SluKWB/Qj9kV8SnBMnTWfRMD8UUQiSNW/Bs/1y9YieZVVXA+PSABwJEWvSTP8bqlR0e18vtiTtw4YntwAkolu9EIX4ExLu9hEtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yf2rDZtA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728654308; x=1760190308;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jA6Bduz+f3uu0Nv/cNJGLTISP4v5zEwytxuOSAtHnHo=;
  b=Yf2rDZtAIte9eV6qAJN07+yTpRDi4sEDu0hk7PflPx2Q5JVzvb4Hd6n7
   Eb+QNTjcV+lww1QceTWSIuSRVlq7jsxmjB6AJMzx5GLmVygHVPEnfyVZ9
   DVqyzLylDr6FVvSrTFL6PpFz8l6yzX+shP356nO369yOdxDybsq0NAfXu
   c89fOP3Gva2ZoX0FoJZCdBfM1821H3f7RCvdDK8uv5TykiBuXsK1zOos2
   1Uj2GpgTIlUW7lpjKtu52x4rSR/a0eSby8DNG1Pv3zlvMwxPae2mYQDvH
   kLfpL7HpmpTPL94yW10qbYtOuY++ATlAJIAyxMHHmtxdQ4kj9LGKGDN9G
   Q==;
X-CSE-ConnectionGUID: N0YeULSXTTmb5DyOXbN91w==
X-CSE-MsgGUID: yqr4ZoJiSg6YtyoNoIHJow==
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="263955870"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2024 06:45:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 11 Oct 2024 06:44:58 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 11 Oct 2024 06:44:57 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip pac1921.
Date: Fri, 11 Oct 2024 16:44:54 +0300
Message-ID: <20241011134454.45283-1-victor.duicu@microchip.com>
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

The patch was tested on a minnowboard(64b) and sama5(32b).
In order to avoid overflow when reading 64b values from ACPi table or
devicetree it is necessary:
- the revision of .dsl file must be 2 or greater to enable 64b arithmetic.
- the shunt resistor variable in devicetree must have the prefix "/bits/ 64".

Differences related to previous versions:
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

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 drivers/iio/adc/pac1921.c | 106 +++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 567279664e74..01c5eceab0be 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -67,6 +67,10 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_UOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236-7a7a742e55cb"
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -204,6 +208,11 @@ struct pac1921_priv {
 	} scan;
 };
 
+static inline bool pac1921_shunt_is_valid(u64 shunt_val)
+{
+	return (shunt_val == 0 || shunt_val > INT_MAX);
+}
+
 /*
  * Check if first integration after configuration update has completed.
  *
@@ -792,13 +801,13 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	rshunt_uohm = (u64)val * MICRO + val_fract;
+	if (pac1921_shunt_is_valid(rshunt_uohm))
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
 
-	priv->rshunt_uohm = rshunt_uohm;
+	priv->rshunt_uohm = (u32)rshunt_uohm;
 
 	pac1921_calc_current_scales(priv);
 
@@ -1150,6 +1159,74 @@ static void pac1921_regulator_disable(void *data)
 	regulator_disable(regulator);
 }
 
+/*
+ * documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ */
+static int pac1921_match_acpi_device(struct i2c_client *client, struct pac1921_priv *priv,
+				     struct iio_dev *indio_dev)
+{
+	acpi_handle handle;
+	union acpi_object *rez;
+	guid_t guid;
+	char *label;
+	u64 temp;
+
+	guid_parse(PAC1921_DSM_UUID, &guid);
+	handle = ACPI_HANDLE(&client->dev);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	temp = rez->package.elements[0].integer.value;
+	ACPI_FREE(rez);
+
+	if (pac1921_shunt_is_valid(temp))
+		return dev_err_probe(&client->dev, -EINVAL, "Invalid shunt resistor\n");
+
+	priv->rshunt_uohm = temp;
+	pac1921_calc_current_scales(priv);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
+	if (!rez)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read label from ACPI table\n");
+
+	label = devm_kmemdup(&client->dev, rez->package.elements->string.pointer,
+			     (size_t)rez->package.elements->string.length + 1,
+			     GFP_KERNEL);
+	label[rez->package.elements->string.length] = '\0';
+	indio_dev->label = label;
+	ACPI_FREE(rez);
+
+	return 0;
+}
+
+static int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921_priv *priv,
+			       struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &client->dev;
+	u64 temp;
+
+	ret = device_property_read_u64(dev, "shunt-resistor-micro-ohms", &temp);
+
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot read shunt resistor property\n");
+
+	if (pac1921_shunt_is_valid(temp))
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
+				     priv->rshunt_uohm);
+
+	priv->rshunt_uohm = (u32)temp;
+	pac1921_calc_current_scales(priv);
+
+	return 0;
+}
+
 static int pac1921_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1176,17 +1253,14 @@ static int pac1921_probe(struct i2c_client *client)
 	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
 	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
 
-	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
-				       &priv->rshunt_uohm);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Cannot read shunt resistor property\n");
-	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
-		return dev_err_probe(dev, -EINVAL,
-				     "Invalid shunt resistor: %u\n",
-				     priv->rshunt_uohm);
+	if (ACPI_HANDLE(&client->dev))
+		ret = pac1921_match_acpi_device(client, priv, indio_dev);
+	else
+		ret = pac1921_parse_of_fw(client, priv,  indio_dev);
 
-	pac1921_calc_current_scales(priv);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "parameter parsing error\n");
 
 	priv->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(priv->vdd))
@@ -1243,11 +1317,17 @@ static const struct of_device_id pac1921_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pac1921_of_match);
 
+static const struct acpi_device_id pac1921_acpi_match[] = {
+	{ "MCHP1921" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
 static struct i2c_driver pac1921_driver = {
 	.driver	 = {
 		.name = "pac1921",
 		.pm = pm_sleep_ptr(&pac1921_pm_ops),
 		.of_match_table = pac1921_of_match,
+		.acpi_match_table = pac1921_acpi_match
 	},
 	.probe = pac1921_probe,
 	.id_table = pac1921_id,

base-commit: c4f9679c92dc8f5a16cd3ad1c9a4a23c6d3f52d7
-- 
2.43.0


