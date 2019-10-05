Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072FCCCAA0
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfJEOuB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfJEOuB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:50:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB6520862;
        Sat,  5 Oct 2019 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570287000;
        bh=qOJAhZp3zmapET+RLs7ctITKD0/BDn6jnXEjLqWwBB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SGoFCqdPb9AMqnEEQtiwBic5RvAsGObDgMzNZYalLTkJy7MKaqmHXNS5gfIznFt5P
         dnmaBBWsxCvLPsN0OQqqgjzPQbgx2P3lGN+3GlJMFUP/7qGyDqEgRCT/VJrmW+F2tF
         BEOhlrMOclNry5Bhyb0vfpC/fjBHLG8yIRGr6Rb4=
Date:   Sat, 5 Oct 2019 15:49:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adis16260: remove indio_dev mlock
Message-ID: <20191005154949.4c339235@archlinux>
In-Reply-To: <20191005153837.25e5be57@archlinux>
References: <20190919115716.25909-1-alexandru.ardelean@analog.com>
        <20191005153837.25e5be57@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Oct 2019 15:38:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 19 Sep 2019 14:57:16 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> 
> > The internal lock that is by the ADIS library should be sufficient to keep
> > state consistent. There is no need for an extra lock.  
> 
> I'm not sure that's true.  In theory we could get two different attempts
> to set the sampling frequency running concurrently. That could lead to
> a race between the point where we set the spi frequency for future
> messages and the point where we set the devices sampling frequency.
> 
> Bang it stops working.  So, whilst it is arguably paranoid I think
> you do need a lock here, but it should be something that is driver
> local rather than mlock.

Thinking a bit more on this do we have a potential issue where we
race with a read on the spi bus as we are changing this frequency?
They might all be 'safe' but I haven't thought it through properly yet.

> 
> thanks,
> 
> Jonathan
> 
> 
> > 
> > This patch removes it.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/gyro/adis16260.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> > index 207a0ce13439..0fa93d02062a 100644
> > --- a/drivers/iio/gyro/adis16260.c
> > +++ b/drivers/iio/gyro/adis16260.c
> > @@ -293,7 +293,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
> >  		addr = adis16260_addresses[chan->scan_index][1];
> >  		return adis_write_reg_16(adis, addr, val);
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		mutex_lock(&indio_dev->mlock);
> >  		if (spi_get_device_id(adis->spi)->driver_data)
> >  			t = 256 / val;
> >  		else
> > @@ -310,7 +309,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
> >  			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
> >  		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
> >  
> > -		mutex_unlock(&indio_dev->mlock);
> >  		return ret;
> >  	}
> >  	return -EINVAL;  
> 

