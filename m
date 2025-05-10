Return-Path: <linux-iio+bounces-19414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF17AB25A5
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E539E4AC4
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBB220F20;
	Sat, 10 May 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ13ox0z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F721ABCC;
	Sat, 10 May 2025 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917086; cv=none; b=P+6tRS7j01usYWZgT2h4GFHsUMZPwBMxm+CefbhBSjXkMcv2IX8r/b8P/0u1gy4DspOS8eDoX8eGNp9dfUgqgK6kkBoI+IBeYy2zFMMF5/dV5ahGJKk9UVOJ7trSFT63qcPKN3LpuBM8YJGXdpl9/Hu7PPE0jEgqg7r3YK2t6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917086; c=relaxed/simple;
	bh=MOr4IvKGTgebHvHbJUV8wyvXIn/RXs57ZZld6zmaP8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXeyrDhgRfp7Pf7Lfw23p2gGwVmQTL77jgOSjO/2Lwte0aPk1+tiP649KNLmW/hyPQQvW022HejVuBifU3VIiJCcg3BEOU1RSOJdoynwuUmG81J4HBkRapLLqAOw28tWFx4nAAkAE16vk7xdpBbs4KoSDmGtZLO8lcaar2K8TKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ13ox0z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43f106a3591so2535505e9.3;
        Sat, 10 May 2025 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917083; x=1747521883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4h8GiUaOKYcTZ9vWZ/7AJmF0EHHcuCYihbQ0AxbIKc=;
        b=YQ13ox0zSdoW1SzX5OcrO831bRzEiKlpdDKlRaL4OTNd1sEZQ642p7kJ91VYdZiELR
         mPMe355kWpm3o070K0opys8LXDkRobCzVLYoDq9+duklfeGOfuAvneKrqIGDEeEztgZm
         OHQ4bqge6pbMUh9KPgHuMrsfmAxsy5LG+81/WzKjqCIaDHXxcYSxLjdA4U10+2LE6D+v
         EWgNq1ZpnjwanYZUnjvhFv4RWl15LEi7Fr6jfwwX8hvAJaR6gp5rTj0SvLOvW3GSXP2R
         xImotJx3OPCmZy8ryNhep4uwDdfetmxEF/GFtsvP3uC5/f1BR53oUUKDiC1Tr3GC2/pL
         BIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917083; x=1747521883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4h8GiUaOKYcTZ9vWZ/7AJmF0EHHcuCYihbQ0AxbIKc=;
        b=ubvCuxjSWCcm70D0NDQe+zV0pNwwmcN6a+uYP9FBT9fapzto6xgMIZzZKM9+nuZhAO
         icuoBVIOEm4Zu+aCuheCcHg8raPmYKuMUwG/ay4gFmvOaT/QW4c7se1JFMTH4shTZ54K
         z/S4TWftYBEWUIkVckFvh7SZDSGmx+S6q4MlzSiq9m5VElKecQh3pn+oki8OM4wnxD16
         WisrN44s+F3ZLu0Ks4DWzxrn6yMdp9lMOpXftR+wCA2jrwjT7TzwrILsvdy49VLLZQ6p
         xo3M7WVyI8bG+7UyHEvtajJyP1oMyjySC/jdj/qxDKgM8ENlJfAPckQk9jLBjkfZ/SkT
         mo+w==
X-Forwarded-Encrypted: i=1; AJvYcCWfUN/kBkpG5e1og9/lNWt72dMRr56Y5e7yRT4j/dvXTGuAPf7X6jHF+o00q+RNaPq2JlxlrR06NrxzDo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdx+1H6DZdA8vz5kg4bhXX+2t5ALj4Kul5iBZsM2LvldOmzoZ
	rZOyeCzoTK4qKFfgFNWxo8gM12/GXMbZVD6CyFM+RORBf3MQTxBx
X-Gm-Gg: ASbGncstx+NwTewcW3undRP+kLREa6Gg1gxUO+uMDEI50yIAyno2VBfVjJYAoCZlxy2
	6IH6a41gWdVf0CHFlKg0Fqq02beOcFv5fyrepZaXNp8JTxx5GuWWI7paPbNcWu1pSOoewj6weBh
	qHkYpkO4uMLLstiGmyH97iXGbBjlbZUm1Ymi22dEvyretLLA9F56/saNW9Dz2nTAUFY2V7WG7aI
	eC8WNhYlgxPif5jVnpd1PU5QX4Gri7qY1T5vmInvOyix+wuYXym+w6tB2kYOz9P+QQa7aaKS9mN
	VwHTrtuf/Wktd+HjEku9LI8hqmk25ohpLMsC+fG1yjqLM1filgsbgNt3O6eNJGPsAcP30nQRXah
	O0JI+2AZW9I1x27VK3hUTuw==
X-Google-Smtp-Source: AGHT+IEjHAyoBSW9B3IOrRnr35cA07ZWrvs0kjyIbxP1bTpt3GMGhgofdY0TSoKFGwt3WRS7+P9Gog==
X-Received: by 2002:a5d:6489:0:b0:3a0:7d47:8d7e with SMTP id ffacd0b85a97d-3a1f643eb5dmr2019422f8f.8.1746917082882;
        Sat, 10 May 2025 15:44:42 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:42 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 4/7] iio: accel: adxl345: add inactivity feature
Date: Sat, 10 May 2025 22:44:02 +0000
Message-Id: <20250510224405.17910-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 176 ++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 32d014bd1e52..ba68f304035a 100644
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
@@ -214,10 +223,29 @@ enum adxl345_chans {
 	chan_x, chan_y, chan_z,
 };
 
+static const struct iio_event_spec adxl345_fake_chan_events[] = {
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, chan_x, X),
 	ADXL345_CHANNEL(1, chan_y, Y),
 	ADXL345_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = adxl345_fake_chan_events,
+		.num_event_specs = ARRAY_SIZE(adxl345_fake_chan_events),
+	},
 };
 
 static const unsigned long adxl345_scan_masks[] = {
@@ -261,7 +289,8 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 {
 	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
 
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_MEASURE, val);
 }
 
 /* act/inact */
@@ -293,6 +322,21 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
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
@@ -312,6 +356,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl = 0;
 	int ret;
@@ -330,6 +375,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		default:
 			return -EINVAL;
 		}
+	} else {
+		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
+				ADXL345_INACT_Z_EN;
 	}
 
 	if (cmd_en)
@@ -350,11 +398,69 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -763,6 +869,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -803,6 +916,10 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 			return adxl345_set_act_inact_en(st, chan->channel2,
 							ADXL345_ACTIVITY,
 							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY,
+							state);
 		default:
 			return -EINVAL;
 		}
@@ -828,7 +945,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	int ret;
 
@@ -846,9 +964,26 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
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
+			ret = regmap_read(st->regmap,
+					  ADXL345_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -913,10 +1048,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1201,6 +1348,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
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
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -1432,10 +1590,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


