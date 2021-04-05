Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD33542C7
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhDEO1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235915AbhDEO1l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:27:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6F96139E;
        Mon,  5 Apr 2021 14:27:32 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:27:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce
 boilerplate
Message-ID: <20210405152747.2d2f7090@jic23-huawei>
In-Reply-To: <339f74d2c0f64516b697b17aa306d20e@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-2-jic23@kernel.org>
        <339f74d2c0f64516b697b17aa306d20e@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 20:10:38 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Saturday, April 3, 2021 7:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Lars-Peter Clausen <lars@metafoo.de>
> > Subject: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce
> > boilerplate
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As iio_poll_trigger() is safe against spurious interrupts when the
> > trigger is not enabled, this is not a fix despite looking like
> > a race.  It is nice to simplify the code however so the interrupt
> > is never enabled in the first place.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > ---  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Applied to the togreg branch of iio.git and pushed out as testing to
let the autobuilders see if they can find anything we missed.

Thanks,

Jonathan

> 
> BTW, +Cc Tiantao as Tao might be moving drivers to
> use IRQF_NO_AUTOEN.
> 
> 
> >  drivers/iio/adc/ad7766.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> > index 829a3426f235..1e41759f3ee5 100644
> > --- a/drivers/iio/adc/ad7766.c
> > +++ b/drivers/iio/adc/ad7766.c
> > @@ -255,18 +255,17 @@ static int ad7766_probe(struct spi_device *spi)
> >  		ad7766->trig->ops = &ad7766_trigger_ops;
> >  		iio_trigger_set_drvdata(ad7766->trig, ad7766);
> > 
> > -		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> > -			IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
> > -			ad7766->trig);
> > -		if (ret < 0)
> > -			return ret;
> > -
> >  		/*
> >  		 * The device generates interrupts as long as it is powered up.
> >  		 * Some platforms might not allow the option to power it down so
> > -		 * disable the interrupt to avoid extra load on the system
> > +		 * don't enable the interrupt to avoid extra load on the system
> >  		 */
> > -		disable_irq(spi->irq);
> > +		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> > +				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
> > +				       dev_name(&spi->dev),
> > +				       ad7766->trig);
> > +		if (ret < 0)
> > +			return ret;
> > 
> >  		ret = devm_iio_trigger_register(&spi->dev, ad7766->trig);
> >  		if (ret)
> > --
> > 2.31.1  
> 

