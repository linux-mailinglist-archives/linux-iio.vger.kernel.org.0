Return-Path: <linux-iio+bounces-18665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2BA9D3E7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B72A4E11AF
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59060224B05;
	Fri, 25 Apr 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qiOjvBV3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161E224882
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615383; cv=none; b=ltpnzbkYKNbZO9oD1JN0uOlmW9SkSrNKDU0ijhHZET9vBQ+2P5izIPCRp69VdiZOe/YpUP/7nthtQgInGHdaG8+txLx+/Ll00lGHS3U2LVuNhFVJfGZKyT4xYKqRFlUIJWwBvJmIwDPuVjmvjhwLs0PFSypOhp5I3vR+nMtumsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615383; c=relaxed/simple;
	bh=NLK9rHWGxHgHc450e6JA3Kx5J3+N1Fpz21XOi57G4v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5XJf/ga95bSyRhPhCRGPkKKAPfeBo6BAkOBPgiss7yP3PXRTw/RBLmlHiGG1FwMX84Dq6zKSIjKKCxG4xV/EHLKt+44HUZ94Wpt5cwpiDtOx9Xf3qku9SzhSqWLyeAtmeWWInl5Psk/4L1ImWzzSsuEg9oE2h7zYhMhjKm3CCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qiOjvBV3; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c7336ed99so750547a34.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615380; x=1746220180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2koMhN4hR5KSSnBsIlIFgfxzAiKDp/j1dG+oyh3qTA=;
        b=qiOjvBV3Jq3l0J78a7B5QTmd0v5vcv/cOPQDFJaeW6/7HP+rtVagnHpaucX5Km130O
         q2CUSpTppullb9rqe9RvaT4BaLJ21nd5roiP4ddSwXoQAysjxeJa+YgN0YC75prGgpd0
         z79UAfW0K5g7zsrYQ5gFFohR9NF2Mw0GYKQcuq92zoSAh+Bp1C7v4vBWrn8yFAIYQwth
         nZcr7ZPGuomrfVLv/BOpW72R9xusjaNgpTIIYgE5YonEayZJiC4DdcjUV+3dAVqbSWqG
         1Pwmp0ZFwDv6TIDU+Jq90D6cSypohfalKWNmSDad5n0J6LXcUEeMom/F1BBnOX8185IS
         Xduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615380; x=1746220180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2koMhN4hR5KSSnBsIlIFgfxzAiKDp/j1dG+oyh3qTA=;
        b=RsldzmEmttXDoC/Zbs9QzhcfWlA6uuuOYcnhOGJjwyQMz9JkWC1Y0mGq5eQ+EP9I39
         xX9ZnKSG3tom14paCr7QDSqqTeuAjJD1GgPuy5EVQwxbbzgCLalbLTLO6nbTOIvn4ubp
         Q8hXXG9JjRXs4cjLqmA5S4jAe/sSNZyDuDRz7XOgzPVYlzcuqVTCIn0GFvgqPbomCw47
         ArB1GZA2VQp2g6A4e5ZrY7Y/vq/S7q+stgJezAUbY69IY7P1v2stYNkjyyJF1628QhlZ
         9dKhN3N9pLLryHrH3MHp7FCQtqZ61ZyF09+oqBQYoBnV4Q2/JKUmWZTCTovgiREGwQAV
         0alg==
X-Gm-Message-State: AOJu0Yx4YXrxvm7eX74B0H4vF0Lw7JsMl8zPLaeIOJ19hwUl6xKvt4hS
	OabUj78W8ZqR1ZsMCcLFUJP4jFBrBfh7DeAAMhWgeMVfsTvf37LiCmHOxuFUlrY=
X-Gm-Gg: ASbGnctlgou0L7kKd5RTqVcxVBYUR6rUqjSaQ0lJYbxzlL5htLBM6sLXEKwJyMvi8kf
	N944MaKVghnHvewA+xbvbVrhvyYWLgNTxqu4dIbcLOWnAbGPy2Zu4o4dEgNg+WQRhymgivu0OrV
	7m1MLUwnB+rgTG92A8343J0m5krpSFLJvxQi92QOKCYqqk5O2VxrBJbhZFvGoIwlWZjYU9tA1O+
	kl3pa2h46aJ6TF4q5AUTonY/eg+I3UK9lwoFz+J5Fe0rbu6Noyuof/uzskHSnf16H5krCJh24os
	228qcyIWZMTQfYV/wgtr7FP54NE9dB8jCr+zYw5p9QdX
X-Google-Smtp-Source: AGHT+IGKc5OoUlGqAMHb8DxpInuVuqSVZZrq1V/GWDAa8RVUKrWc/HhQWHVIWR6LgXFCY+EudsWgsg==
X-Received: by 2002:a05:6830:6103:b0:727:423c:95d5 with SMTP id 46e09a7af769-7306507d10cmr827931a34.3.1745615380147;
        Fri, 25 Apr 2025 14:09:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:44 -0500
Subject: [PATCH v3 2/6] iio: adc: ad4695: use u16 for buffer elements
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-2-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NLK9rHWGxHgHc450e6JA3Kx5J3+N1Fpz21XOi57G4v0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/ntGikd68zhc3eGez4DLRFRcNXynKp9dhqTH
 axf3aMkGNaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv57QAKCRDCzCAB/wGP
 wAgDB/0auzgk1L/frm29yKaf4b3PEH/of/+PWSRx7XnDdBIbgId0dZU5fPeSrZtK//pb6MguHyN
 pTTAJcteQG4JB7+lSY0FCltwzuC5VL5jILT78ZTc1OQSZOLlXMv5G/33kUicVLCye+/ZcIXb2Rf
 THjJLuO79tWICuwLYeVk2U0crzcotqLF7rh2Fu//4nJSwLA2M/fdrYuiM4qEDJlOoefh8JF7yzn
 XtNeHkRbFNpzbav0+yO0YJaZcvWqhlO38PygEOGYZx2PqrEf1nCTf0H1GcUW12Q5d2k3VtsuIWJ
 nmljWyL2JcplY+E4L/eTEtrhLk28n0o4NXRxjJBaGpjmBBOr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the type of the buffer elements to u16 since we currently only
support 16-bit word size. The code was originally written to also allow
for 32-bit word size when oversampling is enabled, but so far,
oversampling is only implemented when using SPI offload and therefore
doesn't use this buffer.

AD4695_MAX_CHANNEL_SIZE macro is dropped since it no longer adds any
value.

AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
previously we were overallocating. AD4695_MAX_CHANNELS is the number of
of voltage channels and + 1 is for the temperature channel.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 68c6625db0d75f4cade7cb029e94191118dbcaa0..0c633d43e480d5404074e9fa35f1d330b448f0a2 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -106,8 +106,6 @@
 
 /* Max number of voltage input channels. */
 #define AD4695_MAX_CHANNELS		16
-/* Max size of 1 raw sample in bytes. */
-#define AD4695_MAX_CHANNEL_SIZE		2
 
 enum ad4695_in_pair {
 	AD4695_IN_PAIR_REFGND,
@@ -162,8 +160,8 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
-		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
+		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;
@@ -660,9 +658,8 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
 	iio_for_each_active_channel(indio_dev, bit) {
 		xfer = &st->buf_read_xfer[num_xfer];
 		xfer->bits_per_word = 16;
-		xfer->rx_buf = &st->buf[rx_buf_offset];
+		xfer->rx_buf = &st->buf[rx_buf_offset++];
 		xfer->len = 2;
-		rx_buf_offset += xfer->len;
 
 		if (bit == temp_chan_bit) {
 			temp_en = 1;

-- 
2.43.0


