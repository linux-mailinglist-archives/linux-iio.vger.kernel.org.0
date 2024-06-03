Return-Path: <linux-iio+bounces-5685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E748D86D0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D06C1F21756
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC112E1DD;
	Mon,  3 Jun 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0KWIQ6u7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB44436
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430417; cv=none; b=JwHS3baomj4+H2aMUTUKXbu18TcBE6MEj+xaSYuNkvXXsINY5PtvBTMyKcMpTHX2s7tn1JJ4CNFCqV5pzf01IgWD3DT0hBRn6C/xrcg7coDQo5knL4xo2m8vrfxhwMJx/BLYk4s2cX38+C223tzLsnSl3yCV6a13zSijtmw9AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430417; c=relaxed/simple;
	bh=ZVmmqm2gePgCHbgRtZjzvJC1acAthJMX0qTqhdOD0n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1s3wiHegpNBs5TY57ThiNnjEiQEmppTkxx4bV3NoGzg62dB/8zb+07aCk1tK8sbMNrRgKL3Nvq9OvDraiR8nD5rh+u4ZzH/4NpIO6dE3nI4hmjFRmkymeXghGCgEyr+57ZC62QQvWZmAbdcqCATUqnysP53ScxRX8nvjVdjHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0KWIQ6u7; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f12171523eso2366044a34.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717430414; x=1718035214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfeQA5RNRJgv87my+Y8NPK/KqfRgxtKa/KFauEIvYss=;
        b=0KWIQ6u72VDXxwMo44SWqciC/xDHgGgxAPPTWLldVVEvWR/TMxyhUKdpcqBQ7G/xAC
         +9ukKNBj84OSx2QuegHZiPZm4EL4pywOKUtqNh+cXWLtRh9was3heZpeXIrClHA3VAsj
         /ohH4a8XGYpRieC03ciZCnyIXLzsY1dC++/USuNkhoP1uSL+3Z/HiN+ac7vzxDVrKITb
         fe0+NiHlJ1SU5/JX49J3p5SEDm1HtoRLgaIY+jRFG9REIVP/SBfB7TLdivSkdNLeLQWG
         erJt/krQkDWUGqP3yeKrr7iJacThzpDyb4WrgTnr9Ut9EkzgeIXJYltC3wAo794aH5vN
         cMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430414; x=1718035214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfeQA5RNRJgv87my+Y8NPK/KqfRgxtKa/KFauEIvYss=;
        b=OIyVKPXiEGsoW9qHPxQaQ6eNNPf1i/x/f3u9gQ6dFmlmeCvY9DzepFbKG+TGJMcrbG
         EH7nC17SEMa2l4S1CWdMa++0t/A7pyT7mvqen76N9cYG3V7NxmgeDNS/XsUnvgOpL0b4
         +zpfvz2On/RuAXRgCdwNwyG+510QBUL8mIt+A6sNR5DZ6fz2j8SIdwbJ+7fnZGb0PCfR
         tzd6VqblzxIW+HmQXW1G8qTgFImuag88EBvL8uXD5TmtTGLIKdcU1jBYZVxsQZpdtmur
         0hhrPSiN8ahvMClU23KLj4ZCjxAjVsPmumwoo9SUMJ2cP0DPMz/X6thNRPIVjrpHv9x/
         ULnw==
X-Forwarded-Encrypted: i=1; AJvYcCXN5HpCq/VGxuk8Y5Nud7RghoWC90iw48E8h1rCol9GZD6fc1P3Xcau70dhdLZRrICEleswKeVgk+0uChvMF2e3WuUVLmY0PqAi
X-Gm-Message-State: AOJu0YxkY3XeSv9fm+4REeBTVzSIoH6fOATFHZTwiK8Bi64xHh7t4Ev4
	2MsLvi5IHZrqRRt8P6XBuER+6/fwxZ1iybkLvqPRCzEjtvPeMXlDh8J8YZFMah8=
X-Google-Smtp-Source: AGHT+IGTlHNJVslE6UXb6KM6zbiO1iPpViMFSEIvv4eTobL0M2MR8UH3PgujM5HpvfFAmIPaSVMo3w==
X-Received: by 2002:a05:6830:1b78:b0:6f1:2215:e1e3 with SMTP id 46e09a7af769-6f911f1fe3emr9493205a34.6.1717430414142;
        Mon, 03 Jun 2024 09:00:14 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91059ce02sm1491108a34.54.2024.06.03.09.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:00:13 -0700 (PDT)
Message-ID: <2df46968-ff5f-43bc-98fd-506840c1aaa9@baylibre.com>
Date: Mon, 3 Jun 2024 11:00:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iio: adc: ad7173: refactor ain and vref selection
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d2370ad2-5fed-41b3-bdd5-c6c895283c18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/24 8:08 AM, Ceclan, Dumitru wrote:
> On 03/06/2024 16:00, Nuno Sá wrote:
>> On Sat, 2024-06-01 at 19:49 +0100, Jonathan Cameron wrote:
>>> On Fri, 31 May 2024 22:42:29 +0300
>>> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>
>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>
>>>> Move validation of analog inputs and reference voltage selection to
>>>> separate functions to reduce the size of the channel config parsing
>>>> function and improve readability.
>>>> Add defines for the number of analog inputs in a channel.
>>>>
>>>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>> ---
>>>>  drivers/iio/adc/ad7173.c | 71 ++++++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 50 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>>>> index 6e249628bc64..a20831d99aa5 100644
>>>> --- a/drivers/iio/adc/ad7173.c
>>>> +++ b/drivers/iio/adc/ad7173.c
>>>> @@ -60,6 +60,7 @@
>>>>  #define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
>>>>  #define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
>>>>  
>>>> +#define AD7173_NO_AINS_PER_CHANNEL	2
>>>>  #define AD7173_CH_ADDRESS(pos, neg) \
>>>>  	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
>>>>  	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>>>> @@ -623,6 +624,7 @@ static int ad7173_setup(struct iio_dev *indio_dev)
>>>>  static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
>>>>  						 u8 reference_select)
>>>>  {
>>>> +	struct device *dev = &st->sd.spi->dev;
>>>>  	int vref;
>>>>  
>>>>  	switch (reference_select) {
>>>> @@ -646,9 +648,11 @@ static unsigned int ad7173_get_ref_voltage_milli(struct
>>>> ad7173_state *st,
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> -	if (vref < 0)
>>>> +	if (vref < 0) {
>>>> +		dev_err(dev, "Cannot use reference %u. Error:%d\n",
>>>> +			reference_select, vref);
>>>>  		return vref;
>>>> -
>>>> +	}
>>>>  	return vref / (MICRO / MILLI);
>>>>  }
>>>>  
>>>> @@ -905,13 +909,50 @@ static int ad7173_register_clk_provider(struct iio_dev
>>>> *indio_dev)
>>>>  					   &st->int_clk_hw);
>>>>  }
>>>>  
>>>> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>>>> +					      const unsigned int
>>>> ain[AD7173_NO_AINS_PER_CHANNEL])
>>> I was late to the game in replying to previous thread.
>>>
>>> This is neater without the loop and with 2 parameters.  Anyhow see reply to v3.
>>>
>>
>> Yeps, even more given that we're passing/copying the complete array which always
>> fells awkward to me :)
>>
>> - Nuno Sá
>>
>>
> 
> I rewrote the function, but it feels a bit awkward, perhaps I could get a bit of
> advice before sending V5:

Maybe we could make this easier to read with macros?

> 
> static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> 					      unsigned int ain0, unsigned int ain1)
> {
> 	struct device *dev = &st->sd.spi->dev;
> 	bool special_input0, special_input1;
> 
> 	special_input0 = ain0 == AD7173_AIN_REF_POS || ain0 == AD7173_AIN_REF_NEG ||
> 			 ((ain0 == AD7173_AIN_COM_IN_POS || ain0 == AD7173_AIN_COM_IN_NEG) &&
> 			 (st->info->has_common_input)) || ain0 == AD4111_VINCOM_INPUT;
> 	special_input1 = (ain1 == AD7173_AIN_REF_POS || ain1 == AD7173_AIN_REF_NEG) ||
> 			 ((ain1 == AD7173_AIN_COM_IN_POS || ain1 == AD7173_AIN_COM_IN_NEG) &&
> 			 (st->info->has_common_input)) || ain1 == AD4111_VINCOM_INPUT;
> 

	special_input0 = AD7173_IS_SPECIAL_INPUT(ain0);
	special_input1 = AD7173_IS_SPECIAL_INPUT(ain1);

> 	if (st->info->has_vincom_input) {
> 		if (ain0 == AD4111_VINCOM_INPUT &&
> 		    ain1 < st->info->num_voltage_in && /* Normal input */
> 		    ain1 >= st->info->num_voltage_in_div) /* Input without divider */
> 			return dev_err_probe(dev, -EINVAL,
> 				"VINCOM must be paired with inputs having divider.\n");
> 
> 		if (ain1 == AD4111_VINCOM_INPUT &&
> 		    ain0 < st->info->num_voltage_in && /* Normal input */
> 		    ain0 >= st->info->num_voltage_in_div) /* Input without divider */
> 			return dev_err_probe(dev, -EINVAL,
> 				"VINCOM must be paired with inputs having divider.\n");

		if (AD7173_IS_VINCOM_MISMATCH(ain0, ain1) ||
		    AD7173_IS_VINCOM_MISMATCH(ain1, ain0)) {
 			return dev_err_probe(dev, -EINVAL,
 				"VINCOM must be paired with inputs having divider.\n");

> 	}
> 
> 	if ((ain0 >= st->info->num_voltage_in && !special_input0) ||
> 	    (ain1 >= st->info->num_voltage_in && !special_input1))
> 		return dev_err_probe(dev, -EINVAL,
> 				     "Input pin number out of range for pair (%d %d).\n",
> 				     ain0, ain1);
> 
> 	if (!special_input0 && !special_input1 &&
> 	    ((ain0 >= st->info->num_voltage_in_div) !=
> 	     (ain1 >= st->info->num_voltage_in_div)))
> 		return dev_err_probe(dev, -EINVAL,
> 			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
> 			ain0, ain1);

These last two don't seem so bad.

> 
> 	return 0;
> }
> 
> It feels a bit too verbose, but I could not come up with a better way to
> incorporate all those cases.


