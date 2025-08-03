Return-Path: <linux-iio+bounces-22218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB4B1942C
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576AA7A6410
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075C258CE5;
	Sun,  3 Aug 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="ZjKYaUXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE394DF71
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230164; cv=none; b=R+Jn5ountPg3rT5zpGzrQ1H23xbOLV618bTEAHVLCSAgDeVpsjOo1M4gSA7od0tuxShgnRjUlq1igOKiafugRV42sl9aYfjkZ9angcu02F693pliTaoHr/pUtIVOGpk4++WYEhbZ1iUFmGLWAOleGvWEH3i43VXsQbWt0JKNXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230164; c=relaxed/simple;
	bh=H/QMWUjvgK0Vxt79TQdslrg0YTWalslk04JfC3wgFCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKKK5nootBj2MluEipmiCV8MV7E2V3J9YePiPkR1nb9jH5HclUSLsahc6IWftTHqMbi05zpywFYgFZytJYfpID/UMm2oyQE6EClIkFoR2AGPFRfWT4/R8Z/p72bTM7o7EY/6UK0aAC2P9lWBQNmB0NuOUe0IubE5jy+ltUBHDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=ZjKYaUXq; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id ECA6824056D;
	Sun,  3 Aug 2025 16:09:18 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 5BE20240206;
	Sun,  3 Aug 2025 16:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqEptRxAWFPqI07gyLRi+ReojYhHDHsDlvRz6OYAmDQ=;
	b=ZjKYaUXqJfugdxlGuno80/4R3Q3F70jmafJ5rK7afjY5+0f9iyNh76H+AqI2IfpB7krSfq
	jDth6az8GA5Jztskd/E9RCLtXy25T/O5SZaM7rdHyONyG1yivi9obVTcI0U2iXbFnzuWXX
	OurrnuC8J9dGaeR66bcLnMqF+xjaoRXfsFKZBHp/GNRrfAvFlGPTXFJ7DpHXOoVpYT4vFO
	BBVyB41msi5zskFYlDPlZc3B1P/cwvFIikpadr/QOgqeL4d1ufqXkuHjPDqxoGG/i8oRCe
	cmSSUswmoeiSn5oG76NcG70pEmmh4m0Yalm+Wa5H2THc6yqzn2yXjDRU6zHaGw==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 19C40240165;
	Sun,  3 Aug 2025 16:09:17 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 5/6] iio: pressure: bmp280: remove code duplication
Date: Sun,  3 Aug 2025 16:08:01 +0200
Message-ID: <20250803140802.36888-6-Achim.Gratz@Stromeko.DE>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: bdc116
X-Rspamd-UID: 5e1499

Refactor to get rid of duplicated code.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 89 +++++-------------------------
 1 file changed, 15 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index b3dcee3fe9b3..5cdaf7516940 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -658,6 +658,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling_temp;
 	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling_temp;
 	int switch_off, switch_threshold = -1;
+	int raw = 0;
 
 	guard(mutex)(&data->lock);
 
@@ -668,6 +669,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		raw = 1;
 	case IIO_CHAN_INFO_PROCESSED:
 		switch_off = 0;
 		if (data->op_mode == BMP280_FORCED) {
@@ -723,6 +726,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
 			*val = data->chip_info->humid_coeffs[0] * chan_value;
 			*val2 = data->chip_info->humid_coeffs[1];
 			return data->chip_info->humid_coeffs_type;
@@ -731,6 +738,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
 			*val = data->chip_info->press_coeffs[0] * chan_value;
 			*val2 = data->chip_info->press_coeffs[1];
 			return data->chip_info->press_coeffs_type;
@@ -739,86 +750,16 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
 			*val = data->chip_info->temp_coeffs[0] * chan_value;
 			*val2 = data->chip_info->temp_coeffs[1];
 			return data->chip_info->temp_coeffs_type;
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_RAW:
-		switch_off = 0;
-		if (data->op_mode == BMP280_FORCED) {
-			/* MODE_FORCED, switch off unused channels */
-			switch (chan->type) {
-			case IIO_HUMIDITYRELATIVE:
-				temp_oversampling_press = 0-1;
-				switch_off |= (prev_oversampling_press > switch_threshold);
-				/* can't be switched off as it is needed for compensation */
-				temp_oversampling_temp  = 1-1;
-				break;
-			case IIO_PRESSURE:
-				temp_oversampling_humid = 0-1;
-				switch_off |= (prev_oversampling_humid > switch_threshold);
-				/* can't be switched off as it is needed for compensation */
-				temp_oversampling_temp  = 1-1;
-				break;
-			case IIO_TEMP:
-				temp_oversampling_humid = 0-1;
-				temp_oversampling_press = 0-1;
-				switch_off = (prev_oversampling_humid > switch_threshold) |
-					     (prev_oversampling_press > switch_threshold);
-				break;
-			default:
-				return -EINVAL;
-			}
-		}
-		if (switch_off) {
-			data->oversampling_humid = temp_oversampling_humid;
-			data->oversampling_press = temp_oversampling_press;
-			data->oversampling_temp  = temp_oversampling_temp;
-			ret = data->chip_info->chip_config(data);
-			if (ret)
-				goto restore;
-		}
-
-		ret = data->chip_info->wait_conv(data);
-		if (ret)
-			goto restore;
-
-		if (switch_off) {
-			data->oversampling_humid = prev_oversampling_humid;
-			data->oversampling_press = prev_oversampling_press;
-			data->oversampling_temp  = prev_oversampling_temp;
-			data->chip_info->chip_config(data);
-			if (ret)
-				return ret;
-		}
-
-		switch (chan->type) {
-		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, &chan_value);
-			if (ret)
-				return ret;
-
-			*val = chan_value;
-			return IIO_VAL_INT;
-		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, &chan_value);
-			if (ret)
-				return ret;
-
-			*val = chan_value;
-			return IIO_VAL_INT;
-		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, &chan_value);
-			if (ret)
-				return ret;
-
-			*val = chan_value;
-			return IIO_VAL_INT;
-		default:
-			return -EINVAL;
-		}
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-- 
2.50.1


