Return-Path: <linux-iio+bounces-17065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B3A68091
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37965424DC3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F42165E9;
	Tue, 18 Mar 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCSf/Tha"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDE215076;
	Tue, 18 Mar 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339349; cv=none; b=KVpmu3dMsBEO1MsfsRyjC4FBzLcZaThxvQBy86mRSjpK4GqIjGAUkLf/LQcJ/Tu2EDV5moBMccP+lvoUCbNOcjjbriVFbG+8ZOkbJ9B5+IFTgKApbyPzQzFPGD0nhK4BYWQgjOV1bjxN03226mqZvBv6NFSLrVjDbJfkFU4zCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339349; c=relaxed/simple;
	bh=xEXSbaibN3QHw05OQ3jieNg7GhHZ50nM21wzNuufd9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbIXN58GnDGi9SdMHmoQKXBWo7jyqLOqt8RzssCyF7CUkaUBe5qbhPJx3ynZ4SfyN5Em9aGfV9zkFO40ja4lsNkvMbs5sN3LiL7I3P+u4uH+AEZSQ0okT0DrnH69qHMWkSGgUESXUGxq8YcVEDWQzXDkm6vewekuvuocaNqJ55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCSf/Tha; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394944f161so2760235e9.3;
        Tue, 18 Mar 2025 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339345; x=1742944145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b2TleVB8YJe7W3d0ZwwgheLtzRt6Of/5V2RlbJn1LU=;
        b=eCSf/Tha68DutJydkGFrJSCfYiAc99K83CyYUJ3TDzKkyTLSG7WP0JzN8GaxLu72Mx
         yKKHksXmwGCj+1AiXfz6491entNc9Ntv4Mo9amX/tVhWdk0pW5yrIoA4ZLPv2TujwSa1
         XZVx2sFh1gqS4OJ7HS/45GQV7iMOp5PcdpSCWoZjTKYY1yVAhZebNxiC5sqerflp1vvR
         jYdw3YqIrrlCt1iMn7UOeWWkT2ljrYMlJHnLYCPJvxFoCgs4uzkCHRdtY7xy1MtbUFUt
         vbEXdGb7JRtxfR/6EEVJiwujjyqt7e1pEw5oECdv7q8yyYDm4IjEzFWCNvfl18o2KGc9
         MF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339345; x=1742944145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b2TleVB8YJe7W3d0ZwwgheLtzRt6Of/5V2RlbJn1LU=;
        b=fK6434pdy/Q0EbmpnOfOU5qwdZ5QOTf1S2jYlBveiM4sF1EVr5KA6ZudHQb1C3K4Il
         4OsAdvDtyKLS6OUJewRILF9cCAlk8akWHlxe2b+QbuTddLWi9ligFie+QFUCc5rWBLt3
         j3D36aH1RDwXfsJ5gPk1FXxfl9bzz/0EPja42n5stRqVlX6OlOu8rQRs0DZJyZXyRdyi
         zbl6gj79/dpebac4RSEKNibtuZOlCsWALzjHPTKV9RMLzpi60gh64I8+Tx68BbxP9zpV
         WzuMr+DLq/YByvGwlpMi/ObGvpQftOAKmmcpOENfyeJ9M7qbKg5wa1MAIAzjYz+jZiK3
         vyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUsl0eB7vZoYn8FZlVs2ePBNT7o6vaqn0OBLomsvbYjYth9mfxK5zzy8HS2+kED055PqKGgWZOTQtW5x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi5Nj7zs7N1cpcMy4g9LgAiRXSirayYbQc/bZ1PtaTXsXL1ff
	WUH9dQ5aAB5bro4sKPoU+zhmVxH9JqRGI0yjn8k+GYN+iSR/OoE7
X-Gm-Gg: ASbGnctoZ1fxduEhLm0wpP1fNQOpD47v9N5OnMkE0YGAL0Dj2bBd1VgP7jQCb700tvB
	MuyUuIXZIZZiWJExYfMPbtZr1GoN7r5CFVm9aw+1BCfPSGDwuhWQuXht1URvuOPLFx10craYLot
	4riFD5k289fVvZ2NK4hup1MkdwsRHyC1fZxUU0211rAxgcMbIRssKt8fuK3xUm0us0hRAJSebqz
	RGTkX/q+MQfpETH/xGUkAF41XG+9A0UtnZcqVOOpFW2U1fm3u9/BlPqKZs9E/rCPd/kLpT6nhBi
	q5ciyiI5H9frJ3SX+qqzo2ZsXg46IZFPLGrZI0ZZZxxGNpdCq+aeNECd4+Q6cw1I8x+4WT1zAFc
	Ro+779FztizwJ03sD3KJA8l8=
X-Google-Smtp-Source: AGHT+IEy6MGSCV76H7WwE1/cUWxziCST5LTp66OKmlbIIXot6bi/KXK7ud2lY3grOKoL5MWPQROUkg==
X-Received: by 2002:a05:600c:4fd3:b0:439:9595:c8f4 with SMTP id 5b1f17b1804b1-43d436c8539mr1221925e9.0.1742339345192;
        Tue, 18 Mar 2025 16:09:05 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:09:04 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 09/11] iio: accel: adxl345: add inactivity feature
Date: Tue, 18 Mar 2025 23:08:41 +0000
Message-Id: <20250318230843.76068-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 167 ++++++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6b8491202119..3b841032d41b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -37,11 +37,17 @@
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
 
+#define ADXL345_INACT_Z_EN		BIT(0)
+#define ADXL345_INACT_Y_EN		BIT(1)
+#define ADXL345_INACT_X_EN		BIT(2)
+
 #define ADXL345_ACT_Z_EN		BIT(4)
 #define ADXL345_ACT_Y_EN		BIT(5)
 #define ADXL345_ACT_X_EN		BIT(6)
@@ -72,14 +78,17 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
 
 enum adxl345_odr {
@@ -179,6 +188,14 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -310,6 +327,20 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		default:
 			return -EINVAL;
 		}
+	} else {
+		switch (axis) {
+		case IIO_MOD_X:
+			axis_en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Y:
+			axis_en = FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Z:
+			axis_en = FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
@@ -327,6 +358,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool axis_en, en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl = 0;
 	int ret;
@@ -345,6 +377,20 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		default:
 			return -EINVAL;
 		}
+	} else {
+		switch (axis) {
+		case IIO_MOD_X:
+			axis_ctrl = ADXL345_INACT_X_EN;
+			break;
+		case IIO_MOD_Y:
+			axis_ctrl = ADXL345_INACT_Y_EN;
+			break;
+		case IIO_MOD_Z:
+			axis_ctrl = ADXL345_INACT_Z_EN;
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	if (cmd_en)
@@ -365,11 +411,67 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (type == ADXL345_ACTIVITY) {
 		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) > 0;
 		en = axis_en && threshold > 0;
+	} else {
+		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) > 0;
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
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
 }
 
 /* tap */
@@ -829,6 +931,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_en(st, chan->channel2,
+						      ADXL345_INACTIVITY,
+						      &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -873,6 +982,9 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, chan->channel2,
 							ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -900,7 +1012,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
 	int ret;
@@ -919,9 +1032,24 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
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
@@ -1002,10 +1130,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 				if (ret)
 					return ret;
 				break;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+						   val);
+				if (ret)
+					return ret;
+				break;
 			default:
 				return -EINVAL;
 			}
 			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_inact_time_s(st, val);
+			if (ret)
+				return ret;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1306,6 +1446,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1546,10 +1697,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, 3);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_INACT, 4);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
 		if (ret)
 			return ret;
-- 
2.39.5


