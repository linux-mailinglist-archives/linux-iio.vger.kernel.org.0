Return-Path: <linux-iio+bounces-9593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7459792E7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50849B21F10
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7421D31AC;
	Sat, 14 Sep 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIkwuz2T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3431D3196;
	Sat, 14 Sep 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337629; cv=none; b=lwB9ChvGYIvgHC7skWPEw4a5334IR+oqEn4VSURVlATIeJMCS7vIiZp1w9rnEHEWd9W4AhrODTp5Dbc7Fi6YNJt6zRkJ0Ofr6ocdu70wKFvCaxrnvJsJP/Eof91owtD3eDw5214uBw9LUyXddjbCn1CGvVqe2O4y81bCFhbaSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337629; c=relaxed/simple;
	bh=Qw6txWVPdZ7FgDvn4pS7WGFdIcv31Wh2+xKLWxH8g3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoduutVATFGaKNy6F/R84tAWUUdFLiXE9rami6W5sP5zZMPwonrdllAh6YmScA8rxj4mvspNjZFNxUKRGcW8eMTgvgViWpQrIcYlYHXh5vu8kaupH9XysdV4dYrtmWy8OzMkI4o2fhHDKdUMxRKNsdpAjEY4k8p5VgAsbcxGCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIkwuz2T; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20573eb852aso28071015ad.1;
        Sat, 14 Sep 2024 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337626; x=1726942426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=028JaGJ1ahArc8EOD+3vvYERpoxcW3WW4Or8S3HILb4=;
        b=SIkwuz2TH0kp5RMPptdxst/x+UkFQlOcQqIHDloQqDRYKSUyRbtUh+FFY3ZX6fwEYR
         m1qOJecOfQqWpcGyThmiSQT+PG1OemrA+LmC/pp1pNHOi/6pyerDqY7o7r4iswn65GvR
         5Y37CcM1G+3nVn2vGe3N25syj/ccshmKC6fQqiyM8aa1mjtl/VMAzWn+VtFnM1eC8oWS
         40Jz7qcVkWil600DPBZE1F/qzQWAPujcNc07qm/ShM5p1UbAhsVwMhbrCV8IKpkDNJBr
         5cuHsL1vFTuRXQlMpOgoIedDrMl2JFsU1zNXElheMapZe3xQbfSNV4U9rm1O1O2s+t7Z
         LA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337626; x=1726942426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=028JaGJ1ahArc8EOD+3vvYERpoxcW3WW4Or8S3HILb4=;
        b=c7Ya3T/seDopYVFJUT9c4GyBy/wZyl2hbSfcGVyszDcnSKCMhvy56kP7GqBLD8YLVl
         ZE69csnxnZAZIULt46v0duKDIA7NXmpF6JrvXLlzCU/N7XAamBfApYHIY2cBv0tOXbSm
         SqOGBctmIdP537l83hhuYv2JwPcGpagt3AhWRGyvYxfG4ZakP3V0iS/dBXR3O/MIumlr
         4EB01HxCtZuDpnAtpBLgfifZvQA3v9MEZNfMfwGk5lr7SBfQ3kqYS9f/FRij7e76oA+t
         n8W2Rw6oRsUpUW6uxg6nlF2zSUPyd3ksT6Cbkn5FH56PbC3ltbeBovRErgbIacWEzO4K
         2/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWfF/yEehsTwMRYyfAZVswLn3xBK+vkvStG0gJY6Mz/9/75BSFD8Pr/uubY9bD+g8vhw5nveZcjjBsPIms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcBRUg+UM8sqgEZbv4I9VzVQwp6TwiDGJ1lTKdWNVq5JwJTyc
	WyDBNBPL4OjOxvaRp3zOPeq3VmS3R+xzFVW0uUgRqbZrsHdW7lvZ3gxmIstivdM=
X-Google-Smtp-Source: AGHT+IF7DPpO9UMOZdwoydrcnG4dGInQk2kuK5Z6EZkb0Su3KwkpSd/qTrIfDI56nTkKN0A+j6XXgA==
X-Received: by 2002:a17:90a:62ca:b0:2d8:9fbe:6727 with SMTP id 98e67ed59e1d1-2db9fc1adabmr15562659a91.4.1726337625752;
        Sat, 14 Sep 2024 11:13:45 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm1830870a91.31.2024.09.14.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:13:45 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 4/4] iio: light: ltr390: Add interrupt persistance support
Date: Sat, 14 Sep 2024 23:42:46 +0530
Message-ID: <20240914181246.504450-5-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 65 +++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 57bf48595..a51ad6704 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -41,6 +41,7 @@
 #define LTR390_ALS_DATA			0x0D
 #define LTR390_UVS_DATA			0x10
 #define LTR390_INT_CFG			0x19
+#define LTR390_INT_PST			0x1A
 #define LTR390_THRESH_UP		0x21
 #define LTR390_THRESH_LOW		0x24
 
@@ -49,6 +50,8 @@
 #define LTR390_ALS_UVS_MEAS_RATE_MASK	GENMASK(2, 0)
 #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
+#define LTR390_INT_PST_MASK		GENMASK(7, 4)
+#define LTR390_INT_PST_VAL(x)		FIELD_PREP(LTR390_INT_PST_MASK, (x))
 
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
@@ -80,6 +83,11 @@ enum ltr390_mode {
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
@@ -157,7 +165,8 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
 	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
 }
 
-static int ltr390_get_samp_freq(struct ltr390_data *data)
+static int ltr390_get_samp_freq_or_period(struct ltr390_data *data,
+					enum ltr390_meas_rate option)
 {
 	int ret, value;
 
@@ -166,7 +175,7 @@ static int ltr390_get_samp_freq(struct ltr390_data *data)
 		return ret;
 	value = FIELD_GET(LTR390_ALS_UVS_MEAS_RATE_MASK, value);
 
-	return ltr390_samp_freq_table[value][0];
+	return ltr390_samp_freq_table[value][option];
 }
 
 static int ltr390_read_raw(struct iio_dev *iio_device,
@@ -226,7 +235,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = ltr390_get_samp_freq(data);
+		*val = ltr390_get_samp_freq_or_period(data, LTR390_GET_FREQ);
 		return IIO_VAL_INT;
 
 	default:
@@ -251,7 +260,8 @@ static const struct iio_event_spec ltr390_event_spec[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_PERIOD),
 	}
 };
 
@@ -397,6 +407,44 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
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
 static int ltr390_read_threshold(struct iio_dev *indio_dev,
 				enum iio_event_direction dir,
 				int *val, int *val2)
@@ -453,6 +501,9 @@ static int ltr390_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_VALUE:
 		return ltr390_read_threshold(indio_dev, dir, val, val2);
 
+	case IIO_EV_INFO_PERIOD:
+		return ltr390_read_intr_prst(iio_priv(indio_dev), val);
+
 	default:
 		return -EINVAL;
 	}
@@ -472,6 +523,12 @@ static int ltr390_write_event_value(struct iio_dev *indio_dev,
 
 		return ltr390_write_threshold(indio_dev, dir, val, val2);
 
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


