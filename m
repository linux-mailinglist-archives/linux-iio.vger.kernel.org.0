Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E88254FAB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0UC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 16:02:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CDEC061264;
        Thu, 27 Aug 2020 13:02:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so4331181pfw.9;
        Thu, 27 Aug 2020 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZGo/LXMWA743P+olH7TRkE+L3lrjbqKbRZ3LxAQjPo=;
        b=dTu6o2U3wIn+j1v+r3MXNSN35FUN+T2Ga+C6IEZhOqyDDBfBE3A597INaQykc/zK5N
         e29lSW8oIy3von1EDSHzrXAVeRMAvW1ed+lYOELqagYL5sR2inJeqwfBbqXV4FK6sCMk
         Hfm42l4h/LTOWilsOGK7JOMAPAdmKuTI7ri15EU81fGomSsgujOEykmO3j5u3b8d00JT
         y6G7L3ZjYiblAjxovxtPZnHCI16Md4+vLhzEs1tK7lNien1ry4pAHrXAiN3tLj6C5xlc
         yK8rJWblvVYrsonzu63yJ/EgonbAcYBoDqsF2KrONQ8csAQTA+38zWBBwcTvD1DPUifV
         GLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZGo/LXMWA743P+olH7TRkE+L3lrjbqKbRZ3LxAQjPo=;
        b=mS4xUPJAIs6/fgjpcWp1vmIfjkQyihn4P+Y7q2SRTA6rmUh37dVoBgGjG+zLH98zXG
         5oRefqZBb003vDawErEhRVmO7eWcUL6jnV/4PobB2zvQyOgZBYsaw/jlnTw9YWjjJggv
         nqGt2+LuM9K1GN+FoMNhGI5fhPa6KgJo8sp2aNPFLX0RTRfuyU2e8i8hTCOBRDG57nYv
         xmY8rJfSMzJEaEHAnPZ255/+COmlkeCixqby9TtAirZM+sPhSCq9XOXRJJyppk+w/rSK
         qJ0Ji0cQCZ7q27NQRbcpP5M8S9suLBFgpmJbTzcpFy8sV1ksiAfGvkSOG1d6YveXHE/M
         +K/Q==
X-Gm-Message-State: AOAM531aelGRC0R/4qKJpP5AacIF90RkXKZ9EykLBpmVjG+8rLH7NjQt
        nMcx1PgBo4vcPgHMMhLy5IPlLTg2GjaRLFYzHng=
X-Google-Smtp-Source: ABdhPJyrJVOQaAjVOgzTH9Ia08ZxKIpsXNc3Mfx5rESAlYI8qMYgqJ1+s8Yh5E+7TlXUKU+iWqHjdU0n6g2EX6jm0oE=
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr17478277pfk.219.1598558545190;
 Thu, 27 Aug 2020 13:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-18-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-18-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 23:02:08 +0300
Message-ID: <CAHp75Vc4R_PkVSYFGNr0UO5yJ+dLGhVV-G7vznGnNu_aCVoTVQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] iio: magnetometer: iio-mux: Simplify with dev_err_probe()
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
> ---
>  drivers/iio/multiplexer/iio-mux.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 6910218fdb00..d219d4a86657 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -354,11 +354,8 @@ static int mux_probe(struct platform_device *pdev)
>                 return -ENODEV;
>
>         parent = devm_iio_channel_get(dev, "parent");
> -       if (IS_ERR(parent)) {
> -               if (PTR_ERR(parent) != -EPROBE_DEFER)
> -                       dev_err(dev, "failed to get parent channel\n");
> -               return PTR_ERR(parent);
> -       }
> +       if (IS_ERR(parent))
> +               return dev_err_probe(dev, PTR_ERR(parent), "failed to get parent channel\n");
>
>         sizeof_ext_info = iio_get_channel_ext_info_count(parent);
>         if (sizeof_ext_info) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
