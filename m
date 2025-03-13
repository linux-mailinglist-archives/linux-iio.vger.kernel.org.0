Return-Path: <linux-iio+bounces-16788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807BBA5FC93
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF523B0221
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837F26A0A7;
	Thu, 13 Mar 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X21AYDh+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000D268FED;
	Thu, 13 Mar 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884671; cv=none; b=frqn5ATEoZaivAMmrpkDmbNhcr52iYXAfIhlhZut7N2Vkzc/VyJv7nf7mRVBFyw+024TYrK9amQezPGSn12MqEnA+XTK+5IbBtsfrCFZqAd94yhm1Ivyya1M6BRp2y300QneST3/g6u3uZ3Eb9AAeJMjT6Wv5+Jh78ZZvafFAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884671; c=relaxed/simple;
	bh=8MP0T+dQsXHgXL5ulZQRNSI8o6NFV2qYmgSyeuqIguo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmeDeUkPMYmYx6cTaBCbVnfKtJIO60g0XrIgUU+VToJteVzPUa042JVOfz5AkRvuqzV5xC352+1oln1F4HKIYC3YqhmB8CV+t5erCY4oKdo50ctdJ6ccCk/iXa8N1Kmq7RBgYpLa/nMGRs58hfhWJUSKZ7IPlUta5u2nkQThAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X21AYDh+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac250d158a8so17037466b.2;
        Thu, 13 Mar 2025 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884668; x=1742489468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFwVdVVwUhuklWAEWaQaMN6IvcWIhL+hcr37YQoJJjg=;
        b=X21AYDh++CzT88Lh5DM96cs/DBzTwcC+uL8Tf3PJwMG0I2FKzDviwCJB2XBDlaoCRl
         FgrmLslG9pzI+AkGpVKbqg+ZkCVK/PNB/o4OOnNzBmKbyl0xnQK3k/TDJLN5eIQwv4uk
         6Y6/6cnQwnwYZqjKfz34RoPgfPu4CFOnEz+LRApT1Jauv7BlCfnhFfAgLB9hPm8if/v0
         17gVXCrSErKLArHGEmZO0yGfTht4Af+KUFMAmiNYUBBtq7J9agnk5ddoK1n1ob/GB1ms
         Z4WR2PuRtWY1sekUJ+HsmkziGNtgn4SmAmicL0msVYEJqtC23/WOqff3zNX6v+/NzS2X
         sZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884668; x=1742489468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFwVdVVwUhuklWAEWaQaMN6IvcWIhL+hcr37YQoJJjg=;
        b=iMMrNk4hbVULSpMcAON+B9KnhuIYJL4Ktg81F3QN9mOPCahdy568QsOnOCYCZhWUMj
         GEqUIqBvyJv9tN5D9hlo4WrbwZKlUL05SZ90Pf9vjCG/LEf7glCMfUbvACTnuzA/3gKA
         LChVI0kxP8YB7djgPbaJdEm/Xvtm24YE+d6NJHNIE6c/O1cl5k4cPUKMGqdjbt+TfReV
         W4MIg+G5pUxfrV+tDFcYqzC/aDYCrt8YBkTTF7FJtzutK1CA1Fn86sFBa1CC4WRfxg+F
         Qi8jGarmcm+Qj7IvZdyV1pOruU7CSK9o2vtl67ONEkKVEQAVI2B/X3tuF1fH4MJlis0V
         Q2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXmYR00c6JSHqaKJlqpUJ6N67sW9+vtrjdaLdo4gkhhnDOkMDvGYrJLHWEseeT1c49JhvgFMDsW6uU372o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPFwtCOJQKScnK+8wmmlp5TaMXE0sck47m9NuB49/JsgOFNNf
	FA5MUmmycQx9Vcz4p1gZVWx+OnovT0rozVYgFzKhtXKiKpth9tPEgeb4v9AB
X-Gm-Gg: ASbGncsRo5kSSqK8vrZ8AD8+XcFdtHl01qjKN4LUghOy0YEdCKcKgC+R33Wpn/nJ2OB
	fGkgKcDcyOsKYrSlQf2llvXk2u9yDK9LkxaQVjqT7uKKb7uLuzwsjx3nnWsKpEkhOqcVLLiH215
	gRcga21MrPZBHo7gb9chyGsiPGLr6Emv/lDplaAIQ41lOQjH1HcAXm17EY/ZhXkL6uGd2todFo1
	+TwLGQTPw7/qoSsyG8cqXJKuU5EkB+l2XDAOd+oD8rmTfOXFZKCbzujCZubBrpfpV+6bhqviklQ
	lqWRfDBrvYjju63YtRu/EhTFPjCSCMS0AlVR2Q0pk4p+W0TtcgakAyKtenrFETo7PbjcoQfJ9ID
	377tEZ5Iqp1AV2U0xvOtN3Ao=
X-Google-Smtp-Source: AGHT+IGqN3N58qGCdJYSRSVTs1vGRNIKtSeLmqI2x5AVaYMjqc7fWqymrdwSOe6j/wwJwODL2QiI1g==
X-Received: by 2002:a17:907:1c9f:b0:ac2:6bf9:e386 with SMTP id a640c23a62f3a-ac2b9ea161emr669472266b.8.1741884668029;
        Thu, 13 Mar 2025 09:51:08 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:07 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 02/14] iio: accel: adxl345: move INT enable to regmap cache
Date: Thu, 13 Mar 2025 16:50:37 +0000
Message-Id: <20250313165049.48305-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the interrupt enable member variable to the regmap cache. This
makes the function set_interrupts() obsolete. The interrupt enable
register is written when the driver is probed. Thus it is perfectly
cacheable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6f337b26999a..10e2da7de17e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,7 +36,6 @@ struct adxl345_state {
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	int irq;
-	u8 int_map;
 	u8 watermark;
 	u8 fifo_mode;
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
@@ -114,11 +113,6 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
-static int adxl345_set_interrupts(struct adxl345_state *st)
-{
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
-}
-
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -217,7 +211,7 @@ static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int fifo_mask = 0x1F;
+	const unsigned int fifo_mask = 0x1F, watermark_mask = 0x02;
 	int ret;
 
 	value = min(value, ADXL345_FIFO_SIZE - 1);
@@ -227,7 +221,10 @@ static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 		return ret;
 
 	st->watermark = value;
-	st->int_map |= ADXL345_INT_WATERMARK;
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE, watermark_mask,
+				 ADXL345_INT_WATERMARK);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -381,11 +378,6 @@ static void adxl345_fifo_reset(struct adxl345_state *st)
 static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = adxl345_set_interrupts(st);
-	if (ret < 0)
-		return ret;
 
 	st->fifo_mode = ADXL345_FIFO_STREAM;
 	return adxl345_set_fifo(st);
@@ -401,8 +393,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	st->int_map = 0x00;
-	return adxl345_set_interrupts(st);
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 }
 
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
@@ -524,6 +515,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/* Reset interrupts at start up */
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
+	if (ret)
+		return ret;
+
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
 		ret = setup(dev, st->regmap);
-- 
2.39.5


