Return-Path: <linux-iio+bounces-10616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45099E512
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA961F245C2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441241EB9EC;
	Tue, 15 Oct 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN7Rf8Mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B621E7664;
	Tue, 15 Oct 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990415; cv=none; b=D3w+Q+WB0CQJd5Lx0YeXh8YYweN5BBesqodwx8PjFpq2tX49wUD15YenyMkxkqd06kx73OwoaJZ0CyZp4ddYMNP8pDRqzWLmKJpOHts2S7pwdqYOZxKp9Ts0092J6UWmIY6tym0TNEhEHljdXh05HpwceqCFv9hPbChYIsegeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990415; c=relaxed/simple;
	bh=QdYDXg+F9crN+GcA1VSjP47ejtoSADQbLgM8+WYO3yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggUSEnpKFds937f7GSKHacCpi63V4rqp0jLsIy+dI4gQKpzomOIVhmhbfbhxpA4msmpgUiN4CMBWrYTDycfik7YmQc9UTiF4YYa02838taWjoW1kgf5sZrGFuwpfnIpVJGZQQPcmJS1OqLknL2otbaIXpX69nwRoPFEYDuAsGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN7Rf8Mj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so61599655e9.3;
        Tue, 15 Oct 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990411; x=1729595211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=fN7Rf8MjGYIWdJa6QUVjqiWgujkJiBChwnIRs+31EgGkJFJDSJz2t1UM+C/9KI5YKT
         ElFWDv3Q7WkNqrdiS8RsVaMzqUIXXA9ES8xaMXspif8vi0xiXtVkQFt7kRblq0P8bCnv
         NkjqTcomN8cvQzgq7iWLx4UiT5BVV0StQjvdId1G0DLdB/2b1YjwK/jkZWsis28F5EpR
         9yXoFgJbpAhWDw2LSXsuZIQZCMXXxp3IONGAXOqUBbU9GWhKRym05qOWcnolLzEkgdA8
         PDtQsqE3q1Z4OWnlRJ5+0t2gLt+JOjxoUtFvUVeE668/bP3CdtF0oBn1TQYb43e68/b+
         Gufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990411; x=1729595211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBrQ02u0x+gOef7QkcexjhixwvYLcPbk6l/zE/g/i1o=;
        b=Yxa7joIYvwpDUqPoSflZzSFy15GonT5mnMgU3tGRG9gIo/w99lVBAhYfa1kQNAD7ui
         C2k+FCSdwGTg4dsWm1yXDeYQ1N6BNgAtZ55kREybhzgxRBle/c/tnfLAfJiLdndfPqja
         PtuEO2xUC5PwFfG99f6zuJ9tYK6nz3rO+hQ8qhpW+94Q5T4G/8YvQ59HhkNGM8V8DpJX
         PSrP/5LBNogxOeGYVE7reuWI/+IYSkwcQvD3duF1OJhPCh/8q8GH2emr4o7up8fiGS2b
         dz2bMbOd/TloEDEYK4zjmvS44JFXF2EGzzMuzdj/9I3GZJbV740s3P9RtbhE9OyyKZmb
         Ff/A==
X-Forwarded-Encrypted: i=1; AJvYcCUG1oVbGAIQgInSywtYlhYZgnkmQN9Nr8RxhPqXySplMiM8maR4LR9TnXoCTkqislirAOfTTXJWgc0=@vger.kernel.org, AJvYcCVlX5xuBowhOOGIqxGca6FY4W37rnuDhOD736ISO5dpt2p542ehY+4dzHgsfr9Felt5PFUv6WaVXUEzvFI=@vger.kernel.org, AJvYcCXLnr1eC4IgP8GcLCBkBC+EAqYIu183WPkz+q5vlizUiGn/8f+OYoh0hMZzHbxy+/3EowFkCRA4Ls93ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TEHasHmBH7j46ViEvPsEWkodhIzqN1K3g0wYGing/IqMEVYg
	vXrpwlj4W9HSj/L43OafcxjDjvo/YCsTLLgbNB0+IrXaAVnzBEwJOeqk0IWt
X-Google-Smtp-Source: AGHT+IFTPY+YqfaloGUHhYaFV9LoEdK/S04iLUW4htdOHIlqQfxo5RikCRfVHmY660LYaFHowAsXHw==
X-Received: by 2002:a05:600c:4e4f:b0:42c:b220:4769 with SMTP id 5b1f17b1804b1-431256167f0mr139921975e9.32.1728990411165;
        Tue, 15 Oct 2024 04:06:51 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f569943sm14423005e9.12.2024.10.15.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:50 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 15 Oct 2024 13:06:36 +0200
Subject: [PATCH v3 3/5] iio: pac1921: use read_avail+release APIs instead
 of custom ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-iio-read-avail-release-v3-3-ac3e08f25cb3@gmail.com>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
In-Reply-To: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
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


