Return-Path: <linux-iio+bounces-9126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFC96B3BB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB38C1C210AF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323E155324;
	Wed,  4 Sep 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OWJVwDHn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB3146A7A
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436742; cv=none; b=tVCcc4qPgiAxvHSQ2E/6BGV6jyKT5y9VMWbXu6rM5d0AFZW7FEkXj3hJFk+hLwWjcfVNBEF5DXDzOncII5hgHOcOCAlW5+kChktuJps+yPTHZVCnABVSqB9hupefxLlaQljmi78mKUTkHshLaqcNRKoNGtjvmc+xuxG9QO3XqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436742; c=relaxed/simple;
	bh=c2jAvJRISFmKTJLAivo6CZeVFTI+zZ70Yr/35SjCgB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXcUjryiVhCsvtTqLs/mIQYPJweIBrkoGdmJRnPrutH8/Nr7MQps8xxuXlJP9vOdPG87K2G3p2J8ui89OKxOaW/qbjei8l3G/hDc8zfObxqXe6d3pF7yo9KaZsTxUMx9XRyXuocBBWzMhx08WHPEilLCLsPpZY2cWUwG3e/EWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OWJVwDHn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86e5e9ff05so723304166b.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725436738; x=1726041538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o38ll/1shPkcH2c9qDR658TMHisQqMl2xPlWoUMdupM=;
        b=OWJVwDHnMvMCmaRJW7HdKr2jeHfY8//F0rB92qh1tL5zV2KubY62VlnZh43eMojbC1
         e/ibN1Ky5R35wpXUkrpNi5z38Is8EIm3QkUbLFknEWTf0DZMYgoZKaqpw6sHpNNnVRiZ
         ewhuwAXtlOEXZJ8hHjvxkB3YyuBPEtJe+DrhYKlJmmYzSC8A9LTu++Aw7tFOorLvSQXP
         TqKcPddE2278eDMlkRkuUKO1RZlgEmTfw/dfrpWStHKZ+SdxMjd8P/y45pf8EhGOYi1i
         ltCWJHrwRU8UVnC2VTxFYHkwFsX0zxUGyxH6oyRjCy0eMpGEUQxDPjFtugNMxzraACoA
         GX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725436738; x=1726041538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o38ll/1shPkcH2c9qDR658TMHisQqMl2xPlWoUMdupM=;
        b=KoThAXFuP7hB9BDNY6lHV5MDpXQrldzkH++4s3GT5SCiXpVuzSObyEmveFx2JgcDg8
         Agtzh6E+uHfWZWw6rr9njzH9m2hNYMf+/K4Mz2Mfc6A2FXpRwEgenE4uWLD4b+ywxJho
         r68kUYkqtLa2QNyQmUYqZbqPS7U/Mcmlu4rXw8KDF8iiyqr6gdIwi5DaJrqYWh00qzme
         C+gUMnuVE/lmwyUg9/t74ztzd9Mb0YdvgRelX5jWA9MU5AQlE/T+2g1bsRfbB45l8EYY
         hQ7bkxKSTkUEOEzYhmQ+AiRXVQXmsVoC5pkwnjH/zR4SepsSFmBdK0k4y2HzwGnqs7ra
         J4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvR7JjoKrNzeE3T9D2tDMv5V2oaRm6wwerEPpXohYDffDKcLkqZKhGh4v+7mWBkb35wsPI4Tp3D4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvkIElKsWld51wKRc7B6JSN9O0QpAVmRV6DdECobVdEl0AMkD
	ObqXyIXYZmUeNDXNgIQX0n35sBiyvDqGHVqmsnOFCi7Ak9nd1nKm0puvrHvf2KE=
X-Google-Smtp-Source: AGHT+IHbXWBNh7i4cmQrik4TDTg1G8pCMakv2oa+Dk+9s51s/80FIoXVDzhEC95r4WGClTNuCsuPdA==
X-Received: by 2002:a17:907:97d1:b0:a86:bb5f:ebbd with SMTP id a640c23a62f3a-a8a32fe029cmr183723666b.63.1725436737475;
        Wed, 04 Sep 2024 00:58:57 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892232c7sm768623066b.222.2024.09.04.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:58:56 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:58:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: ad7625: add driver
Message-ID: <mgsig2v65adwgfhofxk3snfbtibgjfeiqqj4iw5r2aquak22ve@3ssolag3ousl>
References: <20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>
 <202408201520.lFtco3eF-lkp@intel.com>
 <7658aca4-a408-480c-98b6-4637bb86b5ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yytpvatfhmknuuz"
Content-Disposition: inline
In-Reply-To: <7658aca4-a408-480c-98b6-4637bb86b5ad@baylibre.com>


--3yytpvatfhmknuuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Trevor,

On Tue, Aug 20, 2024 at 05:07:27PM -0400, Trevor Gamblin wrote:
> On 2024-08-20 3:19 a.m., kernel test robot wrote:
> > Hi Trevor,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on ac6a258892793f0a255fe7084ec2b612131c67fc]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/Trevor-Gamblin/d=
t-bindings-iio-adc-add-AD762x-AD796x-ADCs/20240819-221425
> > base:   ac6a258892793f0a255fe7084ec2b612131c67fc
> > patch link:    https://lore.kernel.org/r/20240819-ad7625_r1-v3-2-75d521=
7c76b5%40baylibre.com
> > patch subject: [PATCH v3 2/3] iio: adc: ad7625: add driver
> > config: alpha-randconfig-r132-20240820 (https://download.01.org/0day-ci=
/archive/20240820/202408201520.lFtco3eF-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 13.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20240820/2024082015=
20.lFtco3eF-lkp@intel.com/reproduce)
> Seems to be a problem with missing static inline definitions in pwm.h if
> CONFIG_PWM isn't set. I've replied to the relevant series on the PWM mail=
ing
> list and will add "select PWM" to Kconfig for this driver.

I'm not a big fan of the dummy static inlines. It seems to be a somewhat
subjective thing, but I think that usually if a driver makes use of PWM
functions it doesn't work at all if CONFIG_PWM=3Dn. Does your driver work
with CONFIG_PWM=3Dn? If not, even if the dummy inline was there, I'd
recommend at least a

	depends on PWM || COMPILE_TEST

=2E (This is also the implicit recommendation to use "depends" and not
"select". Currently all drivers needing PWM use "depends" and mixing
yields strange effects in menuconfig.)

Currently there is only a single driver that uses "depends on PWM ||
COMPILE_TEST" (i.e. SENSORS_PWM_FAN). I already considered changing that
to plain "depends on PWM" and get rid of the dummy defines. While I
didn't tackle that one yet, I'd like to not introduce dummys for the new
waveform functions. So I suggest you either stick to

	depends on PWM

or try to convince me that these dummys are a good idea (and then
probably use "... || COMPILE_TEST").

Best regards
Uwe

--3yytpvatfhmknuuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbYEzwACgkQj4D7WH0S
/k5SvQf+NO8vcbtNzPEQ93q8b0bUlyJ0RMbzu+c2gvXGTNCZfFrxMknBXCxauxnk
NsFS69G2JzB3Q/LG/Lny6rguZd9gkvYDBVKSjid2wdf4Kekr/2cKXSbAkPaFVQHu
QQndCDqL6XKMpug1f5f3ehcxFnL7LVw5ZMSWMqO19bzpYGa6zgEH1JJVTmpVPDa5
ZoOJoTb3njfPDLqGjBgdaZVaI0dAgwkP7Nf8DUbzXKqdZEl7d50T8c2LoJOEpZ1I
NP/Jl0xMi8oWc3KtVuLvslL87nmXyRsW8bGdDFOlg+i7tYO3bJlBO4zoJ+2Nm0tx
pSJaiqTBJkyu0HmnLg2VtkcQBqwZzA==
=Ps67
-----END PGP SIGNATURE-----

--3yytpvatfhmknuuz--

