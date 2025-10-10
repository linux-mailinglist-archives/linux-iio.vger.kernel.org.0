Return-Path: <linux-iio+bounces-24912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E300BBCDDF1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9715B188BEFC
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CC239099;
	Fri, 10 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N2+ivFbN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668102609D9
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111447; cv=none; b=BzjpNI46qAvLiClX+Vxm7Tklv+VTUY4qndSKPxR4mQWY14F4/q7xKkYQwY1y8cSO1LdyDi95E6qh8+pF6hIE2W3ZLfltnKPbsuYjoItPVgPgtmHI6yWmbYowVSB8XBL6IW44bA2OKwZqLF49GHABIn+Tk1+kbO5kixE0EHta++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111447; c=relaxed/simple;
	bh=Lr+jKNfeiIaKX/OCJwSJFFQhKa98XMsgnhtzVqhKr+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er4leKyJjzR5Ir68e7/g/ZAN2OnmMFW1zzHmfKQ4lj8Kj9NBr6zSIvujcuqk7rwffh+wLI9XUj25UjfaGFv7CRcN6pP1TW/QwenA9DS2t5+YJVRZxt2MaTVBkQYBNkIgr1hUYDqOMW4ibhSinVHXYqLaT4ZNe18vIYY1JihNgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N2+ivFbN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-43f5ec025d3so1105923b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760111444; x=1760716244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Wla+XRCNTxPSui7Pm3LI+bmBJn47wan8XF9ZjOoM70=;
        b=N2+ivFbNOjCsuVXun5JLnggSTPx9/Su4gFlgGvgxKCc3dtBzXS1B5eR7eR6kccTgGL
         aONNtlO2XqMyv6rSc7aq6Lfi+3D0ZTDoUmBqY+AD8SSurKZRTKjynKY3SF/OTKyDQWJf
         KsN+AackdmYPjEkQwhyEtTfDSD/JWV1Db1Ol/b9JL3103OPpL17eTv0PwX5TWV26y3tE
         cI/jXGjVHvT2Aj+1XDeD66miZSiLU3FTCgxsZ2wLpwJmPpUrTarPgBw9rpSFM7xO/5RJ
         WE7AgSDvcr51ycIBr5vsyDEoBxudCWN7LmsgEg7iwAacqRYrM/M3SaaZEQ/R8x8wAYTY
         mX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111444; x=1760716244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wla+XRCNTxPSui7Pm3LI+bmBJn47wan8XF9ZjOoM70=;
        b=MbVSnE/BYPQwMPr+P694zOjlEc8rzl5KxeXMhwdEhjcES8wFZewckUkzj0U5baQe7T
         QJpe2WTBk1xWSpAMpq99cBIqq3b6Onuqf5vnODHVb3dvj+BsqJ16XMDRAwCsKj1NVIDn
         qgQ6pKo2GB2FPhH0Jmmano0sOHH66r+uI11nIHYwLhZSwCOq3t/YJw+BWm1VSK5uyl9e
         SORKKRR/s0hqyTeILRVY/zaWc+31nPn25BpM9S8Mc9WHB4waAhINsxrqw0uRCdqBnIGp
         CPcOeBJxwATo1Ssc1gE7k8NDYGBCAw6JdVP4KbG507RvVF1cwsRo572rtHwRdK2cgAgK
         Y+IA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhGSIn2w/Qpx0YFotjqUuSBefSpW6cOQj091MTHNuBjag0dNAsFT9y8xAqKwm1BGg+qMDzi9kO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyGl22LYifC1Jd/zdPB+I7BdAzVFyj2Qys4zXxLjnULhldFTz
	3UN14Kf1n9iK9Ss/qvczpHDtlXifzafUMNjk/uaJ8rspY44UU2ZdzdmOArYLFt4cKjk=
X-Gm-Gg: ASbGncvabNr0JHwRhwnwGygDlSl/JrnKhk6eWN2ie6lx/CMW1GnZWoGaQZouxFx1YNu
	kKRpp2sUFDsLpA/uXpl0/gTtYCExTbEGhM/z5O9M5tPomStSLgTHmSheWFboh3E7YX+lwCZzGbM
	J2o3dDsNAMheOcLN8K02rzUlJQSfM/F5TT96Kj6b6Be57Pz6wD//FZotcq922y9soFCBiQz+AKu
	j6iY/VDyywvngbnQILKWUoGu9E21C7bexmTZdFV2oXcHmqHSJa0q2CkD2763vjRbjyF35Doo06o
	UXe1C4jXZYSK1AP/Bw6Xaxiw2nLFFhy9conFhVwsnZR8tCOZLhL8pV7lAvRb4Y1lXv6uNGZ4dfk
	ZvpZ7/Qy2lCOnefp1+185jc67vO3dxAnfOpwFyFCNorVXpw6Yv0kVZAO0WAoslvvmf2HuNM1Dae
	7A8xI5M8EloZyCjP59P0nLupEi3Q==
X-Google-Smtp-Source: AGHT+IFmSQs/65lBMWUZCbPudB/Y7vsZmZnRWmezkFLrbBsfFTtCSMn4x+tYxlovrhd6L79TJQ3aRA==
X-Received: by 2002:a05:6808:15a0:b0:43d:20f2:2e26 with SMTP id 5614622812f47-4417b34558dmr5969421b6e.10.1760111444375;
        Fri, 10 Oct 2025 08:50:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f9067bbbsm944113a34.10.2025.10.10.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:50:43 -0700 (PDT)
Message-ID: <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
Date: Fri, 10 Oct 2025 10:50:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com> <aOg3dg21aWNTF47x@lore-desk>
 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk>
 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
 <aOkG-jBOYXxWy1z3@lore-desk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aOkG-jBOYXxWy1z3@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:
> On Oct 10, Francesco Lavra wrote:
>> On Fri, 2025-10-10 at 10:13 +0200, Lorenzo Bianconi wrote:
>>>> On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
>>>>>> The rate at which accelerometer or gyroscope sensor samples are fed
>>>>>> to the hardware FIFO (batch data rate, or BDR) does not have to
>>>>>> coincide with the sensor sampling frequency (output data rate, or
>>>>>> ODR); the only requirement is for the BDR to not be greater than
>>>>>> the ODR. Having a BDR lower than the ODR is useful in cases where
>>>>>> an application requires a high sampling rate for accurate detection
>>>>>> of motion events (e.g. wakeup events), but wants to read sensor
>>>>>> sample values from the device buffer at a lower data rate.
>>>>>
>>>>> can you please provide more details here? Are you using the hw fifo
>>>>> to
>>>>> read
>>>>> data? If we configure the hw fifo according to the BDR (even assuming
>>>>> the
>>>>> watermark is set 1) the hw will generate interrupts according to the
>>>>> BDR
>>>>> (bdr < odr).
>>>>
>>>> Yes, I'm using the hw fifo to read data. The use case is to enable
>>>> event
>>>> detection (which works best at high sampling rates) and sensor data
>>>> streaming at the same time, without requiring the data stream to be at
>>>> the
>>>> same rate as the sensor sampling rate. So the amount of I2C (or SPI)
>>>> traffic (as well as the rate of periodic interrupts) required by the
>>>> data
>>>> stream is kept to a minimum without sacrificing the accuracy of event
>>>> detection.
>>>
>>> I guess you can get the same result (reduce sensor data interrupt rate
>>> keeping high odr value) configuring the hw fifo watermark.
>>> Does it work for you?
>>
>> Setting the hw fifo watermark to a high value reduces the rate of
>> interrupts, but doesn't do much to reduce the amount of I2C traffic, so the
>> issue would still be there.
> 
> ack, now I got the goal of the series. I think the series is mostly fine.
> I guess hwfifo_odr instead of bdr is more meaningful, what do you think?
> Naming is always hard.
> 
> Regards,
> Lorenzo

In the IIO subsystem, we prefer to include the units in the variable/
field name as well, e.g. hw_fifo_odr_mHz.

