Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42243542EB
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhDEOk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 10:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236072AbhDEOk2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Apr 2021 10:40:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A565613A3;
        Mon,  5 Apr 2021 14:40:19 +0000 (UTC)
Date:   Mon, 5 Apr 2021 15:40:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq
 request then disable
Message-ID: <20210405154035.403edea1@jic23-huawei>
In-Reply-To: <a733aa9b11684bb990f0bc6a50b101e5@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-7-jic23@kernel.org>
        <a733aa9b11684bb990f0bc6a50b101e5@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 20:37:37 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Saturday, April 3, 2021 7:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Alexandru Ardelean <ardeleanalex@gmail.com>;
> > Nuno Sa <Nuno.Sa@analog.com>
> > Subject: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request
> > then disable
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This is a bit involved as the adis library code already has some
> > sanity checking of the flags of the requested irq that we need
> > to ensure is happy to pass through the IRQF_NO_AUTOEN flag untouched.
> > 
> > Using this flag avoids us autoenabling the irq in the adis16460 and
> > adis16475 drivers which cover parts that don't have any means of
> > masking the interrupt on the device end.
> > 
> > Note, compile tested only!
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Cc: Nuno Sa <Nuno.Sa@analog.com>
> > ---
> >  drivers/iio/imu/adis16460.c    |  4 ++--
> >  drivers/iio/imu/adis16475.c    |  5 +++--
> >  drivers/iio/imu/adis_trigger.c | 11 ++++++-----
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> > index 74a161e39733..73bf45e859b8 100644
> > --- a/drivers/iio/imu/adis16460.c
> > +++ b/drivers/iio/imu/adis16460.c
> > @@ -403,12 +403,12 @@ static int adis16460_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> > 
> > +	/* We cannot mask the interrupt, so ensure it isn't auto enabled */
> > +	st->adis.irq_flag |= IRQF_NO_AUTOEN;
> >  	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
> >  	if (ret)
> >  		return ret;
> > 
> > -	adis16460_enable_irq(&st->adis, 0);
> > -
> >  	ret = __adis_initial_startup(&st->adis);
> >  	if (ret)
> >  		return ret;
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 8f6bea4b6608..1de62fc79e0f 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -1258,6 +1258,9 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
> >  		return -EINVAL;
> >  	}
> > 
> > +	/* We cannot mask the interrupt so ensure it's not enabled at request */
> > +	st->adis.irq_flag |= IRQF_NO_AUTOEN;
> > +
> >  	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
> >  	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> >  				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> > @@ -1362,8 +1365,6 @@ static int adis16475_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> > 
> > -	adis16475_enable_irq(&st->adis, false);
> > -
> >  	ret = devm_iio_device_register(&spi->dev, indio_dev);
> >  	if (ret)
> >  		return ret;
> > diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> > index 0f29e56200af..39b50d6fdb6a 100644
> > --- a/drivers/iio/imu/adis_trigger.c
> > +++ b/drivers/iio/imu/adis_trigger.c
> > @@ -29,18 +29,19 @@ static const struct iio_trigger_ops adis_trigger_ops = {
> > 
> >  static int adis_validate_irq_flag(struct adis *adis)
> >  {
> > +	unsigned long direction = adis->irq_flag & IRQF_TRIGGER_MASK;
> >  	/*
> >  	 * Typically this devices have data ready either on the rising edge or
> >  	 * on the falling edge of the data ready pin. This checks enforces that
> >  	 * one of those is set in the drivers... It defaults to
> > -	 * IRQF_TRIGGER_RISING for backward compatibility wiht devices that
> > +	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
> >  	 * don't support changing the pin polarity.
> >  	 */
> > -	if (!adis->irq_flag) {
> > -		adis->irq_flag = IRQF_TRIGGER_RISING;
> > +	if (!direction) {  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
> 
> Though a better way might be:
> 
> if (direction == IRQF_TRIGGER_NONE)
Agreed.  That makes it a tiny bit more obvious what is going on.

Applied with that change (seems unlikely to affect other's tags)
to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can find anything we missed.

As normal, whilst 0-day and friends are working their magic, there
is time for any additional feedback anyone would like to share.

Thanks,

Jonathan

> 
> > +		adis->irq_flag |= IRQF_TRIGGER_RISING;
> >  		return 0;
> > -	} else if (adis->irq_flag != IRQF_TRIGGER_RISING &&
> > -		   adis->irq_flag != IRQF_TRIGGER_FALLING) {
> > +	} else if (direction != IRQF_TRIGGER_RISING &&
> > +		   direction != IRQF_TRIGGER_FALLING) {
> >  		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> >  			adis->irq_flag);
> >  		return -EINVAL;
> > --
> > 2.31.1  
> 
> Thanks
> Barry
> 

