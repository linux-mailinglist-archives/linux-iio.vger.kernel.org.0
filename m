Return-Path: <linux-iio+bounces-12355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502349D0519
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6463B21F9A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F21DDC20;
	Sun, 17 Nov 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyRo0AM5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467E1DDA33;
	Sun, 17 Nov 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868112; cv=none; b=QeyDj4wb7WWL+ipJCSxv3ynPRlGwNZDFya3tIX+acsytEnDkYHFdF6cULv3q8wJ7VTeCdsxI+AG+FuBcTUOLEZK1BWZvEPBN+S8Lk0Jnyj3lHc463J0YNZ+ChYQSy2snt7MjBERrLBW9zqoG+7IRiisUDAhjAQJY8LC+wUqQjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868112; c=relaxed/simple;
	bh=qWbaygyMbxxCxY2EM69SwvmmEH+qTWZUyJMBN5sPzCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UeP0NurnZsqY0Wlkc5YIPb6gKUuDNrpJI5uq8EEti6AF1WFeSMkaoKMbK9MYVfLbdJWvfDJRt0Ayb9Z9yZwFPjqwLuRISjHMlUrOS8wNScLCV80wDs3BlJsu7sbqN7mKFQ9KqOZT/eGwbg0lJgefC2gNQWdxjwZO/ptmxqSVBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyRo0AM5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso2241205e9.0;
        Sun, 17 Nov 2024 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868109; x=1732472909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08++XPHng6VQRbZngz7EYFo0cAPTzd2hP395fTftmHY=;
        b=DyRo0AM55AP5VcCYyKcaw2YjYNirwZmiG7skyHMnJCWYdQAaUi6G0q0I0RNLW7isxp
         LaI4WCWUS1jyzjHjcBU9ZZOCWDVfK9JnuovphNFFDe63o/MvWnZT0jYwuvt8CIHeB0fY
         DG5DXqzxbiTFFVQCww0Je1hgyFTC2INaJ5VfCekPLPRidUhvMO1hc8Il+BeJJpf2onZ2
         3RkGc8kC9BGBdtlXkSf1DZIqmOKlv6tn1BYngcUSp6XK+E3ECYj1fHxf/iETB5VnDnXQ
         DQYGTmNhqAhGMQc/x290OC38q+g5qHpNhbk921G7lwzWg9/IcXCbiKiPb+zzVapDWNmz
         EnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868109; x=1732472909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08++XPHng6VQRbZngz7EYFo0cAPTzd2hP395fTftmHY=;
        b=qHYPabpNLb2z4UosiT79oaqrL8FBarerRuCMGgK9UAoumoHEa0TryQlVRnpx919YZm
         0rHzm68sdD5wLKDJaSgvGWMGykuDJHiobc83WJqFLHHODBRfFRphxesw238kxc/kt97q
         S5ldy1HJwUMkD+7I6BiTTQq73Dgk+xUGkhcU1l6sYDqH2YdtiZro+yuRnnjzpERomLJT
         UXHDyOUklV5gQVIwy6zhaBUPlmCOltWMB9QsK7Itgj1TUXNSO1PeOxgo4QHHXo5VmxeE
         tGZHfj1btnYeBjGmMA/YUnXVlwSli1JkWtzmsvQMOqZoEeGW5rXD7BwbG5WAKbtAvj9r
         0Lwg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFEB1KYubKycJrM686YFP42tMM1AUSS6qNsHkqELtyJa+xBL8w2PXZVTyRHkUyzV7pvSYkezg7gGC5qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+c2D3K8hVpN9ZzyrfVAe6Ky5ij2iqh3l3j4REzBUXeOY8SaDL
	VAHiI6zef2q51e6+d9nZ/PqA1j8J8ntIu2RZgMniQdAXntyw4O/K2PXPizUp
X-Google-Smtp-Source: AGHT+IGazw5wStaxXiQcVpMZFABDQof4/ko5McqQJJ/8TPLUhiF9sqpbHZqtAlKdg42KHFV1q6Yx5A==
X-Received: by 2002:a05:600c:4f02:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-432df71d75fmr34800285e9.1.1731868108464;
        Sun, 17 Nov 2024 10:28:28 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:28 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 12/22] iio: accel: adxl345: elaborate iio channel definition
Date: Sun, 17 Nov 2024 18:26:41 +0000
Message-Id: <20241117182651.115056-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the channel definition ready to allow for feature implementation
for this accelerometer sensor.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b16887ec1c..f98ddef4c5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -141,21 +141,33 @@ struct adxl34x_state {
 	u8 intio;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
-	.type = IIO_ACCEL,						\
-	.modified = 1,							\
-	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+#define ADXL34x_CHANNEL(index, reg, axis) {				\
+		.type = IIO_ACCEL,					\
+			.address = (reg),				\
+			.modified = 1,					\
+			.channel2 = IIO_MOD_##axis,			\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+			.scan_index = (index),				\
+			.scan_type = {					\
+				.sign = 's',				\
+				.realbits = 13,				\
+				.storagebits = 16,			\
+				.shift = 0,				\
+				.endianness = IIO_LE,			\
+			},						\
 }
 
+enum adxl34x_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl34x_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL34x_CHANNEL(0, chan_x, X),
+	ADXL34x_CHANNEL(1, chan_y, Y),
+	ADXL34x_CHANNEL(2, chan_z, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
-- 
2.39.5


