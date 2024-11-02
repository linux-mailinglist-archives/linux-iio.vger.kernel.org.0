Return-Path: <linux-iio+bounces-11831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B47D9BA040
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15951C20BDE
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C0018A92A;
	Sat,  2 Nov 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA0yDPcU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E818B47B;
	Sat,  2 Nov 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553210; cv=none; b=C5Zy8FUrbSRDYsVsA31wDc0XdkWM0WakKsOtjYhVn/jkfCuUCAVkKVgxkKO/XZjhPSveZS/sWeajLaCz7lQp/47QEPB6TTWpwCi/HoFtMXvonoaP5qRASsw1/NYpa0KHxAvk3PcXHzJ1d0hRzRldkzxSeFC0Cl8yFynj4W/PMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553210; c=relaxed/simple;
	bh=Ivj3K4QViitvAojGVDS5oG0DyH9SDexyGRYnaxNC38g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9tVqg0XZGq9lGkSgqObGTsQzO9UXdpjlE0WTkpUN2vKfFe7TjWSFxP1lFltu4e84YUKkUMKjNYs1n8uuYqEkNAHIHun8QeVNG3RstFXX+Hu7SC3duWJs/MxnhngUWZ85xNPLtiw/EcN0oCCFRrqKNRsfMXtcfj627xmAUNfvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA0yDPcU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43152b79d25so24077575e9.1;
        Sat, 02 Nov 2024 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553206; x=1731158006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQkyYg38PIPTosx7BKhjuXp+ykRKp2GeAROi5exy52I=;
        b=FA0yDPcUDy30MCBxAPCZq/VdDxtNpUHR0BZnaGZi9kf3+//pxezXPcJG8aw43zg4N6
         8TCsVMlL/WwOlCFOfVxgCF+32Lnwv3lw04LOproRUfY7iwEnlM3RrsmfxMDgEWAQlIRM
         C3w0H14H03+AFB2xQ2zahyUQ1k1fKWG95HAtXCdIog8fDayPOKKvxSLrJycJNtHaCbWo
         rbab9hiIJUVtf+K2fyjrClJ69FnxwIjefsgdDYdAU6pl/aiZ52ECMLrMFgaj6FAu/Wka
         xF1aA46byb+Wl9LCrTch0Igqrd1SepnWIyhESoeAkZ0mZ8D4J8eXH5C/NYkOVEUqOVus
         TJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553206; x=1731158006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQkyYg38PIPTosx7BKhjuXp+ykRKp2GeAROi5exy52I=;
        b=nioKgtJ/kZxRp/HvJwuIomx3G4KpbbXrMwbCrGvJlhcvnCFNo7Yk9qu5ucbQ7BN/nC
         hk7Iz7jaG+HN5fyM08yVjWemU+roqR6VSTpdowUjJfwZoeoPy5IQ/zdGmw++FISRwxP5
         OGMQlEuMfo+r4w5rOE++mpvkiIfGwEtWjJWVWlE3lfT92hBNl2QscrZAzx2hiYPMgTUF
         V3Jf+KhvwXFy37wQMW+yu0TusfRtEuxvgkIB2tNNSTvGtGY/BOhYDaZTlWjRnGnifQcE
         2NXl1kDBY/zy5wEGyEhuYX0FeJBzRzA1OL9PXkafdHkIh3X4wLnH2+vTbgkT+Nz3JoJe
         stfw==
X-Forwarded-Encrypted: i=1; AJvYcCUNCyx2G1S5uET0vq6wthLPHs4SBhjQj+CfawTHavXhkVd/lhpGl216pD0+8KjOD9N2qehhZmvwZEB6@vger.kernel.org, AJvYcCUuyq8xSdWuwQpQuXCuKkxdldTM7Q0GPhee6UGW6D8tQpXDShotONrXc7qPJd/6BLu1wVXXEqnnPCleVqib@vger.kernel.org, AJvYcCVyc1vy9hfbgBE3OjeX42ETwQ92lO+/HonsU55dvauRiTWPH2/hoG/Ls2OuAztYDQ3CSy3uMp0sUSbY@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOZbkDR4DbIxOADhLPvYG5BMqICmIssSSAzFk3erEQYjxU9do
	kMe5EjsqE+Pm6NIghyypbKeEcmGfDVtMWIK9Qzl86CrhXqeCcxNxgvWRsxCJ
X-Google-Smtp-Source: AGHT+IE7gzmhQd2zPicrOhNTa10EM9/0J1ENm4Nw+5Oy2etWO+kC0CtFrU7HbWQ/nBqwV6KwQu4tIg==
X-Received: by 2002:a05:600c:3b91:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-4327b7ea7c6mr96883325e9.26.1730553205713;
        Sat, 02 Nov 2024 06:13:25 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] iio: chemical: bme680: refactorize set_mode() mode
Date: Sat,  2 Nov 2024 14:13:05 +0100
Message-ID: <20241102131311.36210-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactorize the set_mode() function to use an external enum that
describes the possible modes of the BME680 device instead of using
true/false variables for selecting SLEEPING/FORCED mode.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  2 --
 drivers/iio/chemical/bme680_core.c | 31 ++++++++++++++----------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index f5be4516dde7..77136b55e7f6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -27,8 +27,6 @@
 #define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
 #define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
 #define   BME680_MODE_MASK			GENMASK(1, 0)
-#define     BME680_MODE_FORCED			1
-#define     BME680_MODE_SLEEP			0
 
 #define BME680_REG_CONFIG			0x75
 #define   BME680_FILTER_MASK			GENMASK(4, 2)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6d11f9188367..5c2c327c4540 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -95,6 +95,12 @@ struct bme680_calib {
 	s8  range_sw_err;
 };
 
+/* values of CTRL_MEAS register */
+enum bme680_op_mode {
+	BME680_MODE_SLEEP = 0,
+	BME680_MODE_FORCED = 1,
+};
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -502,23 +508,16 @@ static u8 bme680_calc_heater_dur(u16 dur)
 	return durval;
 }
 
-static int bme680_set_mode(struct bme680_data *data, bool mode)
+static int bme680_set_mode(struct bme680_data *data, enum bme680_op_mode mode)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (mode) {
-		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
-					BME680_MODE_MASK, BME680_MODE_FORCED);
-		if (ret < 0)
-			dev_err(dev, "failed to set forced mode\n");
-
-	} else {
-		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
-					BME680_MODE_MASK, BME680_MODE_SLEEP);
-		if (ret < 0)
-			dev_err(dev, "failed to set sleep mode\n");
-
+	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
+				BME680_MODE_MASK, mode);
+	if (ret < 0) {
+		dev_err(dev, "failed to set ctrl_meas register\n");
+		return ret;
 	}
 
 	return ret;
@@ -613,8 +612,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	int ret;
 	u8 heatr_res, heatr_dur;
 
-	/* Go to sleep */
-	ret = bme680_set_mode(data, false);
+	ret = bme680_set_mode(data, BME680_MODE_SLEEP);
 	if (ret < 0)
 		return ret;
 
@@ -745,8 +743,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 
 	guard(mutex)(&data->lock);
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
+	ret = bme680_set_mode(data, BME680_MODE_FORCED);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


