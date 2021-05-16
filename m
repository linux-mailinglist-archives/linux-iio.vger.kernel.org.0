Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51CC381F96
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEPQIi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhEPQIi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:08:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FCF6115C;
        Sun, 16 May 2021 16:07:21 +0000 (UTC)
Date:   Sun, 16 May 2021 17:08:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 23/28] iio: pressure: zpa2326: fix potential extra call
 of runtime suspend.
Message-ID: <20210516170824.15ce4e59@jic23-huawei>
In-Reply-To: <20210512164951.3de2d515@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-24-jic23@kernel.org>
        <20210512164951.3de2d515@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:49:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:49 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This case illustrates why the new pm_runtime_sync_and_get() is good
> > in that it makes clear the correct way to handle errors.
> > 
> > Calling pm_runtime_put() on failure of the _get() in pm_runtime_get_sync()
> > will potentially result in powering down an already powered down device
> > (as we never successfully powered it up.  Unlikely to cause any problems
> > in reality.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> This one seems a little odd on my eyes, although I don't know much about
> IIO, as it calls RPM get only at:
> 
> 	zpa2326_init_runtime()
> 
> on a balanced way, as the routine starts with RPM get() ends with RPM put().
> 
> Then it does a put at zpa2326_suspend() and a get at zpa2326_resume().
> 
> Can RPM usage_count be zero at suspend (or are there some other part
> of IIO core that increments it?). Because, if after resume, usage_count
> would be equal to 1, as I guess RPM core prevent negative values.

I've stared at this for a few minutes and gotten nowhere in figuring out
the intent.   As such I'm going to drop the patch for now and revisit
at a later date.

Jonathan



> 
> Regards,
> Mauro
> 
> 
> 
> > ---
> >  drivers/iio/pressure/zpa2326.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> > index 89295c90f801..97ac3ba399f7 100644
> > --- a/drivers/iio/pressure/zpa2326.c
> > +++ b/drivers/iio/pressure/zpa2326.c
> > @@ -664,11 +664,9 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
> >  {
> >  	int err;
> >  
> > -	err = pm_runtime_get_sync(indio_dev->dev.parent);
> > -	if (err < 0) {
> > -		pm_runtime_put(indio_dev->dev.parent);
> > +	err = pm_runtime_resume_and_get(indio_dev->dev.parent);
> > +	if (err < 0)
> >  		return err;
> > -	}
> >  
> >  	if (err > 0) {
> >  		/*  
> 
> 
> 
> Thanks,
> Mauro

