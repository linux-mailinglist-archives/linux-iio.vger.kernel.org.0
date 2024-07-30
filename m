Return-Path: <linux-iio+bounces-8044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A2940905
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4736B253CD
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501918FDD7;
	Tue, 30 Jul 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL9ntevD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3118FDCF;
	Tue, 30 Jul 2024 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322731; cv=none; b=uvx7JelB0zKVhz5aYQrv5kA/CMXA+p0Wbz0VmpalUMFMV4nVvqAlQ/5CLHDe80A7nIz+AHezQLaNif6b41xaU4fBnWmkp7uEEtZ546p42MyPnFZod7riZHNzScMpXC2W+LLrfAU7tdPixBSGhCw1G7bQ9c4D6rq2NFd5czAUhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322731; c=relaxed/simple;
	bh=KH3WiUbPFjX2b0GbewcbZQdwYcpIGQdzDK0aD52ND+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK/ddlYVXKc3yGrjpM36wP3nxWHQOBmHMezWkDl9pHAiIEdcR8G/38z6YWHjp2d8W99sYo0sj+sAL0JQTU0L2p74MI6XMuI0aNwd0d1GjAcmmcPt4GVjsZKC31sf5eKRRJIFb3p/0DVpMAW1LM9px53ZoXE2H/rm3AIpR1Ck/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL9ntevD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3546445b3a.3;
        Mon, 29 Jul 2024 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722322728; x=1722927528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtbsN7ycxw2Dhmlhyg4JZ9X6Xr4H9ar+tBVNOnCfR0A=;
        b=QL9ntevDGCueGh9wOIBG7OWqcYOunWC2B4ptTgeK3efHYa10sH+ntZrQzyOEAvsQTd
         E9Z6rkPwVt+7CbXY5cQDpSRlUXRryUg/qrw9AlmNEQq6/mmm7PQ25pwiE5spTndwL2kw
         MuAo09wcri7dejaUQCxe6RxZarHOp6hDxCcoPUrdNppnVapOloBjPJQEY+LEGZxlbGKF
         e2ziT6BhCxjAKcJ0NExLI76iKxgXOMbxBH637PYLUgJO0PUMPzqnpZjLuT1pOSqQCStJ
         ZcxujH+O86INgDDxg47No2Y/Jw00eNvJvVm8uCiUYZfPGdOrr7PEWXq2dknlvqxyQ8NT
         Rk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322728; x=1722927528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtbsN7ycxw2Dhmlhyg4JZ9X6Xr4H9ar+tBVNOnCfR0A=;
        b=R3QrLO9t+vnS5kCRL1Sbu9GJm67LDKAd0HiU6TtyHmt2J3FXQrAZ+PjAQQ2JzHYNrg
         m9dwWHPR7It33E+/AWc8ApscagDbwn6Y3B/2ilueKvuGcxS4x3cWyuUB33jXngUBjh0a
         9qgnVb/94q8DFIoo82+KEPLplgBexGNyzTx1iMKr1gUYQTPk+PNlTL5D9PfOW7wAcSua
         Ak9R26c6DVd+ruXMfQmwA+cYhTziIY8jdpsjTHAQmiW3S99OeDP+0DJ6NWXMrfnYho90
         uiJdlPWU7KU7WuyITMYFYSz32J+THfcUcvllNK2LfxVBdMihmwUTBSheW/bDINppkCED
         MPSA==
X-Forwarded-Encrypted: i=1; AJvYcCXT3pvNUGRs6TQOi1fuLjAL5nolr02SabcSn6KAqwtSyxRP5OAyI+XRVkzDgu5F4+JgjPHApKYuss7Gr966rJs6lJENpblWLADG6a1t
X-Gm-Message-State: AOJu0Yz5msn8f+BF+3UpAPWV6nl4aEeFMwTaYmrL2wLOlflYsCqM4P9A
	q7eJ7cRxMXRW7dW//2gVnqE9r10LMsDATaP+uI39lkf1J6j0tZPzXqH8XIlR+YFm+fSY
X-Google-Smtp-Source: AGHT+IGrE8jtukt92/uv2sW34IwXqfYyV6JwCW7f2A+oGC+pKawGgtsQnE4MfUX/56JS/t9yHWhdqw==
X-Received: by 2002:a05:6a20:ce43:b0:1c0:e9f5:f6bd with SMTP id adf61e73a8af0-1c4a14c78f9mr13879824637.41.1722322728191;
        Mon, 29 Jul 2024 23:58:48 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7d378a7sm94337605ad.109.2024.07.29.23.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:58:47 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v4 2/3] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Tue, 30 Jul 2024 12:28:18 +0530
Message-ID: <20240730065822.5707-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730065822.5707-1-abhashkumarjha123@gmail.com>
References: <20240730065822.5707-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new ALS channel and allow reading raw and scale values.
Also provide gain and resolution configuration for ALS channel.
Add automatic mode switching between the UVS and ALS channel
based on which channel is being accessed.
The default mode in which the sensor start is ALS mode.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 109 ++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee3d30075..953c1ed3d 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -63,11 +63,17 @@
  */
 #define LTR390_WINDOW_FACTOR 1
 
+enum ltr390_mode {
+	LTR390_SET_ALS_MODE,
+	LTR390_SET_UVS_MODE,
+};
+
 struct ltr390_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
 };
@@ -95,6 +101,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
+{
+	if (data->mode == mode)
+		return 0;
+
+	switch (mode) {
+	case LTR390_SET_ALS_MODE:
+		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+	}
+
+	data->mode = mode;
+	return 0;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -105,15 +130,56 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ltr390_register_read(data, LTR390_UVS_DATA);
-		if (ret < 0)
-			return ret;
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+			ret = ltr390_register_read(data, LTR390_UVS_DATA);
+			if (ret < 0)
+				return ret;
+			break;
+
+		case IIO_INTENSITY:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			ret = ltr390_register_read(data, LTR390_ALS_DATA);
+			if (ret < 0)
+				return ret;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = LTR390_WINDOW_FACTOR;
-		*val2 = LTR390_COUNTS_PER_UVI;
-		return IIO_VAL_FRACTIONAL;
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = LTR390_COUNTS_PER_UVI;
+			return IIO_VAL_FRACTIONAL;
+
+		case IIO_INTENSITY:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = data->gain;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
 
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = data->int_time_us;
@@ -128,11 +194,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 
-static const struct iio_chan_spec ltr390_channel = {
-	.type = IIO_UVINDEX,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+static const struct iio_chan_spec ltr390_channels[] = {
+	/* UV sensor */
+	{
+		.type = IIO_UVINDEX,
+		.scan_index = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
+	/* ALS sensor */
+	{
+		.type = IIO_INTENSITY,
+		.scan_index = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
 };
 
 static int ltr390_set_gain(struct ltr390_data *data, int val)
@@ -252,12 +330,14 @@ static int ltr390_probe(struct i2c_client *client)
 	data->int_time_us = 100000;
 	/* default value of gain from pg: 16 of the datasheet */
 	data->gain = 3;
+	/* default mode for ltr390 is ALS mode */
+	data->mode = LTR390_SET_ALS_MODE;
 
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
-	indio_dev->channels = &ltr390_channel;
-	indio_dev->num_channels = 1;
+	indio_dev->channels = ltr390_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
 	indio_dev->name = "ltr390";
 
 	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
@@ -275,8 +355,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


