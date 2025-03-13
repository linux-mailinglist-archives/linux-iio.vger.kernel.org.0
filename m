Return-Path: <linux-iio+bounces-16798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB24A5FCAB
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB1C16FFC5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0126AAAD;
	Thu, 13 Mar 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZRofeQw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281ED2698B8;
	Thu, 13 Mar 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884681; cv=none; b=SFbjfgu3BMO2Ku6A3aKgtTf/rxPMhoMRrhndpnziOXWsnV/z3n4PYaL7Ntc10eI4qoExosKm0cmC753UqlEisrGlQkZ4l9HPqXbJiSUm8TFO8RltOHfdiaqwSWSvfsmCgt/2BQSzXzDJOyovO7Oqbs1sE1QIVzBDJAp2/xrQ77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884681; c=relaxed/simple;
	bh=M6t6mlQ1igVk0UXirkHCfi5PtaQYamY95PHjcgPOe7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdUhDKAUFf0hdoh4KxrkyndhL6kqY/0O1EDmvB+HHs+jOVu+fUkeoEZhkj1JxxAKbyezK5UHNd+qyhUsSrIUdoiJiVAc9Wit//kVIwi9JDBm+jykNwiD0XcYKd9DQVKb2KmEDaOcJTMHQCCkzCWPS906VpL6WsBJ8ppndSdtD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZRofeQw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2b8830e2cso16109366b.3;
        Thu, 13 Mar 2025 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884677; x=1742489477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlD6NtdRlPIXybja5Wb352sxVITMXlChHaEZC8CxGjo=;
        b=gZRofeQwWnRBBJeVHyhNFQpLwh+Vfh18Ml9cf2GoOefV4ZPvJBJAi7PxP/qB2m5cC9
         dyJCNJTMIAj5zTEFDqEzIaNaM21MEjIApZjOD/uHyUyv3m64gEGrvCHCkdzOXbpI/EKg
         bEZgHXgB+jOvWE9pFPpn/tTSYcUyouhDu1q5SUhMq1S65yixkHLfkuyErVFrsYkKLMie
         BywRIfUyW6HuC5f4LcVFdQTiv6uMhAm/nWMPXwCvORqy79+TZXZOZ2QStaSjXg4jjEX4
         w4NR2ldRM3xymvvVli8bgKHpoxHog6R33xQa+Or4vHfkyPfnTdC8exj/JBGg85U0xaAW
         BGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884677; x=1742489477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlD6NtdRlPIXybja5Wb352sxVITMXlChHaEZC8CxGjo=;
        b=ea5yXZV5xgRrCWpAovi7rxYCTw3LUk/AN5TaGQTlQHcjd4EarncX/+HzqW5k9dmouV
         jZ1LNvQKmvcmO4goTL07gLtgdyeUZczmB8HsmDGb+8EP2iaNz0JQ0ba6zRPZorKq2xwv
         7TneBfBICbCXEi/eCuLxX8rQ+c43MfeO7Ycg8vbvo6lAohwlnXaYCJb8iAyfBl94emxA
         GCbHsiu+GWxxIzLNUTxThFMCOfWPodRgWz59XimhCeaxsvqgSiE+OyS0rtVT3QJaRHLC
         nNt6hX2TEYZuiZTPL4pGTOAQwY98TUBrDXJy9uXV5932eSEehbSJ9CT8VMd4E9s153UU
         //DA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2B4LAkUHJSewK/T0wd9Bi809OcOjgZsAZEo90uLD2hahEYUNipjNJH25xvstXkBuYQiyVoHxZalLVRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfapzc7OGU0UG/MQR83K0y//URA286Deru5axgLnQ7AAqSXjRJ
	I8+pPvVNcU9sUI26+9V4vMFgyADfVSxlanXbdL1H6R8ouEa18qdX
X-Gm-Gg: ASbGncsznZsCEjCVG1zPLubusV6GKvTy6u/VMd+7g2FzXTZOXy21xNP3UKHoCh1LGPE
	tyLkCEWq8sT5or6YGBGfpPT3BSEj+i1NaoEPwsEeDOVmy2p//Perys8IlJeggA37zj3Z6UG1/kk
	W0oGd6bL4F1rH/7rIjbmxPJ36mqtvSU0BVhI07UPCfxZZ2H6wMwBRUD6RcRs665BfG93cCRQ5PI
	WJXk7zWkRWMQwYWPhpi3DDRCFB5Mwpc00slo6L9beiA2ZrhjN7gkcdloELpeRhtd8iw/ya36xca
	wXsxsGt/UUZQwS8dLK7uyYOkwDhvMsS5hZifxuUko+/2rK8OSFuatq1iNNPVurY3gGT5gdMMzZL
	LMwBQi1OuFtwWrtieEk1LNLs=
X-Google-Smtp-Source: AGHT+IG2BeFIvvcdHPLelY/Mnf6eRHtTxUs/pQsRDFjxP98eeR4wpl3FtmdFbil1KaTziY1zfS28fw==
X-Received: by 2002:a17:907:7b99:b0:ac2:1d34:44ff with SMTP id a640c23a62f3a-ac2b9cfc3fbmr651085666b.4.1741884677022;
        Thu, 13 Mar 2025 09:51:17 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:16 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 12/14] iio: accel: adxl345: add inactivity feature
Date: Thu, 13 Mar 2025 16:50:47 +0000
Message-Id: <20250313165049.48305-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 132 ++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 98a781987b63..c718d529d897 100644
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
@@ -182,6 +188,14 @@ static struct iio_event_spec adxl345_events[] = {
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
@@ -333,6 +347,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool axis_en, en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl;
 	/*
@@ -379,11 +394,67 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -855,6 +926,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -899,6 +977,9 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, chan->channel2,
 							ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -926,7 +1007,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
 	int ret;
@@ -945,9 +1027,24 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 
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
@@ -1026,10 +1123,18 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1327,6 +1432,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1569,10 +1685,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


