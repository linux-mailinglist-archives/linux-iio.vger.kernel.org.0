Return-Path: <linux-iio+bounces-23635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28763B400AD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16E516A411
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BB821FF50;
	Tue,  2 Sep 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULSKc8yH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FED212574;
	Tue,  2 Sep 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816258; cv=none; b=mc+CbBzaYjg4jKrdL9YjkxkYYr5pQzUyYSP9wSZEHjEfK/obQpQFqFDy4Q5vLnmcwAwAnLNaTu+wGpLuHRNzYwOyeF2iDPoX09GAWzvpgfAj5sKzxNXB4DR71JH/7y911n1LeHgEfOLYvwO7+3gzGJM/NpzxgHxIXB6M58ETBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816258; c=relaxed/simple;
	bh=wH5KRVO8DrpRPW4kS9jEPxwcEskcMxWrkrT5TIxUJvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfEb+h1KbW4m25jWQzSwX9r8rbvN3q7JfaT14jYlEktresZx7e7oECOUXB3jKRWHES9BAcjtlhniGT80fZsB4+bYhhNNd16Qc5x8wxWdJdsUrULjzzQlJQQxnsev+qbEKTcCPH1PUPEruxRwy4ojqszWea8+L+0DshCt0Ojh93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULSKc8yH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so3686568e87.2;
        Tue, 02 Sep 2025 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756816254; x=1757421054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lP6s/YaLsqxk0SP2arlfn0tHcFpj43m+GUr636Gha9M=;
        b=ULSKc8yHUvUeelXwjtOXsy9+Y0Pcm2enjEo2Ykolge2FVcMSSQJ1LP6C5VPAEasgCp
         0bhtJsPShNgbiMWgel5VuWDlYTQXMBbr7Aq/JyVFq6ViHBdhxdy4Ss+8cXe+rgqiE7+n
         Ih9Ror06OZrUk36kLDU8HSUiRpvr/07332fIJFTv9hgJL38DcsADaVuNVI7C4Hr87dk3
         qumx9HiAHlaELRfZGPh4mdf4bvusw2GIsfyH1Fe1+5G/dacpSYId0ciu50FOJz/jfq5S
         Kz8YnL+1kOs/CCFkeLcw3WmAPw0+MhyNELTBazsZF+IVeA7aJXXZeZswcEN4Fc+2v8a/
         C5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816254; x=1757421054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP6s/YaLsqxk0SP2arlfn0tHcFpj43m+GUr636Gha9M=;
        b=OZuBAPMYPS/T8QhKSY0tGnyzEB/1PhKxtkWWfPcWLvfhfx/8d57dRx+3icUpvd+4fI
         3JvMvoERU5LSQDrrxHE4pGcFUQ+3a3a4TrSH7fuJMxyrSOXfFyQaGqT/5+AwOkMi3FFA
         NRFOeDZxO6O9yk7ACehMKIBQzoge8+rmLRffFfIHhauqCK0SbcKa89t4/dFtp+MclRjc
         RQU6fibZYwElhhuveS5QidBh8cWNuM2GCIGDzYpYDAFG+vi8Vn1pfCkNMF+vy0A9jqmB
         tHTv8tnoV+Kbd0kBMBvw+kXVXkBH6Y6NZqdP8kOaLRhsLWvSOCul4kU7i2r4KC1cS2/C
         3EOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3AQn4VIWmnjptDGIdWkQPHHvPaWpuwuhSLMIdgWF7/lbHRr6d3CD39HU/gMZzDcTqZ6FXvW2RPD2I@vger.kernel.org, AJvYcCUgznZDJ+FygmFegxYe70RnNZ6HmDYm+98AVIGvr3RnLaUePSzwrMWXDma3PvR8L2dVoDUBaDGmjvcE@vger.kernel.org, AJvYcCWQlEOgbFjaBmNe5bTi10IdwfhMbB9yIkxjzmXm2ON0lj84Fz4fccZscRi5l4thqrQRgbPWwM5jLtNP9MJb@vger.kernel.org, AJvYcCWdjevKtCyWk8sNDk6Xfj2ojgC3vlvwAQ+nTlDpsBzQ/Woyc9Aq7igLkuqkEIslQpG50o5ccHRsgN3uzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYrvbakC3rJyvtezkFFYZ5eSwnsrAqu70yNL1aF8WkgGJDKvW
	KGVHnJoASyAmPDxdfXrX0ZQLYVc7goTsCo4RBABClk4iDrnmIao+oC1p
X-Gm-Gg: ASbGncsok05rzXj2hJM6IZb82ic6nKqyLH/l9F6wFbsxHpnQ5pM8TTB81jj9E/VRS8G
	/vgNUB/JLFxSgg899qz2/RnxnE+DuawRrMIMuZTXt1UDQo5ccEnZ0YOfrjhADcwHe18JbFoUklQ
	7npJkRYCtpLViEn+5h3sNcyC7WjcvJbOfDbjbkINXEaxj5+ZbjB5Mkhw8LREI0G/uaHUcpYqNK7
	uqaB30jc+FMXBBrblnnb1CBKBrrSQI4Kj7lXGy75TLXKEbg+AcAk304FQz2f4yEXOm0Dfcxiofz
	zJHKRsgvvZZm0tRsVoeye+QatNookmvmV3qAVOKVRqldcqOfz0XzkDZMuQA+WQWe0aMbmgMCAEK
	63qOLD8BORmGpqlaLgv7EPfhGxg==
X-Google-Smtp-Source: AGHT+IHiEujbkskndE3LyNgJuL1872cRhTbw6Od3C9VG8ZLC8iMCXgMS0is4AXjx8NzAFqyDaw4FGg==
X-Received: by 2002:a05:6512:4383:b0:55f:6eb0:cad0 with SMTP id 2adb3069b0e04-55f708b4927mr3525218e87.17.1756816254164;
        Tue, 02 Sep 2025 05:30:54 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d1137sm678207e87.10.2025.09.02.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:30:53 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:30:48 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Support ROHM BD79112 ADC
Message-ID: <2af3a3ec00c4a21bd9df2b1746b96e0b84080b92.1756813980.git.mazziesaccount@gmail.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQvTRu61ZzJ2UjtA"
Content-Disposition: inline
In-Reply-To: <cover.1756813980.git.mazziesaccount@gmail.com>


--LQvTRu61ZzJ2UjtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
which are maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

This patch got some last minute changes after other patches were already
sent. I hope I got the message-IDs right - but if I didin't - I'm sorry.
In that case I'll re-spin series after some delay :)

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3d..8e78a1168c17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21864,9 +21864,10 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
-ROHM BD79124 ADC / GPO IC
+ROHM BD791xx ADC / GPO IC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported
+F:	drivers/iio/adc/rohm-bd79112.c
 F:	drivers/iio/adc/rohm-bd79124.c
=20
 ROHM BH1745 COLOUR SENSOR
--=20
2.51.0


--LQvTRu61ZzJ2UjtA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi243gACgkQeFA3/03a
ocUBzQf+IzkBnlIznAD2RxHhu6rZUnGRgCKBWdPvTcAGue3HUdtFr6vB2s+afHaH
HWTFTtgXiaDEdvIlDuiRqrCjODgx+b3QCU645Sj1Eh9PP7Uwbl16NmLFTUIXIkqY
qk+qC8KHZ/lJk1XbVKNKUWfvk8zJMWq6XEFrNJfYDwsLqYNv41esa/VquR11HIB8
KzY6PHS/62kLm8VxzGcK/GWvb0FB3mf1AwARw3E+Uc17idDGtPRIvQORPV0U+Q9N
roYvRbIJPvgPouwb+99rzJVZ6CU26IIg1ubjrL4oLbC6HcbLEpEn90wPolJjZK9a
LDti2BfOT20YnOH/27C1F4a5937K3w==
=32le
-----END PGP SIGNATURE-----

--LQvTRu61ZzJ2UjtA--

