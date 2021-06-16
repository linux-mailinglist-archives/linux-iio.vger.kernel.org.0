Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDA3A9B18
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFPMyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhFPMyH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:54:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D766023D;
        Wed, 16 Jun 2021 12:51:58 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:54:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2 4/6] iio: prox: pulsed-light-v2: Fix misbalance
 runtime pm in error path
Message-ID: <20210616135400.7c93f0ed@jic23-huawei>
In-Reply-To: <20210616091842.7caae83e@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-5-jic23@kernel.org>
        <20210616091842.7caae83e@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:18:42 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 17:21:01 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > There is one path in which we don't do a runtime pm put and so
> > leave the device enabled for ever more.
> > 
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> I was unable to apply it on the top of next-20210615, although
> the patch looks good to me.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Ah. This crossed with another fix for the same issue.

I'll take another look at whether the alternate fix works
as well as this and revisit this one at a future date.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index 822a68ae5e03..ecaeb1e11007 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -164,7 +164,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> >  	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "cannot send start measurement command");
> > -		return ret;
> > +		goto err;
> >  	}
> >  
> >  	while (tries--) {
> > @@ -188,6 +188,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> >  		}
> >  		ret = -EIO;
> >  	}
> > +err:
> >  	pm_runtime_mark_last_busy(&client->dev);
> >  	pm_runtime_put_autosuspend(&client->dev);
> >    
> 
> 
> 
> Thanks,
> Mauro

