Return-Path: <linux-iio+bounces-12168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302109C48F9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AD828100A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876331474A7;
	Mon, 11 Nov 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHMDFY6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9838F83;
	Mon, 11 Nov 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363494; cv=none; b=lzurSrxXAfexot7tAvRL2uwvsyIVdXzugef8Dgc498Ip2p8A+61UtfRKH6lWS5EM+q5HwWk1qgJPfqrLnFVxzrVkc1tQGOw9pTGgPhYTtrgd0Zzh/nU0x5dTAS0yePfmbbt6kvzMTJoYyzjG+xqbpQXovTsymGaar6tbLHCBh5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363494; c=relaxed/simple;
	bh=LeGtUiwPp7dUSHOMlblfulJI3szSmMXkY1FNvRIxCQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYnyaCzCpjLckEOfsrjWSOzZmAnW/PMEoNnXw/GVDw6t48th9OG5TjRZjnPyL1+voLLANKTuhATjXI6k6oTqpJ7NGxekI324zS+THhmOzmCzXa7iTqY4LIbQ2M/KlLMijwZn294eL/biV9O/bYEYGoXvigo76Wc37Y1J5+vophE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHMDFY6m; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609c9b39d0so34010661cf.1;
        Mon, 11 Nov 2024 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731363491; x=1731968291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gUTNs8Dh8KbUYmm7/7ZTpr23lbHf0Ptz/iifQK4G1M=;
        b=MHMDFY6m7G6vtIzw2udhQ8L6GP2g6AAO0oqDFloySKaA75i9bAbceKb2KhrPVBWRfs
         7i/gtC72AqDD7dyoAfdU8OzzwiRcpe4ION5HMY9C7SGUx0UsvAx2KUd81v0BMndJTx/7
         7fh26Rf6+xjQrGk0NEQ12cBcEXPSvOP9I5yYMnTV9UQFDRGjcDHG6joickgtOs67OnMJ
         l1AGLZHaZI80OLScfZtNrKJWKo0z2ygrqPmfWudENKAjFxCO9fwIEuwV1yDn3G840MeD
         ZRy8YkGvHCqQ5kT76d91Nx9AvoKtg5/kLaGB5PA2eJ1dr7gxCAd65MQnkA7fyP7Szstv
         az0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363491; x=1731968291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gUTNs8Dh8KbUYmm7/7ZTpr23lbHf0Ptz/iifQK4G1M=;
        b=k5Sggl2jRNgIzgyJzan3FLC8gWP5bgvOxYLqEwZ4yGzm4K0OFs2eJZh7uqu7pKHCce
         gh/eBrkkhuw3qcAWkP4/mLxqrxwujz+5vYLiJGT8yyythqkAMmPlpmxlPQIy5yOQwCiF
         Hep05KMKk0hM/9XWtHfvwjj5eJ+ruqiXcjcxUcOsuwYjQkgpJgc1M8xl8maIygH8qiYd
         5qr/KnXH93B4kd+JZN6ppEz4m7x1wWpyPBUtt7/m4PchflrzcaC2+n4hcwAIr54ksOs2
         0llZmDrYfddVKeGfMr3TVVAUWAvLpkzRf4+34b1kBCOTDZZ9xc3PC5zCfNzbNGp+iwLv
         ViRg==
X-Forwarded-Encrypted: i=1; AJvYcCWppHIV1dhjhUhp3TWIwv7NhylmPBjsLBlv/msd4E67V36LHk5SuiB89zpaNqekiA4vVNIghIcWxQHaww94@vger.kernel.org, AJvYcCXbCQyMUKerRaoeXZJvnES6z4a3wKmCKTxFgvxdM89CQhiVXHa8XmFP+9lFk96BGQMQ/Fe/mcXsqqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbqcnr6QRZFmUpt9+ETlNdCOKDKe0BflhAjHPDj8gVX/fJ4hU
	WseNVnCh6tww9njZLGL6dFv46dALjYjV928gi00dNS/hoBLZEqZOOREzsoJg7afh/mAAIPrgcKo
	OAEnbvTqU2jB98pWUlcOjfiq9/mo=
X-Google-Smtp-Source: AGHT+IFBSFXwho3XyINI2DcEU/Xepv/720ecvGA0qvDaPusA/yXsvod0iClvHMK0JEz9Jm2Fdz03yfn9c4Ds8BzAZio=
X-Received: by 2002:a05:622a:1b1e:b0:461:1475:6135 with SMTP id
 d75a77b69052e-463093003c5mr217546251cf.1.1731363491551; Mon, 11 Nov 2024
 14:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
 <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com> <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
 <b2f6db15-51a8-498d-ab5b-52f0f6a2e098@baylibre.com>
In-Reply-To: <b2f6db15-51a8-498d-ab5b-52f0f6a2e098@baylibre.com>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Mon, 11 Nov 2024 17:18:00 -0500
Message-ID: <CANeGvZW0Ja=pwLuYqZh1KWn3Y7Oany4JvALHWcHoM-jALedSbw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com, 
	tgamblin@baylibre.com, fabrice.gasnier@st.com, benjamin.gaignard@linaro.org, 
	lee@kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:15=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 11/11/24 2:36 PM, Jiasheng Jiang wrote:
> > On Mon, Nov 11, 2024 at 2:45=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> >>
> >> On 11/11/24 1:19 PM, Jiasheng Jiang wrote:
> >>> Add check for the return value of clk_enable() in order to catch the
> >>> potential exception.
> >>>
> >>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> >>> ---
> >>> Changelog:
> >>>
> >>> v2 -> v3:
> >>>
> >>> 1. Simplify code with cleanup helpers.
> >>>
> >>> v1 -> v2:
> >>>
> >>> 1. Remove unsuitable dev_err_probe().
> >>> ---
> >>
> >> ...
> >>
> >>> @@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_d=
ev *indio_dev,
> >>>               return -EINVAL;
> >>>
> >>>       case IIO_CHAN_INFO_ENABLE:
> >>> -             mutex_lock(&priv->lock);
> >>> -             if (val) {
> >>> -                     if (!priv->enabled) {
> >>> -                             priv->enabled =3D true;
> >>> -                             clk_enable(priv->clk);
> >>> -                     }
> >>> -                     regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_=
CEN);
> >>> -             } else {
> >>> -                     regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR=
1_CEN);
> >>> -                     if (priv->enabled) {
> >>> -                             priv->enabled =3D false;
> >>> -                             clk_disable(priv->clk);
> >>> +
> >>> +             scoped_guard(mutex, &priv->lock) {
> >>> +                     if (val) {
> >>> +                             if (!priv->enabled) {
> >>> +                                     priv->enabled =3D true;
> >>> +                                     ret =3D clk_enable(priv->clk);
> >>> +                                     if (ret)
> >>> +                                             return ret;
> >>> +                             }
> >>> +                             regmap_set_bits(priv->regmap, TIM_CR1, =
TIM_CR1_CEN);
> >>> +                     } else {
> >>> +                             regmap_clear_bits(priv->regmap, TIM_CR1=
, TIM_CR1_CEN);
> >>> +                             if (priv->enabled) {
> >>> +                                     priv->enabled =3D false;
> >>> +                                     clk_disable(priv->clk);
> >>> +                             }
> >>>                       }
> >>>               }
> >>> -             mutex_unlock(&priv->lock);
> >>> +
> >>>               return 0;
> >>>       }
> >>
> >>
> >> Another way to do this that avoids changing the indent
> >> so much is placing braces around the case body like this.
> >> This also avoids the compile error from using guard after
> >> case directly.
> >>
> >>
> >>         case IIO_CHAN_INFO_ENABLE: {
> >>                 guard(mutex)(&priv->lock);
> >>
> >>                 if (val) {
> >>                         if (!priv->enabled) {
> >>                                 priv->enabled =3D true;
> >>                                 ret =3D clk_enable(priv->clk);
> >>                                 if (ret)
> >>                                         return ret;
> >>                         }
> >>                         regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1=
_CEN);
> >>                 } else {
> >>                         regmap_clear_bits(priv->regmap, TIM_CR1, TIM_C=
R1_CEN);
> >>                         if (priv->enabled) {
> >>                                 priv->enabled =3D false;
> >>                                 clk_disable(priv->clk);
> >>                         }
> >>                 }
> >>
> >>                 return 0;
> >>         }
> >>
> >
> > Looks great.
> > But there is no indentation between "switch" and "case".
> > As a result, the closing braces of "switch" and "case" will
> > be placed in the same column.
> >
> > Like this:
> >
> > switch(mask) {
> > case IIO_CHAN_INFO_ENABLE: {
> >
> > }
> > }
> >
> > -Jiasheng
>
>
> Usually, there is a default: case as well, so we could move the
> final return and make it look like this:
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>                 return regmap_write(priv->regmap, TIM_CNT, val);
>
>         case IIO_CHAN_INFO_SCALE:
>                 /* fixed scale */
>                 return -EINVAL;
>
>         case IIO_CHAN_INFO_ENABLE: {
>                 guard(mutex)(&priv->lock);
>                 if (val) {
>                         if (!priv->enabled) {
>                                 priv->enabled =3D true;
>                                 clk_enable(priv->clk);
>                         }
>                         regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CE=
N);
>                 } else {
>                         regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_=
CEN);
>                         if (priv->enabled) {
>                                 priv->enabled =3D false;
>                                 clk_disable(priv->clk);
>                         }
>                 }
>                 return 0;
>         }
>                 default:
>                         return -EINVAL;
>         }
>
>
> And it is unusual, but I found kvm_arm_pmu_v3_get_attr() that
> also has this double inline brace at the end of a switch statement.
>
>         }
>         }
>
> So even if it doesn't look so nice, it does seem to be the
> "correct" style.

Thanks, I will submit a v4 patch.

-Jiasheng

