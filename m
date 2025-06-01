Return-Path: <linux-iio+bounces-20099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B087EAC9F81
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B01E171723
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5A1F130E;
	Sun,  1 Jun 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbyc9/16"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB81DE8A6;
	Sun,  1 Jun 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798514; cv=none; b=DDflt3Atzpy6fq6achPMcAaRTeUvJsQAGtIdJU9/QPYAFk/pINNpDEq5J9RCLNxO06eEYfLJ9p2WY9GwjurQt0GaWKQsz8ajv2KLX7vZ3Ea79saOmj8+Glt4WtKHiJfaaAM2sNALl1C1znyI3gTm5gcjW397lwL4RqH4L/kDcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798514; c=relaxed/simple;
	bh=PlgOYthuh6JtMI4CL9QQOMMKFCb6fUJ+OzltwhdNM0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw092BIZ8Yt7MJHPyt6uQ8PSb/QbtbOsJvlqEGAX+OfXoC5rNkaefh0J+TkwHaQ5ye8J2XG5b6XG99H9mzc8F4X8KBtTPr8Xy3gwzKSwWEwSCDYiupN1T+eNrpqyhiWdjhb6JMch+wnJSi85nQi7JEZk5Ks1y3sGef7f3aV8Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbyc9/16; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4ebfaa623so514629f8f.1;
        Sun, 01 Jun 2025 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798511; x=1749403311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsJz4ZlJcyUxy6ajB/i4TEWppNdFHS1iZ8mtjoDs8Js=;
        b=gbyc9/16aqe0f4u5wSe8xX5/h2Bl+jznJ4lN8h21wY+Tl6OvqGSDF7IT5TV2J3kh7z
         Z8N91V6sMxFibsQ6irC67xSX3cwloaKgSicvkzZKoqQDYYeW7Hm7I5Avo21mEK3f5Rmi
         TqoYCcUuYJ2eiWRJuzmynG1a64lIUJGC+NwjHsSco2PV7eGXKwMx+Et+MXIP5Ln6tLI0
         Ez1Who64xyu4rKxIuWi4G9aTDm0niIYWN85Sg7xw0SGaJA3CG8JNLvBNteUZMiO0vFQG
         PFRGjnK0oljWBsHvGC/kS04nQMxqMkmXhgZV0tOSFiAf/iyO7VWxHnE9/nNGoiQr5Mby
         qvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798511; x=1749403311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsJz4ZlJcyUxy6ajB/i4TEWppNdFHS1iZ8mtjoDs8Js=;
        b=Lzl+FxoMKWLQCjAntw2dhTRhIBWsM9ecDCpipVb5L1assLQSWPImxB7F/ItooGvlAi
         m89wllbhSlkTpFXdSg0RdTkQQJaze5I0ZiGLOhBJ6A4evKmyotR+hdrGisyOa7ZW7BAg
         MgrCyNOjKQaYS7sRl351x5xkn9olWDxyzUqti6QVS4SvQA3YD/Eyv/H0EjZbmfxCqRnO
         V+KWbu5d6Y8/MqkO9dIdSsLiBrEu5Sr9EJKjUhDDWGG2hvjbJ93/OsJHFQ9y3gDoDF8G
         SKlCDQtKIZp1wQuq1W4m5IK4UZyPtWd9rL97XbZi3f4Z5A2eMQUyOLbOroAC44hPk9l5
         EfZA==
X-Forwarded-Encrypted: i=1; AJvYcCVeeXHzf+IzUEcWDjCoZdp+GAaKPLBS41Q6fYCo0PXrD68G+Kmtkpz5beSDlnVW5T/w3Vz4OPxfsPrHxiKY@vger.kernel.org, AJvYcCW6kGFW6uCTU5vDOJlMwLoUiyFAqy/3VvTCQUtRl4fP+XLl7WA6BQUxUNgkAfSdFddHyQQ7MkSNNWc=@vger.kernel.org, AJvYcCXzlqEp5BTl1GzTlG1gphIE4HucnRx/Ft4mXORiQWSGc49eFUi4gE79qSzdbnhUvLeckE9JT5DEWStG@vger.kernel.org
X-Gm-Message-State: AOJu0YwQECc8g9LzPjS+08YU7PBOTxhulfv0JyhiYV2uRr9JIrexOeCn
	qerw3GC6mC0Ve0DdNxMMM1Pr9tUily+u/adFsmuNWr8+YUzWaifpfiPp
X-Gm-Gg: ASbGncuCIfen8JuVUEuUYE+36qH4DftUQvfCGGZZD7WLaB1rB7PXDX6XpxSSVa18dkG
	AnWNKEB14BOdc2vwAtq/GgMj5Oucc0WXZz8mX5CBFLX4aziwlEwLbH002npuWKItoWkNQzRv2up
	3soXfYjuA27FMvtzAGHNU7iK+CAx09usx8ShafclEuORxITj4iSqY/eGIXb2ASrk7gofKNC80By
	JEl+lfy1RpNKE6746aWQdbikK1N0qAS8gPPoW/FobCPS8g1uGgzPRqUljvzRfKr4ev9Svc3y8VF
	SuhpApTbLymN3a7DTVQADn+IiB4d/qp0koAJASyzLy8/85Akn1jHaTtX1T4CW9OKFhwZBqCSp6w
	xmlijIgl1RM+lRuxcE9INEWeLDxXG7VET
X-Google-Smtp-Source: AGHT+IF1AvTaJe1O9b5lihFPu2eJzBrgV1pPhUgQpxpSoVRp6SPW6aynJPcd+nIGXHmN9iYnl12l2A==
X-Received: by 2002:a05:600c:4fc9:b0:450:d5ed:3c20 with SMTP id 5b1f17b1804b1-450d7bb5709mr29013875e9.6.1748798510834;
        Sun, 01 Jun 2025 10:21:50 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] iio: accel: adxl313: introduce channel buffer
Date: Sun,  1 Jun 2025 17:21:30 +0000
Message-Id: <20250601172139.59156-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scan_mask and scan_index to the iio channel. The scan_index
prepares the buffer usage. According to the datasheet, the ADXL313
uses 13 bit in full resolution. Add signedness, storage bits and
endianness.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2f26da5857d4..06a771bb4726 100644
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
@@ -183,14 +184,26 @@ static const int adxl313_odr_freqs[][2] = {
 	.info_mask_shared_by_type_available =				\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 	.scan_type = {							\
+		.sign = 's',						\
 		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
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
@@ -419,6 +432,7 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl313_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
 	if (ret) {
-- 
2.39.5


