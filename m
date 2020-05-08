Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582341CB702
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgEHSVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727086AbgEHSVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 14:21:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792DC061A0C
        for <linux-iio@vger.kernel.org>; Fri,  8 May 2020 11:21:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b8so1217734pgi.11
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2020 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtptXvN0u1ghf1Y0NDnybYTwzJTfjGhpiEoFrpWGk6w=;
        b=XvYm4YU9Sm3v2rTT+Axc8daF7cedOutMbVgSyaMnd0oPTDfXNUp2Gc0UaMdIUc+vig
         KdOhac9UzJ3xFpIpGpVr9XDflSzo5cA1E6jVvoqcaAYRU3/wskHtoonq/Gk7hZx/qKBR
         PKU7DjbdQO/Ztj8KK1KZnkBElIumg6jpHubhsZ5pmDy0clOR6mJgs/YNVN9n5pgvBR8k
         /SZkQ/aRbGjjCRYuACohkPnp3hc6hpunNcXsHyg5/P+9Nqbp5x/1/e8NQwK0yGsoSkGL
         tvMXskWpPL4rTHPeSlY/60qFg0BUppA30OC/a/twTqsJzjOXXMjxVcogZY7G5S5GP19J
         R4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtptXvN0u1ghf1Y0NDnybYTwzJTfjGhpiEoFrpWGk6w=;
        b=st5Nw9JJtY2fUM4nhifgEJ36SMSuqmjcms65PoehAgWXzZzEoMTktIIdbuSQLnXy58
         UHtaHbsex7SWZsVudwBE0biKtGtCBfPq5d+bDqp5g7luVzzKzLjWCycc926Qf3nQ9Hsf
         2ijtYqSKK9eJk2FXsZfR5laPvs+JHPk+edN6jdnBfXROWz8LkcXkf2kZmh6jnTeS9IfB
         Ctui+YtZfzAdnNd1tvAnAoEoziBk7wCAa0JltxQKMaAT6Pk7gDCGFvae9d1R7ngGwK0j
         FKLl5wU6RZQKWEWAl4SQKL51MnlJ4nN/0920mltnK05SEwNd5ZxcvNltoKu2a68t2OVS
         ZEBQ==
X-Gm-Message-State: AGi0PuZ2rz66suSP80nuL8iLVkLZu2D/0NTTssHAklXK/VtMrzqseU+k
        djHXgBSp4Eog2gerWrqVRWO5d22ZeZaKwi8s3TmVng==
X-Google-Smtp-Source: APiQypLolAFh6mJKDfk2vX4BRKEcp2v8bPlHuZTy7nAJx6FF6ghMR0UeONzLV/qeVHYs4jgLZm3KgGj90AjOkaT4OX0=
X-Received: by 2002:a62:146:: with SMTP id 67mr4260150pfb.169.1588962067915;
 Fri, 08 May 2020 11:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142408.1113763-1-arnd@arndb.de>
In-Reply-To: <20200505142408.1113763-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 May 2020 11:20:56 -0700
Message-ID: <CAKwvOdmQ8pzxGdNEJ=eG+rRFK1J4Xg6738dYvdZSqf0u0gtscw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7476: fix clang -Wpointer-bool-conversion warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 5, 2020 at 7:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Checking the pointer value of st->chip_info->convst_channel is pointless
> since this this an array inside of a struct: even if st->chip_info is NULL,
> the pointer is non-zero. Clang warns about this:
>
> drivers/iio/adc/ad7476.c:312:40: warning: address of array 'st->chip_info->convst_channel' will always evaluate to 'true' [-Wpointer-bool-conversion]
>         if (st->convst_gpio && st->chip_info->convst_channel)
>                             ~~ ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
>
> I could not come up with a sane way to check whether the entry
> is valid, so just remove the check and keep the behavior as it
> is today but without the warning.

Me too. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 3a6af93dd66e ("iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/ad7476.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index e9984a38fc4c..4e816d714ad2 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -309,7 +309,7 @@ static int ad7476_probe(struct spi_device *spi)
>         indio_dev->num_channels = 2;
>         indio_dev->info = &ad7476_info;
>
> -       if (st->convst_gpio && st->chip_info->convst_channel)
> +       if (st->convst_gpio)
>                 indio_dev->channels = st->chip_info->convst_channel;
>         /* Setup default message */
>
> --
> 2.26.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200505142408.1113763-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
