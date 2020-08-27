Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C52254F80
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgH0Tzn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgH0Tzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:55:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C42C06121B;
        Thu, 27 Aug 2020 12:55:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q93so3097853pjq.0;
        Thu, 27 Aug 2020 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKJLemoVLYYxLBYCuDxkTU6hysuqtvkOfMWKltUpHmg=;
        b=aHv8XBuvf3mu31R7gKeKtuhgl1EoOsKrQs5CzuB4CzH9W+US75wwPQkCadexNhNh8Y
         0aNGjmQg3w5t6xy7olIU3pLgnxAKjeBpK4hvGZeHopw6+XaKY3sCmgG8BERcRAN5hbty
         o90oICnyLq0PNZgSAc9Vx68ynwtaBo929qt8T5KVuCBUcgZ8iN8NKp4zsjEHhXsubYNi
         i20SB1o6xkpoYW5/YSmIBPyAI7ziv/N6WHGyTfxG80rFCPalXkVksf0FNDPmLSK41pL4
         NumTs+7qpXLhoWktPnOAmSOHDxt0X0RQs0eC41ysk8HCQtMo5qeBU9DzR1qJh77FoN7c
         QTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKJLemoVLYYxLBYCuDxkTU6hysuqtvkOfMWKltUpHmg=;
        b=jojwB8mHym9ZXe13eieDdfgsIhXHSa3vRbk9MaAiYG2mWPSFKMQEhYSm4Ntd1+KSY/
         DkExgHG2cq5R5SV+MeRTuICE9wVe4/1gcL8VIClVgt6gXobvNqC6k6UjIrSomydMC2Ng
         bxOJvYw0MX2t/BRK+vCmm390tikNPIOhXa/YlZzjcQyrIQyLZ34l+WQy7YWHUuLCAU4E
         5DCJ8N4reaPf90u877FF7zV8Q0H6ljVJ1a51Kqq91EO89PlEFE8yss2PXCIPCpvHY9pX
         Wx9YhFfxMBEF5jZeZ6ClpKZkzBsLJBwzQM94CqMHp66muOF2Vw7+huIJ/JP1xDpul5l7
         R5fg==
X-Gm-Message-State: AOAM530Ns0hsewABPS6Jvc5xrWdOdBvMizi0bHi3Cn37M/tNtqjBsCY6
        YI7N2MlhX9hfdD3fHgEJg8drFX13YZhJ8ukNOfk=
X-Google-Smtp-Source: ABdhPJzWsp6WVsNzpr3PrSg5dBnXCuc4a+cBQMZrivfL7x35pwluAfdNM04pSMxxwhkDuruCwpYH6X8QYAVfVIkpaUg=
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr384454pjb.181.1598558141774;
 Thu, 27 Aug 2020 12:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-11-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-11-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:55:25 +0300
Message-ID: <CAHp75VcQHTeAtw7zKkie+9re_GRpgdDKrR+Fq-77+mVEYDcFkw@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] iio: chemical: scd30: Simplify with dev_err_probe()
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
> Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
>
> ---
>
> Changes since v1:
> 1. Wrap dev_err_probe() lines at 100 character
> 2. Add Ack
> ---
>  drivers/iio/chemical/scd30_core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index eac76972f83e..4d0d798c7cd3 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -705,13 +705,8 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
>         indio_dev->available_scan_masks = scd30_scan_masks;
>
>         state->vdd = devm_regulator_get(dev, "vdd");
> -       if (IS_ERR(state->vdd)) {
> -               if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_err(dev, "failed to get regulator\n");
> -               return PTR_ERR(state->vdd);
> -       }
> +       if (IS_ERR(state->vdd))
> +               return dev_err_probe(dev, PTR_ERR(state->vdd), "failed to get regulator\n");
>
>         ret = regulator_enable(state->vdd);
>         if (ret)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
