Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05103526F7
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhDBHe4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 03:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhDBHey (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 03:34:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E0C0613E6;
        Fri,  2 Apr 2021 00:34:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z136so4580938iof.10;
        Fri, 02 Apr 2021 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8YiWEgAWNK+PWFAwlRLwclHpIGKDlHTAlTUSmH/65s=;
        b=jFUe8fj/rlXjI53aUF/H7YFiHByWQ4hDH19JCq4435UfFGgeAj9AUTeSGK+svJ0RbH
         ouvKNhYESpEQcNmF/f8a6it7JO+IYvF0h25WjxQUibN12shEBIq8jmGshVWPW4Wwhuv6
         GRM1waAT5nWoOhEnAZhrHYfJWxYBpC1FfhkfzaQ/0KhabL689p/gLsy2vZN+Tr5EseMg
         8iWCvo/uD3oa/TBL2LONUyd8febqLoptvKPUDi89m9/+vC/LjW/4ibAIRMZkUtBdI7V0
         UTxrOr6cNio2+ye0bbhAVOPNqczxXxASLoEeqlbLTSRMlbMiYUryty4PJBZU0DTLHYPm
         WIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8YiWEgAWNK+PWFAwlRLwclHpIGKDlHTAlTUSmH/65s=;
        b=C7xZ7ehIGE/F1JjkYp6EfleN8zRGX4LNneA/6trB+8WHLGApALbrQcYOx/Tify+xMR
         SSWXCtLhid512M1N0tZw9NVfEbw+nLlOj73TSSqH9g/Uu1YW8L5zC9hIfLgCPAP6zuRw
         Y/g/VRZElfPzmBIERZgn4MsRZlDbB1JQ0S2azu6IcBwBPZaCTBg7xsYryGH+E4TaVAti
         bVP9ptO06gJRwatuou5WHcubYhnjP03YtY8QW0rOiilEdS2PxP5YBdlsmzT2SoKbHz7c
         RDrKwHLCvz9zDsqwiOG9A3dLpqY2wKFmc+n/oZUEtjEdP+WOcNSXmdXJ5LITwJszQPJz
         0OIA==
X-Gm-Message-State: AOAM532OLnG1QfuhrDTUBaQrUuv1qA0TA1CKWaTYoBi0nknxUj0xpYm7
        WWEaQDao/Rxyjl0uvhW1eHLQK2gHvDgFudVevYg=
X-Google-Smtp-Source: ABdhPJydMTWYDIZREgnTQx666V8nT2/KJLSYAkt+IR7zQKVsyhiAi4hsU4Dy1m0Xg401RwfZHKWoOLbX20rc26JQwNY=
X-Received: by 2002:a05:6638:3791:: with SMTP id w17mr11482434jal.91.1617348893555;
 Fri, 02 Apr 2021 00:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210401171759.318140-1-jic23@kernel.org> <20210401171759.318140-2-jic23@kernel.org>
In-Reply-To: <20210401171759.318140-2-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 2 Apr 2021 10:34:42 +0300
Message-ID: <CA+U=DspFppB_cnufH6VLULKCaVQ796GsNykt90OJPPj_ThcyvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio:adc:ad7476: Fix remove handling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 1, 2021 at 8:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This driver was in an odd half way state between devm based cleanup
> and manual cleanup (most of which was missing).
> I would guess something went wrong with a rebase or similar.
> Anyhow, this basially finishes the job as a precusor to improving

2 typos in this commit description

> the regulator handling.
>

I was pretty surprised about this patch [before reading through it].
Anyhow:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 4bb2b8f94ace3 ("iio: adc: ad7476: implement devm_add_action_or_reset")
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/iio/adc/ad7476.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 17402714b387..9e9ff07cf972 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -321,25 +321,15 @@ static int ad7476_probe(struct spi_device *spi)
>         spi_message_init(&st->msg);
>         spi_message_add_tail(&st->xfer, &st->msg);
>
> -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -                       &ad7476_trigger_handler, NULL);
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +                                             &ad7476_trigger_handler, NULL);
>         if (ret)
> -               goto error_disable_reg;
> +               return ret;
>
>         if (st->chip_info->reset)
>                 st->chip_info->reset(st);
>
> -       ret = iio_device_register(indio_dev);
> -       if (ret)
> -               goto error_ring_unregister;
> -       return 0;
> -
> -error_ring_unregister:
> -       iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_reg:
> -       regulator_disable(st->reg);
> -
> -       return ret;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct spi_device_id ad7476_id[] = {
> --
> 2.31.1
>
