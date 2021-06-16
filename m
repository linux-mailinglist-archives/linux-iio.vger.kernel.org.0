Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44B3A9B32
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhFPM4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhFPM4i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:56:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6009661359;
        Wed, 16 Jun 2021 12:54:29 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:56:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH v2 6/6] iio: pressure: icp10100: Balance runtime pm +
 use pm_runtime_resume_and_get()
Message-ID: <20210616135632.4957386d@jic23-huawei>
In-Reply-To: <20210616091638.76127362@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-7-jic23@kernel.org>
        <20210616091638.76127362@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:16:38 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 17:21:03 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The devm_ handled runtime pm disable calls pm_runtime_put_sync_suspend()
> > which isn't balancing a matching get call.  It isn't a bug as such,
> > because the runtime pm core doesn't decrement the reference count below
> > zero, but it is missleading so let's drop it.
> > 
> > Using pm_runtime_resume_and_get() new call makes it easy to handle
> > failures in resume as it doesn't hold a reference count if it exits
> > with an error.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

> 
> > ---
> >  drivers/iio/pressure/icp10100.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
> > index 48759fc4bf18..af4621eaa6b5 100644
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
> > @@ -525,7 +527,6 @@ static void icp10100_pm_disable(void *data)
> >  {
> >  	struct device *dev = data;
> >  
> > -	pm_runtime_put_sync_suspend(dev);
> >  	pm_runtime_disable(dev);
> >  }
> >    
> 
> 
> 
> Thanks,
> Mauro

