Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79F827E055
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgI3F3I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3F3H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:29:07 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D7C061755;
        Tue, 29 Sep 2020 22:29:07 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r4so145435ooq.7;
        Tue, 29 Sep 2020 22:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIzuXn0cJGfjjlZNYmXAMtjJ7AdNZYIRMcgSkGHY+rw=;
        b=DaXb/c/uDbu9CSoAs8w/y0E58HXd+mO8R1fcGDpAUuYnxqPec/lom+7KrQ9tw1q6JC
         /FxiGbaTRTAUaVrU44GGj3E8nWDb6D0iWlKEji3XxnZaUKl33itQ3XSfVyg1jAxeAqda
         fK62GtBotmLHs57UI5vi4XOuwuKI+5eHXe1L18hiFwaEFdQkkvLsLxbzrpnRm6VKBltm
         a8qxbN4b9yTU4/9gwEzY8ygCCZba1ZfdwPa8PaHXR+tfbjXbXtobcIL0Vo0y8IqmPfSW
         3hqTpX/X0F2UQ0lvEOaF7wTCTPIW0aBMhdGNQyVEq4Xfe7z9/tXcRbMiUAfUPjEq8FEo
         bMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIzuXn0cJGfjjlZNYmXAMtjJ7AdNZYIRMcgSkGHY+rw=;
        b=YOLRV/GrFwnnbDGp3LO84aVNqswsqULlPLW/7U6DAZbooa79a2swKOpX+RG37Bz9pc
         U2vRnpcMJv74mObspCX0CYo7W4/zskRscSpHuwukVZZkqvYyOBgypj4/pCgUqwYyoM1a
         7JqU5+TDNXO4sS4YmuuN9ItimumTTcxBVd44gkpy2njAKmwcjUbct2IjUQ3v8rES5oqv
         RWGF9bPhDXekT3CvyeefQLl0wV8sAWKHvnQwtvgd6s1CXKxRjQ1VqkhCZxmkF3Zekr3J
         OZHJE4D8djZvcSqK826dpV5hTul5Ekbe6NDcyVRXBjovTiX3dMkaajQwZiuUugdq0sbH
         fW2w==
X-Gm-Message-State: AOAM532ArTAYIjA7kwwfj+v/kUrpMFV0AtOL5NyLQH2XSO+s2LMOJPQu
        A/jhfCYj7MpqAbxFvFcevCOeILalVf3nZkjksCU=
X-Google-Smtp-Source: ABdhPJy9PS3Ws5Xyf5PrWCdK9NkNskxD+dVxzzrp5tTDmreXIRxin2vboMBh5hN1bzPZvgZ8i+Ahcc6oztR+49JbqUk=
X-Received: by 2002:a4a:b982:: with SMTP id e2mr778351oop.0.1601443747011;
 Tue, 29 Sep 2020 22:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125424.35921-1-alexandru.ardelean@analog.com> <20200929165428.15ac9e4c@archlinux>
In-Reply-To: <20200929165428.15ac9e4c@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 08:28:56 +0300
Message-ID: <CA+U=DsrKGTE3nC09NEHfksF=1WQaUrM1jV5zpw3u272+zEt1cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: at91_adc: use of_device_get_match_data() helper
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alexandre.belloni@bootlin.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 6:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 28 Sep 2020 15:54:23 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This tries to solve a warning reported by the lkp bot:
> >
> > >> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
> > >> 'at91_adc_dt_ids' [-Wunused-const-variable]
> >    static const struct of_device_id at91_adc_dt_ids[] = {
> >                                     ^
> >    1 warning generated.
> >
> > This shows up with 'compiler: clang version 12.0.0' and W=1 (as the bot
> > mentions).
> >
> > Forward declarations for global variables can be a bit weird; forward
> > function declarations are more common.
> Hi,
>
> That's not the forward declaration that it is complaining about...
>
> It's a reasonable patch anyway, but doesn't fix that warning which is
> about of_match_ptr and the lack of #ifdef CONFIG_OF around the
> actual definition.
>
> For the bug warning, I'd add add a Kconfig dependency on OF.
> It doesn't make any sense to allow building this driver without that.
>
> So resend this as a simple tidy up patch and another one adding
> that build dependency.
>

At this point it might make sense to also remove the of_match_ptr() helper.
If adding the OF build dependency, the of_match_ptr() would always
return non-NULL.

> Thanks,
>
> Jonathan
>
> >
> > Maybe another fix for this would have been to prefix with 'extern' the
> > 'at91_adc_dt_ids' variable, thus making it more friendly as a forward
> > declaration. It would look weird, but it would work.
> >
> > But, we can avoid that forward declaration altogether simply by obtaining
> > the private data with of_device_get_match_data().
> >
> > This appeared after commit 4027860dcc4c ("iio: Kconfig: at91_adc: add
> > COMPILE_TEST dependency to driver"), which put this driver on the lkp's bot
> > radar.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/at91_adc.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 9b2c548fae95..c9ec0a4a357e 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -829,8 +829,6 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
> >       return ticks;
> >  }
> >
> > -static const struct of_device_id at91_adc_dt_ids[];
> > -
> >  static int at91_adc_probe_dt_ts(struct device_node *node,
> >       struct at91_adc_state *st, struct device *dev)
> >  {
> > @@ -878,8 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
> >       if (!node)
> >               return -EINVAL;
> >
> > -     st->caps = (struct at91_adc_caps *)
> > -             of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> > +     st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
> >
> >       st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
> >
>
