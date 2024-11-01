Return-Path: <linux-iio+bounces-11810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A829B9744
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7846C1F2202E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7051CDFC0;
	Fri,  1 Nov 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bYobjbXF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C594C1AB523
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485152; cv=none; b=SJ5A3ITQcuwjIMLSd3cmNVC4cliR2tBPsRboMtdi0/fM3sbGeK5mr3+WdglIffpvLPddReqXmTttZoB7wu8CyJzg5OzglROSp6yV7p9df9R5CUP+X7DlAvQgk30GhI9ZgmkCPcG6a+zm0qOXwHVxyzpzHIBSgv1FHHwviTqJY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485152; c=relaxed/simple;
	bh=jOGNatYKO7LyfoMaEY3D4pl3e46xv0D7qv7HJZZbDO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B26eVn6O4C40eRBgNI7dHTimcRmz7aHD5gqSjUHr0EtB2ZEC1MwK6A5zHn6Thzzx8/+THvU+bGbCtzCKL0uy+Mt/43rdLuLv1w8GZ3PfFFJXx0SPuj03lHdekm5n4kuu/nlJFeU/JGjnRpuP6e/YGZkY2Bn4+ibcEa2ohGB/CVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bYobjbXF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso308640566b.2
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730485148; x=1731089948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCb0avfMfhqFRdPMe3Ycp6E7ngzUGoHw4RlfxTUvmP4=;
        b=bYobjbXFwsQvoB3St4LwIgP9ERXydeonQ6dEvnTxleS6OWEuTfvRor852qw8VtPaCH
         mNLNLTBzWcFDKDi3x/hoBwOBNEjtY3cUFTIAw2guRK9lBcKNVC9EvYTkafTzO4SBdhCa
         8vibo8mpkA8gwriFlBAy3NJAsYl/XOtXAYHYHsTWi+9aI644HUG+V+iZZrxqd2VJxLI7
         4O8akD6EwIaTUGaD7a0vIQYriM2s5/z6xnBx1hsraK+X9DtdDM6apIvr5PRihnTZJO9l
         SLlGrna6DUCHOVEqVGqofy7Fbm8O/DMRcef1wAx9rD8JzimEOlASyMrJqURobYS/V98/
         aKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485148; x=1731089948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCb0avfMfhqFRdPMe3Ycp6E7ngzUGoHw4RlfxTUvmP4=;
        b=VYpNwMWlnuZ9Yuk2W/xs55faIkmqjnPsYgZxonLZujdpTbA9BXdMs2BCzg7LrL1HZn
         8PGZD+TYIxtzzdHwWTyreXr6jCEjqNggRFrIFfS3ZfywaB6ezq8TvrOSl6IQd0y1Rfl2
         3kBkD/ryb2+vyMKsQER4oLDDjYVItCV6Q79MoF3jODQ/V4qUbWpYuXDNbVYZzlA2TUMc
         hSdDB0zrqfJndyrdSumtig9ARIiGwJXbpbikoDBGYg6qchgEw9CcfAO+uq3dkruAlIHY
         rH9gA6egPau64a5do3csu4JbBkttjwr8nZSoa9oGRxFinmdL0NsoESv1Hw6O5Q6d8Ocm
         kSKA==
X-Forwarded-Encrypted: i=1; AJvYcCVeb13LDEcd/5+hiQCKtBGHcXBTKkCDD6Q0erIoSrLSnjjzctwssuFa6z0+9xc86DqoOuWbxPyW330=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSbwc3slntxu2UBw0otMvJuoOJAJg6HTvmDKyMu4b1Yrg7kaG
	lxkSQqc3mzUOs6Stht9hrbxQMC7EOjJ6Cwhs6KYB/D/75Ltppoi5wCd1hJToYOaX4FpHSYrFIWV
	h95QfDuAXzOJOywpaLYQugPU4eVzIdZeMrlo3Hg==
X-Google-Smtp-Source: AGHT+IFcq0AMZn+pZ24DpM6HGZ4OavdIPRNi8d8rMXlbIsaq2gBK6JoQrQewB37SFhHsyDDEtF8jHre0Mg6mo5VxsRA=
X-Received: by 2002:a17:907:3da9:b0:a99:e98f:e73d with SMTP id
 a640c23a62f3a-a9e5097d255mr759902366b.37.1730485148179; Fri, 01 Nov 2024
 11:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
 <ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com> <20241101154451.227defba@jic23-huawei>
In-Reply-To: <20241101154451.227defba@jic23-huawei>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 1 Nov 2024 19:18:48 +0100
Message-ID: <CAEHHSvZxgREMpA-kC7zarRZAp=bU6dcc2-3qjZU8o01BP3bSzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Matteo Martelli <matteomartelli3@gmail.com>, 
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>, 
	Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 1 nov. 2024 =C3=A0 16:45, Jonathan Cameron <jic23@kernel.org> a =C3=
=A9crit :
>
> On Thu, 31 Oct 2024 11:27:45 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 10/31/24 10:27 AM, Julien Stephan wrote:
> > > state parameter is currently an int, but it is actually a boolean.
> > > iio_ev_state_store is actually using kstrtobool to check user input,
> > > then gives the converted boolean value to write_event_config.  The co=
de
> > > in adux1020_write_event_config re-uses state parameter to store an
> > > integer value. To prepare for updating the write_event_config signatu=
re
> > > to use a boolean for state, introduce a new local int variable.
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  drivers/iio/light/adux1020.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux102=
0.c
> > > index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5=
d1aba08a73ce18c367e 100644
> > > --- a/drivers/iio/light/adux1020.c
> > > +++ b/drivers/iio/light/adux1020.c
> > > @@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio=
_dev *indio_dev,
> > >                                    enum iio_event_direction dir, int =
state)
> > >  {
> > >     struct adux1020_data *data =3D iio_priv(indio_dev);
> > > -   int ret, mask;
> > > +   int ret, mask, val;
> > >
> > >     mutex_lock(&data->lock);
> > >
> > > @@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct i=
io_dev *indio_dev,
> > >                     mask =3D ADUX1020_PROX_OFF1_INT;
> > >
> > >             if (state)
> > > -                   state =3D 0;
> > > +                   val =3D 0;
> > >             else
> > > -                   state =3D mask;
> > > +                   val =3D mask;
> > >
> > >             ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT=
_MASK,
> > > -                                    mask, state);
> > > +                                    mask, val);
> > >             if (ret < 0)
> > >                     goto fail;
> > >
> > >
> >
> > Instead of introducing `val`, I would rewrite this as:
> >
> >       if (state)
> >               ret =3D regmap_clear_bits(...);
> >       else
> >               ret =3D regmap_set_bits(...);
> >
> Good idea.  Rather than go around again and potentially stall the end of =
this series.
> I made that change whilst applying.  Shout if either of you doesn't
> like the result. Diff doesn't do a perfect job on readability (it does
> if I add a line break but then the code looks worse in the end!)
>

Hello Jonathan,

Looks fine to me. Thank you for doing the change yourself.

Cheers
Julien
> From 06a1ca816450d1b5524f6010581a83ab9935d51b Mon Sep 17 00:00:00 2001
> From: Julien Stephan <jstephan@baylibre.com>
> Date: Thu, 31 Oct 2024 16:27:01 +0100
> Subject: [PATCH] iio: light: adux1020: write_event_config: use local vari=
able
>  for interrupt value
>
> state parameter is currently an int, but it is actually a boolean.
> iio_ev_state_store is actually using kstrtobool to check user input,
> then gives the converted boolean value to write_event_config.  The code
> in adux1020_write_event_config re-uses state parameter to store an
> integer value. To prepare for updating the write_event_config signature
> to use a boolean for state, introduce a new local int variable.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Link: https://patch.msgid.link/20241031-iio-fix-write-event-config-signat=
ure-v2-6-2bcacbb517a2@baylibre.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/light/adux1020.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 2e0170be077a..06d5bc1d246c 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -526,12 +526,11 @@ static int adux1020_write_event_config(struct iio_d=
ev *indio_dev,
>                         mask =3D ADUX1020_PROX_OFF1_INT;
>
>                 if (state)
> -                       state =3D 0;
> +                       ret =3D regmap_clear_bits(data->regmap,
> +                                               ADUX1020_REG_INT_MASK, ma=
sk);
>                 else
> -                       state =3D mask;
> -
> -               ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT=
_MASK,
> -                                        mask, state);
> +                       ret =3D regmap_set_bits(data->regmap,
> +                                             ADUX1020_REG_INT_MASK, mask=
);
>                 if (ret < 0)
>                         goto fail;
>
> --
> 2.46.2
>
>
>
> >
> >
>

