Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD73D4E3B
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGYOeG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 10:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhGYOeF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 10:34:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0573060F3A;
        Sun, 25 Jul 2021 15:14:31 +0000 (UTC)
Date:   Sun, 25 Jul 2021 16:17:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210725161704.4aed26a2@jic23-huawei>
In-Reply-To: <CANk7y0irgGbsEXG0jhduVycFSvbL7TkPh9+Z4RmM_XbMx=1rcA@mail.gmail.com>
References: <20210722062155.32998-1-puranjay12@gmail.com>
        <20210722062155.32998-3-puranjay12@gmail.com>
        <20210723181022.000032bd@Huawei.com>
        <CANk7y0irgGbsEXG0jhduVycFSvbL7TkPh9+Z4RmM_XbMx=1rcA@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > +
> > > +static int adxl355_set_hpf_3db(struct adxl355_data *data,
> > > +                            enum adxl355_hpf_3db hpf)
> > > +{
> > > +     int ret = 0;
> > > +
> > > +     mutex_lock(&data->lock);
> > > +
> > > +     if (data->hpf_3db == hpf)
> > > +             goto out_unlock;
> > > +
> > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > +     if (ret < 0)
> > > +             goto out_unlock;
> > > +
> > > +     ret = regmap_update_bits(data->regmap, ADXL355_FILTER,
> > > +                              ADXL355_FILTER_HPF_MSK,
> > > +                              ADXL355_FILTER_HPF_MODE(hpf));
> > > +     if (!ret)
> > > +             data->hpf_3db = hpf;
> > > +
> > > +out_unlock:
> > > +     ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > > +     mutex_unlock(&data->lock);
> > > +     return ret;
> > > +}
> > > +
> > > +static int adxl355_set_calibbias(struct adxl355_data *data,
> > > +                              int scan_index, int calibbias)
> > > +{
> > > +     int ret = 0;
> > > +     __be16 reg = cpu_to_be16(calibbias);  
> >
> > Hmm. I'm a bit in two minds on whether we can always rely on regmap
> > now copying these buffers and hence avoiding the need for DMA safe buffers
> > when used with SPI.  It seems like it now does but that's no documented
> > and a fairly recent development. Anyhow, I went with just asking Mark
> > Brown - see top of email.
> >  
> I will need to study this as I don't have knowledge about what you are saying.

It's a really 'interesting' but fiddly corner.  Following discussion with Mark
on the other branch of this thread the upshot is we should never use a buffer
on the stack for multiple register accesses in regmap because the underlying
bus driver (here SPI controller drivers are the ones that matters) may receive
the buffer directly for use in a scatter gather DMA access.

The guarantees around coherency of access to the data buffer only apply at the
size of a cacheline.  That means you can get evil things like..

1) DMA set up for the SPI transfer using this buffer.
2) Whilst DMA is going on, some unrelated bit of the driver writes a flag.
3) DMA completes and writes back the whole cacheline (some devices do this)
   and neatly rewrites the flag to it's value from before DMA started.
Having once encountered an SPI controller that could indeed do this I can tell
you it is very tricky to debug... 
https://www.youtube.com/watch?v=JDwaMClvV-s is a good presentation by Wolfram
that goes into some of these issues and why they are really hard to solve
in general (and hence why drivers still need to care!)

Anyhow, ensuring you don't share a cacheline that is used for DMA with 
anything else guarantees everything will be fine.
There would be ways of SPI controller drivers work around this, but reality
is data moves around system interconnects in cacheline sized blocks so it
fine in real systems.

Two ways of getting such data.  A heap allocation is always big enough
to ensure no sharing. IIO also has a trick given we hit this a lot.
The iio_priv() structure is cacheline aligned and on the heap.  So
if you put your buffer at the end of your driver structure that you
access via iio_priv and mark it ____cacheline_aligned then it will
start at the beginning of a new cacheline and that C requires structures
to be padded to the value of maximum element alignment means you
will be in a cacheline on your own.

A side note here is that is fine to share a cacheline for rx and tx
buffers if that makes sense as we can assume an SPI controller won't
trash it's own data.


> > > +
> > > +     mutex_lock(&data->lock);
> > > +
> > > +     ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
> > > +     if (ret < 0)
> > > +             goto out_unlock;
> > > +

...

> >  
> > > +
> > > +static const struct iio_info adxl355_info = {
> > > +     .read_raw       = adxl355_read_raw,
> > > +     .write_raw      = adxl355_write_raw,
> > > +     .read_avail     = &adxl355_read_avail
> > > +};
> > > +
> > > +#define ADXL355_ACCEL_CHANNEL(index, reg, axis) {                    \
> > > +     .type = IIO_ACCEL,                                              \
> > > +     .address = reg,                                                 \
> > > +     .modified = 1,                                                  \
> > > +     .channel2 = IIO_MOD_##axis,                                     \
> > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                  \
> > > +                           BIT(IIO_CHAN_INFO_CALIBBIAS),             \
> > > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
> > > +                                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |      \
> > > +             BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> > > +     .info_mask_shared_by_type_available =                           \
> > > +             BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
> > > +             BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> > > +     .scan_index = index,                                            \  
> >
> > Only makes sense if you are supporting buffered mode as otherwise there
> > isn't really any such thing as a 'scan'.  
> 
> I will be adding the support for buffered mode soon, is it fine if I
> leave these here?

Sure, that's fine though even better to do it in that patch ;)

Jonathan

