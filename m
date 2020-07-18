Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA308224A3E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGRJZE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgGRJYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jul 2020 05:24:55 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD2C0619D2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2020 02:24:52 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i3so9461945qtq.13
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2020 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFno1i8ULLYg3FCWz/CmmFbzrbZUMcHSe/iu00Qu+g4=;
        b=qraFjx5YB4bZTW6OHepRqQaJ0u0cZulZzc6jCeVJQqh5HmzdjraCoxIsFGOjzxFbEr
         J/CjhdP91NLLJbeYiRuK4+TC+KK/tuE8uSpy/P6hs/dQ0owN3mLDZlkgzjRMUerX3Px+
         VPE0K7m+Zvh7kJj5V9I3nWFF5+YxZuU6jLmxxOd+Sl4CduA9BetaIgNS9UlkwgeUssFl
         jTZSEDd5UWQd+VG1l2IiIf0dx0bE7QcrBp5OtohGKUQkHa6aaurNk1pxMjP+FFxojDy0
         HRPP6UodUcCNU8GyTEuMzs8KKjUjxbWToLpHa61Q0w2hAsZPR34YPEH6PSZ2y252A1w8
         uZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFno1i8ULLYg3FCWz/CmmFbzrbZUMcHSe/iu00Qu+g4=;
        b=jLBRrLfQTH/Ifk5rx0XBE5FT5G5J+ZjLzBKm7fxwZO3QiE2FAkDA5SilIquzoYSp3y
         IxVoEZ7QQY2Utrt4wZFw8v89wUX4la8ti+cDFXwGDhYNB1F7eym5lO788ds8wBriUMwe
         /d9KFayKeYRz7IUN4Pok9xa0AWbQBPbnT8+V6VJj+vh32zFM72BEALm4qBsjVKGAVRnt
         KoanSrrd7Ixq2ro/0kcuGdZNad84eUpABMAIMLSBaCkbHb9djzygw4WseEmk6FmtiR2E
         90gnJ+x5zwIlqR/NoGj6dWVYRT4cI0reif7vp3YQr9uGC+6M3jGpl8BoKge7fuX7ni/p
         qm2g==
X-Gm-Message-State: AOAM530T4os6lHnacMdU/JqSqr626MB3swu3Jzv8MJuXyUcDK9sZt3Bc
        cgcGiDONPVA7L5FyWHyVIGvTSbd24MKLpyrJJNNg8Q==
X-Google-Smtp-Source: ABdhPJzM6hZdvPE/up0GYkD8TSobS6uRvY5KVvY9t3AZiSjoUmWbKbOG/uO8a8eca75CeRF2Y+PpLa68jllHUSws0Bg=
X-Received: by 2002:aed:2684:: with SMTP id q4mr14373679qtd.208.1595064291603;
 Sat, 18 Jul 2020 02:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135928.1456727-1-lee.jones@linaro.org> <20200716135928.1456727-16-lee.jones@linaro.org>
In-Reply-To: <20200716135928.1456727-16-lee.jones@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sat, 18 Jul 2020 11:24:40 +0200
Message-ID: <CAMpxmJU1NZniOOofWykaHmpJDD=ZDw2HpRofDHHF01fvr_JZfA@mail.gmail.com>
Subject: Re: [PATCH 15/30] iio: dummy: iio_dummy_evgen: Demote file header and
 supply description for 'irq_sim_domain'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 16, 2020 at 3:59 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> File headers are not good candidates for kerneldoc.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/iio/dummy/iio_dummy_evgen.c:30: warning: Cannot understand  * @regs: irq regs we are faking
>  on line 30 - I thought it was a doc line
>  drivers/iio/dummy/iio_dummy_evgen.c:42: warning: Function parameter or member 'irq_sim_domain' not described in 'iio_dummy_eventgen'
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index ee85d596e5284..1febbbff0ded6 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (c) 2011 Jonathan Cameron
>   *
>   * Companion module to the iio simple dummy example driver.
> @@ -27,11 +27,13 @@
>  #define IIO_EVENTGEN_NO 10
>
>  /**
> + * struct iio_dummy_eventgen
>   * @regs: irq regs we are faking
>   * @lock: protect the evgen state
>   * @inuse: mask of which irqs are connected
>   * @irq_sim: interrupt simulator
>   * @base: base of irq range
> + * @irq_sim_domain: irq domain

To be even more clear: this could say: "interrupt simulator domain".

Bartosz

>   */
>  struct iio_dummy_eventgen {
>         struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
> --
> 2.25.1
>
