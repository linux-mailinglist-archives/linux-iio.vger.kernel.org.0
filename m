Return-Path: <linux-iio+bounces-5480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481148D4672
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A67A1C2103A
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A64142E60;
	Thu, 30 May 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crls+Zf2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF520322;
	Thu, 30 May 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055456; cv=none; b=jxIQ3YGAVqGUqMubIVL+MBWIINFe0Gv5CRAwz+VTb58vMUMYxixFflfclc2IeEfSX9o7zgOAUScj2s0DfzMQtUjavhINeIhvdaONxIF6uQVrTB/099tF5+3sq4qNxNf6D5uymJVUaLOYDbwzIk2LzBwVfYh/HFJr1phP0WNR/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055456; c=relaxed/simple;
	bh=T8xl6dkKmEDZUxLjgDs9SDEVtYPGWxwHHjLalcQCz+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCEX2asc8bArSW1wmgqTmArz55twpSuR6U3ehY7ml7v3OmXa4HmrXAhqvqJgLxnzy1eIk40vFe5lcF++WwxC5DQU9QTfcJRvR1XqwME9eOD0jEOGAmIC512Os18iLb9gzOkNNc94gXfg0hrhM5dUbKt/AhloVUCy28/Jl5HJjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crls+Zf2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a033c2e8eso530498a12.3;
        Thu, 30 May 2024 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717055453; x=1717660253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vuhKwhsToXT3l/R6AlWw5K5GSmHL8Yl/mYkI6e8/s/0=;
        b=crls+Zf2D6OWA87pT2TP49QJDjRKjFGL1R3hhDXKSi772oWZUhPutB3p5sLTWNJ9i0
         +wp5mT6V4aWwSNacaP7tWzSC5u0d+g7ggta3IMIjm+XKFfRa/VXuw+JOiGXELZPd9x09
         3YgV3qoixfI6q9ODxQ566W9NzpM3FXqGhSu3G8iiLURJBA09jWbzvNk3eFbq4YMvjFnP
         jhGlv/uzs7oUt3nUlY++hAanXj0VDLaYWnbighLtzCR/nuED8kHGofJ4cPhtayLwsAH7
         9u/hJMUlgoQ281oLgp8QO0rFL7EbXj0zrFH0CiVTQLowWYTtJqqEBIdfHer+Z5fX6qtb
         7WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055453; x=1717660253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuhKwhsToXT3l/R6AlWw5K5GSmHL8Yl/mYkI6e8/s/0=;
        b=NQeaZ/esYCdaqgD7Y6chu3PrgrJaZBVvO8hVvjpk9g+DLtcCPbsGcH94c7TDABPXDK
         a1wXv5IUODbbX4/zMzLow7mT/U5TAhfpkhKMcaQRBNq/eT23NbpS2blHwW+8w7p4V0Yq
         akmJzpG5TfRCeSUMMkoDDbeuwldk+N/99Fdb6R91zzDr3AxgF5tAYoO0JaZphMAf3Qr/
         6ILJgN4Xlipx3a+iwo6W1Kh3KtQiaVo2lNLKBcnI0gSuKzxS8FZVtOW8JPGCTvWn2hdv
         yMr4RZNMLInulv3hgYp/3avR+G+15/ivoIqbMaUiXwOgBLonM5S4abhADtgVhCGxmFPm
         n2fg==
X-Forwarded-Encrypted: i=1; AJvYcCUkPNa9sF8W6BLICYWwMfnzkZZgjWAa5kQnRUlmBj87Gv2NzzeQNgJFohS4QF07dXQClT0r4yMGqART+OeesHTV9BlkhfzzMWFAKG1VmEcmBkUHy6glDrzxtYQNB5QCTKECBqSW3DfrXSnzMhOIeOqUcoDW+xxr4cU1dE2FlIIAV1BFQA==
X-Gm-Message-State: AOJu0Yx3mb7xv7+Yx45H/tBDBLlxANmm7uQwTelf1de6ow9n/WEs2nw1
	ZCDae/632VERasrkZlSE484FNh1mP7neT+hcgysqla51e4yKMXFB
X-Google-Smtp-Source: AGHT+IGmMOjzzdnXJvyzloxYKsyaVIexJ39/I1CvMB3KjQgntAf3iXd9SPAN5vvgOx0dpENpMfWP+A==
X-Received: by 2002:a50:9f2f:0:b0:57a:23eb:13b3 with SMTP id 4fb4d7f45d1cf-57a23eb1421mr325242a12.12.1717055453025;
        Thu, 30 May 2024 00:50:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579b63ad3b2sm6964476a12.0.2024.05.30.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:50:52 -0700 (PDT)
Message-ID: <e0be3356bf809035963c4801f05b9db2675c111e.camel@gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, "Ceclan, Dumitru"
 <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 May 2024 09:50:51 +0200
In-Reply-To: <20240529-slit-verse-0fb06f3556fb@spud>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
	 <20240527-arguably-said-361184ad848e@spud>
	 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
	 <20240528-filtrate-cloning-b9152322a3da@spud>
	 <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
	 <20240529-slit-verse-0fb06f3556fb@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 17:04 +0100, Conor Dooley wrote:
> On Wed, May 29, 2024 at 04:38:53PM +0300, Ceclan, Dumitru wrote:
> > On 28/05/2024 20:52, Conor Dooley wrote:
> > > On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
> > > > On 27/05/2024 20:48, Conor Dooley wrote:
> > > > > On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 R=
elay
> > > > > wrote:
> > > > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adi,channel-type:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Used to=
 differentiate between different channel types as the
> > > > > > device
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
egister configurations are the same for all usage types.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Both ps=
eudo-differential and single-ended channels will use
> > > > > > the
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ingle-ended specifier.
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/type=
s.yaml#/definitions/string
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - singl=
e-ended
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - diffe=
rential
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: differenti=
al
> > > > >=20
> > > > > I dunno if my brain just ain't workin' right today, or if this is=
 not
> > > > > sufficiently explained, but why is this property needed? You've g=
ot
> > > > > diff-channels and single-channels already, why can you not infer =
the
> > > > > information you need from them? What should software do with this
> > > > > information?
> > > > > Additionally, "pseudo-differential" is not explained in this bind=
ing.
> > > >=20
> > > > In previous thread we arrived to the conclusion single-ended and
> > > > pseudo-differential channels should be marked with the flag
> > > > "differential=3Dfalse" in the IIO channel struct. This cannot
> > > > really be inferred as any input pair could be used in that
> > > > manner and the only difference would be in external wiring.
> > > >=20
> > > > Single-channels cannot be used to define such a channel as
> > > > two voltage inputs need to be selected. Also, we are already
> > > > using single-channel to define the current channels.
> > >=20
> > > If I understand correctly, the property could be simplified to a flag
> > > then, since it's only the pseudo differential mode that you cannot be
> > > sure of?
> > > You know when you're single-ended based on single-channel, so the
> > > additional info you need is only in the pseudo-differential case.
> > >=20
> > Yes, it could just be a boolean flag. The only thing I have against
> > that is the awkwardness of having both diff-channels and
> > differential=3Dfalse within a channel definition.
>=20
> What I was suggesting was more like "adi,pseudo-differential" (you don't
> need to set the =3Dfalse or w/e, flag properties work based on present/no=
t
> present). I think that would avoid the awkwardness?
>=20

Yeah, that was also my understanding of your reply...=C2=A0But I think you'=
re also
mentioning to have this flag together with the single-channel property?=C2=
=A0

I'm a bit confused because it seems to me that single-channel only gets one=
 input
while we need to select two for pseudo-differential/single-ended. Is this c=
orrect
Dumitru?

FWIW, I think we already have that awkwardness in the current form. If I'm =
not
missing anything, what we have in the driver is pretty much:

if (not diff && single-channel)
	// then current channel
else
	// relies on the channel-type stuff

So, effectively with the above we have

diff-channels =3D <1 0>;

but then wait, not so fast

adi,channel-type =3D "single-ended"

To me the above is equally awkward (not sure if there's any precedence in u=
sing diff-
channels like this though)...

I would like for this to be explicit... If we have diff-channels, then it's=
 surely
differential.

If not we could use the single-channel property and instead of using an ext=
ra flag we
could make the property having either 1 or 2 items. If we have 1, then it's=
 a current
channel. If we have 2, then it's voltage single-ended/pseudo-differential.=
=20

David's suggestion is also pretty good (and I like it's more explicit about=
 what's
going on) so I would likely go with it...

- Nuno S=C3=A1


> > > >=20


