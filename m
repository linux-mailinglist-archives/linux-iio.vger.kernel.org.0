Return-Path: <linux-iio+bounces-17150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AAA6A750
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 14:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E99160DB1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70DF20C01C;
	Thu, 20 Mar 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O68C+KO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47E1684AC;
	Thu, 20 Mar 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477905; cv=none; b=Hcq1JurRoqdNuHv2U5uAf7yY+elj3q1e98l3G8TF0nc7vbQBdFnfSnPH3xnI27zZX8zrYfh9740aNDAAbRTxqNHhGtjgJSHfnLDW1wJfmiUTisuBZmbEyR3RmYoCXRA2n9ua0sOALrge+5UoKTGicLN1sMRfiMR77k7eAmNU8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477905; c=relaxed/simple;
	bh=Jj+H64shwC1qPEkffUnCIumApVwzodaf+IxPcGmG08U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuUQ+ohbxjOq9a7iK5iraLkHblmTRnwcxxFvU3nNvwjuj89YiEWb2V9Lqijo71P79dYHwlJk+pue4cH5EKBL0PIGlsosLNUHIaFhbJlqFa9vq8s21MZ+QNoGycEcjpkEGRVcxXVVbNZdf+avNmSbuqnEk/LadK4cDmzQpe1oiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O68C+KO2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549644ae382so1097920e87.1;
        Thu, 20 Mar 2025 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742477901; x=1743082701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2odSbGq3Flj8keql/q8822RZsfO+D58WXChYQfa0hc=;
        b=O68C+KO2SYF7UXchs3j/5hp2Q2bIJjiKYgHiXdJpJfBO+sdpH3Ge/vNFGZK1ELd12s
         XOx9Z2+qsxmVnQsJm0HQe1w5aCqW/DbRxMdXtA65LH2710DJc+UHtSeBVZ3QgzLwkMIz
         hUEBSHvkM2DJ3MdyKSzQ2DLy7xxiaYy1A8VIng8VNESKxsbxJVj9smMgBCNAo+c4UzVY
         4V8nEikUDPvQX1FykO3UTXoDiO9AAj4h37JXB8wRr+34WZrBGuXqK/f7dZWd4Rl7maxF
         OVw4i1Lasm2WMp/eYHxOFw7QWWDwh+8BiMDfKeJWBJWq509VHP40p7n2jOcsmBcrzOCw
         aLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742477901; x=1743082701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2odSbGq3Flj8keql/q8822RZsfO+D58WXChYQfa0hc=;
        b=Pi41375Ruaen+T2IDeal1mt5f3+AQk61VFviRDajkCbyD4OU6BokV25lKSbrdt7rNl
         8ErEIIMyycz97Vm6NkN+SVflHxyi0ji/GnEzdbDxRB+XyrUdcl/PfuHO9RqSEVODt0EN
         fFSLKUrGQyc3EPhvkPNmD+rrzd8qrHc4z1+3JgkqgKD6aVzDIZsRd119LVWxLvgyw/f1
         3acMfnP1jKsYdHvm9Xuwb36VodPiLflN+UJOdrC3Ir87RNHgP1KxttiouOtWpFShrcHw
         hS1ixjYFfIiOiTVy8jfPxHeraSOFmmUyhE3zjNa8wVF8rAOskjY+1CgNiaDUr2jiGyTn
         V77g==
X-Forwarded-Encrypted: i=1; AJvYcCW331/uVCwDhRr05d8t4n762ibGx9/W2hQVcrByUlLHwcuU/vzBXw+lNUhdGr1pfO69twwFQ5xPrBs=@vger.kernel.org, AJvYcCWQ4db8LmhWbRjKsYA/6AAlYtU9if4FRaKFdW9UGaDtolgEynXbB43Bge1Zd193n2iX/J7dq3NTJC9HtMT9@vger.kernel.org
X-Gm-Message-State: AOJu0YyYznb1+2BoelT1BaAb43JPIg/H5PM5LE7Ib2MKWlfCCJVsY2Xo
	DhPXbE4Mxc6ZUSOZkycpUa8LvZmWNzockKqCbCJYEsz8JN/3KE4D
X-Gm-Gg: ASbGncu4OD0mRiSYbuu3LcpYICCDC3RMMsyjAnrsq857hHVJ7ZrzDiA75jFHdo3s3/j
	Qje+sBF3ePyxyNTlTo7j70Qfxvwdi9Q8Faj8SwN6TYq2CATq0GmlLTX6M9ThRB9DqeswvOKHbjE
	jyJeUNh4h88OR8cQvKXlBTF6YCQG5/oCFK5fHXvv2Xlvjue2rVwcsPwOev+JHh1nDu9B15hTB8F
	4yTqi0BhJGqh95rrUDc0FR2cBQaHBtl3pnhNcu+8NmGYfiySPyGx43WTwweGM4SlJVCF/cv8uer
	fgXjnSycQMt2ZS/AVEBtb4SEg4y9LQ7OxuqYFXTHx43cIUP1aFJiE7SQkPhnvpbIKdHvHFyl749
	43tMmoFYdFB/xkn+3rRF7WQnAMQ==
X-Google-Smtp-Source: AGHT+IEgd6byKAeY7qzrJjCMOK9W1nbiR+AI7o6qvv+BnKcNPHZVanpPfilt2/xRUP0r0z6MU0dkxw==
X-Received: by 2002:a05:6512:2255:b0:545:f9c:a80f with SMTP id 2adb3069b0e04-54ad0619d84mr828014e87.1.1742477901081;
        Thu, 20 Mar 2025 06:38:21 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c1a48sm2208291e87.87.2025.03.20.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:38:19 -0700 (PDT)
Message-ID: <3e618f7c-891f-42fa-86b7-1383e55c3fb2@gmail.com>
Date: Thu, 20 Mar 2025 15:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 15:16, Andy Shevchenko wrote:
> On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus do not support the BD79124's manual measurement mode but implement
>> the measurements using automatic measurement mode, relying on the
>> BD79124's ability of storing latest measurements into register.
>>
>> Support also configuring the threshold events for detecting the
>> out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus, prevent the user-space from choking
>> on the events and mask the received event for a fixed duration (1 second)
>> when an event is handled.
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Make those pins which don't have corresponding ADC channel node in the
>> device-tree controllable as GPO.
> 
> ...
> 
>> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
>> +{
>> +	struct bd79124_data *data = gpiochip_get_data(gc);
>> +
>> +	if (value)
>> +		regmap_set_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
>> +	else
>> +		regmap_clear_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
> 
> Hmm... Is there still any obstacle to use regmap_assign_bits()?

No. I missed this by accident. Thanks for the patience :)

>> +}
> 
> ...
> 
>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +				    unsigned long *bits)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +	struct bd79124_data *data = gpiochip_get_data(gc);
>> +
>> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
>> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
>> +	if (ret)
>> +		return;
> 
>> +	if ((val & *mask) != *mask) {
> 
> This is basically an equivalent to
> 
> 	if (val ^ *mask) {

Right.

>> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
> 
>> +		/* Do not set value for pins configured as ADC inputs */
>> +		*mask &= val;
> 
> But this still puzzles me. If we have a valid_mask set, this should never
> happen. Maybe I missed something, though.

I think I already replied this. Wonder if my message was lost. Well, 
here's a recap:

"It can until this gets merged:
https://lore.kernel.org/all/cd5e067b80e1bb590027bc3bfa817e7f794f21c3.1741180097.git.mazziesaccount@gmail.com/

Furthermore, the cost of the check is fairly low. Knowing that the
drivers tend to get backported (because very few if any device makers
use latest kernels) I will keep it here for couple of cycles."

> On top of that I have just realised that you modifying the input here

Valid point. I didn't think of that.

> which may ne quite surprising (I dunno why we don't have const specifier
> in the callbacks from day 1.
> 
>> +	}
>> +
>> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
>> +}
> 
> ...
> 
>> +struct bd79124_raw {
>> +	u8 val_bit0_3; /* Is set in high bits of the byte */
>> +	u8 val_bit4_11;
>> +};
> 
> Again, this is confusing.
> 
> Just put a bit order map in the comment as I suggested previously.
> When I see variable name containing bit range like above I think
> about the same bit order, i.e. with your comment it makes like this
> 
> bit number	7 6 5 4 3 2 1 0
> data bit	0 1 2 3 x x x x
> 
> All the same for the second variable.

I find this very confusing. I wonder if you missed my previous reply? 
Just in case you did:
https://lore.kernel.org/all/dc241efd-fcb1-4d2d-9009-b5e4d9fc9b68@gmail.com/

> 
>> +#define BD79124_RAW_TO_INT(r) ((r.val_bit4_11 << 4) | (r.val_bit0_3 >> 4))
>> +#define BD79124_INT_TO_RAW(val) {					\
>> +	.val_bit4_11 = (val) >> 4,					\
>> +	.val_bit0_3 = (val) << 4,					\
>> +}
>> +
>> +/*
>> + * The high and low limits as well as the recent result values are stored in
>> + * the same way in 2 consequent registers. The first register contains 4 bits
>> + * of the value. These bits are stored in the high bits [7:4] of register, but
>> + * they represent the low bits [3:0] of the value.
>> + * The value bits [11:4] are stored in the next register.
>> + *
>> + * Read data from register and convert to integer.
>> + */
>> +static int bd79124_read_reg_to_int(struct bd79124_data *data, int reg,
>> +				   unsigned int *val)
>> +{
>> +	int ret;
>> +	struct bd79124_raw raw;
>> +
>> +	ret = regmap_bulk_read(data->map, reg, &raw, sizeof(raw));
>> +	if (ret) {
>> +		dev_dbg(data->dev, "bulk_read failed %d\n", ret);
>> +
>> +		return ret;
>> +	}
>> +
>> +	*val = BD79124_RAW_TO_INT(raw);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * The high and low limits as well as the recent result values are stored in
>> + * the same way in 2 consequent registers. The first register contains 4 bits
>> + * of the value. These bits are stored in the high bits [7:4] of register, but
>> + * they represent the low bits [3:0] of the value.
>> + * The value bits [11:4] are stored in the next register.
> 
> And you probably don't need a long comment copied twice when data type is well
> described.

I did also explain in the previous reply why I think the correct place 
for this doc is the function documentation.

>> + * Convert the integer to register format and write it using rmw cycle.
>> + */
>> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
>> +				    unsigned int val)
>> +{
>> +	struct bd79124_raw raw = BD79124_INT_TO_RAW(val);
>> +	unsigned int tmp;
>> +	int ret;
>> +
>> +	ret = regmap_read(data->map, reg, &tmp);
>> +	if (ret)
>> +		return ret;
> 
>> +	raw.val_bit0_3 |= (tmp & 0xf);
> 
> Parentheses are not needed. Bit we already discussed that and it's principal
> disagreement between us. :-(
> 
>> +	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
>> +}
> 
> ...
> 
>> +static const struct iio_chan_spec bd79124_chan_template = {
>> +	.type = IIO_VOLTAGE,
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +	.indexed = 1,
>> +	.event_spec = bd79124_events,
>> +	.num_event_specs = ARRAY_SIZE(bd79124_events),
> 
> + array_size.h which is missing.

Thanks!

>> +};
> 
> ...
> 
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		if (dir == IIO_EV_DIR_RISING)
>> +			*val = data->alarm_r_limit[chan->channel];
>> +		else if (dir == IIO_EV_DIR_FALLING)
>> +			*val = data->alarm_f_limit[chan->channel];
>> +		else
>> +			return -EINVAL;
>> +
>> +		return IIO_VAL_INT;
> 
>> +
> 
> Blank line...
> 
>> +	case IIO_EV_INFO_HYSTERESIS:
>> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
>> +		ret = regmap_read(data->map, reg, val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val &= BD79124_MSK_HYSTERESIS;
>> +		/*
>> +		 * The data-sheet says the hysteresis register value needs to be
>> +		 * sifted left by 3.
>> +		 */
>> +		*val <<= 3;
>> +
>> +		return IIO_VAL_INT;
> 
> ...no blank line. Can you choose one style and use it everywhere?

Ok.

>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> ...
> 
>> +	case IIO_CHAN_INFO_RAW:
>> +	{
>> +		unsigned int old_chan_cfg, regval;
>> +		int tmp;
> 
> This tmp sounds to me like
> 
> 		int ret2; // or rc, retval, etc.

I prefer tmp as it indicates this is really a value which is used to 
store a temporary data. For me ret, rc and retval sound like something 
that is returned to the caller.

> 
>> +		guard(mutex)(&data->mutex);
>> +
>> +		/*
>> +		 * Start the automatic conversion. This is needed here if no
>> +		 * events have been enabled.
>> +		 */
>> +		regval = FIELD_PREP(BD79124_MSK_CONV_MODE,
>> +				    BD79124_CONV_MODE_AUTO);
>> +		ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
>> +					 BD79124_MSK_CONV_MODE, regval);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = bd79124_single_chan_seq(data, chan->channel, &old_chan_cfg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* The maximum conversion time is 6 uS. */
>> +		udelay(6);
>> +
>> +		ret = bd79124_read_reg_to_int(data,
>> +			BD79124_GET_RECENT_RES_REG(chan->channel), val);
>> +		/*
>> +		 * Return the old chan config even if data reading failed in
>> +		 * order to re-enable the event monitoring.
>> +		 */
>> +		tmp = bd79124_single_chan_seq_end(data, old_chan_cfg);
>> +		if (tmp)
>> +			dev_err(data->dev,
>> +				"Failed to return config. Alarms may be disabled\n");
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	}
> 
> ...
> 
>> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
>> +		u64 ecode;
>> +
>> +		if (BIT(i) & i_hi) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_RISING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
>> +			/*
>> +			 * The BD79124 keeps the IRQ asserted for as long as
>> +			 * the voltage exceeds the threshold. It causes the IRQ
>> +			 * to keep firing.
>> +			 *
>> +			 * Disable the event for the channel and schedule the
>> +			 * re-enabling the event later to prevent storm of
>> +			 * events.
>> +			 */
>> +			ret = bd79124_event_ratelimit_hi(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +		if (BIT(i) & i_lo) {
> 
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +						     IIO_EV_TYPE_THRESH,
>> +						     IIO_EV_DIR_FALLING);
>> +
>> +			iio_push_event(iio_dev, ecode, data->timestamp);
> 
> Sounds like possibility to deduplicate as the above only differs by ecode.

I am unsure what 'deduplicate' means?

> 
>> +			ret = bd79124_event_ratelimit_lo(data, i);
>> +			if (ret)
>> +				return IRQ_NONE;
>> +		}
>> +	}
> 
> ...
> 
>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
>> +		BD79124_MAX_NUM_CHANNELS - 1, &cs);
>> +	if (ret < 0) {
>> +		/* Register all pins as GPOs if there are no ADC channels */
>> +		if (ret == -ENOENT)
>> +			goto register_gpios;
> 
> It's possible to move outside of the above conditional, but I think I got your
> idea, however it is still not a hot path.

As I replied earlier, I liked the comment you suggested, but dislike 
having two checks instead of one in the usual operation. It's not like 
this caused too deep nesting or anything.

>> +		return ret;
>> +	}

Yours,
	-- Matti

