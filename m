Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBE37FBA9
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbhEMQlH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234995AbhEMQlG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:41:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E39611CE;
        Thu, 13 May 2021 16:39:54 +0000 (UTC)
Date:   Thu, 13 May 2021 17:41:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/28] iio: accel: bmc150-accel: Balanced runtime pm +
 use pm_runtime_resume_and_get()
Message-ID: <20210513174102.1d6160c6@jic23-huawei>
In-Reply-To: <ab152f9b-f4b8-fefc-5d4b-81a6e91fed90@redhat.com>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-5-jic23@kernel.org>
        <ab152f9b-f4b8-fefc-5d4b-81a6e91fed90@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 May 2021 15:52:44 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A call to pm_runtime_put_noidle() doesn't match any call that would
> > result in a get().  It is safe because runtime pm core protects against
> > the reference counter going 0, but it makes it harder to understand the
> > code.
> > 
> > Whilst here use pm_runtime_resume_and_get() to tidy things up.
> > The Coccinelle script didn't get this one due to more complex code
> > structure.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>  
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied to the togreg branch of iio.git, pushed out as testing for all the
normal reasons.

Thanks,

Jonathan

> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 62a164a7b852..43cfadf8f6b7 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -389,7 +389,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
> >  	int ret;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);
> > @@ -398,9 +398,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
> >  	if (ret < 0) {
> >  		dev_err(dev,
> >  			"Failed: %s for %d\n", __func__, on);
> > -		if (on)
> > -			pm_runtime_put_noidle(dev);
> > -
> >  		return ret;
> >  	}
> >  
> > @@ -1836,7 +1833,6 @@ int bmc150_accel_core_remove(struct device *dev)
> >  
> >  	pm_runtime_disable(dev);
> >  	pm_runtime_set_suspended(dev);
> > -	pm_runtime_put_noidle(dev);
> >  
> >  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
> >  
> >   
> 

