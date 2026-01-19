Return-Path: <linux-iio+bounces-27993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB0D3B5AB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1064E3041F47
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDE38E5FA;
	Mon, 19 Jan 2026 18:24:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB432936F
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847077; cv=none; b=pQhalf4n0sWkJFmJqUk7w6JMkLCXgFYMz72apHqVogj0Nm4zaWBq9uQTcLAlVpMhr5M22Jetfe+dKSkTbyGaRlHImgzpi4NEzNBlnRuFQFfI5+g5l26kYqH//zNny1u2Iitvr9AF2glROM2kT1YHwbaAzaxQ6fkOe+k7laOLF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847077; c=relaxed/simple;
	bh=WTzdsTpYNInqLGPOOUqeJAkoZ9UkVda5LqW9qOOCN/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaIrSjQuBkjTNlPuFct1plc4e0j4Yt8ej2pbAzeSfolc+vpb4OF/jV194V1weE5HlAVBDSYiCykRp1ANlrngl7r4dXkCrvNTbpKUrWK/6MUTWZhZKcYofvIYkUoTdwarIEF4420Swk7T66uIWbfITbZEHkzcRIRsCOXkk/TOH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-0004SP-7e; Mon, 19 Jan 2026 19:24:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-001SUl-1L;
	Mon, 19 Jan 2026 19:24:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvN-00000006y29-2gQi;
	Mon, 19 Jan 2026 19:24:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v1 5/8] iio: dac: ds4424: add Rfs-based scale and per-variant limits
Date: Mon, 19 Jan 2026 19:24:21 +0100
Message-ID: <20260119182424.1660601-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119182424.1660601-1-o.rempel@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Parse optional maxim,rfs-ohms values to derive the per-channel output
current scale (mA per step) for the IIO current ABI.

Select per-variant parameters to match the shared register map while
handling different data widths and full-scale current calculations.

Behavior changes:
- If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
  and reports mA/step derived from Rfs.
- If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
  working without requiring updates.
- RAW writes are now limited to the representable sign-magnitude range
  of the detected variant to avoid silent truncation (e.g. +/-31 on
  DS440x).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/iio/dac/ds4424.c | 137 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index 9c24c37d3c42..a0c60eb89717 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/delay.h>
@@ -54,12 +55,41 @@ enum ds4424_device_ids {
 	ID_DS4424,
 };
 
+/*
+ * Two variant groups share the same register map but differ in:
+ * - resolution/data mask (DS4402/DS4404: 5-bit, DS4422/DS4424: 7-bit)
+ * - full-scale current calculation (different Vref and divider)
+ * Addressing also differs (DS440x tri-level, DS442x bi-level), but is
+ * handled via board configuration, not driver logic.
+ */
+struct ds4424_chip_info {
+	u8 result_mask;
+	int vref_mv;
+	int scale_denom;
+};
+
+static const struct ds4424_chip_info ds4424_info = {
+	.result_mask = 0x7F,
+	.vref_mv = 976,
+	.scale_denom = 16,
+};
+
+/* DS4402 is handled like DS4404 (same resolution and scale formula). */
+static const struct ds4424_chip_info ds4404_info = {
+	.result_mask = 0x1F,
+	.vref_mv = 1230,
+	.scale_denom = 4,
+};
+
 struct ds4424_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	uint8_t save[DS4424_MAX_DAC_CHANNELS];
 	struct regulator *vcc_reg;
 	uint8_t raw[DS4424_MAX_DAC_CHANNELS];
+	const struct ds4424_chip_info *chip_info;
+	u32 rfs_ohms[DS4424_MAX_DAC_CHANNELS];
+	bool has_rfs;
 };
 
 static const struct iio_chan_spec ds4424_channels[] = {
@@ -111,6 +141,7 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	union ds4424_raw_data raw;
+	struct ds4424_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
@@ -122,10 +153,19 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		raw.bits = *val;
-		*val = raw.dx;
+		*val = raw.dx & data->chip_info->result_mask;
 		if (raw.source_bit == DS4424_SINK_I)
 			*val = -*val;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (!data->has_rfs)
+			return -EINVAL;
+
+		/* SCALE is mA/step: mV / Ohm = mA. */
+		*val = data->chip_info->vref_mv;
+		*val2 = data->rfs_ohms[chan->channel] *
+			data->chip_info->scale_denom;
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -136,6 +176,8 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
+	struct ds4424_data *data = iio_priv(indio_dev);
+	int max_val = data->chip_info->result_mask;
 	union ds4424_raw_data raw;
 
 	if (val2 != 0)
@@ -143,7 +185,12 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val <= S8_MIN || val > S8_MAX)
+		/*
+		 * The hardware uses sign-magnitude representation (not
+		 * two's complement). Therefore, the range is symmetric:
+		 * [-max_val, +max_val].
+		 */
+		if (val < -max_val || val > max_val)
 			return -EINVAL;
 
 		if (val > 0) {
@@ -173,6 +220,74 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int ds4424_setup_channels(struct i2c_client *client,
+				 struct ds4424_data *data,
+				 struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec channels[DS4424_MAX_DAC_CHANNELS];
+	size_t channels_size;
+	int i;
+
+	channels_size = indio_dev->num_channels * sizeof(*channels);
+	memcpy(channels, ds4424_channels, channels_size);
+
+	/* Enable scale only when rfs is available. */
+	if (data->has_rfs) {
+		for (i = 0; i < indio_dev->num_channels; i++)
+			channels[i].info_mask_separate |=
+				BIT(IIO_CHAN_INFO_SCALE);
+	}
+
+	indio_dev->channels = devm_kmemdup(&client->dev, channels,
+					   channels_size, GFP_KERNEL);
+	if (!indio_dev->channels)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int ds4424_parse_rfs(struct i2c_client *client,
+			    struct ds4424_data *data,
+			    struct iio_dev *indio_dev)
+{
+	int count, i, ret;
+
+	if (!device_property_present(&client->dev, "maxim,rfs-ohms")) {
+		dev_info_once(&client->dev, "maxim,rfs-ohms missing, scale not supported\n");
+		return 0;
+	}
+
+	count = device_property_count_u32(&client->dev, "maxim,rfs-ohms");
+	if (count != indio_dev->num_channels) {
+		dev_err(&client->dev,
+			"maxim,rfs-ohms must have %u entries\n",
+			indio_dev->num_channels);
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32_array(&client->dev,
+					     "maxim,rfs-ohms",
+					     data->rfs_ohms,
+					     indio_dev->num_channels);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to read maxim,rfs-ohms property\n");
+		return ret;
+	}
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (!data->rfs_ohms[i]) {
+			dev_err(&client->dev,
+				"maxim,rfs-ohms entry %d is zero\n",
+				i);
+			return -EINVAL;
+		}
+	}
+
+	data->has_rfs = true;
+	return 0;
+}
+
 static int ds4424_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -210,7 +325,7 @@ static int ds4424_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
 
-static const struct iio_info ds4424_info = {
+static const struct iio_info ds4424_iio_info = {
 	.read_raw = ds4424_read_raw,
 	.write_raw = ds4424_write_raw,
 };
@@ -252,15 +367,20 @@ static int ds4424_probe(struct i2c_client *client)
 	switch (id->driver_data) {
 	case ID_DS4402:
 		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		/* See ds4404_info comment above. */
+		data->chip_info = &ds4404_info;
 		break;
 	case ID_DS4404:
 		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4404_info;
 		break;
 	case ID_DS4422:
 		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4424_info;
 		break;
 	case ID_DS4424:
 		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		data->chip_info = &ds4424_info;
 		break;
 	default:
 		dev_err(&client->dev,
@@ -269,9 +389,16 @@ static int ds4424_probe(struct i2c_client *client)
 		goto fail;
 	}
 
-	indio_dev->channels = ds4424_channels;
+	ret = ds4424_parse_rfs(client, data, indio_dev);
+	if (ret)
+		goto fail;
+
+	ret = ds4424_setup_channels(client, data, indio_dev);
+	if (ret)
+		goto fail;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ds4424_info;
+	indio_dev->info = &ds4424_iio_info;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-- 
2.47.3


