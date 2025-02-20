Return-Path: <linux-iio+bounces-15828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956AFA3D705
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E35216CB59
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584421F1315;
	Thu, 20 Feb 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyqVRMrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AA1CAA9C;
	Thu, 20 Feb 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048163; cv=none; b=JiTvBRYqr2kl8TFrrMoE6tsOetFRkIowwOol2sqXHpvmF4GQvB6zRmjif4ekMAeO36gZzO85hwD+3uDSnpmZbGGcdzeYaBDrFpH8GCjXTs2pcbFuS0kSrp6phuUppn94Ro8LCzgk0xVmt3vB1KPh3JkVQZk13il5dXbDhHnSYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048163; c=relaxed/simple;
	bh=N5wPUtEL8GafvraaTitozwAcmvfIG4+F6qsLJt/dB1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoEjivoFAvbDEVY2/bqQidnSyExojwc9/+zVm4vaiNaXt/l9KcYan9jWcEfGp9EyLh8TkESkFCXy2dpqjA24vmFApSAOA8UHodLbIGERu76sxvXkxe0VK2NWvk43G8bytvo4n7ZvLxrDQnWv5MKqeBbEp33CPRnEdAy8r7UFYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyqVRMrn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbb16a0565so12153266b.1;
        Thu, 20 Feb 2025 02:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048160; x=1740652960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbwv18cfnvcZ2p2D0qtMZqem9sYjjTgAWQthVEWC7o=;
        b=GyqVRMrne+kYaf7I17TOJSxuixUCOFRX1Rv2dtHYiKQvu5gLk/+ZZ6QkWsiCEu/iBK
         +F4WZudb30jylzr7rMwsgrYxgkUEHHISWij4Gkwb/Mb6/olkRaxcTd+J5SPs+4SFd3+P
         MQTLZT90kDKv4z0XbOiQenhAwkrF5Mb5c51dX9xTi1nigq0iphgW6xB1Rd4mxPHBX5/h
         4d21VaO4mhiL3TOq29IfE6/aVOCBI+X6o4mTdB9omnPQmqsIZjxcdaSlpsbCXx6DQNlJ
         jDEyAsA37dvAYT5E8hDPkkdsShX8I02dp75gYXRdoAnB0AkagaTpMpHkDxnBUT4KK8ti
         JYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048160; x=1740652960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvbwv18cfnvcZ2p2D0qtMZqem9sYjjTgAWQthVEWC7o=;
        b=irmLMnU61QSZsOJ6nJne5/EsGfUVkgBwX/91rI74xSMmlrwWl5AKLnfD4qt8D5jNi1
         xty9WYrKuM1atBxupbk2AIRykd4CW2hpQDCEjWAM2/QpbJr+nL0UjPeFd0FVNqiTv35W
         f6D+s9uj8imp02lFq5zRw9wBL0SNKnYl1gou7rXM6HQwRtxwKyWOt9wpX5QJCiXOKPEV
         DwHKldfpAtYD9/TDxE6vk/yWgcBu5kFvv/maJoPCfuMuJuJmi8ntoBJdb9nq/1FcRpus
         bugOfodwSuqI0BjDg4B+Tch6DX5QSaQ9hFVG31xNsglYTTB5vk8g8FSsstsHtWPXG7gO
         uzyg==
X-Forwarded-Encrypted: i=1; AJvYcCUANY+9e6ZkNdNKmNwa9GGcS8vdV3ReAgwzxz8cM2TDYCv6GR8o5zUcfREopJOmY0dgoI7+wSpiZ3RPQ1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyd377k/Dmfp9Hv5j74dThYnjwOz2RP3QGbYIqYLlmwDD7rFxO
	BTR+tyy66qXvcCnBt5kjvQ/JM2QdmBNYYYatO9YvQoSH6oKHKgVP
X-Gm-Gg: ASbGncv6upiyTbXZWCusxG24uC2FoRCeplc3Yz7Nf9A53+1aM8VsFYUnvm9FmNpHcMw
	e6Q91nZuom1HfTDc08FhNcsWqSRju1kwUL6JVPKf4OrmzlPsATxokaCEhWhBbvIBDH6PunJQTdf
	8YcGtWnmO0iPrdRNVHdWmqT1G36M59GTpQ+WsNlVeVMITTT0rsJwfcKtTtG0R63YOsldiq2DrBb
	R3ONS/AyEo4NBhnmV7iLfVpmsSzhgLO3/PgX4QE0/1QH4P9rRm0rDNlulTzhWis+JOMFP8IvwbR
	cqQ4V/dtRTy638C4aUhlka/zPncAVFJElL3ott/Od1J6g3a3z1lS9W2jmkQiPl0MTrHksA==
X-Google-Smtp-Source: AGHT+IGUI2g+a2PDsMQXCnov2E7hRm5r7BSy/Cm728dhccNNiZNOm8E99POXf14RkcGPt+8ikOjCYg==
X-Received: by 2002:a17:907:d8b:b0:ab6:58e4:4fec with SMTP id a640c23a62f3a-abb7093370fmr829356866b.3.1740048159422;
        Thu, 20 Feb 2025 02:42:39 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:39 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 01/15] iio: accel: adxl345: reorganize measurement enable
Date: Thu, 20 Feb 2025 10:42:20 +0000
Message-Id: <20250220104234.40958-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the measurement enable function up in order to have it generically
available.

This is a preparation for upcomming patches. Particular features need
to have measuring off while changing settings, and turned on again
afterwards.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ed0291bea0f5..c24692c51893 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -76,6 +76,26 @@ static const unsigned long adxl345_scan_masks[] = {
 	0
 };
 
+/**
+ * adxl345_set_measure_en() - Enable and disable measuring.
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ *
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Return: Returns 0 if successful, or a negative error value.
+ */
+static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
+{
+	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+
+	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+}
+
 static int adxl345_set_interrupts(struct adxl345_state *st)
 {
 	int ret;
@@ -214,26 +234,6 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-/**
- * adxl345_set_measure_en() - Enable and disable measuring.
- *
- * @st: The device data.
- * @en: Enable measurements, else standby mode.
- *
- * For lowest power operation, standby mode can be used. In standby mode,
- * current consumption is supposed to be reduced to 0.1uA (typical). In this
- * mode no measurements are made. Placing the device into standby mode
- * preserves the contents of FIFO.
- *
- * Return: Returns 0 if successful, or a negative error value.
- */
-static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
-{
-	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
-
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
-}
-
 static void adxl345_powerdown(void *ptr)
 {
 	struct adxl345_state *st = ptr;
-- 
2.39.5


