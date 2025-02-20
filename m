Return-Path: <linux-iio+bounces-15840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0CAA3D727
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D817B9CD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE11F63E8;
	Thu, 20 Feb 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0fgLmdu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED551F428F;
	Thu, 20 Feb 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048175; cv=none; b=HXiG+JPOPNJZ4sHPNHgInzRyvJrQ7Uhg8sNgaUCcjDUvCKCcvDJBEZ3DeZjKvKyKTq3QfF+dAgr5oA8Hro6734qCAVoVVqLfbEcDHKFQtRy87gz5laeny/AZc2jIw6viT3xPjQnH+MdS70XCjVLNZVky4JWHVi7NzqDwLKX5eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048175; c=relaxed/simple;
	bh=xvyhb3hgiV1rOvFtBrj2iSKtA/DZrOVcxHIESnw0vCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ckhp9dkOWUgsVlf0D1PlYh2tyjtiXxR4FEOV0BNm+3Gh6LP3qeut9xxuNja/9Co5rDZt5VF/C7AsC3WRB71RQ3TGN5XDiosbNHKueabpnYYVXbStK/2vKI2+qvMxfvkSB16bGb3C3nEpv2//Fj9GptgDhmwHTswqXl9cBnrHKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0fgLmdu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7f9f57192so10752466b.3;
        Thu, 20 Feb 2025 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048172; x=1740652972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrAbvaoVsJFBJDRNcyUkhf7FE4bWAv22MmmOmYXI+24=;
        b=S0fgLmdumG1lK5VLd3bCPe70akmKNsvTImHvqx0lnpltFVH7lyO4HvaAsDo5JVxyRi
         aYd/+GWXVtz3yxKQIYoAzkpFN1ANxi9Tz89bSf3l2FXr9ZBL20mbe60ksH1xFj1roaXS
         bc0ShgKN1NwpNN4tHvWIvhnjoImvD48LxRMH+PlGBtembpjrfEjuZIRm6PtDc22s1xDD
         gllIS1IvTlMXgqblCydeymtxCLbX6quji4JQrBGvwt3Vv6WpH8+OzFDRkRAvx02YCsRh
         iKWdl6ZG1qgM0XDlLWsfSEl+BpstAPaTj7g2vGCQOkSib1cmy8hWlgc99hdHkfCkM0vp
         T9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048172; x=1740652972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrAbvaoVsJFBJDRNcyUkhf7FE4bWAv22MmmOmYXI+24=;
        b=QsMdgdfMd8RN6qNhBIUiQtzzGgbRqjhXGCzxDCvrH4lgI0w8ya1S/v/kMirOb5q6J5
         nQJJM1PmkTsXJKyzruyoZHVMBU3MWkpG3ZWbF/iUYE8e+KjK2Ug51HzMTZlXLGcLHSXF
         c/shIJWNG+nXl8QJyNfudgUJ6patiJfhih8X3NpLFGM6x7AKz80A6Vb8ql/B8NjHWhTi
         sGXV7xkfFA53sgD7p8aCc+R92yPrSLJFSplSQsj1Xs5yvDCJGoMUzTsMG88DJ5pakpOJ
         sxce37OBgqtXyMcsONI3W7rvh6XSthgK+NJkikXeMMPjNi893iN1LykAc2LamvmsaHrv
         msPw==
X-Forwarded-Encrypted: i=1; AJvYcCVAIhPjenrjXeHnRg+R6k3t7wnUOfqhsxlf5ZLS6Q80d16vGxsHEDJUUm+v0rhwdu0gtA0cniHfXv/9tV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1n+Z7CXk2X+LsERu1X7hKboKfXn8zyijvpXAq/Br272yNNAI
	k+dq9i8xujB13JpyezQH9vOaDMMzIkVC2PsccSMjwNF77R0PpHAqnQqLaxdJ
X-Gm-Gg: ASbGncuklSdl1405MqWunEIl8BK6K5L7w30+vFvj4jjpbKsY3kOcsYBRBtmol7El6Y4
	jRU9XTy13zyoN0/GMQBxaoIPGFwnjh1gBoNCXhnMkrNDu+Gzr74dO4/0uTkThxpnfqT0tLH6aF8
	8l5O7CaAmmqFeMDPb7QENg224SuxB2qbiTK5jsro6fRsxnaPOEkowaeHOHCgKT7CZASDKHHeIj6
	/op/BUVXCj208WrZXkRilUeOtzyYYO4BIwkGybuKT3QjxodSdOhv8vT9xMAclN0bpwAEw5l7F55
	CxN2PnD+GfeguIHDsDgviZ33lEC1VXC9yXwQEtrfbWsiLYMKMSzmXU4gAXTrW7dOgoHbnQ==
X-Google-Smtp-Source: AGHT+IGcKQkGABAIpldGYILpIGiAuPBvrOMtnYwQYYfg1Z6+0BJ30vvbzay7EjyveqcJYj/doWJP+A==
X-Received: by 2002:a17:907:d8b:b0:ab6:58e4:4fec with SMTP id a640c23a62f3a-abb7093370fmr829379966b.3.1740048171473;
        Thu, 20 Feb 2025 02:42:51 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:51 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 13/15] iio: accel: adxl345: add inactivity feature
Date: Thu, 20 Feb 2025 10:42:32 +0000
Message-Id: <20250220104234.40958-14-l.rubusch@gmail.com>
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

Add the inactivity feature of the sensor. When activity and inactivity
are enabled, a link bit will be set linking activity and inactivity
handling. Additionally, the auto-sleep mode will be enabled. Due to the
link bit the sensor is going to auto-sleep when inactivity was
detected.

Inactivity detection needs a threshold to be configured, and a time
after which it will go into inactivity state if measurements under
threshold.

When a ODR is configured this time for inactivity is adjusted with a
corresponding reasonable default value, in order to have higher
frequencies and lower inactivity times, and lower sample frequency but
give more time until inactivity. Both with reasonable upper and lower
boundaries, since many of the sensor's features (e.g. auto-sleep) will
need to operate beween 12.5 Hz and 400 Hz. This is a default setting
when actively changing sample frequency, explicitly setting the time
until inactivity will overwrite the default.

Similarly, setting the g-range will provide a default value for the
activity and inactivity thresholds. Both are implicit defaults, but
equally can be overwritten to be explicitly configured.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 140 +++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index f1895925a80b..40ec06bf2090 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,6 +36,8 @@
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -71,18 +73,22 @@ static const unsigned int adxl345_tap_time_reg[] = {
 /* activity/inactivity */
 enum adxl345_activity_type {
 	ADXL345_ACTIVITY,
+	ADXL345_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
 static const unsigned int adxl345_act_axis_msk[] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK,
 };
 
 enum adxl345_odr {
@@ -167,6 +173,7 @@ struct adxl345_state {
 	u8 fifo_mode;
 
 	u32 act_axis_ctrl;
+	u32 inact_axis_ctrl;
 	u32 tap_axis_ctrl;
 	u32 tap_duration_us;
 	u32 tap_latent_us;
@@ -184,6 +191,14 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
 			BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 	{
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
@@ -307,6 +322,17 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
 					 st->act_axis_ctrl);
 		if (ret)
 			return ret;
+
+	} else {
+		st->inact_axis_ctrl = en
+			? st->inact_axis_ctrl | ADXL345_REG_INACT_AXIS_MSK
+			: st->inact_axis_ctrl & ~ADXL345_REG_INACT_AXIS_MSK;
+
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+					 adxl345_act_axis_msk[type],
+					 st->inact_axis_ctrl);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -330,6 +356,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    enum adxl345_activity_type type, bool cmd_en)
 {
 	bool axis_en, en = false;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	int ret;
 
@@ -344,11 +371,71 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (type == ADXL345_ACTIVITY) {
 		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
 		en = axis_en && threshold > 0;
+	} else {
+		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, st->inact_axis_ctrl) > 0;
+		en = axis_en && threshold > 0 && inact_time_s > 0;
 	}
 
-	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
-				  adxl345_act_int_reg[type],
-				  en ? adxl345_act_int_reg[type] : 0);
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				 adxl345_act_int_reg[type],
+				 en ? adxl345_act_int_reg[type] : 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_INACT_MSK,
+				  en ? (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
+					: 0);
+}
+
+/**
+ * adxl345_set_inact_time_s - Configure inactivity time explicitly or by ODR.
+ * @st: The sensor state instance.
+ * @val_s: A desired time value, between 0 and 255.
+ *
+ * If val_s is 0, a default inactivity time will be computed. It should take
+ * power consumption into consideration. Thus it shall be shorter for higher
+ * frequencies and longer for lower frequencies. Hence, frequencies above 255 Hz
+ * shall default to 10 s and frequencies below 10 Hz shall result in 255 s to
+ * detect inactivity.
+ *
+ * The approach simply subtracts the pre-decimal figure of the configured
+ * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz are thus
+ * ignored in this estimation. The recommended ODRs for various features
+ * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.5 Hz and
+ * 400 Hz, thus higher or lower frequencies will result in the boundary
+ * defaults or need to be explicitly specified via val_s.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_s)
+{
+	unsigned int max_boundary = 255;
+	unsigned int min_boundary = 10;
+	unsigned int val = min(val_s, max_boundary);
+	enum adxl345_odr odr;
+	unsigned int regval;
+	int ret;
+
+	if (val == 0) {
+		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
+		if (ret)
+			return ret;
+		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
+
+		val = (adxl345_odr_tbl[odr][0] > max_boundary)
+			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];
+	}
+
+	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 /* tap */
@@ -785,6 +872,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -842,6 +934,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -884,9 +978,10 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int tap_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int ff_threshold;
-	unsigned int act_threshold;
+	unsigned int tap_threshold;
 	int ret;
 
 	switch (type) {
@@ -903,9 +998,24 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
 				*val = act_threshold;
 				return IIO_VAL_INT;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(st->regmap,
+						  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+
+				*val = inact_threshold;
+				return IIO_VAL_INT;
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
+			if (ret)
+				return ret;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -981,10 +1091,18 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
 						   val);
 				break;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+						   val);
+				break;
 			default:
 				ret = -EINVAL;
 			}
 			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_inact_time_s(st, val);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -1282,6 +1400,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
@@ -1426,6 +1555,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	 * setup.
 	 */
 	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
+	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
 
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
-- 
2.39.5


