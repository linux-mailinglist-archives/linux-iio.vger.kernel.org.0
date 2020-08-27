Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31181254F7B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0TzX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TzX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:55:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF9C061264;
        Thu, 27 Aug 2020 12:55:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so4115163pgh.6;
        Thu, 27 Aug 2020 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a447o0TIIe56Effe0RiDEzq1r8VXzso23Bql8Sh47SQ=;
        b=iJNPerv+D6Wlv6jntU6RuRXEHqUp0FtUPafG+q6O82bxjmsX3wu7vAqvlxhZaghmSH
         dUNPoFLCxeQT9RuzUpIQ2d+NiOiS0UACXwcF5I17AfP+xEbYRmaqzxZEDbKx4KekJt0/
         o/zQVjSyDNFrTQRZRXUONJ8yRxCiBNZgwZTwnCzUgJdnJtYXkG/g70yPUVIjLa0w+/JA
         Tx3TDT9Z0upM8vHEOacF2i6Ow8CajOZIWnlL8NU0rd+QN2ctK8aTkUHNxM4wv4oiSONl
         3nS6f94NDBc2sfh5IC73mwfWYinCyfMaWBDtva/HV69+ec5NQT+QJzccwa6HzQx67i4R
         /f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a447o0TIIe56Effe0RiDEzq1r8VXzso23Bql8Sh47SQ=;
        b=uRkz7oc2X3Cwo+zWG5SiiDoGwS3uy/GXG5fCKUIiEouJiAi5LvDjda+/NDpeQcr+Of
         qI148w1hEFRUmfDoNmnZgFnP3rmDJNtRdyhguL4tB9vrMu7ceMlCt7QB6LMNDgTu2XFM
         F2b7lePYQqEIKTm8H0V9odgCEJ2h9pTyc3qs6DHHa4QZGESgcrEcLUHtkVLo0HdIJOMl
         SuH/1Q9PksZxDOYaIR6iEqI/ruBECNxi301BaLEfX7eoTWXu0zXLbfGPF4ONESabJ7g0
         3t+MDBh8oqqai7EQNOJmjt27o4KT7PkMItAU0PSPeFM/rrnSlXrOlM/K3dlwIp7VhcRP
         t0sQ==
X-Gm-Message-State: AOAM532KxSbSBJuCoYskl0Gq80PSnncob8RPa8e9YCF3FcRIWMoNBAUa
        UH5s1Ru0HIi/b9Y2SB3Edu9Z/D7/fD4fEXueFeM=
X-Google-Smtp-Source: ABdhPJw67IkikO0xwQzWrqUZ4T363Hvhj2FtfLCQk/A2GvTmAUns7Z2+M8nm+bLCgXnjK3iq2pIei3aEvQrODJB24bM=
X-Received: by 2002:a63:c543:: with SMTP id g3mr8405213pgd.203.1598558122833;
 Thu, 27 Aug 2020 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-10-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-10-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:55:05 +0300
Message-ID: <CAHp75VcNQzZCWMg-jyOYuVfcJ-C9+=3Z2hn1-7yQ6yXNfOz-yQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] iio: amplifiers: hmc425a: Simplify with dev_err_probe()
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
>  drivers/iio/amplifiers/hmc425a.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index 582708924e4f..bde11df4bb9e 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -201,12 +201,8 @@ static int hmc425a_probe(struct platform_device *pdev)
>         st->gain = st->chip_info->default_gain;
>
>         st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
> -       if (IS_ERR(st->gpios)) {
> -               ret = PTR_ERR(st->gpios);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "failed to get gpios\n");
> -               return ret;
> -       }
> +       if (IS_ERR(st->gpios))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(st->gpios), "failed to get gpios\n");
>
>         if (st->gpios->ndescs != st->chip_info->num_gpios) {
>                 dev_err(&pdev->dev, "%d GPIOs needed to operate\n",
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
