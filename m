Return-Path: <linux-iio+bounces-9772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71E986370
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B528A0B6
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AE13E03E;
	Wed, 25 Sep 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nLcgLCdx"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FDC8D1;
	Wed, 25 Sep 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276947; cv=none; b=uP9aBpZu436Z1tU0RL3EwFHptnZ5IaxsJgzlS/n0Wyu4XcymiIApc4TTLWhcAByyKa1VR9ogyz+bbow+xPcaYJd54QSWSXu7xN7/bft05CV3qAynOl+GM0Ryji5dbqWwkHfvEWKuSwmmMpoSk/vdPlBOraOAKLRBso47pwBvOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276947; c=relaxed/simple;
	bh=nQ/Cr5Bfm5KJBGUupn+Bz8PlyDkWSw0a2Ipd0EIg54g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=drTllLQvrqMbtgZEuZ/VGGEKElTkId10LF7CrqjuY03y+rB5fTM+tfYCZjJT8YI06RVLj7xJbYBWKNEpbi4dMEql0wiKn6smmq/UfahN1dGDSEtNp5s3waQVRxbDhZoXxbjZt8dQcbnBQ36nNpxar3DSE/6a3lsjYjy6RrRjGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nLcgLCdx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727276945; x=1758812945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nQ/Cr5Bfm5KJBGUupn+Bz8PlyDkWSw0a2Ipd0EIg54g=;
  b=nLcgLCdxfcUGwH+LPCxJjG2dpDT8RZEm9bT3GIryGMY6tYSMwbXC0kSK
   qpt0CxKmmhZW5j5oZztiauE4sQtKi4+wBCnrvQmpzHWJMnam1m8AxKL0G
   AnRwRqpxwXnYP61wid4fzTvmm615zzznJ2Lhk3J7D3fah+SLY3Gbq+8vS
   4uMm7cl4U15ac5/o+h+pdB4I7+D10HZLiDe0r8P5wDuaCP1CJf5YwRIDy
   nrBM/m5pFiRBBNChXDRL5b//B+Leh9IXXUcgETM0fzYOo+IoNDXZ7KVPr
   614SR4mwHrz7jsMHKAAFaLdCfRIm5h/CuIwgXa3Rq1So4JL8mdj4rrzHF
   Q==;
X-CSE-ConnectionGUID: r0BHBmfrTJ2zG0UC0FqmTQ==
X-CSE-MsgGUID: RpZnUojOS5aN67xiiPa9Jg==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="32846330"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 08:09:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 08:08:59 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 25 Sep 2024 08:08:58 -0700
From: <victor.duicu@microchip.com>
To: <matteomartelli3@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>
CC: <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <victor.duicu@microchip.com>
Subject: [PATCH v1] iio: adc: pac1921: add ACPI support for pac1921
Date: Wed, 25 Sep 2024 18:08:56 +0300
Message-ID: <20240925150856.19441-1-victor.duicu@microchip.com>
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

This patch implements ACPI support for pac1921.
Driver can read shunt resistor value and device name from ACPI table.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 drivers/iio/adc/pac1921.c | 116 +++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc39..9bb61b88aaef 100644
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
@@ -190,6 +194,7 @@ struct pac1921_priv {
 	u8 n_samples;
 	u8 prev_ovf_flags;
 	u8 ovf_enabled_events;
+	char *name;
 
 	bool first_integr_started;
 	bool first_integr_done;
@@ -1151,6 +1156,79 @@ static void pac1921_regulator_disable(void *data)
 	regulator_disable(regulator);
 }
 
+static int pac1921_match_acpi_device(struct i2c_client *client, struct pac1921_priv *priv)
+{
+	const struct acpi_device_id *device_pointer;
+	acpi_handle handle;
+	union acpi_object *rez;
+	guid_t guid;
+	struct device *dev = &client->dev;
+
+	guid_parse(PAC1921_DSM_UUID, &guid);
+	handle = ACPI_HANDLE(&client->dev);
+
+	device_pointer = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!device_pointer)
+		return -EINVAL;
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read shunt from ACPI table\n");
+
+	priv->rshunt_uohm = rez->package.elements[0].integer.value;
+	ACPI_FREE(rez);
+
+	if (priv->rshunt_uohm == 0)
+		return dev_err_probe(&client->dev, -EINVAL, "Shunt value is 0.");
+
+	pac1921_calc_current_scales(priv);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_NAME, NULL);
+	if (!rez) {
+		priv->name = "";
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Could not read name from ACPI table\n");
+	}
+
+	priv->name = devm_kmemdup(&client->dev, rez->package.elements->string.pointer,
+				  (size_t)rez->package.elements->string.length + 1,
+				  GFP_KERNEL);
+	priv->name[rez->package.elements->string.length] = '\0';
+	ACPI_FREE(rez);
+
+	return 0;
+}
+
+static int pac1921_match_of_device(struct i2c_client *client, struct pac1921_priv *priv)
+{
+	int ret;
+	struct device *dev = &client->dev;
+
+	/* Read shunt resistor value */
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &priv->rshunt_uohm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Cannot read shunt resistor property\n");
+
+	if (priv->rshunt_uohm == 0 || priv->rshunt_uohm > INT_MAX)
+		return dev_err_probe(dev, -EINVAL, "Invalid shunt resistor: %u\n",
+				     priv->rshunt_uohm);
+
+	pac1921_calc_current_scales(priv);
+
+	if (device_property_present(dev, "name")) {
+		ret = device_property_read_string(dev, "name", (const char **)&priv->name);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Invalid rail-name value\n");
+	} else {
+		priv->name = "pac1921";
+	}
+
+	return 0;
+}
+
 static int pac1921_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1172,22 +1250,14 @@ static int pac1921_probe(struct i2c_client *client)
 				     "Cannot initialize register map\n");
 
 	devm_mutex_init(dev, &priv->lock);
+	if (ACPI_HANDLE(&client->dev))
+		ret = pac1921_match_acpi_device(client, priv);
+	else
+		ret = pac1921_match_of_device(client, priv);
 
-	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
-	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
-	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
-
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
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "parameter parsing error\n");
 
 	priv->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(priv->vdd))
@@ -1198,13 +1268,15 @@ static int pac1921_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Cannot enable vdd regulator\n");
 
-	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
-				       priv->vdd);
+	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable, priv->vdd);
 	if (ret)
 		return dev_err_probe(dev, ret,
-			"Cannot add action for vdd regulator disposal\n");
+				     "Cannot add action for vdd regulator disposal\n");
 
 	msleep(PAC1921_POWERUP_TIME_MS);
+	priv->dv_gain = PAC1921_DEFAULT_DV_GAIN;
+	priv->di_gain = PAC1921_DEFAULT_DI_GAIN;
+	priv->n_samples = PAC1921_DEFAULT_NUM_SAMPLES;
 
 	ret = pac1921_init(priv);
 	if (ret)
@@ -1212,7 +1284,7 @@ static int pac1921_probe(struct i2c_client *client)
 
 	priv->iio_info = pac1921_iio;
 
-	indio_dev->name = "pac1921";
+	indio_dev->name = priv->name;
 	indio_dev->info = &priv->iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = pac1921_channels;
@@ -1244,11 +1316,17 @@ static const struct of_device_id pac1921_of_match[] = {
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


