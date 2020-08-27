Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445BA254F78
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0TzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:55:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A53C061264;
        Thu, 27 Aug 2020 12:55:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q93so3097114pjq.0;
        Thu, 27 Aug 2020 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iCBP+9jZBWChmw6UiUb37gEZ3nyFFfurQpHrGXgKOo=;
        b=fmDKpG7JsNZWYR4WnBcEBetb/oHsOCdtX523ndIe2IZMPYsIrBIKn1XtshfI4TqHwu
         D08AXB8uTUFH9zriG8lI0eNgDKRlaSQ9a+EWr/izTx93LB42f1p07HwFExW+QrUgdzyd
         ilaVRZ8+BDgLBgmCDQoEuZoEJTPlFaZWucf3rXVXkqEzzE9MpG9unIWKWpgco9V4FBG8
         CPvCh+d3lPSpQGZwMLm0Rg+2Ygk4XldfIOOPsXF+p9+3iCHmyKGE8aFMr8pYT4nRCAqb
         eEVyijsnhpi5gSlqNea/keX3CLEEgpzZulaCr/n7I8TIfrBd63KA70brURiKiTw0S43y
         LaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iCBP+9jZBWChmw6UiUb37gEZ3nyFFfurQpHrGXgKOo=;
        b=OTouiZdUMlMdua/+D3F1QppcmWZXJWcXolzUWgXqgRBURmecDks8WpBfiutGxd/stY
         ZGUd7gPKzXqQEYS3LU2ctmNrkL7g5RGpJS8vSsBSnj5LyCdbz2ffTE6MgmUvegJAVO7R
         7XI9FWPGzfTEVMxKm3+ve4l6tB25hPaU3AboTyUnMfMKMvJGyhzBVcWEIRgYQd8Xs/CG
         FN3PmaWq0oVUNULU/xpSRK8OYLBRXIiD3iepamVEPrEYIgBbzknSerYQ1A11LVOa2h9q
         Q5kzFHTjE2eziR+8Uwf0gNZnq6vDAMG90IlyZpc8hjJSQpV/c/nKwmVGTT1HQqUFKvDf
         A6LQ==
X-Gm-Message-State: AOAM533hTnFbC91GA88e3BSKLBo4kFJTTLO2Vqz9K2dEbeTPpKmdPrgE
        ylgpHRCGAey8WjzPWMSlgSdyPcUxJNtB8s++wi0=
X-Google-Smtp-Source: ABdhPJy3db6CIQJ4K7OGhMgQan8eyYxEg/iBHcrwmiOZE1uEdOWivJYmfC67a+ptd7Jp7WYZumerqKG+TuNU5caIQKE=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr418944pjd.129.1598558101205;
 Thu, 27 Aug 2020 12:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-9-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-9-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:54:45 +0300
Message-ID: <CAHp75VeH1dcn7TzdWf7N5kQ2EQeBXFyXRpRHBb4TyUrx+g4q8A@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with dev_err_probe()
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
>  drivers/iio/afe/iio-rescale.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 69c0f277ada0..8cd9645c50e8 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -276,11 +276,8 @@ static int rescale_probe(struct platform_device *pdev)
>         int ret;
>
>         source = devm_iio_channel_get(dev, NULL);
> -       if (IS_ERR(source)) {
> -               if (PTR_ERR(source) != -EPROBE_DEFER)
> -                       dev_err(dev, "failed to get source channel\n");
> -               return PTR_ERR(source);
> -       }
> +       if (IS_ERR(source))
> +               return dev_err_probe(dev, PTR_ERR(source), "failed to get source channel\n");
>
>         sizeof_ext_info = iio_get_channel_ext_info_count(source);
>         if (sizeof_ext_info) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
