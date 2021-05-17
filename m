Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B507E3822AC
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 04:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhEQCVG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 22:21:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:51152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhEQCVF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 22:21:05 -0400
IronPort-SDR: ZytU6v9cOowRmBp5sORI5boLZVUxF4YOUis1Lao+xr+ww5uzqhI3sgAF8ERiv3zxXUzKiJpuVB
 qumN2MgdIMgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="198412933"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="198412933"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 19:19:48 -0700
IronPort-SDR: CcO80RkzVMwSySIA5sLKz71yHKYPjq26ILvFELwUlqJQCHs/Sezb1KZXIiqAmZuUK1LI4VGv5u
 YGHtu4ob9CBA==
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="626263811"
Received: from sebryan-mobl1.amr.corp.intel.com ([10.213.189.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 19:19:45 -0700
Message-ID: <34bcfe8c14e26635a4ac46f0d7b198fd07761623.camel@linux.intel.com>
Subject: Re: [PATCH 08/28] iio: hid: trigger: Balance runtime pm + use
 pm_runtime_resume_and_get()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Sun, 16 May 2021 19:19:40 -0700
In-Reply-To: <20210516161918.048de27d@jic23-huawei>
References: <20210509113354.660190-1-jic23@kernel.org>
         <20210509113354.660190-9-jic23@kernel.org>
         <20210512154430.36edf9b7@coco.lan> <20210516161918.048de27d@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-05-16 at 16:19 +0100, Jonathan Cameron wrote:
> On Wed, 12 May 2021 15:44:30 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Sun,  9 May 2021 12:33:34 +0100
> > Jonathan Cameron <jic23@kernel.org> escreveu:
> > 
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > The call to pm_runtime_put_noidle() in remove() callback is not
> > > balanced by any gets
> > > 
> > > Note this doesn't cause any problems beyond reader confusion as
> > > the runtime
> > > pm core protects against the reference counter going negative.
> > > 
> > > Whilst here, use pm_runtiem_resume_and_get() to simplify code a
> > > little.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>  
> > 
> > RPM get/put logic LGTM.
> > 
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> After our side discussion on this one I wanted to take another look.
> I'm not sure I follow the logic behind the runtime_enable() path
> and why we don't want to enable runtime_pm until first use.  However
> it's not directly related to this patch and as far as I can tell
> it's just unsuual rather than broken.  As such, applied this one to
> the
> togreg branch of iio.git and pushed out as testing.
> 

This was enabled in init path but caused issue with USB sensor hub in
Thinkpasd Yoga S1, where we can never power off sensor and it wakes up
device immediately after suspend.

commit
ad7532cefd11d11a0814a75fb814c205ee3d9d4c


Thanks,
Srinivas

> Thanks,
> 
> Jonathan
> 
> > 
> > > ---
> > >  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > index 5a7b3e253e58..c06537e106e9 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > @@ -163,18 +163,15 @@ int hid_sensor_power_state(struct
> > > hid_sensor_common *st, bool state)
> > >  
> > >         if (state) {
> > >                 atomic_inc(&st->user_requested_state);
> > > -               ret = pm_runtime_get_sync(&st->pdev->dev);
> > > +               ret = pm_runtime_resume_and_get(&st->pdev->dev);
> > >         } else {
> > >                 atomic_dec(&st->user_requested_state);
> > >                 pm_runtime_mark_last_busy(&st->pdev->dev);
> > >                 pm_runtime_use_autosuspend(&st->pdev->dev);
> > >                 ret = pm_runtime_put_autosuspend(&st->pdev->dev);
> > >         }
> > > -       if (ret < 0) {
> > > -               if (state)
> > > -                       pm_runtime_put_noidle(&st->pdev->dev);
> > > +       if (ret < 0)
> > >                 return ret;
> > > -       }
> > >  
> > >         return 0;
> > >  #else
> > > @@ -222,7 +219,6 @@ void hid_sensor_remove_trigger(struct iio_dev
> > > *indio_dev,
> > >                 pm_runtime_disable(&attrb->pdev->dev);
> > >  
> > >         pm_runtime_set_suspended(&attrb->pdev->dev);
> > > -       pm_runtime_put_noidle(&attrb->pdev->dev);
> > >  
> > >         cancel_work_sync(&attrb->work);
> > >         iio_trigger_unregister(attrb->trigger);  
> > 
> > 
> > 
> > Thanks,
> > Mauro
> 


