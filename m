Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685957D260F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVVLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 17:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVVLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 17:11:04 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF33297
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 14:11:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so40218541fa.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698009060; x=1698613860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auQpGaECjTCs+PFuyDE8IKn2Q0sSCjMRbWmc04At4Ck=;
        b=bAs8pPlthd9zrUQONA3hLrAMznCim45qBflHoRK9411dTshezxkV4jymipvNxBV/Ae
         jMJmWcEpZVG4yHL7UlytMb2igNA7XUGMglrF5SUIEdYmY5qMuOVEFt4sILcZUKSvv/op
         nxXUUO0UUgPmj8GlE6AvxxM4daPuwRwzrIcvwm8nwajJKjJkD4ODMFHJnKxALW5sG/SH
         6s/ct3blR7NYqNoV7m8XPDqA7rs63Ceg4+6XahfskXUg4MsNcx04LUMB18czoeYZQg4B
         Am7dsJ3/RDVBQH4xz4DzhzaLrDGSQ7AkwKm4drrdNP2Kt/aVdbu23XhmyjvISi/uWemB
         q08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698009060; x=1698613860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auQpGaECjTCs+PFuyDE8IKn2Q0sSCjMRbWmc04At4Ck=;
        b=As3FJCZVlKCKIS5dw7HJ7z+NnG3yXj9xEd4AHvBukSs698H87YPCT5f4COtOy/FqaS
         M/SJKd2Kx6AfuuXR47637kxH7Fw4Uc6Qo8LNWtrzvc8QGhLkpvuL2dOaxmgn8NQhnJZy
         /+o0txWGGCYzt4xsY6bzprtIrjtMHf602jvC0/7SULo9pHGC2AwWP+PysszcfghMZjCL
         L6ESc4BmKGcKQN8zUDwpKpxdZmc4o7P+XVwGcJ7hW7v5NHyAfQO5HzPVT85rbQnVn40P
         7ISvy0pAG+eqBuQXHVhrBpcJu02uwz3daU8Gcj4lo6IZo5Xh5e8Hmpz47MkZRK5Ci0CS
         dlVg==
X-Gm-Message-State: AOJu0YylF32mzztqlaV4dgU+usA0pz5zEEMisBliMYMcD/eV1lFZLChE
        q6qoUOZqZuVCV3HZJRpUW+THBz7ZB9jYDPKM7WH65g==
X-Google-Smtp-Source: AGHT+IEsQWsOIWJCc5YEaFEZ3EIR7+fpbJoniyuDA083CwEduaYPSal7tJoMq5a2BagWvAGflgNU87ek7Re4ToqCwVc=
X-Received: by 2002:a05:651c:2328:b0:2c5:1e70:7d30 with SMTP id
 bi40-20020a05651c232800b002c51e707d30mr4931578ljb.30.1698009059516; Sun, 22
 Oct 2023 14:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231022154710.402590-1-jic23@kernel.org> <20231022154710.402590-2-jic23@kernel.org>
In-Reply-To: <20231022154710.402590-2-jic23@kernel.org>
From:   David Lechner <dlechner@baylibre.com>
Date:   Sun, 22 Oct 2023 16:10:48 -0500
Message-ID: <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 22, 2023 at 10:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Allows use of:
>
>         CLASS(iio_claim_direct, claimed_dev)(indio_dev);
>         if (IS_ERR(claimed_dev))
>                 return PTR_ERR(claimed_dev);
>
>         st =3D iio_priv(claimed_dev);
>
> to automatically call iio_device_release_direct_mode() based on scope.
> Typically seen in combination with local device specific locks which
> are already have automated cleanup options via guard(mutex)(&st->lock)
> and scoped_guard().  Using both together allows most error handling to
> be automated.
>
> Note that whilst this pattern results in a struct iio_dev *claimed_dev
> that can be used, it is not necessary to do so as long as that pointer
> has been checked for errors as in the example.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c |  4 ++++
>  include/linux/iio/iio.h         | 25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index c77745b594bd..93bfad105eb5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
>   */
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev)
>  {
> +       /* Auto cleanup can result in this being called with an ERR_PTR *=
/
> +       if (IS_ERR(indio_dev))
> +               return;
> +
>         mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
>  }
>  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d0ce3b71106a..11c42170fda1 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/slab.h>
>  #include <linux/iio/types.h>
>  /* IIO TODO LIST */
> @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *dev, s=
truct iio_dev *indio_dev,
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp=
);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> +/*
> + * Auto cleanup version of iio_device_claim_direct_mode,
> + *
> + *     CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> + *     if (IS_ERR(claimed_dev))
> + *             return PTR_ERR(claimed_dev);
> + *
> + *     st =3D iio_priv(claimed_dev);
> + *     ....
> + */
> +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> +            iio_device_release_direct_mode(_T),
> +            ({
> +                       struct iio_dev *dev;
> +                       int d =3D iio_device_claim_direct_mode(_T);
> +
> +                       if (d < 0)
> +                               dev =3D ERR_PTR(d);
> +                       else
> +                               dev =3D _T;
> +                       dev;
> +            }),
> +            struct iio_dev *_T);
> +
>  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
>  void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
>
> --
> 2.42.0
>

What is the benefit of exposing `claimed_dev` rather than just the int
return value? It seems like it just makes more noise in the error
check.

Also, this seems like this is a pattern that could be generalized and
put in cleanup.h. For example, this pattern could be used with
mutex_trylock as well.

Basically we could create a variation of the current `guard` like:

#define DEFINE_CHECKED_GUARD(_name, _type, _lock, _unlock) ...
#define checked_guard(_name) ...

To be used like:

/* linux/mutex.h */
#define DEFINE_CHECKED_GUARD(mutex, struct mutex *, \
    mutex_trylock(_T), mutex_unlock(_T))

/* any/driver.c */
if (!checked_guard(mutex)(&thing->lock))
    return -EBUSY

/* linux/iio/iio.h */
#define DEFINE_CHECKED_GUARD(iio_claim_direct, struct iio_dev *indio_dev *,=
 \
    iio_device_claim_direct_mode(_T), iio_device_release_direct_mode(_T))

/* iio/driver.c */
if (!checked_guard(iio_claim_direct)(indio_dev))
    return -EBUSY
