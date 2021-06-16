Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5573A9ABD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFPMry (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhFPMrv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:47:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B603260FDB;
        Wed, 16 Jun 2021 12:45:43 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:47:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2 3/6] iio: chemical: atlas-sensor: Balance runtime pm
 + pm_runtime_resume_and_get()
Message-ID: <20210616134746.7e747dea@jic23-huawei>
In-Reply-To: <20210616091620.5f689adb@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-4-jic23@kernel.org>
        <20210616091620.5f689adb@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:16:20 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 17:21:00 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The pm_runtime_put_noidle() call in remove isn't balanced with any get, so
> > drop it.  Note this isn't a bug as the runtime pm core will not allow the
> > reference count to go negative, making this a noop. However, it is
> > confusing to the reader so let's drop it.
> > 
> > pm_runtime_resume_and_get() replacement found using the coccicheck script
> > under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > As pm_runtime_resume_and_get() returns <= 0 take advantage of that to
> > change the error checking to if (ret) which is more in keeping with the
> > rest of this driver.
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied

> 
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 0fdb3b29c5eb..9cb99585b6ff 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -410,11 +410,9 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
> >  	struct atlas_data *data = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	ret = pm_runtime_get_sync(&data->client->dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(&data->client->dev);
> > +	ret = pm_runtime_resume_and_get(&data->client->dev);
> > +	if (ret)
> >  		return ret;
> > -	}
> >  
> >  	return atlas_set_interrupt(data, true);
> >  }
> > @@ -487,11 +485,9 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
> >  	int suspended = pm_runtime_suspended(dev);
> >  	int ret;
> >  
> > -	ret = pm_runtime_get_sync(dev);
> > -	if (ret < 0) {
> > -		pm_runtime_put_noidle(dev);
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> >  		return ret;
> > -	}
> >  
> >  	if (suspended)
> >  		msleep(data->chip->delay);
> > @@ -741,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	return atlas_set_powermode(data, 0);
> >  }  
> 
> 
> 
> Thanks,
> Mauro

