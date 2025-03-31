Return-Path: <linux-iio+bounces-17402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E4A760C7
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594733A6809
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FB1CAA6E;
	Mon, 31 Mar 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIHiVysw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E369D2B;
	Mon, 31 Mar 2025 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408185; cv=none; b=hTvsMNZjIDKXDPNlVBkIvu8jW3NVeXNlirbQ/7UBaMRBwbEd4BdCRcZ9GFMiY6SqoQd74UownJzKkoMehy2AqLFhQFNT74yESEf4FKn/+E3qHuUGrYv5EDLDqHt2KLJ5KxFtDTYuYJzPqSmSdVZ524Yb2aG5nYHOSa6ubp6mrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408185; c=relaxed/simple;
	bh=YVpuM7dgprbv0GtfP/fGAJUobt+5qb7gbFBGxfO11jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFY188hqZ8qwRBM56laX0jfcltxWhTBBgNtQvv2QOy57ay1KjrvHIqbzVv6gyOdN28ioTR7KFyeewMuuy8TsDeNb7FIVjuGBw+/ZrsBotPRsiWTAJH9c54WgfJs+Imj36rn6cD/v3iHnt4i72sZfKY56/h41fDlZ1iQOfPDFegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIHiVysw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf1d48843so36268851fa.2;
        Mon, 31 Mar 2025 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408181; x=1744012981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBHwZqJRLeUXbeecOEQfFgkEOpXTE6ey+sc5tdVEuRw=;
        b=WIHiVyswkZO3GJ3cj214zxSzac0yIfmlefuANqwBuIVt7nd0WkIqSsq1/veswIC5gY
         ep8d+AzFxt5tUltuv0RcSHYulwSeHab1Kz1yxsA/F+yN+tvqEglsJSsQuF18SgPXI+EY
         GFHDSnvGHfDkbcjpEGxAWIYe4AcwUyLemht4kPlGabhuUbppsWKyMNt8dBpytCnAmmp6
         aSzLEBS9SiknT3I+oXDX7niK2jKPMa4pVypK2ff/9OnLuhV3lXeWoYm51Yav7RN85mUe
         s6rkAMXL9ocRGI3C8ti+vVcdSAXAyvYW+eDYX+No84f7+ts7lXrbhGU9S7Vwhtq6U3sZ
         uhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408181; x=1744012981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBHwZqJRLeUXbeecOEQfFgkEOpXTE6ey+sc5tdVEuRw=;
        b=s84w4aU+M/tm71PnEMQoUngd/VKk4RqjYeDxH2iGmNId0ZZe9Zo/qOs+wrb/KMf/rH
         jYzzVk9Witreyva/YY6lSNt2znn3R9Hx42h54S+8KGpMAk2hhwBIOEMVZbZ6w7Nn117M
         nxdxj6QxfyaiFElW0QBwVwXNrVOzzdUpZ1kojZ8OHMKaHBP+Wf+teX9/PiALirBWX3YA
         /pFcS/JzxRnQ6/60rKF4h8W/neC/NoXA68M9bGEsJ+C1REsLzAZWQITUJfNlqQGYzUz+
         JiU01qF4YXoRYVRlG2ZxSzh4h7vYeJLqql6oa8dP+BpspLVtz/pSqs+7BCjGuVgblkYa
         htuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7ylJKHS1BBbeX4E6XjIadO8kmFzt0CWtO/VoM3miCQhOkGeCikbzjl2uZEqmNwVvTz/wE77FiIDjUxUSm@vger.kernel.org, AJvYcCVZnJOD2PZSxDsTe3Df3LBVj4U8C0Xn9dNv+y+I6MgZs+KfOHcxuAsDcNgEbO9DPyVk6DDOcj4qKaRZ@vger.kernel.org, AJvYcCXEORQBfvwafUCClrV0V51DsnSt693vpeF3BMyWfxFmZmcDRJKXxNN1nBuNyHvHxff4sFtEqPzNSWXY@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6LX02PG2yEdYkINaA/l3mqBKcWfXHBlhAfFYE+NgPs+hEAU2
	8JmY2DX9hgEM2//Uj0daJ7TjyQO8xUe+V5tqbC/KJP7zrnEggV08
X-Gm-Gg: ASbGncvlJFKc4RqRbqDgpH0j9iBOnNr/P+9rvn2XOH0uKeL8eli9Tl7LHYRKKVtCbB8
	MOIxySwUAkvbdXiytJEllEKI+PI2MFmG6EEDh1uBukHrlgUsvuYFpLEusciQu7WBK1Tx2wee+RW
	3Uowr19xoIpYjOedpMBWEQTavMEt1OZo2xdt1uvhMgGFymvo+IW9kS06y+ALmlIjEfleEZyVQ7r
	zoEuYMVDTA78GB/kVE5x3fz54XaEIgDAPWzoBlpEDz9TPV1u2mGrafS7c+Z9N3CTsNcBIHXHYyP
	eLH3CgvMmT2Fv6igHaxRixSj7MruC8WBR6OnDDj9i64X6Qc/Gx0=
X-Google-Smtp-Source: AGHT+IF9Wc+i1DLmHJJAa6vLgUpDGzaBiNozHNoAChuyMtEChf9NIyjq49qgbM/np31OKjekneIscQ==
X-Received: by 2002:a2e:b88a:0:b0:30d:e104:b67d with SMTP id 38308e7fff4ca-30de104b897mr22059131fa.40.1743408181301;
        Mon, 31 Mar 2025 01:03:01 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b5983fsm13354411fa.98.2025.03.31.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:03:00 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:02:55 +0300
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
Subject: [PATCH 2/6] iio: adc: ti-adc128s052: Fix ADC value on BE systems
Message-ID: <babe1eac3de30aa22e09266de1f5521fa9e0decd.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiOVzKU1KHw2h4wJ"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--IiOVzKU1KHw2h4wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ADCs supported by the ti-adc128s052 driver do return the ADC data in 16
bits using big-endian format. The driver does unconditionally swap the
bytes. This leads to wrong values being reported to users on big endian
systems.

Fix this by using the be16_to_cpu() instead of doing unconditional byte
swapping.

Fixes: 913b86468674 ("iio: adc: Add TI ADC128S052")
Cc: stable@vger.kernel.org
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
I have no big endian machines on my hands to test this. Problem was
spotted by reading the code, which leaves some room for errors.
Careful reviewing is appreciated!
---
 drivers/iio/adc/ti-adc128s052.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index a456ea78462f..d1e31122ea0d 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -28,19 +28,20 @@ struct adc128 {
 	struct regulator *reg;
 	struct mutex lock;
=20
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
+	__be16 buffer __aligned(IIO_DMA_MINALIGN);
 };
=20
 static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 {
 	int ret;
+	char *msg =3D (char *)&adc->buffer;
=20
-	mutex_lock(&adc->lock);
+	msg[0] =3D channel << 3;
+	msg[1] =3D 0;
=20
-	adc->buffer[0] =3D channel << 3;
-	adc->buffer[1] =3D 0;
+	mutex_lock(&adc->lock);
=20
-	ret =3D spi_write(adc->spi, &adc->buffer, 2);
+	ret =3D spi_write(adc->spi, msg, 2);
 	if (ret < 0) {
 		mutex_unlock(&adc->lock);
 		return ret;
@@ -53,7 +54,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 c=
hannel)
 	if (ret < 0)
 		return ret;
=20
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	return be16_to_cpu(adc->buffer) & 0xFFF;
 }
=20
 static int adc128_read_raw(struct iio_dev *indio_dev,
--=20
2.48.1


--IiOVzKU1KHw2h4wJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTC8ACgkQeFA3/03a
ocWNxQgAzZTe5FlOy0vDBKa3nNtfo45qRFf6jctZCX+pXG/Jnvxg0EmuvKqfmaGV
QUwH4D5fs2zYlRi1Gf4/QFIk72r6/AaSxy3092THDCmUXHfm3j2DRR7t30lYqBZn
juWUSTld68gYHX/SS/gdUDaI8JaZByMPHf46TsBtuE5etWbkOBjH01h1AU0iPW9X
eXed8UzRcRl+8zFEB2oxQ4xtAfkl+GNN9/ZATkPd/lQqg3Wq0pQlFPYyTdHfNZds
8LnLwHpcysxgULjc79jcThuCje6StzPbMbqp1kv/zxutLRtpYldt5Y5GxRh1RTbJ
EFOv/8Q8EHEGLsNSnh+R+KFC4Q6evA==
=YRAz
-----END PGP SIGNATURE-----

--IiOVzKU1KHw2h4wJ--

