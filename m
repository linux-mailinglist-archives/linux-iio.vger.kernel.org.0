Return-Path: <linux-iio+bounces-10722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2C9A3DD6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AC1F21976
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B890418C0C;
	Fri, 18 Oct 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JLAU8fU7"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B646FC3;
	Fri, 18 Oct 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253242; cv=none; b=JTYF2DDwOGU0Qfu7b6rbWf21EHKiNIn9PupG4f9grGtR0ng/ircYghtQUENYbAXz3BYkU8H6xT6BaCmxx3t3RnJXhdelvTI7fbcZKK2ZETwRT/5HOOYg8QzayXASZr92rK5fBv6PeBzAg2KNKGdNA/l2bAbzwBrK2PGmO5s0m9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253242; c=relaxed/simple;
	bh=URBOnJ/Ss5PaWSgCKIzSeXHcUY8k6lxtjhkvPrc0xhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVSlsoTcKY69YlrjRL4Vo1ajyWkonVCBHgwY8l5YixPxU6KtaZP49dw/VaKogpAZIjCvKSG4Gry/NR6miiXZ6Cm1EOUARlaDVKqGqs3Po/G+AmCBOVDBTkYfDFlVC2EV2NphBo8v4IRmdRChvgomiOKQ7UXotOxYZBvMPeTR+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JLAU8fU7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729253240; x=1760789240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=URBOnJ/Ss5PaWSgCKIzSeXHcUY8k6lxtjhkvPrc0xhg=;
  b=JLAU8fU75hGvk5c7edYg4XPv4MjvKJyZIgZfa4t8zVa6xIGUYXlKY73Z
   uLKS4aOOKJq/KPczXNKo+upOV6SyeY/G1nkfIOH3sFWlplwdzHBUI2vtY
   8TpEinMnJ6ZDHx7EUDHPDzTz7NXronUAjqHtcVIPXTtF+NR01ND6/JiEj
   +cgGkhSEqTmfma7ZYwMKOLZZxx75GcwCL7zuhQ0bdc1l3jNFdMBFPyeCD
   nTWFgEvCS+Ulqz/Xamklk0W+cldy3EeC7GNWP0POgzgOhuJqgfF55GUa0
   IrUbfOu1JFddNi0aTmHpNy0VKeboXzQuu+LMpN83OhcNcjlc3ovoMiKRi
   A==;
X-CSE-ConnectionGUID: cunrz4YRRpeQeLPu+b1Gow==
X-CSE-MsgGUID: k0qZE7O+S2uBKo6Hk5OdGw==
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="32981640"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2024 05:07:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 18 Oct 2024 05:06:48 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 18 Oct 2024 05:06:46 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] iio: adc: pac1921: Add ACPI support to Microchip pac1921
Date: Fri, 18 Oct 2024 15:06:24 +0300
Message-ID: <20241018120624.15409-1-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
cate: Fri, 18 Oct 2024 14:11:37 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This driver implements ACPI support to Microchip pac1921.
The driver can read shunt resistor value and label from ACPI table.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

The patch was tested on minnowboard and sama5.

Differences related to previous versions:
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

 drivers/iio/adc/pac1921.c | 109 +++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a96fae546bc1..9622b0da6196 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -67,6 +67,13 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_UOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236-7a7a742e55cb"
+/*The maximum accepted value of shunt_resistor is 2Kohms */
+#define PAC1921_MAX_SHUNT_VALUE_OHMS		2000
+#define PAC1921_MAX_SHUNT_VALUE_UOHMS		2000000000
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -204,6 +211,11 @@ struct pac1921_priv {
 	} scan;
 };
 
+static inline bool pac1921_shunt_is_invalid(u32 shunt_val)
+{
+	return (shunt_val == 0 || shunt_val > PAC1921_MAX_SHUNT_VALUE_UOHMS);
+}
+
 /*
  * Check if first integration after configuration update has completed.
  *
@@ -781,7 +793,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
-	u64 rshunt_uohm;
+	u32 rshunt_uohm;
 	int val, val_fract;
 	int ret;
 
@@ -791,9 +803,13 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	ret = iio_str_to_fixpoint(buf, 100000, &val, &val_fract);
 	if (ret)
 		return ret;
+	
+	/* This check is to ensure val*MICRO won't overflow*/
+	if (val < 0 || val > PAC1921_MAX_SHUNT_VALUE_OHMS)
+		return -EINVAL;
 
 	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	if (pac1921_shunt_is_invalid(rshunt_uohm))
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
@@ -1150,6 +1166,71 @@ static void pac1921_regulator_disable(void *data)
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
+	u32 temp;
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
+	if (pac1921_shunt_is_invalid(temp))
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
+static int pac1921_parse_of_fw(struct i2c_client *client, struct pac1921_priv *priv)
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
+	if (pac1921_shunt_is_invalid(priv->rshunt_uohm))
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
+				     priv->rshunt_uohm);
+
+	pac1921_calc_current_scales(priv);
+
+	return 0;
+}
+
 static int pac1921_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1176,17 +1257,13 @@ static int pac1921_probe(struct i2c_client *client)
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
-
-	pac1921_calc_current_scales(priv);
+	if (ACPI_HANDLE(&client->dev))
+		ret = pac1921_match_acpi_device(client, priv, indio_dev);
+	else
+		ret = pac1921_parse_of_fw(client, priv);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "parameter parsing error\n");
 
 	priv->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(priv->vdd))
@@ -1243,11 +1320,17 @@ static const struct of_device_id pac1921_of_match[] = {
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

base-commit: 57573ace0c1b142433dfe3d63ebf375269c80fc1
-- 
2.43.0


