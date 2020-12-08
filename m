Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717FF2D28F9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLHKcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 05:32:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2219 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHKcm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 05:32:42 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqxHn58Hxz67N0l;
        Tue,  8 Dec 2020 18:29:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 11:31:59 +0100
Received: from localhost (10.47.68.59) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 8 Dec 2020
 10:31:59 +0000
Date:   Tue, 8 Dec 2020 10:31:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Message-ID: <20201208103135.00004496@Huawei.com>
In-Reply-To: <20201207171111.GC292338@lore-desk>
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
        <AM8PR10MB4209021B3239B1CE06D2824DEDF20@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
        <20201205151121.70d31d71@archlinux>
        <20201207171111.GC292338@lore-desk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.59]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Dec 2020 18:11:11 +0100
"lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com> wrote:

> > On Thu, 3 Dec 2020 04:06:44 +0000
> > Denis CIOCCA <denis.ciocca@st.com> wrote:
> >   
> > > Hi Jonathan, Lorenzo,
> > > 
> > > I am not able to test it right now, I can probably do this weekend.
> > > My comments inline.
> > > 
> > >   
> > > > -----Original Message-----
> > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Sent: Sunday, November 15, 2020 6:38 AM
> > > > To: jic23@kernel.org
> > > > Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org;
> > > > linus.walleij@linaro.org; Denis CIOCCA <denis.ciocca@st.com>
> > > > Subject: [PATCH] iio: common: st_sensors: fix possible infinite loop in
> > > > st_sensors_irq_thread
> > > > 
> > > > Return a boolean value in st_sensors_new_samples_available routine in
> > > > order to avoid an infinite loop in st_sensors_irq_thread if stat_drdy.addr is
> > > > not defined or stat_drdy read fails
> > > > 
> > > > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > > > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > This patch is just compile tested, I have not carried out any run test
> > > > ---
> > > >  .../common/st_sensors/st_sensors_trigger.c    | 20 ++++++++-----------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > >   
> 
> [...]
> 
> > > 
> > > To me this should return true. When a sensor does not specify the address (because there is no such register ie) the interrupt should be considered a valid interrupt.
> > > In the original code from Linus indeed the if condition that is using this function is checking && -EINVAL that is considered true.  
> > 
> > Good point!
> > 
> > Ah, so we have an issue here because the function is called in two different
> > circumstances.  For the initial test of whether there is a sample I absolutely
> > agree with you, we need to say there is even if we can't check a status register.
> > 
> > In the second case however, we would end up in an infinite loop if there is no
> > status register.
> > 
> > 
> > So the function is..
> > 
> > static irqreturn_t st_sensors_irq_thread(int irq, void *p)
> > {
> > 	struct iio_trigger *trig = p;
> > 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > 	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > 
> > 	/*
> > 	 * If this trigger is backed by a hardware interrupt and we have a
> > 	 * status register, check if this IRQ came from us. Notice that
> > 	 * we will process also if st_sensors_new_samples_available()
> > 	 * returns negative: if we can't check status, then poll
> > 	 * unconditionally.
> > 	 */
> > //CASE 1: Trigger if we don't have a status register.
> > 	if (sdata->hw_irq_trigger &&
> > 	    st_sensors_new_samples_available(indio_dev, sdata)) {
> > 		iio_trigger_poll_chained(p);
> > 	} else {
> > 		dev_dbg(sdata->dev, "spurious IRQ\n");
> > 		return IRQ_NONE;
> > 	}
> > 
> > 	/*
> > 	 * If we have proper level IRQs the handler will be re-entered if
> > 	 * the line is still active, so return here and come back in through
> > 	 * the top half if need be.
> > 	 */
> > 	if (!sdata->edge_irq)
> > 		return IRQ_HANDLED;
> > 
> > 	/*
> > 	 * If we are using edge IRQs, new samples arrived while processing
> > 	 * the IRQ and those may be missed unless we pick them here, so poll
> > 	 * again. If the sensor delivery frequency is very high, this thread
> > 	 * turns into a polled loop handler.
> > 	 */
> > //Case 2, don't trigger.  
> > 
> > 	while (sdata->hw_irq_trigger &&
> > 	       st_sensors_new_samples_available(indio_dev, sdata)) {
> > 		dev_dbg(sdata->dev, "more samples came in during polling\n");
> > 		sdata->hw_timestamp = iio_get_time_ns(indio_dev);
> > 		iio_trigger_poll_chained(p);
> > 	}
> > 
> > 	return IRQ_HANDLED;
> > }
> > 
> > I think the reality is we can't safely support edge interrupts unless there is
> > a status register as we will always be prone to the race conditions.
> > 
> > As to a solution, I would suggest we make the status register existence
> > check separate from it's use.  That way we can always poll in case 1 and
> > never poll in case 2 if we don't have a status register.
> > 
> > To prevent the edge based interrupt without a status register case could
> > be done in various ways. Probably easiest is to check it at time of
> > interrupt registration and refuse to probe if we can't handle it.  
> 
> ack, right. So what about applying patch v2 and add another patch to return an
> error if edge interrupt is requested and we do not have status reg? Something
> like:
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index d3f047e9d778..2bff3350b498 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -176,9 +176,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  
>  	/* Tell the interrupt handler that we're dealing with edges */
>  	if (irq_trig == IRQF_TRIGGER_FALLING ||
> -	    irq_trig == IRQF_TRIGGER_RISING)
> +	    irq_trig == IRQF_TRIGGER_RISING) {
> +		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> +			return -ENOTSUPP;
> +
>  		sdata->edge_irq = true;
> -	else
> +	} else {
>  		/*
>  		 * If we're not using edges (i.e. level interrupts) we
>  		 * just mask off the IRQ, handle one interrupt, then
> @@ -186,6 +189,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  		 * interrupt handler top half again and start over.
>  		 */
>  		irq_trig |= IRQF_ONESHOT;
> +	}
>  
>  	/*
>  	 * If the interrupt pin is Open Drain, by definition this
> 
> Do you prefer to add it in the same patch?

I don't really mind.  Either needs to be before the other patch or
in the same one.  They are both part of the same fix, but kind of
separate aspects of it.

Jonathan


> 
> Regards,
> Lorenzo
> 
> > 
> > Jonathan
> >   
> > >   
> > > > 
> > > >  	/* No scan mask, no interrupt */
> > > >  	if (!indio_dev->active_scan_mask)
> > > > -		return 0;
> > > > +		return false;
> > > > 
> > > >  	ret = regmap_read(sdata->regmap,
> > > >  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> > > >  			  &status);
> > > >  	if (ret < 0) {
> > > >  		dev_err(sdata->dev, "error checking samples available\n");
> > > > -		return ret;
> > > > +		return false;    
> > > 
> > > This part indeed is probably the one that before could cause problems because in case of failure -something returned it is considered true.
> > > 
> > >   
> > > >  	}
> > > > 
> > > > -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > > > -		return 1;
> > > > -
> > > > -	return 0;
> > > > +	return !!(status & sdata->sensor_settings-    
> > > > >drdy_irq.stat_drdy.mask);    
> > > >  }
> > > > 
> > > >  /**
> > > > --
> > > > 2.26.2    
> > >   
> >   
> 

