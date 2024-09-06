Return-Path: <linux-iio+bounces-9226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F996E8FE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05449B22827
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A774BF5;
	Fri,  6 Sep 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0dbrYDEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB161FD8
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599459; cv=none; b=lSG2yMbB9fEXGbscpOgh9ddh5RSoyScHj1MC+tyfcezlkLH+N67wRrleCTFyc7quemUpv+PHHf5Bm5AhjwVV16e5+avbNxk5RcfpzOqUL06l32KXfzhosT8GP04JL+Yy2pylnFiDw4/moJzz+a39f8p+ucU8JG5NCHoC7JrhCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599459; c=relaxed/simple;
	bh=cox6Nxc7egq7AZwig73/QCORN5Qr52T6ViOyEhlj3O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HozJUQl4Uc/7/JRMbWsS+YvvKZF/Tk6E1wqfSfF4hOBy6JANbOnSzAYueLpy0cmCzDUm36GBo0pQD0kxMwZYqTB5wZGajltUivf0FRv+x7LVxzl1QDN62JS6Fr+JqhnlG8BgoT1/Kby0hSG8WOk/EA4fjb8lnEFpGF/C0mets9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0dbrYDEx; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4fd136aac40so435911e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725599455; x=1726204255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfXwtPAreobELFhytY+AFMWjfhxEApMqwxtGAQPF5w=;
        b=0dbrYDExodw5q7EDMLIShbzIwomA2I0yPOB3ohTD3RoOxGmuD/OGGCghTkVH0PPAj4
         9ivPhju8s80+UJPxswRnSUoWQusFIzJuQprvAqRB9aZkp0yTT1L2i0xRRS7teJBaYdvE
         dJ+m1iNYRTSqo72H6y64BRAp6yfecZ0NVAxdSultcJ5GLHVI0YBfX/vpGkXjtBkGGden
         Cmbp7kvbEbFnZUe6PfCj9HUt//cisgoyqiEKAbgVSafzxMJWLKMCZMC5c/Q4FUUfQY0O
         X9tdDOZfzWEYY7V2t66KJRrEy8Peg9n1t0PhU/ZXwpuSlE3BsTG9g/8EQLNyd5ljFaTz
         WBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599455; x=1726204255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtfXwtPAreobELFhytY+AFMWjfhxEApMqwxtGAQPF5w=;
        b=hJ5PlNOiu0Cu3V7LS/tUhiUxcg/csisS+GI4kSR9o77pwxyMnU13y9giCZ7qjXqBni
         OsyEkUFKgufAWBnaKNfJ9hTghhj/GVHy5+W6hNPp232ZHnL31thNo+jP4Td5JMIy9N+t
         Xr1U0+c7OtXgxSQEoLGQHsrU/Bw+qZS+KrMqBad0uuIJT43pow3hmdSVv+9RBvptp+FM
         x5z0y0rOU/B476oJ+vUnGnFv1vreayN07ZtyzfxGlTeWmpayZHxsHEMj6Gty8hSZZqnE
         DR+93kPkV9vIEkiDqT2Jq/qUpGgbhQuGGJKwUuNGiAYpkRCRToasSOK3Yyad6q3yStE9
         sYwQ==
X-Gm-Message-State: AOJu0YwNYiE7yLcOZclsHhfrUeMPSazjOcGOJdNx3XbHmc+GjF9Zs8RY
	zcsaDDJ4d3d8+p+I6VeGJxgTBB6d89ANrna0WFuQvlfkFDLXrHJxi4dnoyc0VfpHzw2OD3b3eyy
	58A92HVqRfRguI75vWix8MCxRQYC6K34nFtMs7w==
X-Google-Smtp-Source: AGHT+IEqVjx1uqswLtj04+06JSwnBwvixcQ6zE4PjuQ1mK8KKr5zEv9HB8xSLkouZcGTEIYAbRmMs9ehQ/l1tT2eMuw=
X-Received: by 2002:a05:6122:470f:b0:4fc:eda5:634f with SMTP id
 71dfb90a1353d-50207c2e984mr1486839e0c.4.1725599455053; Thu, 05 Sep 2024
 22:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-2-aardelean@baylibre.com> <7ba70132-e661-4f4f-a0e3-0ed1efc1aecb@baylibre.com>
In-Reply-To: <7ba70132-e661-4f4f-a0e3-0ed1efc1aecb@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Fri, 6 Sep 2024 08:10:44 +0300
Message-ID: <CA+GgBR8H1TP1Ux8Fgohx0SkctxdvmtBZfqW+-k4cZsram5yScA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:25=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 9/5/24 3:23 AM, Alexandru Ardelean wrote:
> > There are some newer additions to the AD7606 family, which support 18 b=
it
> > precision.
> > Up until now, all chips were 16 bit.
> >
> > This change adds a 'bits' parameter to the AD760X_CHANNEL macro and ren=
ames
> > 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> >
> > The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for I=
IO
> > channels in SW mode.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
>
> ...
>
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index 0c6a88cc4695..771121350f98 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -8,7 +8,7 @@
> >  #ifndef IIO_ADC_AD7606_H_
> >  #define IIO_ADC_AD7606_H_
> >
> > -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) { \
> > +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {   \
> >               .type =3D IIO_VOLTAGE,                            \
> >               .indexed =3D 1,                                   \
> >               .channel =3D num,                                 \
> > @@ -19,24 +19,26 @@
> >               .scan_index =3D num,                              \
> >               .scan_type =3D {                                  \
> >                       .sign =3D 's',                            \
> > -                     .realbits =3D 16,                         \
> > -                     .storagebits =3D 16,                      \
> > +                     .realbits =3D (bits),                     \
> > +                     .storagebits =3D (bits),                  \
>
> Technically OK in this patch since bits is still always 16 but we
> can avoid changing the same line again later to:
>
>         (bits) > 16 ? 32 : 16
>
> if we just do that in this patch.

sure
will update

>
>
> >                       .endianness =3D IIO_CPU,                  \
> >               },                                              \
> >  }

