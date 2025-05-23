Return-Path: <linux-iio+bounces-19838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663BAC2BC7
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C25C9E3919
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010E215779;
	Fri, 23 May 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0lBilSf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8321420B;
	Fri, 23 May 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039757; cv=none; b=VYBqvJ1RwSBinUz3Z2Da1BGMSnpwguLs/FwL+RXVTsF4fTZAatG2nzIDeLCctyVM0qquz5sAoZzOaDMRb2JytWlid4uyZnZd8Dy2HcA59+VEsKi8N+ZBn8dfL8Mxb1tv/kLquyfGOjtGDW41uTA+FybJV4XmDIRm+lS4Zh15qQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039757; c=relaxed/simple;
	bh=4VcxMc2O+7O6Wyrf7uyGzg6cQv5sJpNtCm62qAyK1Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfCKbZj7qX9b2/p9neBAh+E79oJdvPXRBuQpiHAPC9kKHnEfqsQfDKtyCfnEfFWURlA/ONPhPgacRRbq7JBvA/XC2lWVegNFpNAgghkpYtXMUNG0qAq//QXEMMuQn/z1zF/kS4NFc+OG4zT007Ainel1kXfgt2m+62obBIWSN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0lBilSf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442e9c7cf0eso44755e9.2;
        Fri, 23 May 2025 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039754; x=1748644554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIP0vkmItWQF91gizrE7KsbrwzYmte6B1xKBxPYNS5c=;
        b=c0lBilSfttD5ZWVAglu/fFUhZbGLMDw+f3z9zy5qGTAbKvUwZw1e0YKmqMoFz59pRX
         8C480OeiPuGeIpQ3MaC1TIp6okXj+mdb19v6an1DD5u7F4rAk0+GQC96sqDBuUXt0nKO
         Tbf07oRbvBb4rKtlPXLk7LJbgo70bLE19YR3wWurBv/QfQrhUTJbFJiqGtAz3K1r5JUm
         8zg+bf5PzlMmcWw5zRq3KGML81x/9sDazftNaVa1p1AxTNRGGCxPC+z+/Am7v7Y1/AKl
         op5NfX08/xk/fGRUmF9OW5nwt0iqdGte2U133A/OKKojNZPZ5KvajmXQK0zyHQ+LPHJe
         v4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039754; x=1748644554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIP0vkmItWQF91gizrE7KsbrwzYmte6B1xKBxPYNS5c=;
        b=EBpvzYdSDOPMsqbUPQ+dBJ+bvDDvUDnKKdLwOp+ssJcF3fSKGksMzg7BTLFQ/cEqV+
         a1bpnWWWvt7GueYVsE+OF8F/w+GRRqP/IZKz8L4JN1jYHlzzTLAXiG4s4Pyjuz8EJNEJ
         1HX9gtfC2/sXxwhT91L674ya4khTW301lra2rJRVUMvHJKCxaTnWFsylfjfSYe9h15aN
         r/d/7fks9t0PMDIu2PSQYm/L2A7jOUt4JWDJvvatz25E1mf5PH6J3PLyWFTe9So0X8i6
         biB2iRx8Gedwa09ilQ/EAX/ztNiHqfkc2/w2Q/lNn2cYY87GQCbkirI1uQUli0LV/Tye
         uxeA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Vzag19m21raegFogXTuLV8mup/4HC5ecXDE9TOVcJ8RbwLH9ELCujqjQjQMUYYTuENKmoee65Ls=@vger.kernel.org, AJvYcCXAbm7Tq/opkSzTCT86VDYOdpPCSZ5SGDuDcwrU45lK+mGInYTS2zamOljnVyYGjAuH3d1JeMUBTt5fBOyv@vger.kernel.org, AJvYcCXBOuXvHqZg4ORo0nDCnTWSK/JfTllC1KFXe3eLKQFV9RlaZLp1+Cz0bI0amZBwLYs4pGgC6uvENH1o@vger.kernel.org
X-Gm-Message-State: AOJu0YxDM926OB8rgK6JOMcbsgQMrpLBFdNhDknpB7QcBclWrSgbqo/5
	noAH4lRQNTJQR7PiDGAYh9hdzGILO1aqv3DfDzj0FbNz28hCzmqrL226
X-Gm-Gg: ASbGncsHlrCauAupQz9E7a0RSQcRPsjnL3LOVA2ixGfppWQpU6JKk1mRiRWH00wYm57
	jkkI786nod/cZvAiaJUOWAzPCHtApDK/JbcezXtMl06dudyGxpkQodaKDP5xtygZ0h737SCOzfm
	Drko4/2KD5pQ8xh8nSgn8/p4UrHFKmNVGnTevz5WnUhU0TIS6XOhk6lYd3XmGnQUh62OJGx7mQ9
	8ltciV6rb2MFK4Qiv3MBKxzJ3CzGyKH9xE4IqUTi6ruE1kRCIiLRzDnGycDKsyw8g2FTKEe0uUs
	pOqIQ3q960JCDc1GEe4F8I6JbzYVzjrpEyXPJqrXABZ46KiTOHNhymQls1mhsF+RSdcwHluT6UZ
	8tJPL5zVYAWkPf/MbW3QhHAxE9k6kLGB9
X-Google-Smtp-Source: AGHT+IEOf+eV9gNYu2hTpc3KcmfGuuY9KHbjyiQ187Pe3SErczqXH+oWWiTnLh9dLU/JcXYoXSImRQ==
X-Received: by 2002:a05:600c:4752:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-44c93caeb6amr2171745e9.9.1748039753679;
        Fri, 23 May 2025 15:35:53 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:53 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/12] iio: accel: adxl313: introduce channel scan_index
Date: Fri, 23 May 2025 22:35:13 +0000
Message-Id: <20250523223523.35218-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scan_mask and scan_index to the iio channel. The scan_index
prepares the buffer usage.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2f26da5857d4..9c2f3af1d19f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -171,9 +171,10 @@ static const int adxl313_odr_freqs[][2] = {
 	[9] = { 3200, 0 },
 };
 
-#define ADXL313_ACCEL_CHANNEL(index, axis) {				\
+#define ADXL313_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
-	.address = index,						\
+	.scan_index = (index),						\
+	.address = (reg),						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
@@ -187,10 +188,19 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+enum adxl313_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl313_channels[] = {
-	ADXL313_ACCEL_CHANNEL(0, X),
-	ADXL313_ACCEL_CHANNEL(1, Y),
-	ADXL313_ACCEL_CHANNEL(2, Z),
+	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
+	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
+	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+};
+
+static const unsigned long adxl313_scan_masks[] = {
+	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
+	0
 };
 
 static int adxl313_set_odr(struct adxl313_data *data,
@@ -419,6 +429,7 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
-- 
2.39.5


