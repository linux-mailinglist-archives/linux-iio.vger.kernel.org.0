Return-Path: <linux-iio+bounces-19758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A451FABE7A0
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A69E178611
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FC267AFD;
	Tue, 20 May 2025 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQaPceNl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6730264A86;
	Tue, 20 May 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781452; cv=none; b=A7cduqEHxQcEh3cds0Lxd8ZINFnIfsn1/mmgk1ev+CXjaJS8z+sMlvOJMHakUdImfBytXrA67jVf2xLUTHXTlj4caMseHC/a1hnyBYVSdP58SDU+oyZxRxjRICsCTElpsc7lz9dwoGcT0K+CeQCu8fKIYglTgriR7tJ3GNv++uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781452; c=relaxed/simple;
	bh=UML19rB3I7Moji5ihdWH5EkeZ3eOK1vFwd5wFQ63814=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ji7aW9uQiRQTuY4zEhHIK4yDlqSnglujCrtiVwro1JfgGZfAyD6YJA4f36Dh8itP/I657/0JDWgdfargWlW9DRTHR/xhazubcVz056gDNFhlzWDbVHVTyZakKuCj2pHQOsEwcv541DzemsQ7Y2h3JEv3IUiPBlr3P6aTxqFm1XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQaPceNl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a208a76272so576356f8f.3;
        Tue, 20 May 2025 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781448; x=1748386248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wLRpNFhkV9mvf2yxa+tQYmciv/wFHVuUwDrMmSvMcU=;
        b=dQaPceNlsGFtiJeW0XPizHAiBsS5cPwXROdowUjqWOBoiwqwfCUtJwGba8qkpNMQBd
         FspUuuJmiMhO/RsHyvt8oFtPMmHKYdoe68s5xW4TcF47+XLocneIAnbXpO42T8KoQNVj
         rXlOgX26yYBeR8xan+7eC1zeYc4zmKaor8lVOuLNT2h6NtuvEKLdI0eZghyoa+k/9YXa
         5Zv2vjnnxqEL9pxje2HzDoazuV8TpDtuQc+xtIYPiReYmVIKtNi/BE00AbgpkjmiOJss
         2IGC+xiBXDYxVyDWaPnen1p2Q4cnJ+z8oREtDhGmUiSvjkVtLycFPEtdkbXIy0EVsUKo
         vokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781448; x=1748386248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wLRpNFhkV9mvf2yxa+tQYmciv/wFHVuUwDrMmSvMcU=;
        b=iSBELx54ifrUqW0WwZqpMeauDn2xkRkMEg3gNHpVKiLeepyAY+uGsq3hVvndtuyN0P
         VK90UQGEfAXGpUhXFJ6xgF0r1KyPrF6IXJnYVAmbwnRLKjU8YkzcBVIZo7W92OpkAuHF
         Vd66SDf/DTO0IjvcpDhAj0fqmpiq/CXVo3xGJms+XY8UMi3dQj7LSgmfBaSuqbSt3Tnr
         0jAV+GHmjf4lckOIs4hJ2VOCpyrPsoS2Zv1Lr8Qp2Faw9TgzITcZFLjLYsmBECopGG6P
         Q7ypYFvF4IIaa76lhppJRJsmYSVuRLvctx4+hghlw9gIpFSXDmljWCOA+uPwMg3Aiy5C
         00Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVVln9pvjNdQzbD58M8qDvNxpv7hjdDCwmyB/QmxN8BmOT3dGDq55Urw8UdZ7ZUocsbOcAAiJ/iPpk=@vger.kernel.org, AJvYcCXbYxEy8KRtz6o6fHFXbVkGQn4wdw01n+GAdCNadBMqUPOuAfS+G7mGXYXN1wl6RjkutCLhl6d+JSh7aT45@vger.kernel.org
X-Gm-Message-State: AOJu0YyveUI02fN10oGgC5qqOx5Y4JKjCh0FK0QSY3XhX3ULuSAV1GZt
	sQybEeM6evN7B5pEWjyq0keDWKA5vukYfCzpckdMWnyLzL6Fi/HKpWsv9oZz7QSq
X-Gm-Gg: ASbGncsvkdlnPQwbLa6fWl6WJlNdtYZMi386Qg88TodEnUPYiiy6h0cf4Ca9jRgersV
	OogB50bGgtWu4z2zh9h6i5sZii0QCwAlIcE6f+SmBMUIoRcTPTYeFYA1ss4vmiBVJuznEINsXdt
	psoPtCskaCNznJYbBR9+YSYr8sEw4fiCPEB5jsL2vZ12VhZpO+nFM0cSSV6Ctyve1MZ6Wmq+Yzu
	hBLyMA5s0igeRZEAiYpkR4yHRgEOqXJCGkbUDEYRvz9syZz0KewMaYXzvTroNPpcUrT6h9eKV2K
	DIgPm4XDa+awLRv+rTJfbCkI2TrBAzgiDFoC8osg9AzVWR/K7RcXosM8brZQCsskFPjfdth7ec/
	tGt1zHGOUSXH2e+gvTm6p8Q==
X-Google-Smtp-Source: AGHT+IG6y7aiSwNrxwo3wBaT1sY1TRzI/ivC4SL9NTnq0M6Kgm/Wvp5DEdx9AiipwGaXx9UQTAhJhw==
X-Received: by 2002:a05:6000:40e1:b0:3a3:7077:ab9d with SMTP id ffacd0b85a97d-3a37077adb0mr3155541f8f.6.1747781448030;
        Tue, 20 May 2025 15:50:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:47 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] iio: accel: adxl313: add inactivity sensing
Date: Tue, 20 May 2025 22:50:05 +0000
Message-Id: <20250520225007.10990-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the interrupt handler to process interrupts as inactivity events.
Add functions to set threshold and period registers for inactivity. Add
functions to enable / disable inactivity. Extend the fake iio channel to
deal with inactivity events on x, y and z combined with AND.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |   2 +
 drivers/iio/accel/adxl313_core.c | 138 +++++++++++++++++++++++++------
 2 files changed, 114 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 9c7aedf7da7a..1398ac54d19b 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -18,6 +18,8 @@
 #define ADXL313_REG_SOFT_RESET		0x18
 #define ADXL313_REG_OFS_AXIS(index)	(0x1E + (index))
 #define ADXL313_REG_THRESH_ACT		0x24
+#define ADXL313_REG_THRESH_INACT	0x25
+#define ADXL313_REG_TIME_INACT		0x26
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2ad87e98525c..7356aacd8874 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -29,18 +29,22 @@
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+#define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
+	ADXL313_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -255,6 +259,14 @@ static const struct iio_event_spec adxl313_fake_chan_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 enum adxl313_chans {
@@ -335,6 +347,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_inact_time_s(struct adxl313_data *data,
+				    unsigned int val_s)
+{
+	unsigned int max_boundary = 255;
+	unsigned int val = min(val_s, max_boundary);
+
+	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
@@ -350,7 +371,7 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	if (type == ADXL313_ACTIVITY)
 		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
 	else
-		return 0;
+		axis_en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
 
 	/* The axis are enabled, now check if specific interrupt is enabled */
 	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
@@ -366,13 +387,16 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 				    enum adxl313_activity_type type,
 				    bool cmd_en)
 {
-	unsigned int axis_ctrl = 0;
+	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
 	bool en;
 	int ret;
 
 	if (type == ADXL313_ACTIVITY)
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
+	else
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
 
 	ret = regmap_update_bits(data->regmap,
 				 ADXL313_REG_ACT_INACT_CTL,
@@ -385,10 +409,14 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
-	if (type == ADXL313_ACTIVITY)
-		en = cmd_en && threshold;
-	else
-		en = false;
+	en = cmd_en && threshold;
+	if (type == ADXL313_INACTIVITY) {
+		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		en = en && inact_time_s;
+	}
 
 	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
 				  adxl313_act_int_reg[type],
@@ -481,6 +509,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	case  IIO_EV_DIR_FALLING:
+		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -500,6 +530,8 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
 	default:
 		return -EINVAL;
 	}
@@ -514,6 +546,8 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int act_threshold;
+	unsigned int inact_threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	/* Measurement stays enabled, reading from regmap cache */
@@ -521,19 +555,38 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 	if (type != IIO_EV_TYPE_MAG)
 		return -EINVAL;
 
-	if (info != IIO_EV_INFO_VALUE)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					  &act_threshold);
+			if (ret)
+				return ret;
+			*val = act_threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					  &inact_threshold);
+			if (ret)
+				return ret;
+			*val = inact_threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
 		ret = regmap_read(data->regmap,
-				  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-				  &act_threshold);
+				  ADXL313_REG_TIME_INACT,
+				  &inact_time_s);
 		if (ret)
 			return ret;
-		*val = act_threshold * 15625;
-		*val2 = MICRO;
-		return IIO_VAL_FRACTIONAL;
+		*val = inact_time_s;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -557,16 +610,30 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	if (type != IIO_EV_TYPE_MAG)
 		return -EINVAL;
 
-	if (info != IIO_EV_INFO_VALUE)
-		return -EINVAL;
-
-	/* Scale factor 15.625 mg/LSB */
-	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		ret = regmap_write(data->regmap,
-				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-				   regval);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* The scale factor is 15.625 mg/LSB */
+		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_write(data->regmap,
+					   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					   regval);
+			if (ret)
+				return ret;
+			return adxl313_set_measure_en(data, true);
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_write(data->regmap,
+					   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					   regval);
+			if (ret)
+				return ret;
+			return adxl313_set_measure_en(data, true);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		ret = adxl313_set_inact_time_s(data, val);
 		if (ret)
 			return ret;
 		return adxl313_set_measure_en(data, true);
@@ -722,6 +789,17 @@ static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -891,6 +969,14 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(data->regmap, ADXL313_REG_TIME_INACT, 5);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_INACT, 0x4f);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
 		if (ret)
 			return ret;
-- 
2.39.5


