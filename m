Return-Path: <linux-iio+bounces-23685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B41B41E96
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD6F7ACE97
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C062FCC17;
	Wed,  3 Sep 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUbSyWWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422852FC875;
	Wed,  3 Sep 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901688; cv=none; b=RPSk0Hk41HBrIebz9zI+PBg8QHqIk09PPfhjgqnB91cks9Wb5yDIDfBSEzdRCfc59uEssI50ZpXL97o8ERqVWUQEho1+O2zwmyYrNL4DSFWnPZNwSuBcIyOoyl25JAxTumyS1PAClZmK4hIggfNrMYYkAdB9at/EX4xsLI6lyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901688; c=relaxed/simple;
	bh=I3Rwui5h8i8VWqYrb6PdFvNsET6DUKRQRuELuzNdVKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdzRTR8ZSXpbrp9ETn6TI9Qf/LQyv6iKeaOpOTFQQxmCmYIVdVZ5mXCJRdH1mHdbRNpPnF2uZWSOskaz6yeyORJ/0f2K/18+kJ4dwV15L33zDtt20s1gDB0s2udpp5rCnlXkHgFcL8+x8sOvlJOdK/liuGRC1fWPMyW5X1d8bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUbSyWWg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f720ffe34so1244658e87.1;
        Wed, 03 Sep 2025 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901684; x=1757506484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bnFdOSUcb5DzapHVKdsvSL7DbxrbpUwGDL+u7NsRkk=;
        b=OUbSyWWg4VhOCA+5tonWzPlbwN1c9ypIP43TOKCDyGYnj4RgOzXWmf3R5jA7ol/ql2
         rLd5QNQxBZx6IMYUCAi9iNF2uDrfG9yjlxpUhqZN4Q5viYLFvlKar7yvcFVErBDi8+1r
         dWY1dqewcsWIgWB6clWVxJCsEw502tr/O+Xv/RMC68+I0yS9F3Cwoq0BIjEIeNdqgJE6
         6Jh6VjxRUkfo/06Us45RMzEcgw4Xpsx31cNFLIlNtKPf7AW5U/nMVzuNkktjSDA6Y9Se
         2/+zpDYgskMkOjr9J0ztwluW1SKyMfcoRmlb/kywmZORQ4S7LOU547MMwD7KoU6jz0M6
         Vcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901684; x=1757506484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bnFdOSUcb5DzapHVKdsvSL7DbxrbpUwGDL+u7NsRkk=;
        b=K92rLnfCE4c+YyMWQGB3oP2M3n8h74NxG+XLFYf7K0zJJLyeWqrcj+k0g6xdKN1IjK
         syUP2yQI0qC40RvYt0lquw5wHJR0RwwTeBCzh4s1M+co5F9XHmRQlEM8VpWICJeFhqxC
         jP1keJPQMfVgpsz+3ULuci8MBejDDflSUvb0hB2iEEGSF+WIqM0OeuErDjDxS1VZk3m2
         aCwHscD9HFlPUQoJr61aEZ4ux7394G+qpdEjHeTtMd5AnUHDJo2KjcwBqE5O6IJkLHpH
         YRygm+DXT3GMs+SuLCpyqsU92VcsZGpAN1BT7HchXu+UU+Nba1Z0kVLjkN4OqJpAwpHS
         JFtA==
X-Forwarded-Encrypted: i=1; AJvYcCVO82mQAGC+AO2NAVaTEHaYQ5QRjzMI1qqJGTDaZfR5LiyMC1aGT1FgfbKZH85EHJyW/pDwwPdlRMLh32Ux@vger.kernel.org, AJvYcCW6fWIxcK4VioddPu6xUHq/HxpU5DQ2PUKl5D6lfsCfwQJQp5rn4gvpwjs7WXuAdWKvcC1iOl7pwMw5yw==@vger.kernel.org, AJvYcCW9CbSFMpjkMZARD6N1c+xhfSX0ODsqZmDc7tSNBGtLKoYYhqIjOZAtoKJ52CnNMj1STN1GNKUiyJDD@vger.kernel.org, AJvYcCXImG03T2RqJowdUPzLDlSxwFUutJDbRrr3EoO2UxtWu4EEtHurj8C3Cxh8GXM2ZkOofR35JytVZ9tH@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEP1ffDSmNQkoV66VopQtHG5lm0fov5vidIMzq7oTqoxK1SBw
	voroVp0s9Ijk7/LRqtW74pL3DuJknGCzED8p8gy96jYkOWixEgCXs0nx
X-Gm-Gg: ASbGncuJlU/Tl2dJKlX/tdbQxApFfGNzT3AIsKl6CgW1ghUZg5Xc7VH3WUeIVTfpICX
	RUCcOD0GpdtncjRQuAtpjyCxmY97Fys92r9k8CVd/rwgMrpKBpfKQBI3CuWbjZYl3SCG6YD5slf
	syu+BKYbkjwNqmyjisbppxR/I7BvbUN0esl4OYwXDKgrMpvRYwwIcHqnLsdCxUiiaeNZ329n4rB
	e3xqKUbfDygYNDc6DnLfB6JZjAgPmeUjGRvQB+o5HVPHQTR3GRQJt7+CQ6n3TaBmrGZfh98kx/u
	fwKnYnhRvQWUzvy/gb0gT6brykaQhnUfNWz9ob7BxGuMFD+rrTzmuM+8ki+eyxxHpuiqwyaT76o
	U8zfS6kwN82d7xkfw0CD55dPBtOJhoxCx1TrHPl3n8MQx6WJ3u7p54TKDN+IkwkA47oI6yglT1a
	WD8iwV
X-Google-Smtp-Source: AGHT+IH6jxbRHLcb1E9iKj6tlhXFNKumhSggGsD/bmyTaclcpbDEyHbuFaQHrtmGJ6Z1IZ53ftI55Q==
X-Received: by 2002:a05:6512:140d:b0:55f:3fea:db7 with SMTP id 2adb3069b0e04-55f708c0672mr4182756e87.9.1756901683861;
        Wed, 03 Sep 2025 05:14:43 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad0f6besm470470e87.116.2025.09.03.05.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:14:43 -0700 (PDT)
Message-ID: <10c6b0c4-d75f-494c-bb3c-883c06cf3bc2@gmail.com>
Date: Wed, 3 Sep 2025 15:14:42 +0300
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
 <00ee1968-a471-4d2b-a024-4bee00e40513@gmail.com>
 <aLglJoqBDap_eMIj@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aLglJoqBDap_eMIj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 14:23, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 09:52:02AM +0300, Matti Vaittinen wrote:
>> On 02/09/2025 17:15, Andy Shevchenko wrote:
>>> On Tue, Sep 02, 2025 at 03:24:31PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +	unsigned int vref_mv;
>>>
>>> Perhaps _mV to follow the actual unit spelling?
>>> (and yes, I know that both variants are present in the kernel)
>>
>> The 'mv' is a deliberate choise. I still remember our previous discussion
>> about this same topic [1].
> 
> Rings a bell. And I still think the proper spelling is more important when
> we talk about physics.
> 
> ...
> 
>> TLDR; I can combine the conditions in one if (), thanks.
> 
> Works for me.
> 
> ...
> 
>>>> +static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int offset,
>>>> +				int dir)
>>>> +{
>>>> +	unsigned int set_reg, clear_reg, bit;
>>>> +	int ret;
>>>> +
>>>> +	bit = GET_GPIO_BIT(offset);
>>>> +
>>>> +	if (dir == GPIO_LINE_DIRECTION_IN) {
>>>> +		set_reg = GET_GPI_EN_REG(offset);
>>>> +		clear_reg = GET_GPO_EN_REG(offset);
>>>> +	} else {
>>>> +		set_reg = GET_GPO_EN_REG(offset);
>>>> +		clear_reg = GET_GPI_EN_REG(offset);
>>>> +	}
>>>
>>>> +	ret = regmap_set_bits(data->map, set_reg, bit);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return regmap_clear_bits(data->map, clear_reg, bit);
>>>
>>> I believe the order depends on the out-in or in-out switch.
>>> Otherwise it might be potential glitches on input (hw) buffer.
>>> Right now when it's not an interrupt it may be okay to don't
>>> bother, but in general I see a potential issues with that.
>>
>> Can you please explain what you mean. I am not sure I can follow you here.
> 
> If we set out first with enabled input, input can get a value from the output.
> If the value before was different, it will be an event condition (of course
> it all depends on the HW and I haven't read datasheet for this one).

Ah. I guess I see what you mean. I have a feeling there is a problem at 
the GPIO user side, if it keeps listening for inputs after it calls 
direction to be switched to output.

But yes. I believe turning off the 'input listening' first, and toggling 
direction to output only afterwards makes sense. So, thanks. And thanks 
for explaining this further.

> ...
> 
>>>> +static int bd79112_probe(struct spi_device *spi)
>>>> +{
>>>> +	/* ADC channels as named in the data-sheet */
>>>> +	static const char * const chan_names[] = {
>>>> +		"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A",
>>>> +		"AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",
>>>> +		"AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
>>>> +		"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B",
>>>> +		"AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",
>>>> +		"AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",
>>>
>>> Can you make all of the lines to be the same in terms of amount of entries?
>>
>> Maybe :) I would like to know why? As you know, I prefer to keep lines short
>> to fit multiple terminals in parallel, so this will probably make the entry
>> to consume more rows. Thus, I would like to have a solid reason.
> 
> Sure, the array above is unindexed. It's prone to errors and typos.

Ha. Thanks :) I see it now when I counted the entries :) Should be 32, 
was 34. I agree this would have been easier to spot!

> Moreover, it's really hard to follow in case one needs to debug such
> a typo and see which value needs to be fixed (imagine you typed twice
> the same name).

Or, if I typed twice the same name twice ;) Thanks!

> 
> Recommended way is to use power-of-two per line (and even add a comment
> at the end), like
> 
> static const char * const chan_names[] = {
> 	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A",		/*  0 -  3 */
> 	"AGIO4A", "AGIO5A", "AGIO6A", "AGIO7A",		/*  4 -  7 */
> 	"AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",	/*  8 - 11 */
> 	...
> 
> (or hexadecimal offsets, whatever is better and more in accordance with
>   the SW / data sheet).

Ok, This makes sense now.

> 
>>>> +	};
> 
> ...
> 
>>>> +	data->vref_mv = ret / 1000;
>>>
>>> (MICRO / MILLI)
>>
>> I find this much more confusing than plain 1000. (I know we had this type of
>> discussion before. See [1] again).
> 
> Rings a bell, but that's what IIO reviewers suggest to do nowadays as a
> compromise between creating a new bunch of unit (V) related definitions.

I am sorry, but this just seems stupid to me. I'd say that it is very 
obvious for most of the readers dividing microvolts by 1000 results 
millivolts. And if it is not, then having this MICRO / MILLI is likely 
to just cause more confusion.

I _really_ dislike these defines. Why is MILLI 1000? Why it isn't 0.001? 
It makes no sense that KILO and MILLI are the same. Especially not when 
we are dealing with physics.

This is just an obfuscation compared to using plain 1000. (I kind of 
understand having a define for a value like 100000 - where counting the 
zeros gets cumbersome, although 100 * 1000 would be equally clear. But 
1000 _is_ really 100% clear, whereas MICRO / MILLI is not).

>>>> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
>>>> +		BD79112_MAX_NUM_CHANNELS - 1, &cs);
>>>
>>> Hmm... Indentation can be amended.
>>
>> Sorry but I am not sure I understand what you mean by amended? Can you
>> please go an extra mile and explain :)
> 
> 	ret = devm_iio_adc_device_alloc_chaninfo_se(dev,
> 						    &bd79112_chan_template,
> 						    BD79112_MAX_NUM_CHANNELS - 1,
> 						    &cs);
> 

Ah, Ok. I'll do this, thanks.

> ...
> 
>>>> +	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>>> +					  iio_dev->num_channels);
>>>
>>>> +
>>>
>>> Instead of leaving this rather unneeded blank line I would move above...
>>>
>>>> +	/* We're done if all channels are reserved for ADC. */
>>>
>>> ...to be here
>>>
>>> 	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>> 					  iio_dev->num_channels);
>>
>> I suppose you mean something like:
>>
>> register_gpios:
>> 	/* We're done if all channels are reserved for ADC. */
>> 	gpio_pins = bd79112_get_gpio_pins(iio_dev->channels,
>>                                            iio_dev->num_channels);
>> 	if (!gpio_pins)
>> 		return 0;
>>
>> right?
> 
> Yes.
> 
>> I don't like this because now the comment suggests we do call
>> bd79112_get_gpio_pins() only to see if all channels were for ADCs. This,
>> however, is not THE reason for this call, only an optimization. I think:
>> having:
>>
>>          /* We're done if all channels are reserved for ADC. */
> 
> Then you can amend the comment
> 
>           /* If all channels are reserved for ADC, we are done. */
> 
>>          if (!gpio_pins)
>>                  return 0;
>>
>> is clearer.
> 
> Which makes my approach sustainable.

I like your wording better, but placing this comment before the call to 
bd79112_get_gpio_pins() is still more confusing that placing it before 
the actual check:
	if (!gpio_pins)
is still misleading. Comment applies to the check, not the retrieval.


Yours,
	-- Matti

