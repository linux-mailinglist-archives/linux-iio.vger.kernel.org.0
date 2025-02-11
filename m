Return-Path: <linux-iio+bounces-15325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34404A3069B
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7546B1886394
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309C1F0E39;
	Tue, 11 Feb 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZRgRU5H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE026BDA6;
	Tue, 11 Feb 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264774; cv=none; b=bt0Uh65/ZQtJOo7ZHJk2vFMZRGHDygnln00VkdYnFqTc35DjL545hVoxfL7zyhkCmBON865Gkock2MXngoqduWJIkkPPeEpYFldq6ouH+Jp5ezUaKzyIS+qu3vwoAzwnzqKeMl0YotJ9J0JToCN8dE1fYRHuP39FDw4rdPgEjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264774; c=relaxed/simple;
	bh=IEzsQDpfO4qKgUk8tWbIoV/Aj+XIVuDbQzISKLrBLpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t95XzGNkz7pBvnM2oumgMUx6EFGSwqDMxRSBMi2B4+l4ORM/WZNOlrE9VnCC/Mklgn01oLw6W/BxzDLj2BEtEnD0EeE9rHuq4tLF5VNDVj4dBLPme8Dpa4cgeM0/kuWggp3S3r3vjC+ZxZJO7q7MNu0EyDL/BtbLnHfwWqce6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZRgRU5H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54505a75445so3083129e87.1;
        Tue, 11 Feb 2025 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739264770; x=1739869570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8rVlgNNUU0i1bMrkzHyq/cftlIkIpGDbN5j/qK9PbM=;
        b=hZRgRU5HQ3IriiPqEYCKM3md8D2uKjLdmtoLI7KI/b4ynCt2cL7HL+bDBR2Mk4rDA6
         ctJuio44otDH0CtWGIGdDqfXnRIVkz9n5CGYXtBMSnOVC8kC8ryT8O3gVzQCH/F1Nx2i
         5AkU7r/qOX0FX06dvBSBOYY7ueynu5pmmZ9X6ra1wTUMp6lzYwkICkI9nrsEJMHdJ5/s
         UTZC5RRC4bP7dMqx3mvJTGK4U4tazOYwFvqOLlyudMplCHsS4Eib+t/ET0SJAYvrifpP
         7aoOM8cJMfYKgWu4EM76n3DzYTrvCI5UyK3SRuZzR/Dl1nnBztKn+SECVoAX7Jmp13L8
         CmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264770; x=1739869570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8rVlgNNUU0i1bMrkzHyq/cftlIkIpGDbN5j/qK9PbM=;
        b=tKDc0y/xgluBh5W1zzQcvgjuucMS6MIbE6MdXLbDxM88hcVFba5ySbTYzVpjWh09IQ
         but+GTIDZARsL/3NY1pQFapzkYDtqY2lKT+WZtouIW7KRn5dg6iNuq4P9kIwEh9QIjVO
         XqprRA8aXLx7Wyn4ktUznIi1U50boNjmKUBGlPdDifHEzRWgatF+EXPbznjI49bROTmz
         9WSgVagpgedTZN8E0cljW3OEek26BPyazIOdSNT5/2CaGZH3NXyns0rOyBqSUXGaCXWU
         fpwM/TrPtFmckWOdGrXaehYU/mUOPdp1Ko0WJsn1rOyqkieturvw2WN5JYn7cUObGp5e
         JqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+mgbHV9VQ3IeBygcyXBmfkDYHhUg/jFdwvQzoO58Lk/umzQCZAsQdKnW2zXiWfcH9YOOfvun3aK4G@vger.kernel.org, AJvYcCUjI0kv8QoGqoxCs5ea5X5+q1CPaYGmeDcfqo7tippcbcg0M9qsyaq+5sOdCJG9PpBdP4FfwNkN4ghyXotV@vger.kernel.org, AJvYcCX/++rS8wv614A5RAoCDzzNaj2EOI4IwVo7eQD/zC/SSQrWvUegIZcgSy3FQS7jyenQNobwmBmMiv9j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0C+DEs56Q9tyEWYg5XSDdNIxWs81PoZjyB1dE3VvKRvypDZtZ
	w9dg39hjOO/sDhifkO5TEcKrYDZHVOWwG5Hs1i4AS8D3WS21pnSY
X-Gm-Gg: ASbGnct90O0LtLxoEn3Q6aGXazEr7r75xPkfcpt1UPjwVCONhQ+dVYPUzkmJ3jWGzxk
	EZDKeVwCCHDMDGVgzxGXqSxQ6W5ayPaW9zL7sL3ubKIpK1aX2daxQPyon7Fcx5Wtif3ePy0RV4m
	9shEO7kzmRRhbJfdVnQbvur8w0B27luymuFIpWUKVBejSvUn4KDwh2wiNsPKxBRWUHnZI5hwsog
	7XijI2W0rM8nBtDoSLnYSaNU/g0GGyJrL4tMSCN8Edl260BmswDfqLcPHptur8Nphwnm+E+6fA8
	gW+B/ZW/pUgi1H7PypZ/m82wBQjn
X-Google-Smtp-Source: AGHT+IFcaa6uJNm8Q8Xuea2thhJSiBeAUyUKgqsOcqDOH4ViStWWJxdNC/8XHXOz466ggA4V+hAmjQ==
X-Received: by 2002:a05:6512:360f:b0:545:a2f:22bd with SMTP id 2adb3069b0e04-5450a2f23a7mr2675885e87.48.1739264769912;
        Tue, 11 Feb 2025 01:06:09 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545052da7fasm908226e87.96.2025.02.11.01.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 01:06:09 -0800 (PST)
Message-ID: <87b712f9-6191-4626-b031-0234379a166c@gmail.com>
Date: Tue, 11 Feb 2025 11:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <4781e1b1f074ca6c84ecc084b152885d08e826cc.1738761899.git.mazziesaccount@gmail.com>
 <20250208165208.3560237f@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250208165208.3560237f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/02/2025 18:52, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 15:38:16 +0200
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
> 
> Hi Matti,
> 
> Just a few really trivial comments though this wasn't my most thorough
> of reviews as ran out of time / energy today!


Thanks :) I appreciate the time and energy invested here :)
> 
>> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
>> new file mode 100644
>> index 000000000000..ea93762a24cc
>> --- /dev/null
>> +++ b/drivers/iio/adc/rohm-bd79124.c
>> @@ -0,0 +1,1149 @@
> 
> 
>> +static int bd79124_write_event_value(struct iio_dev *iio_dev,
>> +				     const struct iio_chan_spec *chan,
>> +				     enum iio_event_type type,
>> +				     enum iio_event_direction dir,
>> +				     enum iio_event_info info, int val,
>> +				     int val2)
>> +{
>> +	struct bd79124_data *data = iio_priv(iio_dev);
>> +	int reg;
>> +
>> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
>> +		return -EINVAL;
>> +
>> +	switch (info) {
>> +	case IIO_EV_INFO_VALUE:
>> +		if (dir == IIO_EV_DIR_RISING) {
>> +			guard(mutex)(&data->mutex);
>> +
>> +			data->alarm_r_limit[chan->channel] = val;
>> +			reg = BD79124_GET_HIGH_LIMIT_REG(chan->channel);
>> +		} else if (dir == IIO_EV_DIR_FALLING) {
>> +			guard(mutex)(&data->mutex);
>> +
>> +			data->alarm_f_limit[chan->channel] = val;
>> +			reg = BD79124_GET_LOW_LIMIT_REG(chan->channel);
>> +		} else {
>> +			return -EINVAL;
>> +		}
>> +		/*
>> +		 * We don't want to enable the alarm if it is not enabled or
>> +		 * if it is suppressed. In that case skip writing to the
>> +		 * register.
>> +		 */
>> +		if (!(data->alarm_monitored[chan->channel] & BIT(dir)) ||
>> +		    data->alarm_suppressed[chan->channel] & BIT(dir))
>> +			return 0;
>> +
>> +		return bd79124_write_int_to_reg(data, reg, val);
>> +
>> +	case IIO_EV_INFO_HYSTERESIS:
>> +			reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
>> +			val >>= 3;
> Odd indent.

Oh, indeed. Thanks!

>> +
>> +		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
>> +					  val);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> 
>> +static void bd79124_re_enable_lo(struct bd79124_data *data, unsigned int channel)
>> +{
>> +	int ret, evbit = BIT(IIO_EV_DIR_FALLING);
>> +
>> +	if (!(data->alarm_suppressed[channel] & evbit))
>> +		return;
>> +
>> +	data->alarm_suppressed[channel] &= (~evbit);
>> +
>> +	if (!(data->alarm_monitored[channel] & evbit))
>> +		return;
>> +
>> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_LOW_LIMIT_REG(channel),
>> +				       data->alarm_f_limit[channel]);
>> +	if (ret)
>> +		dev_warn(data->dev, "Low limit enabling failed for channel%d\n",
>> +			 channel);
>> +}
>> +
>> +static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int channel)
>> +{
>> +	int ret, evbit = BIT(IIO_EV_DIR_RISING);
>> +
>> +	if (!(data->alarm_suppressed[channel] & evbit))
>> +		return;
>> +
>> +	data->alarm_suppressed[channel] &= (~evbit);
>> +
>> +	if (!(data->alarm_monitored[channel] & evbit))
>> +		return;
> This lot is very similar to the lo variant. Can we combine them or
> use some helper for both?

Initially I did this.

But the code looked a bit dull because the evbitm, alarm-limit array and 
prints depend on the direction. Furthermore, the caller already knows 
the direction (as the caller does also handle directions separately), so 
doing:

foo(dir)
{
	if (dir == bar)
		...
	else
		...
}

...

if (dir == bar)
	foo(dir);
else
	foo(dir);

started to feel just a bit, meh. Hence I separated the stuff to own _lo 
and _hi functions.


>> +
>> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel),
>> +				       data->alarm_r_limit[channel]);
>> +	if (ret)
>> +		dev_warn(data->dev, "High limit enabling failed for channel%d\n",
>> +			 channel);
>> +}
> 

Yours,
   -- Matti


