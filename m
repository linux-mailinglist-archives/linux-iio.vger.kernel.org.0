Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BA3381FB8
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEPQRc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhEPQRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:17:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1970610A7;
        Sun, 16 May 2021 16:16:13 +0000 (UTC)
Date:   Sun, 16 May 2021 17:17:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 27/28] iio: pressure: icp10100: Use
 pm_runtime_resume_and_get() + handle errors
Message-ID: <20210516171726.15c02247@jic23-huawei>
In-Reply-To: <20210512170004.3c6dc2a6@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-28-jic23@kernel.org>
        <20210512170004.3c6dc2a6@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 17:00:04 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:53 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Using this new call makes it easy to handle failures in resume as it
> > doesn't hold a reference count if it exits with an error.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > ---
> >  drivers/iio/pressure/icp10100.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
> > index 48759fc4bf18..80cd66688731 100644
> > --- a/drivers/iio/pressure/icp10100.c
> > +++ b/drivers/iio/pressure/icp10100.c
> > @@ -250,7 +250,9 @@ static int icp10100_get_measures(struct icp10100_state *st,
> >  	__be16 measures[3];
> >  	int ret;
> >  
> > -	pm_runtime_get_sync(&st->client->dev);
> > +	ret = pm_runtime_resume_and_get(&st->client->dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	mutex_lock(&st->lock);
> >  	cmd = &icp10100_cmd_measure[st->mode];  
> 
> 
> This one has a logic similar to a patch I commented earlier in this
> series. At probing time, it does:
> 
>         pm_runtime_get_noresume(&client->dev);
>         pm_runtime_set_active(&client->dev);
>         pm_runtime_enable(&client->dev);
>         pm_runtime_set_autosuspend_delay(&client->dev, 2000);
>         pm_runtime_use_autosuspend(&client->dev);
>         pm_runtime_put(&client->dev);
>         ret = devm_add_action_or_reset(&client->dev, icp10100_pm_disable,
>                                        &client->dev);
> 
> 
> Here, get/put are balanced, but the icp10100_pm_disable logic is:
> 
> static void icp10100_pm_disable(void *data)
> {
>         struct device *dev = data;
> 
>         pm_runtime_put_sync_suspend(dev);
I'll drop this in v2.

Thanks,

Jonathan

>         pm_runtime_disable(dev);
> }
> 
> Not sure what RPM get() it is trying to balance there.
> 
> Thanks,
> Mauro

