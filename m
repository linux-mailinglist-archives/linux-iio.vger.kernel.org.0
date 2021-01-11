Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4032F159A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 14:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbhAKNmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 08:42:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2304 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbhAKNMN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 08:12:13 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DDvCl2L9Gz67Zsk;
        Mon, 11 Jan 2021 21:08:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 11 Jan 2021 14:11:30 +0100
Received: from localhost (10.47.69.27) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 11 Jan
 2021 13:11:30 +0000
Date:   Mon, 11 Jan 2021 13:10:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop
 in st_sensors_irq_thread
Message-ID: <20210111131052.000031dc@Huawei.com>
In-Reply-To: <20210111082134.GA2258@lore-desk>
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
        <20201213150447.119eec7c@archlinux>
        <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
        <CAJ0CqmVJ9qMpLq-ZSVBFzQXSj3MNqeP5b4MjMpZh0b2H7mjXzg@mail.gmail.com>
        <20201230120850.6dd32cfc@archlinux>
        <20210111082134.GA2258@lore-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.69.27]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Jan 2021 09:21:34 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Tue, 22 Dec 2020 11:53:57 +0100
> > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> >   
> > > >    
> 
> [...]
> 
> > It's a very minor gamble, so I've applied it to the fixes-togreg branch of
> > iio.git.  Fingers crossed no one hits the corner case and has somehow been
> > getting away with it.
> > 
> > Thanks,  
> 
> Hi Jonathan,
> 
> I am not able to find this commit in your tree. Am I missing something?

oops. Now pushed out.

J

> 
> Regards,
> Lorenzo
> 
> > 
> > Jonathan
> >   
> > >   
> > > > Regards,
> > > > Lorenzo
> > > >    
> > > > >
> > > > > It's possible we would be better falling back to interrupt free support
> > > > > in that case rather than failing to probe at all.
> > > > > I think that would be best done by moving the check out to the
> > > > > various per type drivers so we fail in the same fashion as no irq
> > > > > provided + a warning.    
> > > >
> > > >    
> > > > >
> > > > > thanks,
> > > > >
> > > > > Jonathan
> > > > >
> > > > >    
> > > > > > ---
> > > > > > Changes since v2:
> > > > > > - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor does not support
> > > > > >   status register
> > > > > >
> > > > > > Changes since v1:
> > > > > > - return true if the sensor does not have stat_drdy register
> > > > > > ---
> > > > > >  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---------
> > > > > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > index 0507283bd4c1..2dbd2646e44e 100644
> > > > > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > @@ -23,35 +23,31 @@
> > > > > >   * @sdata: Sensor data.
> > > > > >   *
> > > > > >   * returns:
> > > > > > - * 0 - no new samples available
> > > > > > - * 1 - new samples available
> > > > > > - * negative - error or unknown
> > > > > > + * false - no new samples available or read error
> > > > > > + * true - new samples available
> > > > > >   */
> > > > > > -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > > > > -                                         struct st_sensor_data *sdata)
> > > > > > +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > > > > +                                          struct st_sensor_data *sdata)
> > > > > >  {
> > > > > >       int ret, status;
> > > > > >
> > > > > >       /* How would I know if I can't check it? */
> > > > > >       if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > > > > > -             return -EINVAL;
> > > > > > +             return true;
> > > > > >
> > > > > >       /* No scan mask, no interrupt */
> > > > > >       if (!indio_dev->active_scan_mask)
> > > > > > -             return 0;
> > > > > > +             return false;
> > > > > >
> > > > > >       ret = regmap_read(sdata->regmap,
> > > > > >                         sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> > > > > >                         &status);
> > > > > >       if (ret < 0) {
> > > > > >               dev_err(sdata->dev, "error checking samples available\n");
> > > > > > -             return ret;
> > > > > > +             return false;
> > > > > >       }
> > > > > >
> > > > > > -     if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > > > > > -             return 1;
> > > > > > -
> > > > > > -     return 0;
> > > > > > +     return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);    
> > > > >
> > > > > No need for the !! as you can rely on type conversion to a boolean.
> > > > >    
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > > > > >
> > > > > >       /* Tell the interrupt handler that we're dealing with edges */
> > > > > >       if (irq_trig == IRQF_TRIGGER_FALLING ||
> > > > > > -         irq_trig == IRQF_TRIGGER_RISING)
> > > > > > +         irq_trig == IRQF_TRIGGER_RISING) {
> > > > > > +             if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> > > > > > +                     dev_err(&indio_dev->dev,
> > > > > > +                             "edge IRQ not supported w/o stat register.\n");
> > > > > > +                     err = -EOPNOTSUPP;
> > > > > > +                     goto iio_trigger_free;
> > > > > > +             }
> > > > > >               sdata->edge_irq = true;
> > > > > > -     else
> > > > > > +     } else {
> > > > > >               /*
> > > > > >                * If we're not using edges (i.e. level interrupts) we
> > > > > >                * just mask off the IRQ, handle one interrupt, then
> > > > > > @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > > > > >                * interrupt handler top half again and start over.
> > > > > >                */
> > > > > >               irq_trig |= IRQF_ONESHOT;
> > > > > > +     }
> > > > > >
> > > > > >       /*
> > > > > >        * If the interrupt pin is Open Drain, by definition this    
> > > > >    
> > >   
> >   
> 

