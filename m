Return-Path: <linux-iio+bounces-7338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C32C92857A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA11AB21317
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB16146A9B;
	Fri,  5 Jul 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="i9uMLzmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8D1442F0;
	Fri,  5 Jul 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173101; cv=none; b=sF4CtJLQHEkBdlpbBZG+5jbOVkGVpi1CTwySxqnWQSh31W6nr10Rq5o0Mg6oWf5OdHy7ju/em9KQOVfOZGIvAlu1UmDYu/k0dne09VtlcmK/wq1ThBNXT8wl8PLqdjfsQROy1tF2YIJWewV/XnwauXjlScEJ13iWmp+LY+ONhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173101; c=relaxed/simple;
	bh=MhSl17FdDfS22i6BDX5td6/4FkYAMudFAm0dQ4K3ku0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQcyMVR4ioAACUJUbTsx5Crp7zrLULLfWlMdh1cKGh0xJtZ9joo85v61o0NYtRMoxFnpZicjyj6nSYMHL0BXz033kPIMtCWRTqEvwCFH9uBN4S9nIOoN8mxbawJzJYI4v+krvErRV4XFY+Gy/imSPLGwOAh//Y9kqX/XsHM7sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=i9uMLzmi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E75CC882F0;
	Fri,  5 Jul 2024 11:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720173097;
	bh=Y0eTuYMQuFzr9aIwGO2uXrIWg1+otGLpDkYbEL3M0Ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i9uMLzmiKO5sPFWdy8LGZvwrCZ0Ti+CLWkQXPkCPg439hQ5575ZZ1MEtK+tgpNcTi
	 +m1P5lFffXtXMWO5OllgBlK2BVejnvW7gnaz4Qa1SVy+TRKTeW6967ey4q9ow7O4v4
	 OQKxKW42gUHyLQyI6FLMZv+SLAcmpJcD56/dfab+dr3ruTo4VXtLdqKRXyI9j/xEcO
	 yUkAIQb4umSFq9BFoKdStlVumoLzGkfSaXWoYdi3QzsvJOJaxxFYYfaxnC/DNCJuRp
	 ae5pSCQ5d5+w8tELskB8RbaZ4z7yzVrDo4UoJsmjXb0fG0SD29srm3e/aeUKO9OiBR
	 McJMsaSCwWZaw==
Message-ID: <5785cd09-aed7-4697-87bc-4bf97b75580c@denx.de>
Date: Fri, 5 Jul 2024 11:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: ltrf216a: Add LTR-308 support
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, devicetree@vger.kernel.org
References: <20240705091222.86916-1-marex@denx.de>
 <20240705091222.86916-2-marex@denx.de>
 <b794ed7c-d3b2-4fcd-94fb-de499de89804@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b794ed7c-d3b2-4fcd-94fb-de499de89804@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/5/24 11:40 AM, Krzysztof Kozlowski wrote:
> On 05/07/2024 11:11, Marek Vasut wrote:
>> Add LiteOn LTR-308 support into LTR-F216A kernel driver.
>>
>> The two devices seem to have almost identical register map, except that
>> the LTR-308 does not have three CLEAR_DATA registers, which are unused
>> by this driver. Furthermore, LTR-308 and LTR-F216A use different lux
>> calculation constants, 0.6 and 0.45 respectively. Both differences are
>> handled using chip info data.
>>
>> https://optoelectronics.liteon.com/upload/download/DS86-2016-0027/LTR-308ALS_Final_%20DS_V1%201.pdf
>> https://optoelectronics.liteon.com/upload/download/DS86-2019-0016/LTR-F216A_Final_DS_V1.4.PDF
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
> 
> ...
> 
>>   	mutex_init(&data->lock);
>>   
>> @@ -520,15 +537,27 @@ static int ltrf216a_runtime_resume(struct device *dev)
>>   static DEFINE_RUNTIME_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
>>   				 ltrf216a_runtime_resume, NULL);
>>   
>> +struct ltr_chip_info ltr308_chip_info = {
> 
> static const
> 
>> +	.has_clear_data		= false,
>> +	.lux_multiplier		= 60,
>> +};
>> +
>> +struct ltr_chip_info ltrf216a_chip_info = {
> 
> static const

Both fixed, thanks.

>> +	.has_clear_data		= true,
>> +	.lux_multiplier		= 45,
>> +};
>> +
>>   static const struct i2c_device_id ltrf216a_id[] = {
>> -	{ "ltrf216a" },
>> +	{ "ltr308", .driver_data = (kernel_ulong_t)&ltr308_chip_info },
>> +	{ "ltrf216a", .driver_data = (kernel_ulong_t)&ltrf216a_chip_info },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>>   
>>   static const struct of_device_id ltrf216a_of_match[] = {
>> -	{ .compatible = "liteon,ltrf216a" },
>> -	{ .compatible = "ltr,ltrf216a" },
>> +	{ .compatible = "liteon,ltr308", .data = &ltr308_chip_info },
>> +	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
>> +	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },
> 
> Drop this one. You cannot have undocumented compatibles - and checkpatch
> tells you this - and we do not want to accept stuff just because someone
> made something somewhere (e.g. ACPI, out of tree junk etc). There was
> similar effort in the past and we made it clear.

The "ltr,ltrf216a" was already part of the driver, wouldn't removing it 
be an ABI break ? I will add a separate patch to remove it, so it can be 
reverted if someone complains. Thanks .

