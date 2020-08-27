Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD8254F21
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH0Ts0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0TsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:48:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A40C061264;
        Thu, 27 Aug 2020 12:48:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so4087006pgd.12;
        Thu, 27 Aug 2020 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kacN1ThtNH5U40mcv/4k6dMARnX9bfV0PWOTTEKKot4=;
        b=uCHxCyolCflVbO+WUbO5LZqzBxHhrvlh9Pfc4sUAey8ZLgzdCoqYIrLEdx8BpwQcBh
         s2GFIussGGUrYPA0MF7HrS5LyrCzsMV7f3icVtHxQDnUdBsayujKjO4yklbNWparyLk6
         6s/hYZYO7z9qF50wRRq3vSxKkZRtHXpiiZPUoABcbB8tpDAXLFRK8W47KyZVcZSsbKFl
         GcpeBcMwA/NHfGzT7yOp5nwKgLoqG3eJzac9x4Zrkxu9rtMnmOVUdbEfRzxdmbXvjGpK
         VnntcUFcoKeILOSwGYEdjuUalT1APy+Ayiduu0gb6oeP6w5roa17Qj+Rtnan3NJD4kzq
         Izgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kacN1ThtNH5U40mcv/4k6dMARnX9bfV0PWOTTEKKot4=;
        b=PTVrxoC6Aq8WsUFosIuRYITdoY/mGXxZ6HZVHB0QP7dnVgNFDezq7MxOszfhWppgIj
         O993P1gaNgaLGMZqr1ZgT7CFS0OVd7Z9faQGcwrj15/yZpx3Ch0fh26kCgQpYReuhu9W
         K84mjp5ZWHlwXEVEdPNZQLG3RRvjheMhrkyAW1mKSoZaILi0aY3VJxAhrHdEXfp0HJYg
         cTkfHi3A0VIAoRgXAeqRq2rTbli4aqgtCG2LOrhrS1AjLIkyfvmccFlER5Wf/2SI0ayd
         TQJIfEJu1T6MKq82liG7Q0XYcu+dyqi1I7JWi5q8yYbdPHHH6KBXjy9RsRbapdAzY6BV
         UWdg==
X-Gm-Message-State: AOAM531oMJe4txpYVB0wHcmn1c8fI3Nf5zJud90sNgx1nlGTl2bgLfgw
        /PHHDNfizqlOXf8nGlo+z8/v3/U2bVnygH7gBko=
X-Google-Smtp-Source: ABdhPJzMBvf3SlQ4MXHwemF7WLO50QwdlrwNqcBo2uex50d1LsuaXz279AsMkddgVB3byOEu0XId2Ie0ozFdCkvrviw=
X-Received: by 2002:a17:902:407:: with SMTP id 7mr17541240ple.167.1598557703780;
 Thu, 27 Aug 2020 12:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-5-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-5-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:48:07 +0300
Message-ID: <CAHp75VepFzdeN=jaXvmSmkQauDJfgSU5ut3hA6a+Cer_SC52Og@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] iio: adc: ltc2497: Simplify with dev_err_probe()
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

On Thu, Aug 27, 2020 at 10:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
>  drivers/iio/adc/ltc2497-core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 9b8fd9c32364..d337ed96bbb0 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -180,13 +180,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>                 return ret;
>
>         ddata->ref = devm_regulator_get(dev, "vref");
> -       if (IS_ERR(ddata->ref)) {
> -               if (PTR_ERR(ddata->ref) != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get vref regulator: %pe\n",
> -                               ddata->ref);
> -
> -               return PTR_ERR(ddata->ref);
> -       }
> +       if (IS_ERR(ddata->ref))
> +               return dev_err_probe(dev, PTR_ERR(ddata->ref), "Failed to get vref regulator\n");
>
>         ret = regulator_enable(ddata->ref);
>         if (ret < 0) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
