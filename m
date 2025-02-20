Return-Path: <linux-iio+bounces-15834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A2BA3D713
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB993B0149
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B01F416B;
	Thu, 20 Feb 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsZwSzjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746781F3B9E;
	Thu, 20 Feb 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048169; cv=none; b=rMaSpoPQlgkfHvTr3KWQMh4yt4mXkvmO4quSxEoewUPagNqzHHOJKiMl9GZ198VgniQ5dvbPDVyawq+Lf/X/NfnRpf0DfzUBY0AIGyxkb1W3pyGO0gVFuTbto4WeRHQjblOVQ3yqnCCTiIhN2JjEGoMBrqs9T2WFlL9PIX8dEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048169; c=relaxed/simple;
	bh=L39niv7e4NppXWE6tN4Vx0S2ojeN4AEe+yM+KuPTEkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnjsvkGI+4a6LuAHBd1gyf6pxQJe48XpwEOMGoH/EEnOgWEBONx4POaG+/PWu4XqUorTyMIOuk5ukY/OduqIdtQv0sG5Vi3X/++SwPN/RmWdWvpcndyDdxj2XApDHkI5LVTKrsxnyzEY6SruAD7yMKfcAy8+SVnyDD8lOYwDVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsZwSzjh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7dd005cb0so10750466b.3;
        Thu, 20 Feb 2025 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048166; x=1740652966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta+2FU81zc6EZR7Nqtyxx9EdNRilRxxat+p3vt2mhcA=;
        b=lsZwSzjhD5khyCmZpAUkoEpnKj7SRM2IMVeKR24nySOSYyP+4vyHWkd2yGs/gLPrOU
         BCfMGrotmQAr3L5IJdjU/RFNDBeXucTVMODhQFh3cM0t9qCZ/RCXTGofaIoHuqs16mnC
         Bv1I5wtxzy1cOKFCt10HiWU9MOqDJjkf+r/LMTAhjAa/51k1QWBpwP1nvyG7gw3I8TAS
         jcEy/L8HT82pryDE0jKfaxezU1Twe5pOwaQEKL14/G0orqk/k7qRPYoUfEic0LBYNXoN
         5hOVnnds8mK8OIhzFxun7j67ts8VF19GcXyFKV2jCm9Lil4/XmEq/RTewD5fBK4WL8/B
         YZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048166; x=1740652966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta+2FU81zc6EZR7Nqtyxx9EdNRilRxxat+p3vt2mhcA=;
        b=NUU/Pk4G5vKS+lenjhAeK6xK7FIjsc1ipNyyrN+Y+EqapAxnRGOaCqu4PC+8ckbtVO
         OAMmkG68NMeXTLR0MQFWCNNr61Eb/3hIIjMwZH1Y3NmDaMo3EAMw3YZSxsuXjauHwAwc
         JShs8KLn9+G2lZALVu0YiXf42I3sO1OLco330txYUzmcEeC1a2lbXVynlX5rjIuasXzN
         Vudsb9UNacfcYWz8qTmA7p24q5/1DerSnWOxrONe3I36te9A0VDY9vVvnWeGMbUcAUVk
         FU+IxULkAeEVCdwuoNvzndsqoX84WgfDPvs+xulLbG83WmIJWOgg5UJRUShSEoZZW24a
         WqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPYn+7sBA8cQQuGj94dmg4mGzru3ZUtY2X9ci6k9DwQv2SDDE66vMcTKWRf3H5wqWrUUJ8HvN66oPqhmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeNoVbpy+Y+Wk3ebXqFtVO+7jpAI7zvuht4HqxARc6FeEl5hA
	Ocaq9LjebRlUkRTKOiUd8g1FuOixwyx+3XSArPLmRVxyLlgz4zuTMIYBTJgG
X-Gm-Gg: ASbGncu0qO13r12YncOgsQ48HfJ6Bza1UkD03s9+VLCcktZEEPy+wRov9QaDMXwRyA3
	NAQoyE12OWUdStLjhhHtS/mAuDtC0iE17znOM4BK+LpCBHs9VLwJMN95cLN0gLDyEQxrTRjbIv6
	WG4wyvQthEC/Fv4avHkunziPJxz5czO3Do2+0xnfaJMldj8m/LrQN3hLEgQE1DdQVhWKTxnYkY5
	58miiYt2Wbu5FUGf9NZnjIUGh1s4zahelJhHt22WAbbTR7allbkUkMsMCEIS1pfAUaCSEVeF4kb
	3Rau+C5MjTVtS1imGDa48+mGjVvnTPYFiKXBHi/cxXajf2b3+ijAcL2Jl1a+KTHdpASpVw==
X-Google-Smtp-Source: AGHT+IEfYnwAWlvQ6iXKy35YFsF9pSZriJsMvYRoYjH6QF5UZTSZ0qCwUEZ0SX2Vd8QxG03ChK4FsQ==
X-Received: by 2002:a17:907:9494:b0:ab3:2719:ca30 with SMTP id a640c23a62f3a-abb70dc5ca3mr812164766b.10.1740048165367;
        Thu, 20 Feb 2025 02:42:45 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:45 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 07/15] iio: accel: adxl345: add double tap feature
Date: Thu, 20 Feb 2025 10:42:26 +0000
Message-Id: <20250220104234.40958-8-l.rubusch@gmail.com>
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

Add the double tap feature of the sensor. The interrupt handler needs
to catch and forward the event to the IIO channel. The single tap
implementation now is extended to deal with double tap as well.

Doubletap introduces window and latency times, both in us. Since both
times are scaled, the 8-bit register value is stored in hardware,
where the scaled value in [us] is stored as member variable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 99 +++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d05593c0d513..c014bdf84e66 100644
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
 
@@ -70,6 +76,8 @@ struct adxl345_state {
 
 	u32 tap_axis_ctrl;
 	u32 tap_duration_us;
+	u32 tap_latent_us;
+	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -82,6 +90,13 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -180,6 +195,7 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	unsigned int tap_threshold;
 	bool axis_valid;
 	bool singletap_args_valid = false;
+	bool doubletap_args_valid = false;
 	bool en = false;
 	int ret;
 
@@ -195,8 +211,16 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
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
@@ -232,12 +256,23 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
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
@@ -269,6 +304,34 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
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
@@ -387,6 +450,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en && axis_en;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = adxl345_is_tap_en(st, ADXL345_DOUBLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -424,6 +492,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
 			return adxl345_set_singletap_en(st, axis, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
 		default:
 			return -EINVAL;
 		}
@@ -460,6 +530,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -492,6 +570,12 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -747,6 +831,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_DOUBLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_DOUBLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return -ENOENT;
 }
 
@@ -862,6 +957,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
+	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


