Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E307334CEB9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhC2LTG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhC2LSv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 07:18:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF18761554;
        Mon, 29 Mar 2021 11:18:49 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:18:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7923: register device with
 devm_iio_device_register
Message-ID: <20210329121856.0327b9a4@jic23-huawei>
In-Reply-To: <1548d948-bd01-a8db-6ecc-720bb7ca73a9@metafoo.de>
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
        <b0146465d52f4e259f5f95c83c71e72f065093da.1616966903.git.lucas.p.stankus@gmail.com>
        <1548d948-bd01-a8db-6ecc-720bb7ca73a9@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 09:06:14 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/28/21 11:46 PM, Lucas Stankus wrote:
> > Registers the device using the devm variant.
> > This is the final step of converting the ad7923 to only use devm routines,
> > meaning that the ad7923_remove() function is no longer needed to release
> > resources on device detach.
> > 
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>  
> 
> Hi,
> 
> Thanks for the patches.T his looks good, just one small comment.

On basis of saving everyone time, I've fixed up the comment from Lars
below whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they can find anything we missed.

Thanks,

Jonathan

> 
> > ---
> >   drivers/iio/adc/ad7923.c | 12 +-----------
> >   1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index d07eaf3111ed..f7af2f194789 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -356,16 +356,7 @@ static int ad7923_probe(struct spi_device *spi)
> >   	if (ret)
> >   		return ret;
> >   
> > -	return iio_device_register(indio_dev);
> > -}
> > -
> > -static int ad7923_remove(struct spi_device *spi)
> > -{
> > -	struct iio_dev *indio_dev = spi_get_drvdata(spi);  
> 
> This removes the last user of get_drvdata() on the SPI device. This means you 
> can also remove the spi_set_drvdata() in the probe function.
> 
> > -
> > -	iio_device_unregister(indio_dev);
> > -
> > -	return 0;
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> >   }  

