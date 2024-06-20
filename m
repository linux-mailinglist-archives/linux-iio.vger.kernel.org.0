Return-Path: <linux-iio+bounces-6615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BA910186
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 12:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0A1C21472
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270381AAE0D;
	Thu, 20 Jun 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O4LgYgwk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F2A1AAE01
	for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879659; cv=none; b=jTwbwmqWzUslup72Xrk7ySXnB2IWLZqhd5b3b8c9dCxajZ1kPNIWnIfk1ohXTOIQA4duk6uD+jCyzcFStj/wNOZq/V05u6m6OI3rJSP5+CsjJa+HE1SwFjIlguoMkvBGnR7D7Q0LNzZk+sIwPiolQukL1ATp1du1CQbdyAvdnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879659; c=relaxed/simple;
	bh=YNOkYJNBVLQ0eueIapzEgiAefpctePBYXUzNH0ucuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvRYTvXWQRhrfBNmtpeKwvgpKWaKsGgNeJcmUzjv5G1h/7dRV3doQk/wMzXo/ItltLCCda8qUYLuagtSsLvhkgsWpzF3GRjwsc5lnFAT9sQv0uwbgMKs1vB4wpaH2rHHklIrXa3k7U/b1tuWWJyuVvaIE6DqtsNEooiGoTW/prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O4LgYgwk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso765447a12.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718879655; x=1719484455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH1RftmHG3Vs+kyJjdp6FaijzaNseaKDxHW9Q4uMarM=;
        b=O4LgYgwk8Awj0VHeb9P3YjDruI99pZGB+PtBkXIDhyFXoDZXbHoi3r9V4qiZQRmzGU
         clGhbTBa3YLuCLRoq5wSIEBZUgO2ceAuHKGNQLLmpRN4lnpeBgNU+7s6VgY601Jdpgrc
         Y3R4BRKvtp+u5hVYJ5wfnvXACS8O/La4saI4GNoWcz0U23YlPEm5QJ6YyekWWj+e0Qfn
         XnO+8zOYY1lze8tIupeEitLJIS4nw6H2YZqaP5eKAPALQY7zXVfUCShO5vEDtjYTfPyU
         Tg0Ye8O2en/ckemwd+BDFUDjj8wWphis+Ou1n2MslE0iptr1Y5TjkGFQJhaAiChrnsca
         i4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718879655; x=1719484455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH1RftmHG3Vs+kyJjdp6FaijzaNseaKDxHW9Q4uMarM=;
        b=WFUhb/lQMtHQT6uZv2A939TQZeAHvRcXcR4YizFqJyKbGqW1R3vYVIElevwrnPZA+q
         SNzsXAiFh9A5oMhLDc1QeZDC6Gon1QRDtJEzL5AbgTK7Y+DxKnMVOGf0HnfSmCAW1kfI
         r2ZMXShNogxoZ3CFBPr9pl/jxuAR1USUjJIJ8oarWsTu6rIYrQHAMJliqODXkso9zNrK
         Q3jrgV9IxeUurT7bPRMPqOw4ri/zJ6w9IxgQdrEd47w9c7xPzkUqLpH11LSy4JxMCNkA
         VD23w9nVXhm6pdxo+c8i6o8KCzAIVgW1iTTMH8oWfFNAsX1SvP4/72z3fOcuSN6Jqa69
         493A==
X-Forwarded-Encrypted: i=1; AJvYcCUFslZ169pAUM19NyqU08BJGy2jLOP2N6MmFG3nY69CVw3P3Aj/wcVr5pYwGxQjGuluhSfV2IhXNutjBy5GTw+Ctcyh+jS/mk1P
X-Gm-Message-State: AOJu0YyA3cP1ifzElHMCUQN+OQ1mFThHD/RBFQapaqTrkDSn+yK5V9H+
	e2BhcUs8Meme/W/ugtCLoU9xad095xvw7o9xa7m5I/ztAnJa1Foxk7j1KFz+Mrw=
X-Google-Smtp-Source: AGHT+IEywqbKty6de7BGaA3EekB8lHCg+TqJCCgL/r5vpSNbTS3dSW25wQhhnMyvzNmMNB+yuXEXOw==
X-Received: by 2002:a17:906:e214:b0:a6f:6721:b065 with SMTP id a640c23a62f3a-a6fab643f94mr316617366b.32.1718879654465;
        Thu, 20 Jun 2024 03:34:14 -0700 (PDT)
Received: from localhost (p200300f65f283b00ca876ee5dd3d1e3b.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:ca87:6ee5:dd3d:1e3b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecd5bfsm750320466b.113.2024.06.20.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:34:13 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:34:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hl7obtkvuj2dllak"
Content-Disposition: inline
In-Reply-To: <20240620084451.GC3029315@google.com>


--hl7obtkvuj2dllak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, Jun 20, 2024 at 09:44:51AM +0100, Lee Jones wrote:
> On Wed, 19 Jun 2024, Uwe Kleine-K=F6nig wrote:
>=20
> > These two defines have the same purpose and this change doesn't
> > introduce any differences in drivers/counter/stm32-timer-cnt.o.
> >=20
> > The only difference between the two is that
> >=20
> > 	TIM_DIER_CC_IE(1) =3D=3D TIM_DIER_CC2IE
> >=20
> > while
> >=20
> > 	TIM_DIER_CCxIE(1) =3D=3D TIM_DIER_CC1IE
> >=20
> > . That makes it necessary to have an explicit "+ 1" in the user code,
> > but IMHO this is a good thing as this is the code locatation that
> > "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> > (because software guys start counting at 0, while the relevant hardware
> > designer started at 1).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Did you drop William's Ack on purpose?

Yes, because a) I was unsure what he didn't like about the subject, and
(more importantly) b) I split the patch in question. I should have
written that in the cover letter, sorry.

(Note I only announced to have fixed the subject prefix of the pwm
patch. I assume you won't include that in your pull request, but if you
do, please do s/-/: / on it. That's another thing I failed with for this
series.)

Best regards
Uwe

--hl7obtkvuj2dllak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ0BaEACgkQj4D7WH0S
/k7t4gf/cOIyz4Nagjp9u3Qrvbjo6uKDr5UNTBYW/l4HOKdCzRn2Ay7aWf5oRPOh
ZES1YQ1qZfU016yI+Uo1glCjmYvLuqCUeAh10hdBbTG62MHpUZoQG6KjL2Xv5+x/
FpsgfO77RerGDLZ4eUEH57XolCnRK76HAyDGLUp07GOU/xuDpGLmu6vh+Q+7m3Uu
A3IrKXrN9x8RDbO1Dl6Hm2Qpw+wbvZtlyTS/Zua+nKtO8lGpGkWtv3eJnnnupHQt
RJDvkplZy1uB3W+4x1cU/AKRtUphn94+DAaoWAHu82hamy3s3xiuS9n1aq5W4l8h
AtKCcSvaXottQP+Nm85Lr7Y1srvioQ==
=TbiZ
-----END PGP SIGNATURE-----

--hl7obtkvuj2dllak--

