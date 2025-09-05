Return-Path: <linux-iio+bounces-23730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEDB44DA2
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC55177FA8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565B267B01;
	Fri,  5 Sep 2025 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXWSdrjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8781EE7B7;
	Fri,  5 Sep 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050893; cv=none; b=S/Zft2brPXy/pSB3Cn58Bz2zkyV41u5Tu6ByvgPI4/HRGU/1r1HuT5n80zXw7uQ2sJgUCKg9yCZkVe/qEl34zU0NwzPKVcgfwp4y2M4eGXbknPyCKbZqgjqRO65M0ys09RFPUfHUxJCtQuIYuFYYxEbhIYsPyWJ82jQKll24o2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050893; c=relaxed/simple;
	bh=eLys4QeUr6olzf7g0jR9e576kv+68GlVXGvhX/QYrTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL9el6IvtFZiy5vJXPR3tUHvjSxFkHLtLBdMNTvpLuzlmBVsaHhAwWdCkXxs0NktTLLnmfuMG7EYb1jm+XhzauhosZunvA7rkeHEmjUrpfZT+17AjEiz1IxkEEHjNBcWpFnK5m1UZENMCs7bGzoAlCmoptaIfVbZEj8I3Fj9dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXWSdrjh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so1743312e87.1;
        Thu, 04 Sep 2025 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757050889; x=1757655689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbhTVk0PDE/MZXe5g/5Hq+IjGa9Cnm5K5CG5XQpjzfs=;
        b=MXWSdrjhp/Hng6Qi3lZGNgkCaWv92DUY7KaSe/W+XLlvzHnVAuaFTGiOzW0FgL0zOt
         7RLGfpNnDwFVD0I1VJERDGdtXUU85Qf53mkCnFr1DfbZJ4FoQWOEvlCGlbI7A4tSD+h9
         /74e12Rqkiagb3AVSXvh0BHysg6M79Z0MSUhErdCJK5wN3oNJ3IynbcQTBHZ1mEA83rP
         PW96pcK7SB08AVVsIZeRQ1DtmnGV/AjAq5yWc+Zyu7Ne5C1xmCMckvRYmlCdwiTMuMHB
         m50rrF6Yp4ku0xICewNUNSBhYV9b6lQV5vG5pvB4sxl/u77v7g3jAJP2WxmJowH1WJLz
         4U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757050889; x=1757655689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbhTVk0PDE/MZXe5g/5Hq+IjGa9Cnm5K5CG5XQpjzfs=;
        b=jlddsSZcvHJ2WFFhY0KnbhzCHB9GEI3wEEeWxxPZWV68ILLzFP9q62nGOCv/GC//rj
         xkHYBhHOOvcPEkji02C/aE5oIz27ht5QPfRNcUnLoxhJR0j6CI+yCMAxjaLWae1t28Q+
         w6S0nCiInmXHSRJ0MCDjc8MUGe2HQP3h9Ld9cBSnBuBp+oJ7H2ohluuRaB36wp9XXk2j
         0UTbBhiBVN5QI6A8mmq8xTEYkaTA7gGeW2R2wI0Bo82+jPrZuGvs88w2rC17ptWIpWDg
         YlH2n2oGOryNR6M2L9wTf8tFJKaWam7r5MkoI0s+1b6u9Kr1FCNtxOHNlqpj/bVLpNiR
         juLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1mscBN9Lg9z2ASK4eBgbGdkVHBiNf7zNS1OtE1NDJ/VMXPRpeUYC1I8YHkf41EixJipjpMu0Hllj3@vger.kernel.org, AJvYcCWRur9YVN13wtBBZ2G1/rfW9DNaPpEN6KjZ7DYkxjzB7xPT1BqqfWRZ8qfpeEjf/GXjUVWcmfRhebpscA==@vger.kernel.org, AJvYcCXPXSLfbL1K1EMjaxVEbrZOxQ8hr2dR4Ro7/oC0eO3FagfmQboDvfgKPfHMGPYwKALlczzBwuuc5vaL@vger.kernel.org, AJvYcCXxmHjcrG4DKA7hH2L1Tzx1YtCUIl83kL6nHUZRmLFhTZ/OEwKSHWoHNfYFTVaCHYfkV1KAeMchnOmKw5eK@vger.kernel.org
X-Gm-Message-State: AOJu0YywnPZns2iCm1gFSg29f6jbg2BLuvliGImOuc5XQ9EOADT+u4Qi
	Usajx4r1HCQuWIZH5y3NmcXVGw4vPoi2coxN7Jj8j1zoJdIm6GjUklcc
X-Gm-Gg: ASbGncspj2DMQgdifx2JF00XLwbs+yL1fyvLruOvFqI31zkZON73dbxsdRB/xCD0Btx
	Hv9Z9508tBFQacGiCyIdiMVd8bk2JDRZu9EBPtp9bStyTmWv9a4Jtv+wSFshivG5n141FjlBd2w
	tOt7NotmtImLweVslFOWIgQ+ODKqirSqf7A2+N47QR2qV3QtYFL7sfStGYTk4c2h2XzSvrgzpOa
	/1sw2aIBIlXfWigPNwywMhJQWsVH0IhEAjC/YkYJZ9B/YRElrDsKhjZyNizd4i4VjC3bB27yPAj
	b2o38r4dGgiKtBQQZ6xjHwxd0Zj05952vP1+u8yaYbpJul98gdaDrbxzI7CYk9McijFoGt9x7Zd
	t4XxZrh+5V3t13VIsAcBh2CEbcNr/jL3oU8COS9vtS0wEB0EMaD3uzRjSNV3UixPcbSA+ebnfNK
	QwXM2kqITQg/WCbp0=
X-Google-Smtp-Source: AGHT+IFtmxgBBQbEfspmfdu14lGinUHmdGU1FZ/ZEUh60RHZA+TK49bPkM/H86CAhq05xL+26jLAfA==
X-Received: by 2002:a05:6512:2513:b0:55f:5f7e:9ba8 with SMTP id 2adb3069b0e04-55f708ec3bfmr8473478e87.31.1757050888781;
        Thu, 04 Sep 2025 22:41:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e281sm1636054e87.18.2025.09.04.22.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 22:41:28 -0700 (PDT)
Message-ID: <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
Date: Fri, 5 Sep 2025 08:41:26 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
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
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Pop Ioan Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
 <aLmVzDB4bk-z5d16@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aLmVzDB4bk-z5d16@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho Andy!

Thanks again. I really appreciate the effort you put in these reviews! :)

On 04/09/2025 16:36, Andy Shevchenko wrote:
> On Thu, Sep 04, 2025 at 03:36:46PM +0300, Matti Vaittinen wrote:
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
>> +/*
>> + * The data-sheet explains register I/O communication as follows:
>> + *
>> + * Read, two 16-bit sequences separated by CSB:
>> + * MOSI:
>> + * SCK:	| 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
>> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
>> + *
>> + * MISO:
>> + * SCK:	| 1 .. 8 | 9 .. 16 |
>> + * data:| 8'b0   | data    |
>> + *
>> + * Note, CSB is shown to be released between writing the address (MOSI) and
>> + * reading the register data (MISO).
>> + *
>> + * Write, single 16-bit sequence:
>> + * MOSI:
>> + * SCK:	| 1 | 2 | 3   | 4     | 5 .. 8 |
>> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
>> + *
>> + * MISO:
>> + * SCK:	| 1 .. 8 |
>> + * data:| data   |
>> + */
> 
> I don't know how to read this comment. In the monospace font the whole block
> looks like a mess.

What do you mean by a mess? Don't you have the '|' -characters aligned? 
That's very odd because they are aligned for me. Or, is this otherwise 
unclear?

> 
> ...
> 
>> +static int _get_gpio_reg(unsigned int offset, unsigned int base)
>> +{
>> +	int regoffset = offset / 8;
>> +
>> +	if (offset > 31 || offset < 0)
> 
> So, < 0 is now unneeded and offset > 31 can be rewritten as
> 
> 	if (regoffset >= 4)
> 
> which is more clear to me (like we have 4 banks and here is the check for
> the bank. Maybe you can even call the variable 'bank'.

Ah, thanks for pointing out the pointlessness of the < 0! Will fix this.

I still prefer checking that the offset doesn't exceed the pin count. 
The amount of pins is clear for anyone using the device, where as amount 
of 'banks' or even 'registers' isn't quite as obvious but requires one 
to know the internals of the IC.

> 
>> +		return -EINVAL;
>> +
>> +	return base - regoffset;
>> +}
> 
> ...
> 
>> +#define GET_GPIO_BIT(offset) BIT((offset) % 8)
> 
> I suggest to make it to be a returned parameter of _get_gpio_reg(). This will
> give better code generation on some architectures, see, for example, this
> commit: 9b3cd5c7099f regmap: place foo / 8 and foo % 8 closer to each other.

Interesting micro optimization. I had no idea about this - thanks for 
sharing it :) It's always good to learn something!

I don't like it here though. There are a few call sites where we only 
need to get the offset once, but more than one register. (Like the 
direction setting). Hence, I like to keep these operations decoupled. I 
think the benefit from this optimization is quite small. Furthermore, 
architecture specific optimizations aren't really something we should 
add in generic drivers. It may be this will never get used on the 
architecture we are optimizing for. [Sure it can make sense for 
something like regmap, which is heavily used (probably) on all 
architectures, especially if cost is just placing some lines closer to 
each others. So, nice change there!]

> 
> ...
> 
>> +static const struct regmap_access_table bd79112_volatile_regs = {
>> +	.yes_ranges = &bd71815_volatile_ro_ranges[0],
>> +	.n_yes_ranges = ARRAY_SIZE(bd71815_volatile_ro_ranges),
> 
> + array_size.h
> (and btw we put generic asm/* _after_ generic linux/*, just noticed that).

Thanks!

>> +};
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
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
>> +
> 
> Unneeded blank line.
> 
>> +}
> 
> ...
> 
>> +static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>> +				     unsigned long *bits)
>> +{
>> +	struct bd79112_data *data = gpiochip_get_data(gc);
>> +	unsigned long i, bank_mask;
>> +
>> +	for_each_set_clump8(i, bank_mask, mask, /* gc->ngpio */ 32) {
> 
> Hmm... Why constant and not gc->ngpio?

Oh, well spotted! That's just a leftover from my testing where I called 
this without the gpio-chip! It should indeed be the gc->ngpio! Thanks!

> 
>> +		unsigned long bank_bits;
>> +		unsigned int reg;
>> +		int ret;
> 
>> +		if (bank_mask) {
> 
> This is a duplication, the iterator only gives non-zero "clumps".

Indeed. Thanks!

>> +			bank_bits = bitmap_get_value8(bits, i);
>> +			reg = BD79112_REG_GPO_VALUE_A0_A7 - i / 8;
>> +			ret = regmap_update_bits(data->map, reg, bank_mask,
>> +						 bank_bits);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
>> +{
>> +	int i, gpio_channels;
>> +
>> +	/*
>> +	 * Let's initialize the mux config to say that all 32 channels are
>> +	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
>> +	 * bits for found ADC channels.
>> +	 */
>> +	gpio_channels = GENMASK(31, 0);
> 
> This is negative number, it might bait one at a surprising time. Hence once
> again, why not make them unsigned?

I think I already explained why it is signed. I don't see how this bites 
us here? Can you please elaborate what's the problem _here_?

> 
>> +	for (i = 0; i < num_channels; i++)
>> +		gpio_channels &= ~BIT(cs[i].channel);
>> +
>> +	return gpio_channels;
>> +}
> 
> ...
> 
>> +/* ADC channels as named in the data-sheet */
>> +static const char * const bd79112_chan_names[] = {
>> +	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",	/* 0 - 4 */
>> +	"AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",	/* 5 - 9 */
>> +	"AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",	/* 10 - 14 */
>> +	"AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",	/* 15 - 19 */
>> +	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",	/* 20 - 24 */
>> +	"AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",	/* 25 - 29 */
>> +	"AGIO14B", "AGIO15B",					/* 30 - 31 */
> 
> O-o-key, but why not power-of-two per line (esp. taking into account
> the whole size)? (Whatever, it's not something I would fight for.)

I just filled the rows to the maximum width, while keeping the item 
count same for each row and adding the comment.

I'm not really sure having 4 items / row, and adding one row more would 
be much better, but not much worse either. I can do this if you think 
it's better. (No need to even fight for that).

>> +};
> 
> ...
> 
>> +	data->vref_mv = ret / 1000;
> 
> Yeah, mV, (MICRO / MILLI) and other things I leave to other people to discuss.

Thanks Andy. I've a feeling we were somewhat stuck on this discussion 
anyways. I suppose it's nice to hear other's opinions if someone else 
really cares. This was approaching bikeshedding.

> ...
> 
>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
>> +						    BD79112_MAX_NUM_CHANNELS - 1,
>> +						    &cs);
>> +	if (ret < 0) {
> 
>> +		/* Register all pins as GPIOs if there are no ADC channels */
>> +		if (ret == -ENOENT)
>> +			goto register_gpios;
> 
> As I showed this can be checked before other case, but I kinda have an idea why
> you are liking to do it this way.

Sorry Andy. I think I didn't consider your suggestion thoroughly as I 
just assumed it was related to the question if the value returned by the 
devm_iio_adc_device_alloc_chaninfo_se() can be positive. I'll re-read 
your suggestion, thanks for pinging me on this.

>> +		return ret;
>> +	}
> 
> ...
> 
>> +register_gpios:
>> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>> +					  iio_dev->num_channels);
>> +
>> +	/* If all channels are reserved for ADC, then we're done. */
> 
> I still consider the assignment to be located here is a better place,
> but I leave it to maintainers.

I do also still think placing the comment before assignment can give 
reader an idea that the amount of pins is fetched for this check, which 
it isn't. We fetch it for other purposes, but optimize things bailing 
out if there are no GPIOs. So, we comment to explain early exit. But 
yeah, let's see what others think of it as well.

>> +	if (!gpio_pins)
>> +		return 0;
> 

Yours,
	-- Matti


