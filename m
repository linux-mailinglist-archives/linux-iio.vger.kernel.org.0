Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F3254F3F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgH0Ttp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgH0Ttm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:49:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916DC061264;
        Thu, 27 Aug 2020 12:49:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so4315900pfn.5;
        Thu, 27 Aug 2020 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3gzyzO1gbxLdidSqR6d1wlDjGQFBUJvUcq8FiJnVtg=;
        b=Ix3Va+o+3XbmB70WBqBC725rnsHUyDm6ZoPZy2b6hcZ+38QrgQbROqTVcHhuzh8SXK
         rMQANp0HWGAK0S3jGGDuzX8pV7jIMANFnK9ew4PiVoz4gml/9QsbVZBlaad6zaN1zTHh
         L56Wy4g5LQD9tNdVMaYcFb7N6DSCrhozT7oT7ICoIwsrJXoKJ35rzoD+7dpGgpwdSemG
         QSZ1F8DLFO0OU5j/xtnuxVyj9N16sMJ07M9DSs8l6Ckbjdjz+9xWDA08Xegmz7/mZkJG
         XlgePyfePvWDzYQBw5KQxNn3PpFfJTT0e70LTT9XoS7BmcRJcAJrKFseBYXuCfY+VAcz
         tHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3gzyzO1gbxLdidSqR6d1wlDjGQFBUJvUcq8FiJnVtg=;
        b=KQMt2UWmN/7qvR49jOj55L8Aeudj0TQlLTpQhAlb2XBVx/MgeZUKlWD9vn5rpWHl+6
         bBWVxwmZpJV3RmQ2wNIEOrXwpWSgEzdPfFo/IQgCSWzf2MhA+vzVpN4IWU/8lIN30tX+
         lTEGw3qUtqL33YhBOVGHbm7Bl3/gwI3YbyZaE9BgUNCUSMHaa/2byQFOzjWWC05ekrA/
         3ypZKA2GRVNXpBsAFM9Ymmjr+l6BuxvujDHcOtuJlRgDj040aYYIVSefy2c/FhY6ZpvG
         jwxm3oVW+5vTkGy5kNbhuUa/EkZ9K+44EvxTKSU2XKjjb145Q1UyWc+ErncL/Jx5QTtl
         48sg==
X-Gm-Message-State: AOAM530AnCyKokKO6Y3I762fcf/SWao20PKoqsIiAcF6G0S9lupMS0hn
        SOvRnFnD9p4b7QMoXcpvdjs2DVPIffKg/QkgJiU=
X-Google-Smtp-Source: ABdhPJywOKJ7nbos0Vl5TfFihLljc3WSP3/cAdSxhBmVa6rR4UoZP9/yzEnECmoNYbP22WFTY+hpwLKOC2YaPImjw0A=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr6288066pln.65.1598557780819;
 Thu, 27 Aug 2020 12:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-7-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-7-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:49:24 +0300
Message-ID: <CAHp75VezjCWG+_qLWevc9nX5zQUoB+2UpLJo9HXqnV5svmwX-Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] iio: adc: rcar-gyroadc: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
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
        Beniamin Bia <beniamin.bia@analog.com>,
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

On Thu, Aug 27, 2020 at 10:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
>  drivers/iio/adc/rcar-gyroadc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index d2c1419e72a0..e1a7c93fc2db 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -495,12 +495,8 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->regs);
>
>         priv->clk = devm_clk_get(dev, "fck");
> -       if (IS_ERR(priv->clk)) {
> -               ret = PTR_ERR(priv->clk);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get IF clock\n");
>
>         ret = rcar_gyroadc_parse_subdevs(indio_dev);
>         if (ret)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
