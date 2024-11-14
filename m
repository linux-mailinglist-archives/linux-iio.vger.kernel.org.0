Return-Path: <linux-iio+bounces-12238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7119C853A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11625B29D39
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48521F76A5;
	Thu, 14 Nov 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rly70Xj8"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791061F709D;
	Thu, 14 Nov 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574148; cv=none; b=iOvPZ46P5z8zkVARylmQx7Jg5Ifmz5BzKG0XtQVmkStuuESvc7K1WfXZZon45YWf7XxC9TueLGNJkRTOjCozFA+7amL+2BC8pG36h3XglFzv88cmINyMMwOS8Vcpye2H7sIWZNYYlxTXKCJDfC8oW3vSsDouMVOvzgh51m+fDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574148; c=relaxed/simple;
	bh=byDETJbTeVz3nwdfzrvFfAHPl/b/mc8k5BW/rN4mUjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1o11+nI4X/IPXCwUZRLsRo6rSQrTwo7kkhL7KHF0QA3HDoR8ngF9XzT7HDsJzM4tjEtPm9WmOFAY0lJyLflrqEAqq4YdWv0zW250TuXTv79bjhV9mm6q3YRH8/XL2nkGAVWL61Y0Oqn//olZjPckOLgcut+vxLsahSRrMKKV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rly70Xj8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731574146; x=1763110146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=byDETJbTeVz3nwdfzrvFfAHPl/b/mc8k5BW/rN4mUjU=;
  b=rly70Xj8J4FF6x8YYgN+hO6XS5sTjCEsKsY3B5sxLPsilzIO3TcVYo/r
   pf5bQlo273F5T0JkRr8erMdk88A4aNJM6Stxgx5NX6Mp637oX+dozEYoR
   jJRu26ByreTOQ/mDuWOOR7x7tD4UJ3y1UcY5zvLhCFqFln/NE5C0z3E/t
   JqoBsZIJ0mrCVP8wjOvCufOhTIwQB2wniFUPwo5l0sqph08lXfy2ghmmw
   iRMNzT+mE22kFTSSwrujeQ9v+HG9HHcNTRbsbChKaudWhAoP+Y/QplP7m
   pHAK2Xa9NAoF4AElCMtlf7E1Y5RrDn1wpeVeW8q5Hu/qB7/vB61UeZQ/x
   A==;
X-CSE-ConnectionGUID: PoEyi07LTq+PBDLoS2xvEQ==
X-CSE-MsgGUID: nPSbEAhkQpWeXSbXwFCMjg==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="34037340"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 01:49:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 01:48:22 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 01:48:19 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
	<andy.shevchenko@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>, <victor.duicu@microchip.com>
Subject: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip pac1921
Date: Thu, 14 Nov 2024 10:47:02 +0200
Message-ID: <20241114084702.3499-1-victor.duicu@microchip.com>
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
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---

The patch was tested on minnowboard and sama5.

Differences related to previous versions:
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

 drivers/iio/adc/pac1921.c | 110 ++++++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index b0f6727cfe38..9da94d14132a 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/limits.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
@@ -67,6 +68,27 @@ enum pac1921_mxsl {
 #define PAC1921_DEFAULT_DI_GAIN		0 /* 2^(value): 1x gain (HW default) */
 #define PAC1921_DEFAULT_NUM_SAMPLES	0 /* 2^(value): 1 sample (HW default) */
 
+#define PAC1921_ACPI_GET_uOHMS_VALS             0
+#define PAC1921_ACPI_GET_LABEL			1
+/*
+ * The maximum acceptable shunt value is 2146.999999 OHM.
+ * This value, which is below INT_MAX, was chosen in order to
+ * allow the readings from dt and ACPI to share the same range
+ * and to simplify the checks.
+ * With this value the maximum current that can be read is
+ * 0.1V / 2146.999999OHM = 46.576 uA
+ * If we use INT_MAX the maximum current that can be read is
+ * 0.1V / 2147.483647OHM = 46.566 uA
+ * The relative error between the two values is
+ * |(46.566 - 46.576) / 46.566| * 100 = 0.0214
+ */
+#define PAC1921_MAX_SHUNT_VALUE_uOHMS		2146999999UL
+
+/* f7bb9932-86ee-4516-a236-7a7a742e55cb */
+static const guid_t pac1921_guid =
+			GUID_INIT(0xf7bb9932, 0x86ee, 0x4516, 0xa2,
+				  0x36, 0x7a, 0x7a, 0x74, 0x2e, 0x55, 0xcb);
+
 /*
  * Pre-computed scale factors for BUS voltage
  * format: IIO_VAL_INT_PLUS_NANO
@@ -782,7 +804,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 					    const char *buf, size_t len)
 {
 	struct pac1921_priv *priv = iio_priv(indio_dev);
-	u64 rshunt_uohm;
+	u32 rshunt_uohm;
 	int val, val_fract;
 	int ret;
 
@@ -793,10 +815,17 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	rshunt_uohm = val * MICRO + val_fract;
-	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
+	/*
+	 * This check validates the shunt is not zero and does not surpass the
+	 * maximum value. The check is done before calculating in order to avoid
+	 * val * MICRO overflowing.
+	 */
+	if ((!val && !val_fract) ||
+	    ((u32)val > PAC1921_MAX_SHUNT_VALUE_uOHMS / MICRO))
 		return -EINVAL;
 
+	rshunt_uohm = val * MICRO + val_fract;
+
 	guard(mutex)(&priv->lock);
 
 	priv->rshunt_uohm = rshunt_uohm;
@@ -1151,6 +1180,58 @@ static void pac1921_regulator_disable(void *data)
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
+	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1, PAC1921_ACPI_GET_uOHMS_VALS, NULL);
+	if (!status)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = status->package.elements[0].integer.value;
+	ACPI_FREE(status);
+
+	status = acpi_evaluate_dsm(handle, &pac1921_guid, 1, PAC1921_ACPI_GET_LABEL, NULL);
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
@@ -1179,14 +1260,16 @@ static int pac1921_probe(struct i2c_client *client)
 	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
 	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
 
-	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms",
-				       &priv->rshunt_uohm);
-	if (ret)
+	if (is_acpi_device_node(dev->fwnode))
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
+	if (!priv->rshunt_uohm || priv->rshunt_uohm > PAC1921_MAX_SHUNT_VALUE_uOHMS)
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
 				     priv->rshunt_uohm);
 
 	pac1921_calc_current_scales(priv);
@@ -1246,11 +1329,18 @@ static const struct of_device_id pac1921_of_match[] = {
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


