Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08D2636F6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 21:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIT55 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 15:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgIIT55 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 15:57:57 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B2521D91;
        Wed,  9 Sep 2020 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599681475;
        bh=Fj/ZQbw6iThGFoHDEPgT4Mpjuadx6d6xm8WtTwb+cS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gH+Ux2bfsGWe0ZZ8cr/KH4k1RUwrjBxh2rNdIt1VeCmIfHUDCq39wW48JqvtybXWy
         Rw8pmYp1O3RalPallGy/5d3wY6dSMu5Y/7qWiIPM+cwz8vmVcrJWXqbauDdjEuVqkS
         bjUUVwZCxI6cw+s+WEaEuQPutenO211vAHrqJv18=
Received: by mail-ej1-f53.google.com with SMTP id z22so5325528ejl.7;
        Wed, 09 Sep 2020 12:57:55 -0700 (PDT)
X-Gm-Message-State: AOAM532xczjPP+a2j7QZz9Ei5PMAPunSRjdE6MeKUDi8151A2r3QS+iV
        bck/u5pz+icuurvMgAUyRnivU4sM7ER9XFwzM2g=
X-Google-Smtp-Source: ABdhPJwTMqh5k7vWahnMEeb3gRi7HnzNHjrkeMUXR1813rl6InlKMxnwCaXk5Vx2ppJEqh/OTvng43DjT6sRq5dxx5s=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr5150651ejx.215.1599681474195;
 Wed, 09 Sep 2020 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200829064726.26268-1-krzk@kernel.org> <20200829064726.26268-8-krzk@kernel.org>
 <20200909193600.41970d8c@archlinux>
In-Reply-To: <20200909193600.41970d8c@archlinux>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 21:57:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
Message-ID: <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] iio: adc: stm32: Simplify with dev_err_probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 at 20:36, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 29 Aug 2020 08:47:16 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and also it prints the error value.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> I don't have the thread to hand, but this tripped a warning next
> and the patch was dropped as a result. See below.

Thanks for letting me know. If you mean the warning caused by:
https://lore.kernel.org/lkml/20200909073716.GA560912@kroah.com/
then the driver-core patch was dropped, not the iio one:
https://lore.kernel.org/linux-next/20200909074130.GB561485@kroah.com/T/#t

So we are good here :)

Best regards,
Krzysztof

> Jonathan
> > ---
> >
> > Changes since v2:
> > 1. Wrap dev_err_probe() lines at 80 character
> >
> > Changes since v1:
> > 1. Convert to devm_clk_get_optional
> > 2. Update also stm32-dfsdm-core and stm32-dac-core.
> > 3. Wrap around 100 characters (accepted by checkpatch).
> > ---
> >  drivers/iio/adc/stm32-adc-core.c   | 75 ++++++++++--------------------
> >  drivers/iio/adc/stm32-adc.c        | 10 ++--
> >  drivers/iio/adc/stm32-dfsdm-adc.c  | 10 ++--
> >  drivers/iio/adc/stm32-dfsdm-core.c |  9 ++--
> >  drivers/iio/dac/stm32-dac-core.c   |  5 +-
> >  5 files changed, 35 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 0e2068ec068b..3f27b4817a42 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -582,11 +582,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
> >       priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
> >       if (IS_ERR(priv->syscfg)) {
> >               ret = PTR_ERR(priv->syscfg);
> > -             if (ret != -ENODEV) {
> > -                     if (ret != -EPROBE_DEFER)
> > -                             dev_err(dev, "Can't probe syscfg: %d\n", ret);
> > -                     return ret;
> > -             }
> > +             if (ret != -ENODEV)
> > +                     return dev_err_probe(dev, ret, "Can't probe syscfg\n");
> > +
> >               priv->syscfg = NULL;
> >       }
> >
> > @@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
> >               priv->booster = devm_regulator_get_optional(dev, "booster");
> >               if (IS_ERR(priv->booster)) {
> >                       ret = PTR_ERR(priv->booster);
> > -                     if (ret != -ENODEV) {
> > -                             if (ret != -EPROBE_DEFER)
> > -                                     dev_err(dev, "can't get booster %d\n",
> > -                                             ret);
> > -                             return ret;
> > -                     }
> > +                     if (ret != -ENODEV)
> > +                             dev_err_probe(dev, ret, "can't get booster\n");
>
> This tripped a warning and got the patch dropped because we no longer
> return on error.
