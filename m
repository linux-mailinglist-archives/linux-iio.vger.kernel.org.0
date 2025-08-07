Return-Path: <linux-iio+bounces-22388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F95B1D4E0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8299C5625A3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DA25CC63;
	Thu,  7 Aug 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KabFeLze"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B5220F5E;
	Thu,  7 Aug 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559279; cv=none; b=seyVgBJ7+r0Nks2pwU7hI0cUmyO2hpCJ9FVJQJ8gy1SsAvTQYGJBXDDCgjwxbAgYQx5LzAne7a3R9ikbKQPqXyQTaZ0BGifeylsL5EFsXvoP4SjJWBuWA2vLNthtY31iNhnXHxySyp2Mr2pHec1kkD/Y8PAACbratRWR9XIxv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559279; c=relaxed/simple;
	bh=0vCIztPZD+BesSzci2t30zHZGAgY7hFiC7LgX3rS02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL5h7R+TO8HsauXqtxEjpmoXnboXo96DSHSC6haV97KzMoxEYmSIv0Jg1o477zTfBx0u0/UWKry5Qk1YFlwBAImRFg2SsuhMZrfD0Hvc5wccJCCkSfCOKrcPy0HfI1nHBDLFGbjA8OgQklYlrFACOAvAjlskCU/KYjI23b0FYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KabFeLze; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-555024588b1so894479e87.1;
        Thu, 07 Aug 2025 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559275; x=1755164075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=addgU5+bNFveu8gx7RdfbotqD9xo7DZxzvISYg2VFeE=;
        b=KabFeLzeIODospiIzHAxZthUEIUwY1eFWUmnswejkLkwu4k3aBOiamjL1bdZfkgKqs
         usYWFrZyRh1bReO5rrPVpg7PzPsxmtbY7CA7a3NU/Ei7Ah9SBEptCRDArWt/DUZ5/umf
         3I8dbO9jJ5zfwOKA2sPIGxlrVg6OGqiLoADlPMdlfmQgpRQbwxBcXmJNHi8RpDaBq01z
         1efy+TlgGSaaIxxBnMRepoTlKvfXWPlIuYgfAFaFsk655rvsxqFz1/m2YwasUKvhn64k
         THZHPuPkPr8DhW4yUUpNLhF6G6cGWdYWnYg6/8mtkoKY3Nr/puYGohU2Y1uISQ25AFeO
         pfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559275; x=1755164075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=addgU5+bNFveu8gx7RdfbotqD9xo7DZxzvISYg2VFeE=;
        b=dJbPIJCoT59qFkz1qvApYWS1OuZh8i0w7StsgIvM+hTaSxDQzb6J2lbseZtfiQ373x
         d8RuiO2QCkX9SnqesMWDDjMuM2mwKutSAdB7Ce4IQ6VXh1uGQpMSAuFjdXgQwzpsufQG
         XpDUjxUV/2B784wWjgzZR7Pi9KGlWpRf9Z5FFKtvg3WIxWUU2OtNJ69bD/jVhwFGVZZ4
         N9YXrjRzvGNtw5bnGPOelbxbKjTgZi8K/vkQZ52x/CMp+TBRsPiVZuToDtMMKFKik+ML
         exQYx7KOzJpz7sO3fvyZJUbXhQGsdi8jY7XORBIqc7CZbdieBWL9WMEXcX8sgSD7A3RK
         ei0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeyjSxJdOk9tSLrCM9StgyHux2d3JOlZr5RzAjVRHVp7gB8i5w5ZddUzq7L/rC34Uj14drZ2kj063tpVbq@vger.kernel.org, AJvYcCUm1/ViRc3A9lQZCSb7zhCnUbq3SeMv1yo0XAB6ZJEFUZjtYLZl5PXwI9+oPtS0CSSRl1x8oEFgBHes@vger.kernel.org, AJvYcCX0AC6PWPcnrtlDgXybT7mcaZ7VIMFrODSsDXCI8s+Mtc6rPeul/LO+4vbY59jVDIjpgCQezcNP5ly0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tq674nWEB5DVOAB0SiiCtFenRrupu6ySm9D5ydsyDUwBujUb
	gWW1vzJq1RYMZFSvBHw4FYA9lSikmWOrUNjZOzBfuDj3iL8CdVXk0+4X
X-Gm-Gg: ASbGncvk4Oclpocvh+JXfUimAHy8APUrBewQQAqetWDZcDkxsLcyeUDiRvyE0wilH65
	JHy3PU71tiJu6M8cdiCVposVUI7YoBDtFtKflcr7W5sx3QFid0xQDrKSh6/fEbzvxT03vdCwpXE
	SnCpw5BO/oPlDttQIBUB203szlg8lbjDG5C/lbf0tWRq2kNXfUUbXhjk2dkBikVqZIcM4KZYP4l
	IXDIlifvrZIONNRFVV7LLgOBIFTxBOYjWgUUQBGnDUCwLBqWRATjbGVQX5q74pW7y75SjQ8fYkq
	iL4FQUOFKgZT2Z0x24TbMNHxcxTLA93P3JmsXLpklo8oz6Pn7yYnfmvGQzR3eSrfOuSxMzBkP7W
	7CQhj/Vn9C87buGHhSnXfe6c3n+tH
X-Google-Smtp-Source: AGHT+IFVKMRLKU6d7beKECE+fUIy7Z0miFvbxfdxYF+dopbKIl3zZxeB9uMWB+FLrqjBQ2Q3P6/tfA==
X-Received: by 2002:a05:6512:e99:b0:55b:5b33:bc09 with SMTP id 2adb3069b0e04-55caf5f3ed9mr1798960e87.28.1754559275079;
        Thu, 07 Aug 2025 02:34:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cac6a3e06sm626646e87.172.2025.08.07.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:34 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:34:30 +0300
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
Subject: [PATCH v2 04/10] iio: adc: ad7476: Use correct channel for bit info
Message-ID: <3d3ccb9195271c8c0cf4b476a10b81fe309d3564.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvmQgl2tyCPpRLdJ"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--uvmQgl2tyCPpRLdJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports ADCs which use separate GPIO for starting the
conversion. For such devices, the driver uses different channel
information if the GPIO is found. The bit information is still always
used from the original (non 'convstart') channels.

This has not been causing problems because the bit information for the
'convstart' -channel and the 'normal' -channel is identical. It,
however, will cause issues if an IC has different characteristics for an
'convstart' -channel and regular channel. Furthermore, this will cause
problems if a device always requires the convstart GPIO and thus only
defines the convstart channel.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v1 =3D> :
 - No changes
---
 drivers/iio/adc/ad7476.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 7b6d36999afc..fc701267358e 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
=20
 		if (ret < 0)
 			return ret;
-		*val =3D (ret >> st->chip_info->channel[0].scan_type.shift) &
-			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
+		*val =3D (ret >> chan->scan_type.shift) &
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D st->scale_mv;
@@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
-	st->xfer.len =3D st->chip_info->channel[0].scan_type.storagebits / 8;
+	st->xfer.len =3D indio_dev->channels[0].scan_type.storagebits / 8;
=20
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
--=20
2.50.1


--uvmQgl2tyCPpRLdJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUcyYACgkQeFA3/03a
ocX9UggAtce/kkLmUPgbx1P/Peqh1yCesHSorqLGfQdCQUfKQpEMT7QcwHPFmxkc
n0j1vHNgWW/1bHdIhliJtApKS8JrLt8w7Ivsl2BPnzTIiolNiMFVFla6cYa29oJ+
/vg5olH2briUQd2U1NguGof1HvyqXNsZWnRBeN2QWniabl7npb8elU+39no02bTH
SGvIXmrcPGt1Xr6/V/0fhJZ+Om0qk0BjS3C4dxY8vT7ZPkU+OOoIJDioRbx1Unwl
fiTTegAkPJnjDwkGXlIP8BpHzICq/y8QxzoSataGFMUZA9tlSq47XqvH6ULlbXZP
dzVaN3SHq/EZ8f5gSFTodBw798c5Kw==
=+Jui
-----END PGP SIGNATURE-----

--uvmQgl2tyCPpRLdJ--

