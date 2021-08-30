Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949D83FB35B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhH3JqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Aug 2021 05:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236225AbhH3JqT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 05:46:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75E760F57;
        Mon, 30 Aug 2021 09:45:23 +0000 (UTC)
Date:   Mon, 30 Aug 2021 10:48:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: add threshold event
 handling
Message-ID: <20210830104835.4a413386@jic23-huawei>
In-Reply-To: <20210830081032.267891-1-sean@geanix.com>
References: <20210830081032.267891-1-sean@geanix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 10:10:31 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Add event channels that control the creation of motion events.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Hi Sean,

This seems to be hammering a pair of independent limits into use as
a magnitude event.  Whilst that is what many accelerometers support,
this particular one seems to have separate thresholds for the negative vs
positive and we should look to support that.  Note that it's not uncommon
to have separate thresholds, but only one enable - just register three event
specs, one with the enable and DIR_EITHER and one for each of the directions
with just the value setting.

If there is a strong usecase for a magnitude threshold then we should
discuss whether 'emulating' that is a job for userspace or kernel.

Various related comments inline.

Thanks,

Jonathan

> ---
> Changes since v1/v2:
>  - Fixed comments fron Andy (Thanks)
>  - Corrected sign mess
> 
>  drivers/iio/accel/fxls8962af-core.c | 266 +++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 6b36eb362d07..dd639420fb0f 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -22,6 +22,7 @@
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> @@ -30,6 +31,7 @@
>  
>  #define FXLS8962AF_INT_STATUS			0x00
>  #define FXLS8962AF_INT_STATUS_SRC_BOOT		BIT(0)
> +#define FXLS8962AF_INT_STATUS_SRC_SDCD_OT	BIT(4)
>  #define FXLS8962AF_INT_STATUS_SRC_BUF		BIT(5)
>  #define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
>  #define FXLS8962AF_TEMP_OUT			0x01
> @@ -73,6 +75,7 @@
>  #define FXLS8962AF_ASLP_COUNT_LSB		0x1e
>  
>  #define FXLS8962AF_INT_EN			0x20
> +#define FXLS8962AF_INT_EN_SDCD_OT_EN		BIT(5)
>  #define FXLS8962AF_INT_EN_BUF_EN		BIT(6)
>  #define FXLS8962AF_INT_PIN_SEL			0x21
>  #define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
> @@ -96,8 +99,14 @@
>  #define FXLS8962AF_ORIENT_THS_REG		0x2c
>  
>  #define FXLS8962AF_SDCD_INT_SRC1		0x2d
> +#define FXLS8962AF_SDCD_INT_SRC1_X_OT		BIT(5)
> +#define FXLS8962AF_SDCD_INT_SRC1_Y_OT		BIT(3)
> +#define FXLS8962AF_SDCD_INT_SRC1_Z_OT		BIT(1)
>  #define FXLS8962AF_SDCD_INT_SRC2		0x2e
>  #define FXLS8962AF_SDCD_CONFIG1			0x2f
> +#define FXLS8962AF_SDCD_CONFIG1_Z_OT_EN		BIT(3)
> +#define FXLS8962AF_SDCD_CONFIG1_Y_OT_EN		BIT(4)
> +#define FXLS8962AF_SDCD_CONFIG1_X_OT_EN		BIT(5)
>  #define FXLS8962AF_SDCD_CONFIG2			0x30
>  #define FXLS8962AF_SDCD_OT_DBCNT		0x31
>  #define FXLS8962AF_SDCD_WT_DBCNT		0x32
> @@ -152,6 +161,9 @@ struct fxls8962af_data {
>  	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
>  	struct iio_mount_matrix orientation;
>  	u8 watermark;
> +	u8 enable_event;
> +	u16 lower_thres;
> +	u16 upper_thres;
>  };
>  
>  const struct regmap_config fxls8962af_regmap_conf = {
> @@ -451,6 +463,15 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int fxls8962af_event_setup(struct fxls8962af_data *data, int state)
> +{
> +	/* Enable wakeup interrupt */
> +	int mask = FXLS8962AF_INT_EN_SDCD_OT_EN;
> +	int value = state ? mask : 0;
> +
> +	return regmap_update_bits(data->regmap, FXLS8962AF_INT_EN, mask, value);
> +}
> +
>  static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
>  {
>  	struct fxls8962af_data *data = iio_priv(indio_dev);
> @@ -463,6 +484,194 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
>  	return 0;
>  }
>  
> +static int __fxls8962af_set_thresholds(struct fxls8962af_data *data,
> +				       const struct iio_chan_spec *chan,
> +				       int val)
> +{
> +	int ret;
> +
> +	/*
> +	 * Add the same value to the lower-threshold register with a reversed sign
> +	 * in 2-complement 12 bit format.
> +	 */
> +	data->lower_thres = -val & GENMASK(11, 0);
> +	data->upper_thres = val & GENMASK(10, 0);

As mentioned above, this is hammering a non magnitude threshold setup into one
that looks like a magnitude. I'd like to understand more on why you are doing this.

> +
> +	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_LTHS_LSB,
> +				&data->lower_thres, chan->scan_type.storagebits / 8);

Don't use storegebits because it's not immediately obvious that the threshold will
have the same bitdepth as the channel read back (it's not the case for some other
devices).  So use sizeof(data->lower_thres) instead.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +				&data->upper_thres, chan->scan_type.storagebits / 8);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_read_event(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir,
> +				 enum iio_event_info info,
> +				 int *val, int *val2)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	u16 raw_val;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	/*
> +	 * Read only upper-threshold register as the lower-threshold register have the
> +	 * same value with reversed sign.
> +	 */
> +	ret = regmap_bulk_read(data->regmap, FXLS8962AF_SDCD_UTHS_LSB,
> +			       &raw_val, chan->scan_type.storagebits / 8);
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(raw_val, chan->scan_type.realbits - 1);
> +	*val2 = 0;

The core won't use val2, with a return value of IIO_VAL_INT, so you can skip
setting it unless you are feeling very paranoid or some checker is warning
about it due to the checkers limited visibility.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int fxls8962af_write_event(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  enum iio_event_type type,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info,
> +				  int val, int val2)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > 2047)
> +		return -EINVAL;
> +
> +	if (data->enable_event)
> +		return -EBUSY;
> +
Trivial: One blank line only.
> +
> +	if (fxls8962af_is_active(data)) {
> +		ret = fxls8962af_standby(data);
> +		if (ret)
> +			return ret;
> +
> +		ret = __fxls8962af_set_thresholds(data, chan, val);
> +		if (ret)
> +			return ret;
> +
> +		ret = fxls8962af_active(data);
		return fxls8...

> +	} else {
> +		ret = __fxls8962af_set_thresholds(data, chan, val);
		reutrn __fxls...

is perhaps a little neater.

> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +fxls8962af_read_event_config(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     enum iio_event_type type,
> +			     enum iio_event_direction dir)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		return FXLS8962AF_SDCD_CONFIG1_X_OT_EN & data->enable_event;

I would force these to be 1/0. The IIO core doesn't sanitise these values currently
(it's something we should perhaps think about, though I don't fancy auditing all the
users to check no one is doing anything strange through this interface).

> +	case IIO_MOD_Y:
> +		return FXLS8962AF_SDCD_CONFIG1_Y_OT_EN & data->enable_event;
> +	case IIO_MOD_Z:
> +		return FXLS8962AF_SDCD_CONFIG1_Z_OT_EN & data->enable_event;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int
> +fxls8962af_write_event_config(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir, int state)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	u8 enable_event, enable_bits;
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	fxls8962af_standby(data);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		enable_bits = FXLS8962AF_SDCD_CONFIG1_X_OT_EN;
> +		break;
> +	case IIO_MOD_Y:
> +		enable_bits = FXLS8962AF_SDCD_CONFIG1_Y_OT_EN;
> +		break;
> +	case IIO_MOD_Z:
> +		enable_bits = FXLS8962AF_SDCD_CONFIG1_Z_OT_EN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (state)
> +		enable_event = data->enable_event | enable_bits;
> +	else
> +		enable_event = data->enable_event & ~enable_bits;
> +
> +	if (data->enable_event == enable_event)

You have put the device into standby. I'm fairly sure you need to come
out of that if this is a noop.   I'd suggest just moving the standby() call
until the point where you know you are going to make a change (so after this).

> +		return 0;
> +
> +	/* Enable events */
> +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG1, enable_event | 0x80);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Enable update of SDCD_REF_X/Y/Z values with the current decimated and
> +	 * trimmed X/Y/Z acceleration input data. This allows for acceleration
> +	 * slope detection with Data(n) to Data(n–1) always used as the input
> +	 * to the window comparator.

This sounds like a ROC detector... If true the current description is wrong as you
need to use the IIO_EV_TYPE_ROC for that sort of event.  Ideally also add the
absolute magnitude version, or at least clearly document that it is not currently
supported by the driver.

The datasheet isn't exactly friendly for working this stuff out. *sigh*

Whilst here, also looks like there is also a convenient vector magnitude option.  Would be
good to support that.

Also break that c up into the two parts that it contains (enable and REF_UPDM value) with suitable
definitions for the various options of REF_UPDM.


> +	 */
> +	ret = regmap_write(data->regmap, FXLS8962AF_SDCD_CONFIG2, enable_event ? 0xc0 : 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = fxls8962af_event_setup(data, state);
> +	if (ret)
> +		return ret;
> +
> +	data->enable_event = enable_event;
> +
> +	if (data->enable_event) {
> +		fxls8962af_active(data);
> +		ret = fxls8962af_power_on(data);
> +	} else {
> +		if (!iio_buffer_enabled(indio_dev))

This can (I think) race with buffer enabling.  To avoid that, whilst doing this check
do a claim_direct_mode() and release it after turning the power off.  That will
ensure consistency.  There is a nasty corner case though if another function is
doing a claim_direct_mode() say due to a concurrent userspace access.  In that case
this one will fail, but the buffer is not enabled and hence we won't power down.

Hmm.  Looking at what this power_off() is doing and the fact it's using runtime_pm,
you should be able to rely on the runtime_pm reference counting and not need this check.
In fact the presence of the power_on above without an iio_buffer_enabled() check
suggests to me this is currently unbalanced and you can end up with the power stuck
on permanently.  

The fact we even have separate config and value callbacks is a historical bit of mess
it would be nice to clean up one day (but is quite a way down the todo list!)

> +			ret = fxls8962af_power_off(data);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_event_spec fxls8962af_event = {
> +	.type = IIO_EV_TYPE_THRESH,
> +	.dir = IIO_EV_DIR_EITHER,
> +	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),

I'm missing something here. The thresholds seem to be independent...

> +};
> +
>  #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
>  	.type = IIO_ACCEL, \
>  	.address = reg, \
> @@ -481,6 +690,8 @@ static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
>  		.shift = 4, \
>  		.endianness = IIO_BE, \
>  	}, \
> +	.event_spec = &fxls8962af_event, \
> +	.num_event_specs = 1, \
>  }
>  
>  #define FXLS8962AF_TEMP_CHANNEL { \
> @@ -522,6 +733,10 @@ static const struct iio_info fxls8962af_info = {
>  	.read_raw = &fxls8962af_read_raw,
>  	.write_raw = &fxls8962af_write_raw,
>  	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
> +	.read_event_value = fxls8962af_read_event,
> +	.write_event_value = fxls8962af_write_event,
> +	.read_event_config = fxls8962af_read_event_config,
> +	.write_event_config = fxls8962af_write_event_config,
>  	.read_avail = fxls8962af_read_avail,
>  	.hwfifo_set_watermark = fxls8962af_set_watermark,
>  };
> @@ -605,7 +820,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	ret = __fxls8962af_fifo_set_mode(data, false);
>  
> -	fxls8962af_active(data);
> +	if (data->enable_event)
> +		fxls8962af_active(data);
>  
>  	return ret;
>  }
> @@ -614,7 +830,10 @@ static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct fxls8962af_data *data = iio_priv(indio_dev);
>  
> -	return fxls8962af_power_off(data);
> +	if (!data->enable_event)
> +		fxls8962af_power_off(data);
> +
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
> @@ -725,6 +944,41 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  	return count;
>  }
>  
> +static int fxls8962af_event_interrupt(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	s64 ts = iio_get_time_ns(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_SDCD_INT_SRC1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg & FXLS8962AF_SDCD_INT_SRC1_X_OT)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_EITHER),

I was a bit surprised to see DIR_EITHER here so went looking at the datasheet.
Seems to me that we have X_OT_POL that lets us know which threshold was passed.
Can we use that here to give a more specific event?

> +				ts);
> +
> +	if (reg & FXLS8962AF_SDCD_INT_SRC1_Y_OT)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Y,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_EITHER),
> +				ts);
> +
> +	if (reg & FXLS8962AF_SDCD_INT_SRC1_Z_OT)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_Z,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_EITHER),
> +				ts);
> +
> +	return ret;

return 0;  Better to make this explicit if it can't have any other value.

> +}
> +
>  static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
> @@ -744,6 +998,14 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  		return IRQ_HANDLED;
>  	}
>  
> +	if (reg & FXLS8962AF_INT_STATUS_SRC_SDCD_OT) {
> +		ret = fxls8962af_event_interrupt(indio_dev);
> +		if (ret < 0)
> +			return IRQ_NONE;
> +
> +		return IRQ_HANDLED;
> +	}
> +
>  	return IRQ_NONE;
>  }
>  

