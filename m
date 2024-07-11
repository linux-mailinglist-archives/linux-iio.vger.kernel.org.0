Return-Path: <linux-iio+bounces-7522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886D92F122
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9049B20969
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D819F461;
	Thu, 11 Jul 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YK/tsZmO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344F146010
	for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733485; cv=none; b=a0soBPl1jweYkwAOhmnmK+Xjz8h0FMJ7++jOVJgBI0coaPZayFuUoBh36r5Ya96juQyhVgvFnb//DtCr0K3WTdn5yKNuXDthn5Hr5RUWqCrfUfpMkuJ7ZGVtdm/HUVOsnDbrLTTWAEjyxjoW+JsD4rvd+lwlJluNTCCG6E7A58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733485; c=relaxed/simple;
	bh=jFC/ch/i8/z5xVvWKDKmHwOHmrjhAbhPZHERWwIZfQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR0F3xlV334EHNFELdd8lQc6XHPGrTuq0lrRE1EDAbP31btBMA5fEWuM15/bQbjF63CWugGEahjUncRdtHcV4mwOOhK5x9hBVHxXUPxmu10wWYqUxRhic4OQY1ox8SUfVi/sAfbk0dbxNU3tZWPR1FJ2SDTQOalZZlxshueOrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YK/tsZmO; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d853e31de8so727241b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720733483; x=1721338283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfeKN2QfdZHciO4OVOVkpdd43CD7Qm2bGhXeNljngUw=;
        b=YK/tsZmO76iCrXYiHHrA+y32F7ZmMZuF8/UZuTosVFxz8STblfzPAh4imVFyrVFO4f
         fDRHIncSoh9OLUXnvgWPm6MH6RZz8pwXTiWEToNqjIKlSB4CytM3CWlHOVgKVdQXVIp7
         B/0X5QMNNWfERunu6Dg0kWQ+PxJPhVMegQOjT2ONyY3dqIWsbDH55blM32qaMlU1Pal5
         wwhypADmV86JRrS+u9q+oBHrhXSjIy/lEo7n7z6mUZOgNdfV+bXT39k16a1FrlrYM2kG
         /2OT2+5hVQEvl9RL1Y1JNmULaNnQ1mmUDMGt4KWhw57oVGTVoPObjG2Ngja21hreL2ER
         C7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733483; x=1721338283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfeKN2QfdZHciO4OVOVkpdd43CD7Qm2bGhXeNljngUw=;
        b=tWCF9ZSjtWtPcgKhYBuuDvwFbGI92PtbGt+pz2xa+ELJcYZGjAc7ozWrnicoXMbsT5
         lIM9eJVWM/YWAZCUrkO5bhC+sV+QPEEPV7sVJ8Sk+Z4+JPV9UEi+MMomPrJgITrLgGZQ
         6ys8V6VjdA2zfO1IuIDhYsQDbozYKpZJE/IlNX03fydlKI/3llT11mjojX8FUNN/dXsz
         8rVnHt6HocmLldyxy/ltGPWca3xIbeMwwPwzxvynsPZnG/nW2VHQ3Er0jRoXt/rTj6RQ
         kbVBlCKdeYynzzGKVMTudRa5m2bvgVeNvTYvNmEehXtrkA4nnPcF3pfdJZ+i9lMP4Tkc
         7fqg==
X-Forwarded-Encrypted: i=1; AJvYcCVBvQSiKb1lSy7i9ymCrzIBkxrOsR3tj98X6q2xM8tgWABIng5QOLHnMEvdS4xwSeZMzsHjT6MuAe9YNcZ4Yr/CZaUgVNk3qol4
X-Gm-Message-State: AOJu0Yz7BlSSKWh7G85o2pmoSmWnfWTQsoeY2RKZy+v1EQAZaPTzM4YF
	17xH2Zsuj/MI0VRF/qf29E3c+1AXDHv0b3F7B61QkrX0e7yNdPNJZ1TY97uYND0=
X-Google-Smtp-Source: AGHT+IFf4egknI9k9MvbDQeAJxrUvsMSH7+SArDvalruHrHw+3gkn8noL4LvJ2u6fMwbjYLblTnOIA==
X-Received: by 2002:a05:6808:3d2:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3d93e48a58emr8438609b6e.10.1720733482672;
        Thu, 11 Jul 2024 14:31:22 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad2447dsm1180928b6e.25.2024.07.11.14.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:31:22 -0700 (PDT)
Message-ID: <733f4f7b-53b2-46c1-8bf8-5ed357adab30@baylibre.com>
Date: Thu, 11 Jul 2024 16:31:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Nuno Sa <nuno.sa@analog.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
 <20240510064053.278257-3-Mariel.Tinaco@analog.com>
 <20240511174405.10d7fce8@jic23-huawei>
 <SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240628194546.2f608365@jic23-huawei>
 <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
 <20240708170504.00006c9d@Huawei.com>
 <ccce603d36fa2fd590b563955bcd2cda085773e5.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ccce603d36fa2fd590b563955bcd2cda085773e5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/24 4:20 AM, Nuno Sá wrote:
> On Mon, 2024-07-08 at 17:05 +0100, Jonathan Cameron wrote:
>> On Mon, 8 Jul 2024 05:17:55 +0000
>> "Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:
>>
>>>> -----Original Message-----
>>>> From: Jonathan Cameron <jic23@kernel.org>
>>>> Sent: Saturday, June 29, 2024 2:46 AM
>>>> To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
>>>> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
>>>> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>>>> <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
>>>> <broonie@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>>>> Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
>>>> <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
>>>> Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
>>>>
>>>> [External]
>>>>   
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
>>>>>>> +				     const struct iio_chan_spec *chan) {
>>>>>>> +	return 0;  
>>>>>>
>>>>>> Why have the stubs in here?  
>>>>>
>>>>> Should I move the stubs to a different place in the code or remove
>>>>> them altogether since there is only a single powerdown mode available  
>>>> Ah. I'd not really understood what was going on here.  This is fine as is.
>>>>   
>>>>>> AD8460_HVDAC_DATA_WORD_HIGH(index),  
>>>>>>> +			    ((val >> 8) & 0xFF));  
>>>>>>
>>>>>> bulk write? or do these need to be ordered?  
>>>>>
>>>>> For this I used bulk read/write this way.
>>>>>
>>>>> static int ad8460_set_hvdac_word(struct ad8460_state *state,
>>>>> 				 int index,
>>>>> 				 int val)
>>>>> {
>>>>> 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];  
>>>> regmap bulk accesses (when spi anyway) should be provided with DMA safe
>>>> buffers.
>>>> Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN) to the
>>>> end of the ad8460_state structure.  Possibly you'll need a lock to protect it -
>>>> I
>>>> haven't checked.  
>>>>>
>>>>> 	regvals[0] = val & 0xFF;
>>>>> 	regvals[1] = (val >> 8) & 0xFF;  
>>>>
>>>> That is an endian conversion so use appropriate endian function to fill it
>>>> efficiently and document clearly what is going on.
>>>>
>>>>
>>>> 	put_unaligned_le16()
>>>>   
>>>>>
>>>>> 	return regmap_bulk_write(state->regmap,  
>>>> AD8460_HVDAC_DATA_WORD_LOW(index),  
>>>>> 				 regvals,  
>>>> AD8460_DATA_BYTE_WORD_LENGTH); }  
>>>>>
>>>>>  
>>>>>>> +}  
>>>>   
>>>>>>> +	state->regmap = devm_regmap_init_spi(spi,
>>>>>>> &ad8460_regmap_config);
>>>>>>> +	if (IS_ERR(state->regmap))
>>>>>>> +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
>>>>>>> +				     "Failed to initialize regmap");
>>>>>>> +
>>>>>>> +	ret = devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev,
>>>>>>> +"tx",
>>>>>>> +  
>>>>>> IIO_BUFFER_DIRECTION_OUT);
>>>>>>
>>>>>> Ah. I take back my binding comment. I assume this is mapping some
>>>>>> non standard interface for the parallel data flow?  
>>>>>
>>>>> Yes, the HDL side doesn't follow yet the standard IIO backend from
>>>>> which this driver was tested  
>>>>
>>>> Hmm. I'd like to see this brought inline with the other iio backend drivers if
>>>> possible.  
>>>
>>> Does this mean that we would need to implement an AXI IP core on the
>>> FPGA side to be able to test this?
>>
>> Don't think so.  That framework is meant to support any equivalent IP.
>> So whatever you have should be supportable. Maybe it's somewhat of a stub
>> driver though if there isn't anything controllable.
>>
>> It's Nuno's area of expertise though +CC.
>>
> 
> Hi Jonathan,
> 
> Yeah, I did reply David (IIRC) about the very same question. In the design/HW Mariel
> is working on the DAC is directly connected to the DMA core which is handled already
> by a proper dma controller driver. So in this case I'm really not seeing the backend
> need right now (maybe in the future we may have another design for this device that
> could justify for a backend device but no idea on that).
> 
> As you mention, we could very well do a stub platform driver so we can use the
> backend framework (like dma-backend or something) that could pretty much be a stub
> for the DMA controller. But is it worth it though? We'd actually be "lying" in terms
> of HW description as the DMA is a property of the actual converter.
> 
> - Nuno Sá
> 
> 

I'm a bit inclined to agree with Jonathan here. I could see someone in the future,
wanting to, e.g., use DMA + a GPIO controller for the parallel interface if they
didn't have an FPGA. So it seems a bit more future-proof to just always use the
IIO backend framework for the parallel interface.

FWIW, I don't think it would be "lying" since the io-backend DT node would be
representing physical parallel bus between the DMA controller and the ADC
chip.

But if DT maintainers are OK with the idea that a DMA channel can be directly
wired to an external chip, I guess I won't complain. :-)


