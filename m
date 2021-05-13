Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6537FBA1
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhEMQhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhEMQhv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:37:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0661D61396;
        Thu, 13 May 2021 16:36:39 +0000 (UTC)
Date:   Thu, 13 May 2021 17:37:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 02/28] iio: light: isl29028: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513173748.55aa2ae8@jic23-huawei>
In-Reply-To: <20210512153335.5acb9e3f@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-3-jic23@kernel.org>
        <20210512153335.5acb9e3f@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:33:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:28 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > In remove this driver called pm_runtime_put_noidle() but there is
> > no matching get operation.  This does not cause any problems because
> > the reference counter will not change if already zero, but it
> > does make the code harder to reason about so should be dropped.
> > 
> > Whilst we are here, use pm_runtime_resume_and_get() to replace open
> > coded version.
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/isl29028.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> > index 2f8b494f3e08..9de3262aa688 100644
> > --- a/drivers/iio/light/isl29028.c
> > +++ b/drivers/iio/light/isl29028.c
> > @@ -339,9 +339,7 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
> >  	int ret;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);
> > @@ -647,7 +645,6 @@ static int isl29028_remove(struct i2c_client *client)
> >  
> >  	pm_runtime_disable(&client->dev);
> >  	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> >  
> >  	return isl29028_clear_configure_reg(chip);
> >  }  
> 
> 
> 
> Thanks,
> Mauro

