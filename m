Return-Path: <linux-iio+bounces-18477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F05A958FF
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DC1896D28
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67392225A20;
	Mon, 21 Apr 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyEo4rQ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A21224894;
	Mon, 21 Apr 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273228; cv=none; b=jlLArs+Ew8BFEJSd/7IB5MQvO7ydBwGU63nRbVOyldEb9pCzMq9FwcBk+SE+IKquCh8BwCcePjvJJ6B9QD7V9ocanEeUkB6RqBjs5ECJDC6kf9J7AMi3CuR5bPchOpmPlRjwInyTGue6Db6JPL9Gaw5Db7hqXrRsjObLmn3692w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273228; c=relaxed/simple;
	bh=mbcERdFQQom/BTOHUff26fkRFKWLbyOhAi5VHByJqTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb1n38V9ry8J2UvdmWxE1E105f1zi5Z46LPH2r/5Kp/+IIAxwFBUjiUzTuJvi6vNX9lXqXz9maiw0tbmiBjvZxBoPlbezrf5NJY/95iQKW/hCV0MMTj6jVqPPBGHrPkxJ9wcwHYask8EYrQQB0CW38RrNZAEBCsLMnDI9ReM7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyEo4rQ2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac30d4ee128so62869266b.0;
        Mon, 21 Apr 2025 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273224; x=1745878024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdu0LdDj62KC+oWS88znCzXV1CP0ELp5VSRb6zCbXT0=;
        b=HyEo4rQ2QwLvxfva5+bjLcP5m4NYYi4WaNiBI46qoiPO8MECNwl2H24XgvwqUtTb6M
         lRl5Ht3iHZvriTc0jgzUbCYhJIBBfChvRnXot7rMblyRlbryzizmhMEaCshOaDiRSHJY
         pilXNDBGnb5oofDOYCtDzuvnHSF8CfQ0dN97JG32PvwA3SMOFtZ/DgQaXfZSyANACVCD
         Rtg6P9Jefpf5DttvhQSPJzNk86Pj29cGaB3NVwdr8kUQYXHN0H8tCbrA4nEU983KwWz7
         oFG+hr/QHPzRC1/yU367VCYjHBRw+lcnZju4ajwlzlgtpEuz1xZx2c9HNJMneJbcH0Xe
         qBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273224; x=1745878024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdu0LdDj62KC+oWS88znCzXV1CP0ELp5VSRb6zCbXT0=;
        b=wiL6XGCwMH1CCOJBJ5ojUiNNyPn6v3Rif2VwoVB2qajZ4bUz8kf5Fk0ygsebJUynoa
         +tHg88mys14xarCophE4bkHLmVoaUGdwHYEKzn5e+5yLr2rR/D1/d70Mb8bg8XkiyzI1
         einqMYtOKslsA3bRDmRnSQz1pQvf2ogispBEC21/3KBZZC9Zbiw9lm4wa9NIpqQUujN3
         DwFIQlKlfE2L11FbwuGn46JnfX+APEzIWXEbuZd5LF5zAOxRhCJMVvZIop42lyDRaYuo
         VtP0XbqFk0ETLAge8kjVYLD/uPxYCkBLpoFgldwCcBWJvqGparDR2Z5ScnaGQt5AHDrI
         U22A==
X-Forwarded-Encrypted: i=1; AJvYcCXQKOrOoG0NTlNcCQF0Cnmqx/2msqtqUMtRg07Yn22wR7KDFQuGGTG6w9aXIoUH0Wn7e1DhAwI+Gzv1unQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdgoKsBdvDx2dP77Xb0rbxtanG7+XqW6CSF//06eCtZCiTAmR
	4ADB52JKfhk19cjyz+pgkEfJum3mTUJcLR5hl3skOGZ1hvfmZffW
X-Gm-Gg: ASbGncuJmTtPHekjpVmtX813QLrC73qzyLbYWg3RDSsFO9CLxxZouUN6u9PPGsMAfh9
	zRxVkr2HI8ItUIXs42xGUmsrMK+rQC03YenhIxLni15YOxWMOhqj6j5E+WiUkY3vYDJCe/bk4zu
	WBWo0uk8tTjEyOS0Lvne+3s3TbXQ1aJrzxOWfAlql+Fqm4Z5jm5zWDXc9IGV/jnf10DTDi6NIFa
	trZ0DC3mWx/V+qb5sNM8pLQEbsSgJ/sTT2LwxDl1GuqLduEEhapcZ2N/8LkOM5hbIk3/kSqjWsX
	SviDoBf9idl6f2sBWbAcIQ6OJk51Lew3tLFL4+lmhO50PkgYUoju/aoGZ0VFY75BSHPNLzG5RCJ
	zRB4k8CY9NOk1qLDSLyMoNthpcxDTBw==
X-Google-Smtp-Source: AGHT+IHDnCL35LzEftESps1dx2w0AZDEuvmI8snCKPzT1aQCqtwrXOPbRoX+rcH6Lt6A5Kcmxnl0VA==
X-Received: by 2002:a17:906:ad7:b0:acb:b8bd:ddf9 with SMTP id a640c23a62f3a-acbb8bde169mr48690366b.0.1745273224054;
        Mon, 21 Apr 2025 15:07:04 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:07:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 09/11] iio: accel: adxl345: add inactivity feature
Date: Mon, 21 Apr 2025 22:06:39 +0000
Message-Id: <20250421220641.105567-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 172 ++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 680981609d83..b25efcad069b 100644
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
@@ -232,6 +241,16 @@ static const struct iio_event_spec adxl345_freefall_event_spec = {
 		BIT(IIO_EV_INFO_PERIOD),
 };
 
+/* inactivity */
+static const struct iio_event_spec adxl345_inactivity_event_spec = {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, chan_x, X),
 	ADXL345_CHANNEL(1, chan_y, Y),
@@ -244,6 +263,14 @@ static const struct iio_chan_spec adxl345_channels[] = {
 		.event_spec = &adxl345_freefall_event_spec,
 		.num_event_specs = 1,
 	},
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = &adxl345_inactivity_event_spec,
+		.num_event_specs = 1,
+	},
 };
 
 static const unsigned long adxl345_scan_masks[] = {
@@ -287,7 +314,8 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 {
 	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
 
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_MEASURE, val);
 }
 
 /* act/inact */
@@ -319,6 +347,21 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
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
@@ -338,6 +381,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl = 0;
 	int ret;
@@ -356,6 +400,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		default:
 			return -EINVAL;
 		}
+	} else {
+		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
+				ADXL345_INACT_Z_EN;
 	}
 
 	if (cmd_en)
@@ -376,11 +423,69 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -846,6 +951,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -890,6 +1002,9 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, chan->channel2,
 							ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -917,7 +1032,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
 	int ret;
@@ -936,9 +1052,24 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
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
@@ -1019,10 +1150,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1323,6 +1466,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
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
@@ -1569,10 +1723,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


