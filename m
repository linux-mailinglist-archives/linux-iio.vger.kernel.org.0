Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F782CFBC0
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgLEPZB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 10:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgLEPM7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 10:12:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A361E2224C;
        Sat,  5 Dec 2020 15:11:24 +0000 (UTC)
Date:   Sat, 5 Dec 2020 15:11:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: common: st_sensors: fix possible infinite loop in
 st_sensors_irq_thread
Message-ID: <20201205151121.70d31d71@archlinux>
In-Reply-To: <AM8PR10MB4209021B3239B1CE06D2824DEDF20@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
References: <3b8dc467b30dd6869ea60ed583cad750c74eb44e.1605450804.git.lorenzo@kernel.org>
        <AM8PR10MB4209021B3239B1CE06D2824DEDF20@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Dec 2020 04:06:44 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Hi Jonathan, Lorenzo,
> 
> I am not able to test it right now, I can probably do this weekend.
> My comments inline.
> 
> 
> > -----Original Message-----
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Sent: Sunday, November 15, 2020 6:38 AM
> > To: jic23@kernel.org
> > Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org;
> > linus.walleij@linaro.org; Denis CIOCCA <denis.ciocca@st.com>
> > Subject: [PATCH] iio: common: st_sensors: fix possible infinite loop in
> > st_sensors_irq_thread
> > 
> > Return a boolean value in st_sensors_new_samples_available routine in
> > order to avoid an infinite loop in st_sensors_irq_thread if stat_drdy.addr is
> > not defined or stat_drdy read fails
> > 
> > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > This patch is just compile tested, I have not carried out any run test
> > ---
> >  .../common/st_sensors/st_sensors_trigger.c    | 20 ++++++++-----------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > index 0507283bd4c1..3bee5c9255d4 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > @@ -23,35 +23,31 @@
> >   * @sdata: Sensor data.
> >   *
> >   * returns:
> > - * 0 - no new samples available
> > - * 1 - new samples available
> > - * negative - error or unknown
> > + * false - no new samples available or read error
> > + * true - new samples available
> >   */
> > -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > -					    struct st_sensor_data *sdata)
> > +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > +					     struct st_sensor_data *sdata)
> >  {
> >  	int ret, status;
> > 
> >  	/* How would I know if I can't check it? */
> >  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > -		return -EINVAL;
> > +		return false;  
> 
> To me this should return true. When a sensor does not specify the address (because there is no such register ie) the interrupt should be considered a valid interrupt.
> In the original code from Linus indeed the if condition that is using this function is checking && -EINVAL that is considered true.

Good point!

Ah, so we have an issue here because the function is called in two different
circumstances.  For the initial test of whether there is a sample I absolutely
agree with you, we need to say there is even if we can't check a status register.

In the second case however, we would end up in an infinite loop if there is no
status register.


So the function is..

static irqreturn_t st_sensors_irq_thread(int irq, void *p)
{
	struct iio_trigger *trig = p;
	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
	struct st_sensor_data *sdata = iio_priv(indio_dev);

	/*
	 * If this trigger is backed by a hardware interrupt and we have a
	 * status register, check if this IRQ came from us. Notice that
	 * we will process also if st_sensors_new_samples_available()
	 * returns negative: if we can't check status, then poll
	 * unconditionally.
	 */
//CASE 1: Trigger if we don't have a status register.
	if (sdata->hw_irq_trigger &&
	    st_sensors_new_samples_available(indio_dev, sdata)) {
		iio_trigger_poll_chained(p);
	} else {
		dev_dbg(sdata->dev, "spurious IRQ\n");
		return IRQ_NONE;
	}

	/*
	 * If we have proper level IRQs the handler will be re-entered if
	 * the line is still active, so return here and come back in through
	 * the top half if need be.
	 */
	if (!sdata->edge_irq)
		return IRQ_HANDLED;

	/*
	 * If we are using edge IRQs, new samples arrived while processing
	 * the IRQ and those may be missed unless we pick them here, so poll
	 * again. If the sensor delivery frequency is very high, this thread
	 * turns into a polled loop handler.
	 */
//Case 2, don't trigger.  

	while (sdata->hw_irq_trigger &&
	       st_sensors_new_samples_available(indio_dev, sdata)) {
		dev_dbg(sdata->dev, "more samples came in during polling\n");
		sdata->hw_timestamp = iio_get_time_ns(indio_dev);
		iio_trigger_poll_chained(p);
	}

	return IRQ_HANDLED;
}

I think the reality is we can't safely support edge interrupts unless there is
a status register as we will always be prone to the race conditions.

As to a solution, I would suggest we make the status register existence
check separate from it's use.  That way we can always poll in case 1 and
never poll in case 2 if we don't have a status register.

To prevent the edge based interrupt without a status register case could
be done in various ways. Probably easiest is to check it at time of
interrupt registration and refuse to probe if we can't handle it.

Jonathan

> 
> > 
> >  	/* No scan mask, no interrupt */
> >  	if (!indio_dev->active_scan_mask)
> > -		return 0;
> > +		return false;
> > 
> >  	ret = regmap_read(sdata->regmap,
> >  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> >  			  &status);
> >  	if (ret < 0) {
> >  		dev_err(sdata->dev, "error checking samples available\n");
> > -		return ret;
> > +		return false;  
> 
> This part indeed is probably the one that before could cause problems because in case of failure -something returned it is considered true.
> 
> 
> >  	}
> > 
> > -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > -		return 1;
> > -
> > -	return 0;
> > +	return !!(status & sdata->sensor_settings-  
> > >drdy_irq.stat_drdy.mask);  
> >  }
> > 
> >  /**
> > --
> > 2.26.2  
> 

