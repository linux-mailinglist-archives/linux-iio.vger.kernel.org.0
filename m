Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA520EEE8
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgF3HBn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgF3HBn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:01:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8492C061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:01:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so9517997pgq.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9O+Ual+ovjBZLx4ILq/2p57n9p4llzRVg0n11bBLvtI=;
        b=egITt2fZiE1NTB2+vrn9y1ig9L2jJcSP7t+uzr1As4TWJ8B1VU9/+5pAONzGNH4+nd
         1irHQLq38l5MFnENmAcmN6AkqDfKFCWrP1oF01AbKKwq0JpJCc39p3Iy8h/pKw++fnVp
         PYXBa5jCXMOB/kK8hv/t2MEbDJTXMil26O9RNP3+X2bB6hFErAC5gUknzdRR6/Fc0O7F
         vCz+1SB1LPbhvOnwophKC4ZLc6gpbI23D+btvSanXY+/e5IAWGpctHtAMKWTZIh2SbWE
         1VftRrreBdu56pEkUuJb6fMzbzrhOBPj/dPJQEd6zdomRzkjpbEVXlJPlyFP+bpfRDuY
         kitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9O+Ual+ovjBZLx4ILq/2p57n9p4llzRVg0n11bBLvtI=;
        b=jL4rzLX7BzzZ/7DairX+b5r9wzU1kaFwUIKoehNJ25JRR4gSY5HqCrYUQn8hl+c29s
         zjYQJopFVaIlSCDFnVA1w1Vls8FzMi0KruhTE0na4bpDSrBbdqLOxb2zrWeJjRHj6fge
         DIrrohRlpUHVmoZ7uFIhkMeWp0iuX0TSdwppKZyZ97mzlnE5Nnzcn6fE5hjuI0fkLB3r
         cj9gngMaFJrTxur6e61H0lS4wXqWZ3IUc8V8Xy16H9nUIcgns9xzyH4semipZ1Anql5I
         Jt7Yrn5x1hUdt5aPubxKtAycgaYIW0UbPxtfAXH3jnUyIPO0peMYMHcn3DwvgVGu1F2X
         OLVw==
X-Gm-Message-State: AOAM532Z4iIGlP+ecAYZgu4NeDgJbMJVnfbvlF+jC1kHhRyCAZaD7yKn
        R2nJm7w4dQR4Cjqv+ZbVqxEeU/kWlFNIBcre9iteJpP+rGo=
X-Google-Smtp-Source: ABdhPJzeG15HkkiLj7QiP8HGi4n4DBYlpz6upfZfMkzE2jUmDryE5qyTTktxWlLx74qLy4SD5hSwjJit+uhtfc4dXC8=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr8148510pgn.4.1593500502428;
 Tue, 30 Jun 2020 00:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-2-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:01:29 +0300
Message-ID: <CAHp75Vdxjb2ZR3HVVnfQpTpa=Ts2ToFJ-qG9NkXV7E9pcSx7JQ@mail.gmail.com>
Subject: Re: [PATCH 01/23] iio:adc:lpc32xx: Drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst is unlikely anyone will be using this part with an ACPI PRP0001
> based binding any time soon, we are getting a lot of cut and pasting
> of this pattern so I am looking to remove it entirely from IIO.
>
> In this case CONFIG_OF protections also removed and
> mod_devicetable.h include added given direct use of struct of_device_id.
>

Yes, it also fixes indirect inclusion of of.h.
LGTM!

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/lpc32xx_adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index bc2712a48844..b56ce15255cf 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -14,6 +14,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>


>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>
> @@ -209,19 +210,17 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id lpc32xx_adc_match[] = {
>         { .compatible = "nxp,lpc3220-adc" },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
> -#endif
>
>  static struct platform_driver lpc32xx_adc_driver = {
>         .probe          = lpc32xx_adc_probe,
>         .driver         = {
>                 .name   = LPC32XXAD_NAME,
> -               .of_match_table = of_match_ptr(lpc32xx_adc_match),
> +               .of_match_table = lpc32xx_adc_match,
>         },
>  };
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
