Return-Path: <linux-iio+bounces-10870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C819A693A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8FF1F23EBE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535B1F8915;
	Mon, 21 Oct 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZKhUeS9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE31F7074;
	Mon, 21 Oct 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515392; cv=none; b=LXz6pSOL4mOn4HOf5g6AZTU70EV1hacjsJPyoeXqfcrY1UxaZ8nWW+NsRgnS677OlrxeFt0weVKdnzokEmUpiZy8UTmuPTAq/N4Ox6tT/KBhK/zWltZGs9dEL8eyz9F+OwLW9kswqt1W3IzFY+Pe0yLBGLO1Y0qeV3ek3JTkqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515392; c=relaxed/simple;
	bh=QdYDXg+F9crN+GcA1VSjP47ejtoSADQbLgM8+WYO3yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeMNP4dZvL0JgwqJaXTsNNKC+kxmgcLy7ZocBHf0hrzHUwovepWrpxaO5J40JyBZvD93hbel/dygf+qkHhhLR3J+kI4SDco8f8obnp3KelmmpLk93yTmx7j0krhmyDt34BDa2h7gFWzfih2EDIfJPZdOKhGrItP5v+mknfER/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZKhUeS9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43161c0068bso30493535e9.1;
        Mon, 21 Oct 2024 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515388; x=1730120188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=XZKhUeS9P3Y3CoBlmhHWpilI/q5A65sHVeFSmfUgBtvw5ZmiWr+NDYKc+l2XqOW62u
         wI/Wn4iDNy767InY3NMdvez2QHE0GaTekIkiAYUmzmsu342rL/EGJcDUk0N1Sj5tnOxd
         NsIvoP0bCyyL39J3v7bJEFJSAK4AABJrF472bPLX91PmdnlRvm7qH/oSrQccYrCyV6l6
         0Icg9WxmWn3QdWObQpe5/ywAFMr8hTjKwLYSecUTy/r06A5LZDKYkUym5qWSo2va/wCI
         rny7mhQBw3cLq4oHgIrlGWhyaHA5t2zgZc8zmgSXTC3AvlLZ1cYSbPHVzdzFRuiSeE/l
         Yyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515388; x=1730120188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=SyydGuP0daHuvcvSPdlCbsOg0hnJtjjhz/nw5IY+iEEtWxCVWG3ZJNS5voBwiKgM4V
         kIfNCeAFFb4H3A92lXylumfeM47jxO60vBZB2Fdh3hvSeG5QRmozGC2pR2Hic6SFRwm7
         ISIrRCHGH8xuEChqIZfjxreFWn5+Gkya31rLuGCkHGBL7QY6ycx1RfAFyk8sV0gR4iKK
         QIyh/FX6VyJ6D4TEMCj7qkaCNsS05SF3r4Br13FfULg4EqLBTQHGFuB+gr4WFSKJDktE
         iFfYaM2xWhKlCZmlfjPQ02Qg+meC2i/G7sMuf1abR49yjtgfeRcliaJiJiMYIhr1ktiv
         F77w==
X-Forwarded-Encrypted: i=1; AJvYcCV0kB80zSgRMsULY+xOrb9yzle4g1AUm0vk5k1MJkg8Wse9CRYhEBEVgTpI+SIOYZao9ob8M60R0lLtAtI=@vger.kernel.org, AJvYcCWjBPSgINgQQSbe+XAQKZ4vOpQk2tlLaNjB4Iy+XYYf71Y9VrKnDM+uiBGplIc38G4gz3DR8ibXtzE=@vger.kernel.org, AJvYcCXZcjHmhLdt+41s/UZ4Vs8LqftgDROz/h6c5IQ8T5cu5zAad+mLoKCxZ/Vu2K+R2Dt215aWFd8Il4GrVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9DHkGPoAKm+XzMHciwgMT9tb/kT5jDji3U/Z5Jgcrt0zjQu5
	+r6mZ49Fy8jGphnpl6IC8xsJA6rD64eph6w0HtFhGwnsYPyNAMbG
X-Google-Smtp-Source: AGHT+IHTdxFJmJrGfuZiT2KuSOoWNJzMyoctKdk4/SqZcCw1YvqBxoJO2n9iIQAHSDbEp9dsgXBrIw==
X-Received: by 2002:a05:600c:3d9b:b0:431:5bb1:f088 with SMTP id 5b1f17b1804b1-431616a35dbmr94325905e9.29.1729515388025;
        Mon, 21 Oct 2024 05:56:28 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2df7sm56628355e9.33.2024.10.21.05.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:27 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 21 Oct 2024 14:54:16 +0200
Subject: [PATCH v5 3/5] iio: pac1921: use read_avail+release APIs instead
 of custom ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iio-read-avail-release-v5-3-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The pac1921 driver was exposing the available scale info via an ad-hoc
ext_info attribute instead of using the read_avail API. This to avoid a
possible race condition: while the available current scales were being
printed to sysfs by iio core (iio_read_channel_info_avail), the shunt
resistor might have been changed concurrently.

Switch to the read_avail+release APIs now that the race condition has
been addressed.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/adc/pac1921.c | 128 ++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 83 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index a96fae546bc1e6d1bf3a0dbe67204c191d77a3ee..f6f8f9122a78d1b5e63d8184203eb3dae55eb560 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -444,11 +444,52 @@ static int pac1921_read_avail(struct iio_dev *indio_dev,
 		*vals = pac1921_int_num_samples;
 		*length = ARRAY_SIZE(pac1921_int_num_samples);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS:
+			*vals = (const int *)pac1921_vbus_scales;
+			*length = ARRAY_SIZE(pac1921_vbus_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_VSENSE:
+			*vals = (const int *)pac1921_vsense_scales;
+			*length = ARRAY_SIZE(pac1921_vsense_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_CURRENT: {
+			struct pac1921_priv *priv = iio_priv(indio_dev);
+
+			*length = ARRAY_SIZE(priv->current_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+
+			guard(mutex)(&priv->lock);
+
+			*vals = kmemdup_array((int *)priv->current_scales,
+					      *length, sizeof(int), GFP_KERNEL);
+			if (!*vals)
+				return -ENOMEM;
+
+			return IIO_AVAIL_LIST;
+		}
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void pac1921_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_SCALE &&
+	    chan->channel == PAC1921_CHAN_CURRENT)
+		kfree(vals);
+}
+
 /*
  * Perform configuration update sequence: set the device into read state, then
  * write the config register and set the device back into integration state.
@@ -748,6 +789,7 @@ static int pac1921_read_event_value(struct iio_dev *indio_dev,
 static const struct iio_info pac1921_iio = {
 	.read_raw = pac1921_read_raw,
 	.read_avail = pac1921_read_avail,
+	.read_avail_release_resource = pac1921_read_avail_release_res,
 	.write_raw = pac1921_write_raw,
 	.write_raw_get_fmt = pac1921_write_raw_get_fmt,
 	.read_label = pac1921_read_label,
@@ -805,88 +847,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	return len;
 }
 
-/*
- * Emit on sysfs the list of available scales contained in scales_tbl
- *
- * TODO:: this function can be replaced with iio_format_avail_list() if the
- * latter will ever be exported.
- *
- * Must be called with lock held if the scales_tbl can change runtime (e.g. for
- * the current scales table)
- */
-static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
-					  size_t size, char *buf)
-{
-	ssize_t len = 0;
-
-	for (unsigned int i = 0; i < size; i++) {
-		if (i != 0) {
-			len += sysfs_emit_at(buf, len, " ");
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
-		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
-				     scales_tbl[i][1]);
-		if (len >= PAGE_SIZE)
-			return -EFBIG;
-	}
-
-	len += sysfs_emit_at(buf, len, "\n");
-	return len;
-}
-
-/*
- * Read available scales for a specific channel
- *
- * NOTE: using extended info insted of iio.read_avail() because access to
- * current scales must be locked as they depend on shunt resistor which may
- * change runtime. Caller of iio.read_avail() would access the table unlocked
- * instead.
- */
-static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
-					uintptr_t private,
-					const struct iio_chan_spec *chan,
-					char *buf)
-{
-	struct pac1921_priv *priv = iio_priv(indio_dev);
-	const int (*scales_tbl)[2];
-	size_t size;
-
-	switch (chan->channel) {
-	case PAC1921_CHAN_VBUS:
-		scales_tbl = pac1921_vbus_scales;
-		size = ARRAY_SIZE(pac1921_vbus_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_VSENSE:
-		scales_tbl = pac1921_vsense_scales;
-		size = ARRAY_SIZE(pac1921_vsense_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_CURRENT: {
-		guard(mutex)(&priv->lock);
-		scales_tbl = priv->current_scales;
-		size = ARRAY_SIZE(priv->current_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-	}
-	default:
-		return -EINVAL;
-	}
-}
-
-#define PAC1921_EXT_INFO_SCALE_AVAIL {					\
-	.name = "scale_available",					\
-	.read = pac1921_read_scale_avail,				\
-	.shared = IIO_SEPARATE,						\
-}
-
-static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
-	{}
-};
-
 static const struct iio_chan_spec_ext_info pac1921_ext_info_current[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
 	{
 		.name = "shunt_resistor",
 		.read = pac1921_read_shunt_resistor,
@@ -910,6 +871,7 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -927,12 +889,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -950,12 +912,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.47.0


