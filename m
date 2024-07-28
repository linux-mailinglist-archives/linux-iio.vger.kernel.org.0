Return-Path: <linux-iio+bounces-7995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A356193E5CE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF09AB2119E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535A5381B;
	Sun, 28 Jul 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfmezoiE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1051C4A;
	Sun, 28 Jul 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180057; cv=none; b=oWgPYNaHdkp4aVPXy6hUgEb2/krgTFjDes3GUfrsL9KVG6xjCKCJeo8TegEuvCoybMoeY6hLpTFb1lNXnAHP8Sh0MThJSj8r79Hj6tSSAQduJ6tN+hmQzZl0ApTM0VDhqt7txrFhviXlfmCAN9S4FT/p4sl+GIEGlFLMWlZoDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180057; c=relaxed/simple;
	bh=H2l0h8YRhgXblFTsNadr2/9iP8N+azShpAkZg3gB0nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxQ3F3zXts7HK3NZ7B4QtG0G4lKcoYUor4PaxExuO2v+L1qzcXcn6ZKrMGu5C7aUJ7lRocx7d4QXSLsR2kwc48sWun16B+mNqgVyS2agMyad9TpVtE5tWbUZF51bdA0roR4NX1qQixNoalhZK8tZc+5fMX03sMVKwq5Tdi8N3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfmezoiE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2248233b3a.0;
        Sun, 28 Jul 2024 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722180055; x=1722784855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C1EgNpzZcryNoeLIX+aGIDEXf/D0siNcgsRHDZO6bM=;
        b=XfmezoiEMDZsdyS2JWYgpqxdx53AolhFr+M5R6Can5+0vjILtE3T53s4HdWHiscvI2
         X6j9sSi00jeAg4fUtUGoNOpFz5bwAdVNAiYwrXL7r4lpc2EWdNESg6lq29caQH8/iFuH
         ab69/XO0mXnt8r68oQWSTXOnkPDLELYd9Mv3v34INJ6r/oFBPCioeJp94bYZn2bHZBTG
         frNKwP95ybMyOJoEjJh+YTEgM6m7kLcpj/PKSryWTjMRnYd46UFJt/AELbNlSP3G6ycu
         ZQch+gFQz+54Q9w5vzyiCAFtRymWCtuChPubcgJTd3e5E3tmImSl6A/jZQXWHG9kXPF0
         JiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180055; x=1722784855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C1EgNpzZcryNoeLIX+aGIDEXf/D0siNcgsRHDZO6bM=;
        b=vZnFljkh3ppszjh9Hmu5wPdkEZcUAiRt1c783TmxdruwDf9kr/iAi3nhk98ZDZ6trJ
         FCepW0eLjgKzdCXuTW6py7g3qXtWiLwi4w3hLybiLVUd8HqNjxmGH5nanugMKMvR6aoy
         Yh/VAIIj4cfRcFRndBevcyGvTAF3kyTrnbHraIbnwwJ7QanpF0iuxfkW+v//SAYXIzcZ
         RWkycfycTcwVv0xg4KdXlZ4pSMsDUdoM9gf20c+1JoMnsw0Oe/TpoboHxNnCzfUAQ063
         M2TbnIklqzYSy2kg8ntZ/XG9PJ7lvc5lYlaeDZlrAfby/SdU+IQ+UPqcYQ0zQyKa0NY+
         FlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUaF4RQoVrsE8DVhLNw1nQ8mLbucoj/lQTyyv0RfzTEQdLuaS3Z16rLMnypmG7QodqydXgmnATIuR5snToQVPk2lq3/7hiXf/ETF5f2
X-Gm-Message-State: AOJu0Yxc0ccoygpaMVQXCROAo6SNNONiOvmYdcIfLdr0JtRRhMIiVu55
	EC/U1ALtUx9ftLTZttAxcaBA5wdYL9VsGUYOLK859IOn7SXfh+S8RdCe9IbPVv63ZQ==
X-Google-Smtp-Source: AGHT+IGNA3Wmardp50omAbWdFw1sWR+UfMQVgPGsNJrCW4pu80jRVSATvb/D2JiMzqrGUMkOvMQE6g==
X-Received: by 2002:a05:6a21:393:b0:1c4:cae1:d53e with SMTP id adf61e73a8af0-1c4cae1fa7amr150970637.22.1722180054933;
        Sun, 28 Jul 2024 08:20:54 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm5836843a12.28.2024.07.28.08.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:20:54 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 3/3] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Sun, 28 Jul 2024 20:49:56 +0530
Message-ID: <20240728151957.310237-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728151957.310237-1-abhashkumarjha123@gmail.com>
References: <20240727132735.052502ad@jic23-huawei>
 <20240728151957.310237-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    counts_per_uvi depends on the current value of gain and
    resolution. Hence we cannot use the hardcoded value of 96.
    The `counts_per_uvi` function gives the count based on the
    current gain and resolution (integration time).

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 41 ++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index d1a259141..aceb97e3d 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -45,6 +45,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -122,6 +124,19 @@ static int ltr390_set_mode(struct ltr390_data *data, int mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	int orig_gain = 18;
+	int orig_int_time = 400;
+	int divisor = orig_gain * orig_int_time;
+	int gain = data->gain;
+
+	int int_time_ms = DIV_ROUND_CLOSEST(data->int_time_us, 1000);
+	int uvi = DIV_ROUND_CLOSEST(2300 * gain * int_time_ms, divisor);
+
+	return uvi;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -167,8 +182,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_INTENSITY:
@@ -202,17 +217,21 @@ static const struct iio_chan_spec ltr390_channels[] = {
 	{
 		.type = IIO_UVINDEX,
 		.scan_index = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+							BIT(IIO_CHAN_INFO_SCALE)
 	},
 	/* ALS sensor */
 	{
 		.type = IIO_INTENSITY,
 		.scan_index = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+							BIT(IIO_CHAN_INFO_SCALE)
 	},
 };
 
@@ -261,8 +280,9 @@ static int ltr390_set_int_time(struct ltr390_data *data, int val)
 	return 0;
 }
 
-static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
-				const int **vals, int *type, int *length, long mask)
+static int ltr390_read_avail(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			const int **vals, int *type, int *length, long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -280,8 +300,9 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
 	}
 }
 
-static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
-				int val, int val2, long mask)
+static int ltr390_write_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int val, int val2, long mask)
 {
 	struct ltr390_data *data = iio_priv(indio_dev);
 
-- 
2.43.0


