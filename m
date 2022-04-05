Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22B4F4C6B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiDEXTy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Apr 2022 19:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573211AbiDESVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2022 14:21:22 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D92558F;
        Tue,  5 Apr 2022 11:19:23 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2eb43ad7909so1134637b3.2;
        Tue, 05 Apr 2022 11:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wp5BQRPZX31Tau7Z/BAzOvMpyk9uV0bPZM8M4VsBras=;
        b=gE0BaAvZ9okEO2GPTdjhpnnNT3Sz+VQw7q3NppHwMa0HdA6WbutUKUDRKSdsrUZoHK
         tg7bznR2ssbZgEl9skhQTnFHTyWdcCNBL4VAx5zE59AmNpSo99Hk+5ztBpOaWFoi6r/O
         n12ko5TTY8PhyIuCC+aWvdCEx1lf+wf5+XyZf5lby6F7F/fbPb7Ub/kQR/7LYlHZ8aOr
         EAEKQ3YeI9qtPalaINQYLOfo5XWtPFSw+66fOwD6WLp6Yz2QnttgQvKOW7bkII6TBpJs
         vz+AmptSE7Vm+SiuKTy11bV0FfLajEODRmzW0NJypL5Gke9tpSOCNktJIZNaiOxLi//b
         2qww==
X-Gm-Message-State: AOAM531OK7vT+NwPwVAa0oKRi7ZmbZTz5yxtubxWwM7J/pB/aIAzCXUa
        1IpW3mf9tQND99Tl4SfA+LLNPw7CwhMJIjpEzQvbslYc
X-Google-Smtp-Source: ABdhPJxgCOYicaGfabBQSX1TtzVkx4wjUpVl5764g8J8U/cZkdTPkmlBdt3znmSbx1ACV5tSfliK7lhe83x3Kk2vnAs=
X-Received: by 2002:a81:bc5:0:b0:2e6:dcfe:bfcb with SMTP id
 188-20020a810bc5000000b002e6dcfebfcbmr3974299ywl.19.1649182762847; Tue, 05
 Apr 2022 11:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220401140605.31871-1-Jonathan.Cameron@huawei.com> <20220401140605.31871-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220401140605.31871-2-Jonathan.Cameron@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 20:19:11 +0200
Message-ID: <CAJZ5v0gUECCmFJoVnmR8SK-pBg5v4QrtLgeKT7VTmgdykuZAzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: chemical: scd30: Export dev_pm_ops instead of
 suspend() and resume()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 1, 2022 at 4:06 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Whilst here move to the new infrastructure using pm_sleep_ptr()
> and EXPORT_DEV_PM_OPS() so as to let the compiler remove the unused
> code if CONFIG_SLEEP is not defined.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  drivers/iio/chemical/scd30.h        | 5 +----
>  drivers/iio/chemical/scd30_core.c   | 8 ++++----
>  drivers/iio/chemical/scd30_i2c.c    | 2 +-
>  drivers/iio/chemical/scd30_serial.c | 2 +-
>  4 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
> index f60127bfe0f4..1ac9f3f79271 100644
> --- a/drivers/iio/chemical/scd30.h
> +++ b/drivers/iio/chemical/scd30.h
> @@ -68,10 +68,7 @@ struct scd30_state {
>         scd30_command_t command;
>  };
>
> -int scd30_suspend(struct device *dev);
> -int scd30_resume(struct device *dev);
> -
> -static __maybe_unused SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
> +extern const struct dev_pm_ops scd30_pm_ops;
>
>  int scd30_probe(struct device *dev, int irq, const char *name, void *priv, scd30_command_t command);
>
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index 9fe6bbe9ee04..6c6c11c2772a 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -517,7 +517,7 @@ static const struct iio_chan_spec scd30_channels[] = {
>         IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>
> -int __maybe_unused scd30_suspend(struct device *dev)
> +static int scd30_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct scd30_state *state  = iio_priv(indio_dev);
> @@ -529,9 +529,8 @@ int __maybe_unused scd30_suspend(struct device *dev)
>
>         return regulator_disable(state->vdd);
>  }
> -EXPORT_SYMBOL(scd30_suspend);
>
> -int __maybe_unused scd30_resume(struct device *dev)
> +static int scd30_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct scd30_state *state = iio_priv(indio_dev);
> @@ -543,7 +542,8 @@ int __maybe_unused scd30_resume(struct device *dev)
>
>         return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
>  }
> -EXPORT_SYMBOL(scd30_resume);
> +
> +EXPORT_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
>
>  static void scd30_stop_meas(void *data)
>  {
> diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
> index 875892a070ee..7c332e4e8e46 100644
> --- a/drivers/iio/chemical/scd30_i2c.c
> +++ b/drivers/iio/chemical/scd30_i2c.c
> @@ -128,7 +128,7 @@ static struct i2c_driver scd30_i2c_driver = {
>         .driver = {
>                 .name = KBUILD_MODNAME,
>                 .of_match_table = scd30_i2c_of_match,
> -               .pm = &scd30_pm_ops,
> +               .pm = pm_sleep_ptr(&scd30_pm_ops),
>         },
>         .probe_new = scd30_i2c_probe,
>  };
> diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
> index 568b34486c44..8664f3ce6b33 100644
> --- a/drivers/iio/chemical/scd30_serial.c
> +++ b/drivers/iio/chemical/scd30_serial.c
> @@ -252,7 +252,7 @@ static struct serdev_device_driver scd30_serdev_driver = {
>         .driver = {
>                 .name = KBUILD_MODNAME,
>                 .of_match_table = scd30_serdev_of_match,
> -               .pm = &scd30_pm_ops,
> +               .pm = pm_sleep_ptr(&scd30_pm_ops),
>         },
>         .probe = scd30_serdev_probe,
>  };
> --

Applied as 5.19 material along with the [2-3/3].

Please let me know if you need a non-mutable branch to pull from in
order to base other work on these commits.

Thanks!
