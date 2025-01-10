Return-Path: <linux-iio+bounces-14097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00001A08E7D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFF3A6950
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899E206F06;
	Fri, 10 Jan 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ryYLQhtY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D191205AB9
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506250; cv=none; b=kS6ZIloCSPPAvKYJvoUo2gHljDi25UUr9mZ8p12gNj1rVCVYHfo7VIHHr0Wf5vk4ZnxL73L0qP8s4x1wl4i11YcptvP5VpkbtxK1sRSTWp1BrPAwhKD5aFjaRYnOgWFgO79gMfJ7FrO/FUJt8UaNkG2aPBEiN2k+0E3vBsCbs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506250; c=relaxed/simple;
	bh=fpjOfs1AyD4wMlPVoEUw6g8qjkVfZcr5nl2Lxl+kMEg=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjCH0ICbJtBG7PJ0rVcRQv54SEmbu8YPGVUE/LEXaJhBj+UNr4QKdZjpwJkMYc3qMZIwnwazm/KDDbMlnCjSGd/QTlOV+WgLAqWYYughPoj8zsIE6jDkzr5FMcHGp3wwjquxJwperqe2dPq4GNDAbo9d0mOSBPAfWMcaMOdE3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ryYLQhtY; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so921140fac.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736506246; x=1737111046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwRNi6LqKYd9T/c+jcp5b1H6FO0EfdqkIs65QPPqqOo=;
        b=ryYLQhtYzMK7m6R6lIZ2+xKkZaQ/UtWkxFX6JasXz7ILdFZLhaKMv06SicAKwqhxa9
         X5sMPk5jTok2s0r1Q/wEEXR76YAJPhVyk+iKoXVO7ZlHJx88NH2cyJ81tpy6yA5+Kag1
         v79CmAGx2gZc0UP1yqFzqZCZ0WwOqrLA4M80mcc7DtkrV5sQw39xRla++5fnZt76QYIc
         0wXQLIBgM5pfB7sxs7dhbAsdCNcr2/MuNLmvuudBEI1UuJcH/Y5E6y1nBlUFNqGV63fq
         3hfm0szdxrQIu7x8JH91M21fD8kFbiGA9CxhAyJsaJXg7fOBBLkcmbH51SnGO1xtkFsO
         YBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506246; x=1737111046;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwRNi6LqKYd9T/c+jcp5b1H6FO0EfdqkIs65QPPqqOo=;
        b=IAH3ql4j8C15q5IphhAqMked4rcbYRf1AgMQcdDLg6l04ICLcffDZQX8bSRaMuCf87
         q9Et6+7TK7/UBPSRIg/XMj5BdZLaLTlv9FcH2YZQXxS61xEGGwM25WntfqoVTiykj3TP
         goGGRAilRKBisqn/MIm+GAEwDuhlTZwbzTeM6eZG0ubgl6MnVE4vacrmjfcKeTczedrA
         iuNIQLa1uXXg/b44hN3n5xBJyGuQHrdvyFZKQ3hGWUkPlE4RMdpYmem+Tu8zV4hoKNFm
         aRFQApk5WfKqci6848ljsfM/JOGZkCZaSwZLN2GOsnTRKTGr6v6h+5Jra895edMwbtce
         vl1Q==
X-Gm-Message-State: AOJu0YyewOx7AzNp/WactGOG6jAiuNvPeb9aH8DlL0zoAAyn4UT404ew
	Fs4wwGdHORhochc/6sZJO7PLmWAwC7F9mIfDF8h+V/oGq4SaDS5dUc+4uibFSz7Q8YfMvJuXCVM
	8GpS8vhKlS4MgNQozO/9LmFdDlyziCEwi73I1eg==
X-Gm-Gg: ASbGnctXzTDTgKMD7ZcrhDPlyq9/Bc+dgN1B3v5utGUz464U2GrWvXJ92sy65n7OKp9
	UGv0qnsakBa6WheEQ8PVWnwNf8rsW+WsGZl1q
X-Google-Smtp-Source: AGHT+IGlTqNLcT/PnHkeweyAyWZAcIHxNchOkrmpM+SGxcrXUeLYutL5q/zwNWH6YJ7jgTS5lXffai+9/lyVB/LRNDM=
X-Received: by 2002:a05:6870:ae85:b0:2a3:8280:c23e with SMTP id
 586e51a60fabf-2aa06970212mr5056275fac.39.1736506246190; Fri, 10 Jan 2025
 02:50:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jan 2025 05:50:45 -0500
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.10
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
 <20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com> <3ebe506b-17d8-4639-94e2-16ef75a221a5@baylibre.com>
In-Reply-To: <3ebe506b-17d8-4639-94e2-16ef75a221a5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 Jan 2025 05:50:45 -0500
X-Gm-Features: AbW1kvZ5kZtwYOSwFEAd1_Mk4OHj3HnYAKegS6E154VR0Rl8-zsbQuETClO-ZRo
Message-ID: <CABnWg9uhso0S14eQa6uF6a4wwrmiHqo4HMLxvaKhxsjeCta7Yg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 09 Jan 2025 22:53, David Lechner <dlechner@baylibre.com> wrote:
>On 1/9/25 7:55 AM, Guillaume Ranquet wrote:
>> Some chips of the ad7173 family supports open wire detection.
>>
>> Generate a threshold event whenever an external source is disconnected
>
>s/threshold/"openwire"/
>
>> from the system input on single conversions.
>
>And also an event when reconnected.
>
>What about during buffered reads? Is the recommendation that we should do a
>single conversion, check for event, do buffered read, do a single conversion,
>check for event to ensure that a wire did not become disconnected while doing a
>buffered read?

With the current design of the ad7173/ad_sigma_delta, the buffered
read enables continuous mode.

Continuous mode makes the ADC cycle through all enabled channels
automatically.

So, enabling open wire detection during buffered reads has its own
challenges:
* Assigning channels gets more complicated in the current state of the
	driver
* We divide the number of possible channels by two (or even three
	depending on the gymnastic we did when assigning channels).
* Timing performance will suffer as twice as many conversions needs to
	happen
* Accuracy might also suffer as we would need to keep
	AD4111_GPIO_GP_OW_EN enabled at all times.

So, I don't know what the recommendation is, but having open wire
detection enabled during buffered reads seems complex (and is it worth
the performance penalties?).

Another way of doing it would be to decouple open wire detection from
single conversions and create a new channel property instead of an
event.

The property would trigger the two conversions needed for open wire
detection and return synchronously the current status of the channel.

What happens when the user reads the "open wire" property when a
buffered read is in progress?

* Pause the buffered read, do the open wire detection and resume?
* Return an error signaling openwire detection doesn't work when a
	concurrent buffered read is in progress?
>
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7173.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 164 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> index 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..2f1b506c439249462b9740ff69e7553a37c45943 100644
>> --- a/drivers/iio/adc/ad7173.c
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/units.h>
>>
>>  #include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>> @@ -102,6 +103,7 @@
>>
>>  #define AD7173_GPIO_PDSW	BIT(14)
>>  #define AD7173_GPIO_OP_EN2_3	BIT(13)
>> +#define AD4111_GPIO_GP_OW_EN	BIT(12)
>>  #define AD7173_GPIO_MUX_IO	BIT(12)
>>  #define AD7173_GPIO_SYNC_EN	BIT(11)
>>  #define AD7173_GPIO_ERR_EN	BIT(10)
>> @@ -149,6 +151,7 @@
>>
>>  #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
>>  #define AD7173_MAX_CONFIGS		8
>> +#define AD4111_OW_DET_THRSH_MV		300
>>
>>  #define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
>>  #define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
>> @@ -181,11 +184,15 @@ struct ad7173_device_info {
>>  	bool has_int_ref;
>>  	bool has_ref2;
>>  	bool has_internal_fs_calibration;
>> +	bool has_openwire_det;
>>  	bool higher_gpio_bits;
>>  	u8 num_gpios;
>>  };
>>
>>  struct ad7173_channel_config {
>> +	/* Openwire detection threshold */
>> +	unsigned int openwire_thrsh_raw;
>> +	int openwire_comp_chan;
>>  	u8 cfg_slot;
>>  	bool live;
>>
>> @@ -202,6 +209,7 @@ struct ad7173_channel {
>>  	unsigned int chan_reg;
>>  	unsigned int ain;
>>  	struct ad7173_channel_config cfg;
>> +	bool openwire_det_en;
>>  };
>>
>>  struct ad7173_state {
>> @@ -280,6 +288,7 @@ static const struct ad7173_device_info ad4111_device_info = {
>>  	.has_current_inputs = true,
>>  	.has_int_ref = true,
>>  	.has_internal_fs_calibration = true,
>> +	.has_openwire_det = true,
>>  	.clock = 2 * HZ_PER_MHZ,
>>  	.sinc5_data_rates = ad7173_sinc5_data_rates,
>>  	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
>> @@ -616,6 +625,69 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
>>  	return 0;
>>  }
>>
>> +/* Associative array of channel pairs for openwire detection
>> + * The array is indexed by ain and gives the associated channel pair
>> + * to perform the openwire detection with
>> + * the channel pair [0] is for non differential and pair [1]
>> + * is for differential inputs
>
>Maybe just me, but it seem like this would be a bit easier to understand if this
>was two separate tables even if the code that uses it gets a bit more verbose.
>
>> + */
>> +static int openwire_ain_to_channel_pair[][2][2] = {
>> +	[0] = { {0, 15},  {1, 2}   },
>
>Not sure if it makes a difference, but the order in the datasheet is 15, 0.
>
>> +	[1] = { {1, 2},   {2, 1}   },
>> +	[2] = { {3, 4},   {5, 6}   },
>> +	[3] = { {5, 6},   {6, 5}   },
>> +	[4] = { {7, 8},   {9, 10}  },
>> +	[5] = { {9, 10},  {10, 9}  },
>> +	[6] = { {11, 12}, {13, 14} },
>> +	[7] = { {13, 14}, {14, 13} },
>> +};
>> +
>> +/* Openwire detection on ad4111 works by running the same input measurement
>
>s/Openwire/Open wire/
>
>> + * on two different channels and compare if the difference between the two
>> + * measurements exceeds a certain value (typical 300mV)
>> + */
>> +static void ad4111_openwire_event(struct iio_dev *indio_dev,
>> +				  const struct iio_chan_spec *chan)
>> +{
>> +	struct ad7173_state *st = iio_priv(indio_dev);
>> +	struct ad7173_channel *adchan = &st->channels[chan->address];
>> +	struct ad7173_channel_config *cfg = &adchan->cfg;
>> +	int ret, val1, val2;
>> +
>> +	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
>> +	if (ret)
>
>Probably best to return errors to userspace. Or at least log errors instead of
>silently ignoring them. Otherwise troubleshooting failures won't be possible
>without modifying the kernel.
>
>> +		return;
>> +
>> +	adchan->cfg.openwire_comp_chan =
>> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
>> +
>> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	adchan->cfg.openwire_comp_chan =
>> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
>> +
>> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
>> +		iio_push_event(indio_dev,
>> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
>> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_RISING),
>> +			       iio_get_time_ns(indio_dev));
>> +	else
>> +		iio_push_event(indio_dev,
>> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
>> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_FALLING),
>> +			       iio_get_time_ns(indio_dev));
>
>Hmm... rising and falling doesn't make so much sense for an openwire event. It
>is either "open" or "closed" and doesn't really have a direction. (The threshold
>is just an internal implementation detail of how it is detected.)
>
>So maybe we need new IIO_EV_DIR_ members for this too?
>
>I guess we could call it "opening" and "closing" to make it direction-like?
>
>Also, this implementation makes it a level event instead of an edge event.
>In other words, on every single conversion, we will get an event. Usually, we
>would keep track of the previous value and only emit an event when the state
>changes.
>
>> +
>> +out:
>> +	adchan->cfg.openwire_comp_chan = -1;
>> +	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
>> +}
>> +
>>  static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
>>  			     unsigned int offset, unsigned int *reg,
>>  			     unsigned int *mask)
>> @@ -813,6 +885,9 @@ static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
>>  	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
>>  	      st->channels[channel].ain;
>>
>> +	if (st->channels[channel].cfg.openwire_comp_chan >= 0)
>> +		channel = st->channels[channel].cfg.openwire_comp_chan;
>> +
>>  	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
>>  }
>>
>> @@ -861,6 +936,11 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
>>
>>  static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
>>  {
>> +	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
>> +
>> +	if (st->channels[chan].cfg.openwire_comp_chan >= 0)
>> +		chan = st->channels[chan].cfg.openwire_comp_chan;
>> +
>>  	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
>>  }
>>
>> @@ -968,6 +1048,9 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
>>  		if (ret < 0)
>>  			return ret;
>>
>> +		if (ch->openwire_det_en)
>> +			ad4111_openwire_event(indio_dev, chan);
>> +
>>  		return IIO_VAL_INT;
>>  	case IIO_CHAN_INFO_SCALE:
>>
>> @@ -1112,12 +1195,71 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>>  	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
>>  }
>>
>> +static int ad7173_write_event_config(struct iio_dev *indio_dev,
>> +				     const struct iio_chan_spec *chan,
>> +				     enum iio_event_type type,
>> +				     enum iio_event_direction dir,
>> +				     bool state)
>> +{
>> +	struct ad7173_state *st = iio_priv(indio_dev);
>> +	struct ad7173_channel *adchan = &st->channels[chan->address];
>> +
>> +	adchan->openwire_det_en = state;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ad7173_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
>> +				    enum iio_event_type type, enum iio_event_direction dir,
>> +				    enum iio_event_info info, int val, int val2)
>> +{
>> +	struct ad7173_state *st = iio_priv(indio_dev);
>> +	struct ad7173_channel *adchan = &st->channels[chan->address];
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		adchan->cfg.openwire_thrsh_raw = val;
>
>This difference threshold seems like an internal implementation detail of how
>this specific chip handles open wire detection. I'm not sure that writing
>this value to the events/in_voltageY_openwire_value attribute makes much sense
>from an IIO ABI point of view.
>
>It would be OK with me to just always use 300mV for now. And if we find an
>application where that doesn't work, consider adding an adjustment somewhere.
>For example, we might find that it makes more sense to put this in the
>devictree because it depends on electrical properties of the application.
>

The datasheet suggests 300mV, I don't know what factors could make this
threshold change.
I agree we could hardcode it as a first approach.

>> +		return 0;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ad7173_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
>> +				   enum iio_event_type type, enum iio_event_direction dir,
>> +				   enum iio_event_info info, int *val, int *val2)
>> +{
>> +	struct ad7173_state *st = iio_priv(indio_dev);
>> +	struct ad7173_channel *adchan = &st->channels[chan->address];
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		*val = adchan->cfg.openwire_thrsh_raw;
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_event_spec ad4111_events[] = {
>> +	{
>> +		.type = IIO_EV_TYPE_OPENWIRE,
>> +		.dir = IIO_EV_DIR_EITHER,
>> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>>  static const struct iio_info ad7173_info = {
>>  	.read_raw = &ad7173_read_raw,
>>  	.write_raw = &ad7173_write_raw,
>>  	.debugfs_reg_access = &ad7173_debug_reg_access,
>>  	.validate_trigger = ad_sd_validate_trigger,
>>  	.update_scan_mode = ad7173_update_scan_mode,
>
>No read_event_config ?
>
>> +	.write_event_config = ad7173_write_event_config,
>> +	.write_event_value = ad7173_write_event_value,
>> +	.read_event_value = ad7173_read_event_value,
>>  };
>>
>>  static const struct iio_scan_type ad4113_scan_type = {
>> @@ -1321,6 +1463,15 @@ static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
>>  	return 0;
>>  }
>>
>> +static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st, bool differential,
>> +					       unsigned int ain0, unsigned int ain1)
>> +{
>> +	if (differential)
>
>A comment here explaining why this check would be helpful.
>
>> +		return (ain0 % 2) ? (ain0 - 1) == ain1 : (ain0 + 1) == ain1;
>> +
>> +	return ain1 == AD4111_VINCOM_INPUT;
>> +}
>> +
>>  static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  {
>>  	struct ad7173_channel *chans_st_arr, *chan_st_priv;
>> @@ -1375,6 +1526,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  		chan_st_priv->cfg.bipolar = false;
>>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>> +		chan_st_priv->cfg.openwire_comp_chan = -1;
>>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>>  		if (st->info->data_reg_only_16bit)
>>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
>> @@ -1442,6 +1594,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  		chan_st_priv->chan_reg = chan_index;
>>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>>  		chan_st_priv->cfg.odr = 0;
>> +		chan_st_priv->cfg.openwire_comp_chan = -1;
>
>Setting the same value twice?
>
>>
>>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
>>  		if (chan_st_priv->cfg.bipolar)
>> @@ -1456,6 +1609,17 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>>  			chan->channel2 = ain[1];
>>  			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>> +			if (st->info->has_openwire_det &&
>> +			    ad7173_validate_openwire_ain_inputs(st, chan->differential, ain[0], ain[1])) {
>> +				chan->event_spec = ad4111_events;
>> +				chan->num_event_specs = ARRAY_SIZE(ad4111_events);
>> +				chan_st_priv->cfg.openwire_thrsh_raw =
>> +					BIT(chan->scan_type.realbits - !!(chan_st_priv->cfg.bipolar))
>> +					* AD4111_OW_DET_THRSH_MV
>> +					/ ad7173_get_ref_voltage_milli(st, chan_st_priv->cfg.ref_sel);
>> +				if (chan->channel < st->info->num_voltage_in_div)
>> +					chan_st_priv->cfg.openwire_thrsh_raw /= AD4111_DIVIDER_RATIO;
>> +			}
>>  		}
>>
>>  		if (st->info->data_reg_only_16bit)
>>
>
>Overall, I think the way this is implemented looks reasonable. We'll see how
>much Jonathan agrees or disagrees my comments on the ABI stuff. :-)

Thx for the review,
Guillaume.

