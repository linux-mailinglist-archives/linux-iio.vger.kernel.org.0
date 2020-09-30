Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8127E05C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI3FaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3FaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:30:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC92C061755;
        Tue, 29 Sep 2020 22:30:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so632579otl.9;
        Tue, 29 Sep 2020 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu7XV755I5hRstMhFmm189SPTTuDmTjtnvxHW/n5cqM=;
        b=nLg+HuHF8v5IpVD6GX/sUt8IbL83AGZA5Vptt2IcZdymdTMlBtLEIPHXU+bz11e/56
         /GDeebPPsEGgZ1lFWxtIJx+wHcYrBQ1nwNUqdZaruS9LaDZuNH9VLCZvmjO239OKdLyc
         qeOmALsQGeTMjj2Zjp8piJdhEVrcnFke4jo1TGMhsn8DLGiYyda1U1XZTudQdOlsxB9E
         XXAMGps2AIlBJH27IzV0TDgudFA2YOqrcOf6FA2VWYZk1vTqYC7GT+i4mEkTg1Ex3zHQ
         DBJJfhHs+A6H711yR1R2+GECd6TW25dAu3b6aKJINvDyT0naxRIYi4sma6rGsHLhHhpO
         EUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu7XV755I5hRstMhFmm189SPTTuDmTjtnvxHW/n5cqM=;
        b=Nzx38giv85hYceXmJr9/pn2nsvT4A2BubNmQRb/agpJi6WkbxkJ30iTEWDb3s3nB5e
         jNlPPEAWH5KKBL5lAjbQWGsPxcYFjV9lQepSCaSg5oH01a7M15dKNmHRnirzMbNhmyoB
         2v6t55nOAWtdpOebQ9meh1x+xqJJiH4KoxhGviMvWprhQk+X/qJb4Z5rxQNL+Mn1gjHD
         mXxRhljaVg3QEHhefAffI90dPbqmcwMN6ACwvumMXIDo+4gpW0uF4DCQ5QhwkuNJWpn6
         JG5LWOTYiHKnTgQ53hddj7wnhXO99pIgFiYzauDF4uJKl06oc92cCYpXs+8FcoPlV9kJ
         9RaQ==
X-Gm-Message-State: AOAM532gSwNPxg15f8kDIcSwQ/ETHd1PHhkSKZRmTppMVSWoLCm8rqaT
        hpO+Opj9aBYggysOlQtXytunslAu4qIWoNTGUv8=
X-Google-Smtp-Source: ABdhPJzphhYh6zkmYIsXBH5FvEdz6jeZ+lTC4wCELtyH2X1rODe/XdR6hN1qf45yBJG2rMuNT6LNqQ3aRLEOJtatmBw=
X-Received: by 2002:a9d:50a:: with SMTP id 10mr476146otw.207.1601443817093;
 Tue, 29 Sep 2020 22:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125424.35921-1-alexandru.ardelean@analog.com> <20200929165428.15ac9e4c@archlinux>
In-Reply-To: <20200929165428.15ac9e4c@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 08:30:06 +0300
Message-ID: <CA+U=Dspd11N-pXXnnY_5CSzNp50iRr7h16zXTCxo8Fk+v48F7g@mail.gmail.com>
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

Also, silly me here.
I was just annoyed with the email from the bot, so I didn't dig too
deep to understand.

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
