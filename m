Return-Path: <linux-iio+bounces-8232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB1946F11
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5441C20BE7
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425940BE3;
	Sun,  4 Aug 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zws8k1Kt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C881CAB1;
	Sun,  4 Aug 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722778975; cv=none; b=KDOOijDpoYyCqRsZ66TQZNYdUtz4yScRtyPz5BgoOdzTC/PD9gSReLsRPUFnqufORzljAXtb66ul18OcfGjnW4wYVcoMz+hWAZ62lFfhuidFD4Bm0E4ZtltjSJSM3MTH7NkBz3PNDprDJsi4haIEw2mF6ytsrVGL9tyU6uNjW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722778975; c=relaxed/simple;
	bh=DAp5qdEDWVJH7N7R9ECuBCxEY1J6WEuQjzvWtdr+XA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3JEdPoJ1x2VimnzjIxf7lnMXXwNsdffG9YlttppPtPtz98BA9yDGx3CzWxyjwfwLRNjSvnZ9qgrzMB2s4w/5USIQh/iPanvhWHHzYb0axkfcb0QB60Bk98r+Gpa5w1z7yuhN8+MisZfPs+Vhc+Pd1GszzFBmm39dTA7KbJc+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zws8k1Kt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd78c165eeso83535045ad.2;
        Sun, 04 Aug 2024 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722778973; x=1723383773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHJwPZpdp2rqseUmRDcq/aPowEMmcCTrYWBEopdNQpA=;
        b=Zws8k1KtJOAG11R3lP0XMJOffEuMxqytt4ynMvux2mtdcuXkycF4HeKsxFoq4v9dQP
         x7tTbOGc2dJv25x9pTWmzGt9l1cbo3FsNzwh1mKYkebQhWx3mb9zUVmZccafUywfgmS4
         3iEXqbTGNnSLCvuKsV99VacEX0klSq55A4/ZEY1ix2WnfIXLeFldurVwLO12pbYmXo/w
         E6V6auQRDT4ea95sbLFPGABwo72svGncfLcCspqownVF0TtMJ6VROzGfKY215WzOv8NP
         WCyzQxMYCKrjLK05uOUCqQe5MasUSk2hrii8Swe0gLX6Ju7dyfYeGidXxpnGJe43YiVn
         YDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722778973; x=1723383773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHJwPZpdp2rqseUmRDcq/aPowEMmcCTrYWBEopdNQpA=;
        b=S3WN7s5c4i8zg2+W0R4fxOi8pB9O54D0H+8evgCYJ95fe09p89+oC1AXgf3eXN9toF
         thpoG9pbYvAqQtfPOH/7TISE0WFZvHyykRUpxAm1KRAdG9KErElhI07OoWX7gZ+0WdHr
         lN3neDlp8Y+48sPAvMmDrMtkYCHmkz/2DL8p1FN4TAsOLCBGaDsGtjeaHJJucIbmvJBP
         a6T1ZiYz0LPRmaPmMFRyeu/Zbojh9g5nIVpGv1D7LDZubaYIYELl7nFwpWnWHfMtx+Ht
         cXOybV6gxMaPAgrT4WAkHyGkjPhzJiBpPoSHA3hwB7oh6zvGUoxK2cooGTjHcR/p/w5h
         FlBg==
X-Forwarded-Encrypted: i=1; AJvYcCXblB5lHc/dKJ9j1pwBWOiUSf9y5vENv6uhPSWjtLkfepcdOH1ZfaC5C6pSvLgjXVkV3pcHbrHi12BLnmH/MzsI93G0p05+6urqNtXD
X-Gm-Message-State: AOJu0Yxmd3l2P4TAFV6djbIdGurKv88aYi/v4ZFBKAno5YXbKnpVTl5W
	10sEUMiUK+s+Bkm/VI634qbDbL6rek2x7cQCo93y4DvH0NXWC79+qD+S6LJreR/ULw==
X-Google-Smtp-Source: AGHT+IEBnMAV74F6b2VYci3ovLD1y2UE1XNt3H9fk4jK9X16Vg46QA6VpMnesGpOWGC4lEWW7tyA0A==
X-Received: by 2002:a17:903:1245:b0:1fb:3ce5:122d with SMTP id d9443c01a7336-1ff573bfe4amr131326905ad.41.1722778973261;
        Sun, 04 Aug 2024 06:42:53 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff58f29d7dsm49521275ad.46.2024.08.04.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 06:42:52 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/1] iio: light: apds9960: Add proximity and gesture offset calibration
Date: Sun,  4 Aug 2024 19:12:12 +0530
Message-ID: <20240804134212.51682-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804134212.51682-1-abhashkumarjha123@gmail.com>
References: <20240804134212.51682-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proximity and gesture offset registers perform offset correction to
improve cross-talk performance. Added `calibbias` to the proximity
and gesture channels.
Provided facility to set calibbias based on the channel number.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/apds9960.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 1065a340b..bc966b096 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -146,6 +146,25 @@ struct apds9960_data {
 
 	/* gesture buffer */
 	u8 buffer[4]; /* 4 8-bit channels */
+
+	/* calibration value buffer */
+	int calibbias[5];
+};
+
+enum {
+	APDS9960_CHAN_PROXIMITY,
+	APDS9960_CHAN_GESTURE_UP,
+	APDS9960_CHAN_GESTURE_DOWN,
+	APDS9960_CHAN_GESTURE_LEFT,
+	APDS9960_CHAN_GESTURE_RIGHT,
+};
+
+static const unsigned int apds9960_offset_regs[][2] = {
+	[APDS9960_CHAN_PROXIMITY] = {APDS9960_REG_POFFSET_UR, APDS9960_REG_POFFSET_DL},
+	[APDS9960_CHAN_GESTURE_UP] = {APDS9960_REG_GOFFSET_U, 0},
+	[APDS9960_CHAN_GESTURE_DOWN] = {APDS9960_REG_GOFFSET_D, 0},
+	[APDS9960_CHAN_GESTURE_LEFT] = {APDS9960_REG_GOFFSET_L, 0},
+	[APDS9960_CHAN_GESTURE_RIGHT] = {APDS9960_REG_GOFFSET_R, 0},
 };
 
 static const struct reg_default apds9960_reg_defaults[] = {
@@ -255,6 +274,7 @@ static const struct iio_event_spec apds9960_als_event_spec[] = {
 
 #define APDS9960_GESTURE_CHANNEL(_dir, _si) { \
 	.type = IIO_PROXIMITY, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS), \
 	.channel = _si + 1, \
 	.scan_index = _si, \
 	.indexed = 1, \
@@ -282,7 +302,8 @@ static const struct iio_chan_spec apds9960_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
 		.address = APDS9960_REG_PDATA,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.channel = 0,
 		.indexed = 0,
@@ -316,6 +337,28 @@ static const struct iio_chan_spec apds9960_channels[] = {
 	APDS9960_INTENSITY_CHANNEL(BLUE),
 };
 
+static int apds9960_set_calibbias(struct apds9960_data *data,
+		struct iio_chan_spec const *chan, int calibbias)
+{
+	int ret, i;
+
+	if (calibbias < S8_MIN || calibbias > S8_MAX)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+	for (i = 0; i < 2; i++) {
+		if (apds9960_offset_regs[chan->channel][i] == 0)
+			break;
+
+		ret = regmap_write(data->regmap, apds9960_offset_regs[chan->channel][i], calibbias);
+		if (ret < 0)
+			return ret;
+	}
+	data->calibbias[chan->channel] = calibbias;
+
+	return 0;
+}
+
 /* integration time in us */
 static const int apds9960_int_time[][2] = {
 	{ 28000, 246},
@@ -531,6 +574,12 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
 		}
 		mutex_unlock(&data->lock);
 		break;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		mutex_lock(&data->lock);
+		*val = data->calibbias[chan->channel];
+		ret = IIO_VAL_INT;
+		mutex_unlock(&data->lock);
+		break;
 	}
 
 	return ret;
@@ -564,6 +613,10 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val2 != 0)
+			return -EINVAL;
+		return apds9960_set_calibbias(data, chan, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


