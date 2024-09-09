Return-Path: <linux-iio+bounces-9381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C0971574
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367321F23D1D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD41B5830;
	Mon,  9 Sep 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRhbe3u+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3191B4C4A;
	Mon,  9 Sep 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878254; cv=none; b=h9PQ2dWZ6fdVWPCuTFR8fOiqYhUxGemv/1Thl+PcvtAEqiuHSuwMThcqMZS1TClMFi8pw5110oZQvukYbS+UnyyBTVgT0zJEmIKaX6wF+HSKmOzod465oMDyLjIdXCruXKurh0MMaGi+yMdk6uPDCdfAPLWcz29Eb92Kv/BWpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878254; c=relaxed/simple;
	bh=dpIzHbvRu28bi9o3PmHvgdJ8jCcqO43pFnJDruwQtpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuAEZ2zfaDgBRnkZp6jpKsxAtY3eOwUC874Iy20arj/tGtucxC2y4L9NNNuZIGcKcZuFr/d08lAY01JBpxbvBFtDfAt03a2EPyLp5nvGWX/mIz2GoiuptRN1nsikPotPgBSDJGvukNnAB9yolz0P9gIq2eUpXq8cRbjWiFXz/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRhbe3u+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so823974b3a.1;
        Mon, 09 Sep 2024 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878252; x=1726483052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA77S68U5yH+ARFT6rAvuB0lv7jhji9buh4OnSYCZQ0=;
        b=CRhbe3u+1cCmqhjB/QhBz+inSro0CLeT/NRfZBF8vCgiCJpNoJR/UpHZ9uy3tVb1qa
         R+iq4QxcRXkFrvzJtWXrjLkYcCRXjsf79wnXzbrPHWsS+irPoTDAfZ9nxvOZduC+jb8g
         TkF0Nf2EjJ8D0mC60aytXge3iRVPTcPC/8TuuyA/KeCyj2fTS1j7nFOw6NZf/2p9zon9
         S0sLdfeyCpFukghDtGBQYbio1Gj9+jRcH2kWuQWLS1go5eRjw22VOkSOoxw26KHLmK5B
         4VDuqvJmPji0O/Vfc97xsMlx8TbOzdmtVTUF9LpFpvVYUvbPhOEXiR5loPOqaLWTAf1i
         GFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878252; x=1726483052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA77S68U5yH+ARFT6rAvuB0lv7jhji9buh4OnSYCZQ0=;
        b=gkRIUp6lekjFN85WXxO4WA3nXIryqTjlPnDAV6tq36tFRxh+fJlHsuJ1v2j99epRTu
         VXXFNkFvaPBTJAmGHcCcooMRBrIR9gUzaarjKXzgw9ZFqrWQ5seXMXiI7dU4tOM7UfVI
         UtLu3xdcUrVYJQc8fNrIQnMZ5+kSo68RPPQrhWn92kHuX4hH30ctwqWbL1VIMbHNa+iB
         wYWSJxBeBfZFYlgLSRMl+yl5tZ0tdhVcxxlbXsl7jGSeSIHbNYlvPFECJwGBZr89kfhG
         sMHx1cTTBImfRp4VvvB2GKc2kSFToDa5FCwU07GjUBMtAiUHa1CpMbnam1QvQTmm0Tuy
         Nq2A==
X-Forwarded-Encrypted: i=1; AJvYcCUuKAjL7oojh3SPLewkTdqDYjtTbSW047n5J9ZJ9TCSU9uaU0xaCZznTFAp5MZzR4aJA4YdcpWI6ZekelU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQ+ggLKx6wom7YRL+yTPjCjgaR0mllH4Sl9p2IjHTzKMXRfHi
	3eNtoPmk+B/xBmN3lyAYupgMapKjxBhxdA8qZ85UJx3nCI+BHZQprJrf/W8/ja0=
X-Google-Smtp-Source: AGHT+IGD2UjNRug5F2H/UZOpU/gKqZ3pgXTuldQheukNRNfxEhbVqxTgsjheiGqXLJZme2Og3p5v9Q==
X-Received: by 2002:a05:6a20:2d0e:b0:1cf:1228:c175 with SMTP id adf61e73a8af0-1cf1bfa1533mr16390196637.8.1725878251637;
        Mon, 09 Sep 2024 03:37:31 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5897b3fsm3258032b3a.25.2024.09.09.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:37:30 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 4/4] iio: light: ltr390: Add interrupt persistance support
Date: Mon,  9 Sep 2024 16:06:23 +0530
Message-ID: <20240909103623.264113-5-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
References: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support to configure the threshold interrupt persistance value by
providing IIO_EV_INFO_PERIOD attribute. The value written to the
attribute should be in miliseconds and should be greater than the
sampling rate of the sensor.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 66 +++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index c707a4871..87195f001 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -38,6 +38,7 @@
 #define LTR390_ALS_DATA			0x0D
 #define LTR390_UVS_DATA			0x10
 #define LTR390_INT_CFG			0x19
+#define LTR390_INT_PST			0x1A
 #define LTR390_THRESH_UP		0x21
 #define LTR390_THRESH_LOW		0x24
 
@@ -46,6 +47,8 @@
 #define LTR390_ALS_UVS_MEAS_RATE_MASK	0x07
 #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
+#define LTR390_INT_PST_MASK		0xF0
+#define LTR390_INT_PST_VAL(x)		FIELD_PREP(LTR390_INT_PST_MASK, (x))
 
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
@@ -77,6 +80,11 @@ enum ltr390_mode {
 	LTR390_SET_UVS_MODE,
 };
 
+enum ltr390_meas_rate {
+	LTR390_GET_FREQ,
+	LTR390_GET_PERIOD,
+};
+
 struct ltr390_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
@@ -154,7 +162,7 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
 	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
 }
 
-static int ltr390_get_samp_freq(struct ltr390_data *data)
+static int ltr390_get_samp_freq_or_period(struct ltr390_data *data, enum ltr390_meas_rate option)
 {
 	int ret, value;
 
@@ -163,7 +171,7 @@ static int ltr390_get_samp_freq(struct ltr390_data *data)
 		return ret;
 	value &= LTR390_ALS_UVS_MEAS_RATE_MASK;
 
-	return ltr390_samp_freq_table[value][0];
+	return ltr390_samp_freq_table[value][option];
 }
 
 static int ltr390_read_raw(struct iio_dev *iio_device,
@@ -223,7 +231,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ltr390_get_samp_freq(data);
+		*val = ltr390_get_samp_freq_or_period(data, LTR390_GET_FREQ);
 		return IIO_VAL_INT;
 
 	default:
@@ -248,7 +256,8 @@ static const struct iio_event_spec ltr390_event_spec[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_PERIOD),
 	}
 };
 
@@ -396,6 +405,44 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_read_intr_prst(struct ltr390_data *data, int *val)
+{
+	int ret, prst, samp_period;
+
+	samp_period = ltr390_get_samp_freq_or_period(data, LTR390_GET_PERIOD);
+	ret = regmap_read(data->regmap, LTR390_INT_PST, &prst);
+	if (ret < 0)
+		return ret;
+	*val = prst * samp_period;
+
+	return IIO_VAL_INT;
+}
+
+static int ltr390_write_intr_prst(struct ltr390_data *data, int val)
+{
+	int ret, samp_period, new_val;
+
+	samp_period = ltr390_get_samp_freq_or_period(data, LTR390_GET_PERIOD);
+
+	/* persist period should be greater than or equal to samp period */
+	if (val < samp_period)
+		return -EINVAL;
+
+	new_val = DIV_ROUND_UP(val, samp_period);
+	if (new_val < 0 || new_val > 0x0f)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+	ret = regmap_update_bits(data->regmap,
+				LTR390_INT_PST,
+				LTR390_INT_PST_MASK,
+				LTR390_INT_PST_VAL(new_val));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ltr390_read_threshold(const struct iio_dev *indio_dev,
 				enum iio_event_direction dir,
 				int *val, int *val2)
@@ -456,6 +503,10 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return ltr390_read_threshold(indio_dev, dir, val, val2);
+
+	case IIO_EV_INFO_PERIOD:
+		return ltr390_read_intr_prst(iio_priv(indio_dev), val);
+
 	default:
 		return -EINVAL;
 	}
@@ -474,6 +525,13 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return ltr390_write_threshold(indio_dev, dir, val, val2);
+
+	case IIO_EV_INFO_PERIOD:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_write_intr_prst(iio_priv(indio_dev), val);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


