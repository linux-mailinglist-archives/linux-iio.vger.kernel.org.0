Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8977E37FC0C
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhEMRDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhEMRDl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:03:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417216143D;
        Thu, 13 May 2021 17:02:28 +0000 (UTC)
Date:   Thu, 13 May 2021 18:03:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: Re: [PATCH 10/28] iio: light: rpr0521: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513180337.6c70c594@jic23-huawei>
In-Reply-To: <20210512154632.12e470ec@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-11-jic23@kernel.org>
        <20210512154632.12e470ec@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:46:32 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:36 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Calls to pm_runtime_put_noidle in probe() error path and remove() are
> > not match to any get() calls.
> > 
> > The runtime pm core protects against negative reference counts, so this
> > doesn't have any visible impact beyond confusing the reader.
> > 
> > Whilst here use pm_runtime_resume_and_get() to replace boilerplate.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to take a swing at it before I push it in something linux-next
will pick up.   Note still time for additional reviews as I'm happy to rebase
the tree for now.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/rpr0521.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 7e332de0e6a5..c2dd8a3d4217 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -360,7 +360,7 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> >  	 * both stay enabled until _suspend().
> >  	 */
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(&data->client->dev);
> > +		ret = pm_runtime_resume_and_get(&data->client->dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(&data->client->dev);
> >  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> > @@ -369,9 +369,6 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
> >  		dev_err(&data->client->dev,
> >  			"Failed: rpr0521_set_power_state for %d, ret %d\n",
> >  			on, ret);
> > -		if (on)
> > -			pm_runtime_put_noidle(&data->client->dev);
> > -
> >  		return ret;
> >  	}
> >  
> > @@ -1038,7 +1035,6 @@ static int rpr0521_probe(struct i2c_client *client,
> >  err_pm_disable:
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  err_poweroff:
> >  	rpr0521_poweroff(data);
> >  
> > @@ -1053,7 +1049,6 @@ static int rpr0521_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	rpr0521_poweroff(iio_priv(indio_dev));
> >    
> 
> 
> 
> Thanks,
> Mauro

