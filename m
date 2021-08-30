Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717D3FB6C9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhH3NQK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:16:10 -0400
Received: from first.geanix.com ([116.203.34.67]:37284 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhH3NQH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:16:07 -0400
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 38522440FC2;
        Mon, 30 Aug 2021 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630329311; bh=dmrLyBkUDoouiLjrV8agMtXDwekG7X0ugewbjWGOThE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=f5hjGcf15eSWhTQUvRHWjIvWJ1vuJcULARwqSQWRh7ExRN0Y2Uz5JajQAMjYJwI81
         CJqzpuyNsnV+FP/HdrCFXdHLkexVCzjH3rqutz21yUmLtkhuzICh0DZ+a2s6MA/x9m
         i2SEOVTFMhHvn09dImb2q+Tz+qhmuCHq7wntU2to8cVXxOTXZR4nC9QxorogZ8vZ32
         J78tA8SBN6EbdyNfrWuy1ajbAhOo6Z1tarl9bETZ2RFl/frfPIVKUC3mxW0TMUQRlt
         d1IToaBFSQu5wy254ASHlTpKdc4h9HK8IM/nrL1P0h4ACpHZcauQdoExSHIptmd4ES
         KPlxpH/TzB75A==
Date:   Mon, 30 Aug 2021 15:15:09 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: add threshold event
 handling
Message-ID: <20210830131509.jf4uasdmbvdzti6h@skn-laptop>
References: <20210830081032.267891-1-sean@geanix.com>
 <20210830104835.4a413386@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210830104835.4a413386@jic23-huawei>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 10:48:35AM +0100, Jonathan Cameron wrote:
> On Mon, 30 Aug 2021 10:10:31 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > Add event channels that control the creation of motion events.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> Hi Sean,
> 
> This seems to be hammering a pair of independent limits into use as
> a magnitude event.  Whilst that is what many accelerometers support,
> this particular one seems to have separate thresholds for the negative vs
> positive and we should look to support that.  Note that it's not uncommon
> to have separate thresholds, but only one enable - just register three event
> specs, one with the enable and DIR_EITHER and one for each of the directions
> with just the value setting.

Ok, will do :)

> 
> If there is a strong usecase for a magnitude threshold then we should
> discuss whether 'emulating' that is a job for userspace or kernel.

No specific usecase, we have another variant of our board with an ism330dlc. Just
wanted have it look like that from a userspace perspective.

> 
> Various related comments inline.
> 
> Thanks,
> 
> Jonathan
> 

[...]

> >  
> > +static int __fxls8962af_set_thresholds(struct fxls8962af_data *data,
> > +				       const struct iio_chan_spec *chan,
> > +				       int val)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Add the same value to the lower-threshold register with a reversed sign
> > +	 * in 2-complement 12 bit format.
> > +	 */
> > +	data->lower_thres = -val & GENMASK(11, 0);
> > +	data->upper_thres = val & GENMASK(10, 0);
> 
> As mentioned above, this is hammering a non magnitude threshold setup into one
> that looks like a magnitude. I'd like to understand more on why you are doing this.
> 
> > +
> > +	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
> > +				&data->lower_thres, chan->scan_type.storagebits / 8);
> 
> Don't use storegebits because it's not immediately obvious that the threshold will
> have the same bitdepth as the channel read back (it's not the case for some other
> devices).  So use sizeof(data->lower_thres) instead.

Good point...

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> > +				&data->upper_thres, chan->scan_type.storagebits / 8);
> > +
> > +	return ret;
> > +}
> > +
> > +static int fxls8962af_read_event(struct iio_dev *indio_dev,
> > +				 const struct iio_chan_spec *chan,
> > +				 enum iio_event_type type,
> > +				 enum iio_event_direction dir,
> > +				 enum iio_event_info info,
> > +				 int *val, int *val2)
> > +{
> > +	struct fxls8962af_data *data = iio_priv(indio_dev);
> > +	u16 raw_val;
> > +	int ret;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Read only upper-threshold register as the lower-threshold register have the
> > +	 * same value with reversed sign.
> > +	 */
> > +	ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> > +			       &raw_val, chan->scan_type.storagebits / 8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = sign_extend32(raw_val, chan->scan_type.realbits - 1);
> > +	*val2 = 0;
> 
> The core won't use val2, with a return value of IIO_VAL_INT, so you can skip
> setting it unless you are feeling very paranoid or some checker is warning
> about it due to the checkers limited visibility.

Removing val2.

> 

[...]

> > +
> > +static int
> > +fxls8962af_read_event_config(struct iio_dev *indio_dev,
> > +			     const struct iio_chan_spec *chan,
> > +			     enum iio_event_type type,
> > +			     enum iio_event_direction dir)
> > +{
> > +	struct fxls8962af_data *data = iio_priv(indio_dev);
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		return FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;
> 
> I would force these to be 1/0. The IIO core doesn't sanitise these values currently
> (it's something we should perhaps think about, though I don't fancy auditing all the
> users to check no one is doing anything strange through this interface).
> 

So something like?
		return !!(FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event);

> > +	case IIO_MOD_Y:
> > +		return FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
> > +	case IIO_MOD_Z:
> > +		return FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int
> > +fxls8962af_write_event_config(struct iio_dev *indio_dev,
> > +			      const struct iio_chan_spec *chan,
> > +			      enum iio_event_type type,
> > +			      enum iio_event_direction dir, int state)
> > +{
> > +	struct fxls8962af_data *data = iio_priv(indio_dev);
> > +	u8 enable_event, enable_bits;
> > +	int ret;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	fxls8962af_standby(data);
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		enable_bits = FXLS8962AF_SDCD_CONFIG1_X_OT_EN;
> > +		break;
> > +	case IIO_MOD_Y:
> > +		enable_bits = FXLS8962AF_SDCD_CONFIG1_Y_OT_EN;
> > +		break;
> > +	case IIO_MOD_Z:
> > +		enable_bits = FXLS8962AF_SDCD_CONFIG1_Z_OT_EN;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (state)
> > +		enable_event = data->enable_event | enable_bits;
> > +	else
> > +		enable_event = data->enable_event & ~enable_bits;
> > +
> > +	if (data->enable_event == enable_event)
> 
> You have put the device into standby. I'm fairly sure you need to come
> out of that if this is a noop.   I'd suggest just moving the standby() call
> until the point where you know you are going to make a change (so after this).
> 

Good catch, will move _standby() down here.

> > +		return 0;
> > +
> > +	/* Enable events */
> > +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, enable_event | 0x80);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Enable update of SDCD_REF_X/Y/Z values with the current decimated and
> > +	 * trimmed X/Y/Z acceleration input data. This allows for acceleration
> > +	 * slope detection with Data(n) to Data(n–1) always used as the input
> > +	 * to the window comparator.
> 
> This sounds like a ROC detector... If true the current description is wrong as you
> need to use the IIO_EV_TYPE_ROC for that sort of event.  Ideally also add the
> absolute magnitude version, or at least clearly document that it is not currently
> supported by the driver.

What is a ROC event? Right now it works like the event in ism330dlc...

Where do you suggest the comment should be? Beside the event creation
structs?

> 
> The datasheet isn't exactly friendly for working this stuff out. *sigh*

No it's not the best :/

> 
> Whilst here, also looks like there is also a convenient vector magnitude option.  Would be
> good to support that.

So support:
 - absolute magnitude
 - convenient vector magnitude
 - slope detection?

> 
> Also break that c up into the two parts that it contains (enable and REF_UPDM value) with suitable
> definitions for the various options of REF_UPDM.

Will do :)

> 
> 
> > +	 */
> > +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event ? 0xc0 : 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fxls8962af_event_setup(data, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->enable_event = enable_event;
> > +
> > +	if (data->enable_event) {
> > +		fxls8962af_active(data);
> > +		ret = fxls8962af_power_on(data);
> > +	} else {
> > +		if (!iio_buffer_enabled(indio_dev))
> 
> This can (I think) race with buffer enabling.  To avoid that, whilst doing this check
> do a claim_direct_mode() and release it after turning the power off.  That will
> ensure consistency.  There is a nasty corner case though if another function is
> doing a claim_direct_mode() say due to a concurrent userspace access.  In that case
> this one will fail, but the buffer is not enabled and hence we won't power down.
> 
> Hmm.  Looking at what this power_off() is doing and the fact it's using runtime_pm,
> you should be able to rely on the runtime_pm reference counting and not need this check.
> In fact the presence of the power_on above without an iio_buffer_enabled() check
> suggests to me this is currently unbalanced and you can end up with the power stuck
> on permanently.  

Will try to add this and verify the functionality.

> 
> The fact we even have separate config and value callbacks is a historical bit of mess
> it would be nice to clean up one day (but is quite a way down the todo list!)
> 
> > +			ret = fxls8962af_power_off(data);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_event_spec fxls8962af_event = {
> > +	.type = IIO_EV_TYPE_THRESH,
> > +	.dir = IIO_EV_DIR_EITHER,
> > +	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> 
> I'm missing something here. The thresholds seem to be independent...

Sorry, I do not understand this. The event can be enabled per axis', but
the threshold is common for all axis'.

> 
> > +};
> > +
> >  #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
> >  	.type = IIO_ACCEL, \
> >  	.address = reg, \
> > @@ -481,6 +690,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
> >  		.shift = 4, \
> >  		.endianness = IIO_BE, \
> >  	}, \
> > +	.event_spec = &fxls8962af_event, \
> > +	.num_event_specs = 1, \
> >  }
> >  

[...]

> > +static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
> > +{
> > +	struct fxls8962af_data *data = iio_priv(indio_dev);
> > +	s64 ts = iio_get_time_ns(indio_dev);
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT)
> > +		iio_push_event(indio_dev,
> > +				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
> > +					IIO_EV_TYPE_THRESH,
> > +					IIO_EV_DIR_EITHER),
> 
> I was a bit surprised to see DIR_EITHER here so went looking at the datasheet.
> Seems to me that we have X_OT_POL that lets us know which threshold was passed.
> Can we use that here to give a more specific event?
> 

Yes will add.

Thank you for the review and comments Jonathan.

Br,
/Sean
