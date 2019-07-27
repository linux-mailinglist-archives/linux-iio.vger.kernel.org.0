Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3CE77915
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfG0OBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 10:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfG0OBH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 10:01:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA3120840;
        Sat, 27 Jul 2019 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564236066;
        bh=FSQSrO+2OwW4fijGmMlDa81a0rfWwjuQHjY9U+gpkrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PjR7grEfGHOQFtuaNbz5IhNwZ5v/m+2PD7bg9i04Qhls6KRovzoTPO7oljMWSpXs6
         TBOczKpYe2CL11a1hqLvL2sqnSaKNLMMOYBrKiP136O6NFzFJxWwVnfaSSupW1IH0/
         sOwS2KI4W2VVqYY+OKtXZ0kSdf7snrc/eOzXwPlM=
Date:   Sat, 27 Jul 2019 15:01:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "hslester96@gmail.com" <hslester96@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad2s1210: Use device-managed API
Message-ID: <20190727150101.43bb4314@archlinux>
In-Reply-To: <b7c56658547a972b4e4a2b075b2319192f89c803.camel@analog.com>
References: <20190726110742.20445-1-hslester96@gmail.com>
        <b7c56658547a972b4e4a2b075b2319192f89c803.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 12:36:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2019-07-26 at 19:07 +0800, Chuhong Yuan wrote:
> > [External]
> > 
> > Use device-managed API to simplify the code.
> > The remove function is redundant now and can
> > be deleted.  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
The end of this probe function is rather odd and probably needs sorting
out as I imagine that needs to happen before the device is exposed to
userspace.

Nothing to do with this patch though which is great.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index 0c1bd108c386..4b25a3a314ed 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -671,7 +671,7 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
> >  	indio_dev->name = spi_get_device_id(spi)->name;
> >  
> > -	ret = iio_device_register(indio_dev);
> > +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -683,15 +683,6 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  	return 0;
> >  }
> >  
> > -static int ad2s1210_remove(struct spi_device *spi)
> > -{
> > -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > -
> > -	iio_device_unregister(indio_dev);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct of_device_id ad2s1210_of_match[] = {
> >  	{ .compatible = "adi,ad2s1210", },
> >  	{ }
> > @@ -710,7 +701,6 @@ static struct spi_driver ad2s1210_driver = {
> >  		.of_match_table = of_match_ptr(ad2s1210_of_match),
> >  	},
> >  	.probe = ad2s1210_probe,
> > -	.remove = ad2s1210_remove,
> >  	.id_table = ad2s1210_id,
> >  };
> >  module_spi_driver(ad2s1210_driver);  

