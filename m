Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9251F33853C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 06:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhCLF2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 00:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhCLF1k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Mar 2021 00:27:40 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA49C061574;
        Thu, 11 Mar 2021 21:27:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b5so1493165ilq.10;
        Thu, 11 Mar 2021 21:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cedzXH2mwsyrkSO9r0tC4BCdclkRwN6ijBwzgFvGgU0=;
        b=TBJd7C/NApDyC+0/5wKLyKr+fzrC1bBtWFxlApGpVyZYTAMf7pMBGY8VGT5i+/J/0F
         UMCA16UtCB0WQK3L/IsMP0EAFn6zxNPGkQnIYDCljBIdnLgPbUSHRJhI9vt3NXmpbbc3
         V4pQiFiINrAbHbvATj2zBbezRRPDl/+kJOglBy4/cSNRnIqv64w2zVclA5keFs/39eLG
         zKRl7UdUJ+fTHc8bFAHhjTJswQxlhYD6giVjVgDBs9dluN0WOLhScK/ewf009dIZUPEE
         Bg9fEPPZo/KAOiCkcDJx21B5dM1wF3CqnWo/FhMB6fbqa3gJ4Dtr5737Z9xjEd/32mkY
         dR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cedzXH2mwsyrkSO9r0tC4BCdclkRwN6ijBwzgFvGgU0=;
        b=NTLaEi3ZBJSvUW2zstccAQd0wCc0umCs7G9++9L6IW7LKhaZMrupxvzHaa0zJOkvQz
         6MtfHWQTADEnFCIInGnNeZP+C+77snxsCjz6TqwbdbtZBHywDy9yaX6S3iYsy2KrqO5H
         vcvYAooaUoNjv/86/AVm2X7xN/DqtcrP9OrG8lHHQfni/n0u0xb/N9vwpGHRqfCfe6tD
         GZz4eUjm4EQt/tlqfsi14cSN+bGIitg4BfOknEzsuuACJHmkAypKV9kl9DMTeIB8e8X/
         DColPBb0cerVtEa2nRO5ufJ/lyySzEqaU9uNxfhNNZaQScP0eLWbxq7Uh/HoNSB2bS8Y
         qCjw==
X-Gm-Message-State: AOAM5313WMxvCQTwbJFQIB7ODnLtHcrXRJQjL3Xep3V3mN+XHwBrBdTo
        XFjDEhlUnFEUcWf1D+OPAKcztirUYDRiYDmxazw=
X-Google-Smtp-Source: ABdhPJxvReihQMelM2NYf37nhXSdBLG+zRTVh/SPSvsdhuYaeeoY+unUsG3pMcj+CVJC87cQ/uE4oYbyqA3v1Ouzibc=
X-Received: by 2002:a92:3652:: with SMTP id d18mr1627864ilf.100.1615526859345;
 Thu, 11 Mar 2021 21:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20210311091042.22417-1-aardelean@deviqon.com>
In-Reply-To: <20210311091042.22417-1-aardelean@deviqon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 12 Mar 2021 07:27:28 +0200
Message-ID: <CA+U=DsqL3BS0QFsV01caxFjsUmeSsfrbuo1ezKtfBhAncCBoMA@mail.gmail.com>
Subject: Re: [PATCH] iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@deviqon.com,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 11, 2021 at 11:14 AM Alexandru Ardelean
<aardelean@deviqon.com> wrote:
>
> This is similar to the {devm_}iio_triggered_buffer_setup_ext variants added
> via commit 5164c7889857 ("iio: triggered-buffer: add
> {devm_}iio_triggered_buffer_setup_ext variants").
>
> These can be used to pass extra buffer attributes to the buffer object.
> This is a bit of temporary mechanism (hopefully) so that drivers that want
> to allocate a kfifo buffer with extra buffer attributes, don't need to
> include 'buffer_impl.h' directly. This can also become an API function (in
> it's own right, unfortunately), but it may be a little less bad vs drivers
> having to include 'buffer_impl.h'.
>
> So, far the drivers that want to pass buffer attributes, all have to do
> with some HW FIFO attributes, so there may be a chance of unifying them
> into IIO core somehow (as some standard API). But, until that happens, we
> just need to let them register their HW FIFO attributes directly (without
> having to let them include 'buffer_impl.h' directly).
>

This isn't required anymore.
Please disregard.
Apologies for the noise

> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>
> Related to the discussion here:
>   https://lore.kernel.org/linux-iio/CA+U=Dspk3cWjiiRmDrgfHAY6houjr-KtSD3u4BssUcb=c2ujpQ@mail.gmail.com/T/#mcfda9d6cb6426caefa4a5db6d634640bfdbe328e
>
>  drivers/iio/buffer/kfifo_buf.c | 16 ++++++++++------
>  include/linux/iio/kfifo_buf.h  | 12 ++++++++----
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 4ecfa0ec3016..13eea2e11cbc 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -206,22 +206,24 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
>  }
>
>  /**
> - * devm_iio_kfifo_buffer_setup - Allocate a kfifo buffer & attach it to an IIO device
> + * devm_iio_kfifo_buffer_setup_ext - Allocate a kfifo buffer & attach it to an IIO device
>   * @dev: Device object to which to attach the life-time of this kfifo buffer
>   * @indio_dev: The device the buffer should be attached to
>   * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
>   *             INDIO_BUFFER_TRIGGERED).
>   * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
> + * @buffer_attrs: Extra sysfs buffer attributes for this IIO buffer
>   *
>   * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
>   * attaches it to the IIO device via iio_device_attach_buffer().
>   * This is meant to be a bit of a short-hand/helper function as there are a few
>   * drivers that seem to do this.
>   */
> -int devm_iio_kfifo_buffer_setup(struct device *dev,
> -                               struct iio_dev *indio_dev,
> -                               int mode_flags,
> -                               const struct iio_buffer_setup_ops *setup_ops)
> +int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
> +                                   struct iio_dev *indio_dev,
> +                                   int mode_flags,
> +                                   const struct iio_buffer_setup_ops *setup_ops,
> +                                   const struct attribute **buffer_attrs)
>  {
>         struct iio_buffer *buffer;
>
> @@ -237,8 +239,10 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
>         indio_dev->modes |= mode_flags;
>         indio_dev->setup_ops = setup_ops;
>
> +       buffer->attrs = buffer_attrs;
> +
>         return iio_device_attach_buffer(indio_dev, buffer);
>  }
> -EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup);
> +EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup_ext);
>
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> index 1522896e1daf..ccd2ceae7b25 100644
> --- a/include/linux/iio/kfifo_buf.h
> +++ b/include/linux/iio/kfifo_buf.h
> @@ -10,9 +10,13 @@ struct device;
>  struct iio_buffer *iio_kfifo_allocate(void);
>  void iio_kfifo_free(struct iio_buffer *r);
>
> -int devm_iio_kfifo_buffer_setup(struct device *dev,
> -                               struct iio_dev *indio_dev,
> -                               int mode_flags,
> -                               const struct iio_buffer_setup_ops *setup_ops);
> +int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
> +                                   struct iio_dev *indio_dev,
> +                                   int mode_flags,
> +                                   const struct iio_buffer_setup_ops *setup_ops,
> +                                   const struct attribute **buffer_attrs);
> +
> +#define devm_iio_kfifo_buffer_setup(dev, indio_dev, mode_flags, setup_ops)     \
> +       devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (mode_flags), (setup_ops), NULL)
>
>  #endif
> --
> 2.29.2
>
