Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED1410C9E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhISR1u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhISR1u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:27:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836B6604E9;
        Sun, 19 Sep 2021 17:26:22 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:30:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Mihail Chindris <mihail.chindris@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 6/6] drivers:iio:dac:ad5766.c: Add trigger buffer
Message-ID: <20210919183003.476793a2@jic23-huawei>
In-Reply-To: <CA+U=DsrNExNT2Bvjve80GJwBPy3pH_gmhc5vjYTbnsh65MHNHQ@mail.gmail.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-7-mihail.chindris@analog.com>
        <CA+U=DsrNExNT2Bvjve80GJwBPy3pH_gmhc5vjYTbnsh65MHNHQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Sep 2021 11:08:24 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Fri, Sep 17, 2021 at 9:11 AM Mihail Chindris
> <mihail.chindris@analog.com> wrote:
> >
> > This chip is able to generate waveform and using an
> > with the output trigger buffer will be easy to generate one.
> >  
> 
> This turned out to look quite neat.

Indeed. Nice little example.

> Some minor notes inline.
> Nothing major.
> But other than that:
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> > ---
> >  drivers/iio/dac/ad5766.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> > index dafda84fdea3..71491e6d466e 100644
> > --- a/drivers/iio/dac/ad5766.c
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -5,10 +5,13 @@
> >   * Copyright 2019-2020 Analog Devices Inc.
> >   */
> >  #include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  #include <linux/module.h>
> >  #include <linux/spi/spi.h>
> >  #include <asm/unaligned.h>
> > @@ -41,6 +44,7 @@
> >  #define AD5766_CMD_DITHER_SCALE_2              0xD0
> >
> >  #define AD5766_FULL_RESET_CODE                 0x1234
> > +#define AD5766_NUM_CH                          16
Can we derive this from something already present in the driver, or perhaps
enforce it having the right value in some fashion?

I'm thinking it should match ARRAY_SIZE(ad5766_channels) for example.

> >
> >  enum ad5766_type {
> >         ID_AD5766,
> > @@ -455,6 +459,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
> >         .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
> >         .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |         \
> >                 BIT(IIO_CHAN_INFO_SCALE),                               \
> > +       .scan_index = (_chan),                                          \
> >         .scan_type = {                                                  \
> >                 .sign = 'u',                                            \
> >                 .realbits = (_bits),                                    \
> > @@ -576,6 +581,28 @@ static int ad5766_default_setup(struct ad5766_state *st)
> >         return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
> >  }
> >
> > +static irqreturn_t ad5766_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct iio_buffer *buf = indio_dev->buffer;  
> 
> Purely stylistic.
> I would keep the variable name as "struct iio_buffer *bufffer".

buffer.   I guess 3 fs would make it very grep-able though :)

> Reason is: when you start to grep the kernel-code, `buf` tends to
> refer to simple/small buffers (like buf[4], or buf[16]).
> And when wanting to do some multiple-changes, grepping easier is useful.
> 
> > +       int ret, ch, i;
> > +       u16 data[AD5766_NUM_CH];
> > +
> > +       ret = iio_pop_from_buffer(buf, (u8 *)data);  
> 
> Does the compiler complain if this (u8 *) cast is removed?
> Because it doesn't look like this is needed or that it would do
> anything as the argument of data is (void *).
> 
> > +       if (ret)
> > +               goto done;
> > +
> > +       i = 0;
> > +       for_each_set_bit(ch, indio_dev->active_scan_mask, AD5766_NUM_CH - 1)
> > +               ad5766_write(indio_dev, ch, le16_to_cpu(data[i++]));

Looks like the device supports a mode where you write to input registers for all
channels and then trigger a simultaneous update.   That feels like it would be
the mode most suitable to use for buffered mode as would make the whole 'scan'
become active as close as possible to instantaneously.

> > +
> > +done:
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> >  static int ad5766_probe(struct spi_device *spi)
> >  {
> >         enum ad5766_type type;
> > @@ -609,6 +636,15 @@ static int ad5766_probe(struct spi_device *spi)
> >         if (ret)
> >                 return ret;
> >
> > +       /* Configure trigger buffer */
> > +       ret = devm_iio_triggered_buffer_setup_ext(&spi->dev, indio_dev, NULL,
> > +                                                 ad5766_trigger_handler,
> > +                                                 IIO_BUFFER_DIRECTION_OUT,
> > +                                                 NULL,
> > +                                                 NULL);
> > +       if (ret)
> > +               return ret;
> > +
> >         return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >
> > --
> > 2.27.0
> >  

