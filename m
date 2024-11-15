Return-Path: <linux-iio+bounces-12304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525359CE02E
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 14:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133212827AC
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4C1CDFBD;
	Fri, 15 Nov 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FOY6yYVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB71CCEE8;
	Fri, 15 Nov 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677814; cv=none; b=uyY83qBPSZEbKs7KXCegilPl6VMUVOwlRcfUNNHJ62AfiIeOec1uNKZrCZkC2c1dlPAPoTEeO/o+GOHs+NYdjUvpI2iHCxq4/xTOO5YXOjWATQc1IsmGw3sBtp2YZRdDiiLwl9jGbZOpbGWwjdn6vIDLhuLxb/GdEO/kntNNQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677814; c=relaxed/simple;
	bh=J7dyRb7/qcbvuE/pNvHgIFBJ73+8RbYwnlABCVYflpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBEkP9rQ2LTLtSBpl7OE7N2JPRf1K262oLOfef5KZlRimfTzJX4GxcDdsSBJW8WMg1slA+m9ueLsO9sM98r+45p57Z1DgkTP/tkU6HdsTU106aYW4CA0+Xaei9slIJGl5H8Tl/COnAwdH7HYMbIdhsKmtegCBnn41ChRfmI6A3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FOY6yYVQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731677811; x=1763213811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7dyRb7/qcbvuE/pNvHgIFBJ73+8RbYwnlABCVYflpE=;
  b=FOY6yYVQKWK1X7IWxlR5jq46LomuSzwUDKvo8ZAkrhKR+UCYqpePOReQ
   aSBSLvDxioPDI2puSyuKhA4JfXlPlgqfv2bJTh1YifXnqBcxaySIgWAuC
   bopATZdEQCAT2eGj9eOd/EvPdFh9Gzvi3iU1fsSu8j8LmSdsy4jBM1Dgw
   m2G6ZUYQ1FEu/PShxNkSVIK8quZ6eufiYL7U64S2S7fvDmh0zHhDnhELF
   FS+O3Pf//GPFtjo2Uvhd53JI36Oeg8oebtsUB4Qyglr//ZEfgBr5/9pU+
   qlzTFrtyxDSr4xVXsQBAPuuPvnxtgzfdOEjRJThruKqB6pIcB2Rl7DW84
   w==;
X-CSE-ConnectionGUID: fXaFjTziTIG8BfiYuHBS+Q==
X-CSE-MsgGUID: JJtQUwhRRYeBojEJ2vvbGQ==
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="201804333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2024 06:36:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Nov 2024 06:36:04 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Nov 2024 06:36:01 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<andy.shevchenko@gmail.com>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13] iio: adc: pac1921: Add ACPI support to Microchip pac1921
Date: Fri, 15 Nov 2024 15:34:36 +0200
Message-ID: <20241115133436.13204-1-victor.duicu@microchip.com>
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
The driver can read the shunt resistor value and label from the ACPI table.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Matteo Martelli <matteomartelli3@gmail.com>
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

The patch was tested on minnowboard and sama5.

Differences related to previous versions:
v13:
- in pac1921_write_shunt_resistor remove unnecessary parenthesis
  in the check.
- in pac1921_probe change if (ret < 0) to if (ret), change
  !priv->rshunt_uohm to priv->rshunt_uohm == 0 and edit
  error message to be consistent with Matteo's code. This way
  unnecessary changes were removed.

v12:
- in pac1921_match_acpi_device reformat the instructions that
  were over 80 characters width.
- remove PAC1921_MAX_SHUNT_VALUE_uOHMS. Now the maximum acceptable value
  of shunt resistor is INT_MAX. In pac1921_write_shunt_resistor
  change the shunt check to respect the new limit and to avoid
  overflow in val * MICRO.

v11:
- credit Andy Shevchenko for code review.

v10:
- fix coding style mistakes.
- add UL to PAC1921_MAX_SHUNT_VALUE_uOHMS.
- edit comment in pac1921_write_shunt_resistor.
- in pac1921_probe use is_acpi_device_node instead of
  ACPI_HANDLE.

v9:
- put limits.h in sorted order.
- remove guid_parse and implement GUID_INIT.
- remove pac1921_shunt_is_valid.
- change maximum acceptable value of shunt resistor to 2146.999999.
  This change was made so the readings for dt and ACPI share
  the same range.
  With this value the maximum current that can be read is
  0.1V / 2146.999999 = 46.576 uA
  If we use INT_MAX the maximum current is
  0.1V / 2147.483647 = 46.566 uA
  The relative error between the two is 0.0214, so it is
  small enough to allow for code simplicity.
  A shunt value over a few hundred Ohms is quite unusual.

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

 drivers/iio/adc/pac1921.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index b0f6727cfe38..9f7b3d58549d 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/limits.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
@@ -67,6 +68,14 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_uOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+
+/* f7bb9932-86ee-4516-a236-7a7a742e55cb */
+static const guid_t pac1921_guid =
+			GUID_INIT(0xf7bb9932, 0x86ee, 0x4516, 0xa2,
+				  0x36, 0x7a, 0x7a, 0x74, 0x2e, 0x55, 0xcb);
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -782,7 +791,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
-	u64 rshunt_uohm;
+	u32 rshunt_uohm;
 	int val, val_fract;
 	int ret;
 
@@ -793,10 +802,17 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	/*
+	 * This check validates the shunt is not zero and does not surpass
+	 * INT_MAX. The check is done before calculating in order to avoid
+	 * val * MICRO overflowing.
+	 */
+	if ((!val && !val_fract) || val > INT_MAX / MICRO ||
+	    (val == INT_MAX / MICRO && val_fract > INT_MAX % MICRO))
 		return -EINVAL;
 
+	rshunt_uohm = val * MICRO + val_fract;
+
 	guard(mutex)(&priv->lock);
 
 	priv->rshunt_uohm = rshunt_uohm;
@@ -1151,6 +1167,61 @@ static void pac1921_regulator_disable(void *data)
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
+	char *label;
+	struct pac1921_priv *priv = iio_priv(indio_dev);
+	struct device *dev = &priv->client->dev;
+
+	handle = ACPI_HANDLE(dev);
+
+	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1,
+				   PAC1921_ACPI_GET_uOHMS_VALS, NULL);
+	if (!status)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = status->package.elements[0].integer.value;
+	ACPI_FREE(status);
+
+	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1,
+				   PAC1921_ACPI_GET_LABEL, NULL);
+	if (!status)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read label from ACPI table\n");
+
+	label = devm_kstrdup(dev, status->package.elements[0].string.pointer,
+			     GFP_KERNEL);
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
@@ -1179,11 +1250,14 @@ static int pac1921_probe(struct i2c_client *client)
 	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
 	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
 
-	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
-				       &priv->rshunt_uohm);
+	if (is_acpi_device_node(dev->fwnode))
+		ret = pac1921_match_acpi_device(indio_dev);
+	else
+		ret = pac1921_parse_of_fw(indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "Cannot read shunt resistor property\n");
+				     "Parameter parsing error\n");
+
 	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid shunt resistor: %u\n",
@@ -1246,11 +1320,18 @@ static const struct of_device_id pac1921_of_match[] = {
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

base-commit: 20fd1383cd616d61b2a79967da1221dc6cfb8430
-- 
2.43.0


