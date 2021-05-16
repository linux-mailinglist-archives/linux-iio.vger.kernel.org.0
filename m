Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC87E381F7F
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhEPPqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 11:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhEPPqm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 11:46:42 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837F061151;
        Sun, 16 May 2021 15:45:25 +0000 (UTC)
Date:   Sun, 16 May 2021 16:46:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH 18/28] iio: chemical: atlas-sensor: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210516164638.0ec32cc6@jic23-huawei>
In-Reply-To: <20210512162541.078069d8@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-19-jic23@kernel.org>
        <20210512162541.078069d8@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:25:41 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:44 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
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
> Same case as patch 17: this driver also seems to have an extra
> (unbalanced?) call to pm_runtime_disable() at remove().

Good point again.  Matt, given this is a material change I'm going to
drop your tag, please take another look.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index d10f921b233a..90bb3f5bff19 100644
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
> 
> 
> 
> Thanks,
> Mauro

