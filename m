Return-Path: <linux-iio+bounces-14068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E364A08283
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 22:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D90188A8FF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDF204F94;
	Thu,  9 Jan 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qmfWMDaG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251B204C35
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459639; cv=none; b=Si08SerHgpAVUV6q0g05QETYhe3hVBnbbmBf/Mau98qDCpMWA1IN4xEz1bDAo1h/Q3MB2ama28mscOEP6iy8qbQ4XCKWEiHB7eNq/CgCOD6m/PWuxMHKWaPJwZP9FkmtcrXBdnDO6UPEKlWf0lHBNM4D/S9sup7KaQMg3ofxiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459639; c=relaxed/simple;
	bh=IViWiqbUPuHGrE5FW5Gf4Uj4hepbCN7vI/JBNKDbYU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmeB+M4AIyl6RVxN5QiR47+yUfRac0yRZf+o097ZW9hD70waE2vB+shfo7AM5w08NCvt7qUhYo5hSrsqyYJ9ZJ3CMaWOel8d3XG1XSJbwLtGNlF6D+lR+ODMKQP680/C7wHWui+zDv4N2AjGw1IoovkeyFmd/zArETZQ/YM8LaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qmfWMDaG; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3f291ad6so839607a34.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 13:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736459633; x=1737064433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLxp2RkP2LE2c+rup3BNtH6F8CTJ5zqO3Z2u+e/N1h8=;
        b=qmfWMDaGhZcMz10Yk2XRrqa/CxJcpI9aQCgLIjZ8VzkdblPOTCXsy5ES++yFLQGd+g
         4zDW7AyFdnReVlgzmhUmejUCU595qYjvdWyc9uD6GnIo63z+d1Uze/p0w8H6GQ6ScBsU
         erY1d+igF6ofHUF2vESxo+hKBAAFP+PPJPzEpE69atScZJ+q21Bm52Yz1pfHOxua6Mze
         yQqn4Pq+gWoE7jDvxer1U/s/+lIm0X0Hkgub7T1R97cuoTYsEh6vdD980pZQtypNGZ5C
         s48oYHrosWx+iIMlDT+1vciRQgkpPfvcJ7RCLFdDXuTEGv01h3CoAn6/i4l3C6P2gTdi
         lMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459633; x=1737064433;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLxp2RkP2LE2c+rup3BNtH6F8CTJ5zqO3Z2u+e/N1h8=;
        b=tdeh9yqTyPqy+TLI+WEH65sOuTE5cdVLYB2ySs8iD8jmKkoaKx19p1yUv4SV0CXTAb
         jZV1abbvDsf7UsriAk/kGPVOSy5jMpK0RHLQNg+jgnF+lBFiv3DA9F6HGB+HUVw/6ii0
         7EhAtoM0nD8R0bBQPQCHb5SqW8NRE9nR0yDdxJw537Bnwge2c2nL8HsfXU4JaKxPCQ6Y
         kScu/uOomSSIrrE9lCuBPC6x5Ys/P2INBY3YRwcjqPjFNBe/xzWFcw8I+DoYqR5AokCZ
         zf1Ad1kKh2baeD2Rt0yeyfblf5i22wyC8wYw4h0akk89FwU4XqPaCykwNC0j7Wd7tWkv
         rCzQ==
X-Gm-Message-State: AOJu0YzI+VBJbZS4/FWV4bCpQtJYbC3s/nR89thod2JcEOnp7m5KGWM6
	TDerZ0n0Wu5Wa8mNJDoMtZpmGDesQSCqY8SmMRW/xRa6rIcZpQ0SGdxsfUnOI+Q=
X-Gm-Gg: ASbGncuRoRjxzRJx993aMIBVsJOvmiiWsdEnkv631lnNVbaz/qhC14F4OuKSw59U/x2
	+V0yWedWPpr+nMzLL9Ew4aNO8h0ym3b74SvSZK6Ge/Nbh6jPptvu58lhSXwNO9tPAqihyIJEps5
	AHc36YfoIfd4TWW1zNQw1BW7BlljuZNWStjmGvaI+d0J0wR8AlVH8UEAAlliBEcBI1CgrGmAoTl
	H5CawsPO2ccK04MFPuXxklBxAQXR2IkfAi0ZcC1QSyC0ZBTLfATfCJ0gl+SMbHMvX9FmPxjoxhF
	uHRdh0mmfKJlDYdIog==
X-Google-Smtp-Source: AGHT+IFIY92xuIdpB0r1w87l//fxuG6OW9zOAd8VbTAetPqzjmOcKq5d5KpQULJ6HoNv+ACiIFX5Ow==
X-Received: by 2002:a05:6830:6785:b0:71d:f6d3:9fd2 with SMTP id 46e09a7af769-721e2e9be69mr4662979a34.24.1736459633541;
        Thu, 09 Jan 2025 13:53:53 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f88266d2f7sm542609eaf.23.2025.01.09.13.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 13:53:52 -0800 (PST)
Message-ID: <3ebe506b-17d8-4639-94e2-16ef75a221a5@baylibre.com>
Date: Thu, 9 Jan 2025 15:53:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
To: Guillaume Ranquet <granquet@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
 <20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 7:55 AM, Guillaume Ranquet wrote:
> Some chips of the ad7173 family supports open wire detection.
> 
> Generate a threshold event whenever an external source is disconnected

s/threshold/"openwire"/

> from the system input on single conversions.

And also an event when reconnected.

What about during buffered reads? Is the recommendation that we should do a
single conversion, check for event, do buffered read, do a single conversion,
check for event to ensure that a wire did not become disconnected while doing a
buffered read?

> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/iio/adc/ad7173.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..2f1b506c439249462b9740ff69e7553a37c45943 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -35,6 +35,7 @@
>  #include <linux/units.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -102,6 +103,7 @@
>  
>  #define AD7173_GPIO_PDSW	BIT(14)
>  #define AD7173_GPIO_OP_EN2_3	BIT(13)
> +#define AD4111_GPIO_GP_OW_EN	BIT(12)
>  #define AD7173_GPIO_MUX_IO	BIT(12)
>  #define AD7173_GPIO_SYNC_EN	BIT(11)
>  #define AD7173_GPIO_ERR_EN	BIT(10)
> @@ -149,6 +151,7 @@
>  
>  #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS		8
> +#define AD4111_OW_DET_THRSH_MV		300
>  
>  #define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
>  #define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
> @@ -181,11 +184,15 @@ struct ad7173_device_info {
>  	bool has_int_ref;
>  	bool has_ref2;
>  	bool has_internal_fs_calibration;
> +	bool has_openwire_det;
>  	bool higher_gpio_bits;
>  	u8 num_gpios;
>  };
>  
>  struct ad7173_channel_config {
> +	/* Openwire detection threshold */
> +	unsigned int openwire_thrsh_raw;
> +	int openwire_comp_chan;
>  	u8 cfg_slot;
>  	bool live;
>  
> @@ -202,6 +209,7 @@ struct ad7173_channel {
>  	unsigned int chan_reg;
>  	unsigned int ain;
>  	struct ad7173_channel_config cfg;
> +	bool openwire_det_en;
>  };
>  
>  struct ad7173_state {
> @@ -280,6 +288,7 @@ static const struct ad7173_device_info ad4111_device_info = {
>  	.has_current_inputs = true,
>  	.has_int_ref = true,
>  	.has_internal_fs_calibration = true,
> +	.has_openwire_det = true,
>  	.clock = 2 * HZ_PER_MHZ,
>  	.sinc5_data_rates = ad7173_sinc5_data_rates,
>  	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -616,6 +625,69 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
>  	return 0;
>  }
>  
> +/* Associative array of channel pairs for openwire detection
> + * The array is indexed by ain and gives the associated channel pair
> + * to perform the openwire detection with
> + * the channel pair [0] is for non differential and pair [1]
> + * is for differential inputs

Maybe just me, but it seem like this would be a bit easier to understand if this
was two separate tables even if the code that uses it gets a bit more verbose.

> + */
> +static int openwire_ain_to_channel_pair[][2][2] = {
> +	[0] = { {0, 15},  {1, 2}   },

Not sure if it makes a difference, but the order in the datasheet is 15, 0.

> +	[1] = { {1, 2},   {2, 1}   },
> +	[2] = { {3, 4},   {5, 6}   },
> +	[3] = { {5, 6},   {6, 5}   },
> +	[4] = { {7, 8},   {9, 10}  },
> +	[5] = { {9, 10},  {10, 9}  },
> +	[6] = { {11, 12}, {13, 14} },
> +	[7] = { {13, 14}, {14, 13} },
> +};
> +
> +/* Openwire detection on ad4111 works by running the same input measurement

s/Openwire/Open wire/

> + * on two different channels and compare if the difference between the two
> + * measurements exceeds a certain value (typical 300mV)
> + */
> +static void ad4111_openwire_event(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +	struct ad7173_channel_config *cfg = &adchan->cfg;
> +	int ret, val1, val2;
> +
> +	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
> +	if (ret)

Probably best to return errors to userspace. Or at least log errors instead of
silently ignoring them. Otherwise troubleshooting failures won't be possible
without modifying the kernel.

> +		return;
> +
> +	adchan->cfg.openwire_comp_chan =
> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
> +
> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
> +	if (ret < 0)
> +		goto out;
> +
> +	adchan->cfg.openwire_comp_chan =
> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
> +
> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +	else
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));

Hmm... rising and falling doesn't make so much sense for an openwire event. It
is either "open" or "closed" and doesn't really have a direction. (The threshold
is just an internal implementation detail of how it is detected.)

So maybe we need new IIO_EV_DIR_ members for this too?

I guess we could call it "opening" and "closing" to make it direction-like?

Also, this implementation makes it a level event instead of an edge event.
In other words, on every single conversion, we will get an event. Usually, we
would keep track of the previous value and only emit an event when the state
changes.

> +
> +out:
> +	adchan->cfg.openwire_comp_chan = -1;
> +	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
> +}
> +
>  static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
>  			     unsigned int offset, unsigned int *reg,
>  			     unsigned int *mask)
> @@ -813,6 +885,9 @@ static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
>  	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
>  	      st->channels[channel].ain;
>  
> +	if (st->channels[channel].cfg.openwire_comp_chan >= 0)
> +		channel = st->channels[channel].cfg.openwire_comp_chan;
> +
>  	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
>  }
>  
> @@ -861,6 +936,11 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
>  
>  static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
>  {
> +	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
> +
> +	if (st->channels[chan].cfg.openwire_comp_chan >= 0)
> +		chan = st->channels[chan].cfg.openwire_comp_chan;
> +
>  	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
>  }
>  
> @@ -968,6 +1048,9 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> +		if (ch->openwire_det_en)
> +			ad4111_openwire_event(indio_dev, chan);
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  
> @@ -1112,12 +1195,71 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
>  }
>  
> +static int ad7173_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +
> +	adchan->openwire_det_en = state;
> +
> +	return 0;
> +}
> +
> +static int ad7173_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +				    enum iio_event_type type, enum iio_event_direction dir,
> +				    enum iio_event_info info, int val, int val2)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		adchan->cfg.openwire_thrsh_raw = val;

This difference threshold seems like an internal implementation detail of how
this specific chip handles open wire detection. I'm not sure that writing
this value to the events/in_voltageY_openwire_value attribute makes much sense
from an IIO ABI point of view.

It would be OK with me to just always use 300mV for now. And if we find an
application where that doesn't work, consider adding an adjustment somewhere.
For example, we might find that it makes more sense to put this in the
devictree because it depends on electrical properties of the application.

> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7173_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +				   enum iio_event_type type, enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val, int *val2)
> +{
> +	struct ad7173_state *st = iio_priv(indio_dev);
> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val = adchan->cfg.openwire_thrsh_raw;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_event_spec ad4111_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_OPENWIRE,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_info ad7173_info = {
>  	.read_raw = &ad7173_read_raw,
>  	.write_raw = &ad7173_write_raw,
>  	.debugfs_reg_access = &ad7173_debug_reg_access,
>  	.validate_trigger = ad_sd_validate_trigger,
>  	.update_scan_mode = ad7173_update_scan_mode,

No read_event_config ?

> +	.write_event_config = ad7173_write_event_config,
> +	.write_event_value = ad7173_write_event_value,
> +	.read_event_value = ad7173_read_event_value,
>  };
>  
>  static const struct iio_scan_type ad4113_scan_type = {
> @@ -1321,6 +1463,15 @@ static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
>  	return 0;
>  }
>  
> +static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st, bool differential,
> +					       unsigned int ain0, unsigned int ain1)
> +{
> +	if (differential)

A comment here explaining why this check would be helpful.

> +		return (ain0 % 2) ? (ain0 - 1) == ain1 : (ain0 + 1) == ain1;
> +
> +	return ain1 == AD4111_VINCOM_INPUT;
> +}
> +
>  static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7173_channel *chans_st_arr, *chan_st_priv;
> @@ -1375,6 +1526,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->cfg.bipolar = false;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		chan_st_priv->cfg.openwire_comp_chan = -1;
>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		if (st->info->data_reg_only_16bit)
>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
> @@ -1442,6 +1594,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		chan_st_priv->chan_reg = chan_index;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
> +		chan_st_priv->cfg.openwire_comp_chan = -1;

Setting the same value twice?

>  
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
>  		if (chan_st_priv->cfg.bipolar)
> @@ -1456,6 +1609,17 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  			chan->channel2 = ain[1];
>  			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
> +			if (st->info->has_openwire_det &&
> +			    ad7173_validate_openwire_ain_inputs(st, chan->differential, ain[0], ain[1])) {
> +				chan->event_spec = ad4111_events;
> +				chan->num_event_specs = ARRAY_SIZE(ad4111_events);
> +				chan_st_priv->cfg.openwire_thrsh_raw =
> +					BIT(chan->scan_type.realbits - !!(chan_st_priv->cfg.bipolar))
> +					* AD4111_OW_DET_THRSH_MV
> +					/ ad7173_get_ref_voltage_milli(st, chan_st_priv->cfg.ref_sel);
> +				if (chan->channel < st->info->num_voltage_in_div)
> +					chan_st_priv->cfg.openwire_thrsh_raw /= AD4111_DIVIDER_RATIO;
> +			}
>  		}
>  
>  		if (st->info->data_reg_only_16bit)
> 

Overall, I think the way this is implemented looks reasonable. We'll see how
much Jonathan agrees or disagrees my comments on the ABI stuff. :-)


