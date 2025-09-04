Return-Path: <linux-iio+bounces-23707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE9B43BD2
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32A3A005AF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FA2FFDDD;
	Thu,  4 Sep 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8ia1wzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1662F3C21;
	Thu,  4 Sep 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989433; cv=none; b=nIZeBhFLiBv0FXwpTxW0G0V5znY4ZHZ2Odu52HN8H/Ppa6ypBZod2LXvQFMz/ZldiYkYgGWSt8PqsLftVP6sH+6ccrdgfl2n4+vzPTz/kSCjhxnW77poEqCu2vbxtTRelMmMuuDxnemuC9U/5ZzZeG/ne+vwP4x7H9OW7ZXC/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989433; c=relaxed/simple;
	bh=rXBmsI4w/3h8ir12BVsWSwZi6qczH8g4D17zg11ZzC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkwu2S2m2UFIFM8QSJnbhU4TKN+UJ/pv872rIeohvhznZ+Ru16jJfjXxgFDurk9wx7jz9jigf2sIWhmoRGn9HafjtPo1MFP3NkD/Le8WnTBpGVtadLcxQAx7VyfndiXaCj0jYUwgIN5XQADQTS0R7YFaEMu+rXS9YOHbaSuw/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8ia1wzj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so1163362e87.1;
        Thu, 04 Sep 2025 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989430; x=1757594230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utboUAkRWD3W823EUt0eFdmV1SheR5646sGCHwREubE=;
        b=T8ia1wzj2alybdPtwsaEeHjLRcrxvVqOA3Ya1GH9dXTR7tzrzLnoE0QRDyQmL+dtqZ
         jzMb/hmm+UCgNPKT4/e9u1WbivezgKPvVGtSIhk13Huy5QpsOZJR4Tbgg17T476d4Mul
         DEhJlKHa1o18L+rlKXQ2A8miLW93d8bgHbdV6+O6Ni/MDIvB5vFbg63ECtxr4JPBqjhQ
         klbxDSTxe+AQVgSTzdayWEOaZT5dhUtiF/r2Uqv7MPW3ISK35omkf7pS7nAdLVGuXesw
         M6YwYiXHW2XkLcHIQ0Cya3Ej1APyG+cbcKfvkP7mtQghDgZ+UkvdxjfXpBBVM9pV8LUX
         l/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989430; x=1757594230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utboUAkRWD3W823EUt0eFdmV1SheR5646sGCHwREubE=;
        b=OdhTtM4gunRXaRzl7P6SYOgXWrmgT5BQesYHxG4ugDQJyMmWdERXEGvShs1lXeOflo
         647Prl1O4md4mFx5qawnzDVPH3ucDVMo2ClHL0d8nDG+DnHt+hD3xdV3Vk8zLbQpAZD4
         kOzJwRA9Uis2ZF5dXqv684Ld1N8FpWgEJZZzQxgdN0twc8NUlYvQ1w9FH/pY0NsYmELm
         jQkJd/kaqqJia61hIzd2TsDnLhmdP2GwnpL7aHXEjCNE1zaBeHT9lVz+9uJabUUodMk1
         z3IkKGKAtEw6QwMPNid1Fcwti1eshHsfb6L4sflSXsk2P+zZTskUUwmjuDjczqwrvLXy
         KQfw==
X-Forwarded-Encrypted: i=1; AJvYcCW7j6212u/BwZQpojM1rMWZPuoakd7XxWugVuNcnJxB50r+sRpgCDUUIz7eRFHnGIKnEsLiSbQK8N/Y@vger.kernel.org, AJvYcCXEkR3jLEKEN82Og+BDDN4hqcad3GYTPXTEhVrzltUDk+7O9fqoByO1O3MagNvotDvn9tvLBtIKQZxC@vger.kernel.org, AJvYcCXJgZL/zIscofCQ52UsPZShWIRcpv8DSXr047bl+hM5Pq5LTz8NBkCXba/EHThGtdCuQ1OmDqDnASWmhg==@vger.kernel.org, AJvYcCXeC9DqVm6hXjpD/inVpuTDaIsfidY0p4tGiN4thLviY1LZwgs6GuS7ah50PBR5OTTfooSB5W7UeaiJAsP0@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7+0WeLVO29oN0HmFg3kASD/HXiv6b2ksk9gsU99z5fK0Ha2+
	iAi1ihhcSHA/ltCtEvxWu/GifecwdvpU9++0Zo2TcxkiMUgUe88C/Fko
X-Gm-Gg: ASbGncuqixsKzfprc04g1IOmgfSKTImyYyWcREHIxJsW8t+b740xFlE2gnSC7RxNJKK
	UXz3bEakDYhS5VeqDxZohiKBCBYJRRCdYWBHREQm4Ax+C/0r71MV6bQ70eETDf/HxU6utXEw+ly
	pvvICo49zBlZvJeB1SV5cZx7pJaUwYRgvZJEz+yMaKxQkotusKNDufWiX7CYPnzxMbThb9UEy23
	chFmk7liGatsBC5yzxTZeff/0FwyzxDfed2sb1UZ6uKT55f3fmKyFPmlp1mNBTzI8TukLCVlWPy
	swz7gxakzxfh4TI9eJxSCqxij1hB4vTdjxgc/csRCdVFvWn5G/8mTaUws76Y0hXFZi8R4yuDHCy
	5DXNv2ctLhPXfVfne6LIA4cwC5Q==
X-Google-Smtp-Source: AGHT+IGZFdh/1hV9nEbPLIhK0qnUZcojDiv933VLC6F/dKSgGvYZE/iGr5UVxQrrHfo1EJN1zz/6cA==
X-Received: by 2002:a05:6512:2c8e:b0:55f:4856:de87 with SMTP id 2adb3069b0e04-55f708a2d51mr5987953e87.4.1756989429865;
        Thu, 04 Sep 2025 05:37:09 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab928fesm1151046e87.37.2025.09.04.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:37:08 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:37:05 +0300
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
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: Support ROHM BD79112 ADC
Message-ID: <7c7e8e80e128d2eace1c1632de4315de3df5e8bd.1756988028.git.mazziesaccount@gmail.com>
References: <cover.1756988028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="baTTKEtKJ7KAcghN"
Content-Disposition: inline
In-Reply-To: <cover.1756988028.git.mazziesaccount@gmail.com>


--baTTKEtKJ7KAcghN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
which are maintained by undersigned.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - no changes
---
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


--baTTKEtKJ7KAcghN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi5h/EACgkQeFA3/03a
ocUxwAf9EYjDUo85Y8rxE5OLosjz9/BzWTPZjcx8ZIQn+G40FUS5RKDLmfbyu+XE
RAdiv21ezKNDQkgSboq5J5w0lc+st5eHvcWDPJ5ZgecCFyvAVRV6jrFz5qKlTnX/
YNZYqDXVvAi9unpDSLpc5HXKUNeugbKBa1PpIuE6uLcMmSO00MBwG1jlBQiFlG4I
dv0+UDKQGwRXpAvW8T2d3ZdmjkFp3IrNbnLPxXQBTA8cyAh3l0jggFrcqhRSqg3N
E8glw4Fa9iALJN8U7vy/jtyjbbP4wNSCgL6htuxDmhahpTVx23ACRd9lZH5FjNSM
V3ySUCKMHnIRSgCrPGXyuSs182ZLkA==
=yme7
-----END PGP SIGNATURE-----

--baTTKEtKJ7KAcghN--

