Return-Path: <linux-iio+bounces-19625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350EABAFD3
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AA97AC18C
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA521D5B0;
	Sun, 18 May 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRSGYkP7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA021CFFF;
	Sun, 18 May 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566829; cv=none; b=pePQfd4+U5+3N9Un/xNVgfTSBlVt8U3zpm02ZCjhT0zoyFvnC88MFcB65Cp/jEsYSSgp7uMvesaYGDq1KGZCEn01M0bx7fNrW/QHlc0XamFPNO4Nr3O3byAo5ALt4D2Oy2lsDzWGxgx9GmtUYURvL7e2u830qHTsxrmz4C99kBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566829; c=relaxed/simple;
	bh=KKviicaxEyRszhNConiqY0Fii1eydJiHO1yqeCIIVu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWbOcJYcHodJi0AtiP5U/LHuDLSfO+jpaQXmOll0DOW2SDzq4cchc+mpKVHjQDulS2JAR6CVnYTGuRyl4vncu6sfIH1MFSP4Pqv2iOyfORz4M70NgjUT04SgJbX0kFwdn0KHL5+SXidAjKGB2tj0d7iVzBIyRCRM5J10wAvWgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRSGYkP7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a35c339e95so344832f8f.3;
        Sun, 18 May 2025 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566826; x=1748171626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpJq7+q3FiXWjTp65V9AsxgFiWezFi0L+3hZ3O5uTco=;
        b=eRSGYkP7qv1JlejbvypsVp3s2w979b0nAHH/A7xWBk0/FwHCHfrNo6hRbuQGhHLMTD
         FShO/+6xjc+Kyp377ofDdP4rlhuMOHSqDXfNeOlfbb+NYV8uAAg/6rxbzl2QOK1/gZ2s
         ql7/M0vLFqNPWC/Q+3E/WfF89KmiPIm9z1Uwc3InKXQb1HHCGq27Mu9GE4GJx+dCT8Tk
         1XnherP/O6zPxLhAE9pSJZR2dy22r45YGM6znuqqs00ZOVdhp+JNRetfXKfroahyDi+R
         5TeixUHwjiB7xF8DPahkKx35supFago+SbK5yoYddtQ3j0Fa1PkqqdA2wyIzyYKjCBeh
         reIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566826; x=1748171626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpJq7+q3FiXWjTp65V9AsxgFiWezFi0L+3hZ3O5uTco=;
        b=P2hQwQaKo4j1Bc7cEBizLEAvFgvZhu+Jb7X9ija7pWIlWWTEJG5WjdV0IlInlM9Ts7
         QYrfWrjZ971RcWBQkDB5oiQWS3bjTUdXSL+6PupeSb05m37KnEdi0gtxQn/aQjpCbpD8
         hRgwzyVutPV2vrWApPt1x6aT/JEIttmHMpCrWw/DHx18uALeIqdWU4BI3RRwx6xsh3vg
         mfpqsMQOH/+Rka96aN43sKOQtSu7Td/gZNfhLMgTkHOxn2BSBSjrWbTKe2tirP6J2wwF
         +UebXoruabGTstZAt2piku6L2L/8O0lAD7FNItGSrhddYkZa9ghSBlNwadiYVxfSx3qc
         f+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWu5aonXxYBKG5kFo3x1a3XzgDhPU+eVJEhWAsNJ6je26CwSEFGUbARwhhXqAYHJnAuTo9bj80oq8U=@vger.kernel.org, AJvYcCX+qZeIKikCJtIeTqQrGVAIrW26mhDwdycBSX7+KS3WoTHOJIvfrOlnBdxs8zrnxPphYcrnZ7dq7gLk2KFR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2R2nIR73hvFiFkjved1E8zUMUck+R/3UL5EwO7Md62uvzltyn
	mkAlrcdVQnbyRkqfnDR4corL+dUA94dLtv2lMzkCjEnHxOJZDcSaWtFj
X-Gm-Gg: ASbGncsmMmVoGnBA+pBE7zM4LkeAh7oFqT3MqLd9fQY+Rxp7DGM6hxbDoLl7YUNBq5D
	mGo5Fk1CKeXPotzmllyph17MSEsCkoRFM6iKiJxdIYRgfCuSXPdNGqylpaPTUINjFIScTww6tQk
	NEhT8iC4lsP6mXxzauR8ubYYwFVPiXUhsWABsrS+NZ0qvfBP9czB5oLrnOt04mJUBD2BsaurSZC
	sGvppq115v548w2BFT9VijIKIErIFYRLztIArA8hku/MVIzP4I4s9WSP+Uk9snbrbk08bjcJunr
	HxhuyZAfYCEf0Wu9MJrN3lAmM1vbkshj7W0OvKL8fQCZWxLI53+MgGsEz6m6M45QXX/TEidKEdy
	MP+QtYqhFU85Say2wFjWXyg==
X-Google-Smtp-Source: AGHT+IEVpR8JwtDxTlXRMvp7mogyeJeEwrrQUA6Q78+qFxENwy6zdRLUs8nZtoFVA6E6i/y0Sc88DA==
X-Received: by 2002:a05:6000:2405:b0:3a2:133:b1a4 with SMTP id ffacd0b85a97d-3a35c852925mr3103045f8f.13.1747566825646;
        Sun, 18 May 2025 04:13:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 10/12] iio: accel: adxl313: add inactivity sensing
Date: Sun, 18 May 2025 11:13:19 +0000
Message-Id: <20250518111321.75226-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the interrupt handler to process interrupts as inactivity events.
Add functions to set threshold and period registers for inactivity. Add
functions to enable / disable inactivity. Extend the fake iio channel to
deal with inactivity events on x, y and z combined with AND.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  2 +
 drivers/iio/accel/adxl313_core.c | 98 +++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 9c7aedf7da7a..1398ac54d19b 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -18,6 +18,8 @@
 #define ADXL313_REG_SOFT_RESET		0x18
 #define ADXL313_REG_OFS_AXIS(index)	(0x1E + (index))
 #define ADXL313_REG_THRESH_ACT		0x24
+#define ADXL313_REG_THRESH_INACT	0x25
+#define ADXL313_REG_TIME_INACT		0x26
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 49914ccc92cf..46ca30abc7fd 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -28,18 +28,22 @@
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+#define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
+	ADXL313_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -254,6 +258,14 @@ static const struct iio_event_spec adxl313_fake_chan_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 enum adxl313_chans {
@@ -334,6 +346,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_inact_time_s(struct adxl313_data *data,
+				    unsigned int val_s)
+{
+	unsigned int max_boundary = 255;
+	unsigned int val = min(val_s, max_boundary);
+
+	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type,
 				   bool *en)
@@ -350,6 +371,8 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 
 	if (type == ADXL313_ACTIVITY)
 		*en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+	else
+		*en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
 
 	if (*en) {
 		ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
@@ -366,13 +389,16 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 				    enum adxl313_activity_type type,
 				    bool cmd_en)
 {
-	unsigned int axis_ctrl = 0;
+	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
 	bool en;
 	int ret;
 
 	if (type == ADXL313_ACTIVITY)
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
+	else
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
 
 	ret = regmap_update_bits(data->regmap,
 				 ADXL313_REG_ACT_INACT_CTL,
@@ -387,8 +413,15 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 
 	en = false;
 
-	if (type == ADXL313_ACTIVITY)
+	if (type == ADXL313_ACTIVITY) {
 		en = cmd_en && threshold;
+	} else {
+		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		en = cmd_en && threshold && inact_time_s;
+	}
 
 	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
 				  adxl313_act_int_reg[type],
@@ -487,6 +520,13 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case  IIO_EV_DIR_FALLING:
+			ret = adxl313_is_act_inact_en(data,
+						      ADXL313_INACTIVITY,
+						      &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -510,6 +550,10 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 			return adxl313_set_act_inact_en(data,
 							ADXL313_ACTIVITY,
 							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_INACTIVITY,
+							state);
 		default:
 			return -EINVAL;
 		}
@@ -527,6 +571,8 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int act_threshold;
+	unsigned int inact_threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	/* measurement stays enabled, reading from regmap cache */
@@ -545,9 +591,26 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 				*val = act_threshold * 15625;
 				*val2 = 1000000;
 				return IIO_VAL_FRACTIONAL;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+				*val = inact_threshold * 15625;
+				*val2 = 1000000;
+				return IIO_VAL_FRACTIONAL;
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap,
+					  ADXL313_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -586,9 +649,21 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 				if (ret)
 					return ret;
 				return adxl313_set_measure_en(data, true);
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl313_set_inact_time_s(data, val);
+			if (ret)
+				return ret;
+			return adxl313_set_measure_en(data, true);
 		default:
 			return -EINVAL;
 		}
@@ -747,6 +822,17 @@ static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -916,6 +1002,14 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(data->regmap, ADXL313_REG_TIME_INACT, 5);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_INACT, 0x4f);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
 		if (ret)
 			return ret;
-- 
2.39.5


