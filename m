Return-Path: <linux-iio+bounces-22323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC3B1C0E9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7552B623CB6
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EF215F42;
	Wed,  6 Aug 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVTnKeFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA2214A9E;
	Wed,  6 Aug 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463816; cv=none; b=nLYnnw5w5g5nFG9RvhccpubQCjBR+MIa2ngFkaroh4WFE7d1Gc5NQM01uT7uryul+rXwW13HBTfLcyVr3We1P3pGM+TBvPwhqv4VMjPyprAIRoBT3x1HUKh3bEfCa7NnUoDQZ7QRh750AY51fVaR49Mt9zdKeZeIMfGUdZfEULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463816; c=relaxed/simple;
	bh=4MEWSyJSdSgUEOkaI35bYn5mr1p/Gmi2GcKbDNjT+nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNsAWadRtMKt9t7QyKNJ3S/6kw6uSDR8SHW7iHrHo6K0/LjwW6wjb0XBQJaFDxOkbdHNhdRTAwosw35IoPfAW6+OWPcRcxuaSZ9L4lVYBiOSefkaK9FrfN8gF9NkzeIi/30cAOEttJiUgPmy6eu9DvZehUgeUHr56aoGKD06RWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVTnKeFx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b8248e77bso6732993e87.2;
        Wed, 06 Aug 2025 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463812; x=1755068612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvraTRsawp4y9FAOlOtkh/dk2VyLHemGEot3EbZUZ2A=;
        b=NVTnKeFx1TZiGPeWVwQDY1pwiR8DAdr+qdLXM0LM2RYRVH8jWOTpstk0KkAe7z4B/1
         k0iXG986VGXZGtoeew/iVkP/9DzvWndZF7QnNvffG0kz/eE9VLlBTeKEt8ep8UDb9Kiy
         vRxddEkHaU+rQGicGICAqJfFFuWR32Eli0z9lIo6tJr5bvqrffD/rF7nku9Ew0A97OsG
         m9GmGRdVzkr4RiGZSZqI1DnGk3ko/Or4xf7MUNR5Tud+4QCOCHpPpHLkbO7sl/w7pB81
         qaeOo8Go4mgy4DDGqETXdJgDw+vBbsOgrw/vwx6EqXtN3lLrhEyl4yIuAdhIrpzX5715
         VX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463812; x=1755068612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvraTRsawp4y9FAOlOtkh/dk2VyLHemGEot3EbZUZ2A=;
        b=s5iSBt+uM1TUohXVCx91qT95tVkkHM1qyKls2ezC2qlGLt37AQJJ73kAjaIhwzX6Ts
         x1foaF4DKboPt+42ndvcrHvHOyJAQI9XffQUjzhqBvnyAJk8X5HjgBwCYP1bbjWBHCWw
         h+DC49X5lDvLs7Q96kipXlGUZz15oiH6r4uMwm+i5N0y397iAE+ya41PXtpxUM7HrYbR
         xXCs/E68ENLyY/GEmLAI6ZwO713VMBNZiUMgQkznUG6e3j+yifyib4F3XU2FdYydQG+h
         XtyYTSrZoN5GxRF/CxD3+jiUAuRqAU+1TgkibjuAI9QOToWrD6ajx8Vb0cjj04Kr93tH
         u1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9V2EP3FLdhNegleYDQKrWF2hhpNOhjttmFw3jLLrx5Ug+KTBKHY3T+WrUUjJsbUSNip89W5OTswo@vger.kernel.org, AJvYcCWkhQ0P4bPPtuuPU61V9dofHWiWzqjJ2lMJX8w9awn46ZctidAZbO7L4BgQvCw6DyHM6psAk4HtnAmP@vger.kernel.org, AJvYcCX7MV7LfFDQZ+WwB2uLzAxIcHaQH3ATul53MWFdKzJWNNut8Fwig/xCMsYsvkNe4ZngKSnG9SnBRVrWhOUX@vger.kernel.org
X-Gm-Message-State: AOJu0YwBki25muQU9xNqTnRqXx3RwVvZP8n6LgZMHEhzxYcyhtIcTIj/
	KJmAdvrQ3k5YGenZKE8FR4DVkQ4s3qnqwVpUnKNvbqnZGLkGNid+rmoe
X-Gm-Gg: ASbGncuZjMRn3/yJcdtZX5X8eMSjHqQKoolgiBpo5YKCqdwjSlei6KvjSV+t8xi3FHY
	6El0jMrmP+bDsW+PNRVtQdnX/sI5kFULfoYA+Q45T+Xq4S3ISiXxItl4SgsKE2xOrsXfm0IitSK
	+cITTedJnkdhrbVbOPjbC8GDS+QsO27Kouu/3ir3OCs6cZ0q57M+Lg0UyxF8bsxShnkNraabEJg
	Pa2GR6gJfLmXjbF2s3QvNy2oKjmkAOqISMA5WfxwrOtqe4plYXYc9WgPwWnasPux51Cud4vGYRG
	bewZolszF1A7wr5ZkSCqyNx1jUeuuBiv+sHFrw+PTuuW/NgQ5cveVvqRaZbs0PCGSjoREJ4KvOi
	XWHyrl5w9jr0PQzePIrOHsVr2e1oC
X-Google-Smtp-Source: AGHT+IF4E5QhU4dTzy5hiLifM/n/WDNYYbf/lVxxZBGDEgr3cbghxULYLamH+OhHaFCDL5O4NYVTFQ==
X-Received: by 2002:a05:6512:3c9b:b0:55c:ac98:edc6 with SMTP id 2adb3069b0e04-55caf3a7f3emr540790e87.41.1754463811791;
        Wed, 06 Aug 2025 00:03:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55c9c847db8sm262502e87.84.2025.08.06.00.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:03:30 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:03:26 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] iio: adc: ad7476: Use mV for internal reference
Message-ID: <8d2e75bfbf518848d496915e9713541fb7c9bb3a.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itIkFx5ypfyPt7Gy"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--itIkFx5ypfyPt7Gy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports some ICs with an internal reference voltage. For
those ICs the reference voltage has been hard-coded as micro volts, but
the value which is later used in code needs to be milli volts. This
results the need to divide hard coded voltage by 1000 before using it.

Simplify code by changing the hard-coded voltage to millivolts and by
dropping the division.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ad7476.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index f117aafd8fad..7b6d36999afc 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -27,7 +27,7 @@
 struct ad7476_state;
=20
 struct ad7476_chip_info {
-	unsigned int			int_vref_uv;
+	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
@@ -172,7 +172,7 @@ static const struct ad7476_chip_info ad7091r_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
 };
@@ -229,7 +229,7 @@ static const struct ad7476_chip_info ad7475_chip_info =
=3D {
 static const struct ad7476_chip_info ad7495_chip_info =3D {
 	.channel[0] =3D AD7476_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vdrive =3D true,
 };
=20
@@ -295,7 +295,7 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENODEV;
=20
 	/* Use VCC for reference voltage if vref / internal vref aren't used */
-	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
 		if (ret < 0)
 			return ret;
@@ -310,7 +310,7 @@ static int ad7476_probe(struct spi_device *spi)
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 		if (ret < 0) {
 			/* Vref is optional if a device has an internal reference */
-			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
+			if (!st->chip_info->int_vref_mv || ret !=3D -ENODEV)
 				return ret;
 		} else {
 			st->scale_mv =3D ret / 1000;
@@ -318,7 +318,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (!st->scale_mv)
-		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+		st->scale_mv =3D st->chip_info->int_vref_mv;
=20
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
--=20
2.50.1


--itIkFx5ypfyPt7Gy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/j4ACgkQeFA3/03a
ocUe+gf/TgUy4vDI2hkhfhfRwdL5eFtCxIbu3qyXMh4F/VnevwYftooo4Qah6Iml
qg5T5QEW3Pw9qkpzhQUJqXkFP2aMmijkEpKJRPqsFB4ewwdxGwfpBHaprrXAqsm+
3fQY+y3viOBj/RBhd/ZyrhbUYKzaL8EjDUaaXAlTHSIoa2RhyNbtOSFZwJ0jy8El
L6hIj3xBxYiCoTumZ4Q7P7rBlsxqtnFenUQD1LjS7K+KhheX4HuIFtZn3AoTEhVF
4RuYPey5HXNAve4IaMQQRzgJOL3EJ0oHx7l5kQR/cf/6DOzDxoAtT1EgWTzUhoKL
dXHKZ/o9/TEMaIqHOnG3UA3SolGXNQ==
=Z24F
-----END PGP SIGNATURE-----

--itIkFx5ypfyPt7Gy--

