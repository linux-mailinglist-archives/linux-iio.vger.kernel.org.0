Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1306382750
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhEQIqx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 17 May 2021 04:46:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3007 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbhEQIqw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 04:46:52 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkCMW6RV1zmX0F;
        Mon, 17 May 2021 16:43:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:45:33 +0800
Received: from localhost (10.52.123.135) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 09:45:31 +0100
Date:   Mon, 17 May 2021 09:43:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 08/28] iio: hid: trigger: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210517094347.00000af0@Huawei.com>
In-Reply-To: <34bcfe8c14e26635a4ac46f0d7b198fd07761623.camel@linux.intel.com>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-9-jic23@kernel.org>
        <20210512154430.36edf9b7@coco.lan>
        <20210516161918.048de27d@jic23-huawei>
        <34bcfe8c14e26635a4ac46f0d7b198fd07761623.camel@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.135]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 19:19:40 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sun, 2021-05-16 at 16:19 +0100, Jonathan Cameron wrote:
> > On Wed, 12 May 2021 15:44:30 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Sun,  9 May 2021 12:33:34 +0100
> > > Jonathan Cameron <jic23@kernel.org> escreveu:
> > >   
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > The call to pm_runtime_put_noidle() in remove() callback is not
> > > > balanced by any gets
> > > > 
> > > > Note this doesn't cause any problems beyond reader confusion as
> > > > the runtime
> > > > pm core protects against the reference counter going negative.
> > > > 
> > > > Whilst here, use pm_runtiem_resume_and_get() to simplify code a
> > > > little.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>    
> > > 
> > > RPM get/put logic LGTM.
> > > 
> > > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > After our side discussion on this one I wanted to take another look.
> > I'm not sure I follow the logic behind the runtime_enable() path
> > and why we don't want to enable runtime_pm until first use.  However
> > it's not directly related to this patch and as far as I can tell
> > it's just unsuual rather than broken.  As such, applied this one to
> > the
> > togreg branch of iio.git and pushed out as testing.
> >   
> 
> This was enabled in init path but caused issue with USB sensor hub in
> Thinkpasd Yoga S1, where we can never power off sensor and it wakes up
> device immediately after suspend.
> 
> commit
> ad7532cefd11d11a0814a75fb814c205ee3d9d4c

Ah.  Thanks for the history.  Thanks makes a horrible kind of sense ;)

Jonathan

> 
> 
> Thanks,
> Srinivas
> 
> > Thanks,
> > 
> > Jonathan
> >   
> > >   
> > > > ---
> > > >  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > index 5a7b3e253e58..c06537e106e9 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > @@ -163,18 +163,15 @@ int hid_sensor_power_state(struct
> > > > hid_sensor_common *st, bool state)
> > > >  
> > > >         if (state) {
> > > >                 atomic_inc(&st->user_requested_state);
> > > > -               ret = pm_runtime_get_sync(&st->pdev->dev);
> > > > +               ret = pm_runtime_resume_and_get(&st->pdev->dev);
> > > >         } else {
> > > >                 atomic_dec(&st->user_requested_state);
> > > >                 pm_runtime_mark_last_busy(&st->pdev->dev);
> > > >                 pm_runtime_use_autosuspend(&st->pdev->dev);
> > > >                 ret = pm_runtime_put_autosuspend(&st->pdev->dev);
> > > >         }
> > > > -       if (ret < 0) {
> > > > -               if (state)
> > > > -                       pm_runtime_put_noidle(&st->pdev->dev);
> > > > +       if (ret < 0)
> > > >                 return ret;
> > > > -       }
> > > >  
> > > >         return 0;
> > > >  #else
> > > > @@ -222,7 +219,6 @@ void hid_sensor_remove_trigger(struct iio_dev
> > > > *indio_dev,
> > > >                 pm_runtime_disable(&attrb->pdev->dev);
> > > >  
> > > >         pm_runtime_set_suspended(&attrb->pdev->dev);
> > > > -       pm_runtime_put_noidle(&attrb->pdev->dev);
> > > >  
> > > >         cancel_work_sync(&attrb->work);
> > > >         iio_trigger_unregister(attrb->trigger);    
> > > 
> > > 
> > > 
> > > Thanks,
> > > Mauro  
> >   
> 
> 

