Return-Path: <linux-iio+bounces-17717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA8A7D36E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B703D188A77A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 05:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B272222A2;
	Mon,  7 Apr 2025 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aargRNwS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224A8494;
	Mon,  7 Apr 2025 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003393; cv=none; b=JEguFtxJeWo25n4rYbMZ2FAz3Cyb9OuVN+aEChJqmt2NjcFE7VMrlHFmwEzs8RdCYH8LEKOyXmddv/sSdOG1J1ds5Ev26n8Xs1wc3tj8SL4elLHEUbkp/OQt08+McusArUibCp9vMDIeENNmfTLpMkkq/hRzfDmOTSKEjIDDng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003393; c=relaxed/simple;
	bh=4Uw7pJFtBIeo6dVfZ8PPt8rulIb8ur1utK/lmAzQrQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7OWLkPyeFK7E+XKzHoqhmbgB+ubIXLLPFWieNkJ0GPxSO2o38xZ/FjNxiY+pHfbMTSRhCLwUSbefIVI3oCg9axWvlRFZQgaub4nB3oCcDdii+Nu1clRRSZ3/ozzwqcyhdjhc68VfPZWJUPTCU9nPk6KSx1Iu00gdghdx8NpEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aargRNwS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bd21f887aso32688611fa.1;
        Sun, 06 Apr 2025 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744003390; x=1744608190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZANaSp06H/1zuBfOX6aMv95xWnp689wwAWAXkSh8Fo=;
        b=aargRNwSlXq7QA6rnvFI+g9lUhzDzuGuIYsPN7sAhkfZkAtYPXf21uncAXPdl93bKN
         o/13mpjiH3pFow/IL7dbzcG37Q+EmCfICsbUJK74Qw7q2U/oQDltDv4wfm91nVhwcGwv
         X9ph4iuNETo+jLDTN93S58CjxKgpNShjStIalD9XvEX+IDVj8fTGj95ssSFDqJfbXtJC
         RnodNnRiEeIxa7KmSmGX/a2MgqY0dKTzUeRenhoMzzj3bivURpVvfY7ye5vEayalb1jB
         kzlOPaRMSxw3hGbQ4GUR436NzOiRAFwFo3vSj6sX1bM63GHIgZ8ILBYYubcJ8gpuAYUp
         ZI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744003390; x=1744608190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZANaSp06H/1zuBfOX6aMv95xWnp689wwAWAXkSh8Fo=;
        b=io6mKg9XutKY7TCADHrqEcvhAn7f+MaSse199wLby7BjaB/1rpsd6fq7SGb3fFPfVz
         E+3FQxJs64Ez5m9Hd4n0UBhnnzZIpz3tSfQm89PKcWNNnSIi3x9H0MLhnl0LX9uSnXQO
         S00/6IhMrxVMAsl6T4dK1DiVPeznCEVRX/SheyXQnWobVXo5P5qj7N5RRmjDaoUmeSpw
         arK7Re1x4NzkrHaIUstkQSTjt/0W1Z/5DKzxIjxmYei4ZShVXq1ykcXjLX4yUIQiSm9a
         y1PPNxqW735t8GpaaZrNZyu4oIZIZ1JnqRSxqGS+1rsmf789LXXGXBrJTeYS+AE2jCVT
         dn3g==
X-Forwarded-Encrypted: i=1; AJvYcCUyHphQu5juVcFblHOFGTg8IZOJ4XOAXNgfQC8lTwlxnRa5H68IVa6YOhOVfP6PcIi2xk4bP7j2xiRdy9wQ@vger.kernel.org, AJvYcCWTuyy5vnFmSCIvsB7sk0R56MFiWkZIt2hNX12O/23t7jvunIQfoo6GgUZ+eZnoO0G8OrUN1ya1oExC@vger.kernel.org, AJvYcCXzVz+jorC/vQNAan8VC7c2jLJ+Qcm/ebS6oZsP1Ul9vevnopxycP4oU/9awfyK4OlOX1Qy+iGhCX2A@vger.kernel.org
X-Gm-Message-State: AOJu0YxW12Cox6n3pQDvp4fWDnPTQ+Adma5ulrYLN2ftsvBi2hFPaQTZ
	ZF951PKi2MnRkK5e+N3LD0KU6NaqrrEYR5TWhNlufzFkahtkDxZM
X-Gm-Gg: ASbGnct7BxVZDNJz4/Ot4dm0Q1Y5nNAqz/MQRt6BewaDKKAf00hqiLok4LxEujnCERD
	0ps+r/PsXlzSqGbQwEI5t9XHkI6mCqsMhcrtop9CJG+F3xyDYY1YTTOmmPBXtL1fn1okAL1VBNr
	3NNmUNfhVIsTaZ0bhhacYjd7/nyvkmJkutGL+wdjdcDfbC4yYEYWbl1JfVyv+EzDB/TiCX3qvA+
	SWD8cJsqRZOQ5LZIM1gaaKB/bthF0bwSUzYIU8azg6s3bo3h/nxP8ipBgp7B3GI6NykY7BbtAsr
	NNRchRhyaAaCntac+2MZbBENLgLSyhFsBl//7yPKlBxvjyzFZ6dKdnXA/sARpseBl0/pmYkmxdv
	LsfrPeDVRb4FOWUkDDuDqvA98PA==
X-Google-Smtp-Source: AGHT+IEgySfLI1L1T8MWtXptzRJN9uFoexwic2gP0ZiQ3d7z3jM4gXG3jDpwUyK/HKryt32JM60Fhg==
X-Received: by 2002:a2e:bd88:0:b0:308:fbd5:9d2d with SMTP id 38308e7fff4ca-30f0c07084amr32615301fa.37.1744003389759;
        Sun, 06 Apr 2025 22:23:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0313f374sm14219601fa.24.2025.04.06.22.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 22:23:08 -0700 (PDT)
Message-ID: <4f099833-5aa6-47cc-917c-7a466cb644b9@gmail.com>
Date: Mon, 7 Apr 2025 08:23:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iio: adc: ti-adc128s052: Simplify using
 be16_to_cpu()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
 <feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
 <4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
 <1189b539-adb4-46f9-9783-c6577b57a304@gmail.com>
 <20250405182947.06d5e67f@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250405182947.06d5e67f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/04/2025 20:29, Jonathan Cameron wrote:
> On Thu, 3 Apr 2025 08:16:43 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 03/04/2025 00:04, David Lechner wrote:
>>> On 4/2/25 1:09 AM, Matti Vaittinen wrote:
>>>> The register data is 12-bit big-endian data. Use be16_to_cpu() to do
>>>> the conversion, and simple bitwise AND for masking to make it more
>>>> obvious.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>> Revision history:
>>>> v1 => v2:
>>>>    - Fix commit msg to reflect the fact there was no bug
>>>>    - Drop Fixes tag
>>>>    - Use union for rx / tx buffer to avoid casting
>>>>    - Keep the shared message protected by the mutex
>>>> ---
>>>>    drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
>>>>    1 file changed, 10 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>>>> index a456ea78462f..3e69a5fce010 100644
>>>> --- a/drivers/iio/adc/ti-adc128s052.c
>>>> +++ b/drivers/iio/adc/ti-adc128s052.c
>>>> @@ -28,32 +28,34 @@ struct adc128 {
>>>>    	struct regulator *reg;
>>>>    	struct mutex lock;
>>>>    
>>>> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
>>>> +	union {
>>>> +		__be16 rx_buffer;
>>>> +		u8 tx_buffer[2];
> As below. Maybe
> 		__be16 buffer16;
> 		u8 buffer[2];

Ok.

>>>> +	} __aligned(IIO_DMA_MINALIGN);
>>>>    };
>>>>    
>>>>    static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>>>>    {
>>>>    	int ret;
>>>> +	char *msg = &adc->tx_buffer[0];
>>>>    
>>>>    	mutex_lock(&adc->lock);
>>>>    
>>>> -	adc->buffer[0] = channel << 3;
>>>> -	adc->buffer[1] = 0;
>>>> +	msg[0] = channel << 3;
>>>> +	msg[1] = 0;
>>>>    
>>>> -	ret = spi_write(adc->spi, &adc->buffer, 2);
>>>> +	ret = spi_write(adc->spi, msg, sizeof(adc->tx_buffer));
> 
> I'd get rid of msg as it's now just confusing given we are
> using the sizeof() here.

Ok.

>>>>    	if (ret < 0) {
>>>>    		mutex_unlock(&adc->lock);
>>>>    		return ret;
>>>>    	}
>>>>    
>>>> -	ret = spi_read(adc->spi, &adc->buffer, 2);
>>>> -
>>>> +	ret = spi_read(adc->spi, &adc->rx_buffer, 2);
> 
> sizeof(adc->rx_buffer)

I was thinking of this but went with raw 2 - because we need to read 
exactly 2 bytes from the device. Sizeof buffer is matter of software 
where as the 2 bytes is dictated by the device. (Sure the size of buffer 
needs to be large enough).

I don't care it that much though, so I can go with the sizeof() if 
that's what you prefer. Just explaining that the '2' here was a 
conscious choice :)

>>>>    	mutex_unlock(&adc->lock);
>>>> -
>>>>    	if (ret < 0)
>>>>    		return ret;
>>>>    
>>>> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
>>>> +	return be16_to_cpu(adc->rx_buffer) & 0xFFF;
>>>
>>>
>>> The cast isn't exactly beautiful, but this would save a lot of
>>> lines of diff and a few lines of code by avoiding the need for
>>> the union and the local msg variable.
>>>
>>> 	return be16_to_cpup((__be16 *)adc->buffer) & 0xFFF;
> 
> The cast only works because we have forced the alignment for DMA safety.
> That to me is a little fragile.
> 
> You could do get_unaligned_be16() which doesn't need the cast then carry
> on using the original buffer.
>>
>> Thanks again for the review David :)
>>
>> I am unsure which way to go. I kind of like having the __be16 in the
>> struct, as it immediately yells "data from device is big-endian". OTOH,
>> I've never loved unions (and, it silences the above "yelling" quite a
>> bit). I still think this might be the first time I really see a valid
>> use-case for an union :) And, you're right this adds more lines,
>> besides, the cast doesn't look that ugly to me. Yet, I originally had a
>> cast probably as simple as this (and I also had the __be16 in the
>> struct), and Jonathan suggested using union to avoid it...
>>
>> At the end of the day, I suppose I am Okay with any of these 3
>> approaches. Original cast, union or this cast you suggest. Jonathan, any
>> preferences on your side?
> 
> Majority of the diff is really about renaming buffer to tx_buffer.
> Could just not bother doing that and instead have buffer and buffer16
> as the two union elements. With msg gone as suggested above, then the diff
> becomes only a few lines and you get to keep the nicety of it being either
> a pair of u8s or a __be16.

I was tempted to try using the spi_write_then_read() - but I suppose 
this may be kind of a hot path.

I'll go with (not)renaming the buffer and dropping the msg, to squeeze 
the diff.

Yours,
	-- Matti

