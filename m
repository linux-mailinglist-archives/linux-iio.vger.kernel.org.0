Return-Path: <linux-iio+bounces-12154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A815D9C45AC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3978F1F223D7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E741A76C7;
	Mon, 11 Nov 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kECp76W5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61B1A08CB;
	Mon, 11 Nov 2024 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352557; cv=none; b=P2rt0pukFfoDvv7wjv0uTcLrluuLGVHH0jdr0AyZlUK0Y3Ir+kUq2/DzKtZsPAEXk/LQhDmOaqZNBc/IwG0q6VDAbGr5mARc/zNyazgwRQMS6xYuSkHhvy8AU9wpilRKolSafyQDnmP2oUIdyLg3omWRMByNNQHuPSQjsaSoRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352557; c=relaxed/simple;
	bh=sQVRSx7Gg9d1F5e09H4t3116F84QPIi/548ZCSSRobQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQNbiaqGdQFII92rBkWvYAqBZ1VdsIRuNnXSTog54/UVLvuPBfywFi6gJKkgTM9Nl4sxtgKYwAGif6J43A0GIz6n2HXdvIm43QvQARxbz3wZmTIiy+0um+/5aDMqywTqieUHeBagZRtW/sspznOgelHvvcwb4ZKh5nNAscgtu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kECp76W5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e30d821c3e0so4592890276.1;
        Mon, 11 Nov 2024 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731352555; x=1731957355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw0q3qDT0vi95T+/YkCGNgpoNAWEsqCRmfo1keQBb+c=;
        b=kECp76W5P779AVi9OGi4NEkb4AwzxL5/ngtR8Z1gpxJt4arHWwbUzKylIMW8aNHsBW
         nY6zZJq0fmgQBtCDywyUU1oP8CjR6Qq9jg5DHvPCZxhAm9cn+ykR2tzZHvKCrx5ERBND
         PPBVR5x1nhpbnPfIc10O17wjetprkWYaP1LVPMi1xOLh7iDvbItjfrQVftKAJdVsio8B
         AGYp/6saFnVMAQHWLGBNa2/1dA7FDbXex4ZMD5PCOev5G4/ChA0CwYiMsXnElSHYQLtm
         1VxKMfSchpmKnn9tBGNB+py3/p2OJCXpJsto06iB1floLpNIwcLVG5GnxcmhjPifbq/s
         xVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352555; x=1731957355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw0q3qDT0vi95T+/YkCGNgpoNAWEsqCRmfo1keQBb+c=;
        b=IEiDv59BQDoE8ZW7gW6qi+HP2iWYJ0vx6Jd9J26nKQ774Oxz6n2GhRS7+c1pqh97Tq
         QPX8I9TKgVcyC/Ft4W9z/JdttCI1M/bzhcZqOUJKjXwyffkVhhV7Lbr1T88lJJrz1q7M
         bcT/+Gbb7bShsfRryeK8K3BJk+zCvbSqdTP917wswe3o1L8ki4CvOpYQd9ggQF8j+dU0
         aMkGZ1GjIdg+6CEjDSpKE4Dly4IxIImudYfr/IpyYrW2DQTrlSWJP8Gz1faNQCDKfsz/
         72U/qyicEqw4PYGlYHTG2NSRL9PFm1UIHUQpFnq7JlUtFCkgwMEPAnaPw/3Bedpo8n7g
         49UA==
X-Forwarded-Encrypted: i=1; AJvYcCVZuPKzL8sphYDIhhoBMRUjhlNiqZx7v08k95WspJtdk37crBHTuL7m2SAZJ9z6POMabZ75r9nUjxA=@vger.kernel.org, AJvYcCXWniliQeGK3ymGZhZMxDUdTZO/yYIpXYev4CEts9VDf8PqziNAUNUunibl5paPcCVnOCPxZIDMZYaNSNPP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1OY89rdqaPkFt8DaVqkfkdON/lLCFWRxFzpoi4t1WCEXbikp
	vQIsq/+iR1N2IwCWrFTAXhiMWc26/ffY/H0mbE0GaAwg4Y/RN6+k2dKY5CjaYXCuJRxOChNChmF
	pO8lrXGNjwzLggHCUv/aoeyDZVsJYFck5
X-Google-Smtp-Source: AGHT+IEuNdtxOHM/XUCGisUrhzSAQE8+Xh3Htc50ucyk7blV/x9p9fuCjKqwKXS9o+Xm3Iq8+nBpx1uIoLkq8gxXuD4=
X-Received: by 2002:a05:6902:1887:b0:e2b:d9d7:9078 with SMTP id
 3f1490d57ef6-e337f8446cfmr10907400276.3.1731352554935; Mon, 11 Nov 2024
 11:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108200900.44727-1-jiashengjiangcool@gmail.com> <20241109133846.53d7ef06@jic23-huawei>
In-Reply-To: <20241109133846.53d7ef06@jic23-huawei>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Mon, 11 Nov 2024 14:15:43 -0500
Message-ID: <CANeGvZVxte61_FgrrYEt_oTRXXzCESrvq4q90xSWz4JqpMAtYg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	u.kleine-koenig@baylibre.com, tgamblin@baylibre.com, fabrice.gasnier@st.com, 
	benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 8:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri,  8 Nov 2024 20:09:00 +0000
> Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:
>
> > Add check for the return value of clk_enable() in order to catch the
> > potential exception.
> >
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> Hi,
>
> In principle this is fine, but I'd rather we made use of guard()
> / scoped_guard() rather than adding the explicit unlocks.
>
> If you do that as a precursor patch in appropriate places
> in the driver then this will be a little cleaner.
>
> Note I'll not be taking this until next cycle now anyway.
>
> Jonathan
>
> > ---
> > Changelog:
> >
> > v1 -> v2:
> >
> > 1. Remove unsuitable dev_err_probe().
> > ---
> >  drivers/iio/trigger/stm32-timer-trigger.c | 32 ++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/tr=
igger/stm32-timer-trigger.c
> > index 0684329956d9..e1e077122f73 100644
> > --- a/drivers/iio/trigger/stm32-timer-trigger.c
> > +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> > @@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_tri=
gger *priv,
> >                            unsigned int frequency)
> >  {
> >       unsigned long long prd, div;
> > -     int prescaler =3D 0;
> > +     int prescaler =3D 0, ret;
> >       u32 ccer;
> >
> >       /* Period and prescaler values depends of clock rate */
> > @@ -153,7 +153,11 @@ static int stm32_timer_start(struct stm32_timer_tr=
igger *priv,
> >       mutex_lock(&priv->lock);
> >       if (!priv->enabled) {
> >               priv->enabled =3D true;
> > -             clk_enable(priv->clk);
> > +             ret =3D clk_enable(priv->clk);
> > +             if (ret) {
> > +                     mutex_unlock(&priv->lock);
>
> as below guard() for when the mutex is locked is cleaner.
>
> > +                     return ret;
> > +             }
> >       }
> >
> >       regmap_write(priv->regmap, TIM_PSC, prescaler);
> > @@ -307,7 +311,7 @@ static ssize_t stm32_tt_store_master_mode(struct de=
vice *dev,
> >       struct stm32_timer_trigger *priv =3D dev_get_drvdata(dev);
> >       struct iio_trigger *trig =3D to_iio_trigger(dev);
> >       u32 mask, shift, master_mode_max;
> > -     int i;
> > +     int i, ret;
> >
> >       if (stm32_timer_is_trgo2_name(trig->name)) {
> >               mask =3D TIM_CR2_MMS2;
> > @@ -326,7 +330,11 @@ static ssize_t stm32_tt_store_master_mode(struct d=
evice *dev,
> >                       if (!priv->enabled) {
> >                               /* Clock should be enabled first */
> >                               priv->enabled =3D true;
> > -                             clk_enable(priv->clk);
> > +                             ret =3D clk_enable(priv->clk);
> > +                             if (ret) {
> > +                                     mutex_unlock(&priv->lock);
> As below. Prefer use of guard() so we don't have to handle the unlock man=
ually.
> > +                                     return ret;
> > +                             }
> >                       }
> >                       regmap_update_bits(priv->regmap, TIM_CR2, mask,
> >                                          i << shift);
> > @@ -482,6 +490,7 @@ static int stm32_counter_write_raw(struct iio_dev *=
indio_dev,
> >                                  int val, int val2, long mask)
> >  {
> >       struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
> > +     int ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > @@ -496,7 +505,11 @@ static int stm32_counter_write_raw(struct iio_dev =
*indio_dev,
> >               if (val) {
> >                       if (!priv->enabled) {
> >                               priv->enabled =3D true;
> > -                             clk_enable(priv->clk);
> > +                             ret =3D clk_enable(priv->clk);
> > +                             if (ret) {
> > +                                     mutex_unlock(&priv->lock);
> Add include of cleanup.h and swithch the place where the mutex is locked =
to
> guard(mutex)(&priv->lock);
> then remember to drop the explicit unlocks.

I found that cleanup.h is already included.

Moreover, since labels cannot be followed by declarations,
I encountered a compilation error when using guard().
Therefore, I switched to using scoped_guard().
>
> > +                                     return ret;
> > +                             }
> >                       }
> >                       regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CE=
N);
> >               } else {
> > @@ -601,7 +614,7 @@ static int stm32_set_enable_mode(struct iio_dev *in=
dio_dev,
> >                                unsigned int mode)
> >  {
> >       struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
> > -     int sms =3D stm32_enable_mode2sms(mode);
> > +     int sms =3D stm32_enable_mode2sms(mode), ret;
> >
> >       if (sms < 0)
> >               return sms;
> > @@ -611,7 +624,12 @@ static int stm32_set_enable_mode(struct iio_dev *i=
ndio_dev,
> >        */
> >       mutex_lock(&priv->lock);
>
> Perhaps scoped_guard() is  appropriate here.
>
> >       if (sms =3D=3D 6 && !priv->enabled) {
> > -             clk_enable(priv->clk);
> > +             ret =3D clk_enable(priv->clk);
> > +             if (ret) {
> > +                     mutex_unlock(&priv->lock);
> > +                     return ret;
> > +             }
> > +
> >               priv->enabled =3D true;
> >       }
> >       mutex_unlock(&priv->lock);
>

Thanks, I will submit a v2 to simplify code with cleanup helpers.

-Jiasheng

