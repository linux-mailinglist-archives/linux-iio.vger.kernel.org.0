Return-Path: <linux-iio+bounces-22433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95509B1E4DA
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C590725F6E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A926C39F;
	Fri,  8 Aug 2025 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX///wjg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0B2701B8;
	Fri,  8 Aug 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643123; cv=none; b=nJ2LSMNbd7Lybn3cWC2+BKIYCtmdRfeUJf+u/fBHTsSx5gUzpNX5fTbHxF0DzENCn0S2031I8dTi/61GpWafk8MfippnkZoj48HWkQN3YPdBF6cdoTp5/plupRoaGIM/FplIoqt/ufr6RVCH/S0ZpzZSBint0mIEJpMlxyTrNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643123; c=relaxed/simple;
	bh=hXax30hPNqVdmhIcGenKACURw/1LJUIiTO6jkgNE0G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qywMFNpygPq2qeTTlclFRDa6+rQKXW4rhQzLMQkR+w4BXGCkrwrpnxjWJlBxat8E2P19KrSmAPKHW6URuN96oSYW3RGbpdsZGHJ4nLtAKaQZFoPeAom0BUixxHhiZfoDlXDucpnzwHFtt/BhEO001sEVE/hU9X/hhVGRrOIHlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX///wjg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32e14ce168eso21343311fa.1;
        Fri, 08 Aug 2025 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643120; x=1755247920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uk9uYnO2k/H8U7ZKcVEclWdd+mcBTjgDHY2cVw+2KF0=;
        b=MX///wjglwVSISKqtuMTf1i+rhlNyoZTK1nqKaDtrXVOYe0HbU+Z9SYLOwhFtTSL4k
         JCgnoYTLWQyLuvUvuw2rzaSRk4wtb/w77rPBCl9aIHnl4ZYTluWv32MHMv7AGI4wXdSE
         h4rmns9tsA1QP8vTjgw+YtugT3XtXzp6vrHQHZ7/Olqvk55Qth+3l51ms1K+vy4D6dz1
         ZgkYtzAXdPWoFJZ4ps1BjbGnGw03JJUUwbo54GM2IN9Ww2E0HEFZmX7fUsWwRbSbDT07
         5p7ig/4wsvVqYlwP1SZANfd9bGbvdl8yguAVvC3x4Pazf2Tyih6a9YWE8okRiphc23El
         3HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643120; x=1755247920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk9uYnO2k/H8U7ZKcVEclWdd+mcBTjgDHY2cVw+2KF0=;
        b=lTkXbVQvuc96PvzqCb3qgSow/aq4XC5ZcIRsEBBCJoyvq5uPlYIz6Tj5QW9S7VCid2
         4CZx0IeLLfTwYLX6anQ/7OKm1cTqYitW4aF7I+2W2CgUaxyKEtb12JRLo0DDdVXXGo1T
         Izv392dRpYpHrxYxpfxs26hMerhctDVcee4R/+NTdUpg0qXQF9jjQMLK2bzQ6dec9Uvy
         insn6tsSKi1ldjONesho5Pv0xfcgh5hExsiPqvmQH7YogcgzYqrnWXQjaweBBi9+jI+i
         A+I5iEKYLTb0V70ddJVIMqZvBXkGci9lWPWloF96VJG2qXs4t2d1AcBAfZc76zMfRXD1
         e4DA==
X-Forwarded-Encrypted: i=1; AJvYcCULoBqJ0r6jerJCT8kG1pwL6raE8yt1UMLGs0jhlOhemRklKTCNyu9O4okUIbgHdxIZoCCKy7jYYZQw@vger.kernel.org, AJvYcCUmJhDAmwOgh9pQi9PuzSaAJSejuZMpy0XZZ33AEjVtaWs4kLssS6W8B/kf7PCKH/cs0XIkCqziH6VeoWIN@vger.kernel.org, AJvYcCVnZDJMRYoMCy2Nv/qTovWfzprqpNcF9/mQfPKwgO4wu1hbW9nlelRH6EVoGor5gPWxWq/g87wNb2cA@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJrjOiKqMOe73DPJyvFswCSUJxDOsrFJJFiUL5wOTigR605dS
	yKMUyOUv6039f+5laKCxcGkwAHBaAETOnxHUjcJyLzETAWmxx/mqyxb0
X-Gm-Gg: ASbGncvUzB7xqHpbqZAGhjm4oR52QyV9gPGRT5gk+Fq/w0RO7b4YhuSWZCaAcZsdDPo
	jQGpW83l5RDsgt+XVIdTYyumQuiWaLEHpWXb9fPwn/sn2gKWnVGEJhPBqPFzWh/ReTg2SxAArcd
	M+gfW71qH2KVma0q6+MIdd3UTocI0OhKfOl7amKf8H8IdghfuXPabbYUScyg97KhQ2s5lIgNl7t
	VNIrmHPIfIRhbU4myE+h7fNCggypdF6fKzC6Khw7+cEYtauefIfuUvHQ1YhsevLT/PmnJh84DGj
	HPTm1iLK+BbAi4z/BstZy9R5cFfWuHZSFcEwrDNPZ9Vuydh3UGL6qHts7My+U6cI3xYxM0wgNEs
	FpYWsDPlnWH2dNa08K/vtROG7/uL3
X-Google-Smtp-Source: AGHT+IH1PpY8CgkA5Bg3NCmK/dOoF+72ZdmthEr852KsboOQgSGFoC7KDSIhSwH8r9XEgFdJMWuotw==
X-Received: by 2002:a2e:d12:0:b0:32a:74db:fe73 with SMTP id 38308e7fff4ca-333a2260534mr5613971fa.28.1754643119411;
        Fri, 08 Aug 2025 01:51:59 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33250b6beddsm24847751fa.56.2025.08.08.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:51:58 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:51:55 +0300
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
Subject: [PATCH v3 04/10] iio: adc: ad7476: Use correct channel for bit info
Message-ID: <fa41baa78e9490cf169ee590e3c798d9a1d0d274.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czxN9WWi2bei8M1w"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--czxN9WWi2bei8M1w
Content-Type: text/plain; charset=iso-8859-1
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
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
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


--czxN9WWi2bei8M1w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVuqsACgkQeFA3/03a
ocVfTAf/ZXmreqOs9o2ad0tQgDoNhMfkc5dp7pSNlIbn+dp5Tb/WutJzPmtRGY2M
Ku/+ba5JRgCYkOZIe+iJDDgovWhAAcZjxjtUSNMf+7QOkj4CaVr36h/Jmb+Un5lG
mu/vvM6w1FpzZUHmZxU2ZTt5r8+quQtsgZ+jucKsGdx1AdBg512qk/WVffS7ug/J
mi2K5UMO2gOxY9Rd8xBW2iwqN/xort19e8sTCW/khP5p6hS75Q6IogfucZ9xIkMM
FqxAc+EWc3nHAVqNjjKOGV9a1FFn3EMj9mKbe/GDmNUY8GoBQJL+5M4HWADHpW+p
fEYD3mWbAWNcGtsVVDblJgud0uiMhg==
=Ritm
-----END PGP SIGNATURE-----

--czxN9WWi2bei8M1w--

