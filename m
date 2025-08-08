Return-Path: <linux-iio+bounces-22440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9AB1E514
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC67AD150
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B72265CDD;
	Fri,  8 Aug 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI5JSdwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF3266B72;
	Fri,  8 Aug 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643375; cv=none; b=R/ZP4+6yfWaH3gOfLQWxsyOLsdR8eD5Z3iNYR6Zv3zqpvmzyR6jYIzMNVGr8hFcOR+hXci2ho6Ern6TG511yuezJzqM0+r0Xnu23iFMkMNGdPfVl63FK8qdDYRYaYzmKhLg45NLDKUuXCULPgeqGQkZZ4vT9On7kyJNwaTmkA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643375; c=relaxed/simple;
	bh=rFTTNR9H48DnISkyFQUW3VsEiJYCg3e1Ar2G9VaR4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/zFuVxw5pJpH90kt7f+y+36OBPTlVFR2NLrQKGjt31DHPoPJqMR39zpTYaGiIB/hdBtH027HMgcv8NPClxAgO+wBH2CFEHvevwsVHOKNcRuCuw73uT5T6TSUcHgDFl1uSb0nMGQ/QRpysx6290GB0bA6POby70SbwCt/+76Vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI5JSdwC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f1df58f21so18680471fa.3;
        Fri, 08 Aug 2025 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643370; x=1755248170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJGgSNIsweKWTXJAatM4tI8EyYGpipTjfGU8BW+ZG98=;
        b=LI5JSdwCDlBI3PyzvrSFhs7b3hQ8vLJW8ApI8nT5pxHru7kE8cDRaWgQJR6hKBszrv
         YLyvGO50RalqrdVT16H7DJ8jJyz0KQl4+ey7/1V5ykrDilL7PyE7FNoV3Y4Ofk6Xi6Wd
         0hyJXQtEWhVW+QZFPLMB/T2sXkaruAp4/u/IzfT5pIcVSEZHFT1brWqAVIBntHX24GV7
         yM1Xc1ZrVIKr9w6dL1+LokhXN1IlrfeI8g9hXcQwCQx3TD6+5GCEI0ETmwptMsTkiyWf
         LVc5Oi5KIT93bIwqnlIK84mHQBtpa1izTmI7lUZ2bRXSsCU50YvLECRpZElaHedqg7kf
         8SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643370; x=1755248170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJGgSNIsweKWTXJAatM4tI8EyYGpipTjfGU8BW+ZG98=;
        b=rTOj5D7Z37H/Q9nkiI1vKjtYzMJoBJEggaKYyIB4prQeLPirABNUhnhsU6ziKAfc/o
         8Wbp1rq/Hs1V1udsR8oUNusFvFqSIPn+3m7GfDGSfEBTnVlfaPp65/URCnHAzNzvtP0g
         QvLK7UdFS2PFZBz7DG6vs4w27BXixAms9SnSTYCZANxqz84OkieyoyGlgGDRFGO++sT9
         d8ziEGoAtJsoAowSFJMiqMrM+HVl3WW4/EPOu7BBFudcvuiimz1NpXmAYlmNN9TzG0/p
         8FbfYXYlSF7GDYM8RDmCskjiZBj5NdJjZv+ru9XazUjNHst8Ri/LdH+LK1OYKloboFqw
         ONYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMZkIiNvh4FeNzH9u2kOB9LSYBnEHy/VTv48z/eS17+FxyCyA+VXd2PiuEVQz3yfWCSYxWB+p80r1@vger.kernel.org, AJvYcCWIFr0hupGcwG7bCeljelN1sMSs3oPPCwSLCV0vsiEi0U4BJf60Wdw4HUaJBWZAetJA+Vb0aGjQKymi7NeK@vger.kernel.org, AJvYcCWYMAJuPYEPAp1aDgqDRbm1RlbhxeVxzVLUZ+pwEoClx95elXwtef65e/O5rhWwRT9U7WSRM3/iVV40@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYGaXsS4DBdLyYi8w24oSdbrRA/TBJ0OCJXR9Udhov25Ydyo5
	eExi3j/tUtC6MdvBK3b+sDh8pMX9uRyHoriGezjtS805XQgx6X+T+dwX
X-Gm-Gg: ASbGncuAMlf4iutmKQKoCBvgOm1Z0pJbqCQts/9vSUxxUsSrtwEQFvxWwlhA7pb1eTy
	mHiIcFNukkWhvgqm+But78s9s422wbrD7v2i4A9SMQUgya7vjHXLytHV0Q4KcdiIkyID/IzE4Sd
	S8Ydqb3fmRRz6z60ZAmHgWODqmyskB7RBPHLS60fyFXBatu8G0xSPycUS/pBuX0qlJ0Seabn9sP
	f5fXs1E0ZkA76+nndS2/BZl28TAo5U2TsPwI0XsX71AMIPVXroC+lhZDTy+EMW2+JLHAxA5Ex+P
	k2uncpEsCjCFOIKTIq35XIJcN2liSnW2wC4ayUoVSwuh2NXTiLMyVYfV6hSaAmwJbywmjk/k0I0
	6nu2Ldtd97YrEgkTWnZJT9TVVfmy2
X-Google-Smtp-Source: AGHT+IFfT6i8rxg9uGFLErOOPZzC0+/iMgekhVeg3vcuLBxACDh0/MxAQPSE4JM4lX8qkKIameQY6A==
X-Received: by 2002:a2e:b8c2:0:b0:332:4558:b30b with SMTP id 38308e7fff4ca-333a219f377mr5800401fa.18.1754643370176;
        Fri, 08 Aug 2025 01:56:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272d3fsm29654871fa.5.2025.08.08.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:56:09 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:56:05 +0300
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
Subject: [PATCH v3 10/10] MAINTAINERS: A driver for simple 1-channel SPI ADCs
Message-ID: <6ae3f5fd5441059b438350df370e7741cfc4b6c4.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y9CW4BizsC4F2rAD"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--Y9CW4BizsC4F2rAD
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


--Y9CW4BizsC4F2rAD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVu6UACgkQeFA3/03a
ocWd6wgA0QOQsbGEVoPJkwlKTnFdNu6x+Oom9N2gNWYEqivhDYJIh7nYGZ5/e/zk
W6pN1RSVoQlvVak0j4de+FMWMbVdO20bWnWJOqWZTSi5ml0xLu4fNW6aBFQJVW8a
H+tOk3HIAtxzbqE3WuKKDB47qHdVLCunmBMuy4jAOqOdXdRysUtW2eicWb6jNYez
WJ84tlIcn5MelMJfyLKQTHvVZfHpSSmN3ZRXABJU8EbENkxqMKji8rhIk+IK4Ldi
jhRGMpOs70xKbywe7PWeFsf/4+r5AgLLctEdlIGor6fsnWrzgcNCXZFytFUY/5K7
JCnp+ss+Jpk4OKz0f7PSK6UdBI94uQ==
=62nB
-----END PGP SIGNATURE-----

--Y9CW4BizsC4F2rAD--

