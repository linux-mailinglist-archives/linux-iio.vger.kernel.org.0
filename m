Return-Path: <linux-iio+bounces-2526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D5B853AC8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 20:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B41C21F7F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6E5FDD8;
	Tue, 13 Feb 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E7LtdTZt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B11D69B
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852047; cv=none; b=ceZq6Fka2Sh8i4H21kaeE9a6hePoRV5nK9LE2K4VrgbuRHuNXMdBwZXlD+jvheVmnkwQrqfIIjx4Pc6ZtTKfWhiIbEt+/h8fEUmtxspWtm5KmFSgJTtaUQhhXnKJ3DAcinIYnQ4wH/WoSRjPg04WpBlYhz76UB6ER37VX3Q8Xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852047; c=relaxed/simple;
	bh=2eD27nSBYSIdc72inz6nPdpC5osZuxe5XbzWj/cYJrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ+gUCntGZKULf7ZBSS1eQ543GxDSRd9E2Hz8VcQHtodVBl1+IMI9tIVzAIDD1bnBK7jrpCAOlUAaHN4seRawRMSGxii5HtPWrlf+4rMqlBw4XbJI6zxGGZgmymB9btuMYySSsYpUJkyN2Ymf6bieO3/15dqJaxXEkUAlFSjE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E7LtdTZt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so62794601fa.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707852042; x=1708456842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjNs+EOtyNCTC3EqdQw06Whi85umzjdG+7lc6Okj5+w=;
        b=E7LtdTZtQ39VvbB8HURnsKURnP/mXh9yCmxrp/9/3vF8ldlE3M4EY7LSj7rmbmDm13
         jh3d9Et7ACajroXjjvxytRL9nwXlGlPg8Wqn2O3mYOKv5dl+H30pRUX7O2Ct5jzrmDTw
         OCl3AL8Vy+d9uAI8sc+CJg+Br4lpvYMesivRAv3J/Knry+cK/PB6wtFh9yk2WEzvgUY9
         BA14H0EHbKsNWZ5X/p1jrGjbeBUkDFdYWk4wQbCqwS8+RM5JBTQWrXIWFJXu2V22XUc6
         yeRofAECpiQZCb/KG/LEYDFqFCnfc6LJVHiphpq/5eJFiWzUpZa2yCAo7V8UL4NQJpBC
         vZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852042; x=1708456842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjNs+EOtyNCTC3EqdQw06Whi85umzjdG+7lc6Okj5+w=;
        b=e0p0MsHmjwYECd1gq7OcI4/JJiLABVgG759PM2djYukfkObW/ATxnU1WXy4UrrZC8m
         0D//AuAenjH/J08I1XJwOALmZehBMMe1l++D3pyrdklDsWtGQ2F4KNk7xhI3V70/K79r
         aMY58g7fP8aotx+yk+vVnW609/xs83LQFV9Nv2hyNz6Buf9CyPgemAIbRCmcJWVUTdfq
         dLZ3iXYGpJcX0majNNR8dWpB4icP8mWjuKfM8HB2kTwnmVOvfQ97BlPdOaDWHfPTw+aI
         QyPtY4lbHWtviWhvma6SLWRmT1ee6G9phe10o87HPjrdEHO28gKfyLzcXuaDTeujxsZJ
         bywg==
X-Forwarded-Encrypted: i=1; AJvYcCWp191cKT/nJ1EF24hriN/h2aP+jdrUT3OZ0QHu22i6E8r0bE509PgPu6y8JhzmItWWyigByn/MehuRdtKxdLms4x5cT+FQkkBs
X-Gm-Message-State: AOJu0YyaVt+K92VVZv2UOMoey1gWYDmIvN9n5WIOAmoo/WaqH80/zi9n
	r5kytEn+Z/EQg8sTMunltmjgAdFQTgN0DvOkMZWGVxFQIf9qvLt1+mFc7qsnlvMRiY33z7svKmP
	bWYtu+1sE17il2AFvZJIl/tC+zhinl9KZkp+4hg==
X-Google-Smtp-Source: AGHT+IEZWLAHkTfr2RYxYmAawpXrqecxeSqmy9qOLy++NxWLqa4pCUBQKqoVAoJ/789qdHNcn5J1Tp0YXnefirN3NVc=
X-Received: by 2002:a2e:a724:0:b0:2d0:fe56:2057 with SMTP id
 s36-20020a2ea724000000b002d0fe562057mr376125lje.4.1707852042535; Tue, 13 Feb
 2024 11:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com> <20240213172550.000023a7@Huawei.com>
In-Reply-To: <20240213172550.000023a7@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 13:20:31 -0600
Message-ID: <CAMknhBHc5LnaOOYoeCvtDvUcSXzPnHUtkheYMt73Uv5512dJVg@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:25=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
>
> I thought about suggesting splitting this into an initial patch that just=
 does
> the bits without the controller callbacks. Maybe it would work better tha=
t way
> with that introduced after the validate and splitting of transfers (so mo=
st
> of patches 1 and 2) as a patch 3 prior to the stm32 additions?

Unless anyone else feels the same way, I'm inclined to avoid the extra
work of splitting it up.


> > +static void __spi_unoptimize_message(struct spi_message *msg)
> > +{
> > +     struct spi_controller *ctlr =3D msg->spi->controller;
> > +
> > +     if (ctlr->unoptimize_message)
> > +             ctlr->unoptimize_message(msg);
> > +
> > +     msg->optimized =3D false;
> > +     msg->opt_state =3D NULL;
> > +}
>
> Seems misbalanced that this doesn't take a pre_optimized flag in but
> __spi_optimize does. I'd move handling that to outside the call in both c=
ases.
>
>

Agreed.


> > @@ -4331,10 +4463,15 @@ static int __spi_sync(struct spi_device *spi, s=
truct spi_message *message)
> >               return -ESHUTDOWN;
> >       }
> >
> > -     status =3D __spi_validate(spi, message);
> > -     if (status !=3D 0)
> > +     status =3D spi_maybe_optimize_message(spi, message);
> > +     if (status)
> >               return status;
> >
> > +     /*
> > +      * NB: all return paths after this point must ensure that
> > +      * spi_finalize_current_message() is called to avoid leaking reso=
urces.
>
> I'm not sure a catch all like that makes sense. Not sufficient to call
> the finer grained spi_maybe_unoptimize_message()  ?

Hmm... this is my bias from a previous fix showing through. Maybe this
comment doesn't belong in this patch. The short answer to your
question is "it's complicated".

