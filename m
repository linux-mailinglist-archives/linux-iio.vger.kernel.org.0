Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2583708C8
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEAT1V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhEAT1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:27:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A591C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:26:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i13so1386647pfu.2
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNc/5Swh63SAsy9M9nR6vsAJ2tG/bysgeVt8V73MsLo=;
        b=SVoscpRtgj1hmr6Lyg0l5Rxrhp877SgbYwFPkz3zQ8YyzjngLDjbVwLK6ErpaiZIlw
         om3MhJcnAMNupWpEA7Wo7WI4fz8MWghGd6T29+XLrOo0kOsUAhFFxZidQ1e6xjDJY/pC
         QpfqaRkwJAT6NKhF/cpo7NsdMxKjgL/akZHD1ZQOqXxY1rdtDZWA4cLhi6TpDsWJ+E9d
         KzxYcHXz+pvN1FyqnSjYrnT8u8KJP1a/aLbmWeS8QMBrY48Js5HoI4hQlK1hCkC0npdZ
         STQXOhDFiL84ONzADzHCmLHhokK1I7HqF2QCHeS+/8iM8QVbkyZ3+s55uTTBQumHIovR
         JJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNc/5Swh63SAsy9M9nR6vsAJ2tG/bysgeVt8V73MsLo=;
        b=jqJeIMCJVd/AYOniEnSigZ+uoMvammLPOqHDgPHlOnASrNjp1o7po6+lfzRh5Keu+Q
         VwddwljptFelUH/R475WmFHcpDCvfssgWeHA2KvE36Vo6tJdNqC9hYU7w3V6m4kO6Xas
         77qQnZJNFjA8qZxpd4hOGH0U0mI4UJx9+5vadp2mRnBvGRhSlK83Yp02RdmZPf2mZCqn
         +J2Zd6upQh3Ogd/eti/3SqXaGpYgMyfx6lzC9mywcG/kTtHAyLTTQxJjTZEH/7ROIHJq
         m1p9UguZS971pq506+rnu9oEHGRo1wYHRXojNFNNUIWzM7fKvGboMtx4o1iOmA1QOMil
         qEqw==
X-Gm-Message-State: AOAM5310YjxGJDdDrZ17m10VQhitawWk6Bi0bbggR0Rmn758Ub2yHGlG
        BGuhyiUgUNryG+Etvo2FcluXpvY7rKeY7xQgimk=
X-Google-Smtp-Source: ABdhPJwCM7Cq7XmzIRH2uAeKvw1xF+ukEgXpuf3ps0yi8IpxV26OuxfWzEaMs3FLtAYnL7hzIxEfcCGlin5j3QKugaQ=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr10407597pgg.74.1619897173025;
 Sat, 01 May 2021 12:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210501172515.513486-1-jic23@kernel.org> <20210501172515.513486-2-jic23@kernel.org>
In-Reply-To: <20210501172515.513486-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:25:55 +0300
Message-ID: <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce iio_push_to_buffers_with_ts_na()
 for non aligned case.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst it is almost always possible to arrange for scan data to be
> read directly into a buffer that is suitable for passing to
> iio_push_to_buffers_with_timestamp(), there are a few places where
> leading data needs to be skipped over.
>
> For these cases introduce a function that will allocate an appropriate
> sized and aligned bounce buffer (if not already allocated) and copy
> the unaligned data into that before calling
> iio_push_to_buffers_with_timestamp() on the bounce buffer.
> We tie the lifespace of this buffer to that of the iio_dev.dev
> which should ensure no memory leaks occur.

...

> +/**
> + * iio_push_to_buffers_with_ts_na() - push to registered buffer,
> + *    no alignment or space requirements.
> + * @indio_dev:         iio_dev structure for device.
> + * @data:              channel data excluding the timestamp.
> + * @data_sz:           size of data.
> + * @timestamp:         timestamp for the sample data.
> + *
> + * This special variant of iio_push_to_buffers_with_timetamp() does
> + * not require space for the timestamp, or 8 byte alignment of data.
> + * It does however require an allocation on first call and additional
> + * coppies on all calls, so should be avoided if possible

copies

> + */

I do not like the _na part in the name (My first impression was with a
Timestamp that was not available, what?!). Can we spell it better?

> +int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
> +                                  const void *data,
> +                                  size_t data_sz,
> +                                  int64_t timestamp)
> +{
> +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +       data_sz = min_t(size_t, indio_dev->scan_bytes, data_sz);
> +       if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {

> +               iio_dev_opaque->bounce_buffer =
> +                       devm_krealloc(&indio_dev->dev,
> +                                     iio_dev_opaque->bounce_buffer,

Oh la la, foo = realloc(foo, ...) is 101 type of mistakes.
Please, don't do this.

> +                                     indio_dev->scan_bytes, GFP_KERNEL);
> +               if (!iio_dev_opaque)
> +                       return -ENOMEM;
> +       }
> +       memcpy(iio_dev_opaque->bounce_buffer, data, data_sz);
> +       return iio_push_to_buffers_with_timestamp(indio_dev,
> +                                                 iio_dev_opaque->bounce_buffer,
> +                                                 timestamp);
> +}

-- 
With Best Regards,
Andy Shevchenko
