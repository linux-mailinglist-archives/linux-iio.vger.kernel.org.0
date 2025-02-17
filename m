Return-Path: <linux-iio+bounces-15704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDDA3866B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06453AA43B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7C21CA07;
	Mon, 17 Feb 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRbZZpqA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6456B81;
	Mon, 17 Feb 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802283; cv=none; b=QAUjSxUQrXAlDb1Eetd2aYt19Wvz9DEFHSCEvyUyEPwGjl0rgIoylibqMLl3YSUyquYFPBSS/uC/jqH+i9fav1eJZSRzCogzLhIcao1Jt/CMTIkl6S35zbvOmu+WCWheDqnhX/y0cFa5NelCmm7rtbIQV1bqeKrWl60YL161yG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802283; c=relaxed/simple;
	bh=gECeAcSSFF8Y8SPHxl/6WhGB5p1WE7f6SSFMVCfEmzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5C7lVCpc1iz4uW64NEdw7zTA6MGGzpRac609Vgq2VgMw8B83NBHFhiotrvPVp+qlZBOovrd5F1Wiatdy8LeUoCe6iHrDGWup+wgpaUwQ9SxUJhgbRAKN5p3dBoeviUP1lNDTCc2QQFZxUWEILAi/fe+or6KxxDRNTwBptj7YzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRbZZpqA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452c29bacfso3479162e87.3;
        Mon, 17 Feb 2025 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739802280; x=1740407080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqvHWCxai7bhvrrurQEaDaaOMz2RAjRuB7D4ni+5wPU=;
        b=gRbZZpqAP90FkI/QrF6xwVSbZ/YwlzLfueYMrkr4RDd17gdarmy570hwYDV7gCd8ZL
         7htTJg/EMk45Dag+17nPoNJvx6j2J3d2Jmzo8eoNRVAFAOqsI/Z1lv78godXGYzYguDJ
         b9SqQv/fjkuYMCn/vcN5Al5GDVB7CP7gpemiTrtHyMsFLrcpHEleGyIY+vF5WFYXpZpc
         JjyhT9Qmpu93uICKTuhOm9bXccUgbo352QLHBFO2+BobUrS+roZmIF6DmEYLxCKyBOp9
         9JoDkdjYKE+942KCH6wYbX0uX3UG5FF6hevL5akOnNMC6MhFgC0hBL9x2097mcAeshvh
         kxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802280; x=1740407080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqvHWCxai7bhvrrurQEaDaaOMz2RAjRuB7D4ni+5wPU=;
        b=OXG2NhQiTPavVlaxbpJT24UExtqunb9Iy02y8xotFqONoSExC6fOZv275X+meCdcc6
         Y9cA/SKLu5R5J/c7uLtO0oKLVl6VMu4e++3w7eRDJ2Tvoyz4tmVinKYt2HVlPaNX9s5y
         svJFfxqUt6sEZkzaSY2U8mLe1Zzd8kHJGhF9tXC21l63WrmHK54ST0f6J22L+UFCW7Qy
         5zg5gflwZFn1sAq9U4KNs5ret9IqiJ8eUY0UQO44jVDjxNBFPmkVdmfFGzNM11Yo3gVI
         b/TfakP5GPMfZbG8O59MZeJCwGh0H0r35rNIuaIrEMG2/8rpmXjd+1sLXnbQ1vhp8LHV
         0Q5g==
X-Forwarded-Encrypted: i=1; AJvYcCUbGXIYG6+yw3024tj7/mqNfrLfhk4C/TVLo1xI02/CEi+hT+KCa6LmhxpQ+HPoEqILDRL1EbiahHfr@vger.kernel.org, AJvYcCVcq6uw9hUaUTpwJ3yCqulaQzEyWRW38ZO1r8sDww/kU9GSspc3RGRtQMms+swWHrzskjLA64Xs601G@vger.kernel.org, AJvYcCXkRPXQrilgOP5dU0NmR6nyp2dk+AiCDrl8SU3z03yYbI6PPT8WEJxcJORvAivBPvowlAI9R9hIQM4tezj+@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhNtQXSholPQu3wPOI7+nykSEuFv9z40KMakrbAuw5QtN0/K9
	L8ujiMUaDFTirNv4M1EjKRQqeFYA/RzbUYJdvAlQlnC+Eqx2beo6h8XD7g==
X-Gm-Gg: ASbGnctImDu1ECCqoJXKHq+s3zyHNaVkN4hOKUIayvUwv56/jd01Fr/F5385fPD52lo
	VcBd4D/rRg05Edc+cZP7+FglY5UxmHLOz1ujeS2iiBBJ6veQthuWy0wWvme2yoRfTlGUXneX34X
	cc6O/BcXKQXLbXfoTo6dy90iRpiKcnpCdc9iO+AYgDqEp156+BzdrxDCXy0uz1kihSQPFhrcTCJ
	9ClttN5IQQTwijz1sZMi/fRqzvOlUwgSgxTNV+cKHdAmyJuBuOyqfJR/LZTKalgoaEfEBjNpO3Q
	hchL4OOiimdwx5Z6ODoinmp6rXacWSU8rw67Xk5k0Ye0MQjGKUVzTmxhqqoOwS9VproKpqCs
X-Google-Smtp-Source: AGHT+IFf8qTkqLzslw5AAJYe07A0WPtZfPy7OBecIhnxodORhky2XcAl1dWG383sETfCxcf8qvDogw==
X-Received: by 2002:a05:6512:108a:b0:545:2eca:863 with SMTP id 2adb3069b0e04-5452fe6fac3mr2902527e87.42.1739802279604;
        Mon, 17 Feb 2025 06:24:39 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462085207asm468884e87.51.2025.02.17.06.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:24:39 -0800 (PST)
Message-ID: <14779fcc-bd10-45a5-afc1-4a5510e29cf1@gmail.com>
Date: Mon, 17 Feb 2025 16:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@free-electrons.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
 <20250208164111.28ec9f2d@jic23-huawei>
 <ed0e43d8-9ab4-4614-9079-8a592ca8b185@gmail.com>
 <20250211190714.4db240d2@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250211190714.4db240d2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 21:07, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:52:51 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 

...

>>>> +int iio_adc_device_get_channels(struct device *dev, int *channels,
>>>> +				int max_channels)
>>>> +{
>>>> +	struct fwnode_handle *fwnode, *child;
>>>> +	int num_chan = 0, ret;
>>>> +
>>>> +	fwnode = dev_fwnode(dev);
>>>> +	if (!fwnode) {
>>>
>>> As before, I'd relax this until we need to do it. We may never do so.
>>
>> The BD79124 does not require this as I dropped the MFD, so this is
>> ultimately your call :) I, however, would like to humbly suggest adding
>> it now ;) I have changed some APIs in the regulator subsystem and in the
>> clk subsystem to support cases where the device-tree node is in the
>> parent (usual MFD device-case), and it has been somewhat scary... (What
>> if somewhere in some of the existing device-trees the parent happens to
>> have interesting properties - but it actually is not correct node? This
>> becomes a potential source of regression when adding support to an
>> existing API).
>>
>> Furthermore, when the node is unconditionally taken from the given
>> device-pointer, it is tempting for the caller to just pass the parent
>> device as argument...
>>
>>    - If you have done this - please raise your hand. /me raises.
>>    - If you have only later realized it can cause life-time issues when
>>      devm is used - please raise your hand. /me raises.
>>    - If you have tried to kick your own behind when fixing the issues -
>>      please, raise your hand. /me raises. (and if you succeeded - congraz,
>>      you aren't as old and clumsy as I am).
> 
> Maybe. I'd be happier if there was a single user included
> with a patch set doing this.  I'm not sure this applies to
> any of the SoC ADCs which are MFD hosted but maybe it does.
> 

I did a quick "grep powered audit" of the ADC drivers out of the 
curiosity. It seems to me that most of the platform drivers under ADC do 
have the of_match table populated. I suppose they have own node for the 
ADC stuff with ADC specific compatibles, so they're safe from this problem.

(I think we should still also consider cases where the ADC block does 
not have own compatible/node. This sure is just an opinion but I think 
it is kind of artificial to have own node for ADC block when it is just 
a part of a smallish device. Also, having multiple compatibles for one 
device feels "quirky" to me).

The exception to a rule seems to be the 'sun4i-gpadc-iio.c'

And, if I am not misreading the code, the thermal zone registration may 
be causing some problems. It seems to me the data of the thermal zone is 
allocated by the devm_iio_device_alloc() - and bound to the lifetime of 
the platform device.

The thermal zone in MFD branch is bound to the life time of the parent 
(MFD) device.

(in MFD case):
	info->sensor_device = pdev->dev.parent;
...

devm_thermal_of_zone_register(info->sensor_device, ...

I believe that releasing the IIO device will free the thermal zone data 
- but the thermal zone stays there until MFD is released. I haven't 
checked when the thermal zone uses the data though - but I'd be a bit 
wary of this design. Furthermore, removing and re-registering the IIO 
driver may cause some collision with the thermal zone which has stayed 
there. (Again, I didn't check the thermal zone implementation so I'm not 
sure this really is a problem).

In any case, it seems to me most of the current IIO ADC MFD devices have 
dt node "bound" to the platform device and don't use the parent node.

Yours,
   -- Matti


