Return-Path: <linux-iio+bounces-19481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCDAB4E17
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171773B5E5D
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E6205AD7;
	Tue, 13 May 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtsbjVq1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0D204583;
	Tue, 13 May 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124808; cv=none; b=FX/kiFj797xDLQvh6ojOaErrDk4H/woM5e4/IzoDythIy2JizMmG4jtcVeSe2y/zwAHfCerXWrzHHJRUbhorwzUHkA5yG6owMFyutia0+osDPJ/8HP/xncs9snIrFBq7cKk6MIA2UUgRt8pUPGPM2+Q6f8/4065SCktp3yhUBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124808; c=relaxed/simple;
	bh=L2SZ0EZxEo0VNiP7+gEzv6Gn1Kbxa1Nny1f2Hkg9v64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg7JAre7BZsPOYRotoobYAhOw19hp+yDSlHEjijkt7bGfWPpe05IIanQGZw86Q4ocO9m35clQxKv7gPM4THBG1gXq97x6/lDkFrSbHFN//cM8wjIwlRaRJXCekX8cKj2N4kKsbZUqegPxHL1h9nyVFMaqp109vbIUgfGFH7lt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtsbjVq1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54acc0cd458so5767738e87.0;
        Tue, 13 May 2025 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124805; x=1747729605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQzoO7EwuSw8mpPTPqhuN/g/P8PkUFtcgSG2YcJs9sE=;
        b=ZtsbjVq1uGBlEDuVUfbrMnwJ4hvtQUPGBr/TL47MxbgmWdzjoxsTdbDJsSf+MGAgtB
         cs50KkVKT090Knuf4flfgaPUnur9flxspDlv10fEyevhqyEKFqDgfkRjqOURP36chven
         wibFgiLFWiyKuNN9Z9YtzkwbkHX8VfiSOete/6WCBnR/8hv2U0LbwtHKwbH2mkSQ1Bnb
         ABOtELKwyeWKXsxdi3HrVMC2eZSZkMO3xytklHzdbPF0yeJ13U7qWDzUlE7XO7JYyD9f
         b/XyyemJvl2nW0ALsX573eCh0aqIuBUAFNgbdCva0OcFUCOfDw31+ooSoDZDtVuz4crl
         ZURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124805; x=1747729605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQzoO7EwuSw8mpPTPqhuN/g/P8PkUFtcgSG2YcJs9sE=;
        b=lrYRzYdMBqc+Wsbuq/YIsjdtHefsFZ20iW6lnQ1QPf2ppkyJgL0e5i1VGr4E3ZWE7e
         UoipG1t5YpjB+W6kfQhuJMx8bXcw7ehLNKPjRWndf7cqRXwj3/dJ50wY//qcOvBLTXdW
         7zRPH9hlr+QYk8ngQ6rRME1pR+rUL4pQkmgAn8J4rTlAorOz6CtylwaetOwJ533my9lQ
         bVNUm+bS6KTCsmmwu3dYJoqBRFBfVbJ49ooPW97BJZSGo4ZEx1DLUDJ/n4Dpgo0WW7KM
         xlxeH+ag1V0CZy87nKddoUV/hWYjuuKeuWuLY/Crf9gaU41/yFXgyrWWl8WtiVueAKjN
         AvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUAb5yl3F6BZS5dDHUq1XrfNTE/BmkvBmtiAMPBLgJglkx1krD9MaAXE33aXSjSRm38HnWY5WXHd5mVqV54@vger.kernel.org, AJvYcCVHoVShyNH9o2ENj8DMhffVFLg2LLwaED1rV5uXKJf1DI6nqus4+uS5QHumoqPvXxTiIciBq6nqLUfh@vger.kernel.org, AJvYcCXQolqXItMhEV+7iUDQ0uH4lPt78qU8PWs8M90rJlP2A7u9P79aGjFzV4HWFc9mtv4239ZXf/6RHi6a@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5JRl2pXeG4slSNZhEQea1QnhhSh3SHQ8+7H+1qaHS/cwyxta
	oSuGX1hvlgnNmkymTTooSye3TXaaEWJfKmtuU5liY7IQ384ofYkU
X-Gm-Gg: ASbGncuI5GW5Hg0iIS2YsuSHUfspEml/v6XSrlZY+LYzJmImOmzvCERRqZVBzaXOQta
	h/sUN3QvTI0UJNFLPQiY/x0apzdbK7pr3Q3Ia4dOYHw/TRTZvG16L8cOS74r6IWtGV1utYkbEVA
	zFzZUOx1vQ3mr0Oy4EF8c3KBiojWLOB5+yxLkt0dwlCrf6QFTAvCZElbwehLnbn6MeT5UM6y6uW
	YJBfcQbCrfuc31FxgZLXSmcV7xAeCkk38Gy4JoJrIS+621g5Z1RYuOCGEGwIAbxVPhNsPaVHR3z
	5dy+2X0WbvsLIrpnHTpvT3iHIxC9k26//PaJSHdmyFENs1NzuKBJvk4x/Q==
X-Google-Smtp-Source: AGHT+IGt/r79cOZpdTr5DGH1Vl4HNdiskoZEzC2R86LYTIRXwk7+lkpR9LblYBgEQcWl0dUEh4AT1A==
X-Received: by 2002:a05:6512:6810:b0:54c:a49:d3ee with SMTP id 2adb3069b0e04-54fc67b23f8mr6142825e87.3.1747124804402;
        Tue, 13 May 2025 01:26:44 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64cc3f3sm1760230e87.216.2025.05.13.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:26:43 -0700 (PDT)
Date: Tue, 13 May 2025 11:26:39 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ad7476: Support ROHM BU79100G
Message-ID: <a6d84a4c9cdd961fbda38182501983f26cceadc9.1747123883.git.mazziesaccount@gmail.com>
References: <cover.1747123883.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VZ2m/pwvKXA9PH9w"
Content-Disposition: inline
In-Reply-To: <cover.1747123883.git.mazziesaccount@gmail.com>


--VZ2m/pwvKXA9PH9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BU79100G is a 12-bit, single channel ADC. Support reading ADC
measurements using the ad7476.c

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ad7476.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 37b0515cf4fc..6c5c57de6a58 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -2,6 +2,7 @@
 /*
  * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
  * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
+ * ROHM BU79100G 12-bit SPI ADC driver
  *
  * Copyright 2010 Analog Devices Inc.
  */
@@ -72,6 +73,7 @@ enum ad7476_supported_device_ids {
 	ID_ADS7866,
 	ID_ADS7867,
 	ID_ADS7868,
+	ID_BU79100G,
 	ID_LTC2314_14,
 };
=20
@@ -281,6 +283,10 @@ static const struct ad7476_chip_info ad7476_chip_info_=
tbl[] =3D {
 		.channel[0] =3D ADS786X_CHAN(8),
 		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
+	[ID_BU79100G] =3D {
+		.channel[0] =3D ADS786X_CHAN(12),
+		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
 	[ID_LTC2314_14] =3D {
 		.channel[0] =3D AD7940_CHAN(14),
 		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
@@ -311,6 +317,7 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENOMEM;
=20
 	st =3D iio_priv(indio_dev);
+
 	st->chip_info =3D
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
=20
@@ -435,6 +442,7 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", ID_ADS7866 },
 	{ "ads7867", ID_ADS7867 },
 	{ "ads7868", ID_ADS7868 },
+	{ "bu79100g", ID_BU79100G },
 	{ "ltc2314-14", ID_LTC2314_14 },
 	{ }
 };
--=20
2.49.0


--VZ2m/pwvKXA9PH9w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmgjAj8ACgkQeFA3/03a
ocU6qgf+PzR7eP+9s0Qu990z1detKnJ6AaAP29dqT/TbTCFE7k846KqDOzO06UNZ
tOfJEmK/Q1ltlQW2BrUfTrRJuPvISTluIbuiKWrZHRircvPx5sRpRWPM/eV3MAkE
onRtALIMm2HeYhQj3eBhaDzn/KFdP6QB2HNt9a0ygkoWwz9yMHaV1pwbUC71XALG
NDZ5g9XwvCujwLFo9sbVOPYlVLJ5d1jKDGnaXrz7XA8NKnejdVKem2nZCKPVTwK6
aNxNmp0vPDzId8kJO+Rawd1D5X7TVDejXA2Nrk7lkPeEx+g03b4nIt5i343HJYfo
JyC3m4i1xPp57IZDWqOu1iymhQLumA==
=zzEI
-----END PGP SIGNATURE-----

--VZ2m/pwvKXA9PH9w--

