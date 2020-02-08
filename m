Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC604156504
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBHPLY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 10:11:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBHPLY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 10:11:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAE721775;
        Sat,  8 Feb 2020 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581174682;
        bh=uuE7jtGAvfIXIIGpsF1o/kxwGyPLYXUJR9/FPB/NqaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CpJmyW8OgGkklMEvZOWnyDtRTs/RPjuD9uObE3POKKI1P9FswTiowGNd66Ndrn3a+
         bqagylcxlyWWzDaScTCluAkL2gu4N2uS7YPb46sbeDuoYycjlhPmJwknrWUogPY4RB
         FZkjoREW9KX0HsRoj46Q5c9tLQs3R6oWcq9eK/LQ=
Date:   Sat, 8 Feb 2020 15:11:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH 4/5] iio: light: vcnl4000: add control of duty ratio
Message-ID: <20200208151118.2d079214@archlinux>
In-Reply-To: <20200205101655.11728-5-tomas@novotny.cz>
References: <20200205101655.11728-1-tomas@novotny.cz>
        <20200205101655.11728-5-tomas@novotny.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 11:16:54 +0100
Tomas Novotny <tomas@novotny.cz> wrote:

> Duty ratio controls the proximity sensor response time. More information
> is available in the added documentation.

As always there is significant burden to defining custom ABI for
a device.  Generic userspace will have no idea what to do with it.
In this particular case I can't really think of a straight forward
way of mapping this to existing ABI so I guess we will have to
go with custom.  May be better to make it explicit what it is a
duty ratio of.  I initially thought it was of sampling for the
proximity sensor.

Perhaps something in_proximity_led_duty_cycle

A few comments inline.



> 
> Duty ratio is specific only for proximity sensor. Only the vcnl4040 and
> vcnl4200 hardware supports this settings.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 |  18 +++
>  drivers/iio/light/vcnl4000.c                     | 138 ++++++++++++++++++++++-
>  2 files changed, 150 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> new file mode 100644
> index 000000000000..4860f409dbf0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> @@ -0,0 +1,18 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_duty_ratio
> +Date:		February 2020
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Duty ratio controls the proximity sensor response time. It is a
> +		control of on/off led current ratio. The final period depends
> +		also on integration time. The formula is simple: integration
> +		time * duty ratio off part. The settings cannot be changed when
> +		the proximity channel is enabled.  Valid values are in the
> +		respective '_available' attribute.

Fix the cannot be changed, by a disable / modify / enable cycle unless there
is a very strong reason not to do that.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_duty_ratio_available
> +Date:		February 2020
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The on/off available duty ratios.
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 0bad082d762d..a8c2ce1056a6 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -62,6 +62,8 @@
>  #define VCNL4200_AL_SD		BIT(0) /* Ambient light shutdown */
>  #define VCNL4200_PS_IT_MASK	GENMASK(3, 1) /* Proximity integration time */
>  #define VCNL4200_PS_IT_SHIFT	1
> +#define VCNL4200_PS_DUTY_MASK	GENMASK(7, 6) /* Proximity duty ratio */
> +#define VCNL4200_PS_DUTY_SHIFT	6
>  #define VCNL4200_PS_SD		BIT(0) /* Proximity shutdown */
>  
>  enum vcnl4000_device_ids {
> @@ -78,7 +80,7 @@ struct vcnl4200_channel {
>  	struct mutex lock;
>  	const int *int_time;
>  	size_t int_time_size;
> -	int ps_duty_ratio;	/* Proximity specific */
> +	const int *ps_duty_ratio;	/* Proximity specific */
>  };
>  
>  struct vcnl4000_data {
> @@ -132,6 +134,25 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>  	}
>  };
>  
> +static const struct iio_chan_spec_ext_info vcnl4040_ps_ext_info[];
> +
> +static const struct iio_chan_spec vcnl4040_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_ENABLE),
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_ENABLE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.ext_info = vcnl4040_ps_ext_info,
> +	}
> +};
> +static const struct iio_chan_spec_ext_info vcnl4200_ps_ext_info[];
> +
>  static const struct iio_chan_spec vcnl4200_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> @@ -144,6 +165,7 @@ static const struct iio_chan_spec vcnl4200_channels[] = {
>  			BIT(IIO_CHAN_INFO_ENABLE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.ext_info = vcnl4200_ps_ext_info,
>  	}
>  };
>  
> @@ -171,6 +193,68 @@ static const int vcnl4200_ps_int_time[] = {
>  	0, 270
>  };
>  
> +/* Values are directly mapped to register values. */
> +static const int vcnl4040_ps_duty_ratio[] = {
> +	40,
> +	80,
> +	160,
> +	320
> +};
> +
> +static const char * const vcnl4040_ps_duty_ratio_items[] = {
> +	"1/40",
> +	"1/80",
> +	"1/160",
> +	"1/320"
> +};
> +
> +/* Values are directly mapped to register values. */
> +static const int vcnl4200_ps_duty_ratio[] = {
> +	160,
> +	320,
> +	640,
> +	1280
> +};
> +
> +static const char * const vcnl4200_ps_duty_ratio_items[] = {
> +	"1/160",

We don't have any interfaces expressed as a fraction.
Please use decimal, even if it is less compact.

> +	"1/320",
> +	"1/640",
> +	"1/1280"
> +};
> +
> +static int vcnl4200_get_ps_duty_ratio(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan);
> +static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      unsigned int mode);
> +
> +static const struct iio_enum vcnl4040_ps_duty_ratio_enum = {
> +	.items = vcnl4040_ps_duty_ratio_items,
> +	.num_items = ARRAY_SIZE(vcnl4040_ps_duty_ratio_items),
> +	.get = vcnl4200_get_ps_duty_ratio,
> +	.set = vcnl4200_set_ps_duty_ratio,
> +};
> +
> +static const struct iio_enum vcnl4200_ps_duty_ratio_enum = {
> +	.items = vcnl4200_ps_duty_ratio_items,
> +	.num_items = ARRAY_SIZE(vcnl4200_ps_duty_ratio_items),
> +	.get = vcnl4200_get_ps_duty_ratio,
> +	.set = vcnl4200_set_ps_duty_ratio,
> +};
> +
> +static const struct iio_chan_spec_ext_info vcnl4040_ps_ext_info[] = {
> +	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4040_ps_duty_ratio_enum),
> +	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4040_ps_duty_ratio_enum),
> +	{ },
> +};
> +
> +static const struct iio_chan_spec_ext_info vcnl4200_ps_ext_info[] = {
> +	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4200_ps_duty_ratio_enum),
> +	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4200_ps_duty_ratio_enum),
> +	{ },
> +};
> +
>  static const struct regmap_config vcnl4000_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -228,7 +312,11 @@ static int vcnl4200_set_samp_rate(struct vcnl4000_data *data,
>  		if (ret < 0)
>  			return ret;
>  
> -		duty_ratio = data->vcnl4200_ps.ps_duty_ratio;
> +		ret = vcnl4200_get_ps_duty_ratio(iio_priv_to_dev(data), NULL);
> +		if (ret < 0)
> +			return ret;
> +		duty_ratio = data->vcnl4200_ps.ps_duty_ratio[ret];
> +
>  		/*
>  		 * Integration time multiplied by duty ratio.
>  		 * Add 20% of part to part tolerance.
> @@ -236,6 +324,7 @@ static int vcnl4200_set_samp_rate(struct vcnl4000_data *data,
>  		data->vcnl4200_ps.sampling_rate =
>  			ktime_set(((it_val * duty_ratio) * 6) / 5,
>  				  (((it_val2 * duty_ratio) * 6) / 5) * 1000);
> +
Please check patch series for stray whitespace changes like this one.
They add noise and slow down acceptance of patches.
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -284,7 +373,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		data->vcnl4200_ps.int_time = vcnl4200_ps_int_time;
>  		data->vcnl4200_ps.int_time_size =
>  			ARRAY_SIZE(vcnl4200_ps_int_time);
> -		data->vcnl4200_ps.ps_duty_ratio = 160;
> +		data->vcnl4200_ps.ps_duty_ratio = vcnl4200_ps_duty_ratio;
>  		data->al_scale = 24000;
>  		break;
>  	case VCNL4040_PROD_ID:
> @@ -293,7 +382,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		data->vcnl4200_ps.int_time = vcnl4040_ps_int_time;
>  		data->vcnl4200_ps.int_time_size =
>  			ARRAY_SIZE(vcnl4040_ps_int_time);
> -		data->vcnl4200_ps.ps_duty_ratio = 40;
> +		data->vcnl4200_ps.ps_duty_ratio = vcnl4040_ps_duty_ratio;
>  		data->al_scale = 120000;
>  		break;
>  	}
> @@ -512,6 +601,43 @@ static int vcnl4200_set_int_time(struct vcnl4000_data *data,
>  	return -EINVAL;
>  }
>  
> +static int vcnl4200_get_ps_duty_ratio(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	ret = regmap_read(data->regmap, VCNL4200_PS_CONF1, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &= VCNL4200_PS_DUTY_MASK;
> +	val >>= VCNL4200_PS_DUTY_SHIFT;
> +
> +	return val;
> +};
> +
> +static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      unsigned int mode)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	ret = vcnl4200_check_enabled(data, IIO_PROXIMITY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, VCNL4200_PS_CONF1,
> +				 VCNL4200_PS_DUTY_MASK,
> +				 mode << VCNL4200_PS_DUTY_SHIFT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return vcnl4200_set_samp_rate(data, IIO_PROXIMITY);
> +};
> +
>  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  	[VCNL4000] = {
>  		.prod = "VCNL4000",
> @@ -533,8 +659,8 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  	},
>  	[VCNL4040] = {
>  		.prod = "VCNL4040",
> -		.channels = vcnl4200_channels,
> -		.num_channels = ARRAY_SIZE(vcnl4200_channels),
> +		.channels = vcnl4040_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4040_channels),
>  		.regmap_config = &vcnl4200_regmap_config,
>  		.init = vcnl4200_init,
>  		.measure_light = vcnl4200_measure_light,

