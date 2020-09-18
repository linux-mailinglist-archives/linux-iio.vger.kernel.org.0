Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990A26FE5A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRNZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRNZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 09:25:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3422C06174A
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 06:25:16 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x14so6964809oic.9
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64J5foHlAJpGUsri0JLWOY5pwjgFNaO7emBgA5tpxVg=;
        b=MCuMTT/GgnqS7pmi3W7euUm6OeL0/Q9TVfpwSW/+XhkVkRcgaTC+w2O7l5HwqHpExl
         Qn7fLJKucuBMWzzk8geH72xU4ZdIflWxi979r+HB6cexH/NVqBYenU7+DqNptWUzYuaq
         u055PeUNWtXa25EgTW1nMfIIGRSc+F/xRREUYC1hozaIeBhQ/eu4rkv96UTF/r5PKRWB
         bmqesewMRaV7m8iZ8RrDNXSBSQr4BB/GHPN2sHTHQAVhCk1BRUK1IF3Q+b96b7lhtAeG
         24Zrh04X0QUK5+u/dFHggpU6/WAJOO/xFuyddN6JJfi2BxJy8VaIRsa8GTruqJD97H1U
         i03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64J5foHlAJpGUsri0JLWOY5pwjgFNaO7emBgA5tpxVg=;
        b=ojdP8guuaL6/GA6XPqs+phafhNpYI1ds9DIBTnCoIM8LtmvEsngiB9kt98HbmgZXn2
         boV87HGS9+F6CnCTbaKSNI8vM3bFHhKwa3P3E0/q9exj00i+eNOaGxACC/kPc6O70TnO
         pfH5SxQjpFN9+9HtyUG9ULPpdACIRDnxIJ2XUVrhvvcJ5b6JTF+olPxJg/6CGO2I8LAS
         mKQdWIaWH2+diV9LL+iqj+1GNs7CZvbE+bhbBZF4akAE/HsawqBbEaQyC99nk1W94qeV
         zIKihkOMFEF/TuD5jzCOlqfe6jiU/jO8UrTbudIXmc8zBXM0nSxuqhMxuobGwQpMaH+e
         slhQ==
X-Gm-Message-State: AOAM531XTbWDHJPM4nf4uEFkVt6xpBXtdQiAre//679+YB2VjsOc3xlg
        57FiIit7nFL1ZBBw31PB3oAKeomHtGwYAaAGshw=
X-Google-Smtp-Source: ABdhPJxw2wEEKocJCWBnQSktpP14pZ7JYbEwl9AabnxdnOY+qlJgBGHcqS/0AuDCZrJrbpflYdp1VVzrqtaJ91hLudo=
X-Received: by 2002:aca:ea44:: with SMTP id i65mr8130712oih.117.1600435516326;
 Fri, 18 Sep 2020 06:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200913132115.800131-1-jic23@kernel.org> <20200913132115.800131-3-jic23@kernel.org>
In-Reply-To: <20200913132115.800131-3-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 18 Sep 2020 16:25:05 +0300
Message-ID: <CA+U=DspU3pyM54KgTweoQWAqO0zbJno4pTxaBdzhg0Pz-Bda4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: Add __printf() attributes to various allocation functions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A partial set of these was added to IIO a long time back.
> This fills in some gaps in coverage highlighted by building
> with W=1
>

Stylistically, it looks like plenty of these attributes are specified
on a separate line before the function definition.
Example:

__printf(1, 0)
static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)

It doesn't make much difference to me how it's placed.

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-trigger.c   | 2 +-
>  include/linux/iio/iio.h              | 4 ++--
>  include/linux/iio/trigger_consumer.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 6f16357fd732..adfe023cad48 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -516,7 +516,7 @@ static void iio_trig_subirqunmask(struct irq_data *d)
>         trig->subirqs[d->irq - trig->subirq_base].enabled = true;
>  }
>
> -static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> +__printf(1, 0) static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
>  {
>         struct iio_trigger *trig;
>         int i;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index e2df67a3b9ab..a02a3efad794 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -691,8 +691,8 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
>
>  void iio_device_free(struct iio_dev *indio_dev);
>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
> -struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> -                                               const char *fmt, ...);
> +__printf(2, 3) struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> +                                                         const char *fmt, ...);
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
>   * @indio_dev:         IIO device structure for device
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 3aa2f132dd67..2c05dfad88d7 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -38,7 +38,7 @@ struct iio_poll_func {
>  };
>
>
> -struct iio_poll_func
> +__printf(5, 6) struct iio_poll_func
>  *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
>                     irqreturn_t (*thread)(int irq, void *p),
>                     int type,
> --
> 2.28.0
>
