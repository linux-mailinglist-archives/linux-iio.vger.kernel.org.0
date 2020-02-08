Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032F115657D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 17:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBHQcN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 11:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgBHQcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 11:32:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFD92082E;
        Sat,  8 Feb 2020 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581179531;
        bh=fMpJ5niI3lEkPpRN/G2ZZ7MgPe4nf7pK0yIIzHEYJaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dHlZL1ruimU8Epq1gzAKA8DnaJd7p7lm/WCLf7K9ojMS+CpDa//4RV4TqbUdm109d
         TLcik4a4KQ58quAWnwuCcLybEwg0xA++IRFctbwfJQIiQ2/JIR0wpRjq4GkvNcWi4d
         UJSCGBfW4X8hNuN4GyMFRx0tA7wo04/XqtstNIaY=
Date:   Sat, 8 Feb 2020 16:32:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dylan Howey <Dylan.Howey@tennantco.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200208163154.4d4f6752@archlinux>
In-Reply-To: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 14:32:40 -0600
Dylan Howey <Dylan.Howey@tennantco.com> wrote:

> FXLS8471Q devices support temperature readout as 8-bit signed value,
> 0.960C/LSB, -40C to 125C.
> 
> Enabling temperature readout reduces the selected ODR by a factor of
> 2, e.g. with ODR set to 800Hz and temperature enabled the sample rate
> will be 400Hz.
That needs to be reflected in the interfaces, so if enabled sampling_frequency
needs to halve.

> 
> Signed-off-by: Dylan Howey <Dylan.Howey@tennantco.com>

Using enable as you have here creates a non standard userspace interface
that is effectively unusable by generic code.  Various suggestions inline
but in short, I'd expect:

1) No enable.  We work that out implicitly.
   A) sysfs read results in temp being enabled for the reading and disabled
      afterwards
   B) buffered read allows for explicit control of whether the temp channel
      is on or not.  If it's enabled then the sampling frequency will half
2) Sampling frequency attribute needs to output the new value if the temp
   channel is enabled.  Don't worry too much on it being missleading for sysfs
   reads, people care about that interface for buffered reads.

Anyhow, good to see this support and bad luck that its a bit fiddly.  I'm
guessing that's why no one has taken it on before!

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 119 ++++++++++++++++++++++++++++++------
>  1 file changed, 101 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index eb6e3dc789b2..016dcc14e96e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -83,8 +83,13 @@
>  #define MMA8452_OFF_X				0x2f
>  #define MMA8452_OFF_Y				0x30
>  #define MMA8452_OFF_Z				0x31
> +#define FXLS8471_CLEAR_DRDY			0x33
> +#define FXLS8471_TEMP_OUT			0x51
> +#define FXLS8471_TEMP_EN_MASK			GENMASK(1, 0)
> +#define FXLS8471_CTRL_REG6			0x5b
> +#define FXLS8471_CTRL_REG7			0x5c
>  
> -#define MMA8452_MAX_REG				0x31
> +#define MMA8452_MAX_REG				0x5c
>  
>  #define  MMA8452_INT_DRDY			BIT(0)
>  #define  MMA8452_INT_FF_MT			BIT(2)
> @@ -103,6 +108,7 @@ struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	u8 ctrl_reg1;
> +	u8 ctrl_reg6;
>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
>  };
> @@ -113,6 +119,7 @@ struct mma8452_data {
>   * @channels:			struct iio_chan_spec matching the device's
>   *				capabilities
>   * @num_channels:		number of channels
> + * @avaiable_scan_masks:		bitmask of available scan elements
>   * @mma_scales:			scale factors for converting register values
>   *				to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>   *				per mode: m/s^2 and micro m/s^2
> @@ -139,6 +146,7 @@ struct mma_chip_info {
>  	u8 chip_id;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> +	unsigned long available_scan_masks[2];
>  	const int mma_scales[3][2];
>  	u8 ev_cfg;
>  	u8 ev_cfg_ele;
> @@ -156,6 +164,7 @@ enum {
>  	idx_x,
>  	idx_y,
>  	idx_z,
> +	idx_temp,
>  	idx_ts,
>  };
>  
> @@ -204,7 +213,7 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  	return 0;
>  }
>  
> -static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
> +static int mma8452_read(struct mma8452_data *data, u8 buf[7])
>  {
>  	int ret = mma8452_drdy(data);
>  
> @@ -216,7 +225,19 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  		return ret;
>  
>  	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
> -					    3 * sizeof(__be16), (u8 *)buf);
> +					    3 * sizeof(__be16), buf);
> +
> +	if (FXLS8471_TEMP_EN_MASK & data->ctrl_reg6) {
> +		buf[6] = i2c_smbus_read_byte_data(data->client,
> +							FXLS8471_TEMP_OUT);

I'd use an extra parameter passed into mma8452_read. Avoids need to end up
with loosing the endian markings.

> +
> +		/*
> +		 * A read of the dummy register 33h is required to reset drdy
> +		 * for the next interrupt cycle after reading the temperature.
> +		 * Value read from register is don't care.
> +		 */
> +		i2c_smbus_read_byte_data(data->client, FXLS8471_CLEAR_DRDY);
> +	}
>  
>  	ret = mma8452_set_runtime_pm_state(data->client, false);
>  
> @@ -454,7 +475,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	__be16 buffer[3];
> +	u8 buffer[7];
>  	int i, ret;
>  
>  	switch (mask) {
> @@ -470,17 +491,37 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(be16_to_cpu(
> -			buffer[chan->scan_index]) >> chan->scan_type.shift,
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			*val = sign_extend32(be16_to_cpu(
> +			*(__be16 *)&buffer[2 * chan->scan_index])
> +			>> chan->scan_type.shift,
>  			chan->scan_type.realbits - 1);
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			if (!(FXLS8471_TEMP_EN_MASK & data->ctrl_reg6))
> +				return -EINVAL;

If it's there and a read occurs, userspace expects to get an answer.
So if this happens you should turn it on and wait appropriate time to
be able to get a reading.

> +
> +			*val = sign_extend32(buffer[6], 7);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
> -		*val = data->chip_info->mma_scales[i][0];
> -		*val2 = data->chip_info->mma_scales[i][1];
> -
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			i = data->data_cfg & MMA8452_DATA_CFG_FS_MASK;
> +			*val = data->chip_info->mma_scales[i][0];
> +			*val2 = data->chip_info->mma_scales[i][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = 960;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		i = mma8452_get_odr_index(data);
>  		*val = mma8452_samp_freq[i][0];
> @@ -517,6 +558,12 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  
>  		*val = mma8452_os_ratio[ret][i];
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 50; /* 0 LSB @ 25 degree C */
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = !!(data->ctrl_reg6 & FXLS8471_TEMP_EN_MASK);
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -731,6 +778,16 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  			}
>  		}
>  		break;
> +
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (val)
> +			data->ctrl_reg6 |= FXLS8471_TEMP_EN_MASK;
> +		else
> +			data->ctrl_reg6 &= ~FXLS8471_TEMP_EN_MASK;
> +		/* Note: enabling temperature reduces ODR by a factor of 2. */

Ouch. That explains the why enable control question. However, it still creates
an unusual userspace interface which basically means no generic code will ever
turn it on.  

Can we instead deal with it as:
1) Sysfs read.   Who cares if the temp read is slow, turn it on only
   when a read occurs.

2) Buffer. Support explicit enable / disable by providing the available_scan_mask
entries and only pay the penalty if it's enabled.  Given there is a sampling
frequency control you need to deal with that changing as well when the
channel is enabled.

> +		return mma8452_change_config(data, FXLS8471_CTRL_REG6,
> +				data->ctrl_reg6);
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -1003,10 +1060,10 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
> +	u8 buffer[16]; /* 3 16-bit channels + temp + padding + ts */
>  	int ret;
>  
> -	ret = mma8452_read(data, (__be16 *)buffer);
> +	ret = mma8452_read(data, buffer);
>  	if (ret < 0)
>  		goto done;
>  
> @@ -1159,6 +1216,19 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
>  }
>  
> +#define FXLS8471_TEMP_CHANNEL { \
> +	.type = IIO_TEMP, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) | \
> +		BIT(IIO_CHAN_INFO_ENABLE), \

Why does this have an enable control?  That would normally be implicit
in us attempting to read from the device, either via sysfs or by enabling
buffered output of the channel.

> +	.scan_index = idx_temp, \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 8, \
> +		.storagebits = 8, \
> +	}, \
> +}
> +
>  static const struct iio_chan_spec mma8451_channels[] = {
>  	MMA8452_CHANNEL(X, idx_x, 14),
>  	MMA8452_CHANNEL(Y, idx_y, 14),
> @@ -1199,6 +1269,15 @@ static const struct iio_chan_spec mma8653_channels[] = {
>  	MMA8652_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
>  };
>  
> +static const struct iio_chan_spec fxls8471_channels[] = {
> +	MMA8452_CHANNEL(X, idx_x, 14),
> +	MMA8452_CHANNEL(Y, idx_y, 14),
> +	MMA8452_CHANNEL(Z, idx_z, 14),
> +	FXLS8471_TEMP_CHANNEL,
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	MMA8452_FREEFALL_CHANNEL(IIO_MOD_X_AND_Y_AND_Z),
> +};
> +
>  enum {
>  	mma8451,
>  	mma8452,
> @@ -1213,6 +1292,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.chip_id = MMA8451_DEVICE_ID,
>  		.channels = mma8451_channels,
>  		.num_channels = ARRAY_SIZE(mma8451_channels),
> +		.available_scan_masks = {0x7, 0},
>  		/*
>  		 * Hardware has fullscale of -2G, -4G, -8G corresponding to
>  		 * raw value -8192 for 14 bit, -2048 for 12 bit or -512 for 10
> @@ -1237,6 +1317,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.chip_id = MMA8452_DEVICE_ID,
>  		.channels = mma8452_channels,
>  		.num_channels = ARRAY_SIZE(mma8452_channels),
> +		.available_scan_masks = {0x7, 0},
>  		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
>  		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> @@ -1253,6 +1334,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.chip_id = MMA8453_DEVICE_ID,
>  		.channels = mma8453_channels,
>  		.num_channels = ARRAY_SIZE(mma8453_channels),
> +		.available_scan_masks = {0x7, 0},
>  		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
>  		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> @@ -1269,6 +1351,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.chip_id = MMA8652_DEVICE_ID,
>  		.channels = mma8652_channels,
>  		.num_channels = ARRAY_SIZE(mma8652_channels),
> +		.available_scan_masks = {0x7, 0},
>  		.mma_scales = { {0, 9577}, {0, 19154}, {0, 38307} },
>  		.ev_cfg = MMA8452_FF_MT_CFG,
>  		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> @@ -1285,6 +1368,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		.chip_id = MMA8653_DEVICE_ID,
>  		.channels = mma8653_channels,
>  		.num_channels = ARRAY_SIZE(mma8653_channels),
> +		.available_scan_masks = {0x7, 0},
>  		.mma_scales = { {0, 38307}, {0, 76614}, {0, 153228} },
>  		.ev_cfg = MMA8452_FF_MT_CFG,
>  		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> @@ -1299,8 +1383,9 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  	},
>  	[fxls8471] = {
>  		.chip_id = FXLS8471_DEVICE_ID,
> -		.channels = mma8451_channels,
> -		.num_channels = ARRAY_SIZE(mma8451_channels),
> +		.channels = fxls8471_channels,
> +		.num_channels = ARRAY_SIZE(fxls8471_channels),
> +		.available_scan_masks = {0xf, 0},
>  		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
>  		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> @@ -1340,8 +1425,6 @@ static const struct iio_info mma8452_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static const unsigned long mma8452_scan_masks[] = {0x7, 0};
> -
>  static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  					      bool state)
>  {
> @@ -1487,7 +1570,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->num_channels;
> -	indio_dev->available_scan_masks = mma8452_scan_masks;
> +	indio_dev->available_scan_masks = data->chip_info->available_scan_masks;
>  
>  	ret = mma8452_reset(client);
>  	if (ret < 0)

