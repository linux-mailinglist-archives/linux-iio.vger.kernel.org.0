Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883B6342D66
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 15:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCTOjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 10:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCTOjZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:39:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F1361967;
        Sat, 20 Mar 2021 14:39:23 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:39:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        ardeleanalex@gmail.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:dac:max517.c: Use devm_iio_device_register()
Message-ID: <20210320143920.1c4f8e29@jic23-huawei>
In-Reply-To: <707e5ff3-c38a-c0fe-e6b9-1e054cc46606@metafoo.de>
References: <20210314093356.10609-1-dmugil2000@gmail.com>
        <20210314175709.34301-1-dmugil2000@gmail.com>
        <707e5ff3-c38a-c0fe-e6b9-1e054cc46606@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Mar 2021 06:55:53 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/14/21 6:57 PM, Mugilraj Dhavachelvan wrote:
> > Use devm_iio_device_register() to avoid remove function and
> > drop explicit call to iio_device_unregister().
> >
> > Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> >
> > changes v1->v2:
> > 	-As sugested by Alexandru removed i2c_set_clientdata() because the stored
> > 	 data will be never used.  
This changelog belongs below the -- so that it doesn't get picked
up for the permanent log in by git am.  I fixed that up whilst applying.

Otherwise looks good.

Applied to the togreg branch of iio.git and pushed out as testing
to let the autobuilder bots like 0-day see if they can find anything
we missed.  That usually takes about a day and I need to fix up any
resulting issues before pushing this out as the non-rebasing togreg
branch on which pull requests are then based.

Thanks,

Jonathan

> 
> Hi,
> 
> This looks good!
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> One thing process wise. I know it is tempting to send version 2 as a 
> reply to version 1, but this way it is also easy for the messages to get 
> lost in longer threads. At least for the IIO mailinglist we have decided 
> that it is best to send new versions of a patch series as their own 
> threads so that they stand own and get noticed.
> 
> - Lars
> 
> > ---
> >   drivers/iio/dac/max517.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> > index 7e01838ef4d0..00f0062a0298 100644
> > --- a/drivers/iio/dac/max517.c
> > +++ b/drivers/iio/dac/max517.c
> > @@ -153,7 +153,6 @@ static int max517_probe(struct i2c_client *client,
> >   	if (!indio_dev)
> >   		return -ENOMEM;
> >   	data = iio_priv(indio_dev);
> > -	i2c_set_clientdata(client, indio_dev);
> >   	data->client = client;
> >   
> >   	/* establish that the iio_dev is a child of the i2c device */
> > @@ -189,13 +188,7 @@ static int max517_probe(struct i2c_client *client,
> >   			data->vref_mv[chan] = platform_data->vref_mv[chan];
> >   	}
> >   
> > -	return iio_device_register(indio_dev);
> > -}
> > -
> > -static int max517_remove(struct i2c_client *client)
> > -{
> > -	iio_device_unregister(i2c_get_clientdata(client));
> > -	return 0;
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> >   }
> >   
> >   static const struct i2c_device_id max517_id[] = {
> > @@ -214,7 +207,6 @@ static struct i2c_driver max517_driver = {
> >   		.pm	= &max517_pm_ops,
> >   	},
> >   	.probe		= max517_probe,
> > -	.remove		= max517_remove,
> >   	.id_table	= max517_id,
> >   };
> >   module_i2c_driver(max517_driver);  
> 
> 

