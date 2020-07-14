Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E021F550
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGNOsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgGNOsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2020 10:48:41 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417FC061755
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2020 07:48:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f23so17547055iof.6
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2020 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GD6BIvUqA5Oi+YyOCn6l+FUN1jjJuNH169fVbfbKorw=;
        b=yUOzy5EUMjvhqbWr7ZrVYyrIXLxGpaCLUABbU4iuOkQWVkI5kWR8EW71NcPvUxuIZ1
         yv6KVrznNf3pOZ2zxgzZfhzGAq6CJ2gDZYqDqo3j9Bk0cVALNvQSwhOFsGOARQeNHT/C
         LcwQT5zZJbnUWa9mO7mr9WTKE+quzSZvGYPk/mMQFfFhsdrqjT5bB/ma4kWT94Gg9ReO
         sE+xEhAgwNxozTG28Z26XHB3HVOMJ1mAHkxWnDiZLGz6NW7+sjCdXAva8jkgw3lQIgaI
         vALLud2M7dzQTvcp2ZeCjnIQZqeYsGRZ+iBIQwan4fv/awCo21DTphl8METczjZC3O/P
         95hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GD6BIvUqA5Oi+YyOCn6l+FUN1jjJuNH169fVbfbKorw=;
        b=UW5n0rI/2YCPb2gleMpzykoWek3ItnYMM/owMUOPsxx6CPbfhc1E59aaU8RJktfwHI
         QbspA3iEWTjfLHX4K3P5QqN61X73t2p2MTSQzM8FcjUaZleTcNx71c66S7y8HjPXX7v7
         G8blZ42f3KfzimuoMsmen6LzJfcbWUCGn3REuzupFMjQNh6+7yI7Z68yCMOKyO+3qoLq
         fd79fUCiCncpdYyUZopAwVlp01G2BTFw9cUE+rUPh446G8ZYphiq/80dsT4LQ4aQnU3u
         jAbYULXZrLbXlajTaD2UvGBwdqOu4Y6S6uM8zGDEnNYNejal+/KxhliDghnwoT8m54dx
         sQ2A==
X-Gm-Message-State: AOAM532S10B2MgrN7eUsOv4QGrsUsXraJCys+hBuJq2nnoKNT+oxYRml
        MnnIgkpByO2ClXfR+fmO6ewT3/FMZq6N2SRKuhu2bg==
X-Google-Smtp-Source: ABdhPJxIy/+FbmPkRdLd+fE4QlG6dYCLWsG7ljD32Q9xSWvwS+DinNGEDchWYGgv2nA8UdXC+iuV+myzSOcs7T9TWeA=
X-Received: by 2002:a05:6602:2103:: with SMTP id x3mr5304596iox.130.1594738120270;
 Tue, 14 Jul 2020 07:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200713145934.18243-1-brgl@bgdev.pl> <20200713145934.18243-2-brgl@bgdev.pl>
 <20200713192901.GD3703480@smile.fi.intel.com>
In-Reply-To: <20200713192901.GD3703480@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 14 Jul 2020 16:48:29 +0200
Message-ID: <CAMRc=Me66Yi-zXVEOgHW3m_TtaEAz4QMQUJRjeS0WKayJBHC9w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 13, 2020 at 9:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 13, 2020 at 04:59:32PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the managed variant of krealloc(). This function works with
> > all memory allocated by devm_kmalloc() (or devres functions using it
> > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> >
> > Managed realloc'ed chunks can be manually released with devm_kfree().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../driver-api/driver-model/devres.rst        |  1 +
> >  drivers/base/devres.c                         | 67 +++++++++++++++++++
> >  include/linux/device.h                        |  2 +
> >  3 files changed, 70 insertions(+)
> >
> > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> > index eaaaafc21134f..f318a5c0033c1 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -354,6 +354,7 @@ MEM
> >    devm_kmalloc()
> >    devm_kmalloc_array()
> >    devm_kmemdup()
> > +  devm_krealloc()
> >    devm_kstrdup()
> >    devm_kvasprintf()
> >    devm_kzalloc()
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index ed615d3b9cf15..1775d35462300 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -837,6 +837,73 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> >  }
> >  EXPORT_SYMBOL_GPL(devm_kmalloc);
> >
> > +/**
> > + * devm_krealloc - Resource-managed krealloc()
> > + * @dev: Device to re-allocate memory for
> > + * @ptr: Pointer to the memory chunk to re-allocate
> > + * @new_size: New allocation size
> > + * @gfp: Allocation gfp flags
> > + *
> > + * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
> > + * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,
> > + * it's the equivalent of devm_kmalloc(). If new_size is zero, it returns
>
> 'it frees the previously allocated memory and returns'
>
> > + * ZERO_SIZE_PTR. This function doesn't change the order in which the release
> > + * callback for the re-alloc'ed devres will be called (except when falling back
> > + * to devm_kmalloc()
>
> 'or when freeing resources when new_size is zero'
>

This is nit-picking but ok. :)

[snip!]

> > +++ b/include/linux/device.h
> > @@ -206,6 +206,8 @@ int devres_release_group(struct device *dev, void *id);
> >
> >  /* managed devm_k.alloc/kfree for device drivers */
> >  void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
>
> > +void *devm_krealloc(struct device *dev, void *ptr, size_t size,
> > +                 gfp_t gfp) __must_check;
>
> Strange indentation, also you can move __must_check to the beginning of the
> declaration.
>

There's nothing wrong with this indentation, what do you mean?
__must_check is usually put at the end of the line.

[snip!]

Bart
