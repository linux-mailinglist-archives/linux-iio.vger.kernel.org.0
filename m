Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A83A381F74
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEPPTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 11:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhEPPTW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 11:19:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4256113E;
        Sun, 16 May 2021 15:18:06 +0000 (UTC)
Date:   Sun, 16 May 2021 16:19:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 08/28] iio: hid: trigger: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210516161918.048de27d@jic23-huawei>
In-Reply-To: <20210512154430.36edf9b7@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-9-jic23@kernel.org>
        <20210512154430.36edf9b7@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:44:30 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:34 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The call to pm_runtime_put_noidle() in remove() callback is not
> > balanced by any gets
> > 
> > Note this doesn't cause any problems beyond reader confusion as the runtime
> > pm core protects against the reference counter going negative.
> > 
> > Whilst here, use pm_runtiem_resume_and_get() to simplify code a little.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>  
> 
> RPM get/put logic LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

After our side discussion on this one I wanted to take another look.
I'm not sure I follow the logic behind the runtime_enable() path
and why we don't want to enable runtime_pm until first use.  However
it's not directly related to this patch and as far as I can tell
it's just unsuual rather than broken.  As such, applied this one to the
togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 5a7b3e253e58..c06537e106e9 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -163,18 +163,15 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
> >  
> >  	if (state) {
> >  		atomic_inc(&st->user_requested_state);
> > -		ret = pm_runtime_get_sync(&st->pdev->dev);
> > +		ret = pm_runtime_resume_and_get(&st->pdev->dev);
> >  	} else {
> >  		atomic_dec(&st->user_requested_state);
> >  		pm_runtime_mark_last_busy(&st->pdev->dev);
> >  		pm_runtime_use_autosuspend(&st->pdev->dev);
> >  		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
> >  	}
> > -	if (ret < 0) {
> > -		if (state)
> > -			pm_runtime_put_noidle(&st->pdev->dev);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	return 0;
> >  #else
> > @@ -222,7 +219,6 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> >  		pm_runtime_disable(&attrb->pdev->dev);
> >  
> >  	pm_runtime_set_suspended(&attrb->pdev->dev);
> > -	pm_runtime_put_noidle(&attrb->pdev->dev);
> >  
> >  	cancel_work_sync(&attrb->work);
> >  	iio_trigger_unregister(attrb->trigger);  
> 
> 
> 
> Thanks,
> Mauro

