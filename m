Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90580481DA8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhL3PWe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 30 Dec 2021 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhL3PWd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 10:22:33 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76069C061574;
        Thu, 30 Dec 2021 07:22:33 -0800 (PST)
Received: from [81.101.6.87] (port=57032 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2xGB-0005aB-Bi; Thu, 30 Dec 2021 15:22:31 +0000
Date:   Thu, 30 Dec 2021 15:28:16 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/3] iio: dac: add support for ltc2688
Message-ID: <20211230152816.56d4abed@jic23-huawei>
In-Reply-To: <PH0PR03MB67867E372410B3C707FE9F2999789@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-2-nuno.sa@analog.com>
        <20211216141110.0a4dc0c3@jic23-huawei>
        <PH0PR03MB67867E372410B3C707FE9F2999789@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Dec 2021 12:31:57 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> > Sent: Thursday, December 16, 2021 3:11 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; Rob
> > Herring <robh+dt@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH 1/3] iio: dac: add support for ltc2688
> > 
> > [External]
> > 
> > On Tue, 14 Dec 2021 17:56:06 +0100
> > Nuno Sá <nuno.sa@analog.com> wrote:
> >   
> > > The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> > > precision reference. It is guaranteed monotonic and has built in
> > > rail-to-rail output buffers that can source or sink up to 20 mA.
> > >
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>  
> > 
> > I'm not that keen on toggle having to be clock driven, but I guess we
> > can
> > always change that later when usecases come along.
> >   
> 
> I did wrote about some concerns with toggle (among others) in the cover.
> When you have the time, some feedback in there would be very welcome :).

Doh.  Guess I didn't look at the cover letter. Now replied to that as well.

> 
> Anyways, for toggle mode, I do agree that "has to be clock driven" is likely to harsh.
> Right now if a toggle channel is associated with a TGPx pin, then a clock is 
> mandatory and that's the condition that probably should be made optional.
> Someone can very well want to drive the outputs with a GPIO even though
> in that case we could argue to use the SW_TOGGLE.

I wonder if we also need the case where the toggle source is invisible to us
as it's the output of some other hardware.  Obviously would be nice to model
that hardware in DT but that might not always be possible.


> > > +
> > > +static int ltc2688_read_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan, int *val,
> > > +			    int *val2, long m)
> > > +{
> > > +	struct ltc2688_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (m) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = ltc2688_dac_code_read(st, chan->channel,  
> > LT2688_INPUT_A,  
> > > +					    val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		return ltc2688_offset_get(st, chan->channel, val);
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val2 = 16;
> > > +		return ltc2688_scale_get(st, chan->channel, val);  
> > 
> > I'm not against functions returning the IIO_VAL_* like this, but if they
> > are I expect the function to set val2 as well.
> > 
> > I'd suggest return 0 on success and then do similar to what you have
> > done for code_read above.  
> 
> Typically I do like to save lines of code when doable and readability is
> not hurt which is the case. I'm not doing the same for the code_read
> because that one is also used from the extended_info interface. That
> said, I don't have strong feeling about this so I can do as you suggest.

Either option is fine for me.  Set val2 inside _scale_get() or return 0
from that and then do a return IIO_VAL_INT_PLUS_MICRO here.

The particular combination at the moment is rather inconsistent as
val, val2 and the return value should all come from the same 'source'
whether it's here, or in _scale_get()

> 
> > > +	case IIO_CHAN_INFO_CALIBBIAS:
> > > +		ret = regmap_read(st->regmap,
> > > +				  LTC2688_CMD_CH_OFFSET(chan-
> > >channel), val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		/* Just 13 bits used. 2LSB ignored */
> > > +		*val >>= 2;  
> > FIELD_GET() would get rid of need for the comment.
> >   
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_CALIBSCALE:
> > > +		ret = regmap_read(st->regmap,
> > > +				  LTC2688_CMD_CH_GAIN(chan-
> > >channel), val);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		return IIO_VAL_INT;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}  

...

> > > +
> > > +static const char * const ltc2688_dither_phase[] = {
> > > +	"0", "90", "180", "270",
> > > +};
> > > +
> > > +static const struct iio_enum ltc2688_dither_phase_enum = {
> > > +	.items = ltc2688_dither_phase,
> > > +	.num_items = ARRAY_SIZE(ltc2688_dither_phase),
> > > +	.set = ltc2688_set_dither_phase,
> > > +	.get = ltc2688_get_dither_phase,
> > > +};
> > > +
> > > +#define LTC2688_CHAN_EXT_INFO(_name, _what, _shared) {	\
> > > +	.name = _name,					\
> > > +	.read = ltc2688_read_ext,			\
> > > +	.write = ltc2688_write_ext,			\  
> > 
> > I'm not really convinced big multiplexer functions are a good idea here.
> > They seem to save little code and hurt readability a bit.  
> 
> I think this is a very common pattern seen in IIO and probably HWMON no?
> Anyways, I'm ok with either way so I can just extend the macro to accept
> the individual functions. I have to admit that in some cases (when locking is
> required in some case blocks) I'm also not a big fan of these multiplexes
> functions. And I think I'm calling individual functions in all the case blocks
> anyways...

Common pattern, but not always a good idea.  All depends on how much
common code there is.  In this case I don't think there is enough for it
to make sense.

>   
> > > +	.private = (_what),				\
> > > +	.shared = (_shared),				\
> > > +}
> > > +

...

> > > +	 */
> > > +	LTC2688_CHAN_EXT_INFO("dither_frequency",  
> > LTC2688_DITHER_FREQ,  
> > > +			      IIO_SEPARATE),
> > > +	LTC2688_CHAN_EXT_INFO("dither_frequency_available",
> > > +			      LTC2688_DITHER_FREQ_AVAIL,  
> > IIO_SEPARATE),  
> > > +	IIO_ENUM("dither_phase", IIO_SEPARATE,  
> > &ltc2688_dither_phase_enum),  
> > > +	IIO_ENUM_AVAILABLE("dither_phase", IIO_SEPARATE,
> > > +			   &ltc2688_dither_phase_enum),
> > > +	LTC2688_CHAN_EXT_INFO("dither_en",  
> > LTC2688_DITHER_TOGGLE_ENABLE,  
> > > +			      IIO_SEPARATE),
> > > +	LTC2688_CHAN_EXT_INFO("powerdown",  
> > LTC2688_POWERDOWN, IIO_SEPARATE),  
> > > +	{}
> > > +};
> > > +
> > > +static const struct iio_chan_spec_ext_info ltc2688_ext_info[] = {
> > > +	LTC2688_CHAN_EXT_INFO("powerdown",  
> > LTC2688_POWERDOWN, IIO_SEPARATE),  
> > > +	{}
> > > +};
> > > +  
> >   
> > > +
> > > +enum {
> > > +	LTC2688_CHAN_TD_TGP1,
> > > +	LTC2688_CHAN_TD_TGP2,
> > > +	LTC2688_CHAN_TD_TGP3,
> > > +	LTC2688_CHAN_TD_MAX
> > > +};  
> >   
> > > +/* Helper struct to deal with dither channels binded to TGPx pins */
> > > +struct ltc2688_dither_helper {
> > > +	u8 chan[LTC2688_DAC_CHANNELS];
> > > +	u8 n_chans;
> > > +};
> > > +  
> > bitmap perhaps given ordering doesn't matter (I think)
> >   
> 
> Yeah, did not thought about it but I think it will look better with a bitmap yes.
> Although I'm not sure if I will continue with this approach or make the clocks
> property a per channel one (more on this in the cover letter).

I'm not sure how the per channel version will look so leaving this entirely
up to you!

> > 
> > ...
> >   
> > > +
> > > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > > +{
> > > +	struct fwnode_handle *fwnode = dev_fwnode(&st->spi-
> > >dev), *child;
> > > +	struct ltc2688_dither_helper tgp[LTC2688_CHAN_TD_MAX] =  
> > {0};  
> > > +	u32 reg, clk_input, val, mask, tmp[2];
> > > +	unsigned long clk_msk = 0;
> > > +	int ret, span;
> > > +  
> > 
> > I think you need to sanity check you have a fwnode  
> 
> AFAICT, it's done by us already :)
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L741

Ah.  Good point. Ignore that one then.

> 
> > > +	fwnode_for_each_available_child_node(fwnode, child) {  
> > 
> > I guess this is because of the whole
> > device_for_each_available_child_node() not
> > existing discussion that isn't resolved.  
> 
> exactly... I wanted the available option and this was the only way I
> could find...
> 

Hmm. I need to revisit that discussion and see where we got to.

> >   
> > > +static bool ltc2688_reg_writable(struct device *dev, unsigned int  
> > reg)  
> > > +{
> > > +	if (reg <= LTC2688_CMD_UPDATE_ALL && reg !=  
> > LTC2688_CMD_THERMAL_STAT)
> > 
> > Isn't UPDATE_ALL the last register?  So how do you get higher than
> > that?
> > Definitely needs a comment if there is a reason that check is
> > necessary.  
> 
> If you look at the commands table you see that on the write side
> we jump from 0x76 to 0x78 (UPDATE_ALL=0x7c). 0x77 refers to
> reading the thermal status reg which is not writable. Actually in the
> end, as it's a read the command for reading the thermal status will
> be 0xf7.

I'm lost on this.   My confusion is how you get > LTC2688_CMD_UPDATE_ALL
Possibly that's what you are referring to with teh read command being 0xf...
Maybe try to distil this info down to a brief comment for next
version?

> 
> > > +		return true;
> > > +
> > > +	return false;
> > > +}

Thanks,

Jonathan

