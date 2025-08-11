Return-Path: <linux-iio+bounces-22553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E2B2025D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E93B16A7F2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564C2DE70B;
	Mon, 11 Aug 2025 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvQvc5JZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483C2DE6FA;
	Mon, 11 Aug 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902365; cv=none; b=jkqTfw4Jdgdf7QBP18PoXZmcy4lJx/6zR7fC6ZGlK46db/rB7D8gWnfTes1fVDq2YD0Pa+YvhgtdOIMjvnXfGWFygWZ349JHPzgvvYMK86EVtkBkoukVIRYUIYJDf71bRPSAo4wx30zGMOfOuwKcqC72R9PJBbYN2fRqXMpTgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902365; c=relaxed/simple;
	bh=iA7Q7gsWziuOC/h2qXxxCFYwp++1PdWpffduqs8U0Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdEL60z6TJ+C3dDS+ZwVTiFMPoWl8HAGVvYr3fsL3C5wQesT8fvlCxlJ6qoh2d9Vnu/Zj//vqIw2lTtTllex2+u1aqvdevLYptEqGp+tYRQOBBERrRDQrNmLGkI/2yL7nzVJN+0iiJR88iHK0lwbvWMZrbMlcj8wQjZVDc7QY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvQvc5JZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-332426c78a2so32372721fa.2;
        Mon, 11 Aug 2025 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902359; x=1755507159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oliR58RONafJIpMpNgG7NIe6AG/sv5hnF3++Zw8Q8eY=;
        b=KvQvc5JZCY9zlFppHDC27ATKxRJo0KAbY+uitqxI8v2kDU95GRTzNEMZq2IvgvNZdb
         iLELCWKHivFYZ0tPdVrSQ/LHwNbtg+Rjm98zcxkH9WoWGPxihaKuXWkUmjcWii/t2jIs
         xJirS14HU12B4IX0O6ez48jbMjP0oa7oA5yTbWtqp01VecTBFFoxubs73hRzjL5StfvM
         pu1elFF0VlCNF9QGvvWCSyeJ6Uf+HVnZmxpmqt97ZZ2QkrnHTLBxBf1bYzz9xbeOKwXj
         UQ5PnuPx4j5l5BMGFYcFp+GAxzfSDsylsH7OAlD9885K0E/xVh+kF8NaQaaYDbKrhKZY
         oQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902359; x=1755507159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oliR58RONafJIpMpNgG7NIe6AG/sv5hnF3++Zw8Q8eY=;
        b=kI8NcV7ZC2jTEphXZLGb8aQsJtKslHgLU4Znll6MxNkmkpn1uh8l72/XujiCnC0bhY
         q2m9QWxSapVJ9e4cU31BnUJ0N+Dhk03RwQsKXtePJPv/LXffb/INJ+FflRpGydyoFWpM
         03FOVT19sJqLOsrImE8ycvTpJ0TYNTAihhk53xzGQ7LpWbY0kBP11SJ1FTQ9C7Z7wDqg
         hh5AjkdkrbDwHCK767ClUGFvdWI5kdt4sk5Vn0mNKdVTcCVdG7X9fpXp2BGAT7XPPCf2
         MnroivH8BfWoetHVmIgGVOQe2oVV4pj2TJ6e1Ql+QSRfZJ20PZVKmeU2rjNoi6YXLlrO
         831Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR7QNYPvvwpBFleraVt1HO2ZUCIk4dJOAJpZd5VePt1vc5MNSgBxew7lZj7GS8NU/K8MoQejTU3B9S@vger.kernel.org, AJvYcCV0/DeXON89aXW1hsoiHix+KqSXTbHbwUPrMoJZQQB/oqWY1z89n1bItn0Bbr9bhYcANz5lb90iKG/gTpsE@vger.kernel.org, AJvYcCXP07paaP4WJz0tEezHuN67p0XrwG1/UppA2uGV3jUkSGe3Pi7upKUXOlZIzsB9TU63sOHQUapCM82D@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFjjsLiKeFoEyuZ84yy0FkRM+3vw59u9gWrA1rquYZ+VPRsuU
	CpeWEwwswJ0K5uNi/5wXY3o8JRPGYYO90Lv4NKlAFIRcQnLbpd+kcLPb
X-Gm-Gg: ASbGnctzlRGOo741eubRb9Qf4MM3Ivdd5DOQJg+gRE/zeHcNXhNbHLTrZ8JiZ6t/p/D
	2NANCLhew3iyCsHkQSrGGii/VXjJ27vtEPZfAxQuwVX+kVhSJjozclKGNEwlwTxKzbQtD+Rponl
	eyU8rtmFpkGPlqa3KeZmkxVrlH3jVCs9fj+ePLyMkJyx1pZJ10O4vVniVPsLroLvG0uJIN+s6wp
	y1A/xr3oCkXaBvPXoiUwHnbfDEG2BIZgcEzRHrQMnL7tLDRNBZiaQW1Jb3jbBpwSzFo9FBhBRna
	JSP4FFT0Rm4mJX8cvRilDFZvdWNh35fVVQSle+Wcu8rNuoKwZHvJlBbEog2vVHLss5YQSK49dqd
	cbeHz8XwTqhKLv909CNFtc6bKEb5Y
X-Google-Smtp-Source: AGHT+IHKSFH/v9k7VUPl2eyTuwQzWg93gnsKYNlBAVQDlSlJdU0WQp9lq2SCdTiWZYc4XQSqOFHLxQ==
X-Received: by 2002:a2e:9b58:0:b0:32a:7750:a0e1 with SMTP id 38308e7fff4ca-333a223b8d5mr23089061fa.26.1754902359040;
        Mon, 11 Aug 2025 01:52:39 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333a7a116b2sm13423971fa.82.2025.08.11.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:52:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:52:34 +0300
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
Subject: [PATCH v4 11/11] MAINTAINERS: A driver for simple 1-channel SPI ADCs
Message-ID: <b952b543547523951ca87dcac86ba7a00a1c7673.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5P4693bN41puOZdB"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--5P4693bN41puOZdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ad7476.c which supports a few
simple 1-channel ADC connected to SPI.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
 - No changes.

I'll try to keep this on eye.

I only have access to the ROHM BD79105 and BU79100g. I would welcome
anyone with access to other supported ADCs (and time, energy and the
knowledge) to join me. :)
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8c8f682edf6..36fa6333f7b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -455,6 +455,11 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad738=
0.yaml
 F:	Documentation/iio/ad7380.rst
 F:	drivers/iio/adc/ad7380.c
=20
+AD7476 ADC DRIVER FOR VARIOUS SIMPLE 1-CHANNEL SPI ADCs
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
+F:	drivers/iio/adc/ad7476.c
+
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
--=20
2.50.1


--5P4693bN41puOZdB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZr1IACgkQeFA3/03a
ocX0IQgAhEfQ8vViRdvmtNKTjHF31C9nQlS8FaI+fCGeOvSoArhGDS2KYJACHpjH
Y64+HyOZTTvSzNSeediyHRklde3vmKD0ckJ4139xQl+dN1lfifNJHpy9csFbuxR+
Z/8YsVoHUgdTS+kh3+Ea/RuP/G8w12fNBHpW4I01E8BQFsajlRo4znAqs2F6Tt4P
HhPJIEDlHauSnfivpqqNfXrZAfa6LHNbP3XBLzT+V60eyKFxsKUZWd5GbMcdEGmz
Lm/3mjDtxpNh+rBctX2ptPBcFCWu/aUuZqmv8UnZdoJNCbVk3s+y0X4l+mLi4sVf
VZ2ksuCyhyPmrKOBjxDB6ljxKvlfcg==
=fTm1
-----END PGP SIGNATURE-----

--5P4693bN41puOZdB--

