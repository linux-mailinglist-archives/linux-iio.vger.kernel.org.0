Return-Path: <linux-iio+bounces-11670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA89B74BB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A85B21478
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F7146D53;
	Thu, 31 Oct 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VUPyZkrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C013B7B3;
	Thu, 31 Oct 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357581; cv=none; b=DP4j1TnFtWPtasZZg7aVRJQdSixiHTmWZWreaiteAJzFTJvcvaUkfDhTflz/8SRiUpnJ/lz4prZXDK7l7ORr7Dqfr1MigxCTVzkCl68XvzRfcbu0cT/1waJKzPph2t1mYmzlFQtHLe5tk+8m5SXg/LL8CE+24ZAWm8387N/d9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357581; c=relaxed/simple;
	bh=qeer1kcG6Rrt9N7t9xff6/AxPGGMumIvHuxnkuoA0o0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hdrueE39GvCaDSBFwpN3359stlO55eNGUwpTfa6dYyPjpTUG1DoILu8SkSksd+d7/FmrIp+MYpIuU3dA+77O8HdCbEXhQkjAKc2y+aiHmC0HmOb466ELoz1Y1kb6Yj28/iWPFdDMQAsWLbQbp1d9Ocfwh93WAv1P4Ze+zXp3Llw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VUPyZkrN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730357578; x=1761893578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qeer1kcG6Rrt9N7t9xff6/AxPGGMumIvHuxnkuoA0o0=;
  b=VUPyZkrNhscmhydev7kCTwL2zrSannw6kv4CiIL0ymGSGXlMxUgzORYn
   Kixu+58P0Mt4rbJwLx2DX+3sAVE8Brzrfp8wP66W/Blltlm8lO6RPqFHU
   enzUeOPJ0SrvZtWUb6JTosHsp5aaHb2TELjX99VV96NbJ2nhWhP1hEFKs
   kXqt0cKlr9y0p8LPny000ddIC95l9BzKUuxQ9Ab35Iq0Ul4McWw1gNAK7
   vwF40sAkfvUQ1AgP2PIuRgKk1GlJoLP2GCdtErz5Omf4Df7js6/ABEH7Y
   qC7dHzENlRteUqb53etOq5oZuVGL2oEsXXBxjBdhLJp1/8eAKSjs4uPVD
   Q==;
X-CSE-ConnectionGUID: 8YQN047qTAmKFCMPLpdrLg==
X-CSE-MsgGUID: 50sPAILrQkaR/pGgxJQQmQ==
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="201134074"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2024 23:52:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 30 Oct 2024 23:52:22 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 30 Oct 2024 23:52:21 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip pac1921
Date: Thu, 31 Oct 2024 08:52:05 +0200
Message-ID: <20241031065205.50154-1-victor.duicu@microchip.com>
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

 drivers/iio/adc/pac1921.c | 95 +++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a96fae546bc1..c6c8d85e3092 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -67,6 +67,12 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_UOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236-7a7a742e55cb"
+/* The maximum accepted value of shunt_resistor in UOHMS <= INT_MAX */
+#define PAC1921_MAX_SHUNT_VALUE_OHMS		2147
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -204,6 +210,11 @@ struct pac1921_priv {
 	} scan;
 };
 
+static inline bool pac1921_shunt_is_invalid(u32 shunt_val)
+{
+	return shunt_val == 0 || shunt_val > INT_MAX;
+}
+
 /*
  * Check if first integration after configuration update has completed.
  *
@@ -781,7 +792,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
-	u64 rshunt_uohm;
+	u32 rshunt_uohm;
 	int val, val_fract;
 	int ret;
 
@@ -792,8 +803,12 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	/* This check is to ensure val * MICRO won't overflow */
+	if (val < 0 || val > PAC1921_MAX_SHUNT_VALUE_OHMS)
+		return -EINVAL;
+
 	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	if (pac1921_shunt_is_invalid(rshunt_uohm))
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
@@ -1150,6 +1165,60 @@ static void pac1921_regulator_disable(void *data)
 	regulator_disable(regulator);
 }
 
+/*
+ * documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ */
+static int pac1921_match_acpi_device(struct iio_dev *indio_dev)
+{
+	acpi_handle handle;
+	union acpi_object *rez;
+	guid_t guid;
+	char *label;
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	struct device *dev = &priv->client->dev;
+
+	guid_parse(PAC1921_DSM_UUID, &guid);
+	handle = ACPI_HANDLE(dev);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = rez->package.elements[0].integer.value;
+	ACPI_FREE(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
+	if (!rez)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read label from ACPI table\n");
+
+	label = devm_kstrdup(dev, rez->package.elements->string.pointer, GFP_KERNEL);
+	if (!label)
+		return dev_err_probe(dev, -EINVAL, "Label is NULL\n");
+
+	indio_dev->label = label;
+	ACPI_FREE(rez);
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
@@ -1176,14 +1245,16 @@ static int pac1921_probe(struct i2c_client *client)
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
+	if (pac1921_shunt_is_invalid(priv->rshunt_uohm))
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
 				     priv->rshunt_uohm);
 
 	pac1921_calc_current_scales(priv);
@@ -1243,11 +1314,17 @@ static const struct of_device_id pac1921_of_match[] = {
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

base-commit: e2687d0723257db5025a4cf8cefbd80bed1e2681
-- 
2.43.0


