Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB34342E3E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCTQOj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 12:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCTQOe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 12:14:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D6D61932;
        Sat, 20 Mar 2021 16:14:31 +0000 (UTC)
Date:   Sat, 20 Mar 2021 16:14:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@deviqon.com,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: kfifo: add devm_iio_triggered_buffer_setup_ext
 variant
Message-ID: <20210320161428.2252376f@jic23-huawei>
In-Reply-To: <CA+U=DsqL3BS0QFsV01caxFjsUmeSsfrbuo1ezKtfBhAncCBoMA@mail.gmail.com>
References: <20210311091042.22417-1-aardelean@deviqon.com>
        <CA+U=DsqL3BS0QFsV01caxFjsUmeSsfrbuo1ezKtfBhAncCBoMA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 07:27:28 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Mar 11, 2021 at 11:14 AM Alexandru Ardelean
> <aardelean@deviqon.com> wrote:
> >
> > This is similar to the {devm_}iio_triggered_buffer_setup_ext variants added
> > via commit 5164c7889857 ("iio: triggered-buffer: add
> > {devm_}iio_triggered_buffer_setup_ext variants").
> >
> > These can be used to pass extra buffer attributes to the buffer object.
> > This is a bit of temporary mechanism (hopefully) so that drivers that want
> > to allocate a kfifo buffer with extra buffer attributes, don't need to
> > include 'buffer_impl.h' directly. This can also become an API function (in
> > it's own right, unfortunately), but it may be a little less bad vs drivers
> > having to include 'buffer_impl.h'.
> >
> > So, far the drivers that want to pass buffer attributes, all have to do
> > with some HW FIFO attributes, so there may be a chance of unifying them
> > into IIO core somehow (as some standard API). But, until that happens, we
> > just need to let them register their HW FIFO attributes directly (without
> > having to let them include 'buffer_impl.h' directly).
> >  
> 
> This isn't required anymore.
> Please disregard.
> Apologies for the noise

As it's now required again, applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to poke at it.

thanks,

Jonathan

> 
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >
> > Related to the discussion here:
> >   https://lore.kernel.org/linux-iio/CA+U=Dspk3cWjiiRmDrgfHAY6houjr-KtSD3u4BssUcb=c2ujpQ@mail.gmail.com/T/#mcfda9d6cb6426caefa4a5db6d634640bfdbe328e
> >
> >  drivers/iio/buffer/kfifo_buf.c | 16 ++++++++++------
> >  include/linux/iio/kfifo_buf.h  | 12 ++++++++----
> >  2 files changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> > index 4ecfa0ec3016..13eea2e11cbc 100644
> > --- a/drivers/iio/buffer/kfifo_buf.c
> > +++ b/drivers/iio/buffer/kfifo_buf.c
> > @@ -206,22 +206,24 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
> >  }
> >
> >  /**
> > - * devm_iio_kfifo_buffer_setup - Allocate a kfifo buffer & attach it to an IIO device
> > + * devm_iio_kfifo_buffer_setup_ext - Allocate a kfifo buffer & attach it to an IIO device
> >   * @dev: Device object to which to attach the life-time of this kfifo buffer
> >   * @indio_dev: The device the buffer should be attached to
> >   * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
> >   *             INDIO_BUFFER_TRIGGERED).
> >   * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
> > + * @buffer_attrs: Extra sysfs buffer attributes for this IIO buffer
> >   *
> >   * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
> >   * attaches it to the IIO device via iio_device_attach_buffer().
> >   * This is meant to be a bit of a short-hand/helper function as there are a few
> >   * drivers that seem to do this.
> >   */
> > -int devm_iio_kfifo_buffer_setup(struct device *dev,
> > -                               struct iio_dev *indio_dev,
> > -                               int mode_flags,
> > -                               const struct iio_buffer_setup_ops *setup_ops)
> > +int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
> > +                                   struct iio_dev *indio_dev,
> > +                                   int mode_flags,
> > +                                   const struct iio_buffer_setup_ops *setup_ops,
> > +                                   const struct attribute **buffer_attrs)
> >  {
> >         struct iio_buffer *buffer;
> >
> > @@ -237,8 +239,10 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
> >         indio_dev->modes |= mode_flags;
> >         indio_dev->setup_ops = setup_ops;
> >
> > +       buffer->attrs = buffer_attrs;
> > +
> >         return iio_device_attach_buffer(indio_dev, buffer);
> >  }
> > -EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup);
> > +EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup_ext);
> >
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> > index 1522896e1daf..ccd2ceae7b25 100644
> > --- a/include/linux/iio/kfifo_buf.h
> > +++ b/include/linux/iio/kfifo_buf.h
> > @@ -10,9 +10,13 @@ struct device;
> >  struct iio_buffer *iio_kfifo_allocate(void);
> >  void iio_kfifo_free(struct iio_buffer *r);
> >
> > -int devm_iio_kfifo_buffer_setup(struct device *dev,
> > -                               struct iio_dev *indio_dev,
> > -                               int mode_flags,
> > -                               const struct iio_buffer_setup_ops *setup_ops);
> > +int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
> > +                                   struct iio_dev *indio_dev,
> > +                                   int mode_flags,
> > +                                   const struct iio_buffer_setup_ops *setup_ops,
> > +                                   const struct attribute **buffer_attrs);
> > +
> > +#define devm_iio_kfifo_buffer_setup(dev, indio_dev, mode_flags, setup_ops)     \
> > +       devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (mode_flags), (setup_ops), NULL)
> >
> >  #endif
> > --
> > 2.29.2
> >  

