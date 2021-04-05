Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90F35431E
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbhDEPBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 11:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237824AbhDEPBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 11:01:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF027613B2;
        Mon,  5 Apr 2021 15:00:53 +0000 (UTC)
Date:   Mon, 5 Apr 2021 16:01:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/3] iio:adc:ad7476: Fix remove handling
Message-ID: <20210405160112.13c55d0f@jic23-huawei>
In-Reply-To: <CA+U=DspFppB_cnufH6VLULKCaVQ796GsNykt90OJPPj_ThcyvQ@mail.gmail.com>
References: <20210401171759.318140-1-jic23@kernel.org>
        <20210401171759.318140-2-jic23@kernel.org>
        <CA+U=DspFppB_cnufH6VLULKCaVQ796GsNykt90OJPPj_ThcyvQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 10:34:42 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 1, 2021 at 8:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This driver was in an odd half way state between devm based cleanup
> > and manual cleanup (most of which was missing).
> > I would guess something went wrong with a rebase or similar.
> > Anyhow, this basially finishes the job as a precusor to improving  
> 
> 2 typos in this commit description

One day I'll learn how to type /spell or at least to remember to use
a spell checker on commit descriptions.
> 
> > the regulator handling.
> >  
> 
> I was pretty surprised about this patch [before reading through it].
Yup. This one definitely got a wtf followed by a groan that it had snuck
through.  Has that look of a rebase going horribly wrong to me and
I missed it completely in the original reviews :(


> Anyhow:
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Thanks,

Applied to the togreg branch of iio.git and marked for stable.
Bit late in cycle to do another fixes pull request so this one
can wait for the merge window.

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Fixes: 4bb2b8f94ace3 ("iio: adc: ad7476: implement devm_add_action_or_reset")
> > Cc: Michael Hennerich <michael.hennerich@analog.com>
> > ---
> >  drivers/iio/adc/ad7476.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index 17402714b387..9e9ff07cf972 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -321,25 +321,15 @@ static int ad7476_probe(struct spi_device *spi)
> >         spi_message_init(&st->msg);
> >         spi_message_add_tail(&st->xfer, &st->msg);
> >
> > -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > -                       &ad7476_trigger_handler, NULL);
> > +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> > +                                             &ad7476_trigger_handler, NULL);
> >         if (ret)
> > -               goto error_disable_reg;
> > +               return ret;
> >
> >         if (st->chip_info->reset)
> >                 st->chip_info->reset(st);
> >
> > -       ret = iio_device_register(indio_dev);
> > -       if (ret)
> > -               goto error_ring_unregister;
> > -       return 0;
> > -
> > -error_ring_unregister:
> > -       iio_triggered_buffer_cleanup(indio_dev);
> > -error_disable_reg:
> > -       regulator_disable(st->reg);
> > -
> > -       return ret;
> > +       return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >
> >  static const struct spi_device_id ad7476_id[] = {
> > --
> > 2.31.1
> >  

