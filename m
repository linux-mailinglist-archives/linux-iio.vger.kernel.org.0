Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA027E410
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgI3Ir4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3Ir4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:47:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3CBC061755;
        Wed, 30 Sep 2020 01:47:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so1047727otl.9;
        Wed, 30 Sep 2020 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6/fD/ws2aB3vrNVkLIayTVczz7s8A639840tTt+7MA=;
        b=qV54GwsH//FF7a/jDVo4dW5AZWss/+1CgW4VHSBtPMXelyll4eAJZK06hmTAg+M02p
         YdTp28LKyhb8tImkxQzs/8c2rJ4612qG8m/nLqE0He+aMUuvYqsj6YGlCQ9RsRe4i7q8
         XpDM6MdGrtkfNtQbJr0dM2npiBVHPYF1cpE9a+pRTWZBfbqyBqFwJERXo2t/v391Eoj6
         IKOk1ERYJL054EmPkLFQ4xCRepTbFf+DwKXGDZcGlUBjfTdBvvP7s+3hRFOCtIdwKXKG
         qj9QHCf4vQz+s5AtJiYajEd1p/ezRteEORFk1KKVgtR5lrwn5cc03WlQNwhzc0U5+Nuh
         +Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6/fD/ws2aB3vrNVkLIayTVczz7s8A639840tTt+7MA=;
        b=cFIyw/XLFexWkv9QH7OwuZqp3NysmxHLSsEH/FuvWszyhgkw3jQPcVy7US+IHn7Gqd
         PLc1uUvby4mq0FOpXhXewwclxOlECZz2zqCN5eVNWCQ71S6ZhaBQa8qI8S316ftTADYo
         AskOV+lfRp45bgoMSNAxG5lbf0Jqu9KYX2XIn2WcpTLddboVQSZL2lr2vxBFypYo13Ok
         /oIt/DmesuuxHNTop+oYU86Ybk1IGdRnBpoQfkLKkVP5Fe/LNNj7XSzJ7XHh/DEafGfA
         JiHIq0W3305YV40nUmvb3seh9TZAReJffCwQ8o/gNVb7T1667zjDaLrlv9xi1lTsgSDx
         98bQ==
X-Gm-Message-State: AOAM53210A4tcWlg1nRNGczQQmcxaKakSx1NEm1qGhkZ4xVJpQc+IVhR
        U7J9cGgLs0aBPHd8/MQfXBoMdDqPcJ3zgcIiRn4FYU/0pBZHGw==
X-Google-Smtp-Source: ABdhPJykpfyzYCxYNo9YM8F32H2Kq2PtOnT6utFOoLcrBo6wkRHkIp+Gq90hRG+NUNj9pThL5IZJ9Qi9Z7ZsLAivASA=
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr910764otm.119.1601455675619;
 Wed, 30 Sep 2020 01:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-4-alexandru.ardelean@analog.com> <20200930073727.GC2804081@piout.net>
In-Reply-To: <20200930073727.GC2804081@piout.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 11:47:44 +0300
Message-ID: <CA+U=Dsq9Gu6Ayo9k0pzzCD4vA0+4YbfL+HEHSmxDzEZs35g21w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: at91_adc: add Kconfig dependency on the
 OF symbol
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 30, 2020 at 10:39 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 30/09/2020 09:00:07+0300, Alexandru Ardelean wrote:
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
>
> Shouldn't all of that be part of the commit message for 1/4? This
> doesn't explicitly explain why you add a dependency on OF.

Hmm, I think I did this patch before drinking my morning coffee.
Looks like it's also a bad commit description.

>
> > Fixes: 4027860dcc4c ("iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/adc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 91ae90514aff..17e9ceb9c6c4 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -295,7 +295,7 @@ config ASPEED_ADC
> >  config AT91_ADC
> >       tristate "Atmel AT91 ADC"
> >       depends on ARCH_AT91 || COMPILE_TEST
> > -     depends on INPUT && SYSFS
> > +     depends on INPUT && SYSFS && OF
> >       select IIO_BUFFER
> >       select IIO_TRIGGERED_BUFFER
> >       help
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
