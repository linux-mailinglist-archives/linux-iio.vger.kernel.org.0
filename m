Return-Path: <linux-iio+bounces-17753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E89A7DC5B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D10716AB0B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46159238170;
	Mon,  7 Apr 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxoq8CtN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBED51C5A;
	Mon,  7 Apr 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025767; cv=none; b=hD0sn2yy4Zt8K5WB+HHXzMiWS5gLXXkUYr7kO2pINJNOokpf51bxQWbPbZcX9T+5J3DmICVdIQDCP0SePA6TFhyBIOepj5Mf9KGwwMebJ+YillCiNNtRvpQQw1+IIgpv5LuC5B0wyaM8Glm4ADuJn7pdWDwZTKVBauG3onU1fEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025767; c=relaxed/simple;
	bh=8r6O3wJgxWSEfWdnMU0SsVa39yr41Y9p9k1tGUpTvzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYd8zub70obaZeggaZJTBlOGUFvvSKVxnEX6E9nS1u3e92G4i2e+rBrqpN+NV3qjWLiTkCg3tXOXK2xC/ZEGIOMs49r9JWPYOzCnCjxBY6a7KFmV0RshWWXqJ993gHJcpYRHU9fUfA+REN3gGzous0kzQ6az9CbP3LMg4KBp52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxoq8CtN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549946c5346so5033347e87.2;
        Mon, 07 Apr 2025 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025763; x=1744630563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pnTHuBGqWlRiXoCFZ8cMc3CEM7rT1/Z8f5jWlLiSzc=;
        b=cxoq8CtNLRdK3Nk5/q1NWkUgUODxrk4Iy5vp6l1hcPhOTAx3xtsi6eodqbWZ02M4b4
         Atrm+eGBzT2rCBWz4kOwfwsaXXly8aOwvblGSe4MFc0IoKXYziqF2m1WpsSiOAvJdnXP
         XDHyImkpAArgD7p1r9HI0MCdbJPYBjrPlRh8+tJBxlYxmujaTQAAEJ10zwkC6gBnbpim
         l4/TB1MTIsoujYDS5MGGOw39ryYvt/db3xGuc8H/FwFl96Xh9RG8G7jhXD78SI92mJSp
         ueOkxOyoHpG+1hl3RB8/a7kZCdVQg5SWDs7/YbChaodWoISkJzlqB3R71accXNI7IZm8
         1umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025763; x=1744630563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pnTHuBGqWlRiXoCFZ8cMc3CEM7rT1/Z8f5jWlLiSzc=;
        b=JJpKfIaKOraxB7NE28ZvYoAUdvpqMx5gYQNxGyqmMEYMJN8Hlc5iTqtqIlSyc6/ibQ
         QlElBZS8eWUNsicEIHsaEzIGoAA4SQKKvgal0Z4DmSwS3BSmPzXqJADQjMB+KH0SowbA
         /IyTLWI9Q/trok8jA3jSFRnrv4BdDlpixInMDqp9KRRWw2a/UTeqjVCDf70QA3FKLGLB
         2WITdLXAh23iRJB820H0bAjmcM/TSS1UufGna3aZCnGLb+JoPw2UXWqnPYJtcHSj9YPK
         tV91xMY+YtqOKK3oo3fOroBlID1UgQERyMnOkD7u2FsBDPt8b4DJLcD+TjzwfdYqJjxS
         VF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE5ESMz2elGkON7NKLE4ACWoO2qxgf+IvkgGtV9Wc+JvNycEZrynAuYuqm13FlwC7ValT8jtrV1sJl@vger.kernel.org, AJvYcCVdAqpN7bS1449ku5cWggZoAuMeJTICFdaTv1P/p1+SZk48L9EaZid7wSU2JTcCO7kvivPXUzTItmmB@vger.kernel.org, AJvYcCXHtexnD3OISF+YB8EV1HL33XEZo7OTKSroc3W4uDrcFE2C8XmfxPCn5VJpKfMZkL3r138RPw3vdokPw6QN@vger.kernel.org
X-Gm-Message-State: AOJu0YynI0FkB3LxG7w+wXPKAoJWrd7IKcgLto5h9yQ5G/H1+jjr6zt6
	RwQvRCPYcPu6BSE4ufgfI3mDSKgWU4dMMujqs6WDW4fXqkfVhaCB
X-Gm-Gg: ASbGncu5wSw0dK2C4z7xXpv4qC1g4hDKvI60tmSyK3Yek3b4lTY7PsrGnfk1cQNLtdF
	jonpUTdF+pxSk/fjBnSEwLDHTB4gEluN3dGuN6ydqbj0CvAOo3bq9BW9vomwSqxiz1hutlgYWXK
	KkRGAmXQxfDEIJftJ6Z++bHjIVsMpD0guVIWwbkjWSnevAcDwQd95ethr+x6ESiwgtDEPQRQmYN
	jaatCaAnk2l3xRUPPK/PIMyretSoVbSlgt+opruAfURTBZ/gnHKuajomcMrvQ+jAD6tKZB8rB8Q
	LuE60kIA8w1QtDTujLoefZRa4iCDA6hfMPcoHOg5w5k1tL9L/Wo=
X-Google-Smtp-Source: AGHT+IFqWPFnPbY5HdI9w1QEqNzTwmRtdAEuWycHKDFUQonp9aiaZtKA9lTeq6IWThW//jG+7LpAZg==
X-Received: by 2002:a05:6512:1089:b0:545:109b:a9c7 with SMTP id 2adb3069b0e04-54c227dc83fmr3619290e87.35.1744025763278;
        Mon, 07 Apr 2025 04:36:03 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab889sm1215684e87.11.2025.04.07.04.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:36:02 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:35:56 +0300
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
Subject: [PATCH v3 2/8] iio: adc: ti-adc128s052: Simplify using be16_to_cpu()
Message-ID: <8202060d90221beb9b8cf467606641349ad47fe9.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AwISQZKZKx+lCRMy"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--AwISQZKZKx+lCRMy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The register data is 12-bit big-endian data. Use be16_to_cpu() to do
the conversion, and simple bitwise AND for masking to make it more
obvious.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D> v3:
 - Decrease amount of changed lines by keeping the old buffer name.
v1 =3D> v2:
 - Fix commit msg to reflect the fact there was no bug
 - Drop Fixes tag
 - Use union for rx / tx buffer to avoid casting
 - Keep the shared message protected by the mutex
---
 drivers/iio/adc/ti-adc128s052.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index a456ea78462f..c5b2374322e4 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -28,7 +28,10 @@ struct adc128 {
 	struct regulator *reg;
 	struct mutex lock;
=20
-	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
+	union {
+		__be16 buffer16;
+		u8 buffer[2];
+	} __aligned(IIO_DMA_MINALIGN);
 };
=20
 static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
@@ -40,20 +43,18 @@ static int adc128_adc_conversion(struct adc128 *adc, u8=
 channel)
 	adc->buffer[0] =3D channel << 3;
 	adc->buffer[1] =3D 0;
=20
-	ret =3D spi_write(adc->spi, &adc->buffer, 2);
+	ret =3D spi_write(adc->spi, &adc->buffer, sizeof(adc->buffer));
 	if (ret < 0) {
 		mutex_unlock(&adc->lock);
 		return ret;
 	}
=20
-	ret =3D spi_read(adc->spi, &adc->buffer, 2);
-
+	ret =3D spi_read(adc->spi, &adc->buffer16, sizeof(adc->buffer16));
 	mutex_unlock(&adc->lock);
-
 	if (ret < 0)
 		return ret;
=20
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	return be16_to_cpu(adc->buffer16) & 0xFFF;
 }
=20
 static int adc128_read_raw(struct iio_dev *indio_dev,
--=20
2.49.0


--AwISQZKZKx+lCRMy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuJkACgkQeFA3/03a
ocUmJAf+IVemf33aCZPHP67CpGrzkL2Iy65ZA+dh5jokpIF4o8ZrsvSDKKGotA+a
PGHJ8vh821U4UwLD2c4m9CwypeuUy/rMUHQu83cln3QxUzojvcqb9B+nhvTNHGd2
dPSm3aoYfl34By2TbbWuAWAw42NESmXCm/HTfTl3hSTxtU4fbLZ1SDu6x+7vzrRe
tI2Q3jaQFwj5YIcZWAta4pW8mY+FmSoHdUyfM/2LbB6hvSVRja8t0NoT2ADEy/bP
XS4s9HA+tEVIfZ/6m3tDp8EFGMMkI7Vili5xPZUFoMFSFWfAsS29NGErEJoFqRg3
XnXAAIohZZA4c4vhid/foEy0CxMhxg==
=Q1XL
-----END PGP SIGNATURE-----

--AwISQZKZKx+lCRMy--

