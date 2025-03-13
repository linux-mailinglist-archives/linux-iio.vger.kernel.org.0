Return-Path: <linux-iio+bounces-16792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B7A5FC9B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B737189FD6E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9F26AAA9;
	Thu, 13 Mar 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPYpQIDe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF7126C03;
	Thu, 13 Mar 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884675; cv=none; b=nJUC9OwaATb4LDOBilBR6aRyD0cbLfUOWQKPCD0oCKomhVCkFk/thacNgVQzMyiLUx7oHJpMPmTXjm9zogOJ4onAuyN08zDVKKrF8+iJ9HqrpFdI3E4sb2ztieEBsJZBSQHsPDHDqtKL+3whp3KJZwEjVN4hA2ZPC+CVINocKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884675; c=relaxed/simple;
	bh=9tXKDE1CnBDmZcG9vK7Y9pAUYZggjYpbTEVRUGfvE+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKe2NyID8Y4S8H0iVIuR2BAv2CbuA0CsbqCiBtzzGPxdvpcy0U2qd9TZytTTuXG6dpNkeI4fv0sHdWjyg8hgUiokfSM21ptebINmrggv9VzRMZkJme1BVCIRLdEfz/YVZ/peG/o2WCZSHAoaq6EwPi4YZ9An7tqxcSJRclsWtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPYpQIDe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac30d4ee128so10461966b.0;
        Thu, 13 Mar 2025 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884672; x=1742489472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMmC1rvIEkXaWS15upxpWMXmGh0jkxNvxi3wjmpL1yE=;
        b=gPYpQIDeGzNkH9CWb/YhMppAm3GpEWwIOJVvbkpycjolgPcdQ4LwOUspNZSJAZgKq6
         auRu5lcAGV9p6KNW8uM6brKXHhH4sFqgNpb2vj5xXK5W9+Z9xcAbTndXFoX8UGDN1d8Q
         ZM+JWPsrzboPcNb7MY/rJMrSoNhvkga4Zxer79iECZiInf0sf6pgAfEdWzIYEtZN8Ekj
         dhKA9Xve/mjr/bO7t2wWSuNgmibV1cRVsHlbhKTVUREzuv3Z0bdoffAm7eFiD3b67u3W
         nq8eM10nbk4aw9e/X/bwBw2FZShyjzZeHQLk46J6F/p3SFN61FE+SB7VqZXFyNiliz/W
         uhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884672; x=1742489472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMmC1rvIEkXaWS15upxpWMXmGh0jkxNvxi3wjmpL1yE=;
        b=eqSvS2ycTK3fATkX0ZsUuk927iNEC5d0BkUeU05tbHkjN5ptqPhbW+FgVEiXB8Wlki
         B9//LDuVgVPLCl+9JcvUMxjhStVC+QPXXVfpKFY6rbuHoZEDp+p5PUBC0FCSQPmaJojb
         k1O5Umd61RnHIZCv6urlZ2zZTrkuKAE+4zd6CNMZkeIDFiM0bgdkJXMnp46Dgjd/P/fV
         UkcdIcO62QQ89uzrUsG2skSeIQk+lbplQT3tJB3iAar8WvFBLy9IDpt9oWuJIqZ5YtTW
         Zx+5yjJflqMWuKnq4mH5qEnmZRxxAhpPpyKKZOzsVNFK4Cfrb09y+ka2MFhlPua+JUbr
         GR/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQxj7nOmJYyMWPlIZblTTyhn9+qqAmcPw8h4DGhrCa5SNF4da1yw7ADD+JR0sy2I1xWq4IWJMdebsvEag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9BLa+5jhRHm44O0lXAbE5l6EFRFBiC1mDDlOvFT17uc7I/Er
	mMTRFtUmoDtQIwO/LanRzyWTcXp1OKA9zcYn6MN8NS1rg+Wzz+vD
X-Gm-Gg: ASbGncur62CvtiamGNFLmM7CWlMWbI4oMzdxyjHhkOgVjYpq+j203lO1ohwYluFPhsu
	wGu44pzELBFEOUNwWuDox4Udn/icK4lAhqZdZJg+p0sb+bKYcgmjbKQvX3UvuU52Hpt5cv8SUGX
	dvI2fdQ1h/ReA1CcSIE3FhHYXqWvv6FUaJYuW85FaxSz6brRUDZeR1Rke96AkufKLS5vKCe4OqU
	aDGozhojff+8VwqtATADSq+HLdwP+uu7VMYdYU46sEZ9mAdq8JYF2n6zQGdgGTxAFSOyjV4IHeJ
	Vj0pQ0pCWeFAs+LcJI3TLfW1K65CPat/dXNutKTDGIV7od4SO/p7+uKUq6+bNYBXScGXIwMsrwR
	M5GCivNDHacmR6Qbjn5Lb5BU=
X-Google-Smtp-Source: AGHT+IFyZQjNLENno+J4b1eF76M6lraPWOq5QsXkRAovwqs0Vyp1eZq9nG17UlrDxqtjuHRXHDFC6Q==
X-Received: by 2002:a17:907:724f:b0:abf:663b:22c5 with SMTP id a640c23a62f3a-ac2b9e5ed25mr617884866b.13.1741884671607;
        Thu, 13 Mar 2025 09:51:11 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:11 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 06/14] iio: accel: adxl345: add double tap feature
Date: Thu, 13 Mar 2025 16:50:41 +0000
Message-Id: <20250313165049.48305-7-l.rubusch@gmail.com>
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

Add the double tap feature of the sensor. The interrupt handler needs
to catch and forward the event to the IIO channel. The single tap
implementation now is extended to deal with double tap as well.

Doubletap introduces window and latency times, both in us. Since both
times are scaled, the 8-bit register value is stored in hardware,
where the scaled value in [us] is stored as member variable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 100 ++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index cfdbc73c96b4..eae419cf8d0b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -46,17 +46,23 @@ enum adxl345_axis {
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
+	ADXL345_DOUBLE_TAP,
 };
 
 static const unsigned int adxl345_tap_int_reg[] = {
 	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
 };
 
 enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_LATENT,
+	ADXL345_TAP_TIME_WINDOW,
 	ADXL345_TAP_TIME_DUR,
 };
 
 static const unsigned int adxl345_tap_time_reg[] = {
+	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
+	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
@@ -69,6 +75,8 @@ struct adxl345_state {
 	u8 fifo_mode;
 
 	u32 tap_duration_us;
+	u32 tap_latent_us;
+	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -82,6 +90,14 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
+	{
+		/* double tap */
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -167,6 +183,7 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	unsigned int tap_threshold;
 	bool axis_valid;
 	bool singletap_args_valid = false;
+	bool doubletap_args_valid = false;
 	bool en = false;
 	u32 tap_axis_ctrl;
 	int ret;
@@ -187,8 +204,16 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	 */
 	singletap_args_valid = tap_threshold > 0 && st->tap_duration_us > 0;
 
-	if (type == ADXL345_SINGLE_TAP)
+	if (type == ADXL345_SINGLE_TAP) {
 		en = axis_valid && singletap_args_valid;
+	} else {
+		/* doubletap: Window must be equal or greater than latent! */
+		doubletap_args_valid = st->tap_latent_us > 0 &&
+			st->tap_window_us > 0 &&
+			st->tap_window_us >= st->tap_latent_us;
+
+		en = axis_valid && singletap_args_valid && doubletap_args_valid;
+	}
 
 	if (state && en)
 		int_map |= adxl345_tap_int_reg[type];
@@ -265,12 +290,23 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
 }
 
+static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
+}
+
 static int _adxl345_set_tap_time(struct adxl345_state *st,
 				 enum adxl345_tap_time_type type, u32 val_us)
 {
 	unsigned int regval;
 
 	switch (type) {
+	case ADXL345_TAP_TIME_WINDOW:
+		st->tap_window_us = val_us;
+		break;
+	case ADXL345_TAP_TIME_LATENT:
+		st->tap_latent_us = val_us;
+		break;
 	case ADXL345_TAP_TIME_DUR:
 		st->tap_duration_us = val_us;
 		break;
@@ -302,6 +338,34 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_DUR, val_fract_us);
 }
 
+static int adxl345_set_tap_window(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract_us)
+{
+	/*
+	 * Max value is 255 * 1250 us = 0.318750 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (val_int || val_fract_us > 318750)
+		return -EINVAL;
+
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_WINDOW, val_fract_us);
+}
+
+static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract_us)
+{
+	/*
+	 * Max value is 255 * 1250 us = 0.318750 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (val_int || val_fract_us > 318750)
+		return -EINVAL;
+
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -405,6 +469,12 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = adxl345_is_tap_en(st, chan->channel2,
+						ADXL345_DOUBLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -426,6 +496,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
 			return adxl345_set_singletap_en(st, chan->channel2, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
 		default:
 			return -EINVAL;
 		}
@@ -465,6 +537,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 			*val = st->tap_duration_us;
 			*val2 = 1000000;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			*val = st->tap_window_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			*val = st->tap_latent_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -497,6 +577,12 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_TIMEOUT:
 			ret = adxl345_set_tap_duration(st, val, val2);
 			break;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			ret = adxl345_set_tap_window(st, val, val2);
+			break;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			ret = adxl345_set_tap_latent(st, val, val2);
+			break;
 		default:
 			ret = -EINVAL;
 			break;
@@ -753,6 +839,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_DOUBLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_DOUBLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -875,6 +971,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
+	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


