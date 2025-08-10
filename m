Return-Path: <linux-iio+bounces-22529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD4B1FBD2
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8553B3522
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA41FBEB6;
	Sun, 10 Aug 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="SA5c+YYO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80E1FC0FC
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852369; cv=none; b=raleO6Vat8lrdRnQvO0X5FNKmhb5z+22PeXt7hjrJRst1tZTCTLMDi0O6nRfm4k9jQ5WdQejKuunuOR5dZjFzM1TMZYZTBy8vKqctzEu3FehsRZubpXgkjF9vEEwZwU6pJdy8ze9t4XcsHjCrTGFGsJGILL6dgab8SHe9ERWLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852369; c=relaxed/simple;
	bh=Ca8+K+41B34ICQ6Uz/gjKzgCBjAB9CYeJLlpJt1uops=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOVhmLXECoIUdQyoQFNRXBrAGDxt9a0BQ7j4IAWCv+9biJRYXEUOnlJ7J2htsf3PsFbyBCScONmXVJ7TArlhwDDj0YrPZKv5QScv0HBPjOG52aZm01iWDkEWUUEcDDqgPFNg7xb9USsyK4KnieFjVH8j9aD8twc90vJQ+5Zdpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=SA5c+YYO; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 1E736240AEA;
	Sun, 10 Aug 2025 20:59:20 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 7A349240159;
	Sun, 10 Aug 2025 20:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2kTJGoQFGsMtBI3gBwQLiwnnaZ7V84CyCVsf4KiRUY=;
	b=SA5c+YYO3K5s/4CsIPRSPFsxIkXhuYn1Jjad5xQvwcBth4TxWH3OGqyGltcnAs9ubObu4J
	8Ye4xI3xhwkhI/USmHn8MPh6HnfUnPwCjQMqcr64+ap4afoxzoqaoKvMeAweW8PCJcd+Gy
	8bnHuHjgefLwABd+F8ppj+0SPIQtlplAbbgcDOKuNoZMdJdLbsp8pJlFbFHB+KAEbz6kO4
	5BifvD78uwI47yrB/qR+4aNrN7cOTtgfeM4os7iw4wQtTLtgm82owWf6TY39qXJ6hexyQ7
	oszxTOo/1W4eMguxPn9IWTJfqeU0H5C7s0nuUm/0Q6TnJWcB7nfLmApYla9ugA==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 3C0F7240195;
	Sun, 10 Aug 2025 20:59:18 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 4/9] iio: pressure: bmp280: refactoring
Date: Sun, 10 Aug 2025 20:58:41 +0200
Message-ID: <20250810185846.114355-5-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: a8307b
X-Rspamd-UID: 76d96d

Refactor the measurement time calculation into a new function
bmp280_calc_meas_time_us() and use it in bmp280_wait_conv().  This is
currently the only consumer of this value, however calculation of
output data rate values will also require it.  As already commented in
bm280.h:468, but not actually implemented for the BMx280 devices,
sampling_frequency can be emulated indirectly via t_standby
configuration.

Also move the setting of BMP280_MODE_FORCED from
bmp280_read_raw_impl() into bmp[235]80_wait_conv(), as the measurement
cannot be started without having set the mode immediately before
starting the wait, so .wait_conv() should not have to rely on getting
called in the right context.  No mode setting is required for BMP180,
which only has a dummy bmp180_wait_conv() implementation anyway.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 50 +++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 7630c9d1265a..4f5982a36200 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -624,10 +624,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
-
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
 			return ret;
@@ -661,10 +657,6 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->set_mode(data, BMP280_FORCED);
-		if (ret)
-			return ret;
-
 		ret = data->chip_info->wait_conv(data);
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
+static int bmp280_wait_conv(struct bmp280_data *data)
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
 	 * Split the wait into an initial wait of ~94% of the typical
 	 * measurement time (which is ~87% of the maximum measurement
@@ -1070,6 +1079,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	 * duration where found to be the best compromise in overhead
 	 * over a range of oversampling settings.
 	 */
+	meas_time_us = bmp280_calc_meas_time_us(data);
 	initial_wait = (13 * meas_time_us) / 16;
 	fsleep(initial_wait);
 	meas_time_us -= initial_wait;
@@ -1717,6 +1727,15 @@ static int bmp380_wait_conv(struct bmp280_data *data)
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
 
@@ -2457,6 +2476,15 @@ static int bmp580_wait_conv(struct bmp280_data *data)
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
-- 
2.50.1


