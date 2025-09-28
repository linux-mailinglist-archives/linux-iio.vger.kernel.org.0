Return-Path: <linux-iio+bounces-24541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5FBA757E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C57A6D93
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C4A23958A;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="c1VyYhxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C522F389
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080940; cv=none; b=f+BWnhCrmp+Yfq1jnKDUm5CrHi4y4zMtDJzk0JthZrXgKRrs5vNBkfRlwdV7X+gkI8pZlMrrTe+rY9gkjWlTmLgXENhxHGT6z3wkCevny5oAsOwzYrOwy1VIMZ8L/OrjSnhdJ6Sc1+QWc5GQFHLECm5xy/4PAOwS0tNXblHVkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080940; c=relaxed/simple;
	bh=2EkPZrmxp97PzPXBwsPK5GA6aEdHjQlQaicUVUQgoRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0mYV0szQ+fG3RE/mS92ZBX50RqxBpDxFBCG9oxanL5EXAPMkZ1LCw+pokDXiksegyam4/AyZxQZfs5vipLK2fn2kBqZ80LqSgbhUufo/veh/7Ze4sh/IEV9jpf/0vSrg0tWm3Dvep7qXhzJud9yAiNYBq+7ZMQC4B2Mp1oEoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=c1VyYhxK; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 07AA4240AEA;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 618A82400FE;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKkW1lxvoPpdf9po6CH/8OX80kEOcq4EueCsw1LPXXU=;
	b=c1VyYhxKxf2SPyZz6x/WqfF8zSu2rELilfHUr7Q0NW4Qp/+3vNKNPG75xOuK47sTx4/CLm
	BLzXVcMbwTUFr1ghuD2H2GJWBrTqOvdLl40R5t5S9OnQDfrppTQp2IvPM/IPoFtbqfaQ2L
	+tqJh5HVICzOM4bwabKfcAIYcRtavreoYzU9H5ths5fhA0VkAUlsji0liIFos5VJ6ci+xF
	1OKKKKS4IMx5rhn7ay+X7bRVmrQEeZwGSkYVrIhMwualGVPjzwhmVZAOdDSjZMCKomYj38
	aprAGFbzxfdv2YeduyqZ/aAeLCu59N9JqwRgDnU879c3vvkPc0Kz8DIEl04IGg==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id D1523240740;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 4/9] iio: pressure: bmp280: rename wait_conv() to conv(), factor out measurement time calculation
Date: Sun, 28 Sep 2025 19:26:32 +0200
Message-ID: <20250928172637.37138-6-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: d38e2b
X-Rspamd-UID: f8193e

Rename wait_conv() to conv() as the function actually starts the
measurement conversion and does not just wait for it to complete.

Refactor the measurement time calculation into a new function
bmp280_calc_meas_time_us() and use it in bmp280_conv().  This is
currently the only consumer of this value, however calculation of
output data rate values will also require it.  As already commented in
bm280.h:468, but not actually implemented for the BMx280 devices,
sampling_frequency can be emulated indirectly via t_standby
configuration and will need this value for the calculation.

Also move the setting of BMP280_MODE_FORCED from
bmp280_read_raw_impl() into bmp[235]80_conv(), as the measurement
cannot be started without having set the mode immediately before
starting the measurement, so *_conv() should not have to rely on
getting called in the right context.  No mode setting is required for
BMP180, which only has a dummy bmp180_conv() implementation anyway to
keep a consistent device structure.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 74 ++++++++++++++++++++----------
 drivers/iio/pressure/bmp280.h      |  2 +-
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index cd305b6f022d..2dd36493acb4 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -624,11 +624,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
-
-		ret = data->chip_info->wait_conv(data);
+		ret = data->chip_info->conv(data);
 		if (ret)
 			return ret;
 
@@ -661,11 +657,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
-
-		ret = data->chip_info->wait_conv(data);
+		ret = data->chip_info->conv(data);
 		if (ret)
 			return ret;
 
@@ -1037,10 +1029,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static int bmp280_wait_conv(struct bmp280_data *data)
+static unsigned int bmp280_calc_meas_time_us(struct bmp280_data *data)
 {
-	unsigned int reg, meas_time_us, initial_wait;
-	int ret;
+	unsigned int meas_time_us;
 
 	/* Constant part of the measurement time */
 	meas_time_us = BMP280_MEAS_OFFSET;
@@ -1060,6 +1051,24 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	/* Temperature measurement time */
 	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
 
+	/* Waiting time according to the BM(P/E)2 Sensor API (maximum value) */
+	return meas_time_us;
+}
+
+static int bmp280_conv(struct bmp280_data *data)
+{
+	unsigned int reg, meas_time_us, initial_wait;
+	int ret;
+
+	/*
+	 * Each new measurement requires mode setting, as at the end
+	 * of the measurement cycle the sensor enters MODE_SLEEP
+	 * again.
+	 */
+	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	if (ret)
+		return ret;
+
 	/*
 	 * Split the waiting time into an initial part of ~94% of the
 	 * typical measurement time (which is ~87% of the maximum
@@ -1075,6 +1084,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	 * BMP280_MEAS_OFFSET, so the fsleep will always receive a
 	 * strictly positive argument.
 	 */
+	meas_time_us = bmp280_calc_meas_time_us(data);
 	initial_wait = (13 * meas_time_us) / 16;
 	fsleep(initial_wait);
 	meas_time_us -= initial_wait;
@@ -1217,7 +1227,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
 	.set_mode = bmp280_set_mode,
-	.wait_conv = bmp280_wait_conv,
+	.conv = bmp280_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1402,7 +1412,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
 	.set_mode = bmp280_set_mode,
-	.wait_conv = bmp280_wait_conv,
+	.conv = bmp280_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1714,11 +1724,20 @@ static int bmp380_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static int bmp380_wait_conv(struct bmp280_data *data)
+static int bmp380_conv(struct bmp280_data *data)
 {
 	unsigned int reg, meas_time_us, initial_wait;
 	int ret;
 
+	/*
+	 * Each new measurement requires mode setting, as at the end
+	 * of the measurement cycle the sensor enters MODE_SLEEP
+	 * again.
+	 */
+	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	if (ret)
+		return ret;
+
 	/* Offset measurement time */
 	meas_time_us = BMP380_MEAS_OFFSET;
 
@@ -1730,7 +1749,7 @@ static int bmp380_wait_conv(struct bmp280_data *data)
 	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
 		     BIT(data->oversampling_temp) * BMP380_MEAS_DUR;
 
-	/* See bmp280_wait_conv() */
+	/* See bmp280_conv() */
 	initial_wait = (13 * meas_time_us) / 16;
 	fsleep(initial_wait);
 	meas_time_us -= initial_wait;
@@ -2019,7 +2038,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 	.set_mode = bmp380_set_mode,
-	.wait_conv = bmp380_wait_conv,
+	.conv = bmp380_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_probe = bmp380_trigger_probe,
@@ -2443,7 +2462,7 @@ static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 	return 0;
 }
 
-static int bmp580_wait_conv(struct bmp280_data *data)
+static int bmp580_conv(struct bmp280_data *data)
 {
 	/*
 	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
@@ -2459,6 +2478,15 @@ static int bmp580_wait_conv(struct bmp280_data *data)
 	};
 	unsigned int meas_time_us;
 
+	/*
+	 * Each new measurement requires mode setting, as at the end
+	 * of the measurement cycle the sensor enters MODE_SLEEP
+	 * again.
+	 */
+	ret = data->chip_info->set_mode(data, BMP280_FORCED);
+	if (ret)
+		return ret;
+
 	meas_time_us = 4 * USEC_PER_MSEC +
 		       time_conv_temp[data->oversampling_temp] +
 		       time_conv_press[data->oversampling_press];
@@ -2712,7 +2740,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
 	.set_mode = bmp580_set_mode,
-	.wait_conv = bmp580_wait_conv,
+	.conv = bmp580_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_probe = bmp580_trigger_probe,
@@ -2968,7 +2996,7 @@ static int bmp180_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
 }
 
 /* Keep compatibility with newer generations of the sensor */
-static int bmp180_wait_conv(struct bmp280_data *data)
+static int bmp180_conv(struct bmp280_data *data)
 {
 	return 0;
 }
@@ -3047,7 +3075,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
 	.set_mode = bmp180_set_mode,
-	.wait_conv = bmp180_wait_conv,
+	.conv = bmp180_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -3125,7 +3153,7 @@ const struct bmp280_chip_info bmp085_chip_info = {
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
 	.set_mode = bmp180_set_mode,
-	.wait_conv = bmp180_wait_conv,
+	.conv = bmp180_conv,
 
 	.trigger_probe = bmp085_trigger_probe,
 	.trigger_handler = bmp180_trigger_handler,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 25bb9c743a05..df90ed720bc6 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -519,7 +519,7 @@ struct bmp280_chip_info {
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
 	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
-	int (*wait_conv)(struct bmp280_data *data);
+	int (*conv)(struct bmp280_data *data);
 
 	int (*trigger_probe)(struct iio_dev *indio_dev);
 	irqreturn_t (*trigger_handler)(int irq, void *p);
-- 
2.51.0


