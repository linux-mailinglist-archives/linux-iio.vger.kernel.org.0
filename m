Return-Path: <linux-iio+bounces-22531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4CB1FBD3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D073B7FF5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C01FF1BF;
	Sun, 10 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="Eokv/DC2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DD1FDA82
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852371; cv=none; b=CuuA+PXYV9kK3LK9hIMlwiqMfAeeaqHKgfzMDeUnIPzI7vym5N3iVuBWCJt5n2h9o/cnHNpVpsd0Gf1BvS4ESqOw6FplRFJzx7lUqpYoYiO3S01DNt76VwgND6GI3d3wIYmPZcYBNc9pUrzGqcbf5COXATBq9j62el2S2FoVQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852371; c=relaxed/simple;
	bh=2IKhmQ9iE+XEumz1VcgphTXqh6KlIfIyEuW/H3sgLOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN+HA0VU/aInb4PXXgRAg2b81zxo+l1K7KaK1y2Ls+lhB8VbFs+FHRJYmjpZMkezMGsjQLqafASMCG5FkbdOqGyNxKsnI1NCCyR4QtwwpwHhwoB47pkTlcLt5dAQnO74C+2vIoohQGl7DcBQJ0cS3iBuPz3KUyH329iOM+b7oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=Eokv/DC2; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id BA163240D73;
	Sun, 10 Aug 2025 20:59:21 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 277A6240159;
	Sun, 10 Aug 2025 20:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI+0QFw/hHHdNxmXKTfZPCwPtWwo677ljztYGq0VHj4=;
	b=Eokv/DC2dvbaHf2Hl7t11kT1ef6NZZABsmQInXaqdVFGSuhXSPR28RApapthXApHO2q7a9
	xlifHldazECCCbyZO0nAa+PMt9glwQY2HeWyoD9oNrq5ktdUkRt49KaNVkN/+zF2/AlTbS
	g5wnouEVpYiUu5FKvoy2ZhLywgd38fvt6K8YIwI0DfH7W/Mg15nm7v2ocIXgfVASbznFBb
	iJ3/X3E4NeCeTBSL+yFw58gd4rbmYEicuJpgRU5vGsMcdbOHs+uuHRGiMUrKQaedsKo5Pv
	8Gq1jEXWZnGmRCdV1jeWIWwTfyqJ4qQbchcPZ7Gfh5xprNef8Sfbun4YvkfViw==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id E1A9724026C;
	Sun, 10 Aug 2025 20:59:19 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 5/9] iio: pressure: bmp280: remove code duplication
Date: Sun, 10 Aug 2025 20:58:42 +0200
Message-ID: <20250810185846.114355-6-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 079648
X-Rspamd-UID: f02caf

Eliminate code duplication from bmp280_read_raw_impl() by handling raw
and processed channel reads together.  The decision about which data format
to output is pre-computed in bool info_raw so that the switch
statement needs no fallthrough macro.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 46 +++++++++++-------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4f5982a36200..fbecee9928e8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -619,10 +619,12 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int chan_value;
 	int ret;
+	bool info_raw = mask & IIO_CHAN_INFO_RAW;
 
 	guard(mutex)(&data->lock);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
 		ret = data->chip_info->wait_conv(data);
 		if (ret)
@@ -634,6 +636,11 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (info_raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
+
 			*val = data->chip_info->humid_coeffs[0] * chan_value;
 			*val2 = data->chip_info->humid_coeffs[1];
 			return data->chip_info->humid_coeffs_type;
@@ -642,6 +649,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (info_raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
 			*val = data->chip_info->press_coeffs[0] * chan_value;
 			*val2 = data->chip_info->press_coeffs[1];
 			return data->chip_info->press_coeffs_type;
@@ -650,42 +661,17 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
+			if (info_raw) {
+				*val = chan_value;
+				return IIO_VAL_INT;
+			}
+
 			*val = data->chip_info->temp_coeffs[0] * chan_value;
 			*val2 = data->chip_info->temp_coeffs[1];
 			return data->chip_info->temp_coeffs_type;
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_RAW:
-		ret = data->chip_info->wait_conv(data);
-		if (ret)
-			return ret;
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


