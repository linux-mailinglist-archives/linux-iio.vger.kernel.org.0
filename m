Return-Path: <linux-iio+bounces-17529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D260CA787D8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837257A3C55
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE4230BE5;
	Wed,  2 Apr 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4li8ZHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA1136A;
	Wed,  2 Apr 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574155; cv=none; b=Lfq4FKyLsvWaumse/pVnQAaJsqpLjGMdqnNYdbJp6lKBMVgtK8o80FJNFvLgWJ3fNQxjQNBhFospUXPe7m+ipWYx6QF60yPA/LGpm7j3hWHP3XQqpSC8bE10ANGqloXXoXLz+5lfvjuQbepBUb7OqmrrqXHhOUoNtAf0FHlqtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574155; c=relaxed/simple;
	bh=p5irjYtAU9GIPUnC7aSM12GPQ0wmfz3hSIdFlImOF/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQRMpK0JkEYlDIK0xbnDW80E+hxPH+po7mNbKlHU6Jdwupq4rnEyQrF1wweYIxn+H04+V/1GTsEU62odxsJvcjqh5z276xQA6BUzxcgG2NTo7B5Z2JReCwSvAOv+HNakwC8rJkrGWH4uklXXyRMK18mM5xsex9ve4ys+lZ3xUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4li8ZHB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b0d638e86so4806158e87.1;
        Tue, 01 Apr 2025 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574152; x=1744178952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VcrOETKo8XKXDlPVld6j9Y0YpkNjogYC9xDL1E+2vk=;
        b=c4li8ZHBXtM5vavbMvbq0K2DSQQnk1KbQ8y2v4QZS2G5/TFCZ5vLisuxs9cQwzw9DM
         jPe3cEQGARdWliQs7tOe3hf2kc2I85qE9nxOXBxUBjoqUq64tBeMDVADKvBPcg1vfpsl
         85OLjDmb230f6HesEogl7cZLVEU3udz+BhZgudXDw30GMkI1E79/UCFljkU9vP5bdJPx
         SS26U4WomXLbBcRLBJW2x3pOaYg0kWPlFf8m4y4kqmBBpKif2ikq+4MjKc7qCpcxp+Vn
         qG8N+47+7oMSb2YvZR7n7LW+L0iC6lVJ2LdekiLH2WKz4zrn40b9SkEL71ouzVeKTaGX
         9odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574152; x=1744178952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VcrOETKo8XKXDlPVld6j9Y0YpkNjogYC9xDL1E+2vk=;
        b=c8GYJfELpZXowVo5gvNZmqTWRmQxCov01+ZBlscQZF24vg0eM63wN267Wl2Wdj+BX9
         v8LSo4/mxAdzC6AU+HW0VBMrAOqpPqct9MiVFVgZvDS4Ogh4t3prf7mHGXKhDkMa+YMg
         uG3qtUpBzdXtiR6qycTc/1uNJPRLlRTIHxlnybG7aK0K27+P6/kcWJ9Pnx56lenLhfbM
         jKKS5utSdIZ6PJKipj5SEQIQye/NSakWq+hYeVFhRlEBUuTHr2q6ldt8c0C7vtORob28
         RoNC2ST8R3PgRwhiXLX3LummtJN3t+LCZCuK0OXkJ+RZT7EKZSMAogblZ2ZcqjDHxXjE
         /guA==
X-Forwarded-Encrypted: i=1; AJvYcCVenOSUgPBFOBMot7rsHt4kqC3jAAGlJLNfZtz8J/fNAvSsEUlOQI+x21SuFZGoJlMqqm8s9EbZExUORQ6k@vger.kernel.org, AJvYcCW+DqVRFqO8TJqDbgWZ2jzQxCQGtnFyHzq6zxF9V2ryNt+LYxoj+vWX1xfBL1mSCxoB5WySDaSJNmxC@vger.kernel.org, AJvYcCWCPGMQU5Mx3gn1vLhWYzTvVspSZsDNfXINzj7Qik8tyvvRYi/1jO9c+TsT7XN5dA+a0BM9Kjavp6Cl@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8Q2FQ4Y/nJpfAGlD6Fa5MR3yFsUryacS4rgqkBS/DeoemNak
	jR/JT9Od3G35vtaUUaQk5//s8RLQtpxHvm7SkRb6Yfue8YZBKjUQhHAl1Q==
X-Gm-Gg: ASbGncvSLbKTXDTU6JtfjJHknuAKitTh2+T+jQ4+mTKtPUF+xZoOdhV1e8usr9maCIf
	eJATGI9QilwLvczmvfacbzqSYoFx+OYyFP8qddBhxyv4dmolqjNoXMOyoHuFdu/gePp7gWYWxOi
	IzLOalnV/LwNuMcc6DccrYR5DrODmwq5Q9Frj40mNsqEmso86BoDbEwQ+/lv7qC+E1dXjIIpOee
	PTuQmiFhAy0l5+zATYQoMuCCwyLRfFVKa/gQpXOETjJ3n5CodsxRN4XCZLC3aNL4ADZE3n3dUEJ
	axCtWYFIPE4xfVWNfha0d/YXmlKN/gU5PlLoSNtcaziqb02/bxg=
X-Google-Smtp-Source: AGHT+IEqWIPsETKwYRwkr5twFjoTAJwmk9Yaetn2M4H+gaHG39BswQAqeNKYBzG0Xna6tw7w70XbZw==
X-Received: by 2002:a05:6512:2c8f:b0:54c:a7c:cbd4 with SMTP id 2adb3069b0e04-54c0a7ccd49mr1650865e87.24.1743574151821;
        Tue, 01 Apr 2025 23:09:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b095919f6sm1538533e87.208.2025.04.01.23.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:09:10 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:09:07 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] iio: adc: ti-adc128s052: Simplify using be16_to_cpu()
Message-ID: <feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qvy7OnKN4+ah2HUN"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--Qvy7OnKN4+ah2HUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The register data is 12-bit big-endian data. Use be16_to_cpu() to do
the conversion, and simple bitwise AND for masking to make it more
obvious.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v1 =3D> v2:
 - Fix commit msg to reflect the fact there was no bug
 - Drop Fixes tag
 - Use union for rx / tx buffer to avoid casting
 - Keep the shared message protected by the mutex
---
 drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index a456ea78462f..3e69a5fce010 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -28,32 +28,34 @@ struct adc128 {
 	struct regulator *reg;
 	struct mutex lock;
=20
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
+	union {
+		__be16 rx_buffer;
+		u8 tx_buffer[2];
+	} __aligned(IIO_DMA_MINALIGN);
 };
=20
 static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 {
 	int ret;
+	char *msg =3D &adc->tx_buffer[0];
=20
 	mutex_lock(&adc->lock);
=20
-	adc->buffer[0] =3D channel << 3;
-	adc->buffer[1] =3D 0;
+	msg[0] =3D channel << 3;
+	msg[1] =3D 0;
=20
-	ret =3D spi_write(adc->spi, &adc->buffer, 2);
+	ret =3D spi_write(adc->spi, msg, sizeof(adc->tx_buffer));
 	if (ret < 0) {
 		mutex_unlock(&adc->lock);
 		return ret;
 	}
=20
-	ret =3D spi_read(adc->spi, &adc->buffer, 2);
-
+	ret =3D spi_read(adc->spi, &adc->rx_buffer, 2);
 	mutex_unlock(&adc->lock);
-
 	if (ret < 0)
 		return ret;
=20
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	return be16_to_cpu(adc->rx_buffer) & 0xFFF;
 }
=20
 static int adc128_read_raw(struct iio_dev *indio_dev,
--=20
2.49.0


--Qvy7OnKN4+ah2HUN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1IMACgkQeFA3/03a
ocX9aQgAmUYybJpLULtz7An/3xvwEI0dqdKjC1Mwj+DPPNdrrjC9stxqOgua3+x8
+hacgaB6dR1g3Nok9Qpc8uSKnFf0CNoVEizZRoDcBTAK7x8Fh68NwsSWNFIjhtCk
GGh9gboB5v3bteUH1GzU/rDnd2Izs4soLXCThZcfMO2TZWaVNnuyXykmU+sAFXug
8Hgh/lHWrjbuBOm8JPqyk8Maci31WtB0ZKsRoJsuSg3l7y6tcU7OIyHXTRlq247R
qqL4G8gOcZNN1H8hH7PmassGxa0Olb/Et60tMKClvt011QMP+1LGwH38mKop78Ud
8kYVytmoa6nboT6J8srgvJNF18cHnA==
=1blc
-----END PGP SIGNATURE-----

--Qvy7OnKN4+ah2HUN--

