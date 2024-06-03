Return-Path: <linux-iio+bounces-5699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9CA8D8765
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34931C21519
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78F136678;
	Mon,  3 Jun 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+nZAGOD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052B7E8;
	Mon,  3 Jun 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432792; cv=none; b=tjfqosIEUNuf8mMR6OxWy5k5lKEHawc4O9hZ1ReXzM8Eq+zCMaTpQbJhzIK6TBEkCZt4Jnz27D7qq6TDVK3Q3XB//Hpi7qZcrrQCOY4586rxgCW0jfz3JVck1nyD37ga4H6eVA7NdsGwF7CZqjxJ7pjU8+jm2EbdSpAJMUtY2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432792; c=relaxed/simple;
	bh=rnR5iPB01lsns52vG/tA2Gfh3HK2RdIOyDH7P6NAYdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIZ6bRUZLARwp4N/iN12xD68atgD/Xhiue0w1JPLPa0daXUgR2HU/qhOjHevepAVG6synkl678CaSONQnuYXFOW4rfyz29+I8OdmnfvTT5RdmqC+nrf6X9U78m2Jujvbqo/tJExVmwkZbPcHP69e3HkfYALz2yTMQFT5ks5D7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+nZAGOD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4214053918aso263935e9.2;
        Mon, 03 Jun 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717432789; x=1718037589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmucZefJaS9oSAR+UXzx3NPh83JYXnJgaWeSAXKZsFg=;
        b=F+nZAGODw+dZ4N83cBoS4/Kz/rB4mJNKsiH6/YAJk4uhn+ORGGb6281YlTdb33S++i
         ioie4XX2Dyi2B19WAZDHKucliax/JM/tsUSQAds4lDNxnVkwrBYftdYDpbKOd9ZrXUiP
         IgayVKv3aJmyxHPpLa8msZ5iLAXI7QxMEWH2hP1w807ArI7vGChm1emT0sSJxeiLw5LW
         sAhAW2LtRJrPEdFmhhmioklUYvkEGGogbA34zRzZwEiMNyYu6GqM0+UgoUyzWJcp6Wvt
         rWOjKT9spjf9mbYjTmYIttra5L6ME9Q8xvxGdawiSF7LyOGcUxsCB414SmbDISuESjJe
         VJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432789; x=1718037589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmucZefJaS9oSAR+UXzx3NPh83JYXnJgaWeSAXKZsFg=;
        b=HvYGYJMdlo8jP0SKAarQEMNSg/42iWojNaCtkLI/lVDrn2kiDXnTxv0A9Y5uW8wYMf
         tA8WygIlrqBTa9SAlNv1uhm9nhRzxHoiQDz1RgdhFIMJzg5h/hwCMrcxjcR30corZMOj
         Db3mzBUr2ps7wMzdTrRvN51bWCgqB7waXnvaniiS86+A/561pvXYF0kU0kqB9m6o6Y7m
         5sKHnbzjKfx29TD6/R41456v+oSWWASsMaGYMdMLp7l3hyFI2J7bwPs2Soyh8X70X+H/
         bXjq5yZYglpeC5tlhOPr3nwAj+e6J7fPLD+vFya1qUS6+2MemGI/D/UjXtDRxj/joAjK
         atHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUndehoYcLG/SfGYbyzNSjXKt5QYmhgaObTIwOPtzq5wl5ObYpi2w/P5bwgvmNcGVQCPZwSQ3wwq3Hva73Lj7+pXKnXAKnZJ4sq7Wf9BjE+Q0shrvj6v+qX+mUXFsKKdAdSTBwMmzNpPc7iUWajLw4QfG+PLkaFc6moQ12gCsBsgpGP0w==
X-Gm-Message-State: AOJu0Ywnbpo8gZzjCRVB6CT77kozyWnU60HNVy2nMrr46s80aa3EG6g7
	FqFFGr4k+KPBn6pU+so5STAzjtaW/xe52Qw3roZLUbTV5z04coJ2
X-Google-Smtp-Source: AGHT+IGcSUsHtQDHF3KX5AZeA/IawTF2iTfkVdyvpmBBr3Hj/bs0e01mGLyruH0gX37jLzXz4SWHgg==
X-Received: by 2002:a05:600c:4f13:b0:421:418d:8f7 with SMTP id 5b1f17b1804b1-421418d0be6mr10237555e9.12.1717432788875;
        Mon, 03 Jun 2024 09:39:48 -0700 (PDT)
Received: from [192.168.242.235] ([109.166.154.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e8fsm9168075f8f.2.2024.06.03.09.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:39:48 -0700 (PDT)
Message-ID: <64fd8918-0c5e-462d-8ffe-964ed6404bde@gmail.com>
Date: Mon, 3 Jun 2024 19:39:46 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iio: adc: ad7173: refactor ain and vref selection
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
 <20240531-ad4111-v4-3-64607301c057@analog.com>
 <20240601194925.23123071@jic23-huawei>
 <e9ade241e57383d5342d377bc865046e612a7033.camel@gmail.com>
 <d2370ad2-5fed-41b3-bdd5-c6c895283c18@gmail.com>
 <2df46968-ff5f-43bc-98fd-506840c1aaa9@baylibre.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <2df46968-ff5f-43bc-98fd-506840c1aaa9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2024 19:00, David Lechner wrote:
> On 6/3/24 8:08 AM, Ceclan, Dumitru wrote:
>> On 03/06/2024 16:00, Nuno Sá wrote:
>>> On Sat, 2024-06-01 at 19:49 +0100, Jonathan Cameron wrote:
>>>> On Fri, 31 May 2024 22:42:29 +0300
>>>> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>>
>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>
>>>>> Move validation of analog inputs and reference voltage selection to
>>>>> separate functions to reduce the size of the channel config parsing
>>>>> function and improve readability.
>>>>> Add defines for the number of analog inputs in a channel.
>>>>>
>>>>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>>>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>> ---
>>>>>  drivers/iio/adc/ad7173.c | 71 ++++++++++++++++++++++++++++++++++--------------
>>>>>  1 file changed, 50 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>>>>> index 6e249628bc64..a20831d99aa5 100644
>>>>> --- a/drivers/iio/adc/ad7173.c
>>>>> +++ b/drivers/iio/adc/ad7173.c
>>>>> @@ -60,6 +60,7 @@
>>>>>  #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
>>>>>  #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
>>>>>  
>>>>> +#define AD7173_NO_AINS_PER_CHANNEL	2
>>>>>  #define AD7173_CH_ADDRESS(pos, neg) \
>>>>>  	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
>>>>>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>>>>> @@ -623,6 +624,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
>>>>>  static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
>>>>>  						 u8 reference_select)
>>>>>  {
>>>>> +	struct device *dev = &st->sd.spi->dev;
>>>>>  	int vref;
>>>>>  
>>>>>  	switch (reference_select) {
>>>>> @@ -646,9 +648,11 @@ static unsigned int ad7173_get_ref_voltage_milli(struct
>>>>> ad7173_state *st,
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>  
>>>>> -	if (vref < 0)
>>>>> +	if (vref < 0) {
>>>>> +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
>>>>> +			reference_select, vref);
>>>>>  		return vref;
>>>>> -
>>>>> +	}
>>>>>  	return vref / (MICRO / MILLI);
>>>>>  }
>>>>>  
>>>>> @@ -905,13 +909,50 @@ static int ad7173_register_clk_provider(struct iio_dev
>>>>> *indio_dev)
>>>>>  					   &st->int_clk_hw);
>>>>>  }
>>>>>  
>>>>> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>>>>> +					      const unsigned int
>>>>> ain[AD7173_NO_AINS_PER_CHANNEL])
>>>> I was late to the game in replying to previous thread.
>>>>
>>>> This is neater without the loop and with 2 parameters.  Anyhow see reply to v3.
>>>>
>>>
>>> Yeps, even more given that we're passing/copying the complete array which always
>>> fells awkward to me :)
>>>
>>> - Nuno Sá
>>>
>>>
>>
>> I rewrote the function, but it feels a bit awkward, perhaps I could get a bit of
>> advice before sending V5:
> 
> Maybe we could make this easier to read with macros?
> 
>>
>> static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>> 					      unsigned int ain0, unsigned int ain1)
>> {
>> 	struct device *dev = &st->sd.spi->dev;
>> 	bool special_input0, special_input1;
>>
>> 	special_input0 = ain0 == AD7173_AIN_REF_POS || ain0 == AD7173_AIN_REF_NEG ||
>> 			 ((ain0 == AD7173_AIN_COM_IN_POS || ain0 == AD7173_AIN_COM_IN_NEG) &&
>> 			 (st->info->has_common_input)) || ain0 == AD4111_VINCOM_INPUT;
>> 	special_input1 = (ain1 == AD7173_AIN_REF_POS || ain1 == AD7173_AIN_REF_NEG) ||
>> 			 ((ain1 == AD7173_AIN_COM_IN_POS || ain1 == AD7173_AIN_COM_IN_NEG) &&
>> 			 (st->info->has_common_input)) || ain1 == AD4111_VINCOM_INPUT;
>>
> 
> 	special_input0 = AD7173_IS_SPECIAL_INPUT(ain0);
> 	special_input1 = AD7173_IS_SPECIAL_INPUT(ain1);
> 
>> 	if (st->info->has_vincom_input) {
>> 		if (ain0 == AD4111_VINCOM_INPUT &&
>> 		    ain1 < st->info->num_voltage_in && /* Normal input */
>> 		    ain1 >= st->info->num_voltage_in_div) /* Input without divider */
>> 			return dev_err_probe(dev, -EINVAL,
>> 				"VINCOM must be paired with inputs having divider.\n");
>>
>> 		if (ain1 == AD4111_VINCOM_INPUT &&
>> 		    ain0 < st->info->num_voltage_in && /* Normal input */
>> 		    ain0 >= st->info->num_voltage_in_div) /* Input without divider */
>> 			return dev_err_probe(dev, -EINVAL,
>> 				"VINCOM must be paired with inputs having divider.\n");
> 
> 		if (AD7173_IS_VINCOM_MISMATCH(ain0, ain1) ||
> 		    AD7173_IS_VINCOM_MISMATCH(ain1, ain0)) {
>  			return dev_err_probe(dev, -EINVAL,
>  				"VINCOM must be paired with inputs having divider.\n");
> 
>> 	}
>>
>> 	if ((ain0 >= st->info->num_voltage_in && !special_input0) ||
>> 	    (ain1 >= st->info->num_voltage_in && !special_input1))
>> 		return dev_err_probe(dev, -EINVAL,
>> 				     "Input pin number out of range for pair (%d %d).\n",
>> 				     ain0, ain1);
>>
>> 	if (!special_input0 && !special_input1 &&
>> 	    ((ain0 >= st->info->num_voltage_in_div) !=
>> 	     (ain1 >= st->info->num_voltage_in_div)))
>> 		return dev_err_probe(dev, -EINVAL,
>> 			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
>> 			ain0, ain1);
> 
> These last two don't seem so bad.
> 
>>

Thanks for the quick review :)


