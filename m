Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0F31F603
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSIqc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 03:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBSIqb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 03:46:31 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10197C061574;
        Fri, 19 Feb 2021 00:45:51 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u20so4827306iot.9;
        Fri, 19 Feb 2021 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dkoFvnkhD7Gw0bj/FIIwq2SMclEKsgMhUhYHtvCM/Q=;
        b=VacweNxitgPmKnxB9yB2yqDAdBsx3QBI0tQEUPZe58fVV1tmTpXQSql3oN23oymdyh
         B0a7dX1vVboQQveAxnj/0V7ekajUoWjzHFJxlu63ZF+hA0f6Pv+zkm7aRNRi58hjXNvr
         undltDAO+VyDNjeOxVTfFKImVCkMfB/RpKbgWvG9W+XOMNQfPhdHgZkZuNKa3IuLqYu8
         p374kcwrajQXpbbBE8yT1k+yQpkCyG+twC9FduAI7VxEV6D0/HFj8Q588EL0FaVYBoeh
         iKk1kBc7j5QKQir7WRCeeVOVGpLXwTj8rl61S2CaOXGZFEizLa4wjNxF6hi9iQi7ZZC0
         KQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dkoFvnkhD7Gw0bj/FIIwq2SMclEKsgMhUhYHtvCM/Q=;
        b=cQmzCUwKc4GBe7Smiderm5GxOuEQ18piPghrjiOrkFS3TsrhQb3L4Gmo4yd6esAD4e
         4/158Bgf2Lc9/NrRlA5ZvG647NdCDUpuEbk0Ked6Q5XiiGleOmv35gzStA4Pnq8P/6Gl
         vsfZnzDk6RtNC+Dof47b8GnL3OWTxxeft2WOpJNkmXMaF/P+23oz2YVgyVmp+PvQ121/
         nKyiZ0RyLBIPxX37hONyzFTUoKu8nQWpU++ZGfPLOvErM+Tu2PC2XWAl+y5hy0O+caUw
         tGO8Mj8wxRoFqUtvazboGPhZJStoJR/OUzVEEFsyoAGaIB2w0jInpgG4UZ/bfabB+o0W
         lTEQ==
X-Gm-Message-State: AOAM530NWCBvRXuBrWaRkNTkXouLY1qgQn4cHdQ09lNKT2h6wLTJwoyS
        h8OfbzRN4viijHulo2W9xDVxBQNEpJQFU7JNtUvrftUxlLI=
X-Google-Smtp-Source: ABdhPJw4EoSfLE5dXgeUqA+Vkizt4huaf6PanjvfWkJdJyhnpymweh5gM8VGZ4uEDMQLaAZ2MLmx7dADYb77Af8Urf4=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr8664351jaq.69.1613724350416;
 Fri, 19 Feb 2021 00:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
 <20210217083438.37865-3-alexandru.ardelean@analog.com> <20210218134240.2dd1feb2@archlinux>
In-Reply-To: <20210218134240.2dd1feb2@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 19 Feb 2021 10:45:39 +0200
Message-ID: <CA+U=DsqhDYgs-HYnC3-T0d0ubvkG8eZQifx1XLzvUa5K-Ru+bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: Add output buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 18, 2021 at 5:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 17 Feb 2021 10:34:35 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Currently IIO only supports buffer mode for capture devices like ADCs. Add
> > support for buffered mode for output devices like DACs.
> >
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer write()
> > is used to copy data into the buffer.
> >
> > poll() with POLLOUT will wakeup if there is space available for more or
> > equal to the configured watermark of samples.
> >
> > Drivers can remove data from a buffer using iio_buffer_remove_sample(), the
> > function can e.g. called from a trigger handler to write the data to
> > hardware.
> >
> > A buffer can only be either a output buffer or an input, but not both. So,
> > for a device that has an ADC and DAC path, this will mean 2 IIO buffers
> > (one for each direction).
> >
> > The direction of the buffer is decided by the new direction field of the
> > iio_buffer struct and should be set after allocating and before registering
> > it.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Just one question on this, otherwise looks good to me.
>
> Jonathan
>
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 5d641f8adfbd..b9970c68005d 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -162,6 +162,69 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
> >       return ret;
> >  }
> >
> ...
>
> >  /**
> >   * iio_buffer_poll() - poll the buffer to find out if it has data
> >   * @filp:    File structure pointer for device access
> > @@ -182,8 +245,19 @@ static __poll_t iio_buffer_poll(struct file *filp,
> >               return 0;
> >
> >       poll_wait(filp, &rb->pollq, wait);
> > -     if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > -             return EPOLLIN | EPOLLRDNORM;
> > +
> > +     switch (rb->direction) {
> > +     case IIO_BUFFER_DIRECTION_IN:
> > +             if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > +                     return EPOLLIN | EPOLLRDNORM;
> > +             break;
> > +     case IIO_BUFFER_DIRECTION_OUT:
> > +             if (iio_buffer_space_available(rb) >= rb->watermark)
> > +                     return EPOLLOUT | EPOLLWRNORM;
> > +             break;
> > +     }
> > +
> > +     /* need a way of knowing if there may be enough data... */
>
> Curious on what this comment is referring to?

I'm also a bit curious about what this comment is referring to.
I can remove it.

Maybe Lars can give some insight.

>
> >       return 0;
> >  }
> >
> > @@ -232,6 +306,16 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
> >       }
> >  }
> ...
