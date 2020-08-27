Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7E254F9E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgH0UA5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 16:00:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB0C061264;
        Thu, 27 Aug 2020 13:00:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so4108595pgy.13;
        Thu, 27 Aug 2020 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PibWI1WPUcSBuRxCpQduFOuzkYtMaBM/7TN/dC+YiE=;
        b=b7gOG6wgCzT8BP986bm1kkzzFNR5NMwx61bMRrJN7WECwQlCKbLJ0mj+ASuG3rLlY6
         sqRQr5z+Q5tmBHLiaNmXtpOJF/m8HhJKOC0N3BnLyEbvLECd9gi43KZGF2mLOy/Fx4eF
         agm1klSih22rh2dQo7IKSSeLNshpUwc1PCIvsvcCgIR4zda8EF+aBJ++duzL8wRoYBRC
         lV+0tCCiFNxVlpGSz7CUbjh0RX+LcmJ5edho3Lr1QZwtUFcqdZGWYHGcG5ZsUTsQWcFN
         mA0KZnlMJH3puC9gFYa7jPr92KVbp1OjVTWGkYZ+h+qUcWiPSjgBhwkVisWpkBweIh4Z
         T5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PibWI1WPUcSBuRxCpQduFOuzkYtMaBM/7TN/dC+YiE=;
        b=Hgc/B/u/oJU7b5temJ8sEsxInv1lkofBzDPuGAnJxRndyf8E2zApjOgpt9t7B+skPq
         99gWNhNUo/YFCWo/6QRvd+SAR9ROHakiRKdle9vSWmtIf1yWjkqRshd4Vufqi5YpAb0K
         jNXnymRT1L8m0JnnTIrnrdjioBcGlfqnilKtRtzDEbZ6QefgzTU7zpXwRntEK4uS0w/x
         JzVno2xisBvH+2kLLwpmmb2qHRQ/J2gMLm279UfD8WbVxMIjLRtLsG7RccErWjVVamFC
         /D6J44IKcwlShiKPB/gyC1HNcxNvo+3KHhKVwG39ktZjNI8o7PQF2iMJdSI5s8TrQlNc
         sEIw==
X-Gm-Message-State: AOAM532DiADWclD/C2ClxJv8ytBzYrFScQJbXmL7gjI7fm3/SWIqw8h+
        ccqJAjPd4tO4TgqtYu50rJOmhI2PZ6Vz/fqHats=
X-Google-Smtp-Source: ABdhPJyEG1MTF89o46Q1T9Rrytm05a/DG3yol0nSkedmBByh0DN6BD25pKcq0V/H+yCjPfC4PIEK9jFZo90rwd/rC5g=
X-Received: by 2002:a62:9215:: with SMTP id o21mr6817717pfd.268.1598558456196;
 Thu, 27 Aug 2020 13:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-15-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-15-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 23:00:39 +0300
Message-ID: <CAHp75VeC248LYFUX2q-EU9c-d1pO2Fr0TCbS_U5+SaoQt3gn_A@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] iio: light: tsl2772: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 10:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Wrap dev_err_probe() lines at 100 character
> ---
>  drivers/iio/light/tsl2772.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 735399405417..d79205361dfa 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1776,14 +1776,8 @@ static int tsl2772_probe(struct i2c_client *clientp,
>         ret = devm_regulator_bulk_get(&clientp->dev,
>                                       ARRAY_SIZE(chip->supplies),
>                                       chip->supplies);
> -       if (ret < 0) {
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&clientp->dev,
> -                               "Failed to get regulators: %d\n",
> -                               ret);
> -
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(&clientp->dev, ret, "Failed to get regulators\n");
>
>         ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
>         if (ret < 0) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
