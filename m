Return-Path: <linux-iio+bounces-17224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258AA6D4D0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B63416E9D0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C22512D1;
	Mon, 24 Mar 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4kKzzuw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E42505CA;
	Mon, 24 Mar 2025 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800461; cv=none; b=BT4cjh/huO8SjVK/wThEWsiSHwEicrpGhMTfA5jsqfoiCOPLQtD2JO1a5pGTlCxt1bcuvir6opzytj6hIwKMFB+fR2uqKo7mhizjvEZQ7nyUZM3j+HqRyHSY3qf2LhwILpBHQrA21yuU//PB3UW3nCg5gBjUWxrTQl5S4sPsG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800461; c=relaxed/simple;
	bh=Wy3vPqiaLlYahW/IAM7YJlCm2a1eSBYC78uTW6IqDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/bZ2g5h7jN2uI8vYUf0Wg5G0CqPghf7l2g2s16781J1dwmP7D5vQih7GZEcwCD3YuNxAcMoVtCm0w3NgCV2MnMaKEw75jOV4kuikfgd/ZCR0+jAsr5G5kLBOaZriflw0ZXRn1WR3sSq8npyyFi0mURNeYr+/G4ZZaH6tRvzKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4kKzzuw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549967c72bcso4757030e87.3;
        Mon, 24 Mar 2025 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800457; x=1743405257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AszQrPJcVtm10G/JAoQuwy6/p9hq7KTTJ2EVW3dDhxk=;
        b=j4kKzzuwUjuCf7q01lCl1D+GTg7ZKmKJqCgMYbT/uSW7+3TdOxylkHeurswyUsq+eN
         gXU62j5Uhtd+QKjdw9QFnZulbPJyHBVYIz9Ci1lLcoGdpuydkq2QXuC5E0FY5Mu+xtZ7
         Cd0fhiXzspbOJynRzA3stJYvrOFEKKAA+UneOhrRb1TN5WiKESAcaGrDDBkjpXF4CDSP
         hKs60BWyequZ6/e6HBr4Is0TZGGFvAEjNloLNl5TegVzxjcR22R7AEB7waUazwTLXCi9
         DFpR8OPV4GuqPIjscs/w4a2BbKiFxLQLbNpg2Ldxs9Z+Jf+3K5iBOKg+xeWmpMT9QcXE
         702A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800457; x=1743405257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AszQrPJcVtm10G/JAoQuwy6/p9hq7KTTJ2EVW3dDhxk=;
        b=c9jQXj8yUVxrgkE+EuG/eR4gDxkMplIzxPaFIOHU4Gs3k+Vbt0hO0E/Dnb/024C8Zu
         Efa17+ayz8yrM0csTv6Bqfb0HsaN0EkQHCDmjMSlQ6sACyEKkGSIm3BLianGPGubcMvX
         flz4R2wRdqcdBlk/H8W0J+tLCcn3wuw+mci+qzZaWhS9xigfhWPHqsZGFKnzKsHuz6hE
         kQ1l5oyWa9KkR3VhBIwkXFGqALpQJibcgPgd/NLz5kOImtN4M/LL7hA1HM5MZJGooaiP
         CJb/QTkCW1Gwa1zEJhaG6F/itxvE0Vf3yGjvoVCaVoh7Bx4CSS6iXPmzrDVkPcdxjyzA
         IyFA==
X-Forwarded-Encrypted: i=1; AJvYcCXItzDT+pITS9ViI6fm2tpv6fhozt3mo11yybAw6DXZyt3goaddmF86Z9lSBmDJ6wVkOjwCj5jrLTc=@vger.kernel.org, AJvYcCXiKnDEtVHDZF77YitdpZa9KcDFfa57BHhrsrd96idQq8U9Pkzw6zwmSQzGyiCoYZgqp7Vf8OEduKB/uLvI@vger.kernel.org
X-Gm-Message-State: AOJu0YyWO/MRB61SB4f6vp/vt3NXdzi8Ik09H9syvodLuWJMLeyMMd4k
	RokoyGD2kvnrLXZPEGmMwl73y9feB9riVCizwktvliJpL0rjRelt
X-Gm-Gg: ASbGnctg0UWVp3A5B5pe/Twm6O1oCQrFg0iSGLgFFeDmX+Zcj44l1Od0akAGUTCoWNj
	vOTZafxA8JF/d0aAzxLt3FBUiBWHetgL+XjsuwbltiIP4YScpDMIvWoyWdkrs0tEzSQ5iL2pD2B
	Ql8gYRGXVyHxE6Dadda4DQakqeQ3FRa5/vfZo9lWdCtkYZOkgSuhZRRu0pQI+QD91II9xxVpkgz
	ycK8Wyrb+RpSWwJzS81g9ICq4wQWJ/v4aUJJMF3GFr4Z7+Vucp9TRf1072CZk6scPdiXkkdu5m7
	/GKk8VihPLT/UBD21S/H3aqmW8ym6JTMMXX504o8pf9FUp8jpQc=
X-Google-Smtp-Source: AGHT+IHfv5aFN0tDmB64HQusf6jSJ2U6WNfQ0VWY8vXw9sHof5NsJQ8OBHmeGKbr2jfV+OxBSzm5aA==
X-Received: by 2002:a05:6512:3b82:b0:549:8f3a:f64 with SMTP id 2adb3069b0e04-54ad64b30d8mr4505976e87.41.1742800456590;
        Mon, 24 Mar 2025 00:14:16 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64806dcsm1016682e87.96.2025.03.24.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:14:14 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:14:09 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v10 8/8] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <fa3b65599592c1685230a5fa95aea6ed12b0b504.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qwb98GzFX2VTic7/"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--qwb98GzFX2VTic7/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b96fb864227..2e4416b59930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20547,6 +20547,11 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124.c
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.49.0


--qwb98GzFX2VTic7/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBkEACgkQeFA3/03a
ocWizwf/bQfebv+Kaip7GLqV4xairEUMHLFWw3EJ/ANa3YuWdKdymkOh6ZteleWk
6QGx0opk0hCNZVSRsm+jmy4kGXD9bb74qPZ3AyMRuBW67GV1E9aR07k0TyCvHDka
mAf1XiMYK+TUZ2BOxksjcXx6yuzykOCemAXhCyuHIT1WMIbNH0Aid0HwY43pe4VI
EPN000XObLc9RELHHuabVb+eFmIhCKftVwzZCkfZC89tHvKuVQtOSrFt2hMrpt/T
XnekgUHAWBVvvY1nvexvT8kz9vnGRfV3vRD18WT0dC1IJn351DLoYKgiuWggpuKH
ryIoLkKIKv7OIHdXEc/EINw9Fa8hMQ==
=yP3X
-----END PGP SIGNATURE-----

--qwb98GzFX2VTic7/--

