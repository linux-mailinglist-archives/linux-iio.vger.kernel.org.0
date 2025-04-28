Return-Path: <linux-iio+bounces-18790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB5A9FA73
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01F01A867E3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023A1EB194;
	Mon, 28 Apr 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aHafrKJ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715131D5170
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871851; cv=none; b=LoONq6aKQ96QaX91HGlLsOMoHadMPtta0O7gLvekaYGG6iYO0xXqeWSoxK1td90QPPVhC15szQwJrx5dPp38g+XyNpZlG3pWrVIHAJ7jBxP6puBINrVf0cqdved/dv8EyRIsPuDA5rYwEQYd/1cHSBHLzk6o+1BrafOKnrVSGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871851; c=relaxed/simple;
	bh=J4aWhg+jCqZDPjq8gAC6cdfS6rEoLENhaBlAy0BO4RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEHWMEUFM5MrZ0LU8OvqCgh0EWSBsy2G0eizmOqjh2rIdpT85vNavHupBaJ5utyEEUi9QEFmzmtOT982tePhCZPgn8YmtqURj2CuNoWoLDr+fVC4J4I04JIlc+4Qj4SSj6nGoUVqAiSK4H4OL/LdiO/ZthWMQs5dps7kKR5Nttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aHafrKJ2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f94b7bd964so3921167b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871848; x=1746476648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTje6aj5o1aqilClKP/XjHDRm21nPtMuz4RymFa7ygU=;
        b=aHafrKJ2msvWdDzqwJqlL0v7SN+rGl00x+2zZBBAM5qOpttAEMaPUYgESgpfCev+dD
         XdlArxNUlifOwK/chA8034KA1gzAODCJYD29vYvdCUUaJi4pMA5YBMR8x6/zo/nQAAr4
         yZYDKZP2+Eo9hU3u4OVHkRTqRfTrtMkq86gBQN5Cxvd/KSOkUtnQbILFL9webLhQ78ig
         x6r6/IpNpY62XKWg7uj9+blyuf87D2XpmWTkPBZ7GB4AAjguIFR/YeEl9hQUlDX6GJ42
         JA2H3Yb3RtOmbojyStsVJPwFKA/fk6C2kd0Qpo7166gmCxiAkzKRxLSLhtU9NjWHXqRh
         Ht0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871848; x=1746476648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTje6aj5o1aqilClKP/XjHDRm21nPtMuz4RymFa7ygU=;
        b=XBvP9yCBznjqBOqMBLXYWMpJsApvhm4ukpn/j3DzNBtQm77L+nUVTAAlbuHGIEcgTV
         ZXq8JeiYvG2MhLg+AmRU/B+99iA4QA29W6Ar1IMeuNwGaD/GXXusU2hTqkWsL7ObLzhU
         j3MLWMAJj5L0xPWntJfg0QRkYsVEl6OpdnrD3hz0R/EhYOUIIY/tAhI9HFp7aqkwnuv5
         olTdBvtVk+4EoXrA9FNw2uoxk81N0g5ToOmzH/bTCKSAFnqAiVayvvS9wHpc58kbKDkw
         TBl7tGIfcK1UhT6D7BQbt2WpO+/aTDuom7R4vcV8r+7dsFXh1L537oSxp49a0E5wMMjj
         70LQ==
X-Gm-Message-State: AOJu0YyRfv2Ndr278qrJjPxBywbs5ivXwe5hECdWWwr+JZTRMMauBs+H
	4z2alRfIQ67RBU+ycphcdpm+Fgvl8ccjJyMI7HKpWzFb74FAU14JPJSVO2G0KWE=
X-Gm-Gg: ASbGncudHazADzTXEZxW/2CwBm99uRwwLb8ts9tM7s8QqyfgnS7cAaECd1q1Kg/xM+0
	q9MxYVRCvNvbpNLl140WAPbGExxTfMlYqzdRhaiTrPJY88AupOs+BPMj+8r1udt9zjTyDjh9hbL
	yj3FojujVwDudKDL72VDq4kD033irnFdQXsVrMvP9oVSXQnMfYg1ia/amyfM8xmJ6eKFBVQ6Olk
	u8PRYwttz+IEgdx4zV/6AHMDvFBmYPCpc+1UfMNCqsadP0zK1JZkdPXCzXlo5Pf/ttL8cipdMye
	0TBYXa+hmZq865O0ps8AV/ICib6izH05tdSpHqys36MaRA0=
X-Google-Smtp-Source: AGHT+IH5KDMoXCV8pNi4SkosxNjndqHGUg5FZmoI1A1D85SMMHZZKyW1TrrYK1HTGGR4BOcicOe06A==
X-Received: by 2002:a05:6808:bc6:b0:3fb:eb1c:2a83 with SMTP id 5614622812f47-402107f1c7emr578970b6e.9.1745871848357;
        Mon, 28 Apr 2025 13:24:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:23:05 -0500
Subject: [PATCH v4 3/7] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-3-6f7f6126f1cb@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J4aWhg+jCqZDPjq8gAC6cdfS6rEoLENhaBlAy0BO4RQ=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDL4H+//d7X71mGbm6depN80VNtx05mPNSFz0yoVBo/3D
 68l3pPn62Q0ZmFg5GKQFVNkeSNxc14SX/O1OTcyZsAMYmUCmcLAxSkAE+ldz8HQPWHrlnNSMWl+
 eiGv3DoXzklSatqxPbFZQNbZ8eGzmL4pTzQEc3RjJa+l6cwqWDL996PJ4k2Lfs8sM7/xdJdmkrR
 U0UTbtg9nhcuqGR+szP9+z7ymUET43eU7yTyqbYdZp/OZSB049sYlpe4p53GZfak7bgjZzNjkye
 ykejZq9p5XSiLKFwIFEvUWvajebyLxoigkkzWTOcmLb3FeZYZ3a2aHcQrfF4ntL2at3lR46tf02
 yw6zExpnfeSxWuilTkT+Q9Fm5xgfqvUzGYV5/4s6ud8iy4JywintqBYZ86sHZqnIv57bti9tWGr
 fpG/YO+BiBN39GuW1FnsnM3p1thgUvAtTO29XvGe+1YhAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0c633d43e480d5404074e9fa35f1d330b448f0a2..992abf6c63b51dee222caf624e172455fb9b9900 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -160,8 +160,7 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
-		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


