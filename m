Return-Path: <linux-iio+bounces-22220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4726B19433
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B05E171F48
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586623E356;
	Sun,  3 Aug 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="A+A70Oz7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E441217734
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230691; cv=none; b=Xi6XYX8EHrN60FkogolnpGTHtZrbxv65X3tw21pPUDPZbJ25HXzV68hnIgMAn2F5hVSArYGcorIBC9mExay7kMkeT7gtz2678aSpl1PLZh0Ew1UC2fT5LTpV8E3zokMgK7kKamz09xWbn/MLXAoLH1gORPyvPrBQQPGqV/5tGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230691; c=relaxed/simple;
	bh=3tpcy+BnLdLYoZ1aBCR7O9YrSIR5jZ+I9917UVRFAPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG/mzrnDLOJf7Wwhk2X4YA/fAAA7VccB1tQjyBU2jh7lfWawSAhc72QkF0tUBI2N2DaHE3rSR54GGA3FLnWhAzjuu05b/w4y5pDSJtwCvUpeRveAlObQk1sPfr3kJaqj5adj0BRYiFiRgXQKZl3K1ZHONBJRmTD1/he1LK0A010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=A+A70Oz7; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id A1A06240516;
	Sun,  3 Aug 2025 16:09:06 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 12EC0240165;
	Sun,  3 Aug 2025 16:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9IXV17YGzfvUJ5Ceva73t+BDHrJ+BCCRvaVAYBmZlM=;
	b=A+A70Oz7LB8CZUnhstBd28XqN2dIyAqHk/tHaDTrc4DNL9CBlTyargw3JWygc+aKDYSFXS
	6meZwCJekFlYlL8cIpOuNSW3xyfmg2nIWFS3X16CC9q8qq+mObUcziBqCiBKTvULO9oc5w
	zqAezSqT3DnvRTnp5KRgk92T1luQom4g8gvBebaBC8ILqwJtWx9+MAg/r7WJ54oqgYKB4h
	edLzWRE69uOq91ySdN4xDLRUYGkYhJZ/quON0nNlZ7tIE4qSSODOdPvEMG1bKCB9K2q1Em
	9hf69mBolsP0NYpiPgRfpWd4x+GspXpQcHpInISRQ5cNc0R3q+tzvj12egaVjA==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id B127D240036;
	Sun,  3 Aug 2025 16:09:04 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 2/6] iio: pressure: bmp280: reduce overhead on read with MODE_FORCED
Date: Sun,  3 Aug 2025 16:07:58 +0200
Message-ID: <20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: fc4b56
X-Rspamd-UID: 58b075

When measuring with MODE_FORCED, each read through sysfs triggers a
new measurement cycle through aLL channels with the current channel
configuration, even though we can only access a single channel.
Reduce the incurred overhead (especially for higher oversampling_ratio
settings) by temporarily switching off the unused channels.  This
savea about a third of the acquisition time when reading all three
channels in succession:

| oversampling | max/full | max/skip | time/full | time/skip |
|              |     [ms] |     [ms] |      [ms] |      [ms] |
|--------------+----------+----------+-----------+-----------|
|           16 |      339 |      120 |       315 |       127 |
|            8 |      174 |       65 |       166 |        76 |
|            4 |       90 |       38 |        94 |        53 |
|            2 |       49 |       24 |        59 |        41 |
|            1 |       28 |       17 |        36 |        33 |

The results are from an I²C connected sensor at 400kHz, so there is
considerable overhead from the changing the channel configuration,
most noticeably with low oversampling_ratio values.  Faster
communication will reduce this overhead further; and since there is
still a net reduction in acquisition time even for
oversampling_ratio=1 switching off the channels is always done.

Note: The IIR filters will process a slightly noisier input signal.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 138 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |   7 +-
 2 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3213dcadba28..858974a64306 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -619,18 +619,66 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int chan_value;
 	int ret;
+	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling_temp;
+	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling_temp;
+	int switch_off, switch_threshold = -1;
 
 	guard(mutex)(&data->lock);
 
+	prev_oversampling_humid = temp_oversampling_humid = data->oversampling_humid;
+	prev_oversampling_press = temp_oversampling_press = data->oversampling_press;
+	prev_oversampling_temp  = temp_oversampling_temp  = data->oversampling_temp;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
+		/* switch off unused channels */
+		switch_off = 0;
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			temp_oversampling_press = 0-1;
+			switch_off |= (prev_oversampling_press > switch_threshold);
+			/* can't be switched off as it is needed for compensation */
+			temp_oversampling_temp  = 1-1;
+			break;
+		case IIO_PRESSURE:
+			temp_oversampling_humid = 0-1;
+			switch_off |= (prev_oversampling_humid > switch_threshold);
+			/* can't be switched off as it is needed for compensation */
+			temp_oversampling_temp  = 1-1;
+			break;
+		case IIO_TEMP:
+			temp_oversampling_humid = 0-1;
+			temp_oversampling_press = 0-1;
+			switch_off = (prev_oversampling_humid > switch_threshold) |
+				     (prev_oversampling_press > switch_threshold);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret)
+				goto restore;
+		}
+
 		ret = data->chip_info->set_mode(data, BMP280_FORCED);
 		if (ret)
-			return ret;
-
+			goto restore;
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
-			return ret;
+			goto restore;
+
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret)
+				return ret;
+		}
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -661,13 +709,55 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
+		/* switch off unused channels */
+		switch_off = 0;
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			temp_oversampling_press = 0-1;
+			switch_off |= (prev_oversampling_press > switch_threshold);
+			/* can't be switched off as it is needed for compensation */
+			temp_oversampling_temp  = 1-1;
+			break;
+		case IIO_PRESSURE:
+			temp_oversampling_humid = 0-1;
+			switch_off |= (prev_oversampling_humid > switch_threshold);
+			/* can't be switched off as it is needed for compensation */
+			temp_oversampling_temp  = 1-1;
+			break;
+		case IIO_TEMP:
+			temp_oversampling_humid = 0-1;
+			temp_oversampling_press = 0-1;
+			switch_off = (prev_oversampling_humid > switch_threshold) |
+				     (prev_oversampling_press > switch_threshold);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (switch_off) {
+			data->oversampling_humid = temp_oversampling_humid;
+			data->oversampling_press = temp_oversampling_press;
+			data->oversampling_temp  = temp_oversampling_temp;
+			ret = data->chip_info->chip_config(data);
+			if (ret)
+				goto restore;
+		}
+
 		ret = data->chip_info->set_mode(data, BMP280_FORCED);
 		if (ret)
-			return ret;
-
+			goto restore;
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
-			return ret;
+			goto restore;
+
+		if (switch_off) {
+			data->oversampling_humid = prev_oversampling_humid;
+			data->oversampling_press = prev_oversampling_press;
+			data->oversampling_temp  = prev_oversampling_temp;
+			data->chip_info->chip_config(data);
+			if (ret) {
+				return ret;
+			}
+		}
 
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -741,6 +831,15 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
+restore:
+	if (switch_off) {
+	/* restore channel configuration */
+		data->oversampling_humid = prev_oversampling_humid;
+		data->oversampling_press = prev_oversampling_press;
+		data->oversampling_temp  = prev_oversampling_temp;
+		data->chip_info->chip_config(data);
+	}
+	return ret;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
@@ -1040,6 +1139,7 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 static int bmp280_wait_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us;
+	int wait_cycles = BMP280_MEAS_WAITCYCLES;
 	int ret;
 
 	meas_time_us = BMP280_MEAS_OFFSET;
@@ -1056,14 +1156,26 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
-	/* Waiting time according to the BM(P/E)2 Sensor API */
-	fsleep(meas_time_us);
+	do {
+		/*
+		 * Waiting time according to the BM(P/E)2 Sensor API.
+		 *
+		 * First wait is for slightly longer than the typical measurement time, then
+		 * each successive wait cycle will divide that time by 8.  The number of wait
+		 * cycles determines the overhead, this number and the measurement durations
+		 * need to be chosen so that the total wait time meets or exceeds the maximum
+		 * measurement time acccording to the datasheet.
+		 */
+		fsleep(meas_time_us);
 
-	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
-	if (ret) {
-		dev_err(data->dev, "failed to read status register.\n");
-		return ret;
-	}
+		ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+		if (ret) {
+			dev_err(data->dev, "failed to read status register.\n");
+			return ret;
+		}
+	} while ((reg & BMP280_REG_STATUS_MEAS_BIT) &&
+		 --wait_cycles &&
+		 (meas_time_us >>= 3));
 
 	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
 		dev_err(data->dev, "Measurement cycle didn't complete.\n");
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 25bb9c743a05..88f5898282ec 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -269,9 +269,10 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
-#define BMP280_MEAS_OFFSET		1250
-#define BMP280_MEAS_DUR			2300
-#define BMP280_PRESS_HUMID_MEAS_OFFSET	575
+#define BMP280_MEAS_WAITCYCLES		2    /* minimize overhead */
+#define BMP280_MEAS_OFFSET		1112 /* ceil(1250 * 8/9) */
+#define BMP280_MEAS_DUR			2045 /* ceil(2300 * 8/9) */
+#define BMP280_PRESS_HUMID_MEAS_OFFSET	512  /* ceil( 575 * 8/9) */
 
 /* BME280 specific registers */
 #define BME280_REG_HUMIDITY_LSB		0xFE
-- 
2.50.1


