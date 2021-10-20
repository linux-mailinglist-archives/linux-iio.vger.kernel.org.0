Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50C643511A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJTRWb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 13:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJTRWb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 13:22:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB5E610E7;
        Wed, 20 Oct 2021 17:20:14 +0000 (UTC)
Date:   Wed, 20 Oct 2021 18:24:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211020182431.6d3e1f1d@jic23-huawei>
In-Reply-To: <SJ0PR03MB5791E3C382232E22B41247D799BD9@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211008123909.1901-1-mihail.chindris@analog.com>
        <20211008123909.1901-3-mihail.chindris@analog.com>
        <20211010163715.3515a6d1@jic23-huawei>
        <SJ0PR03MB5791E3C382232E22B41247D799BD9@SJ0PR03MB5791.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Oct 2021 11:46:26 +0000
"Chindris, Mihail" <Mihail.Chindris@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, 10 October 2021 18:37
> > To: Chindris, Mihail <Mihail.Chindris@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; lars@metafoo.de;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> > alexandru.ardelean@analog.com
> > Subject: Re: [PATCH v2 2/2] drivers:iio:dac: Add AD3552R driver support
> > 
> > On Fri, 8 Oct 2021 12:39:09 +0000
> > Mihail Chindris <mihail.chindris@analog.com> wrote:
> >   
> > > The AD3552R-16 is a low drift ultrafast, 16-bit accuracy, current
> > > output digital-to-analog converter (DAC) designed to generate multiple
> > > output voltage span ranges.
> > > The AD3552R-16 operates with a fixed 2.5V reference.
> > >
> > > Datasheet:
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/ad
> > > 3552r.pdf
> > >
> > > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>  
> > 
> > Hi Mihail,
> > 
> > I would reduce the use of the attr and single function does everything approach
> > as that is significantly reducing readability.  Sometimes it's worth spending
> > extra lines of code to remove abstractions that end up with a lot of special
> > casing as is happening here.
> > 
> > Other comments inline.

If replying to only a small part, please crop. Cuts down on scrolling fun..

...

> > > +/*
> > > + * Channel used to update both CH0 and CH1 with the same value by
> > > + * writing only one register.  
> > 
> > Hmm. This is rather unusual use of the ABI.
> > In a similar fashion to us only guaranteeing 'simultaneous sampling'
> > when using buffered mode for input devices, I think we should map this only
> > being possible if in buffered output mode.
> > 
> > Then this is only useful to either minimise access or when the hardware 'go'
> > signal isn't wired up.  So I'd suggest that path does a check for the same value
> > being written to both channels and uses this if appropriate.
> >   
> > > + */
> > > +#define AD3552R_CH_DAC_PAGE(_idx) ((struct iio_chan_spec) {	\
> > > +	.type = IIO_VOLTAGE,					\
> > > +	.output = true,						\
> > > +	.indexed = true,					\
> > > +	.channel = _idx,					\
> > > +	.scan_index = _idx,					\
> > > +	.scan_type = {						\
> > > +		.sign = 'u',					\
> > > +		.realbits = 16,					\
> > > +		.storagebits = 16,				\
> > > +		.endianness = IIO_BE,				\
> > > +	},							\
> > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > > +	.modified = 1,						\
> > > +	.channel2 = IIO_MOD_X_AND_Z,				\  
> > ? Not an obvious choice even if I was happy with this approach in general.  
> 
> So the chip has this feature of updating both channels at the same time with the same value.
> Also, I found this ABI : https://www.kernel.org/doc/html/latest/admin-guide/abi-testing.html#abi-sys-bus-iio-devices-iio-devicex-out-voltagey-z-raw
> And as per my understanding it maps well to the chip feature.
> I don't know a use I just found the ABI and I though it would make sense.
> I searched in to the kernel but it seems this modifier is not used anywhere so I couldn't double check it utility.
> Should I keep this channel or remove it?

Ah.   I see where confusion came from.

In that ABI document capital letters are wild cards for the channel numbers.
I'm not actually sure which driver ever used that one...  And digging in the history
I can find the patch that introduced the documentation and.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=98069c3f1cd353eda61d8e11ce40f83d5c5a99f3
Roland did that just before the max517 driver, so looking in there
we have no obvious sign of this today... but 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=6ddc5fb43e47e18d434619e08d41260ff121a7f6
and following forwards from there.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=4cd8d87446d521b7824aa1be84d767c8b5300601

So Lars scrapped it when cleaning that driver up to move it out of staging.

On that basis and the fact we wouldn't do it this way today I'd suggest
we just drop it.  Given we now finally have output buffers, doing this
via some in driver magic that checks for the same value for each channel
as uses this path if they match is going to be much nicer.

For reference the X_AND_Z modifier is for axis like you'd find in an
accelerometer where we are really dealing with the x axis and z axis.
It only really applied to events where you have something that require
a value to be (typically) below a threshold to indicate that the device
is on it's side and so all the acceleration due to gravity is in the y
direction.

If you want to do an additional patch to remove that left over
bit of documentation that would be great. If not I'll do it once
I've caught up with the review backlog.

Jonathan
> 
> Mihail
> 
> >   
> > > +})
> > > +
> > > +static int ad3552r_read_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int *val,
> > > +			    int *val2,
> > > +			    long mask)
> > > +{
> > > +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> > > +	u16 tmp_val;
> > > +	int err;
> > > +	u8 ch = chan->channel;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		mutex_lock(&dac->lock);
> > > +		if (chan->channel == AD3552R_PAGE_CH)
> > > +			err = ad3552r_read_reg(dac,
> > > +  
> > AD3552R_REG_ADDR_DAC_PAGE_MASK_24B,  
> > > +					       &tmp_val);
> > > +		else
> > > +			err = ad3552r_get_ch_value(dac, AD3552R_CH_CODE,  
> > ch,  
> > > +						   &tmp_val);
> > > +		if (err < 0) {
> > > +			mutex_unlock(&dac->lock);
> > > +			return err;
> > > +		}
> > > +
> > > +		*val = tmp_val;
> > > +		mutex_unlock(&dac->lock);
> > > +		break;
> > > +	case IIO_CHAN_INFO_ENABLE:
> > > +		mutex_lock(&dac->lock);
> > > +		err = ad3552r_get_ch_value(dac,  
> > AD3552R_CH_DAC_POWERDOWN,  
> > > +					   ch, &tmp_val);
> > > +		if (err < 0) {
> > > +			mutex_unlock(&dac->lock);
> > > +			return err;
> > > +		}
> > > +		*val = !tmp_val;
> > > +		mutex_unlock(&dac->lock);
> > > +		break;
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val = dac->ch_data[ch].scale_int;
> > > +		*val2 = dac->ch_data[ch].scale_dec;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	case IIO_CHAN_INFO_OFFSET:
> > > +		*val = dac->ch_data[ch].offset_int;
> > > +		*val2 = dac->ch_data[ch].offset_dec;
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return IIO_VAL_INT;
> > > +}
> > > +
> > > +static int ad3552r_write_raw(struct iio_dev *indio_dev,
> > > +			     struct iio_chan_spec const *chan,
> > > +			     int val,
> > > +			     int val2,
> > > +			     long mask)
> > > +{
> > > +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> > > +	enum ad3552r_ch_attributes attr;
> > > +	int err = 0;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		if (chan->channel == AD3552R_PAGE_CH) {
> > > +			mutex_lock(&dac->lock);
> > > +			err = ad3552r_write_reg(dac,
> > > +  
> > 	AD3552R_REG_ADDR_DAC_PAGE_MASK_24B,  
> > > +						val);
> > > +			mutex_unlock(&dac->lock);
> > > +
> > > +			return err;
> > > +		}
> > > +
> > > +		attr = AD3552R_CH_CODE;
> > > +		break;
> > > +	case IIO_CHAN_INFO_ENABLE:
> > > +		attr = AD3552R_CH_DAC_POWERDOWN;
> > > +		val = !val;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	mutex_lock(&dac->lock);
> > > +	err = ad3552r_set_ch_value(dac, attr, chan->channel, val);
> > > +	mutex_unlock(&dac->lock);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int ad3552r_update_scan_mode(struct iio_dev *indio_dev,
> > > +				    const unsigned long *scan_mask) {
> > > +	u32 mask;
> > > +
> > > +	mask = *scan_mask;
> > > +	/* If writing to mask, can't write to other channels */
> > > +	if ((mask & AD3552R_MASK_CH(AD3552R_PAGE_CH)) &&
> > > +	    (mask & (~AD3552R_MASK_CH(AD3552R_PAGE_CH))))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Device type specific information.
> > > + */
> > > +static const struct iio_info ad3552r_iio_info = {
> > > +	.read_raw = ad3552r_read_raw,
> > > +	.write_raw = ad3552r_write_raw,
> > > +	.update_scan_mode = ad3552r_update_scan_mode };
> > > +
> > > +static irqreturn_t ad3552r_trigger_handler(int irq, void *p) {
> > > +	struct iio_poll_func	*pf = p;
> > > +	struct iio_dev		*indio_dev = pf->indio_dev;
> > > +	struct iio_buffer	*buf = indio_dev->buffer;
> > > +	struct ad3552r_desc	*dac = iio_priv(indio_dev);
> > > +	char			buff[AD3552R_NUM_CH *  
> > AD3552R_MAX_REG_SIZE];  
> > > +	int			err;
> > > +
> > > +	memset(buff, 0, sizeof(buff));
> > > +	err = iio_pop_from_buffer(buf, buff);
> > > +	if (err)
> > > +		goto end;
> > > +
> > > +	mutex_lock(&dac->lock);
> > > +	err = ad3552r_write_codes(dac, *indio_dev->active_scan_mask, buff);
> > > +	mutex_unlock(&dac->lock);
> > > +	if (err)
> > > +		goto end;  
> > Drop this given we are going to exactly where we would otherwise be. Note
> > one of the static checkers will probably complain about thsi.  
> > > +
> > > +end:
> > > +	iio_trigger_notify_done(indio_dev->trig);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int ad3552r_check_scratch_pad(struct ad3552r_desc *dac) {
> > > +	const u16 val1 = AD3552R_SCRATCH_PAD_TEST_VAL1;
> > > +	const u16 val2 = AD3552R_SCRATCH_PAD_TEST_VAL2;
> > > +	u16 val;
> > > +	int err;
> > > +
> > > +	err = ad3552r_write_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,  
> > val1);  
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,  
> > &val);  
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	if (val1 != val)
> > > +		return -ENODEV;
> > > +
> > > +	err = ad3552r_write_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,  
> > val2);  
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,  
> > &val);  
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	if (val2 != val)
> > > +		return -ENODEV;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +struct reg_addr_pool {
> > > +	struct ad3552r_desc *dac;
> > > +	u8		    addr;
> > > +};
> > > +
> > > +static u16 ad3552r_read_reg_wrapper(struct reg_addr_pool *addr) {
> > > +	u16 val = 0;
> > > +
> > > +	ad3552r_read_reg(addr->dac, addr->addr, &val);  
> > What about potential errors?  If we need to mask them then add a comment
> > here on why.  
> > > +
> > > +	return val;
> > > +}
> > > +
> > > +static int ad3552r_reset(struct ad3552r_desc *dac) {
> > > +	struct reg_addr_pool addr;
> > > +	int ret;
> > > +	u16 val;
> > > +
> > > +	dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
> > > +						  GPIOD_OUT_LOW);
> > > +	if (IS_ERR(dac->gpio_reset))
> > > +		return PTR_ERR(dac->gpio_reset);  
> > 
> > For a lot of similar paths we should use dev_err_probe() so as to register a
> > 'reason' if we need to defer + provide a bit more debugging info if it is a
> > different error.
> >   
> > > +
> > > +	if (dac->gpio_reset) {
> > > +		/* Perform hardware reset */
> > > +		usleep_range(10, 20);
> > > +		gpiod_set_value_cansleep(dac->gpio_reset, 1);
> > > +	} else {
> > > +		/* Perform software reset if no GPIO provided */
> > > +		ret = ad3552r_update_reg_field(dac,  
> > AD3552R_REG_ADDR_INTERFACE_CONFIG_A,  
> > > +  
> > AD3552R_MASK_SOFTWARE_RESET,  
> > > +  
> > AD3552R_MASK_SOFTWARE_RESET);  
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +	}
> > > +
> > > +	addr.dac = dac;
> > > +	addr.addr = AD3552R_REG_ADDR_INTERFACE_CONFIG_B;
> > > +	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> > > +				 val == AD3552R_DEFAULT_CONFIG_B_VALUE,
> > > +				 5000, 50000);
> > > +	if (ret) {
> > > +		dev_err(&dac->spi->dev, "Err: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> > > +				 !(val &  
> > AD3552R_MASK_INTERFACE_NOT_READY),  
> > > +				 5000, 50000);
> > > +	if (ret) {
> > > +		dev_err(&dac->spi->dev, "Err: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return ad3552r_set_dev_value(dac, AD3552R_ADDR_ASCENSION, 0); }
> > > +
> > > +static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32  
> > *v_min,  
> > > +				     s32 *v_max)
> > > +{
> > > +	s64 vref, tmp, common, offset, gn, gp;
> > > +	/*
> > > +	 * From datasheet formula (In Volts):
> > > +	 *	Vmin = 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
> > > +	 *	Vmax = 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
> > > +	 * Calculus are converted to milivolts
> > > +	 */
> > > +	vref = 2500;
> > > +	/* 2.5 * 1.03 * 1000 (To mV) */
> > > +	common = 2575 * dac->ch_data[i].rfb;
> > > +	offset = dac->ch_data[i].gain_offset;
> > > +	if (dac->ch_data[i].offset_polarity)
> > > +		offset *= -1;
> > > +
> > > +	gn = gains_scaling_table[dac->ch_data[i].n];
> > > +	tmp = (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
> > > +	tmp = div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
> > > +	*v_max = vref + tmp;
> > > +
> > > +	gp = gains_scaling_table[dac->ch_data[i].p];
> > > +	tmp = (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
> > > +	tmp = div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
> > > +	*v_min = vref - tmp;
> > > +}
> > > +
> > > +static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac,
> > > +s32 ch) {
> > > +	s32 idx, v_max, v_min, span, rem;
> > > +	s64 tmp;
> > > +
> > > +	if (dac->ch_data[ch].range_override) {
> > > +		ad3552r_get_custom_range(dac, ch, &v_min, &v_max);
> > > +	} else {
> > > +		/* Normal range */
> > > +		idx = dac->ch_data[ch].range;
> > > +		if (dac->chip_id == AD3542R_ID) {
> > > +			v_min = ad3542r_ch_ranges[idx][0];
> > > +			v_max = ad3542r_ch_ranges[idx][1];
> > > +		} else {
> > > +			v_min = ad3552r_ch_ranges[idx][0];
> > > +			v_max = ad3552r_ch_ranges[idx][1];
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * From datasheet formula:
> > > +	 *	Vout = Span * (D / 65536) + Vmin
> > > +	 * Converted to scale and offset:
> > > +	 *	Scale = Span / 65536
> > > +	 *	Offset = 65536 * Vmin / Span
> > > +	 *
> > > +	 * Reminders are in micros in order to be printed as
> > > +	 * IIO_VAL_INT_PLUS_MICRO
> > > +	 */
> > > +	span = v_max - v_min;
> > > +	dac->ch_data[ch].scale_int = div_s64_rem(span, 65536, &rem);
> > > +	/* Do operations in microvolts */
> > > +	dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem *  
> > 1000000,  
> > > +							65536);
> > > +
> > > +	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span,
> > > +							&rem);
> > > +	tmp = (s64)rem * 1000000;
> > > +	dac->ch_data[ch].offset_dec = div_s64(tmp, span); }
> > > +
> > > +static const char * const gain_dts_names[] = {
> > > +	"adi,gain-scaling-p",
> > > +	"adi,gain-scaling-n",
> > > +	"adi,rfb-ohms"
> > > +};
> > > +
> > > +static int ad3552r_find_range(u16 id, u32 *vals) {
> > > +	int i, len;
> > > +	const s32 (*ranges)[2];  
> > 
> > Why are we comparing signed and unsigned values in here?
> > Should vals be signed as well?
> >   
> > > +
> > > +	if (id == AD3542R_ID) {
> > > +		len = ARRAY_SIZE(ad3542r_ch_ranges);
> > > +		ranges = ad3542r_ch_ranges;
> > > +	} else {
> > > +		len = ARRAY_SIZE(ad3552r_ch_ranges);
> > > +		ranges = ad3552r_ch_ranges;
> > > +	}
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		if (vals[0] == ranges[i][0] * 1000 &&
> > > +		    vals[1] == ranges[i][1] * 1000)
> > > +			return i;
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> > > +					 struct fwnode_handle *child,
> > > +					 u32 ch)
> > > +{
> > > +	static const enum ad3552r_ch_attributes gain_attrs[] = {
> > > +		AD3552R_CH_GAIN_SCALING_P,
> > > +		AD3552R_CH_GAIN_SCALING_N,
> > > +		AD3552R_CH_RFB
> > > +	};
> > > +	struct device *dev = &dac->spi->dev;
> > > +	struct fwnode_handle *custom_gain_child;
> > > +	u32 val;
> > > +	int err, i;
> > > +
> > > +	custom_gain_child = fwnode_get_named_child_node(child,
> > > +							"custom-output-  
> > range-config");  
> > > +	if (IS_ERR(custom_gain_child)) {
> > > +		dev_err(dev,
> > > +			"mandatory custom-output-range-config property  
> > missing\n");  
> > > +		return PTR_ERR(custom_gain_child);
> > > +	}
> > > +
> > > +	err = fwnode_property_read_u32(custom_gain_child, "adi,gain-offset",
> > > +				       &val);
> > > +	if (err) {
> > > +		dev_err(dev,
> > > +			"mandatory adi,gain-offset property missing\n");
> > > +		goto put_child;
> > > +	}
> > > +
> > > +	err = ad3552r_set_ch_value(dac, AD3552R_CH_GAIN_OFFSET, ch,
> > > +				   abs((s32)val));
> > > +	if (err)
> > > +		goto put_child;
> > > +
> > > +	err = ad3552r_set_ch_value(dac,  
> > AD3552R_CH_GAIN_OFFSET_POLARITY,  
> > > +					ch, (s32)val < 0);
> > > +	if (err)
> > > +		goto put_child;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(gain_attrs); ++i) {
> > > +		err = fwnode_property_read_u32(custom_gain_child,
> > > +					       gain_dts_names[i], &val);
> > > +		if (err) {
> > > +			dev_err(dev, "mandatory %s property missing\n",
> > > +				gain_dts_names[i]);
> > > +			goto put_child;
> > > +		}
> > > +
> > > +		err = ad3552r_set_ch_value(dac, gain_attrs[i], ch, val);
> > > +		if (err)
> > > +			goto put_child;
> > > +	}
> > > +  
> > Don't we need to put the custom_gain_child node in the good path as well as
> > the bad one?  
> > > +	return 0;
> > > +
> > > +put_child:
> > > +	fwnode_handle_put(custom_gain_child);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int ad3552r_configure_device(struct ad3552r_desc *dac) {
> > > +	struct device *dev = &dac->spi->dev;
> > > +	struct fwnode_handle *child;
> > > +	struct regulator *vref;
> > > +	int err, cnt = 0, voltage, delta = 100000;
> > > +	u32 vals[2], ch;
> > > +	bool is_custom;
> > > +
> > > +	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac",  
> > GPIOD_OUT_HIGH);  
> > > +	if (IS_ERR(dac->gpio_ldac))
> > > +		return PTR_ERR(dac->gpio_ldac);
> > > +
> > > +	vref = devm_regulator_get_optional(dev, "vref");
> > > +	if (IS_ERR(vref)) {
> > > +		if (PTR_ERR(vref) != -ENODEV)
> > > +			return PTR_ERR(vref);
> > > +		vref = NULL;
> > > +	}
> > > +	if (vref) {
> > > +		voltage = regulator_get_voltage(vref);
> > > +		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> > > +			dev_err(dev, "vref-supply must be 2.5V");  
> > 
> > I'd be tempted to reduce this to a dev_warn and carry on regardless.
> > Whilst the datasheet states it must be a 2.5V reference, I'm not seeing any
> > clear guidance on what happens if say it's just beyond your delta.
> >   
> > > +			return -EINVAL;
> > > +		}
> > > +		vals[0] = AD3552R_EXTERNAL_VREF_PIN_INPUT;
> > > +	} else {
> > > +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> > > +			vals[0] = AD3552R_INTERNAL_VREF_PIN_2P5V;  
> > 
> > I would have a separate local variable for the single value and the array cases.
> > That will look cleaner than a reader wondering what is in the other elements of
> > the array when there is nothing there.
> > 
> > The vals[1] value is only used in a fairly deeply nested statement, so just
> > introduce the array in the appropriate place.
> >   
> > > +		else
> > > +			vals[0] = AD3552R_INTERNAL_VREF_PIN_FLOATING;
> > > +	}
> > > +	err = ad3552r_set_dev_value(dac, AD3552R_VREF_SELECT, vals[0]);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = device_property_read_u32(dev, "adi,sdo-drive-strength",  
> > &vals[0]);  
> > > +	if (!err) {
> > > +		if (vals[0] > 3) {
> > > +			dev_err(dev, "%s must be less than 4\n",
> > > +				"adi,sdo-drive-strength");
> > > +			return -EINVAL;
> > > +		}
> > > +		err = ad3552r_set_dev_value(dac,  
> > AD3552R_SDO_DRIVE_STRENGTH,  
> > > +					    vals[0]);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	dac->num_ch = device_get_child_node_count(dev);
> > > +	if (!dac->num_ch) {
> > > +		dev_err(dev, "No channels defined\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	device_for_each_child_node(dev, child) {
> > > +		err = fwnode_property_read_u32(child, "reg", &ch);
> > > +		if (err) {
> > > +			dev_err(dev, "mandatory reg property missing\n");
> > > +			goto put_child;
> > > +		}
> > > +		if (ch >= AD3552R_NUM_CH) {
> > > +			dev_err(dev, "reg must be less than %d\n",
> > > +				AD3552R_NUM_CH);
> > > +			err = -EINVAL;
> > > +			goto put_child;
> > > +		}
> > > +
> > > +		if (fwnode_property_present(child, "adi,output-range-  
> > microvolt")) {  
> > > +			is_custom = false;
> > > +			err = fwnode_property_read_u32_array(child,
> > > +							     "adi,output-range-  
> > microvolt",  
> > > +							     vals,
> > > +							     2);
> > > +			if (err) {
> > > +				dev_err(dev,
> > > +					"mandatory adi,output-range-  
> > microvolt property missing\n");  
> > > +				goto put_child;
> > > +			}
> > > +
> > > +			vals[0] = ad3552r_find_range(dac->chip_id, vals);
> > > +			if ((s32)vals[0] < 0) {
> > > +				dev_err(dev,
> > > +					"Invalid adi,output-range-microvolt  
> > value\n");  
> > > +				err = -EINVAL;
> > > +				goto put_child;
> > > +			}
> > > +			err = ad3552r_set_ch_value(dac,
> > > +  
> > AD3552R_CH_OUTPUT_RANGE_SEL,  
> > > +						   ch, vals[0]);
> > > +			if (err)
> > > +				goto put_child;
> > > +		} else {
> > > +			is_custom = true;
> > > +			err = ad3552r_configure_custom_gain(dac, child, ch);
> > > +			if (err)
> > > +				goto put_child;
> > > +		}
> > > +
> > > +		ad3552r_calc_gain_and_offset(dac, ch);
> > > +		err = ad3552r_set_ch_value(dac,  
> > AD3552R_CH_RANGE_OVERRIDE, ch,  
> > > +					   is_custom);
> > > +		if (err)
> > > +			goto put_child;
> > > +
> > > +		dac->enabled_ch |= BIT(ch);
> > > +
> > > +		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> > > +		dac->channels[cnt] = AD3552R_CH_DAC(ch);
> > > +		++cnt;
> > > +
> > > +	}
> > > +
> > > +	if (cnt == AD3552R_NUM_CH) {
> > > +		dac->channels[cnt] =  
> > AD3552R_CH_DAC_PAGE(AD3552R_PAGE_CH);  
> > > +		++cnt;
> > > +	} else {
> > > +		/* Disable unused channels */
> > > +		for_each_clear_bit(ch, &dac->enabled_ch,  
> > AD3552R_PAGE_CH) {  
> > > +			err = ad3552r_set_ch_value(dac,
> > > +  
> > AD3552R_CH_AMPLIFIER_POWERDOWN,  
> > > +						   ch,
> > > +						   0);
> > > +			if (err)
> > > +				goto put_child;  
> > 
> > Do we need to put the child node out here?
> >   
> > > +		}
> > > +	}
> > > +
> > > +	dac->num_ch = cnt;
> > > +
> > > +put_child:
> > > +	fwnode_handle_put(child);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int ad3552r_init(struct ad3552r_desc *dac) {
> > > +	int err;
> > > +	u16 val, id;
> > > +
> > > +	err = ad3552r_reset(dac);
> > > +	if (err) {
> > > +		dev_err(&dac->spi->dev, "Reset failed\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	err = ad3552r_check_scratch_pad(dac);
> > > +	if (err) {
> > > +		dev_err(&dac->spi->dev, "Scratch pad test failed\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_L,  
> > &val);  
> > > +	if (err) {
> > > +		dev_err(&dac->spi->dev, "Fail read PRODUCT_ID_L\n");
> > > +		return err;
> > > +	}
> > > +	id = val;
> > > +	err = ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_H,  
> > &val);  
> > > +	if (err) {
> > > +		dev_err(&dac->spi->dev, "Fail read PRODUCT_ID_H\n");
> > > +		return err;
> > > +	}
> > > +	id |= val << 8;
> > > +	if (id != dac->chip_id) {
> > > +		dev_err(&dac->spi->dev, "Product id not matching\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	return ad3552r_configure_device(dac); }
> > > +
> > > +static int ad3552r_probe(struct spi_device *spi) {
> > > +	const struct spi_device_id *id = spi_get_device_id(spi);
> > > +	struct ad3552r_desc *dac;
> > > +	struct iio_dev *indio_dev;
> > > +	int err;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*dac));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	dac = iio_priv(indio_dev);
> > > +	dac->spi = spi;
> > > +	dac->chip_id = id->driver_data;
> > > +
> > > +	mutex_init(&dac->lock);
> > > +
> > > +	err = ad3552r_init(dac);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	/* Config triggered buffer device */
> > > +	indio_dev->dev.parent = &spi->dev;
> > > +	indio_dev->name = "ad3552r";  
> > 
> > That name needs to reflect the connected part, not always be ad3552r.
> >   
> > > +	indio_dev->info = &ad3552r_iio_info;
> > > +	indio_dev->num_channels = dac->num_ch;
> > > +	indio_dev->channels = dac->channels;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +
> > > +	err = devm_iio_triggered_buffer_setup_ext(&indio_dev->dev,  
> > indio_dev, NULL,  
> > > +						  &ad3552r_trigger_handler,
> > > +  
> > IIO_BUFFER_DIRECTION_OUT,  
> > > +						  NULL,
> > > +						  NULL);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return devm_iio_device_register(&spi->dev, indio_dev); }
> > > +
> > > +static const struct spi_device_id ad3552r_id[] = {
> > > +	{ "ad3542r", AD3542R_ID },
> > > +	{ "ad3552r", AD3552R_ID },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, ad3552r_id);
> > > +
> > > +static const struct of_device_id ad3552r_of_match[] = {
> > > +	{ .compatible = "adi,ad3542r"},
> > > +	{ .compatible = "adi,ad3552r"},
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ad3552r_of_match);
> > > +
> > > +static struct spi_driver ad3552r_driver = {
> > > +	.driver = {
> > > +		.name = "ad3552r",
> > > +		.of_match_table = ad3552r_of_match,
> > > +	},
> > > +	.probe = ad3552r_probe,
> > > +	.id_table = ad3552r_id
> > > +};
> > > +module_spi_driver(ad3552r_driver);
> > > +
> > > +MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
> > > +MODULE_DESCRIPTION("Analog Device AD3552R DAC");  
> > MODULE_LICENSE("GPL  
> > > +v2");  
> 

