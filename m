Return-Path: <linux-iio+bounces-9703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C428297E26F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916C92812EB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C529CF4;
	Sun, 22 Sep 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX8qG2Ws"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11DC144;
	Sun, 22 Sep 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022053; cv=none; b=ZEzbh9Xlz64ZLs/zBl2xczd+qBLaVMCv83dQArpCkBbKNokxbYJaFV5y8XYjx9fCwRZTCDxi18BJpofDKuBacMOpm9zatA4cFqYJ6N5HJ5cEcfM8atxdgUg/JfryBRg2+X4OSjLMlpt2MmchBJOYPMW/+qceL22phHGZ7kT+rM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022053; c=relaxed/simple;
	bh=vrveqZfuTz57L2nl6+BZmp7ge4w+VOnltzso6kZxxBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hB82/0f7sZDYmaKTQRGRTnqEQPHSi3B/yBLHIoVqtkcvvPF9VDGG2texQbQlejzOX6zNemDyGKqU9ejNSFysGHslswsZjEC4zW8i5Y8sspCQjAvwxr/WPrGmjnA0cXQGxqfZt7U2QBnCwo3znYBH4O+3P4hsmwb0ac7oVCOkRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX8qG2Ws; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso31495595e9.2;
        Sun, 22 Sep 2024 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727022050; x=1727626850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCkByDilZNiIhlYPmGDLamQmUM4ZAy2w1yl7UZcIe5M=;
        b=XX8qG2WseDvQI1CIvCtJKmVDykR4bB7JI4LEAYObjxERZbkedib6flWcoUb1HSL5TF
         nxnpG2HgphnSW2t9fStxtbzMRxnhmC3XhziQNA/QhAje4giABVK3+Dv30o6J8py0xhCD
         CXNqfoBs57PoQcBBaqNU/sYLNhVkimd2QSIxZTIGGrTYPonSgxHQ9L2/e6WVDln7at/C
         5/R+1MJO2I96sxxmRhPqeCCbaev8zCEbu7bbMUlfvYbkjgRXTnjL5tyqWW9OGVyXmQ2T
         hlSRdQ6pdRa7nS9L0DOXIHpy+9Xu6ptH4VWWBGqI0vUhWkr7bULAQJp6KjulxajQihkU
         nasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022050; x=1727626850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCkByDilZNiIhlYPmGDLamQmUM4ZAy2w1yl7UZcIe5M=;
        b=tj5IL++29sm1NHJrvhY460UlVLxGvEApNKrVppCeJb//LE40pQVnboQrUShD2Ajc0e
         Lg8vYu1eSDdIU9XLzUgBuvwD/D+CsKQmb3QOWyZpvP9pc31nrRZX2Wc7iLfV/VDL7VhA
         SrmbshDMmTWmEMKlhD70S4aQa8sf9pwevJkKDXfZbFsTGjxVKy0qVlYFbmRTcd8O+fRY
         1RgMlMFiv+NPr3k/ULKMJ0+vmTfsGm8OfISJqEXxMtxV8YGaO2hRTqZqi4MzLlhBb8H+
         oOPYUX7qpBdmCFQ3hwdxl73F9Hurrh0cRFddnoCvLQQciU+ilK1KVVXQNxV2KVKQcrKR
         GamQ==
X-Forwarded-Encrypted: i=1; AJvYcCVks6bR/A8hzar8D9bJ31NFnjoW+d2Zb/OUVOJIUsErdzbAtDTXWXiJbnS1Wezs+x4wjUtcCQT1r3J2X1/Q@vger.kernel.org, AJvYcCXXwGn6XBe79PkHMXo165H3YwIIvgNYlWUqG12RBFGkeA+EepsL/NoHkltdpahFufPTrnVWFkx2n1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmea8d07imjomRjaY0gAA7tf/laZSqqL9PgI8BxrIUmjWFDHVX
	SFjYdgzKpE7KDtporDW0N9oIp3PPE8Q6Yl06SCRq8vO2KXcvn4Vl4PE0imcS
X-Google-Smtp-Source: AGHT+IG20xs2JfdZfgmY7E4uU0YkXXZ8V0fu96IQ+BfuVz1Df4AK9qym+lzVWGmxDtWlLrowPJM46Q==
X-Received: by 2002:a05:600c:3b17:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-42e7abe8495mr72409105e9.8.1727022049476;
        Sun, 22 Sep 2024 09:20:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:7367:3ea8:c47e:88f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c6dbcsm104566485e9.46.2024.09.22.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:20:49 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH RFC v1 1/2] iio: light: rpr0521: Use generic iio_pollfunc_store_time()
Date: Sun, 22 Sep 2024 18:20:40 +0200
Message-Id: <20240922162041.525896-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240922162041.525896-1-vassilisamir@gmail.com>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The custom rpr0521_trigger_consumer_store_time() is registered as trigger
handler in the devm_iio_triggered_buffer_setup() function. This function
is called from the calling of the iio_trigger_poll() used in the
sysfs/hrt triggers and it is not used anywhere else in this driver.

The irq handler of the driver is the rpr0521_drdy_irq_handler() which
saves the timestamp and then wakes the irq thread. The irq thread is
the rpr0521_drdy_irq_thread() function which checks if the irq came
from the sensor and wakes up the trigger threaded handler through
iio_trigger_poll_nested() or returns IRQ_NONE in case the irq didn't
come from this sensor.

This means that in the current driver, you can't reach the
rpr0521_trigger_consumer_store_time() when the device's irq is
triggered. This means that the extra check of iio_trigger_using_own()
is redundant since it will always be false so the general
iio_pollfunc_store_time() can be used.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/light/rpr0521.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 78c08e0bd077..56f5fbbf79ac 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -438,18 +438,6 @@ static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)
 	return IRQ_NONE;
 }
 
-static irqreturn_t rpr0521_trigger_consumer_store_time(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-
-	/* Other trigger polls store time here. */
-	if (!iio_trigger_using_own(indio_dev))
-		pf->timestamp = iio_get_time_ns(indio_dev);
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1016,7 +1004,7 @@ static int rpr0521_probe(struct i2c_client *client)
 		/* Trigger consumer setup */
 		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
 			indio_dev,
-			rpr0521_trigger_consumer_store_time,
+			iio_pollfunc_store_time,
 			rpr0521_trigger_consumer_handler,
 			&rpr0521_buffer_setup_ops);
 		if (ret < 0) {
-- 
2.25.1


