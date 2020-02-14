Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0415D829
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBNNOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 08:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgBNNOp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 08:14:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42521222C2;
        Fri, 14 Feb 2020 13:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581686083;
        bh=UzIvJkh7okM0mv8bY5D9J7NwLlvLJ4jlpVubeCrRUbg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3ttCL7CZmcZF5hOrJv6VrXXlomKrj87bbPr3RN/XPlh7cTh59B6R0xGOUtRa+siq
         H6DnfxGCEzoohlfJeH9n4K3VXDLtnQi1p+CvEvtdZf5HOa2gpq6lj3y08wWOm7Oidf
         G3Sv4SwpH8QJLbvklCSNbllrJwN7Fx3DEaFPf2sw=
Date:   Fri, 14 Feb 2020 13:14:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH 3/5] iio: light: vcnl4000: add proximity integration
 time for vcnl4040/4200
Message-ID: <20200214131439.7b1538b3@archlinux>
In-Reply-To: <20200211172552.0b5bbcec@tomas.local.tbs-biometrics.cz>
References: <20200205101655.11728-1-tomas@novotny.cz>
        <20200205101655.11728-4-tomas@novotny.cz>
        <20200208150308.318f06af@archlinux>
        <20200211172552.0b5bbcec@tomas.local.tbs-biometrics.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 17:25:52 +0100
Tomas Novotny <tomas@novotny.cz> wrote:

> Hi Jonathan,
> 
> On Sat, 8 Feb 2020 15:03:08 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed,  5 Feb 2020 11:16:53 +0100
> > Tomas Novotny <tomas@novotny.cz> wrote:
> >   
> > > Proximity integration time handling and available values are added. The
> > > integration time affects sampling rate, so it is computed now. The
> > > settings should be changed only on the disabled channel. The check is
> > > performed and user is notified in case of enabled channel. The helper
> > > function is added as it will be used also for other settings.
> > > 
> > > Integration time values are taken from the Vishay's documents "Designing
> > > the VCNL4200 Into an Application" from Oct-2019 and "Designing the
> > > VCNL4040 Into an Application" from Nov-2019.
> > > 
> > > Duty ratio will be made configurable in the next patch.    
> > A few comments inline.
> > 
> > Jonathan
> >   
> > > 
> > > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > > ---
> > >  drivers/iio/light/vcnl4000.c | 188 +++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 183 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > > index f351b100a165..0bad082d762d 100644
> > > --- a/drivers/iio/light/vcnl4000.c
> > > +++ b/drivers/iio/light/vcnl4000.c
> > > @@ -60,6 +60,8 @@
> > >  
> > >  /* Bit masks for various configuration registers */
> > >  #define VCNL4200_AL_SD		BIT(0) /* Ambient light shutdown */
> > > +#define VCNL4200_PS_IT_MASK	GENMASK(3, 1) /* Proximity integration time */
> > > +#define VCNL4200_PS_IT_SHIFT	1
> > >  #define VCNL4200_PS_SD		BIT(0) /* Proximity shutdown */
> > >  
> > >  enum vcnl4000_device_ids {
> > > @@ -74,6 +76,9 @@ struct vcnl4200_channel {
> > >  	ktime_t last_measurement;
> > >  	ktime_t sampling_rate;
> > >  	struct mutex lock;
> > > +	const int *int_time;
> > > +	size_t int_time_size;
> > > +	int ps_duty_ratio;	/* Proximity specific */
> > >  };
> > >  
> > >  struct vcnl4000_data {
> > > @@ -100,6 +105,10 @@ struct vcnl4000_chip_spec {
> > >  			int *val);
> > >  	int (*enable)(struct vcnl4000_data *data, enum iio_chan_type type,
> > >  			bool val);
> > > +	int (*get_int_time)(struct vcnl4000_data *data, enum iio_chan_type type,
> > > +			    int *val, int *val2);
> > > +	int (*set_int_time)(struct vcnl4000_data *data, enum iio_chan_type type,
> > > +			    int val, int val2);
> > >  };
> > >  
> > >  static const struct i2c_device_id vcnl4000_id[] = {
> > > @@ -132,10 +141,36 @@ static const struct iio_chan_spec vcnl4200_channels[] = {
> > >  	}, {
> > >  		.type = IIO_PROXIMITY,
> > >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > -			BIT(IIO_CHAN_INFO_ENABLE),
> > > +			BIT(IIO_CHAN_INFO_ENABLE) |
> > > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> > >  	}
> > >  };
> > >  
> > > +/* Values are directly mapped to register values. */
> > > +/* Integration time in us; 1T, 1.5T, 2T, 2.5T, 3T, 3.5T, 4T, 8T */
> > > +static const int vcnl4040_ps_int_time[] = {
> > > +	0, 125,
> > > +	0, 188, /* 187.5 */
> > > +	0, 250,
> > > +	0, 313, /* 312.5 */
> > > +	0, 375,
> > > +	0, 438, /* 437.5 */
> > > +	0, 500,
> > > +	0, 1000
> > > +};
> > > +
> > > +/* Values are directly mapped to register values. */
> > > +/* Integration time in us; 1T, 1.5T, 2T, 4T, 8T, 9T */
> > > +static const int vcnl4200_ps_int_time[] = {
> > > +	0, 30,
> > > +	0, 45,
> > > +	0, 60,
> > > +	0, 120,
> > > +	0, 240,
> > > +	0, 270
> > > +};
> > > +
> > >  static const struct regmap_config vcnl4000_regmap_config = {
> > >  	.reg_bits = 8,
> > >  	.val_bits = 8,
> > > @@ -179,6 +214,34 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> > >  	return 0;
> > >  };
> > >  
> > > +static int vcnl4200_set_samp_rate(struct vcnl4000_data *data,
> > > +				  enum iio_chan_type type)
> > > +{
> > > +	int ret;
> > > +	int it_val, it_val2;
> > > +	int duty_ratio;
> > > +
> > > +	switch (type) {
> > > +	case IIO_PROXIMITY:
> > > +		ret = data->chip_spec->get_int_time(data, IIO_PROXIMITY,
> > > +						    &it_val, &it_val2);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		duty_ratio = data->vcnl4200_ps.ps_duty_ratio;
> > > +		/*
> > > +		 * Integration time multiplied by duty ratio.
> > > +		 * Add 20% of part to part tolerance.
> > > +		 */
> > > +		data->vcnl4200_ps.sampling_rate =    
> > 
> > sampling_period perhaps?  It's a time rather than a rate (so many per second).  
> 
> well, yes. This attribute was introduced in the past. Should I prepend
> cleanup patch at the beginning of this series?

That would be great.  If you have already sent out a v2, then it can
always be a follow up tidy up sometime later.

> 
> > > +			ktime_set(((it_val * duty_ratio) * 6) / 5,
> > > +				  (((it_val2 * duty_ratio) * 6) / 5) * 1000);
> > > +		return 0;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int vcnl4200_init(struct vcnl4000_data *data)
> > >  {
> > >  	int ret, id;
> > > @@ -218,18 +281,25 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> > >  	case VCNL4200_PROD_ID:
> > >  		/* Default wait time is 50ms, add 20% tolerance. */
> > >  		data->vcnl4200_al.sampling_rate = ktime_set(0, 60000 * 1000);
> > > -		/* Default wait time is 4.8ms, add 20% tolerance. */
> > > -		data->vcnl4200_ps.sampling_rate = ktime_set(0, 5760 * 1000);
> > > +		data->vcnl4200_ps.int_time = vcnl4200_ps_int_time;
> > > +		data->vcnl4200_ps.int_time_size =
> > > +			ARRAY_SIZE(vcnl4200_ps_int_time);
> > > +		data->vcnl4200_ps.ps_duty_ratio = 160;
> > >  		data->al_scale = 24000;
> > >  		break;
> > >  	case VCNL4040_PROD_ID:
> > >  		/* Default wait time is 80ms, add 20% tolerance. */
> > >  		data->vcnl4200_al.sampling_rate = ktime_set(0, 96000 * 1000);
> > > -		/* Default wait time is 5ms, add 20% tolerance. */
> > > -		data->vcnl4200_ps.sampling_rate = ktime_set(0, 6000 * 1000);
> > > +		data->vcnl4200_ps.int_time = vcnl4040_ps_int_time;
> > > +		data->vcnl4200_ps.int_time_size =
> > > +			ARRAY_SIZE(vcnl4040_ps_int_time);
> > > +		data->vcnl4200_ps.ps_duty_ratio = 40;
> > >  		data->al_scale = 120000;
> > >  		break;
> > >  	}
> > > +	ret = vcnl4200_set_samp_rate(data, IIO_PROXIMITY);
> > > +	if (ret < 0)
> > > +		return ret;
> > >  	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
> > >  	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
> > >  	mutex_init(&data->vcnl4200_al.lock);
> > > @@ -368,6 +438,80 @@ static int vcnl4200_enable(struct vcnl4000_data *data, enum iio_chan_type type,
> > >  	}
> > >  }
> > >  
> > > +static int vcnl4200_check_enabled(struct vcnl4000_data *data,
> > > +				  enum iio_chan_type type)
> > > +{
> > > +	int ret, val;
> > > +
> > > +	ret = data->chip_spec->is_enabled(data, type, &val);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (val) {
> > > +		dev_warn(&data->client->dev,
> > > +			 "Channel is enabled. Parameter cannot be changed.\n");    
> > 
> > For a basic parameter like this, userspace isn't going to typically
> > expect that it can't be changed live.  Hence you should be looking
> > to go through a disable / modify / enable sequence.  
> 
> ok, I will handle it.
> 
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int vcnl4200_get_int_time(struct vcnl4000_data *data,
> > > +				 enum iio_chan_type type, int *val, int *val2)
> > > +{
> > > +	int ret;
> > > +	unsigned int reg;
> > > +
> > > +	switch (type) {
> > > +	case IIO_PROXIMITY:
> > > +		ret = regmap_read(data->regmap, VCNL4200_PS_CONF1, &reg);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		reg &= VCNL4200_PS_IT_MASK;
> > > +		reg >>= VCNL4200_PS_IT_SHIFT;
> > > +
> > > +		*val = data->vcnl4200_ps.int_time[reg * 2];
> > > +		*val2 = data->vcnl4200_ps.int_time[reg * 2 + 1];
> > > +		return IIO_VAL_INT_PLUS_MICRO;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +
> > > +static int vcnl4200_set_int_time(struct vcnl4000_data *data,
> > > +				 enum iio_chan_type type, int val, int val2)
> > > +{
> > > +	int i, ret;
> > > +
> > > +	ret = vcnl4200_check_enabled(data, type);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	switch (type) {    
> > 
> > This check is rather paranoid as it shouldn't be possible to get here
> > without this being IIO_PROXIMITY.  
> 
> I made it confusing. The switch was added as a skeleton because of int. time
> for ambient light. I will drop it completely (including the "check effect").

Great.

> 
> > > +	case IIO_PROXIMITY:
> > > +		for (i = 0; i < data->vcnl4200_ps.int_time_size; i += 2) {
> > > +			if (val == data->vcnl4200_ps.int_time[i] &&
> > > +			    data->vcnl4200_ps.int_time[i + 1] == val2) {    
> >   
> > > +				ret = regmap_update_bits(data->regmap,
> > > +							 VCNL4200_PS_CONF1,
> > > +							 VCNL4200_PS_IT_MASK,
> > > +							 (i / 2) <<
> > > +							 VCNL4200_PS_IT_SHIFT);
> > > +				if (ret < 0)
> > > +					return ret;
> > > +				return vcnl4200_set_samp_rate(data,
> > > +							      IIO_PROXIMITY);
> > > +			}
> > > +		}
> > > +		break;    
> > 
> > return -EINVAL here and no need for break or handling below.
> >   
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +	return -EINVAL;
> > > +}
> > > +
> > >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > >  	[VCNL4000] = {
> > >  		.prod = "VCNL4000",
> > > @@ -397,6 +541,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > >  		.measure_proximity = vcnl4200_measure_proximity,
> > >  		.is_enabled = vcnl4200_is_enabled,
> > >  		.enable = vcnl4200_enable,
> > > +		.get_int_time = vcnl4200_get_int_time,
> > > +		.set_int_time = vcnl4200_set_int_time,
> > >  	},    
> > 
> > We now support more devices in this driver.  
> 
> You mean that vcnl4000 - vcnl4020 are missing it? There is no integration
> time for them. It is guarded by different iio_chan_spec.

Ah. My confusion.  Thanks.

> 
> Thanks,
> 
> Tomas
> 
> > >  	[VCNL4200] = {
> > >  		.prod = "VCNL4200",
> > > @@ -408,6 +554,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > >  		.measure_proximity = vcnl4200_measure_proximity,
> > >  		.is_enabled = vcnl4200_is_enabled,
> > >  		.enable = vcnl4200_enable,
> > > +		.get_int_time = vcnl4200_get_int_time,
> > > +		.set_int_time = vcnl4200_set_int_time,
> > >  	},
> > >  };
> > >  
> > > @@ -443,6 +591,32 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> > >  		return IIO_VAL_INT_PLUS_MICRO;
> > >  	case IIO_CHAN_INFO_ENABLE:
> > >  		return data->chip_spec->is_enabled(data, chan->type, val);
> > > +	case IIO_CHAN_INFO_INT_TIME:
> > > +		return data->chip_spec->get_int_time(data, chan->type,
> > > +						     val, val2);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int vcnl4000_read_avail(struct iio_dev *indio_dev,
> > > +				struct iio_chan_spec const *chan,
> > > +				const int **vals, int *type, int *length,
> > > +				long mask)
> > > +{
> > > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_INT_TIME:
> > > +		switch (chan->type) {
> > > +		case IIO_PROXIMITY:
> > > +			*vals = data->vcnl4200_ps.int_time;
> > > +			*length = data->vcnl4200_ps.int_time_size;
> > > +			*type =  IIO_VAL_INT_PLUS_MICRO;
> > > +			return IIO_AVAIL_LIST;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > >  	default:
> > >  		return -EINVAL;
> > >  	}
> > > @@ -457,6 +631,9 @@ static int vcnl4000_write_raw(struct iio_dev *indio_dev,
> > >  	switch (mask) {
> > >  	case IIO_CHAN_INFO_ENABLE:
> > >  		return data->chip_spec->enable(data, chan->type, val);
> > > +	case IIO_CHAN_INFO_INT_TIME:
> > > +		return data->chip_spec->set_int_time(data, chan->type,
> > > +						     val, val2);
> > >  	default:
> > >  		return -EINVAL;
> > >  	}
> > > @@ -464,6 +641,7 @@ static int vcnl4000_write_raw(struct iio_dev *indio_dev,
> > >  
> > >  static const struct iio_info vcnl4000_info = {
> > >  	.read_raw = vcnl4000_read_raw,
> > > +	.read_avail = vcnl4000_read_avail,
> > >  	.write_raw = vcnl4000_write_raw,
> > >  };
> > >      
> >   

