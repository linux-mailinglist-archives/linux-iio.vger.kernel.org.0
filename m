Return-Path: <linux-iio+bounces-8133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92E944E33
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945D41F26A86
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452111A57F1;
	Thu,  1 Aug 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avatN8wY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B25189B98;
	Thu,  1 Aug 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523162; cv=none; b=n/zyH2KC5W3G9EWJAeGtGoAKn8zYREFNBJ8O75h57UN4a5YnVRyhtEb0UOufdJJ1prX8/slnJ2cdF0ltjRfvBs9p1vBeQuOkomNSuXezBdlPe0NT7qJ1SIKLjXgse7Cj6MbKoEFL+Zn4k+4bQGxjO6BeJHEbgBPpDQKEZZ0fsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523162; c=relaxed/simple;
	bh=/1bC3Yz8Fn63ZouuD8yZjE4xe/wS8IbUJz9KRAgY9k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr6FL7UWWOxqtQZadaUtcWxILLUN6k6s63AVN8mFO5mMX03u6wON5V42czHevhIOipidr/Ww9JU9/O0kRJ0BeIzqKX7zpJvuAAB5haB+LbEdXj5Vbyeb2DsNz8O7hJ7WKBvu4n7wipPlHjODTSBIl8+nhmaEN351uvqfeCqWCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avatN8wY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc692abba4so52559435ad.2;
        Thu, 01 Aug 2024 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722523159; x=1723127959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwmHUdjoPV3dd0WcfIoeW7fjmPevT/WB5Pw+zt1UW7M=;
        b=avatN8wYh3j/cGtSPDpkQHoLMxF8doNQq0ntjIWPvXu3la4tz4AHADIM8bwosV4Q+1
         4nKr5SEIR8hKBcnMeFToFY98LzpVIJOvbKyurvqWND+WHDUGxBd0HgObk3e9twu6sf56
         sKuv7m6xE1Z7cK3mWSVzE5lJCXtqevt7OrCcvBF7YQGPgWfJL80R5WBzH4839RU5WJMO
         rRODg/Qu6ctpHLENam/5rqtRl+B9JHryG4ADsMLZp+TUl3GUJ76sJcQ7m6se3xuljkb3
         BJIZ8Xmems9UyEA0koSI2N5Y+ltNh4MklZ/b91BMk8VDlv2lU66c76Rpr8BIwQt43k5A
         ErSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523159; x=1723127959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwmHUdjoPV3dd0WcfIoeW7fjmPevT/WB5Pw+zt1UW7M=;
        b=SpVOOWidSWwM+V+fgdXDPvJ5O+hehP2OZEzUKV1hh+YacQe38Ma2aGCEyiZKNt3+vt
         8nm99nrvKiRW1T8rKQlZFoX1V2+sVAc+e0QMFhd33Sr9iHTuKNpIr8pCvM90rtZsd6Mf
         BQYtEkTtEI1ZCXE0+uAwNk1tDV9N3bgEnq7qLSSnHZgAfrk+Byaf+ob04NsaZNSrauSk
         fbc3ioYLGLXz76rMdtF6MA/AypwuI/FN0XgHkBukJDcHkj5F+UjOIiztGMqWi107mSjQ
         6fwsQOMaodKKTFyGxkJGnGRdTF4nnqCQzGCPrrTGlhCYeR/5UdJZktJXnkzYY2oMbao2
         m6wg==
X-Forwarded-Encrypted: i=1; AJvYcCWBzTjtkqcq7i74f5C4eQltouqt2dh7kpxzTr4CXn3RvptytS+T8d/cUgB1ifUx6SqMkSXRJ3eHYwa7YKDQN602F2mABU8/3jkNdmx7
X-Gm-Message-State: AOJu0YxooKDQEEJnenxNsLCFrLeJmz4Q4lr1Xs6+fvyJTiaMMkU3Y26U
	O0OTUKrIqbTNlNO1Z6GHJl2YXM9nxuDI2loNMsKfRhwL7FPhb6THsJUiNqgpiZY=
X-Google-Smtp-Source: AGHT+IHGx//19nsjWKJVqTcCtzNmgPNPzjN5CKiKKrPZfSU7SPDHG1DlvR8YTUXUr5jVz09/16gvEw==
X-Received: by 2002:a17:903:22d1:b0:1fd:b604:58a6 with SMTP id d9443c01a7336-1ff57291927mr4887835ad.17.1722523159287;
        Thu, 01 Aug 2024 07:39:19 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7c7fc02sm139825765ad.31.2024.08.01.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:39:18 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 1/1] iio: light: apds9960: Add proximity and gesture offset calibration
Date: Thu,  1 Aug 2024 20:08:57 +0530
Message-ID: <20240801143857.16438-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801143857.16438-1-abhashkumarjha123@gmail.com>
References: <20240801143857.16438-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/apds9960.c | 69 +++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 1065a340b..e7f2e129c 100644
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
+static const unsigned int apds9960_offset_regs[] = {
+	[APDS9960_CHAN_PROXIMITY] = APDS9960_REG_POFFSET_UR,
+	[APDS9960_CHAN_GESTURE_UP] = APDS9960_REG_GOFFSET_U,
+	[APDS9960_CHAN_GESTURE_DOWN] = APDS9960_REG_GOFFSET_D,
+	[APDS9960_CHAN_GESTURE_LEFT] = APDS9960_REG_GOFFSET_L,
+	[APDS9960_CHAN_GESTURE_RIGHT] = APDS9960_REG_GOFFSET_R,
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
@@ -316,6 +337,42 @@ static const struct iio_chan_spec apds9960_channels[] = {
 	APDS9960_INTENSITY_CHANNEL(BLUE),
 };
 
+static int apds9960_set_calibbias(struct apds9960_data *data,
+		struct iio_chan_spec const *chan, int calibbias)
+{
+	unsigned int reg;
+	int ret;
+
+	if (calibbias < S8_MIN || calibbias > S8_MAX)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+	switch (chan->channel) {
+	case APDS9960_CHAN_PROXIMITY:
+		/* We will be writing the calibbias value to both the */
+		/* POFFSET_UR and POFFSET_DL registers */
+		reg = apds9960_offset_regs[chan->channel];
+		ret = regmap_write(data->regmap, reg, calibbias);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(data->regmap, APDS9960_REG_POFFSET_DL, calibbias);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		/* For GOFFSET_x we will be writing to the */
+		/* respective offset register */
+		reg = apds9960_offset_regs[chan->channel];
+		ret = regmap_write(data->regmap, reg, calibbias);
+		if (ret < 0)
+			return ret;
+	}
+
+	data->calibbias[chan->channel] = calibbias;
+	return 0;
+}
+
 /* integration time in us */
 static const int apds9960_int_time[][2] = {
 	{ 28000, 246},
@@ -531,6 +588,12 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
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
@@ -564,6 +627,10 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
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


