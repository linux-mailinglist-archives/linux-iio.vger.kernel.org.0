Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02C55B354
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFZSBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZSBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 14:01:08 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE8DF70
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 11:01:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b24so4784790qkn.4
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVXHhx3n+nyvbL9oDJI5j0gwpB1MMGQFqUYQ2lBdnpU=;
        b=VCQHHxc9JxJBzrfU/FzZXm8tyT8TIOSNseRhX9KIZPkvSr3O7A2ttr0A1eiBMIM+t8
         07bc8l+NZu+mUe6PFiWCFOXT0SmZ8HjeCZYVAVG73/hDgjfHzM0sgEtWi9/dtx5f1Ykq
         WZI7o12iWdOF5UP+saV1KU+6gjqh5NTVxrF3yP2sEEFiGUwW7dXvrTygOktv3D2sGQo5
         RVmtqg3jkDyotzzj4Bvzv7iNsgBDoisKo7okH9ad/O3XN/Ai4sATjeyFZTDnRECcKB5y
         Uhi1Re2wikjS525638AC+E1zDrI0Q+bygbKrI6ilxzCpg3gyDMNq1+lerXR0hHLKUXOd
         SQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVXHhx3n+nyvbL9oDJI5j0gwpB1MMGQFqUYQ2lBdnpU=;
        b=A2o7ai19a9jjDH2m3zHFjQbqZFInTd/JBDBWG34HpGFx+8xzjdIWxf9P2MxLtHa1Db
         KGkyZb1Vfj3fDwS+jEzLiEcrA4xGay/7hd91+VaKTdglCTxSTHRU0dSUiSWSO68V05QG
         rf1QKGps2sgjgesnWqw9kC45zy4nZPplxTnDduAD1JA43K69ZXwcKvSeNL9GK0EF3c8z
         od86+VZi+Enh8sZ3KN4X57fzx0KzOhvWR90lUBdKyb3gf2SDtnakEgRHxBJoLE/M0VO5
         r2Lxb0X4wUpfqxIhe/APovvWzPuOcLUYM0fslLlS1eRk2TBEnx1/Pv2LYkagkixfYsGT
         FZyg==
X-Gm-Message-State: AJIora+IRCFp1MVl0gUaplUA5+ayXERWWa4PdPT5aecghL/7FAZO1qlL
        aW5yIixHqgWDhvrEsAh6CY1Cwud6T78Qm5nbdxs=
X-Google-Smtp-Source: AGRyM1u6FG5LAAvTI5NbPTG0qPyqhUFWMsOaWR2Va1ywgthSW457BGybZ1XI6djMTafclMXneXC3wA2LIpeHsQ85itU=
X-Received: by 2002:a05:620a:24ce:b0:6a7:48c:f0d5 with SMTP id
 m14-20020a05620a24ce00b006a7048cf0d5mr5886972qkn.314.1656266464061; Sun, 26
 Jun 2022 11:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220621202719.13644-1-jic23@kernel.org> <20220621202719.13644-35-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-35-jic23@kernel.org>
From:   Rishi Gupta <gupt21@gmail.com>
Date:   Sun, 26 Jun 2022 11:00:53 -0700
Message-ID: <CALUj-gsoZApB0eyP0B8Nexw94jF1xyFoUAmDMwMXdPZ-jABr8g@mail.gmail.com>
Subject: Re: [PATCH 34/36] iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS()
 and pm_ptr() macros
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 1:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using these new macros allows the compiler to remove the unused dev_pm_ops
> structure and related functions if !CONFIG_PM without the need to mark
> the functions __maybe_unused.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rishi Gupta <gupt21@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 3c937c55a10d..9a7800cdfee2 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -846,7 +846,7 @@ static int veml6030_probe(struct i2c_client *client,
>         return devm_iio_device_register(&client->dev, indio_dev);
>  }
>
> -static int __maybe_unused veml6030_runtime_suspend(struct device *dev)
> +static int veml6030_runtime_suspend(struct device *dev)
>  {
>         int ret;
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -859,7 +859,7 @@ static int __maybe_unused veml6030_runtime_suspend(struct device *dev)
>         return ret;
>  }
>
> -static int __maybe_unused veml6030_runtime_resume(struct device *dev)
> +static int veml6030_runtime_resume(struct device *dev)
>  {
>         int ret;
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -872,12 +872,8 @@ static int __maybe_unused veml6030_runtime_resume(struct device *dev)
>         return ret;
>  }
>
> -static const struct dev_pm_ops veml6030_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(veml6030_runtime_suspend,
> -                               veml6030_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
> +                                veml6030_runtime_resume, NULL);
>
>  static const struct of_device_id veml6030_of_match[] = {
>         { .compatible = "vishay,veml6030" },
> @@ -895,7 +891,7 @@ static struct i2c_driver veml6030_driver = {
>         .driver = {
>                 .name = "veml6030",
>                 .of_match_table = veml6030_of_match,
> -               .pm = &veml6030_pm_ops,
> +               .pm = pm_ptr(&veml6030_pm_ops),
>         },
>         .probe = veml6030_probe,
>         .id_table = veml6030_id,
> --
> 2.36.1
>
Reviewed-by: Rishi Gupta <gupt21@gmail.com>
