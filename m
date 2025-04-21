Return-Path: <linux-iio+bounces-18472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F3A958F5
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6671896BDA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00E221FB0;
	Mon, 21 Apr 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZiNeOj1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8D2206B5;
	Mon, 21 Apr 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273222; cv=none; b=ZGla7C7RUzR6a0QESYGH2ji2H0z+UgPQaFiqY0suN/9CYUg/MJ4n6a1cBolEQPWexWg0R3YmdUlVfh9Ghl8IyACIX0SYdn4r58bx9CKxY5dYzdv334Eeb89Y3IeB52X9uYXrCUCTP6sIsW2xQL9x2Y/YjPzwKC3WJa4T1uBJGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273222; c=relaxed/simple;
	bh=rbaYOkUTWpyowR7jBDQPIChL648feaPDsQw7fIdQNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KW3NR/6furRScYHZ485bfgOjTdOnG7lv6wvhW1F2QXHwvSA11AcGvcxZwz1p6dctqPpQW0RrkWQgISJyEynpWmhYqFwLADAjGuBBpMLZz5QSf4bE4Nqy3+q+Td0FQLGfbKCxSxQMxHDqyfwmwKKJo/IW+Z90VOZcs5okTlklH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZiNeOj1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb94bf7897so16152966b.3;
        Mon, 21 Apr 2025 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273219; x=1745878019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IPG/e3mCWKEPm+RsqHpGKWjD98/6RuMtaJowuJZ564=;
        b=fZiNeOj1TqVYJ5dBNXlrRDYpbWc4L7kZG/QFfwNFqUrZDL+NlYR7BSJPbkAOVP+TOw
         Alz7/HZlU27sAcgy+IXye6SHvaPQRzDpDInW1r4F4Ad6eDX7shUzK1dpbAbWJD9AyZvC
         oECdhKGT22NilZ7imktFS3XV0Ltt+RAtqV1/8SVK066lLoMk6+HYyKDbm6EYnkZ4JONf
         /33rNFAIEkCG3AfvzC3bA+JoO9VEbY88T8wslCoBL0aE19ZCK/5evt30zuJLowYHetxI
         VdulibRv5ugjFqY0TbBiJ64olwTTheoubIkSY9MY63u4H2FdshT5oqKyIeYJfLIzm7Iq
         TakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273219; x=1745878019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IPG/e3mCWKEPm+RsqHpGKWjD98/6RuMtaJowuJZ564=;
        b=J7LUsgBSuoJQiJUcdUFRIsIicnWRyjTaTj0WIX9cYrzvhwOQNkrZqosamI6ZEFT124
         vekwt4vfNMNVPEdq9PZ0giKOIR8oizGbE+85C4wYgCsesDkLv7cSJzfMtxFZzyIYvUEV
         DgAZ+ZcS20VEswTO3EkT2mVnMq8Pk2GTVhXRb09qh7KB9gSZzg2j4qTGU+fGzmzI1Com
         yCAjargzVR+/8oafHHiYvBIG9UkM+mNDt1jueWX+3JePTUatZGPJlUmjahbVOSHMm51/
         kUhUdYiyMNd29VhPokwKSJePDNWi5kq8K4/vxE70d8iGPGx4P2claxbL9MPYFaDGgzyi
         WBWg==
X-Forwarded-Encrypted: i=1; AJvYcCWLzxclXALyqDUPRNMjLrEeRXRxWzZRWSfecIIOS0/+rQuwe7MFsjpPFGXGqIKzzou7KR9vUE5lrs7I9Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1WobH4GU2l11VyOwS8bMcVB79WVwkFoIoAKTu6JIi0ZeamI+
	ygqTogoVph6xYinJ7kl0ES4aULElmoNJYQy2c+MJQHpKr0SmXp0/
X-Gm-Gg: ASbGncvuKPdmdsu0b5SPBc/xU9On5Xfkdu56F1Uiyv1lIJAh0tGE0VQZC5N7X3SPP/j
	tQywhIUutYhqcCv/X/3VlYbnrM7ZQy1o0KXb9Nku6FtRv75hrmKzsLkMwuTu4gPuwiuAXu1ld2i
	ZWWYYU+um/pWxYAwtmW1N+jshJNnH4uC8/x4sqBDIClQBgToBuNeyRMSZ3tQXuU7jeNA8fb4MMe
	xq41ZeF52Vd8TxSlAg45cuRLK/edNIkcCAV8wwaX4OYjAOEY3h1zO35N+rPngEd22GWa+vp4y0y
	MQmmncUb+ySkHZwc/aLHsIF0cpw9rD9G2Evp2CwBMks1/TYmYPoxoUTVmU75HRplj9cH6GtegZr
	CybbB3lmjlF6i3uGd3GU=
X-Google-Smtp-Source: AGHT+IHLX5K7GK3CQD1L0U97V4n9HNL9+lA0XCwdtDzi0mU5FjZ+DRj1B8DJxjGj6g+ijXLHEnyfCQ==
X-Received: by 2002:a17:907:7d8a:b0:acb:1e98:1a19 with SMTP id a640c23a62f3a-acb74b80bafmr328664366b.8.1745273218988;
        Mon, 21 Apr 2025 15:06:58 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:06:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 04/11] iio: accel: adxl345: set the tap suppress bit permanently
Date: Mon, 21 Apr 2025 22:06:34 +0000
Message-Id: <20250421220641.105567-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the suppress bit feature to the double tap detection, whenever
double tap is enabled. This impedes the suppress bit dangling in any
state, and thus varying in sensitivity for double tap detection.

Any tap event is defined by a rising signal edge above threshold, i.e.
duration time starts counting; and the falling edge under threshold
within duration time, i.e. then the tap event is issued. This means
duration is used individually for each tap event.

For double tap detection after a single tap, a latency time needs to be
specified. Usually tap events, i.e. spikes above and returning below
threshold will be ignored within latency. After latency, the window
time starts counting for a second tap detection which has to happen
within a duration time.

If the suppress bit is not set, spikes within latency time are ignored.
Setting the suppress bit will invalidate the double tap function. The
sensor will thus be able to save the window time for double tap
detection, and follow a more strict definition of what signal qualifies
for a double tap.

In a summary having the suppress bit set, fewer signal spikes will be
considered as double taps. This is an optional add on to double tap,
thus a separate patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a95f1c218c0c..c464c87033fb 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,8 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
@@ -295,6 +297,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 
 static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 {
+	int ret;
+
+	/*
+	 * Generally suppress detection of spikes during the latency period as
+	 * double taps here, this is fully optional for double tap detection
+	 */
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS_MSK,
+				 en ? ADXL345_REG_TAP_SUPPRESS : 0x00);
+	if (ret)
+		return ret;
+
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
-- 
2.39.5


