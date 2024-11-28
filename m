Return-Path: <linux-iio+bounces-12776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA4D9DB783
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 13:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58F81631B4
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16419C54C;
	Thu, 28 Nov 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7wA5sLc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06384F20C;
	Thu, 28 Nov 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796817; cv=none; b=BRTx27mkpitVHabu59vhhlXD8t2h0djP1mQUrGSadUQzsjG6xTe5YybGDhHv2k1sUR71uX2pkvW5K9taZnGL9c8F0vEJ8s9zVW/8PM41Q/1ZErfFoBB9fXPeZ+17zn3cKKX0Y9/5eMCh38iJ54dCQJDKtjVkT17Zx1S/5AgUBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796817; c=relaxed/simple;
	bh=cdJQSF24okpmJp3OTyRFJYSdiudOmESvovIU9KWMCfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxRTWAV1JcvxVSuewYQOEkaVNzYHC6+/4lEz5nOMwZa6Busm1KVDonGn8QQQWWc8rbCwxINGY1QaTkfkOSFD0/GY1n5fq6LrIh2AsUbt1/t0TPdTtiuX9TFNoH+gxX/a7gMf/D4G1iZJCXDzdawHPZTZmAwiALYofAQDmi8is5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7wA5sLc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa560a65fd6so143331966b.0;
        Thu, 28 Nov 2024 04:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732796814; x=1733401614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZ9WNpBlKtazde7jfmSDXXstDaTslJye7caY08L0qq8=;
        b=M7wA5sLchjbkyH0UIW/N1pqITW6Y4T/9GkzMo2EZM/VUPay+MYRcjOUlb9Tt+dHNml
         3tl5vg2Lhk4TphMXhp2qa8i5utLhoWQ/3RmAyWvqqLPPvxU7KCV2Bv4We6zphB6kWMUA
         vC9DfPg8+zrybxyiGVw4qN+u6vxqlfgw/onWEliaUcREG+vI19b9sL67iI2UQPXnWKa8
         kHSRlgifG/FOrhY5Rd37L4O7Igz8sZ7an23xHE7VBMk0aqJG8VuIj7K3M5zCUNMj5qXQ
         iKY2O+W6J71z5HHx10ZvAsJfVVtd0BkCHBD1nPCJxgMl3z26TEjtKhmQCoDeD5OvLVH9
         gb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796814; x=1733401614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ9WNpBlKtazde7jfmSDXXstDaTslJye7caY08L0qq8=;
        b=YXjw7hVCNgmydQd5VAOZl3z7LeMmxT+KWqse2G4QHlz68YK3VZcQn85dOMxuFQkV+y
         0xAs10t2oaQo3PSP260TrkYyDq9H15h2tlfoGf9ssrrUJRffif0Fpxnuv6wdTF3+hGxs
         Xqk1EIEP1ua82oKGJj/Xr30L8PmfACssl6VjpVJWmjzOuOS9Ic2f+lOVvEDQfJIbrhhk
         GZcXdCZTIKPYRaj0EGlqxkKFsH7o6hO1uXvUeHqvEtUi30cV98LCnAjTTTLZ71GBCPa6
         kr9/IU1HiDqbrtETFDzC6b1twftsQl9uZ6U/6JjOOJxRknUWDzTXsxOQp/2ebYLPLLXH
         mh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhqgrLH+ufqCC3o4O/YVAF0oI0aFNE7SqQXuNS7M3AibfislMnk1GwrE7+DNoy887Lp3gc4agTdjLA@vger.kernel.org, AJvYcCXmtUQEEl1jygtMpWHZsxnjWb699KmLDhb0pX3rNWzp9ZVTZJ874kr3Rcyi/nW/ejEkYc3HZA8DGNcf4f7s@vger.kernel.org, AJvYcCXnmICxd2+bGxitR/ymPn+LjzR1NnLR5V7aFstmL5RP7im4xbXvvevzkeyFlAPyA7nGerhc8KaF7/ZU@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3AF0IXWcEudmqg+VOoceif/80KyQJ09twMCZRFBNIKaUMbUQ
	BEFnzPvBoyXimV+U/ZyCyKUnpNIAw8hEPjqYEbpx86WUxnW6o7T2
X-Gm-Gg: ASbGnctSPLBMJMCorygbyN8h7zsvoGmoSRanVwxnnvE12dzBpfCtAg2zbeoDQDFwMmG
	M1cPTKEv8IeFwYYVMAFA3U+mYMND+JeNSHhAjH8HisfyXJtWfGFO1c33wvqJ8oL8y7AWz09O3B5
	3HFnyhn1fh45ykApx8TNMM4K4UhwHhILWxRjxAdZZY90pYX9Y7yHtv1JxXWA4ioFJWsgLLevpcq
	USoMRfP01UA025dKxrkV8zYNUObE4a08KMX3zrE4l+uRQF/kL4GBimZjlXSVftdLwUlS+WqsH3X
	rHRK6pwamOUpwBKIl4dbGgNylc4C
X-Google-Smtp-Source: AGHT+IEBNEkepuyx2gsAoW/fXLnYQtrcq4HcBEGgeWPuDBUzCkSPR2feCwkXcaZgIXT3GzltKWwEtQ==
X-Received: by 2002:a17:907:1c8c:b0:a9a:e0b8:5bac with SMTP id a640c23a62f3a-aa594708919mr210265566b.23.1732796813521;
        Thu, 28 Nov 2024 04:26:53 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999731d5sm60837966b.200.2024.11.28.04.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:26:52 -0800 (PST)
Message-ID: <3af77b51-d254-4c97-8faf-1dea29a4f9b1@gmail.com>
Date: Thu, 28 Nov 2024 13:26:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
 <20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
 <20241021193933.59c2d2b6@jic23-huawei>
 <7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
 <20241022192807.2f83dfa1@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241022192807.2f83dfa1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 20:28, Jonathan Cameron wrote:
> On Mon, 21 Oct 2024 22:21:22 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> On 21/10/2024 20:39, Jonathan Cameron wrote:
>>> On Sun, 20 Oct 2024 21:12:17 +0200
>>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>>>   
>>>> The Vishay veml3235 is a low-power ambient light sensor with I2C
>>>> interface. It provides a minimum detectable intensity of
>>>> 0.0021 lx/cnt, configurable integration time and gain, and an additional
>>>> white channel to distinguish between different light sources.
>>>>
>>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
>>> Hi Javier,
>>>
>>> I missed one thing on previous review...
>>> There is no obvious reason this driver needs to provide raw and processed
>>> values.  Unless I'm missing something, just provide raw and let userspace
>>> do the maths for us.
>>>
>>> Jonathan
>>>   
>> Sure, I will drop that for v3. I added it because this driver took the
>> veml6030 as a reference, and that driver provides the processed value. I
>> guess that the veml6030 should have not provided processed values
>> either, but it's late to remove them after the driver was released.
>>
>> Now that we are at it, what is the rule (of thumb?) to provide processed
>> values? Those that can't be obtained from the raw data and simple
>> operations with the scale/offset/integration time/whatever userspace can
>> see?
> 
> Yes. If the conversion is linear, then leave it to userspace (with scale
> and offset provided). If it's not linear then in kernel because currently
> we have no other choice.
> 
> There are some historical quirks where a processed only interface got in
> then we had to add raw later (typically when we added buffered output
> where scale and offset are important because processed values normally
> don't pack well).
> 
> Jonathan
> 
> 


Hi Jonathan, I am bringing this back because I am not sure if dropping
the processed values was the right approach here. I would like to
clarify before propagating some approach that might not be accurate.

This sensor is linear, and the processed value can be obtained by simple
multiplications, but not just raw * scale as documented in the ABI.

This driver is based on the veml6030, whose processed value is obtained
as raw * resolution, where the resolution is completely linear and is
obtained as sensor_resolution * integration_time / scale.

That means that the scale is actually a gain, and the user needs to know
the sensor resolution provided in the datasheet (see cur_resolution in
veml6030.c) to get the processed value. There is a sensor resolution for
every pair { gain, integration_time } in the datasheet, so there is no
need to calculate anything, yet the resolution is not provided by the
driver.

Nevertheless, your comment on this matter was the following:

> Why both raw + scale and processed?
>
> We normally only provide raw and processed for light sensors if:
> 1) The conversion is non linear and hard to reverse.
> 2) There are events that are thresholds on the raw value.
>
> Here it is linear so just provide _RAW.

That is still true in this case, because it is a linear, easy to reverse
conversion. Nevertheless, the user needs to look for the sensor
resolution in the datasheet and then use the given integration_time and
scale.

Is that ok and desired for light sensors? I think that a more accurate
approach would have been treating the gain as a HARDWAREGAIN, which
would have been used to calculate the scale i.e. resolution to directly
apply to the raw value. In its current form, the processed value is not
what you get if you do raw * scale. But as you specifically mentioned
light sensors in your comment, that might not apply here. Moreover,
there are only two drivers (si1133.c and vl6180.c) that use HARDWAREGAIN
for IIO_LIGHT, which makes me think I am over-complicating thing here.

By the way, in_illuminance_hardwaregain is not documented in the ABI,
only out_voltageY and in_intensity. But that is another topic.

The veml6030 has been around for some time and there is no way around
without breaking ABI, and the veml3235 has been only applied to your
tree and maybe it could wait to be released.

If everything is ok as it is, then that's the end of the story, but if
the processed = raw * scale operation should apply, the veml3235 could
still be fixed. And when it is too late for that one too, then I could
follow a different approach for the veml6031x00 I recently sent to avoid
propagating the issue.

Thanks and best regards,
Javier Carrasco





