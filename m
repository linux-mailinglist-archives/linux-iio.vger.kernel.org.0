Return-Path: <linux-iio+bounces-18114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40DA88B9B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256F43A8FA9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977102918E0;
	Mon, 14 Apr 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HextjZeN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974228F53F;
	Mon, 14 Apr 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656182; cv=none; b=XO4Ne+aAEvEIdspBBK6vog1RTFIGmEyaiuWbxZvrYWD7DkKPk3blQfnMEy1jKgS9mMjQnhETUQupJO3eR3QZJHENQTeblkJLcuwyZYoHLI/1cLZgSAvAS1N84diQEsWc5YI99VqUuqJdbP7uH+K5tcEeUKljUPyjzd7SE1nXaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656182; c=relaxed/simple;
	bh=YOMlR7TdCyBNlhGj7tRjjFT+MWcgByluqM+7PRgGt/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nniAYPOeaEL+MdicZ/WrNdYpZu+kLKrp4e1jok27VWeJOeYwcu4ACfJhYoaX27SFgAHv49+J597GGsbxwocXCH3lt1wk6GAy393ooAC/YrSwpjiPgF3me0gU5IZ3wMHjM9d7U8PHiq+8mSHINN5QpPIg6eNcomi0yBcGFOto7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HextjZeN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3beea7762so82843366b.2;
        Mon, 14 Apr 2025 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656178; x=1745260978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdFDpOvEMqCrv1jBxgIkIT+BVlSneRjafPjX/IRKJQc=;
        b=HextjZeNB6SWGvzZuCB7P+h4I5wuRdj2wyQVk/zF23x/AvlDcnIhgURogDlTTU1Tf0
         iZkPwLFZ9T00L0Mxsbs6uXk61AQOlZ9OHVcEMa3lIIBoA3GtuG+JBDnoogstuz84/3Hc
         9VvaYWbdBVjdZMUUy58E1U61XDJ43JWuG3KFjRl4OHhnnXxzWq0gSBNaMKp80I/Gm2KM
         uJsu2NN77mG4KtoeavYVcgRxEvjKjTkFhCh1J2b8FW1FJs5DVqhix7TUG3ag0E2LUddB
         AE9PM+X4WaNF1OaSAA9l+YUD6f3RFR6fbpNvY62qpIsewIQ7+H5T9M9Kqa5JP2GI5BLV
         jJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656178; x=1745260978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdFDpOvEMqCrv1jBxgIkIT+BVlSneRjafPjX/IRKJQc=;
        b=cjb+Fvu2EatXrtT6NGlrOSWqwQ0QoFx0pWH4ISTnCo1mkhHtLuACDGSXoHrybw4YWV
         PrdzlcH0/Ti5TGmvRHr2ykyoIRUbqefk0qLKi4shghK5Y1KC2GVTlGm2IuPuvk0L75ic
         jPuUvX0fxWNirYv4wDbYnA0gKKG2LHpPjLQ0yPum28eO/TQ6cwL40jca/EUPyCgXieQb
         i01PHYWeL8rHwXdFYsjNJPfJoS99tgS8jWZZhwMUQwTooIO/a+AxYyL87SSZowpa6A4/
         aHijcNZrcRJ5DQ28XQl1LcBEDHpx0pzmwmCJogkCrmjhj3HUBUiJ1fMkmsFYFQp9vQAo
         30SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdjDpyY0M/Ozf0l6EN1HMLucip1FnCiPdtDImyYZ9kXKvn0sazFs56TKgEIlWDiBbfUdj7aH07InGWoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsJ8yXvo4TyBUNkuVMBSyGAh4yeuR2yvr5ysL5X7XnxlmP0Fm
	+pMjubCsSCtaMMtNjtbEmCm78OSGn+Oyd8E1yvPteSWu83M/HT5d
X-Gm-Gg: ASbGncu1leNhM2FtTHObzFXuOl7sIDfq+ohUv/qdl0gHvku/nv6YBiLGF2wpKHMN1o1
	JCU3eeZwuHuCktXHtVJLvr3m55D79IpnDuSjlo1GnMWT8F9pS8lCI/b7uNR8OrTE/0slsT/D9k7
	tpnhQVsroe7xrEtSK/387cS//yQAqY4DZAOmNolDQlU8pWVw8kbR5RMB/XInZTwbYhhxJQ+RBsJ
	xiS/K3SMIpDaMeGq//ccVCkaE++f5zgPMHwGFUfpqyuGtmIu/XtPIxfg8YJSCgCLC8l3ozkEnM+
	zhSkLoZFVbuhuakg+HmuKxyB/QYShr/itQ+Z7aFBVYfpj/JN7EnP0yC91ZssdDInrCc60etLGNR
	vZCqCD7bpYxyM/HR3QT8=
X-Google-Smtp-Source: AGHT+IHyRjmAnf8m11PxyvJevvgCOrZKVW+VjblABI98nub3tQK1gsn00VNEMiVOLp5pTCCMjVEbzA==
X-Received: by 2002:a17:907:c8a8:b0:aca:bd09:3cf2 with SMTP id a640c23a62f3a-acad36a1dc6mr394448966b.13.1744656177993;
        Mon, 14 Apr 2025 11:42:57 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:57 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 09/11] iio: accel: adxl345: add inactivity feature
Date: Mon, 14 Apr 2025 18:42:43 +0000
Message-Id: <20250414184245.100280-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 173 ++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8f7ea3928cf8..06028eaef9e0 100644
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
@@ -278,7 +295,8 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 {
 	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
 
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_MEASURE, val);
 }
 
 /* act/inact */
@@ -310,6 +328,21 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 			*en = false;
 			return -EINVAL;
 		}
+	} else {
+		switch (axis) {
+		case IIO_MOD_X:
+			*en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Y:
+			*en = FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Z:
+			*en = FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
+			break;
+		default:
+			*en = false;
+			return -EINVAL;
+		}
 	}
 
 	if (*en) {
@@ -329,6 +362,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl = 0;
 	int ret;
@@ -347,6 +381,20 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -367,11 +415,69 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (type == ADXL345_ACTIVITY) {
 		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
 			threshold;
+	} else {
+		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) &&
+			threshold && inact_time_s;
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
+ * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
+ * is configured by a user, then a default inactivity time will be computed.
+ *
+ * In such case, it should take power consumption into consideration. Thus it
+ * shall be shorter for higher frequencies and longer for lower frequencies.
+ * Hence, frequencies above 255 Hz shall default to 10 s and frequencies below
+ * 10 Hz shall result in 255 s to detect inactivity.
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
@@ -837,6 +943,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -881,6 +994,9 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, chan->channel2,
 							ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -908,7 +1024,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
 	int ret;
@@ -927,9 +1044,24 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
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
@@ -1010,10 +1142,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1314,6 +1458,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1560,10 +1715,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


