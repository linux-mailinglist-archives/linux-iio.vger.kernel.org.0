Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B139A3F4524
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 08:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHWGnS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 02:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhHWGnR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 02:43:17 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0EC061575;
        Sun, 22 Aug 2021 23:42:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so15778777pgm.12;
        Sun, 22 Aug 2021 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKOGlEDRRa7BwoMgAby+IXJz0FkUFXKVKJ7rOLV2TVE=;
        b=rw8rPViq5KjQh+U3yUSUMC5Da5200takIEqUDZiFfM89m4B0GYiGtE5W3hN2TTWuoR
         XQhV567nKsRqzl/Vvnjx6X7MhfSEYwHD4GszwpOr5cxF7ZiV4QUkwvjjMHIA1OD9Vz80
         XSII6eDFaR+xTYzbbsVJEEmMHkQ4yClhPmBYax/EpdScnO6bV46KR01qv6JQ/Ywupjzm
         3eS1CqnDV2tdPV+mPWdlfHiqHI0jM0GFFttjV0p+HZFZ2+zODbCfd4alkvb5QoCpmtBs
         2OwntOtP6PLodRua/JLCke9A1PqBGryyUuYPQIeVfPHVpjZh7zV/JjNNcqT+vrUTKlA8
         Nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKOGlEDRRa7BwoMgAby+IXJz0FkUFXKVKJ7rOLV2TVE=;
        b=dA9NCvEAZ7bAvVxXBCqfmf5INzS6Ywz/jObcdjSfr8tOpjecb0+rRMrpIcRcUo8IjC
         Z7hrwsyBbAxdS6TKy9Ng2pFufXsREz+rRleas9VuiG6Re3plErH1VrMy5yCTFkgeYrbK
         reQwznPdiJwM5L9PDHzzym1bWrlGen4mAlcMyfsiO7xWQRkqF/h/065FMln3T0i30ckC
         ohi4xJOtO2yyxjfdhfzgMd0fjPT8XfXJ14SwaZc/p08aE4IYqPDAr7NiDt28Zan/l7AD
         eW0SFI6q5/Za2dch4k9D2hxo+ubOmslEGga6uACuk4PGDDLS+QHoFhDw20zeLb2syYvN
         EgDg==
X-Gm-Message-State: AOAM533Jr8htvAe1CAL4gURkCvVLdvxoROh+qzdDFtenjjIXkbYf+wjQ
        td4qsHM2w9lqDsYGBcLJVtUeJBfMBy0dmpmuW08=
X-Google-Smtp-Source: ABdhPJzrWmY3eo63wG7m7U13uF41U2cPO7ugHzNZCGCgLZwQkX4Pm1IiIwjXM5DjK257AifV+7QXWU0pukZZnJie7d4=
X-Received: by 2002:a63:460d:: with SMTP id t13mr30555514pga.41.1629700955428;
 Sun, 22 Aug 2021 23:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <85189f1cfcf6f5f7b42d8730966f2a074b07b5f5.1629542160.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <85189f1cfcf6f5f7b42d8730966f2a074b07b5f5.1629542160.git.christophe.jaillet@wanadoo.fr>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 23 Aug 2021 09:42:23 +0300
Message-ID: <CA+U=DsoTdb3b+LJEtUagKr=LmK8E2M_2yhtNDENKsczqGaUPYA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc128s052: Fix the error handling path of 'adc128_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        angelo.compagnucci@gmail.com,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 21, 2021 at 1:43 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A successful 'regulator_enable()' call should be balanced by a
> corresponding 'regulator_disable()' call in the error handling path of the
> probe, as already done in the remove function.
>
> Update the error handling path accordingly.

Good catch.
For the fix:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

If you want, you can also send a conversion to
devm_iio_device_register() for this driver.
And also move the regulator_disable() on a devm_add_action_or_reset() callback.
Maybe, that's already part of your plan. If so, apologies for the noise :)


>
> Fixes: 913b86468674 ("iio: adc: Add TI ADC128S052")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 3143f35a6509..83c1ae07b3e9 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -171,7 +171,13 @@ static int adc128_probe(struct spi_device *spi)
>         mutex_init(&adc->lock);
>
>         ret = iio_device_register(indio_dev);
> +       if (ret)
> +               goto err_disable_regulator;
>
> +       return 0;
> +
> +err_disable_regulator:
> +       regulator_disable(adc->reg);
>         return ret;
>  }
>
> --
> 2.30.2
>
