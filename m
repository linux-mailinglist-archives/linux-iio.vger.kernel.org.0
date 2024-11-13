Return-Path: <linux-iio+bounces-12199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78329C6DB9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB051F21E76
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A21FF600;
	Wed, 13 Nov 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2IHR05B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99321FDFBD;
	Wed, 13 Nov 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496859; cv=none; b=P9BY6lqy7n/TZqwH8Onuh9CCkcwH5Xhc/Xnm58E2TzI9o3t5tpW65bQdsp8EUDZ3lROBuJty0KIbbKUJ0Ot3a7J38xyrN0Mih5ozN8CI5YBfwEVG3aZ51NB00B2udOn+8Wiln4PStO6/s2G2m02irUhxXuDot9zoG/mjc80H1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496859; c=relaxed/simple;
	bh=dXXwawVq71PejwQn8YySdZi3Za4V5+AbxkyetvK7poQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGpvYv3tPqm6e4w1Ew0esPbQPTIkO0s1nqAjgrfColaoF/1hd98eDoATS5vVbWPkMomf7++y9xciQshYb7ZSMwkLgG86ClAABaxEkgT2ZYp9Bb7vtl4u/ICY6ODv34jz+5WK1NnIPY6ANENT3BvqdoO2xtf8CMp/1NKB6abqVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2IHR05B; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da353eb35so176239e87.0;
        Wed, 13 Nov 2024 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496856; x=1732101656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0JthOn1E+unP/ANhBdZcgI5VGqlvtj51Bz6TfmN4co=;
        b=f2IHR05BCqszfIjwXAO5tW7nPFxXgxxCx8wyTKRtV27mGgK1waQ+VDNSYNclEJMdVo
         OmrGXb1gqMrOaYbNY/5+8U253A5tM8c9vD9KrREwmbAw8bHXxnC3QaqXpUT7aC+S4ABV
         2h5TBW1hTyiVmcL2+qVeDAqzNqOoLKJXy74Ii0DN0YreakWNjf9vqLPF2pdlBUrKVWvD
         JNbnC8sdDJAGyTlIm/eQFuG8FmPBebMzXYXskaLSgd3slo1PoQfI0y4gVmAfl1sQRCas
         cJqQj0yyG/BomYdgvsmWjliO84f2ikTYIlbRuhKwmo77JPbGOJtzWBDacW/8bRjte9kK
         ZJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496856; x=1732101656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0JthOn1E+unP/ANhBdZcgI5VGqlvtj51Bz6TfmN4co=;
        b=XTozsFyCBU7snSHnnZZJlnJaavifVZGOS4xQ8YJwA1aVqlPe1BmvTOXbC5bMultPld
         piTYhZ0dDviQOju/qgsVjCwvsgJLUawcSnqfzHKv4Ug4KgDofSi6HYO3OxQLktHd3MUb
         SWzOiFO243PwoXgTet9E65UAe/Mzz8bjZl2SbV/bbdPoML0LnTqcGaV5yFel/xpN+Jm7
         cxlUlO170lk1W5cGEAh3lTgh6vwFQdDcSgeEwFoRmuG0yHn5sdkQ0V0UZjx04xgvsVLW
         xcMwFaYg3dkTBKQcZyL0eMSGxLwjfhazvh7YfiQ2hjmsUBJtKlTn321E4e9a8Y99NA0u
         P4sA==
X-Forwarded-Encrypted: i=1; AJvYcCUvE5LvRY3V/t56Sn2KKCwzk6I6Bqw23Gjj8YxByPfm3tQDb+5bVQSMFwuf07ZkDvTI0mffTtKxfBQQ@vger.kernel.org, AJvYcCXIHePOJ7N18DypiyZOlY76VQhwb4r9KldYqp5jr69idt2fOO3BgOYT7rs/eNryav2z+/tglvwG/VyW@vger.kernel.org, AJvYcCXzXr4MK+O4S9aiRFXpgdvy5GrFxQ3PEy6Xmjm5A1UX0yqABLrJmvv5qHleCc+ORaZjaEDXkO12ec8KCmPg@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCRr+QY2XbeFCF0bgwjmYOQJABmZYvn4bH/w8H4wtlG+SKHDM
	tdbI5psuSPlqEgUAjP7xuiE7If8Zz2rWxLHF9TCDPERkt5KhqCly
X-Google-Smtp-Source: AGHT+IErCFAo4rgn2aiZG1HrU/7vrnVIVlRoLj0+JBHt3WvHqLQYCo+Og0CObPXKNZh0o3kgSTKwbg==
X-Received: by 2002:a05:6512:124f:b0:53d:a34d:70b1 with SMTP id 2adb3069b0e04-53da34d71b4mr254762e87.29.1731496855391;
        Wed, 13 Nov 2024 03:20:55 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826aeb59sm2171448e87.234.2024.11.13.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:20:54 -0800 (PST)
Date: Wed, 13 Nov 2024 13:20:49 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: ROHM KX134ACR-LBZ
Message-ID: <d979a0a8160118d560ba2255346d05237f73b9ce.1731495937.git.mazziesaccount@gmail.com>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AHTmJfWQs/LVn/Js"
Content-Disposition: inline
In-Reply-To: <cover.1731495937.git.mazziesaccount@gmail.com>


--AHTmJfWQs/LVn/Js
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add compatible and information for ROHM KX134ACR-LBZ accelerometer.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml=
 b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 66ea894dbe55..c973f4941a6d 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -11,7 +11,8 @@ maintainers:
=20
 description: |
   KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporting
-  +/- 2G, 4G, 8G and 16G ranges, variable output data-rates and a
+  +/- 2G, 4G, 8G and 16G ranges. The KX134ACR-LBZ supports +/- 8G, 16G,
+  32G and 64G. All the sensors also have variable output data-rates and a
   hardware-fifo buffering. These accelerometers can be accessed either
   via I2C or SPI.
=20
@@ -21,6 +22,7 @@ properties:
       - kionix,kx022a
       - kionix,kx132-1211
       - rohm,kx132acr-lbz
+      - rohm,kx134acr-lbz
=20
   reg:
     maxItems: 1
--=20
2.47.0


--AHTmJfWQs/LVn/Js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0i5EACgkQeFA3/03a
ocVTzQgAuI3BE7tT5i2/copsfWxt5YJwnKlenVou1JEaBpID1oRAKBJITXWUSM7f
LHCuvvz+lo4nwMn/XyRxYyC3YbipAkp7pI5SF+Dk7Cqc+NnQX6KrVIJysUZsWKgR
an4bph9I24qoEOuWrVZ4zDgGpe9Z/knSvSqVjE2jf/FyrhBRRRN43171i8V2NBuE
5Nrftl8G8QU67ZwmAmGtmC8Hn9F5rmrOQOoEuFZbNixyRs1wbWy20+7zhI2x5bng
lz4qbDRSC2CLzAGS8P8bbLEncBWUkzyqKJhB342UtGU2MD6MXPDxiGbv/sCrE2O1
gWSMilvfMIqy2+My+QFcXtuan9vlNw==
=V1M/
-----END PGP SIGNATURE-----

--AHTmJfWQs/LVn/Js--

