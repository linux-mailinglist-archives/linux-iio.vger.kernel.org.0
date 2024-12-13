Return-Path: <linux-iio+bounces-13436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396639F17FB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB75B1670EA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67781EE00C;
	Fri, 13 Dec 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnWnPVKe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A71EBA07;
	Fri, 13 Dec 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124770; cv=none; b=KCZojISsW94RRsamIF8uu2OjqRQKR5xU/vpVW8mz7Y205LW7yjsz1GkqTUgY8Ihy1eaeKE/+5aIb3B/6YyYnWX0kIXD3AROHu8nrLRlpsd6/x0UKjqhkNgKz4giGUf/WetDkgftK5Qt2gsjB2G2BDJY3JRXbCfUomjRqqtmwk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124770; c=relaxed/simple;
	bh=s/2Sud8tbTn3DV/gVz7omCuTc6DCCbix5hAZkUvCcyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVSxaKfqVV8kwgwsTK5xSE5Qw0j2m574rwS96z084Av/jBQegesnPEs4Ab7ZixNyjFXs1RU/zdah1gDaQUpz56q9Jx9mon1xakUEUzfXpEptBw38ylcdfotir/UHGZyxprbatpGW2oo7Z4/56sd1s0f0qpoqfC7w2qYZAXFuFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnWnPVKe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e0d47720so179831f8f.0;
        Fri, 13 Dec 2024 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124766; x=1734729566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYq2MT/kLJ5VNDS2ggKYbL2pEgZu56efpig6dGEeYSQ=;
        b=cnWnPVKenN4x0F9G004Cl+8yfBqHmRHy0QBm8nD0/dIxDujYahbLPf8VU3MLy9ulfc
         dbTqE0xVX8vVwri9ygA2YbLy+tBlBhzDc+hG6uoXjqLwPF/wMPTA5rcmsu8gvCttizpn
         mMBrFBFr2U4OR+iBUyNf7rOGMF6ELrs+X8qAdcs3VMZF9iajuyuelhGJZjGHIw6gOx4W
         cwxz4pV5lhSc1YgBlYky8h1mkGp+ArEDAk86yBl8eE8DMS53vAsEiHtghn1Kxo4+4+bz
         NkTXJiBOqFnBbak8ruwpplDRsymHpOwQcPXjCtCk0sQsbRavLNW3zEm7EZXh9CFOT6bX
         ukuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124766; x=1734729566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYq2MT/kLJ5VNDS2ggKYbL2pEgZu56efpig6dGEeYSQ=;
        b=T0mZiC0uoy/1ARYWAfn+E0mHyg2Zc60xF9rH319xHep4ZQPR2X2I1nXJaayEw8VV7o
         E7Ree467KxEbgXv/J0WggSLLDfJTiYjnT/educMR0UUxc4SMUYArM7dULE2hHJ06odxC
         snHprRBYncEwMgyTx8ka/L/rmxvkIWk/cmXMU8sp2UZlrhFw0h0cBkU306IH03xczjZh
         g+jX2sGBELN/5l7PnaWqqcWJ9fCtYUvwLRL+ydB4cOnk4ytcJI0ybc8U0eeg2l2efEIe
         rlJJZuYKCb3/20Yl9shZjGfz8m3Qrime4yvq00QlhfgqAErK/PvP4Zpj1n+Xv2Sjz/3l
         rrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6e526eA3+4aVuL4oOV41+JgapfCEztv2tRW2Qrbs3YeC8SoxUYtzKLqhnu2aCON3IWZWdkBjNtE=@vger.kernel.org, AJvYcCVLT2d9QzrS41EuG/v76D2N59arA+1flOTCxb9zqfYznCb6/SO0XkCQ87orZ42iG7xBy//1ctkKnE0rwKk2@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjG6M9QdDVuT5MpustR+PpkiAP1dw2S75VxdEF8bwpv+jUiz2
	M4/ibT3ByjKcSBphgB86aLvN7XcpVCM/8+coXaIlHbCEUf1H1qiJ
X-Gm-Gg: ASbGncus7LgDg1nPjRT5ZQVC84IlV1SRiM/WSA6yf/ZxbCKN4bc2UZaMT5A4DYAa0y6
	fyVuY0uoBkfD1pNkkLm2FzC4MfvVYxTVdTxMzyMpudkctjDJLVBNdtg+RCbRidQG0E0Vy8wUx9F
	9Sseqzj4Z8/YJnKTP1ch+/id15qARNof75k1AiKbwxjVvkWEU1wgwDpoZXzDbJoVgL7KwMixvBi
	xyvpTwLSiQ0yNo4FDqZ8S++vg6g+Fjd2rSYKbwdFF2aHG5qNT17dODIsyO7CreImFGMF+OUlXWJ
	PsEIR2mB2n41dL8GZ5KMWaxUieovBMuNMGQ=
X-Google-Smtp-Source: AGHT+IEXNihsN8XxqgC7drI8y5j/V5W3EJ0WOgSZSqHoe+pvSP11CUBMZGS7mFc5Zqk+njfPyD0HaA==
X-Received: by 2002:a05:6000:154e:b0:385:decf:becf with SMTP id ffacd0b85a97d-3888e0b8793mr1084569f8f.11.1734124766520;
        Fri, 13 Dec 2024 13:19:26 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:26 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 7/7] iio: accel: adxl345: complete the list of defines
Date: Fri, 13 Dec 2024 21:19:09 +0000
Message-Id: <20241213211909.40896-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having interrupts events and FIFO available allows to evaluate the
sensor events. Cover the list of interrupt based sensor events. Keep
them in the header file for readability.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h | 57 +++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index bf9e86cff..df3977bda 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -9,10 +9,35 @@
 #define _ADXL345_H_
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP		0x1D
 #define ADXL345_REG_OFSX		0x1E
 #define ADXL345_REG_OFSY		0x1F
 #define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+
+/* Tap duration */
+#define ADXL345_REG_DUR		0x21
+/* Tap latency */
+#define ADXL345_REG_LATENT		0x22
+/* Tap window */
+#define ADXL345_REG_WINDOW		0x23
+/* Activity threshold */
+#define ADXL345_REG_THRESH_ACT		0x24
+/* Inactivity threshold */
+#define ADXL345_REG_THRESH_INACT	0x25
+/* Inactivity time */
+#define ADXL345_REG_TIME_INACT		0x26
+/* Axis enable control for activity and inactivity detection */
+#define ADXL345_REG_ACT_INACT_CTRL	0x27
+/* Free-fall threshold */
+#define ADXL345_REG_THRESH_FF		0x28
+/* Free-fall time */
+#define ADXL345_REG_TIME_FF		0x29
+/* Axis control for single tap or double tap */
+#define ADXL345_REG_TAP_AXIS		0x2A
+/* Source of single tap or double tap */
+#define ADXL345_REG_ACT_TAP_STATUS	0x2B
+/* Data rate and power mode control */
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_INT_ENABLE		0x2E
@@ -34,20 +59,40 @@
 #define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
 
 #define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_SINGLE_TAP		BIT(6)
+#define ADXL345_INT_DOUBLE_TAP		BIT(5)
+#define ADXL345_INT_ACTIVITY		BIT(4)
+#define ADXL345_INT_INACTIVITY		BIT(3)
+#define ADXL345_INT_FREE_FALL		BIT(2)
 #define ADXL345_INT_WATERMARK		BIT(1)
 #define ADXL345_INT_OVERRUN		BIT(0)
+
+#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
+#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
+
+/*
+ * BW_RATE bits - Bandwidth and output data rate. The default value is
+ * 0x0A, which translates to a 100 Hz output data rate
+ */
 #define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
 #define ADXL345_POWER_CTL_STANDBY	0x00
+#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
+#define ADXL345_POWER_CTL_SLEEP	BIT(2)
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
+#define ADXL345_POWER_CTL_LINK		BIT(5)
 
-#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
-#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
-#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
-
+/* Set the g range */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
+/* Data is left justified */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
+/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
+#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
-- 
2.39.5


