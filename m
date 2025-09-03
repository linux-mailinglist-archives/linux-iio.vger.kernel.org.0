Return-Path: <linux-iio+bounces-23667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21AB41595
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 08:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EAA189FE15
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 06:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBD1E2307;
	Wed,  3 Sep 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFv6ec95"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC572D8DD1;
	Wed,  3 Sep 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882329; cv=none; b=OxP/kfrpM1wNDDyk7lTDYK6CraCJKvGRnxAWs9km1j9OWSFV12Ou/SliUni/9s9zWuJZ/HL6dmpWG1/bx04XHHtltVmWMJiJHE2WmmQGIDGi+L/a8Hzd6MKv5FXJVBp0PALA6yTZMIc7OabAYIRj1gH+epQzFcgiWql60MC2TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882329; c=relaxed/simple;
	bh=6az6WKnfiUpQgfnMzmkY1EQOlsh2UHHWC7wEPuNJx/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdgjT9E3f3FmLSMjp5bm2PW1/m2L69VxxpSURHedzQ05ELM4/e7NCNFg1pzXdTZkAZY1BwmqDED4g3AN8RXprzRMuFqizj44loA9KgW2m7G2O6qStjTcxP1k8w67IrDYqvc9wYFlkq1+iisk33B7gCGr8st9Cs3g17U81/8h3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFv6ec95; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f646b1db8so6040391e87.0;
        Tue, 02 Sep 2025 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756882325; x=1757487125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2OUdDacTg6VfmwIiVXUwJM8fEMU0LwHlUYb41+E6ms=;
        b=dFv6ec95z8Vb2o+SlRZyCNzZJz0yW5P4BXXeljWpJzS5I9anclJYoZOVVWh8KWl2Qs
         TQYDUGRSaYiU2hYhM+EPRdKHNphLpgo8umWlfZtLc9GMSSPhylSU5EcRbDEyVEklPSlb
         ZzEY58ZhVqwvcdsV0Mbb5NJN6UJXN3henb6UoFAvWI2NGNjdXxliO28QnQx4cfCE12Oa
         pypYC98HRCryPiOdHIcEDu2MwS/QzDcG2N6OEzMq3DZBzWh28K3gCk/U85J85F6FCHDH
         MPx0GyHwfOnR+Uo9xZcxt3Pj2ydbXPg/J13lqhoTO541uuhJE1QSTm+A1CEdgGNZPzze
         plGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882325; x=1757487125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2OUdDacTg6VfmwIiVXUwJM8fEMU0LwHlUYb41+E6ms=;
        b=UpvipkzYOhSC9FA/1oq4T4gvG4c+9/AC9dQ3Nma5ekMtwjlpfqL4KJS8pYuP/ICpbo
         3vYzNt29xOKpgjnB2Z/tF5KO1uVedVh4B9ZGjk42vcUJsj9ycsLJeo4Pyxr5qx/1Ecq2
         iACM4eYpFd70k5/Mgujmr192Th7SjB1IUyQIY0LZUH27MthwjNhCk99x4iKwlcR00N7t
         0dWZX51WjImnqwnSxC/aYgyG/jLRIv8/e96NLAEbBtPfMKQvWbaGScMmJNJLD+vxZFK9
         sUfnAlu4C8l8fCxrx7GyDLT0qvVZDtBF0jRjn/M7bemAXOQbjT8Tr8PUxtm8R97bob2O
         sbhw==
X-Forwarded-Encrypted: i=1; AJvYcCUPvXz/8W7xhwl1llE5c5v0hjl+qsPLkFOf8T+8/dMS+9h42B1qW3ce808Z/hK2l/ujtSnGASumfPmpMQ==@vger.kernel.org, AJvYcCUjmT+J2CaAWUJPHjDMrnPewYH2oVOX/wRuEohvNdEW6cajxsc1dBc1IzRlCa0YRMdLScEM5o0rLvL0@vger.kernel.org, AJvYcCWowbJG8O6RV16KM8SYOM9NjgCXaj1ZPWFhwlDs4009/ET2JiD9tWwd0k5E9c9SwkhnhDfm3j1Imac3@vger.kernel.org, AJvYcCXBn7llL1lGSKFcH3nB6HE3L2X40EX3T5+4fOdy1r4vVyt+TeeRoPRqc45e9fax6FsqoqDZqrZ2OvDxFZcP@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgJa4GcNj4frU87WV4wfAoBbbO3lZmA7Cphf1wsywDOe6xU85
	TqCQtaWZFJBa6llH4UQYl3QgwSHqlQ+b42zhSnR0bz6+R6v6gx5Cz67H
X-Gm-Gg: ASbGncsdvNZjjXzSgbnQ9GxVAhlemMbLLkwOTiiCZeBw42HW2CkpMOFR27c1zNTPEAh
	Bt78Hyf10MB3fl0Qk9iORJNb8GTIABLPjNrwAVScOBTbWOh2ZbojAqGVBwcQIScg1xWxpHR9Mtq
	4jYlCP02JaYMN8oMpiuPbA30tWuqZyuJDt+lfrTrKwC97MVNKyyQJUj1H+uOz+ZiD9KefUZ8cD+
	o1tufxTbSUX/qv161aufZdNGYKJFwpGLaj7WLPQiPC07pCxvzXsrUilvnvxGyIVgQLRCwmfHYza
	r2Udss3P+eJcYmVIkJcHkro4A73V3uT53y0ZHlMMs8g8neNxkaQKoKIsCZbx7h8yjxp7FtFsHmE
	1ZbYJWtLwc8HQKyC66ItBGjrHCByh4JbzUmShyzR04NhnV62lp6g+dhMWhgdQHGhETXOIdIcTA5
	wMMZB7
X-Google-Smtp-Source: AGHT+IG1h9Tkp9BFtciEhPiwr7lI8E25TdbN9BxtrQFOJT7RO1Xo3xD5DBSKESrYjmo4zwvIuQ+wTg==
X-Received: by 2002:a05:6512:61cd:20b0:55f:770b:855e with SMTP id 2adb3069b0e04-55f770b8649mr2838553e87.52.1756882324489;
        Tue, 02 Sep 2025 23:52:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abc231dsm323119e87.59.2025.09.02.23.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:52:03 -0700 (PDT)
Message-ID: <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
Date: Wed, 3 Sep 2025 09:52:02 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <aLb8HuIG0XXLu653@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aLb8HuIG0XXLu653@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho Andy,

On 02/09/2025 17:15, Andy Shevchenko wrote:
> On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:
>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>
>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>
>> The IC does also support CRC but it is not implemented in the driver.
> 
> ...
> 
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/err.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
> 
> Incomplete list. See below (it doesn't mean I caught up all of the missing
> inclusions).

Thanks!

> ...
> 
>> +struct bd79112_data {
>> +	struct spi_device *spi;
>> +	struct regmap *map;
> 
>> +	struct device *dev;
> 
> 
>> +	struct gpio_chip gc;
>> +	unsigned long gpio_valid_mask;
>> +	unsigned int vref_mv;
> 
> Perhaps _mV to follow the actual unit spelling?
> (and yes, I know that both variants are present in the kernel)

The 'mv' is a deliberate choise. I still remember our previous 
discussion about this same topic [1].

>> +	struct spi_transfer read_xfer[2];
>> +	struct spi_transfer write_xfer;
>> +	struct spi_message read_msg;
>> +	struct spi_message write_msg;
>> +	/* 16-bit TX, valid data in high byte */
>> +	u8 read_tx[2] __aligned(IIO_DMA_MINALIGN);
> 
> + types.h for u8 and indirectly for __aligned.

Thanks! It's super helpful to list the missing headers. (And no, there 
is no sarcasm, it really is hard to pick the right headers at times! I 
find your review _very_ helpful on that).

I won't repeat this for other header comments you made.

>> +	/* 8-bit address followed by 8-bit data */
>> +	u8 reg_write_tx[2] __aligned(IIO_DMA_MINALIGN);
>> +	/* 12-bit of ADC data or 8 bit of reg data */
>> +	__be16 read_rx __aligned(IIO_DMA_MINALIGN);
>> +};
> ...
> 
>> +static int _get_gpio_reg(int offset, unsigned int base)
>> +{
> 
> Why offset is signed?

Just out of habit. Can be unsigned.

>> +	int regoffset = offset / 8;
>> +
>> +	if (offset > 31 || offset < 0)
>> +		return -EINVAL;

...

>> +
>> +	if (reg & BD79112_BIT_IO)
>> +		if (*val & BD79112_ADC_STATUS_FLAG)
>> +			dev_err(data->dev, "ADC pin configured as GPIO\n");
> 
> Missing {}, I think one needs to refresh a memory of kernel coding style.

Could be. I've never been overly enthusiastic what comes to memorizing 
styling rules. (I believe that if there are hard styling rules, those 
should be enforced/checked by tooling like checkpatch.) Still, I've 
myself never really been fond of having too strict set of styling rules.

Thus, I really thought useless brackets were useless.

TLDR; I can combine the conditions in one if (), thanks.

> 
>> +	return ret;
>> +}
> 
> ...
> 
>> +static int bd79112_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int *val,
>> +			    int *val2, long m)
>> +{
>> +	struct bd79112_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = regmap_read(data->map, chan->channel, val);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		 *val = data->vref_mv;
>> +		 *val2 = 12;
>> +
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	}
> 
>> +	return -EINVAL;
> 
> Why not making it default case? This is how most of the IIO drivers do.

Hmm. Thanks. I wonder why I didn't see nagging from unhandled cases. I 
think some tooling used to emit those warnings...

> 
>> +}
> 
> ...
> 
>> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +				     unsigned long *bits)
>> +{
>> +	struct bd79112_data *data = gpiochip_get_data(gc);
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < 4; i++) {
>> +		unsigned int bank_mask, reg, regval, regmask;
>> +		int ret;
>> +
>> +		bank_mask = 0xff << 8 * i;
>> +		regmask = (*mask & bank_mask) << 8 * i;
> 
> Why all this?
> 
> We have for_each_set_clump8().

Haven't yet checked the for_each_set_clump8() - but I assume because I 
had no memory trace about kernel having such function :) (Thanks!)

>> +		if (!regmask)
>> +			continue;
>> +
>> +		reg = BD79112_REG_GPO_VALUE_A0_A7 - i;
>> +		regval = (*bits & bank_mask) >> 8 * i;
>> +		ret = regmap_update_bits(data->map, reg, regmask, regval);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int offset,
>> +				int dir)
> 
> Why dir is int? 

Because it is expected to be either GPIO_LINE_DIRECTION_IN or 
GPIO_LINE_DIRECTION_OUT, which are integers, right?

> And why in negative case or other than _IN we switch pin to
> output mode. It's dangerous default.

This function is only called with GPIO_LINE_DIRECTION_IN or 
GPIO_LINE_DIRECTION_OUT, but I agree it's better to invert the default.

>> +{
>> +	unsigned int set_reg, clear_reg, bit;
>> +	int ret;
>> +
>> +	bit = GET_GPIO_BIT(offset);
>> +
>> +	if (dir == GPIO_LINE_DIRECTION_IN) {
>> +		set_reg = GET_GPI_EN_REG(offset);
>> +		clear_reg = GET_GPO_EN_REG(offset);
>> +	} else {
>> +		set_reg = GET_GPO_EN_REG(offset);
>> +		clear_reg = GET_GPI_EN_REG(offset);
>> +	}
> 
>> +	ret = regmap_set_bits(data->map, set_reg, bit);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_clear_bits(data->map, clear_reg, bit);
> 
> I believe the order depends on the out-in or in-out switch.
> Otherwise it might be potential glitches on input (hw) buffer.
> Right now when it's not an interrupt it may be okay to don't
> bother, but in general I see a potential issues with that.

Can you please explain what you mean. I am not sure I can follow you here.

>> +}
> 
> ...
> 
>> +static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset,
>> +			       int value)
> 
> Why value is signed?

Because the direction_output is defined as:
int                     (*direction_output)(struct gpio_chip *gc,
					unsigned int offset, int value);
in a tree this series is based on?

> 
> ...
> 
>> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
>> +{
>> +	int i, gpio_channels;
> 
> Why signed?

For 'i'? Because it matches with the num_channels, which is int, just as 
it is in the struct iio_dev. This is not a problem because we know the 
maximum number of channels is 32.

For 'gpio_channels'? Mostly because int works and it was handy to just 
use same type as for 'i'. It works as we just need enough memory to fit 
in 32 bits. The integer representation of the value is meaningless and 
thus the sign does not play any role here.

> ...
> 
>> +static int bd79112_probe(struct spi_device *spi)
>> +{
>> +	/* ADC channels as named in the data-sheet */
>> +	static const char * const chan_names[] = {
>> +		"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A",
>> +		"AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",
>> +		"AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
>> +		"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B",
>> +		"AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",
>> +		"AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",
> 
> Can you make all of the lines to be the same in terms of amount of entries?

Maybe :) I would like to know why? As you know, I prefer to keep lines 
short to fit multiple terminals in parallel, so this will probably make 
the entry to consume more rows. Thus, I would like to have a solid reason.

>> +	};
> 
> This seems to be hidden in the function while it's used for the whole life time
> f the device. Why not move it outside of the function?

Mostly just because this is not directly referred to outside the probe 
by this driver and I don't think it should be referred. OTOH, having 
this global would allow squeezing the indentiation - which would make it 
tad more compact - so I think I'll just go with your suggestion for the 
next revision :) Thanks.

..

> 
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
> 
>> +	data->vref_mv = ret / 1000;
> 
> (MICRO / MILLI)

I find this much more confusing than plain 1000. (I know we had this 
type of discussion before. See [1] again).

> 
>> +	ret = devm_regulator_get_enable(dev, "iovdd");
>> +	if (ret < 0)
> 
> Does it return positive or zero on success?

Zero, thanks!

>> +		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
>> +
>> +	data->read_xfer[0].tx_buf = &data->read_tx[0];
>> +	data->read_xfer[0].len = sizeof(data->read_tx);
>> +	data->read_xfer[0].cs_change = 1;
>> +	data->read_xfer[1].rx_buf = &data->read_rx;
>> +	data->read_xfer[1].len = sizeof(data->read_rx);
>> +	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>> +
>> +	data->write_xfer.tx_buf = &data->reg_write_tx[0];
>> +	data->write_xfer.len = sizeof(data->reg_write_tx);
>> +	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
>> +
>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
>> +		BD79112_MAX_NUM_CHANNELS - 1, &cs);
> 
> Hmm... Indentation can be amended.

Sorry but I am not sure I understand what you mean by amended? Can you 
please go an extra mile and explain :)

> 
>> +	if (ret < 0) {
> 
> Why ' < 0' ?

because the devm_iio_adc_device_alloc_chaninfo_se() returns number of 
found channels.

>> +	/* Let's assign data-sheet names to channels */
>> +	for (i = 0; i < iio_dev->num_channels; i++) {
>> +		unsigned int ch = cs[i].channel;
>> +
>> +		cs[i].datasheet_name = chan_names[ch];
>> +	}
>> +
>> +	iio_dev->channels = cs;
>> +	iio_dev->num_channels = ret;
>> +	iio_dev->info = &bd79112_info;
>> +	iio_dev->name = "bd79112";
>> +	iio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	/*
>> +	 * Ensure all channels are ADCs. This allows us to register the IIO
>> +	 * device early (before checking which pins are to be used for GPIO)
>> +	 * without having to worry about some pins being initially used for
>> +	 * GPIO.
>> +	 */
>> +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
>> +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to initialize channels\n");
>> +	}
>> +
>> +	ret = devm_iio_device_register(data->dev, iio_dev);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
>> +
>> +register_gpios:
>> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>> +					  iio_dev->num_channels);
> 
>> +
> 
> Instead of leaving this rather unneeded blank line I would move above...
> 
>> +	/* We're done if all channels are reserved for ADC. */
> 
> ...to be here
> 
> 	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
> 					  iio_dev->num_channels);

I suppose you mean something like:

register_gpios:
	/* We're done if all channels are reserved for ADC. */
	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
                                           iio_dev->num_channels);
	if (!gpio_pins)
		return 0;

right?

I don't like this because now the comment suggests we do call 
bd79112_get_gpio_pins() only to see if all channels were for ADCs. This, 
however, is not THE reason for this call, only an optimization. I think: 
having:

         /* We're done if all channels are reserved for ADC. */
         if (!gpio_pins)
                 return 0;

is clearer.



Thanks (again) for the review! I always appreciate your work, even if I 
don't always agree on everything :)

[1]: https://lore.kernel.org/all/20250505173157.57aa16f9@jic23-huawei/


Yours,
	-- Matti


