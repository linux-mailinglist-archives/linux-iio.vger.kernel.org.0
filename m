Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3886254F13
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgH0Tqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgH0Tqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:46:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2336C061264;
        Thu, 27 Aug 2020 12:46:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so3185072pjb.3;
        Thu, 27 Aug 2020 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4NU6BsCwiLu6+Otmj54J8lCct1JA9I1q/fhttNJEeg=;
        b=ihZcH1k73aBsEgGVPjWLQocZn0fiBEC/RyzxrU/a/t0cYY1yTfKtJ66qVhkBBsp+wF
         nw779Cfrk1akAVYBNt+EZtWu2J2NmHlfYL/ZlvN6p1PahyRIaAj1EbMUTlhHa7XvgkV0
         /8w5ROAiSv76TVIFV+c561WAxlYlzPfMn4sXrzdbRyRtpCjD8TIcgbiJejM6eH3lx27p
         KK7nlfSrWPxSO4IdnSX613qI7aWFERPo8/MESGlTrwgsb7OrsQOyFAvPaXaIBnfcsQci
         lWCQhO4na/uVhFLdgKeyFDb+Bf1qSyGck4aHlEjJnvi+8OQUWHxpyr6avAcVkC1Y2CeG
         RbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4NU6BsCwiLu6+Otmj54J8lCct1JA9I1q/fhttNJEeg=;
        b=DxDep1SvHbqBdw3BhOrknC8NWv5XTil7rvdD/9AfedU5pmYwQMx6LmCu90jFw79tp0
         2ghGPKvbsLeLLHUip00kqBuco7XrOLpsS6QrEHltBTnX/BoTYs3jHnFK6HNcwyqP92oP
         j+Bxrt9S2rKiNVnIZbXegbYPjT3xeWOzFnmyADGMOkKVw4WCAgHh/mao68r4qYm3fRJ5
         MrCxsYgpMVPsbsMubAvmiEmC7QD0/4PR5BAYPh2V+KBgNG6c3I72YjjzXVDtYJihu7p4
         churKw18dlXSo1BUF6/HIKCfWfOjcqJZgWUlCOq/zF4ywreU8jNRPHxEhHNPQudOYRiz
         KIjQ==
X-Gm-Message-State: AOAM533MBV35uPDEybVnTYQ9D1gHnpa4tkNDO3r2mp0AKKOGLZR1zE2A
        pHFoHDgrcJphd6cCpGgQBXHTr1BuCAo5jWpxaYN9FJjvFFpROIRv
X-Google-Smtp-Source: ABdhPJyEV1tQrkEPIueWwokrA4SXeGmpkXh42Z1LuwZzneAgw9EKay1IXMnHY/3R1fyTLePgzlAuANLM2A+JeHBP3ao=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr392684pjd.129.1598557590941;
 Thu, 27 Aug 2020 12:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-3-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-3-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:46:14 +0300
Message-ID: <CAHp75VdUfuuWWyYjejf=Oe0kdZmyc_RFDOB7cvZbJqNQ4NoW0w@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] iio: adc: envelope-detector: Simplify with dev_err_probe()
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
>  drivers/iio/adc/envelope-detector.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 2a4fd3bb64cf..91a7be4a3f1b 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -348,11 +348,8 @@ static int envelope_detector_probe(struct platform_device *pdev)
>         indio_dev->num_channels = 1;
>
>         env->dac = devm_iio_channel_get(dev, "dac");
> -       if (IS_ERR(env->dac)) {
> -               if (PTR_ERR(env->dac) != -EPROBE_DEFER)
> -                       dev_err(dev, "failed to get dac input channel\n");
> -               return PTR_ERR(env->dac);
> -       }
> +       if (IS_ERR(env->dac))
> +               return dev_err_probe(dev, PTR_ERR(env->dac), "failed to get dac input channel\n");
>
>         env->comp_irq = platform_get_irq_byname(pdev, "comp");
>         if (env->comp_irq < 0)
> @@ -360,11 +357,9 @@ static int envelope_detector_probe(struct platform_device *pdev)
>
>         ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
>                                0, "envelope-detector", env);
> -       if (ret) {
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(dev, "failed to request interrupt\n");
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to request interrupt\n");
> +
>         env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
>         if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
>                 env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
