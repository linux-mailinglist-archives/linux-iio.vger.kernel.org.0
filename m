Return-Path: <linux-iio+bounces-20101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A84AC9F8B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AFE1893483
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D71FF61E;
	Sun,  1 Jun 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQefAsly"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E01F866A;
	Sun,  1 Jun 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798518; cv=none; b=HgHK4ImcVPgRoUuhh9nPFMVlzFwxNU5M1DQdihWihrKiamKYPw23Q5A0ni9oBD2iGd7C3/6irOasm+vVgMyfoe3Linxqc/5K05eokTSn34+49822uuKO9dGhPhJ+WVImDN5NDfoFJX9WH4lj0WOSxfjPmKoF/Tpav15XdYfsh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798518; c=relaxed/simple;
	bh=kFiMkvCOIRVqtMWYXPd/AZpWgNM2n4LnCr36yt29o30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTutpkMbdRZ5JyH1tmigEtW8TRL4DRKVG+mAVlkOL/Z/7OIH2dViKIndZzjnxnX/N+udk0MWWkr/4u8Zer7mjKb4Hf/DnN6QLnQGO0uZxyKt1yKsVce/YLc7RpUoYYP3QSyWBeNNUsJN60AsIgTNNVh/jD5bo9/3TcaQHEEsE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQefAsly; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-44069f5f3aaso1111595e9.2;
        Sun, 01 Jun 2025 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798515; x=1749403315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeYCG8HkXRXIHHGQ9W/UCo5tolHvwhv1GUMJTmxb+OQ=;
        b=IQefAslyGk3gHf4HMoxErihVsuotvqXq9GhD6+7ToLL9f8ei3YM/LzRVHka6RkpErv
         YO7Gy4GGj2FURa5EailVYNYXYsWd3XYhJXsnFmD+89vFWyoAoiN43drbE+ZYznpBykp0
         y3QlobOIJ5hi1tZdEJw9sjQh/1loc43tpdqnaYeEb+RyJhX9U4ftF0GMYesHnsmTazZP
         lNa6HXCRjh5zmq5Fo/qr35WR279HLodQGQ+k/zCkuDTlhSruAihNNgbSl74l27MNstSM
         OvVsyjIqmfzFpM56G86P40nehCiXNQ2jpN6XQRdVhQODq81M9Ey1kfFjQPQcb9keC/4T
         hBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798515; x=1749403315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeYCG8HkXRXIHHGQ9W/UCo5tolHvwhv1GUMJTmxb+OQ=;
        b=Q8pu0CbvClc8RZ2TYWDGrZfn+se+5K05bCp3kUPhr99D2hdVqqzLrpcIYEbqCIT9Kt
         QPnHHNHvis+txe1lnbHQIlwAozJbN6BEIPRAue8MTaGdNOLyDQe5R0hhXktmOIYbD6Cu
         4vw3yyMSj+v9uUIPqyJNuDFLFCXc91xVq5fqCR8C1e2IYIlMVPKG8JliBc+Ko5jmaxkO
         cr9mS30eQiGGuWX79RvkXojAHa8u9tihr/syznQO8BAoUlBz4pyD1rYaWS/PofjPK8sG
         yByW8Id+crP+uVMIYx5nB+tH4bMFODwO5r56BdB5aqvgemsX0cjDv47kxY2LwLUyXTK0
         +fmg==
X-Forwarded-Encrypted: i=1; AJvYcCUodlEW/BqEYjNAP11PMghoWNx2U28Znf6JfR5JZWYLbpUfGXLizxGPPQENXv1x9beQaWADqBE2K7n2rgY6@vger.kernel.org, AJvYcCWHS5ErlCa1Dj/LVR09zZF6AycDkaQxTYiAFfbnzvy0V5H1rv2XKlboJFBGmkj3x147k1WBHEJ1huo=@vger.kernel.org, AJvYcCWarUznIJzMtiSrOsj+Dd4ytfmH58NU8URS0zfKcP7a+BMx0GvXCMwKI9JeOSDH+Z1PKvHLDIR/tfEL@vger.kernel.org
X-Gm-Message-State: AOJu0YynBC0gQOg6hUyP6ypmi4DCSkinhlPjFWkmZAdebIRZtaCcpOyz
	xWwM4q9lXFHmPrxKUMY22nTVOCXdI8hvN7TphoREVXxNXaQ94W78GqYU
X-Gm-Gg: ASbGncvxp/5dG+Pffp8Uv5OxawAc8mFvaO6W7adAPmvJHuRZHgYcG9hlXgT6W/hWY3t
	NVI/jrYWI7uHldD+LmZEGujiY8ZnYtZuBi+gbeFke39nEwmw5zsQbDGGAq2cAzlM7dGEFQ4Kuxo
	jbtuU44fGI+t0bksAGzz+OXFvgaXBx1mLwzpmIgE6yTrF1S4KZx9Lu2VJLcHLrhhVjmkCDYGksE
	gJG2FbUPAeKzwGu/xqz+dwgZVxH9YbEfckx/kFYrj54OZYx3RyjqgdR66teaF22fAIWd9Kyd5nD
	kUXCeO5Mnxb/S25TtWhy7y7h681cmmizOgy+IdSld5pe807WzB6rNBwndGPjgUB+A68PHXPa6sm
	0V7XiX9FPw5logmxvIPqumwHw/fVCKjblR6GmPvB7W2A=
X-Google-Smtp-Source: AGHT+IF2r0NjGU9pE0kv12DokvhTwolUZYq7BDqrmPlf0MhtFJnppJPFP9mEYSivSkVn8OUjjoeT8A==
X-Received: by 2002:a05:600c:1c8d:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-450d7bae255mr27584685e9.4.1748798514739;
        Sun, 01 Jun 2025 10:21:54 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:54 -0700 (PDT)
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
Subject: [PATCH v4 04/11] iio: accel: adxl313: add function to enable measurement
Date: Sun,  1 Jun 2025 17:21:32 +0000
Message-Id: <20250601172139.59156-5-l.rubusch@gmail.com>
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

Rework controlling measurement and standby of the sensor. Therefore,
replace writing the register directly by encapsulating this and dealing
with the return value in a separte function to enable and disable
measurement. This will help to avoid redundant code in all locations
where the sensor configuration needs to be adjusted, thus measurement will
be set to standby, in follow up patches.

Further, reduce the control mask to only the measurement bit. The sleep bit
actually controls a different behavior (not just putting the sensor to
standby for configuration, but turning it into sleep mode) and it is not
used so far. In consequence, there is no need to cover sleep bit and
measurement with the same mask.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +--
 drivers/iio/accel/adxl313_core.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index fc937bdf83b6..9bf2facdbf87 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -36,8 +36,7 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
-#define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 0c893c286017..6170c9daa30f 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -63,6 +63,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, en);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -410,9 +416,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


