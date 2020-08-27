Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70AF254F85
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgH0T4I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0T4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:56:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C80C061264;
        Thu, 27 Aug 2020 12:56:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p11so4321135pfn.11;
        Thu, 27 Aug 2020 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLa56i743GyYyvzZsbp7wDSdWi+EGIOQBt69Q105LwQ=;
        b=SR0DcGiRNSloexRgT5hNz4a+LfcqsIQj20wgCxHugcf+XgWQvmGFw0bnb0I7KbH+/c
         ogmXVcx8dsIt5IUDS/nGPWPBDatpaPAfM4P20TV5kzuntmfkhHwjvY9r9zW/CV8eKDUc
         oyYKZqYPt8LQaH829LamjzKyYe8CKpA8OZQMHcTyINmYvBZQ4Df4AnE1g6asyOOpkfCD
         TLQ5THGMgBFl8C5iKS2IuJ5aKQKMbHXw2v1y9jSF9m0qwPaLjYSjfuAZwAOemI2Rj0bw
         NMvemTfF1vk0wlIrV2GWv254XcKVuSD1++6tqd8PyFVcEvx3nMHuigVsvGKhuYalkxEc
         wSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLa56i743GyYyvzZsbp7wDSdWi+EGIOQBt69Q105LwQ=;
        b=GJZP0fEp/v4KuWgi1S0LBWM6TDZ39NwvE0HqE2DIXIA2nOEtWnyAYAJRXUYMwoMxBn
         SwRs48DpaoIoAs8OUfDIH+l6irGYZIP3ZHAnaC1su4tGWzM50vq+KAfRZ6R00P05/6L1
         FJn8YwF+UE7I55duIQmN5YMj1CluMbCvAy5r1kpxDJjQNuxW8sdERJZ5p1pQK2VKHvUZ
         j//zp5gkrTYH+KZ4Y32Lyf9NSjRVitrqidhSkQ9mPEbxiVmrvrJzHl54KFUVKlzZOxZ/
         v3eD6juKNbZerQJh8psdmEk3x744B5FQslPQop8UzFNQhHDn9YvSYjxlyGb04aXD//UZ
         Ukfw==
X-Gm-Message-State: AOAM532OMH4EZhm44HPBRrn5KrSD5vOvYVdkd4gvaTexz4aaoMJusfD1
        WUbK2av6/12fW9MjeKhnljbGCGsq2lmHGwoDngg=
X-Google-Smtp-Source: ABdhPJzz9OgKhOSf0QaPl+XE+7282MSmPn4HpuGGEVGW9DN6uF+vFghnleghHOCVxElQYmTrlTqoeuz0+DPlkRO0bPw=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr15250227pgh.74.1598558167388;
 Thu, 27 Aug 2020 12:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-12-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-12-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:55:51 +0300
Message-ID: <CAHp75VezGhnwphb4JAkVeQtGQhDoH-AtkA2b-GvSwGFta6y+Jg@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] iio: dac: dpot-dac: Simplify with dev_err_probe()
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
> ---
>  drivers/iio/dac/dpot-dac.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
> index be61c3b01e8b..2258535b8a42 100644
> --- a/drivers/iio/dac/dpot-dac.c
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -183,18 +183,14 @@ static int dpot_dac_probe(struct platform_device *pdev)
>         indio_dev->num_channels = 1;
>
>         dac->vref = devm_regulator_get(dev, "vref");
> -       if (IS_ERR(dac->vref)) {
> -               if (PTR_ERR(dac->vref) != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "failed to get vref regulator\n");
> -               return PTR_ERR(dac->vref);
> -       }
> +       if (IS_ERR(dac->vref))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(dac->vref),
> +                                    "failed to get vref regulator\n");
>
>         dac->dpot = devm_iio_channel_get(dev, "dpot");
> -       if (IS_ERR(dac->dpot)) {
> -               if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
> -                       dev_err(dev, "failed to get dpot input channel\n");
> -               return PTR_ERR(dac->dpot);
> -       }
> +       if (IS_ERR(dac->dpot))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(dac->dpot),
> +                                    "failed to get dpot input channel\n");
>
>         ret = iio_get_channel_type(dac->dpot, &type);
>         if (ret < 0)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
