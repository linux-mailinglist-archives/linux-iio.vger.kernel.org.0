Return-Path: <linux-iio+bounces-24536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A746BA756C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BB4E1333
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40040227BB5;
	Sun, 28 Sep 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="PpAHuEDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36851FFC6D
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080939; cv=none; b=sVDhcs5M0q9QjZEyJKLbBFAkIhROCgGd9COrDKspda7j96/7TeMCEM8rUiDsyqH/xwK8XO6D2w2jPqWqchsUkZhU1Ydn0uOoH64SGpxSLISBn4Enf8N1BAptbSBaYOKbqBwIcjZ0fp5rXujFpZH/7ZFTRAkAF8AtM6LOuAvJDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080939; c=relaxed/simple;
	bh=iELBQcwmiKQE+5ZsxAFsQumnhz+ox04qnxEQgubLE1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcnnWGeHgDWB/VN9aO+d1natGhHh6fJEOwTpiBWPrp1shmsG077AMoN6Pr81vd3jgFUAm5b9EbMyFQQsGJzLObQtxDENcCXvdJ953XtWCw9FU+HjKhx3bZ0C4ZiiA16j5UJ6FgOlhgZTN/MliGyzAhXbx8/EMMNwk5g4hjeUyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=PpAHuEDG; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id 09519240CC0;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 61ACC240832;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pupTuwm3WUHo0w0S7l4uGSdAk0L+f4INImG4nbR5oE4=;
	b=PpAHuEDGCaunbq/+QvZOQZ76USnC6umW1o7WnJAEVhpKdMcwcLQLZqI7gLtamaMKqDGFUV
	V4++ENckYEj2h7N2gJkyo9TWevArP2+CPn2yz9HADLuFccaJvhBwidel0dpURwb7jWGXrH
	oXi1Q7ARyZrlsFHNWAyrueF6lK5CWmTFWryow3F30t6YYUD9PjI5LBSnywFnarfXk3HnrY
	5k/j8wy8HbFzGBEcB5PHFcEbabw9HyEJn6GuARLvF1FzGRUGUI/RtoNTzpr1wPRhxsO8Mv
	49LTElNX/ldmYY2YMG/SOdRkDmtRd8okYYU5m93szEeKOfMVQde0yfUGcfichQ==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 181472407F1;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 5/9] iio: pressure: bmp280: remove code duplication
Date: Sun, 28 Sep 2025 19:26:33 +0200
Message-ID: <20250928172637.37138-7-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: 9256cb
X-Rspamd-UID: 936ed3

Eliminate code duplication from bmp280_read_raw_impl() by handling raw
and processed channel reads together.  The decision about which data format
to output is pre-computed in bool info_raw so that the switch
statement needs no fallthrough macro.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 46 +++++++++++-------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2dd36493acb4..4f5c4bd89067 100644
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
 		ret = data->chip_info->conv(data);
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
-		ret = data->chip_info->conv(data);
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
2.51.0


