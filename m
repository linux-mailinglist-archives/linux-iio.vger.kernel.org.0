Return-Path: <linux-iio+bounces-12468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67199D4D75
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 14:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36AAB26A40
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93201D358D;
	Thu, 21 Nov 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxMlFhu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94361D0DF7;
	Thu, 21 Nov 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194349; cv=none; b=YJ6k2ef7axjsJlRFYq9Te5csTOIOh+KvA1u1cn/2cwiWEqT/TdUk6pvA59yJquratwlXG2SS1h3Tode9DyIHKSLsMgcKQnhw7XMdYmLTfBwiLBT5krzIvlKg9vJ55beUxNHShgM4iKwOrpf7O51DibLk17BRj9ni+I1QhbBmKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194349; c=relaxed/simple;
	bh=6npMatVCZI+oeHWmt/V2F2Ut5alI7SeDaNexlDHDHGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mobz5Z0SvXxjd16rlz38B4delSHMJnhiZxO7VHJErh0gwUFedNbQ3qo3GgnZV/lVETHy4vkwexxvfSEZzmDsiU+/gxY7c97dYYbE7jx4KZv8IaeNRnXydnYqzjlqsSDzeF7hBnY7eh6gs9QFfCdXY/zGMeyaPg2XX8GpkV5WFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxMlFhu8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd17c2d71so68470e87.3;
        Thu, 21 Nov 2024 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732194346; x=1732799146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WOMRJJYyVM1nXqRX+JAese5bHuTXFA1dmAo4aaZJwhY=;
        b=UxMlFhu88Zh0S1En1TBXv2LaakEZVpWmLe3RViLdttuG3EkoTXDLZvbZH6r7KOFpGU
         dPEEkJ6QR8MWaJlQ2v72qZvrh5M4KyisVmhYrW3vbcpUNNY59/pgKbxTO+0xfUTbEJ0s
         s1cEopBtmEfN5+WomLGi+9SePrRiPz62tL25RVH8iQK9Qf3Dh7bp8+ZKKBBS2cH401i7
         htijhS1px/BAtzq+ypRpb4KwWo+D9Qi7qTCmQpsrlT5SKtT7UiU+H+35DqhPJ2zOdY7s
         1UfBZr8Vwr6s1gRuvKDz3vlmieThfNVZvWRhq/7SasgAGLkhypu0PnZI5Y0pu79XKAER
         LVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194346; x=1732799146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOMRJJYyVM1nXqRX+JAese5bHuTXFA1dmAo4aaZJwhY=;
        b=Kn/1uzwwIip21U7YMpYoxKzMGT0pQEcOLkvScPMdLJsrhNSLesTkmYxr3vfnx/xckc
         ru8fDcrmqOG7ECkEUvFHBAIktRzbxkh8qfeNjCINxi9wXLHSIQP7Nr4vqY+EO9oNPuIU
         axYVe9xGnKuR4bpyJ0JFHBmaZxZTPICjTQP1PLigapBsdTQ9G749UrWjCu+rRnkBwUzQ
         7ZmihjCBm7GnlqCb5hVTMXeI5cReVqppkbXoTYfCaZovRCPNtRwJXWC6tTMi4PM3EDbV
         LEQF3uIB4nGE6hTxAKCDhGWPhwH432WMxd3QxkWFX/SmBcvaV8c5oSUQeVB9wsDvOOJ7
         tn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHSDXX83yuKElgH3x4IHe65fOUT8oyHduGhdX3WWHJCKqfaL543xXgZSC1jih4HX+fgoSyfNHnXTA=@vger.kernel.org, AJvYcCWNLZ213cOe1VtdBE8KS6pbvHvI+iyaQYIZAFDjb9FPZW4gARctS9V6jB30fCc2DLkjfrTVfkKKqAl4kV1C@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2hBAIlVGNpc0e7JMuj7q7iDaKm0Y27AdCYDqxRAyq2T3kCTL
	NzMaWyZYnW+cLvMhH7Q+IEceGSgnoGGf0DhXLESlEtypXTgRj5XY
X-Gm-Gg: ASbGncsqIAv6ZDyUMUcNzupEo97B719mGZG7O1c3F0tzwAv045LH8YhuJFjqThEREl2
	FiOr8xw2hamfQkdEMeljJPoRHSMMK6m3vyWZYL4pu4DOMjfTt8MtUDAd2v3hU5kNCTN9ZsDPvCv
	x6S2B6qYDwQBovIFhkggqZtTBJ2DN8QrlmNJ6x+GroaEJQlsZXZHaZ7SAhCmjjhD04TuZIfVqgV
	SDJ5KkFfMtvlCsEYHYLzJRtEG4TVnkRK8rJW4EYVvp4pX0nAzHx
X-Google-Smtp-Source: AGHT+IGamEeL9UVJ4CScSHAlfc1wOhqm9/9TKfz5C34BD7KTXtr/rDf5fhtXQaWfwuKzPeADMr8MsQ==
X-Received: by 2002:a05:651c:98a:b0:2fb:5014:c963 with SMTP id 38308e7fff4ca-2ff8db86d5dmr40416081fa.20.1732194345492;
        Thu, 21 Nov 2024 05:05:45 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69b16184sm18618421fa.112.2024.11.21.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:05:43 -0800 (PST)
Date: Thu, 21 Nov 2024 15:05:38 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: bm1390: simplify using guard(mutex)
Message-ID: <a4c2f21189964132d245531b77fb0865562443a1.1732193263.git.mazziesaccount@gmail.com>
References: <cover.1732193263.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5F1TfRMO12U7bMJL"
Content-Disposition: inline
In-Reply-To: <cover.1732193263.git.mazziesaccount@gmail.com>


--5F1TfRMO12U7bMJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BM1390 uses mutex for protecting the fifo read sequence. The clean-up
for a few of the functions can be slightly simplified by removing the
goto-based error handling/unlocking and by utilizing the guard(mutex)
scoped mutex handling instead.

Simplify driver by using the scoped mutexes.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm=
-bm1390.c
index ccaa07a569c9..fa1a477151d0 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -8,6 +8,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -263,14 +264,14 @@ static int bm1390_read_data(struct bm1390_data *data,
 {
 	int ret, warn;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	/*
 	 * We use 'continuous mode' even for raw read because according to the
 	 * data-sheet an one-shot mode can't be used with IIR filter.
 	 */
 	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	switch (chan->type) {
 	case IIO_PRESSURE:
@@ -287,10 +288,8 @@ static int bm1390_read_data(struct bm1390_data *data,
 	warn =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
 	if (warn)
 		dev_warn(data->dev, "Failed to stop measurement (%d)\n", warn);
-unlock_out:
-	mutex_unlock(&data->mutex);
=20
-	return ret;
+	return 0;
 }
=20
 static int bm1390_read_raw(struct iio_dev *idev,
@@ -546,38 +545,33 @@ static int bm1390_fifo_enable(struct iio_dev *idev)
 	if (data->irq <=3D 0)
 		return -EINVAL;
=20
-	mutex_lock(&data->mutex);
-	if (data->trigger_enabled) {
-		ret =3D -EBUSY;
-		goto unlock_out;
-	}
+	guard(mutex)(&data->mutex);
+
+	if (data->trigger_enabled)
+		return -EBUSY;
=20
 	/* Update watermark to HW */
 	ret =3D bm1390_fifo_set_wmi(data);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	/* Enable WMI_IRQ */
 	ret =3D regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
 			      BM1390_MASK_WMI_EN);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	/* Enable FIFO */
 	ret =3D regmap_set_bits(data->regmap, BM1390_REG_FIFO_CTRL,
 			      BM1390_MASK_FIFO_EN);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	data->state =3D BM1390_STATE_FIFO;
=20
 	data->old_timestamp =3D iio_get_time_ns(idev);
-	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
=20
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
 }
=20
 static int bm1390_fifo_disable(struct iio_dev *idev)
@@ -587,27 +581,22 @@ static int bm1390_fifo_disable(struct iio_dev *idev)
=20
 	msleep(1);
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	/* Disable FIFO */
 	ret =3D regmap_clear_bits(data->regmap, BM1390_REG_FIFO_CTRL,
 				BM1390_MASK_FIFO_EN);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	data->state =3D BM1390_STATE_SAMPLE;
=20
 	/* Disable WMI_IRQ */
-	ret =3D regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
+	return regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
 				 BM1390_MASK_WMI_EN);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
 }
=20
 static int bm1390_buffer_postenable(struct iio_dev *idev)
@@ -691,25 +680,24 @@ static irqreturn_t bm1390_irq_thread_handler(int irq,=
 void *private)
 {
 	struct iio_dev *idev =3D private;
 	struct bm1390_data *data =3D iio_priv(idev);
-	int ret =3D IRQ_NONE;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
=20
 	if (data->trigger_enabled) {
 		iio_trigger_poll_nested(data->trig);
-		ret =3D IRQ_HANDLED;
-	} else if (data->state =3D=3D BM1390_STATE_FIFO) {
+		return IRQ_HANDLED;
+	}
+
+	if (data->state =3D=3D BM1390_STATE_FIFO) {
 		int ok;
=20
 		ok =3D __bm1390_fifo_flush(idev, BM1390_FIFO_LENGTH,
 					 data->timestamp);
 		if (ok > 0)
-			ret =3D IRQ_HANDLED;
+			return IRQ_HANDLED;
 	}
=20
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return IRQ_NONE;
 }
=20
 static int bm1390_set_drdy_irq(struct bm1390_data *data, bool en)
@@ -725,17 +713,16 @@ static int bm1390_trigger_set_state(struct iio_trigge=
r *trig,
 				    bool state)
 {
 	struct bm1390_data *data =3D iio_trigger_get_drvdata(trig);
-	int ret =3D 0;
+	int ret;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
=20
 	if (data->trigger_enabled =3D=3D state)
-		goto unlock_out;
+		return 0;
=20
 	if (data->state =3D=3D BM1390_STATE_FIFO) {
 		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
-		ret =3D -EBUSY;
-		goto unlock_out;
+		return -EBUSY;
 	}
=20
 	data->trigger_enabled =3D state;
@@ -743,13 +730,13 @@ static int bm1390_trigger_set_state(struct iio_trigge=
r *trig,
 	if (state) {
 		ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
 		if (ret)
-			goto unlock_out;
+			return ret;
 	} else {
 		int dummy;
=20
 		ret =3D bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
 		if (ret)
-			goto unlock_out;
+			return ret;
=20
 		/*
 		 * We need to read the status register in order to ACK the
@@ -761,12 +748,7 @@ static int bm1390_trigger_set_state(struct iio_trigger=
 *trig,
 			dev_warn(data->dev, "status read failed\n");
 	}
=20
-	ret =3D bm1390_set_drdy_irq(data, state);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bm1390_set_drdy_irq(data, state);
 }
=20
 static const struct iio_trigger_ops bm1390_trigger_ops =3D {
--=20
2.47.0


--5F1TfRMO12U7bMJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc/MCIACgkQeFA3/03a
ocU2uggAhWItEd4R5MnnUV4GlzXrWakai2AQYn1X55tL7GcWXC8q4jaa0EJc6sg3
lJe+ghvqOjczyUncVUVqmIX2K6S8Db7En2bteVEC4JV9DTjU+DyeO3YCN5MOaP96
RRvnQNRVCtVcWpV+0iv4+vGMNl7ORfACcE5D0dkgyp0rgphcs+pgzlCXUoRmge2v
RswMZP5lCrnLPn90BelsbzAkhsrg/4v8p8mXuQ/1HoG1jHA01/8ICnGjeW41dUy6
LDv+QsCle24pKQzc7RpyExchdNXS3neTVrG0TkO1XhC2Eyu5W/pzJqKdMDnZpdtK
+U+thdvAkHbq/nPQJ/M+0xU4c/I6DA==
=Dqg7
-----END PGP SIGNATURE-----

--5F1TfRMO12U7bMJL--

