Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83337FBD7
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhEMQzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhEMQzq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:55:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D13613C5;
        Thu, 13 May 2021 16:54:33 +0000 (UTC)
Date:   Thu, 13 May 2021 17:55:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: Re: [PATCH 25/28] iio: proximity: srf04: Use
 pm_runtime_resume_and_get() and handle error
Message-ID: <20210513175541.10aa066f@jic23-huawei>
In-Reply-To: <20210512165326.12f26e74@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-26-jic23@kernel.org>
        <20210512165326.12f26e74@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:53:26 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:51 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Previously this driver used pm_runtime_sync_get() and did not handle any
> > errors that occurred.  Moving to the new pm_runtime_resume_and_get() +
> > handle errors.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andreas Klinger <ak@it-klinger.de>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/proximity/srf04.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> > index 420c37c72de4..fe88b2bb60bc 100644
> > --- a/drivers/iio/proximity/srf04.c
> > +++ b/drivers/iio/proximity/srf04.c
> > @@ -100,9 +100,11 @@ static int srf04_read(struct srf04_data *data)
> >  	u64 dt_ns;
> >  	u32 time_ns, distance_mm;
> >  
> > -	if (data->gpiod_power)
> > -		pm_runtime_get_sync(data->dev);
> > -
> > +	if (data->gpiod_power) {
> > +		ret = pm_runtime_resume_and_get(data->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >  	/*
> >  	 * just one read-echo-cycle can take place at a time
> >  	 * ==> lock against concurrent reading calls  
> 
> 
> 
> Thanks,
> Mauro

