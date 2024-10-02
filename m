Return-Path: <linux-iio+bounces-10005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF298D3C6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 14:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6321F22928
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5EB1D014E;
	Wed,  2 Oct 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wHCgL4cu"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D01D0142;
	Wed,  2 Oct 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873756; cv=none; b=kpw1ix0C6Je5r/zPGGJFr/Z5gs2XIbCPKnFKx6uAKpVFVtTe/CRek7ObzSXJ6I7i0kVdl41zZ5+SyxJ6GWWzKlJuDDNm6d+fpj7eOMBJZ7p3yIIqVtySwGKA9VD3gobyJefO1zOdEbH23KVePlo85u+xd4z3+xdwud5amZn+QK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873756; c=relaxed/simple;
	bh=BcDRNCBRnAa17mYLsHFdZ52XN2PN8xlbFoQo+wI3gcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHbjy2Umqdio+kArJ1/X+kq7Bb1Hjf1C6GPORIOHzVvZgedSo9noiP+zOaGOySChqvAgS1jZEifjV7xiRfmw+3EN4FQ2jd9Ulqfza/8oOiSj8Y1PKUnQ0fBlwQJESboZo1BVwdsZez3tkVRgKCLz/d7vaRuDjmsVlTxaCYlqEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wHCgL4cu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727873754; x=1759409754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BcDRNCBRnAa17mYLsHFdZ52XN2PN8xlbFoQo+wI3gcE=;
  b=wHCgL4cu7yxL4a7Ww1CJNdqjOtUi0js0H7hF+l4Iy6Va2Q52JxAuDpEc
   SaDFmZ6O8LrJLnRAvLCnTWglLxDkUyK40gYS1X0+nWWfhL7VgS777eH7B
   f7nabLnd723wcPQTmTMDPJmMTwsQXrYxYQlrOaR2mDsADa2PW9oG7MmgV
   vvEuM8gdOuM/2jB89GegrMxR6LP9wJRWWSgCBDiYFSNW67lUECRa3Ra7z
   PqskExjxkwpC+5qHWNs87b3V16M3pM9a779yuGyDejK9QVPtoQ5EF/guO
   uJ6hBjHOJv86tUfbcEvCO/mJBIfs8WGbZuupxlxFBY+K4T/e/tFGvgQzl
   A==;
X-CSE-ConnectionGUID: Va+YVzq4SVeiJMC18iElnA==
X-CSE-MsgGUID: 0WF7gG8/QQCFKeai5VLxaQ==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="35789130"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 05:55:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 05:55:07 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 05:55:05 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: pac1921: add ACPI support to pac1921
Date: Wed, 2 Oct 2024 15:54:45 +0300
Message-ID: <20241002125445.7570-1-victor.duicu@microchip.com>
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
The driver can read shunt resistor value and device label
from ACPI table.

Differences related to previous versions:
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
 drivers/iio/adc/pac1921.c | 112 ++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc39..95ade1c4d5e8 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -67,6 +67,10 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_UOHMS_VALS             0
+#define PAC1921_ACPI_GET_NAME			1
+#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236-7a7a742e55cb"
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -204,6 +208,14 @@ struct pac1921_priv {
 	} scan;
 };
 
+static bool pac1921_shunt_is_valid(u32 shunt_val)
+{
+	if (shunt_val == 0 || shunt_val > INT_MAX)
+		return false;
+	else
+		return true;
+}
+
 /*
  * Check if first integration after configuration update has completed.
  *
@@ -794,7 +806,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 		return ret;
 
 	rshunt_uohm = (u32)val * MICRO + (u32)val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	if (!pac1921_shunt_is_valid((u32)rshunt_uohm))
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
@@ -1151,6 +1163,81 @@ static void pac1921_regulator_disable(void *data)
 	regulator_disable(regulator);
 }
 
+/*
+ * documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ */
+static int pac1921_match_acpi_device(struct i2c_client *client, struct pac1921_priv *priv,
+				     struct iio_dev *indio_dev)
+{
+	acpi_handle handle;
+	union acpi_object *rez;
+	guid_t guid;
+	char *label;
+
+	guid_parse(PAC1921_DSM_UUID, &guid);
+	handle = ACPI_HANDLE(&client->dev);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = rez->package.elements[0].integer.value;
+	ACPI_FREE(rez);
+
+	if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
+		return dev_err_probe(&client->dev, -EINVAL, "Invalid shunt resistor: %u\n",
+				     priv->rshunt_uohm);
+
+	pac1921_calc_current_scales(priv);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_NAME, NULL);
+	if (!rez)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read name from ACPI table\n");
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
+
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				       &priv->rshunt_uohm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot read shunt resistor property\n");
+
+	if (!pac1921_shunt_is_valid(priv->rshunt_uohm))
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
+				     priv->rshunt_uohm);
+
+	pac1921_calc_current_scales(priv);
+
+	if (device_property_present(dev, "label")) {
+		ret = device_property_read_string(dev, "label",
+						  (const char **)&indio_dev->label);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Invalid rail-name value\n");
+	} else {
+		indio_dev->label = "pac1921";
+	}
+
+	return 0;
+}
+
 static int pac1921_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1177,17 +1264,14 @@ static int pac1921_probe(struct i2c_client *client)
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
@@ -1244,11 +1328,17 @@ static const struct of_device_id pac1921_of_match[] = {
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

base-commit: fec496684388685647652ab4213454fbabdab099
-- 
2.43.0


