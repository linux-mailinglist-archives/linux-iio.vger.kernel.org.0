Return-Path: <linux-iio+bounces-4862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96A8BEC28
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CAE1F258EE
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011216D9C2;
	Tue,  7 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1qfWtfeW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3216D9B5
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108541; cv=none; b=LclM6GBD2I3NJb4iHu+AhszUmACeF4Uh/I9gP3JcDwvSU4D+l9n1dutODpACV3LZi2wixxkuqWTcbc91jmMfROqvhdaADXTp4yy2uagYD+kylqkh0nTFCa7Fl2tQnYhkiNxvfD2pAcnEY+u5XFnytnGM5BmLpc29rI1EEzgGcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108541; c=relaxed/simple;
	bh=lPUQfi00hz3EZzfmxjqGDaeJ2LGzL0z8Fh1NDCHiCqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT/WlILyT+QGJGnJhKFuKKphTB056KdVNlgg9fQhV76bGCwZdWsXbE74GsEMtXMXbDsLeECsxdQYmSpBcBs/jOtaUt05INjyqGy60eOSqDwTkGt65JX1B3M4BG2mIHPgk6Ei1wfbUdv8HeSkA+utMjcxdAG6hbdYxXi9lkkf7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1qfWtfeW; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c968f64cdeso884561b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715108539; x=1715713339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gusPUkvJw+HUxHjWbJgthYj3tkXrP9EigZmtbqwV49I=;
        b=1qfWtfeWufUUgUDqjw6SEulZOWdeKJ+rTduwhcuw7lLk50AKcN9IhNYkXgiXpIcogS
         Umxm3QY+i8+eVvYL5NhBoIJF/Xr4FZ2fqFX2w9NbXFDYdCl1CvnTZwtWk8svzZYN/yDu
         ucFLajGzaHMl/IXl55S88WOTzNydkfounRXn7sweAW10DAxhbVwgTcMCfErfoxZ1BNCP
         c5B7kPZ/QWpRXD75W9hEzNYi5s10IhBRgDxkh1lFRxf6TW5DMzAWoz05mr56s94b6VvA
         /XeaOcTt0dfcYnG8E4vmic30+K6/zKSI9Hhj6motWbA8l8VBummhEkbPERjqAAiAheMq
         TLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108539; x=1715713339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gusPUkvJw+HUxHjWbJgthYj3tkXrP9EigZmtbqwV49I=;
        b=pOlAwQGI8aPniZiY6kkqTW6e/SD62t8YK0clHU0Qx4XTljl7E+udrF0WTMQBaFxZaZ
         PIpTnn1h5RyNyzNkEvCKhi4EVbwk30IA/2OjbfNYbp6H0CB4kDCMHesj4NfDb4ZXhbPS
         BHfqBNZ5PA3JYkWrzbQxdAJbYDflqXIs8cEj+K7tqCS6Q93yHnSFixCS4mhrmNY0KxaY
         OsinqIXNI6WAtCXYBUEFy2mI3sApfTE4rRE5nPmQtQXP/wuMPOJsNfogXTlGTKdj4ycK
         VPL2kzel3G2bkQ1EfToNmJP88Xi8FyFtYq42KSd5ZAPpGy/ZcXs8gjVQgeul0o7KEng4
         xvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhtfRamQoeych8p81cLs1Sg1f8sAlNLK+ym9rgbdDZJ6hlmqBHmIq8zTRczJ0BN56cJEb7xbP1YajD6oI0yTvhaH1M2n5ko3L
X-Gm-Message-State: AOJu0Yz1GBIg1mpuHp0yQJzjcYeJFsBzF83LbL8qpoIkfuFOxovEHIWu
	RKOQ7+TL8jh9PNKZgs1WJc/viwTDKzocLzG7HZPCMRiR3KXYdQGHTRy5OxtGaxs=
X-Google-Smtp-Source: AGHT+IFHtu+tsKrhcPKjEbahD4o9LGQo0jYOer1kDmQ9GUynkWoVDP2V0354NOUJT5/NuXaQabwhyw==
X-Received: by 2002:a05:6808:202:b0:3c9:7013:85c3 with SMTP id 5614622812f47-3c9852aac11mr598484b6e.9.1715108538793;
        Tue, 07 May 2024 12:02:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id j14-20020a54480e000000b003c96bbe0e79sm909652oij.13.2024.05.07.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:02:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/4] iio: buffer: use struct iio_scan_type to simplify code
Date: Tue,  7 May 2024 14:02:06 -0500
Message-ID: <20240507-iio-add-support-for-multiple-scan-types-v1-2-95ac33ee51e9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

By using struct iio_scan_type, we can simplify the code by removing
lots of duplicate pointer deferences. This make the code a bit easier to
read.

This also prepares for a future where channels may have more than one
scan_type.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cec58a604d73..08103a9e77f7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -366,7 +366,8 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 type = this_attr->c->scan_type.endianness;
+	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
 #ifdef __LITTLE_ENDIAN
@@ -375,21 +376,21 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		type = IIO_BE;
 #endif
 	}
-	if (this_attr->c->scan_type.repeat > 1)
+	if (scan_type->repeat > 1)
 		return sysfs_emit(buf, "%s:%c%d/%dX%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.repeat,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->repeat,
+		       scan_type->shift);
 	else
 		return sysfs_emit(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->shift);
 }
 
 static ssize_t iio_scan_el_show(struct device *dev,
@@ -694,12 +695,16 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 					     unsigned int scan_index)
 {
 	const struct iio_chan_spec *ch;
+	const struct iio_scan_type *scan_type;
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	bytes = ch->scan_type.storagebits / 8;
-	if (ch->scan_type.repeat > 1)
-		bytes *= ch->scan_type.repeat;
+	scan_type = &ch->scan_type;
+	bytes = scan_type->storagebits / 8;
+
+	if (scan_type->repeat > 1)
+		bytes *= scan_type->repeat;
+
 	return bytes;
 }
 
@@ -1616,18 +1621,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < indio_dev->num_channels; i++) {
+			const struct iio_scan_type *scan_type;
+
 			if (channels[i].scan_index < 0)
 				continue;
 
+			scan_type = &channels[i].scan_type;
+
 			/* Verify that sample bits fit into storage */
-			if (channels[i].scan_type.storagebits <
-			    channels[i].scan_type.realbits +
-			    channels[i].scan_type.shift) {
+			if (scan_type->storagebits <
+			    scan_type->realbits + scan_type->shift) {
 				dev_err(&indio_dev->dev,
 					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, channels[i].scan_type.storagebits,
-					channels[i].scan_type.realbits,
-					channels[i].scan_type.shift);
+					i, scan_type->storagebits,
+					scan_type->realbits,
+					scan_type->shift);
 				ret = -EINVAL;
 				goto error_cleanup_dynamic;
 			}

-- 
2.43.2


