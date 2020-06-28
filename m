Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238B020CA03
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgF1TvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgF1TvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jun 2020 15:51:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4CC03E979
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 12:51:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w9so12693448ilk.13
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2020 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTaTNMgDBTKEJkKYK3hXvkEj0XOWe29+rMTikboLhDw=;
        b=BYDvY0clRoKRVPu3q5fwDIu2KBc8NeuX5aEgBOEdTd+7PslABMALrnLnRXphFlqbNG
         mFfdxk95Yvl3nd6/5Glr+c2jGM0unakzQYg2r33Z8GZUi81wO5k2MsjwvtHCHn0DubPy
         4sXRqfABOL/BWti31mJn4IJwRCoVRGX4um0pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTaTNMgDBTKEJkKYK3hXvkEj0XOWe29+rMTikboLhDw=;
        b=h0OGAELk9DZqCGDkA+vkj11roe3Ga+43KtbLzQ9i5SCr/7dHP6Zt6I+NGu9VIKbwh4
         RLpzrebmrQzdQDA4TxwS5qkLXy4+oF0jiKvotRdf57PIfOpmn7oXAeZLpWWEzLSDeWUK
         q43cj5Zl5FB7HZA68gN1JsErx3+EhgSkOSBsbBRD+4+71hKcIlDrmbcCmDDgg24496Hc
         mMhtKwgVF4m1JEH/Mu8nd6quyWHRG1FFcZqOWsH18GNYbj2WpT+scBa4dH+KANzguASZ
         gFkAWyMQqlgMuYQdfcFgvTt0ga4zs3T/niVzrzTw9I8mAylJMf8cZdyuwbfZXkQaEYo7
         81gg==
X-Gm-Message-State: AOAM5326lCSO8ZdCaBSjRWRNYK7mJTxAYdl9B/xC/T9SWD8uugvO5jXf
        UdmqIPfXj+BZGGrRjr0cRvwNOK9ftAUG0MVRfFJ0GQ==
X-Google-Smtp-Source: ABdhPJzD17+QdPehbBqYDZThHafD+lT1YwLUkwCYEuuKQ2d3M6k3i0RIYNBLFP4PofIScoeQ7kTaZlkixjjvupSrB9o=
X-Received: by 2002:a05:6e02:4c6:: with SMTP id f6mr2085940ils.98.1593373880193;
 Sun, 28 Jun 2020 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-21-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-21-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 28 Jun 2020 12:51:09 -0700
Message-ID: <CAJCx=gmZcc=GPteUhcG6uC+Ezp5BkE5f=H-YGF=L+e9nwauQrA@mail.gmail.com>
Subject: Re: [PATCH 20/23] iio:adc:ti-adc161s626: Drop of_match_ptr protection.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 5:39 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Dropping this allows use of ACPI PRP0001.
>
> I'm also looking to drop all of_match_ptr use in IIO in order to avoid
> it getting cut and paste into new drivers in the future.
>
> Also add a direct include of mod_devicetable.h to reflect the use
> of struct of_device_id.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/adc/ti-adc161s626.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index f27ca3161530..607791ffe7f0 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
> @@ -257,7 +258,7 @@ MODULE_DEVICE_TABLE(spi, ti_adc_id);
>  static struct spi_driver ti_adc_driver = {
>         .driver = {
>                 .name   = TI_ADC_DRV_NAME,
> -               .of_match_table = of_match_ptr(ti_adc_dt_ids),
> +               .of_match_table = ti_adc_dt_ids,
>         },
>         .probe          = ti_adc_probe,
>         .remove         = ti_adc_remove,
> --
> 2.27.0
>
