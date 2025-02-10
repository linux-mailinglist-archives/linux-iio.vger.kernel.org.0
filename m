Return-Path: <linux-iio+bounces-15255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539ADA2EA65
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E97F188A680
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0111E5B6A;
	Mon, 10 Feb 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvXt7iwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C01DED6B;
	Mon, 10 Feb 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185305; cv=none; b=kmnmIQ03nkiR6QNyQp69q6BWpSmJq/l9pF+A/gTRLxp+HizVE70tgJ40tK521rF64Mi7kCkhxnR5+oNDGL17sTEwfnqqMkpTW0fmkPXzOWKyQI/whCL5jMLsUpfgxi5Cxkv8g+tDKpQyH+N3pzNNVF+Q8fZsb1AB6QQDhN/eFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185305; c=relaxed/simple;
	bh=/y7mNfhaGB/ariXDVvyTGgWYdXRldxPNT88Vr6y3RAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+AgxU+AGx110ECOlqnv9Qzy2rc7jsfT3bmfBKooOFGd5C115RrbZey4rMM3x9inhl1glMdM4qknNIjSXGovRsROgB0AFj9Bsopu0RGxECgeXyWh04uXvqKZ6YQao5S+5jgu00L54TTR3qiMYspDr6vYfpyBlRIZ0dSaBpGN7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvXt7iwh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7bc75e0a1so25211966b.3;
        Mon, 10 Feb 2025 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185302; x=1739790102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjRt6a7CPtNKaS1cR5u/H3ujmvzx1jBmmAENlUfwYtw=;
        b=UvXt7iwh3J09JrQAEEpxIgZ3YWzDKAPEKukrs41esyOlEnaJva/l1xdrMSq5uFf+bp
         XkyzCW8VVekvNdkGNa6tYKiTsfWYOf23AP0yiuqpi9BpYfiThLk6UP346D+/x5VAUvDh
         V4QQfY61SAx+CCe7VjXNgbjeWgTHG2MWwZmmgO5uttzYol1OnyOAuAunRdnBnc9hDld/
         Un2FmuDZr1fgAi6uH74dXpc2DK65O0ms/JR2qpVPRLDbcrAt2ij2jvS6CiyhXqKCGLnZ
         ELZSMGL4iD0Q4MO2ICoPeuNnQKGehipeuAkGTII1a4ftPcYLcQXw4WlFStgci60Ssi8S
         ra/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185302; x=1739790102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjRt6a7CPtNKaS1cR5u/H3ujmvzx1jBmmAENlUfwYtw=;
        b=eXJQpJUKA/u6/Z7cmYJGUiPK9nSNgkTBQDlDrSQHODHTAvNCbD8zUKTCAyI4G4DA6R
         mnZwbbmdijPaA7rbxOZjBvnAcMtOHOEevHcejD/vPyUdU7q2n07bewr/okRPsHz922jZ
         px5Ik/wmf2MOZTU/hJxgoDOFtbBFpztHhNrrRHqUjjw1tyyBO8nvuve0D9zVfD3qYMBl
         iXB7gSPkzAsbz+JR5IgZF2hwNh99qzmJaa9cAlKfQcD9XY5jEEsgF3rVT5X8rlNndoxH
         nU2DY6dHtYewPgCsv+yu5RvXdKNAadPyV4Ou16ooq6a3CqDehddW3baAGowGLv0So0X4
         W2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXYz/CRqCa9RL91aTEctrLCGhGvk30ITw+zc0jnUJt15oMZgxe9XL4c1udZL1Lp24XRTme1sYJmgbzdbTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMfs+SQGcPxt+NxTRQ7nlHqFbw9hU/d08NM9ijUuejOM77+YW
	rdh+obRzTdIYbmhL9b0u3oDLqz4/ppfjo/VJaALt1E7MLELC9G3Y
X-Gm-Gg: ASbGncvupv1iM9BGmbSJtKPB9X9rXTNLoqGGflZbryglBP+Cvij4+gwJR2XSxMacuzA
	cDCSNg8PFFwehvvgJrMN1bA/SdBwGw0OXr3ttgsCiVP7HT4NvdN6Yy17/GerKBK4kUicFScsahC
	OecBcrgAW2+/eek3XGavb0GY2ITb1AnLxWkOutzmSqnlC5M6dLAJIvmc+GiL0Sk41TUx5IpxK5r
	XgSumTSUOWfralJ/SZNSzZQBW44IqWGsoE09RK+Aj3jlx7a9hVzISLA6Lfh1TMHo/7lm/zUGzrv
	qt3y+yA3sA/BfBJLMAY+N2BIyDl70NDpIMosZtBS24PM8YpTzl7NYA1XxC6E3juzOZhWiQ==
X-Google-Smtp-Source: AGHT+IHaPbuitP8xm0ecTUWkh8xi/HrRNIf3CggRcGvS6rdpWF1Z9Hg/vbZ7BDj5hOJn3p4MaiCOOg==
X-Received: by 2002:a17:907:1c84:b0:ab7:ce20:5394 with SMTP id a640c23a62f3a-ab7ce2185d2mr52209066b.1.1739185301868;
        Mon, 10 Feb 2025 03:01:41 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:41 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 08/14] iio: accel: adxl345: add freefall feature
Date: Mon, 10 Feb 2025 11:01:13 +0000
Message-Id: <20250210110119.260858-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the freefall detection of the sensor together with a threshold and
time parameter. A freefall event is detected if the measuring signal
falls below the threshold.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 118 +++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b6966fee3e3d..56c5a4d85d71 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -84,6 +84,9 @@ struct adxl345_state {
 	u32 tap_window_us;
 	bool tap_suppressed;
 
+	u8 ff_threshold;
+	u32 ff_time_ms;
+
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -104,6 +107,14 @@ static struct iio_event_spec adxl345_events[] = {
 			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
+	{
+		/* free fall */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -354,6 +365,68 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
 }
 
+/* ff */
+
+static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_FREE_FALL, st->int_map) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
+{
+	bool en = cmd_en && st->ff_threshold > 0 && st->ff_time_ms > 0;
+
+	en ? __set_bit(ilog2(ADXL345_INT_FREE_FALL), (unsigned long *)&st->int_map)
+		: __clear_bit(ilog2(ADXL345_INT_FREE_FALL), (unsigned long *)&st->int_map);
+
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+}
+
+static int adxl345_set_ff_threshold(struct adxl345_state *st, u8 val)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
+	if (ret)
+		return ret;
+
+	st->ff_threshold = val;
+
+	return 0;
+}
+
+static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
+			       u32 val_fract_us)
+{
+	unsigned int regval;
+	int val_ms;
+
+	/*
+	 * max value is 255 * 5000 us = 1.275000 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (1000000 * val_int + val_fract_us > 1275000)
+		return -EINVAL;
+
+	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
+	st->ff_time_ms = val_ms;
+
+	regval = DIV_ROUND_CLOSEST(val_ms, 5);
+
+	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
+	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -479,6 +552,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		ret = adxl345_is_ff_en(st, &int_en);
+		if (ret)
+			return ret;
+		return int_en;
 	default:
 		return -EINVAL;
 	}
@@ -517,6 +595,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -553,6 +633,18 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = st->ff_threshold;
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			*val = st->ff_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -591,6 +683,18 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			ret = -EINVAL;
 		}
 		break;
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = adxl345_set_ff_threshold(st, val);
+			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_ff_time(st, val, val2);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -934,6 +1038,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return -ENOENT;
 }
 
@@ -1041,6 +1156,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	st->ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5


