Return-Path: <linux-iio+bounces-5170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6188CC0DF
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F591F23D93
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AC13D601;
	Wed, 22 May 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA8b20nj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3422E419;
	Wed, 22 May 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379697; cv=none; b=DIc+imaQ7wfPeRIjf03YNaYiHN9A7gSj5AHEqrvgDwkz6ZFOnqIQebvqSkIZUHEXe9AG4UAdz/kDjweP7kXbnNIg7W7m6Ravi8LSjnvwMUfP+E2Oi+b1aJzQ512//YD6AdAjJg/T1vXY8GkM6A6yBmcrWHs5jf68EEUOfZqJYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379697; c=relaxed/simple;
	bh=tOv/v6NW8sGWfhiPmSQ9mFg1FX2TVKJmdt4N8h+nvKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdpXiOyZBzGRtmGEU4QS5ApCNW1PjorU5TRPwmk57y/eWRjZo39LLFjFbFk818C4/NeJOmCF76f531LAy2H6tkaNckAv+prXxMAPummL7Ka2huNfe+YQyRSxKEU4Js+OFpBkOyvLTKnkSC9xmmh6ImXNPjs9gaBj5BohCa9W6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA8b20nj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1032842166b.1;
        Wed, 22 May 2024 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716379694; x=1716984494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tOv/v6NW8sGWfhiPmSQ9mFg1FX2TVKJmdt4N8h+nvKU=;
        b=FA8b20njNyDZtqMQYFkOZ+dcw+bzopgyqssHSnCkC7NQ9FUo4F+kN0CoyN7Yrj5FO2
         7G2YMYykuMS/2CtJa0eZLFa22jPgMR+sD268aC3oV3eumTGYvxfMadT6T3PhflJ82O8/
         rMo+MStEGX2N4BR0qEzPmrWFuKixnG3op/SRBw7bN4ssxE43BFH6UEtvFw52JRH9Dvzr
         LgBIxjU9DDzeOD3rfAmX/7gJKPwHmWGj4T/kTAtkcHk2ZjYviKIX6jXFdUS9yeCYeBpe
         tx3+k22Yf4/76vq6C5euOmKA63Ixa8rHFHCZW8vb1YdmvO0sz0jkJfcmBp0xEWI5Mmr2
         9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379694; x=1716984494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOv/v6NW8sGWfhiPmSQ9mFg1FX2TVKJmdt4N8h+nvKU=;
        b=U9R27foZnZI0FhVBu+BgNQjuBp1eQB2fYEV3LZFwSHy77pPyFgIW7gF6B/+00zSkRl
         IQarXrSem2pAy6J5Hp6d/0BKFvDoHQ2BQpkq/3OW3ueONqeklAEnexzWCM85SDVQgYN1
         BCaBWreZJhmcwm+ShqTOby9E8w0l6o9gFJaUsdvBMcYdStjSmbNXvBS1WdmXjafgbNRW
         5plJ3b/I7BVXFOsnHM/I/tK179xHcqpFXOXajqo5w3ZpOu8LIEphBdvQZuCb3M5ztHsO
         iS26LPCXSEMKnaeJwZ2QbwU+A8V13JNlAr/BqKMdHos92suRq956fpTKcahwNrPoUfeM
         9VKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbtL664SF99ZqV+VlAExzHX2ReseN0kw4Gxiq/M+iM2nJOdyZkWEO+0yrSHeQcNY+JBhi+kUTaXhTcFxkCVd2ECS7MGVd3aITj8ognLbugTuVcdrrE4iapSUumRw46zA64vQNyYc23OOCWmsqdWvMDQwo147gAdykOH3X8mof1J58tb6YsETUN7vlU1Kfij44Dk2uACr16N6qMkjA1fQ==
X-Gm-Message-State: AOJu0YyJj3FR+yCivXKaKYks+7P63/Ue6TOsOxn5iM4K8yq/fX6kW/aT
	sRECAE484ZQH0J4fXE1+AVz+D4fCj4LStI73tS0m4jGSwshpPFBg
X-Google-Smtp-Source: AGHT+IFIa5rESUUNcVa4p+ciKqsr4GFkvT4INhWoc5DjWD+HI6eIr4UK3oX9IGZZM1KnTnQ/1OEYaQ==
X-Received: by 2002:a17:906:2c0f:b0:a5c:3072:5084 with SMTP id a640c23a62f3a-a62281635aemr128967966b.59.1716379693243;
        Wed, 22 May 2024 05:08:13 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm1042190266b.85.2024.05.22.05.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:08:12 -0700 (PDT)
Message-ID: <fbcc8bb3804d0f1f178f695cc16a1aa8dbcda1f1.camel@gmail.com>
Subject: Re: [PATCH RFC v2 6/8] spi: axi-spi-engine: add offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Wed, 22 May 2024 14:08:12 +0200
In-Reply-To: <CAMknhBH9y=tOhHrhBCoMOSSVgZDRbX90cfzqX62m6wLYsKDhNg@mail.gmail.com>
References: 
	<20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	 <20240510-dlech-mainline-spi-engine-offload-2-v2-6-8707a870c435@baylibre.com>
	 <6c5fd2cef9a6412e63f2534243eda37c321ffcd2.camel@gmail.com>
	 <CAMknhBH9y=tOhHrhBCoMOSSVgZDRbX90cfzqX62m6wLYsKDhNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 09:28 -0500, David Lechner wrote:
> On Tue, May 21, 2024 at 7:27=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >=20
> > On Fri, 2024-05-10 at 19:44 -0500, David Lechner wrote:
> > > This implements SPI offload support for the AXI SPI Engine. Currently=
,
> > > the hardware only supports triggering offload transfers with a hardwa=
re
> > > trigger so attempting to use an offload message in the regular SPI
> > > message queue will fail. Also, only allows streaming rx data to an
> > > external sink, so attempts to use a rx_buf in the offload message wil=
l
> > > fail.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
>=20
> ...
>=20
> > > +
> > > +static int spi_engine_offload_map_channel(struct spi_device *spi,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 unsigned int id,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 unsigned int channel)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_controller *host =3D spi->contro=
ller;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_engine *spi_engine =3D spi_contr=
oller_get_devdata(host);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_engine_offload *priv;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (channel >=3D SPI_ENGINE_MAX_NUM_OFFLOAD=
S)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 priv =3D &spi_engine->offload_priv[channel]=
;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (priv->spi)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EBUSY;
> >=20
> > I wonder if we need to be this strict? Is there any problem by having t=
wo
> > devices requesting the same offload engine? I would expect that having =
multiple
> > peripherals trying to actually use it at the same time (with the prepar=
e()
> > callback) to be problematic but if they play along it could actually wo=
rk,
> > right? In reality that may never be a realistic usecase so this is like=
ly fine.
> >=20
>=20
> I guess not. But to keep it simple for now, yeah, let's wait until we
> have an actual use case.
>=20

Agreed.

> ...
>=20
> > > +
> > > +static const struct spi_controller_offload_ops spi_engine_offload_op=
s =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .map_channel =3D spi_engine_offload_map_cha=
nnel,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .prepare =3D spi_engine_offload_prepare,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .unprepare =3D spi_engine_offload_unprepare=
,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .hw_trigger_enable =3D spi_engine_offload_e=
nable,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .hw_trigger_disable =3D spi_engine_offload_=
disable,
> >=20
> > I guess this is what you and Conor are already somehow discussing but I=
 would
> > expect this to be the actual offload trigger to play a spi transfer. As=
 it
> > stands, it looks weird (or confusing) to have the enable/disable of the=
 engine
> > to act as a trigger...
>=20
> It isn't acting as the trigger, just configuring the offload instance
> for exclusive use by a hardware trigger.
>=20
> > Maybe these callbacks could be used to enable/disable the
> > actual trigger of the offload engine (in our current cases, the PWM)? S=
o this
> > would make it easy to move the trigger DT property where it belongs. Th=
e DMA one
> > (given it's tight relation with IIO DMA buffers) is another (way more d=
ifficult)
> > story I think.
> >=20
>=20
> One issue I have with making the actual hardware trigger part of the
> SPI controller is that in some cases, the peripheral could actually be
> the trigger. For example, in the case of a self-clocked ADC where
> there is just a RDY signal from the ADC when sample data is ready to
> be read. In this case would the peripheral have to register a trigger
> enable callback with the controller so that the controller can
> communicate with the peripheral to enable and disable sampling mode,
> and therefore the trigger?

In those cases, the peripheral would not bother in doing any spi hardware t=
riggering
enable/disable (this assumes that we would need explicit interfaces for off=
load
enable/disable). In DT, the engine would also have no trigger has it's not =
required
so the controller even conditionally register these callbacks.

As for the DMA, I have no clue how we can have it associated with the contr=
oller
given how we want the data to be exported to userspace. Maybe dma-buf could=
 be used
but it won't be easy. TBH, I'm not sure if it's that bad having the DMA ass=
ociated
with the peripheral since it's purpose is to transfer peripheral DATA (not =
like a spi
controller DMA used for the actual SPI transfers).

- Nuno S=C3=A1

