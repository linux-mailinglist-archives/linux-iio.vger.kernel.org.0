Return-Path: <linux-iio+bounces-15991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E52A41536
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 07:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6516DC86
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729F1C860D;
	Mon, 24 Feb 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDDKzqcC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A21C84A6;
	Mon, 24 Feb 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377671; cv=none; b=ug4ToMltExQLFVhLvTOzpDqmvDETl/zV5FZTbMNHVbqw36dWo7JebjMqdzD/BTz7sRZ+WLwnp60u8LOkVUsKU/pTvVhtuOuPzVWfDImpZ8X62LODeRwpYZ64+OaVx61tSuzoZ/UTsjYyEMjKfwc/Xr5KVT2jyKjSOuLZcC6TGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377671; c=relaxed/simple;
	bh=z/+pBy5i56eYqVj5wXJDut4aMv6hSqnkB+BARdoJFPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaMVtYjIuAo5bOuuz5E5pMnPj/COzrItDB68T+mlzzIiQAuf9+GC2V4LlXoxPgwV7dXsGScsrFKI9n7+VXbt5tKV8eUW3bnJn0TDziEaj8TfR593ufZ+8CTPI2GFV0JHPKaLxFQJxJeE5Eq02GcXiGyjOOE/YvOv9KkYWk37B6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDDKzqcC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30738a717ffso30696821fa.0;
        Sun, 23 Feb 2025 22:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740377667; x=1740982467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2/AhRT8DSfW/iFYbzjPys2wAflxjAkPB3hNCVPgcpU=;
        b=LDDKzqcCUxku3gGi/9IcZXKsms5Fbq3p94/ewTkrONkDCjKyWCSTiRQYWWtyny3BNl
         QDTuA5iMgQG7QlLc2y4Q12ju+dKhaOV5J7nugNkcrhT1s6uj2iwJ9BbKLu3hoccvp1rw
         9LEv8ARKQYThp9oEqezHastc8fE9sGoLga6maiuvdiNYv1Q69NFtIdsMACyTKGAPJWmN
         bAmQsEhgV9CzRtnKzg3Lq02Nc24DlwFdzIsbTBlwyo8RNwAJLcqflC+I8FEXhaF9vl2e
         AnTtCxd/Gq8BqWHHWtfx9Lgw0nn1rk2kqBG5PXQqk/Mbp2vUZPb1GSiRpx4VAiVn4ajZ
         JPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740377667; x=1740982467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2/AhRT8DSfW/iFYbzjPys2wAflxjAkPB3hNCVPgcpU=;
        b=KbDKorLvp0kAk6nyOGDaoOFzS8ivpv28Rwaloc3J2d60/fF0jINx9aYp/mnzMpZh5a
         I2LOQCCfI2uCdMbUK/a6FQzI2Fi1KAIiuAgU1VVcCjv8OnnMV2Ie5EqIjE34vlRQFegd
         e9Cf6NGB8KhCSQCutGXpEdy3hZJJo6vy47Zn2Qdp1nN9TJKdesMsd0QsbjeIfv0sWW0B
         PFONPrGP/PavYsEqfZlhUWmVnEd/iRRFl8rNEKb8BGnkzRwjkLQDg3QD089UH6lZoZo/
         yKdCtJR0U2VyTTVJGKIIXT1o18e+bDmwDoW6LTuf3En8b/hM246XAxq5nu/fgKLF7wCf
         XiYA==
X-Forwarded-Encrypted: i=1; AJvYcCW/pbEFx9CUpDud22ZZ2JSOQSOdwsK/eirQOaTTOP/zEy/wdKg8KF/iiLmqhOnOERLFN0nc3ORetuo7yAEs@vger.kernel.org, AJvYcCWPwtXdDxuVYyHpiE4+DoLDm2dMaDPEexcULHSf7YwOg2Z/7mXxSLdikDdDn/wpUoy8AD+whC8L+nKWzpcCBUIgH1E=@vger.kernel.org, AJvYcCWpa/9oiwQD3ScvOoFMgOZIczpH/x/MFwCZ5HUxBDYJDAZApjQnXTQOpdOeq0DZKL7ha0fJfVS3Feo9@vger.kernel.org, AJvYcCWtNYjKogV2d3f7vPeMnJ047eCzuRNGJIgq7U9+J/NhJnqf+wWTeh5OAZCHSlTGMyvEpIYHzXqvGJub@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUz32bRoQYlnwu162sUdAluZihjZrQlHaXtin2JqogPU2oqa6
	OzydWXe2MB79+itfAWW+pL6SyRtFsJW09Ot6cztRBvP1XrSUan1x
X-Gm-Gg: ASbGnctu674I+Kby/OiB6svAYcOv6u34mkJuN+8KxtmME8WLBXhZyMKH0m+f9spQ1kD
	LoOhXLa2Z1+2/OLwykn3yWhUCu6Ro3V3jGcD52V+eh/4mBwDnym9dDNM1EzO7685RNoqRN6Gtn/
	zKANI76iNbWdWoYviHxSeMMjQ1SizzLhQL2LcQuZOZwvCtjtvAw7/fy6CGbQgmKXf1UGFqq/eay
	SXNzuLgIHtc6mvdlUUIU6VKIFsEPUMSjckG2KcpecpiNrE5+d/jHEOOLqd8hXAODOJ77MIRy141
	QhrOO28CCCN9hd6tJSRLXzf15Nq0BTSv/xyYhq7INwtJSb7yEU5xTaCSM1uIIkyjOzNsmAd220g
	cT7Cqorg=
X-Google-Smtp-Source: AGHT+IE1bH5ugP5EuU0A9TbSNJydsntvckZB+spkMOEnBoSmkrWPCYe7ceeqNv2veChVyIT0h6M1mw==
X-Received: by 2002:a05:6512:3b06:b0:545:2e85:c152 with SMTP id 2adb3069b0e04-54838f4c9d8mr5459799e87.34.1740377666817;
        Sun, 23 Feb 2025 22:14:26 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e4b08dasm2904602e87.87.2025.02.23.22.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 22:14:26 -0800 (PST)
Message-ID: <125ab96e-1e92-4022-95fe-324cd47ce1d9@gmail.com>
Date: Mon, 24 Feb 2025 08:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Linus Walleij <linus.walleij@linaro.org>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <67b7713724d7591f6321a8f5dfef8cd711f38d34.1739967040.git.mazziesaccount@gmail.com>
 <20250223162807.41960b6b@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250223162807.41960b6b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2025 18:28, Jonathan Cameron wrote:
> On Wed, 19 Feb 2025 14:30:43 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus the driver does not support the BD79124's manual measurement mode
>> but implements the measurements using automatic measurement mode relying
>> on the BD79124's ability of storing latest measurements into register.
>>
>> The driver does also support configuring the threshold events for
>> detecting the out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus the driver masks the received event
>> for a fixed duration (1 second) when an event is handled. This prevents
>> the user-space from choking on the events
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Those pins which don't have corresponding ADC channel node in the
>> device-tree will be controllable as GPO.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> Hi Matti,
> 
> Some fairly superficial review follows. I'm travelling for next few weeks
> so not sure when I'll get time to take a more thorough look.

Yeah, unfortunately people are allowed to have other life beyond the 
ROHM drivers :D
Enjoy your journey(s) ;)

...

>> +
>> +static int bd79124_event_ratelimit_hi(struct bd79124_data *data,
>> +				      unsigned int channel)
>> +{
>> +	int reg, limit;
>> +
>> +	guard(mutex)(&data->mutex);
>> +	data->alarm_suppressed[channel] |= BIT(IIO_EV_DIR_RISING);
>> +
>> +	reg = BD79124_GET_HIGH_LIMIT_REG(channel);
>> +	limit = BD79124_HIGH_LIMIT_MAX;
>> +
>> +	return __bd79124_event_ratelimit(data, reg, limit);
> 
> As below.
> 
>> +}
>> +
>> +static int bd79124_event_ratelimit_lo(struct bd79124_data *data,
>> +				      unsigned int channel)
>> +{
>> +	int reg, limit;
>> +
>> +	guard(mutex)(&data->mutex);
>> +	data->alarm_suppressed[channel] |= BIT(IIO_EV_DIR_FALLING);
>> +
>> +	reg = BD79124_GET_LOW_LIMIT_REG(channel);
>> +	limit = BD79124_LOW_LIMIT_MIN;
>> +
>> +	return __bd79124_event_ratelimit(data, reg, limit);
> 
> I'd put reg and limit inline.  Local variables don't add much as
> their meaning is obvious anyway from what you put in them.

I can do this. The main purpose of those variables was to keep the 
function calls easier to read (on my limited monitor).

>> +}
>> +

...

>> +
>> +static int bd79124_chan_init(struct bd79124_data *data, int channel)
>> +{
>> +	struct bd79124_reg_init inits[] = {
>> +		{ .reg = BD79124_GET_HIGH_LIMIT_REG(channel), .val = 4095 },
>> +		{ .reg = BD79124_GET_LOW_LIMIT_REG(channel), .val = 0 },
>> +	};
>> +	int i, ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(inits); i++) {
>> +		ret = regmap_write(data->map, inits[i].reg, inits[i].val);
>> +		if (ret)
>> +			return ret;
>> +	}
> 
> This is shorter as straight line code rather than a loop. I'd unwind
> it.  Fine to bring in a loop 'setter' like this once the benefit is
> significant.

I suppose you're right. I think loops like this born out of a habit :)

>> +
>> +	return 0;
>> +}
>> +
>> +static bool bd79124_is_in_array(int *arr, int num_items, int val)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < num_items; i++)
>> +		if (arr[i] == val)
>> +			return true;
>> +
>> +	return false;
>> +}
>> +
>> +static int bd79124_mux_init(struct bd79124_data *data)
>> +{
>> +	int adc_chans[BD79124_MAX_NUM_CHANNELS];
>> +	int num_adc, chan, regval = 0;
>> +
>> +	num_adc = iio_adc_device_channels_by_property(data->dev, &adc_chans[0],
>> +						      BD79124_MAX_NUM_CHANNELS,
>> +						      &expected_props);
>> +	if (num_adc < 0)
>> +		return num_adc;
>> +
>> +	/*
>> +	 * Set a mux register bit for each pin which is free to be used as
>> +	 * a GPO.
> For this I would search the simpler iio_chan_spec array rather than passing
> properties again.

I kind of agree. I did it like this because I thought that the 
'iio_adc_device_channels_by_property()' might be useful for other 
callers as well. And, if we had 'iio_adc_device_channels_by_property()' 
- then the code in this driver file becomes simple (as seen here). After 
I looked at the couple of other drivers I didn't easily spot any other 
driver needing the 'iio_adc_device_channels_by_property()' - so I 
suppose it is simpler to drop it and loop through the 'iio_chan_spec' as 
you suggest.

  Just look for gaps.  Or do it in the top level probe()
> function and build a bitmap of which channels are ADC ones from the iio_chan_spec
> array and pass that down here.
> 
>> +	 */
>> +	for (chan = 0; chan < BD79124_MAX_NUM_CHANNELS; chan++)
>> +		if (!bd79124_is_in_array(&adc_chans[0], num_adc, chan))
>> +			regval |= BIT(chan);
>> +
>> +	return regmap_write(data->map, BD79124_REG_PINCFG, regval);
>> +}
>> +
>> +static int bd79124_hw_init(struct bd79124_data *data)
>> +{
>> +	int ret, regval, i;
>> +
>> +	ret = bd79124_mux_init(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
>> +		ret = bd79124_chan_init(data, i);
>> +		if (ret)
>> +			return ret;
>> +		data->alarm_r_limit[i] = 4095;
>> +	}
>> +	/* Stop auto sequencer */
>> +	ret = regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
>> +				BD79124_MASK_SEQ_START);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable writing the measured values to the regsters */
>> +	ret = regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
>> +			      BD79124_MASK_STATS_EN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set no channels to be auto-measured */
>> +	ret = regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, 0x0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set no channels to be manually measured */
>> +	ret = regmap_write(data->map, BD79124_REG_MANUAL_CHANNELS, 0x0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set the measurement interval to 0.75 mS */
>> +	regval = FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
>> +	ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
>> +			BD79124_MASK_AUTO_INTERVAL, regval);
> 
> Where it doesn't make any other difference, align after (
> 
> If you are going shorter, single tab only.

Single tab only? You mean like:

ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
	BD79124_MASK_AUTO_INTERVAL, regval);

Do you prefer that even if the variable holding the return value was 
longer than 8 chars? To me it looks odd if arguments on the next line 
begin earlier than the function on previous line:

longvariable = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
	BD79124_MASK_AUTO_INTERVAL, regval);

(Just ensuring I understood your preference).

> 
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Sequencer mode to auto */
>> +	ret = regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
>> +			      BD79124_MASK_SEQ_SEQ);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Don't start the measurement */
>> +	regval = FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
> What is this for?

Thank's for pointing it out! It is supposed to be used in call below. 
The code works as it is just because the BD79124_CONV_MODE_MANSEQ 
happens to be '0', but it's still better to use FIELD_PREP() for the 
consistency. Below should change from:

>> +	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
>> +			BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
>> +
to:

	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
				  BD79124_MASK_CONV_MODE, regval);

Good catch, thanks! :)

>> +}
>> +
>> +static int bd79124_probe(struct i2c_client *i2c)
>> +{
>> +	struct bd79124_data *data;
>> +	struct iio_dev *iio_dev;
>> +	const struct iio_chan_spec *template;
>> +	struct iio_chan_spec *cs;
>> +	struct device *dev = &i2c->dev;
>> +	int ret;
>> +
>> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!iio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(iio_dev);
>> +	data->dev = dev;
>> +	data->map = devm_regmap_init_i2c(i2c, &bd79124_regmap);
>> +	if (IS_ERR(data->map))
>> +		return dev_err_probe(dev, PTR_ERR(data->map),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
>> +
>> +	data->vmax = ret;
>> +
>> +	ret = devm_regulator_get_enable(dev, "iovdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
>> +
>> +	ret = devm_delayed_work_autocancel(dev, &data->alm_enable_work,
>> +					   bd79124_alm_enable_worker);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (i2c->irq) {
>> +		template = &bd79124_chan_template;
>> +	} else {
>> +		template = &bd79124_chan_template_noirq;
>> +		dev_dbg(dev, "No IRQ found, events disabled\n");
>> +	}
>> +	ret = devm_iio_adc_device_alloc_chaninfo(dev, template, &cs,
>> +						 &expected_props);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	iio_dev->channels = cs;
>> +	iio_dev->num_channels = ret;
>> +	iio_dev->info = &bd79124_info;
>> +	iio_dev->name = "bd79124";
>> +	iio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	data->gc = bd79124gpo_chip;
>> +	data->gc.parent = dev;
>> +
>> +	mutex_init(&data->mutex);
> 
> Whilst it doesn't bring huge advantage, now we have devm_mutex_init()
> it seems reasonable to use it and maybe catch a use after free for the lock.

Ah, indeed. It's a good to learn to 'habitually' use devm_mutex_init().

Yours,
	-- Matti

