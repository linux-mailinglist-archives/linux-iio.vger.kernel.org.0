Return-Path: <linux-iio+bounces-22329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B85B1C0F9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC3171AE9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34AB8821;
	Wed,  6 Aug 2025 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQbIwLa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250318C008;
	Wed,  6 Aug 2025 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463908; cv=none; b=rHUi/D11TS5morFBwCa0NmO+hiYg6JGH09ufXv5o6Dr9P7Mv1S6NFvovV480wLWIJ5nxzujT1a/f1uHtX/7/uJv9HxTQn/2SRmZu+PIvDC8HxVbGVDjcOeNvt65OEwDwewVF8IFqRrEW9dVWXlDtrpFI3nYUpk7U3vYRzQh0fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463908; c=relaxed/simple;
	bh=Y+pF57zebiOWKFC1Q+znjA9oBcuxDMVzZE2toqzqXY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfCpWQC8GcfYNRPzK8xYsH6C1g7I+vfSZL+wseEtzp0h/t15uMTuDgXce4tgvV59yjcl4b51SIPG/4u4TbkCdBSs4SvxsfIaiu/CCEyhD1fE7j70f8IHzpCJ9tuHH2GXQlFugTcJYXrtmTdcjKRzm/AMBXQ/eadigJde41cTPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQbIwLa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b88369530so7880016e87.0;
        Wed, 06 Aug 2025 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463904; x=1755068704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhfozYBANXGWHIriBSKZ0vH8S8S9zWtwffMAGQ2RIno=;
        b=NRQbIwLaKHb0bmrQ5sov4xBsIM1nTDmIa0yudUNMTnkH8Gsvwm2NdV766Svsr7eJ6x
         GRlbkzsilQerCqiEwr79Lg+OXWdLXgGyzNzFQfnEswYYA3OB6O3GSKBWm6Az2LFgCCdv
         B3BxeXlus9MFbEm45hFtzIArvCIgKFWsCGAK+acYTGjS1+SFnUO+fndKNdVpgV78lhvl
         V47X9dGRYHauniFjonwEgc4nvA9foTm6LYEfcJWEKFRb9VvQ9tnzubYblrXMNRoq7aA4
         0Ian1kivTOkttQ8yugUgDWdubQun33GQFDoEvm/wTA4tDNRrKl12DB9LTNvhPYGrsS0z
         Yr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463904; x=1755068704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhfozYBANXGWHIriBSKZ0vH8S8S9zWtwffMAGQ2RIno=;
        b=JE1a4252hzLakjmqRUAz0DpLdjlLynu4F2+SG1+jPMWBvZmyfcmRSBep0dgpjKJ4C+
         SCiXv4O+GNqNwK+WUTrHLDNvmB4S057wHQAynNYAfVyeF3XX/wc564WLmQeUZtgTucsF
         yvVcHTM7EUNRUVN1aV7MkxQtH6c/9pHBFjxhG3H1mCnNQqgeIuIjczk4MJvouJG+jOV+
         o5VTGu7tLaUve42/lKToduOTWg7QvbH/HdPzwLD/FWHFaxJsm1cnmkhFyRRMPzrHAT6N
         yxE0wdQSy9gHVHzmNh1LitI+XPGwPStz9yAosdnzsIQ0mZhufbIcwf/06QDTPoAl0llg
         wwvA==
X-Forwarded-Encrypted: i=1; AJvYcCWobDYUaSlO/hpiuBKErAnqKwDM5tpiLlTCmyLXK/utREuLA0PMZLzDGAcS9Cb2nslJ8w0yD6sBQMTM@vger.kernel.org, AJvYcCXdH2nTxEqLmSk9h9k0etA1wvBFhyqmRIsFXNezF2KYxSgHCOJ8ghS+O/nUVK6bzQdU6ZMI4e0gbq86@vger.kernel.org, AJvYcCXty9/QZqs0Q1zWaSsYJdypnjr40o3UBgvRI/Sjuu0DZr0sfJGydfB4NLM9haVJFCbMl3nl9AWdDFsXlyio@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWG+X68GvSaQva6nySJZsGcVVdB/2QtRQwvfdhQ54hKCNmLk7
	HrpCw/87W6oPQy9iwTOtUWHMNqj5qfTk4waKC+nuEJ/oSuezyt8zkKal
X-Gm-Gg: ASbGncsrWXFuaLp8NprijkRK9LmYZ58sWAr5/EF14lO4jDcsHBwMziHq+A1VbxJQk5I
	HoB6W9IaIrBB7uZL39wdBmT6Ss0ez12dNKhadJymzbuTfuZk3X+iV2eSbtcJrIlaVtYgCwmVlQ+
	p/KXaPezenS8/+/qKLqYHEL66yfCl6fMKC070kXOZPJjVb73TvOg9ij/9/eCOL04z+VgKx1ZPLY
	Ggvbed1FeKcHwdlzVruOuIhsfayF+aplLL1GacIAm9FGfC2SORQUo0uqhRXHEUlbwZ6up5PvYfn
	TgMGh6Cq8y+7hfqrYNNI+n+JK/bneZ204ztVBDy3uwNeOcoua+6G06sBD3hFun1Npivh/SkfD8i
	j1r2Gwk4TImAQpTnY5Ank4ACCAgpiTRTwryt6S0M=
X-Google-Smtp-Source: AGHT+IHuUpHvCNOZyBG2yyyYjis1jKNdzha8195ws7NS4POVNMfve4bjabBERJYaV4gbXwq8Co5JVQ==
X-Received: by 2002:a05:6512:159b:b0:55b:7cb7:f57c with SMTP id 2adb3069b0e04-55caf3c2e3emr520812e87.57.1754463903806;
        Wed, 06 Aug 2025 00:05:03 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9054sm21907041fa.28.2025.08.06.00.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:05:02 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:04:59 +0300
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
Subject: [PATCH 8/8] MAINTAINERS: A driver for simple 1-channel SPI ADCs
Message-ID: <d4c1ebe732640aff7ca36441df68aefd8ff84606.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FRYUNwuGdlf6494p"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--FRYUNwuGdlf6494p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ad7476.c which supports a few
simple 1-channel ADC connected to SPI.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
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


--FRYUNwuGdlf6494p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/psACgkQeFA3/03a
ocVNowgA0TdC3tO5f+X4k2YSfdqbaPiI5OAVA6kHDbpleeBppf0yWagjXh2ecY/X
B4d4W4/SrjOnfjlMdN9x+q5zacokUTDzc41f0mMwdwblLH84lsjfXto3YAMXVL1/
KdBgZ3tvLgKAa75NcQeNj9HL8CrUJtaiR9JhtzOuHT1AmTLsjy24OMs5pDL2zH2a
UNE7NZ/9zvEtsHTfFXCLwE5Y3gc3geakWhNgL+bp2gExaYok1YH54fogKE9CW7kL
/t5st4NmjsyOCyuGy8hsNUmhNkzJiGtNXg2B6A99r/FnjLFk79y+b6KI4QNatnmV
cHahdtZd+ZLjWX2YI0PmrBzOANcs5Q==
=1cUJ
-----END PGP SIGNATURE-----

--FRYUNwuGdlf6494p--

