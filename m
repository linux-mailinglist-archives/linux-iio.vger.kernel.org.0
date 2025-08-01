Return-Path: <linux-iio+bounces-22172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97222B17FE9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD8562682C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B922F76F;
	Fri,  1 Aug 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/fx/S0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4692264C7;
	Fri,  1 Aug 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042867; cv=none; b=Yt/zCafSqueUnSSX+lKfqa6dPwnZGy/zxkeF+6lsLefrYCJuZ2H0Cnngl3tzjx0VQJcG7VPcdxZ/cix4UO0j8LqKUWmRnP1vil7qqoPaFbx9OWAvwzuVRs1PWP2pXFu+oF9A+96zVTlIpUKubUXZCdRlnJlZMWKdRqoCaHT+W5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042867; c=relaxed/simple;
	bh=/4ZfYDxS0RbwwYjfDVsaX1prz5zvolRK5fF2tdOubmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frQKVivcFjyu6YnOGq6gmEw34/3t2McfUmSDgUz1xTMovysKJDPqJCKPEkKBk0gNIgBXUCvcgI7v6sC74xKuKINwdW5Y76aM2SMjoT4YTQRTcd96Jv0qjF+jJJhI/6fCPa156+LhI39q26xzH0G2pUYbjXsBgxJmTWdcYGQXsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/fx/S0F; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b87604220so1375851e87.1;
        Fri, 01 Aug 2025 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754042864; x=1754647664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsaHrDFeM7wf+O/YMnBa1zIkBw5GHo8eRLOe0W2Um3E=;
        b=A/fx/S0FwX4r/6iJ9FbjWtEn4mmP/eStIxlz5EK7MRedpJNG7p0ZZpwOnKEjQ+GF8K
         EZgKPyzlNDELflz6xFQ3Bo2V884Koq71/Tx3gqeiD7jFn4gLlm+oXSjqkdXe45B+s5BB
         xoQqm2m8+ZNE4bJzibYT0maB3j6WHn0LFcaRhVJV9iYVFgflPtY9OIN56dPMBLZMNTq4
         1o2y4Z8YBXznFhJ/q0y7ztUBO5xWKXSUrU4M+zPlOE+g56lk8pgBCcZzA0yPymRXCQ5E
         BcsqUrN4rV9JM2UKwZi6dNaeaRhpbZ+sID05gvChGB/lPSd/PNLoDhAwGRkUvdYTySy9
         4S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042864; x=1754647664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsaHrDFeM7wf+O/YMnBa1zIkBw5GHo8eRLOe0W2Um3E=;
        b=M0CW9tDPw1NhFYbLgeUw1E7DhJIpanN9Wv1VBdUai663qLEBc79tnp1Rwm2MbCMNJi
         Sw68gzyeMsRZ/YdiCGZTpWc3L/Lh4EECPfCe71is+EboNfHTE+dlvvFVHMXanLdBZJlX
         fXBFJ58WKOjob+7lLdD0kEeHJsAsJ19a422El5L1oVaTblh4q8kLNbqrzlCJy6QyNIuh
         myEOXbe4Iunb8kjJcLZGlFbULBwyad9a26ZUCVzfGDk1D3Z+RdxlEFR2t+yZNew5NrRd
         UC+z65aUnL4VOSzQo5jxdzrMzCDX/c/8S13DDA3L2kU3BqP2UrtGBGOb+a2zWuzyuUkd
         PPAw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRzbQHMikMYLMA5RGdnf/JuOOTsGpuoJmXJqU9RBRAoGjAyqf5Y7tITkj/wVHkc0nuKYepNWsSv4=@vger.kernel.org, AJvYcCWyDxM9QQCPTCYhk2889ZfXagEmdHh031CPY36UEwXmNgBOo2qLeWfRZECObyPxug254njue7pSOYunicIg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DE9iH5iTbFGf6H3KJNmrj4K9T7Ka4XRcjy+3fGY2CBrW8vrh
	ISQGd5QF6B8JQLaXFUFGsmk0yyI9HZbqlz2i4e+K+/5QllcyuguHWkZy
X-Gm-Gg: ASbGncuFs4aSp3dvVD0G7rZWbylbT/L4GbfSYozx+hyIZFXAq5YqyUC2sxzGsLMCjHc
	OWP07goOQ93+8cB0yiZtLjJFf4CN+eITp5f7W/e7YQUXjMosA8bxfEv/lsdLY2AAT2aW2dN3uTp
	OlHOkZk2i/9KH1ssleaKv20yiYYZRR9TYQWFtsewKWENKi8AcK3sD3AFHuuhiqet/M5Jd0sLkZ0
	JRyxYNO+Qb1t9CsE3M+5KCfXixBArResdYz0voct4DknjJM9WdQUK1wYQwWQ7TR2Y5YVHpRL5nH
	x2/hDPfHYfoBWbeku4dX1RjPctvYpasGJlOL5bzdMNRfMH63pUV8g+/F6bvO2tB/UBKHXr/YxeK
	efMTaAFR3RaKNJSnbtrkl/NVMqETO
X-Google-Smtp-Source: AGHT+IEvzzJZrWPjWN/zodz/bPyIveP/iYFOHWuha5Q1Us+ys7xppCVNSi6jXCyn/Wtu1fQMP5f3kA==
X-Received: by 2002:a05:6512:12cd:b0:553:2773:f3f9 with SMTP id 2adb3069b0e04-55b7bff3691mr3147392e87.8.1754042863497;
        Fri, 01 Aug 2025 03:07:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3214sm538712e87.126.2025.08.01.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:07:42 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:07:39 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] iio: adc: ad7476: Simplify scale handling
Message-ID: <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QxQjTTFP1NoL/Kg6"
Content-Disposition: inline
In-Reply-To: <cover.1754041258.git.mazziesaccount@gmail.com>


--QxQjTTFP1NoL/Kg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver supports variants with different amount of supply
regulators. On some variants there is only VCC, which is used as a
reference voltage. Others have separate VREF regulator, and some rely on
internal VREF. Some have both internal VREF and option to connect
external one.

The ad7476 driver reads the regulator voltage only when the user asks to
get the scale. This means the driver needs to do some dancing while
picking the correct reference regulator (or internal reference), and
store it for the later use.

According to the discussion:
https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawei/
variable voltage references are rare, making it hard to justify the
added complexity for supporting those.

Drop the support for the variable voltage references and simplify things
by using the managed regulator get and enable interfaces.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
NOTE: This is 100% untested as I lack of the hardware. I have tried to
maintain the existing logic, but there is always some room for an error.
All testing and logic reviewing is greatly appreciated.
---
 drivers/iio/adc/ad7476.c | 84 ++++++++++------------------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index bdfffc4f5724..7b1d6a0fd941 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -39,10 +39,10 @@ struct ad7476_chip_info {
 struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
-	struct regulator		*ref_reg;
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
+	int				scale_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -111,7 +111,6 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7476_state *st =3D iio_priv(indio_dev);
-	int scale_uv;
=20
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -126,14 +125,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->ref_reg) {
-			scale_uv =3D regulator_get_voltage(st->ref_reg);
-			if (scale_uv < 0)
-				return scale_uv;
-		} else {
-			scale_uv =3D st->chip_info->int_vref_uv;
-		}
-		*val =3D scale_uv / 1000;
+		*val =3D st->scale_mv;
 		*val2 =3D chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -286,18 +278,10 @@ static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
=20
-static void ad7476_reg_disable(void *data)
-{
-	struct regulator *reg =3D data;
-
-	regulator_disable(reg);
-}
-
 static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
=20
 	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -308,58 +292,32 @@ static int ad7476_probe(struct spi_device *spi)
 	st->chip_info =3D
 		(struct ad7476_chip_info *)spi_get_device_id(spi)->driver_data;
=20
-	reg =3D devm_regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret =3D regulator_enable(reg);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7476_reg_disable, reg);
-	if (ret)
-		return ret;
-
-	/* Either vcc or vref (below) as appropriate */
-	if (!st->chip_info->int_vref_uv)
-		st->ref_reg =3D reg;
+	/* Use VCC for reference voltage if vref / internal vref aren't used */
+	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+		st->scale_mv =3D ret / 1000;
+	} else {
+		ret =3D devm_regulator_get_enable(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+	}
=20
 	if (st->chip_info->has_vref) {
-
-		/* If a device has an internal reference vref is optional */
-		if (st->chip_info->int_vref_uv) {
-			reg =3D devm_regulator_get_optional(&spi->dev, "vref");
-			if (IS_ERR(reg) && (PTR_ERR(reg) !=3D -ENODEV))
-				return PTR_ERR(reg);
-		} else {
-			reg =3D devm_regulator_get(&spi->dev, "vref");
-			if (IS_ERR(reg))
-				return PTR_ERR(reg);
-		}
-
-		if (!IS_ERR(reg)) {
-			ret =3D regulator_enable(reg);
-			if (ret)
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0) {
+			/* Vref is optional if a device has an internal reference */
+			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
 				return ret;
-
-			ret =3D devm_add_action_or_reset(&spi->dev,
-						       ad7476_reg_disable,
-						       reg);
-			if (ret)
-				return ret;
-			st->ref_reg =3D reg;
 		} else {
-			/*
-			 * Can only get here if device supports both internal
-			 * and external reference, but the regulator connected
-			 * to the external reference is not connected.
-			 * Set the reference regulator pointer to NULL to
-			 * indicate this.
-			 */
-			st->ref_reg =3D NULL;
+			st->scale_mv =3D ret / 1000;
 		}
 	}
=20
+	if (!st->scale_mv)
+		st->scale_mv =3D st->chip_info->int_vref_uv / 100;
+
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
 		if (ret)
--=20
2.50.1


--QxQjTTFP1NoL/Kg6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiMkesACgkQeFA3/03a
ocX//gf/TAURqv8cvjFpzH7Hf9NyMobNOLx6oj4zfAQ3PUCQYKHRsj1s5kQMnlky
MKae4smTlhnI9c6T18SA8lTULbXQUcTdvGvOl13ppcXnrhY2N1qYigUHcuXXIy4L
t2+nj0NIh2/6m7bL7NtVMFd+XWfHFiXvc74kMyy+9eNnROh1t/LLJlDCPS4eL1sa
IyMFl8bk+ynCfVVmWbQDTApBBr2AQYFFrC1W82aw1yWvFO5MJfrzFMpFWTfnkEYM
qm+TDb1S4L6IS7cYSZ/eTBhCCd5aEyqhzAKZqOKLZuQwvcKdQ050Wx3/STQrnC8s
u19IHuFQX5q8MHmugW293cFnBeDUBQ==
=yQsV
-----END PGP SIGNATURE-----

--QxQjTTFP1NoL/Kg6--

