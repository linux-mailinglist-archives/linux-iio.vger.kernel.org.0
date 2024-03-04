Return-Path: <linux-iio+bounces-3322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB98702B2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 14:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9DB2569B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC573D981;
	Mon,  4 Mar 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo9zLvGX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDE3D579
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558903; cv=none; b=QLp4lfA3vb8KXngPua0rdGRSYwQMvbYxC0MsHIsCU2vLg8RLaHa0IPm7bi4TlUGL+QAywxIZCGpQ3JkUPt+tt0jlXqaPcM9YQTKSZrd0JZDJpnGHgWICmK8fdftOKsFEV8df7TAODQ7yI9Sq7le4hLCakPM+bIlf8UVOD+ML6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558903; c=relaxed/simple;
	bh=VI8G929ddBR5brvKqtA8Ym22S1+BxJoVgpqqCpFkhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDEEANNO54dPIIK7iadM0CAtR7B14FnkCTYM3VBB3Cp4A/ocuiz7j+MINnq7FVOB0pivjO+EtjvlYAX9M91I/qbbzslOORlBsosOBwJkxI7OM89bX01KHMPMUIdF0xlcMaQ5sJNhc/aVQK4JUJBIO9sbam5X+uyHTgmQWfiEzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uo9zLvGX; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4725acb539cso1195715137.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 05:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709558901; x=1710163701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjMraSVWoQYij9IimFaQDDJ/jZpfa59SCn64UX2Kn1w=;
        b=Uo9zLvGXyBurH+WmtC8CRJZVcnPKtQRTQVcrKM0jVV87pTZSINZ3g4JSry90Z3Ssmb
         hYc7jI+Scpc0eNxxXuuQgG6AUdHJiVWCq/8QnH9+kTD3ijqJ3ZqPPLe+9mO+LV2ef6sb
         NRk7JwYQoFhGvcowaylXPcoemt+S45h/3yWf2Ayu+/gcPT1KygFGYcjXPGyyTZ3Pc0uf
         7yy/S1bp3Cr7vMbk8asCuL90qKcVBKCBRToV7tO5imgrdLFXfBhYlTz2/lCi7ERq5G4b
         PLCu/p08yIa1nHZ3znWdae1WiWKNqVPZg/Z19pelGEZMt/UEQQG6QNzst5t73bcZuDfk
         4/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558901; x=1710163701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjMraSVWoQYij9IimFaQDDJ/jZpfa59SCn64UX2Kn1w=;
        b=pisVgszSmVCPOZgiSYPpdbK1kezoozknr/W1h8WmFc2/HyszqxD5+lC+RCYnjyeb/7
         LgikQBgkLUyHkDops4SpN1rVEclxl1zfl6/rr8Z2XG/hzjHDaWbjKWUMdyyvTTlFU2Kr
         jTWqBJJ5twVWa2OHW0rdVznDd5xckfgPMh2k7OoFxpcYPIhOlNsov48Yx/sJDRiJrojP
         PUrxiF3Ta0bGKKtyuR8XGLFHQ6TaxJ3zgzwJfRo3Lb7odR3SmoMw4zz3iJq0vNcBU71w
         ar2DfhIzRF9ofB7AOJ7JrSCG7EtuDcyhKlo5oX/jH9DGHQfyC38DC/zvv9aqbpwEYb0p
         nRxg==
X-Forwarded-Encrypted: i=1; AJvYcCVp3ZzLIrZ5rR02/3UIiqT3KQQz/G217/ckFTadqzL/DHBYItcAHGflzhwS1CAgwrsi/qsTP1KeLESJKU0Utd6v7+qSXpC3fmbJ
X-Gm-Message-State: AOJu0YzBnqij9246vUyywrmHjVX6caT+23D5e4AGUVyZpdxR0UX8Fs92
	KblczVk04Mk2OcIgEC1f5/Gfh2lYrmx5kfVI6l/ogW7SDqItDzogsG+fhsX//iY=
X-Google-Smtp-Source: AGHT+IFNUcp5lCuJw/WrmiIEhGGpeoh92Mwt0K7neBcsKMFMWsKmNTMDAXJGVmmNz1sh8R24IW8udQ==
X-Received: by 2002:a05:6102:35a:b0:471:f1a2:13c8 with SMTP id e26-20020a056102035a00b00471f1a213c8mr5222143vsa.11.1709558900667;
        Mon, 04 Mar 2024 05:28:20 -0800 (PST)
Received: from ishi (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id fv5-20020a0561301a8500b007da5d981866sm1279109uab.31.2024.03.04.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:28:20 -0800 (PST)
Date: Mon, 4 Mar 2024 08:28:17 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: syednwaris@gmail.com, vigneshr@ti.com, jpanis@baylibre.com,
	alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Message-ID: <ZeXMcUW6_rxcT1wd@ishi>
References: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
 <ZeH6e02zzfAjw-sd@ishi>
 <562cdbfe-9353-4f5d-a804-34e158a190a7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Mh9QAouw/rxE4EG"
Content-Disposition: inline
In-Reply-To: <562cdbfe-9353-4f5d-a804-34e158a190a7@foss.st.com>


--/Mh9QAouw/rxE4EG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:41:14AM +0100, Fabrice Gasnier wrote:
> On 3/1/24 16:55, William Breathitt Gray wrote:
> > On Fri, Mar 01, 2024 at 11:25:05AM +0100, Fabrice Gasnier wrote:
> >> Now that there are two users for the "frequency" extension, introduce a
> >> new COUNTER_COMP_FREQUENCY() macro.
> >> This extension is intended to be a read-only signal attribute.
> >>
> >> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >> ---
> >> Changes in v5
> >> - "frequency" extension is read-only, so there's no need to provide
> >>   a write parameter.
> >> - patch sent separately from "counter: Add stm32 timer events support"=
 [1]
> >> [1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnie=
r@foss.st.com/
> >> ---
> >>  include/linux/counter.h | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/include/linux/counter.h b/include/linux/counter.h
> >> index 702e9108bbb4..0ac36f815b7d 100644
> >> --- a/include/linux/counter.h
> >> +++ b/include/linux/counter.h
> >> @@ -602,6 +602,13 @@ struct counter_array {
> >>  #define COUNTER_COMP_FLOOR(_read, _write) \
> >>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> >> =20
> >> +#define COUNTER_COMP_FREQUENCY(_read) \
> >> +{ \
> >> +	.type =3D COUNTER_COMP_U64, \
> >> +	.name =3D "frequency", \
> >> +	.signal_u64_read =3D (_read), \
> >> +}
> >> +
> >>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
> >>  { \
> >>  	.type =3D COUNTER_COMP_SIGNAL_POLARITY, \
> >> --=20
> >> 2.25.1
> >=20
> > Hi Fabrice,
> >=20
> > Setting the structure members directly works, but why not use
> > COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL) instead to keep the
> > code more succinct?
>=20
> Hi William,
>=20
> I originally wrote it this way, but I had a doubt since some macros use
> the structure members directly.

Ah yes, the macros that use the members directly are typically the ones
that are unique for their particular type. For example, the enum
constant type COUNTER_COMP_COUNT_DIRECTION will only ever be used with
the COUNTER_COMP_DIRECTION() macro.

For macros that are based on general types such as COUNTER_COMP_U64,
it's better to use the respective base macro such as
COUNTER_COMP_SIGNAL_U64(). Not only is this more succinct and clearer of
the intent, if the need arises in the future it allows us to upgrade the
the underlying base macro and have those changes propagate to the macros
that utilize it.

>=20
> I can update to use COUNTER_COMP_SIGNAL_U64() instead, that will spare
> few lines.
>=20
> Please let me know what you prefer (I guess your proposal above ?).
>=20
> Best Regards,
> Thanks,
> Fabrice

Update to use COUNTER_COMP_SIGNAL_U64() instead, and I should be able to
pick it up quickly.

Thanks,

William Breathitt Gray

--/Mh9QAouw/rxE4EG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeXMcQAKCRC1SFbKvhIj
Kzu7AP9WkIVlQ1Jh+lBJDYsKAObw8kanQFNcLxQXqxQ3J9C7vgEAgbCKLZ/Qmpz7
xlUG50p0PKnSqTAKM66jyp3VikL6xAY=
=7J/c
-----END PGP SIGNATURE-----

--/Mh9QAouw/rxE4EG--

