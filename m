Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742C3FB8A0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhH3PAK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Aug 2021 11:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237250AbhH3PAJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 11:00:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17D960E90;
        Mon, 30 Aug 2021 14:59:14 +0000 (UTC)
Date:   Mon, 30 Aug 2021 16:02:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: add threshold event
 handling
Message-ID: <20210830160225.704b0625@jic23-huawei>
In-Reply-To: <20210830131509.jf4uasdmbvdzti6h@skn-laptop>
References: <20210830081032.267891-1-sean@geanix.com>
        <20210830104835.4a413386@jic23-huawei>
        <20210830131509.jf4uasdmbvdzti6h@skn-laptop>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > > +		return FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;  
> > 
> > I would force these to be 1/0. The IIO core doesn't sanitise these values currently
> > (it's something we should perhaps think about, though I don't fancy auditing all the
> > users to check no one is doing anything strange through this interface).
> >   
> 
> So something like?
> 		return !!(FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event);

yup. That does the job.

> 
> > > +	case IIO_MOD_Y:
> > > +		return FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
> > > +	case IIO_MOD_Z:
> > > +		return FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +

> 
> > > +		return 0;
> > > +
> > > +	/* Enable events */
> > > +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, enable_event | 0x80);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * Enable update of SDCD_REF_X/Y/Z values with the current decimated and
> > > +	 * trimmed X/Y/Z acceleration input data. This allows for acceleration
> > > +	 * slope detection with Data(n) to Data(n–1) always used as the input
> > > +	 * to the window comparator.  
> > 
> > This sounds like a ROC detector... If true the current description is wrong as you
> > need to use the IIO_EV_TYPE_ROC for that sort of event.  Ideally also add the
> > absolute magnitude version, or at least clearly document that it is not currently
> > supported by the driver.  
> 
> What is a ROC event? Right now it works like the event in ism330dlc...

Rate of Change.

Hmm. We don't get these very often so I couldn't remember what the docs said wrt
to units.  Seems it is rather vague which isn't great.
See Documentation/ABI/testing/sysfs-bus-iio and grep for roc_

Mind you this is getting close to the adaptive thresholds where pretty much anything
goes :)


> 
> Where do you suggest the comment should be? Beside the event creation
> structs?

That would work.  Just somewhere anyone wondering why it doesn't do what they want
would find it.

> 
> > 
> > The datasheet isn't exactly friendly for working this stuff out. *sigh*  
> 
> No it's not the best :/
> 
> > 
> > Whilst here, also looks like there is also a convenient vector magnitude option.  Would be
> > good to support that.  
> 
> So support:
>  - absolute magnitude

This one isn't quite true as I read it.  Not sure how you would use the positive and negatives differently
though...

>  - convenient vector magnitude
>  - slope detection?

Could also (I think) do the in window interrupt as a falling magnitude. 
Those tend to be used as freefall detectors which is always fun to test :)

> 
> > 
> > Also break that c up into the two parts that it contains (enable and REF_UPDM value) with suitable
> > definitions for the various options of REF_UPDM.  
> 
> Will do :)
> 
> > 
> >   
> > > +	 */
> > > +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event ? 0xc0 : 0x00);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = fxls8962af_event_setup(data, state);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	data->enable_event = enable_event;
> > > +
> > > +	if (data->enable_event) {
> > > +		fxls8962af_active(data);
> > > +		ret = fxls8962af_power_on(data);
> > > +	} else {
> > > +		if (!iio_buffer_enabled(indio_dev))  
> > 
> > This can (I think) race with buffer enabling.  To avoid that, whilst doing this check
> > do a claim_direct_mode() and release it after turning the power off.  That will
> > ensure consistency.  There is a nasty corner case though if another function is
> > doing a claim_direct_mode() say due to a concurrent userspace access.  In that case
> > this one will fail, but the buffer is not enabled and hence we won't power down.
> > 
> > Hmm.  Looking at what this power_off() is doing and the fact it's using runtime_pm,
> > you should be able to rely on the runtime_pm reference counting and not need this check.
> > In fact the presence of the power_on above without an iio_buffer_enabled() check
> > suggests to me this is currently unbalanced and you can end up with the power stuck
> > on permanently.    
> 
> Will try to add this and verify the functionality.
> 
> > 
> > The fact we even have separate config and value callbacks is a historical bit of mess
> > it would be nice to clean up one day (but is quite a way down the todo list!)
> >   
> > > +			ret = fxls8962af_power_off(data);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct iio_event_spec fxls8962af_event = {
> > > +	.type = IIO_EV_TYPE_THRESH,
> > > +	.dir = IIO_EV_DIR_EITHER,
> > > +	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),  
> > 
> > I'm missing something here. The thresholds seem to be independent...  
> 
> Sorry, I do not understand this. The event can be enabled per axis', but
> the threshold is common for all axis'.

this was mostly me figuring out that there were separate upper and lower thresholds.
So the enable is DIR_EITHER but the values are not.

> 
> >   
> > > +};
> > > +
> > >  #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
> > >  	.type = IIO_ACCEL, \
> > >  	.address = reg, \
> > > @@ -481,6 +690,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
> > >  		.shift = 4, \
> > >  		.endianness = IIO_BE, \
> > >  	}, \
> > > +	.event_spec = &fxls8962af_event, \
> > > +	.num_event_specs = 1, \
> > >  }
> > >    
> 
> [...]
> 
> > > +static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
> > > +{
> > > +	struct fxls8962af_data *data = iio_priv(indio_dev);
> > > +	s64 ts = iio_get_time_ns(indio_dev);
> > > +	unsigned int reg;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT)
> > > +		iio_push_event(indio_dev,
> > > +				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
> > > +					IIO_EV_TYPE_THRESH,
> > > +					IIO_EV_DIR_EITHER),  
> > 
> > I was a bit surprised to see DIR_EITHER here so went looking at the datasheet.
> > Seems to me that we have X_OT_POL that lets us know which threshold was passed.
> > Can we use that here to give a more specific event?
> >   
> 
> Yes will add.
> 
> Thank you for the review and comments Jonathan.
You are welcome.

J

> 
> Br,
> /Sean

