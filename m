Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C834237FBBE
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhEMQqM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234943AbhEMQqF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:46:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02740613C4;
        Thu, 13 May 2021 16:44:53 +0000 (UTC)
Date:   Thu, 13 May 2021 17:46:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/28] iio: imu: kmx61: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513174602.69745dc2@jic23-huawei>
In-Reply-To: <20210512154511.48506a44@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-10-jic23@kernel.org>
        <20210512154511.48506a44@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:45:11 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:35 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > No point in calling pm_runtime_put_noidle() that isn't balancing a get.
> > Note no actual impact because the runtime pm core protects against
> > a negative reference counter.
> > 
> > For the pm_runtime_resume_and_get() main interest is in clearing
> > out this old pattern to avoid it getting coppied into new submissions.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied. Thanks, J
> 
> > ---
> >  drivers/iio/imu/kmx61.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index d3e06ce99c1e..1dabfd615dab 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -750,7 +750,7 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
> >  	}
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(&data->client->dev);
> > +		ret = pm_runtime_resume_and_get(&data->client->dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(&data->client->dev);
> >  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> > @@ -759,8 +759,6 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
> >  		dev_err(&data->client->dev,
> >  			"Failed: kmx61_set_power_state for %d, ret %d\n",
> >  			on, ret);
> > -		if (on)
> > -			pm_runtime_put_noidle(&data->client->dev);
> >  
> >  		return ret;
> >  	}
> > @@ -1426,7 +1424,6 @@ static int kmx61_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	if (client->irq > 0) {
> >  		iio_triggered_buffer_cleanup(data->acc_indio_dev);  
> 
> 
> 
> Thanks,
> Mauro

