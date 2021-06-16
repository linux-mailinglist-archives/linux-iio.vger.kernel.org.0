Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90613A9AB1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhFPMqu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232777AbhFPMqs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:46:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F4960FDB;
        Wed, 16 Jun 2021 12:44:39 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:46:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ads1015: Balance runtime pm + 
 pm_runtime_resume_and_get()
Message-ID: <20210616134641.73e205e6@jic23-huawei>
In-Reply-To: <20210616091555.662c305a@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-3-jic23@kernel.org>
        <20210616091555.662c305a@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:15:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 17:20:59 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The call to pm_runtime_put_noidle() in remove() is not balancing a
> > counter increment.  Note this doesn't matter as the runtime pm core
> > will not allow the counter to go negative.  However, it is confusing
> > to the reader so let's remove it.
> > 
> > The pm_runtime_resume_and_get() replacement was found using coccicheck
> > script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied
> 
> > ---
> >  drivers/iio/adc/ti-ads1015.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 5b828428be77..b0352e91ac16 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -323,9 +323,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);
> > @@ -1070,7 +1068,6 @@ static int ads1015_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	/* power down single shot mode */
> >  	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);  
> 
> 
> 
> Thanks,
> Mauro

