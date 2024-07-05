Return-Path: <linux-iio+bounces-7365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C488E928B4D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB251F2164B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DE14B940;
	Fri,  5 Jul 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EREmVSRp"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FF14AA0;
	Fri,  5 Jul 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192151; cv=none; b=keuatOkE87zqGwYBBuF0ElGK8LFAIG6kIvuzV7CsBXMy4Ub+55Uy8b+qq+ORQ8rW5ZD2e9+9qxYaamFVj+vP6BXoX21TcemjBmBIlS1mThW9t3lLRQmTZTbXC9uY1WeAWpgnq5DNqedw+9YUcdHIv5aHPtzkUx4DZo/WzkDH6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192151; c=relaxed/simple;
	bh=/P6ByaOds/j7kmt2Bjwz6sfg1aVVychv6LXelwiD/M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxYwiva8IH0pHqzvbi2/kOaq45LRLnkUD5TaUHsc4Yjfu9xcK9BjeqXkbo+1qAxwuFt4Jpk0eb+5gO8Nfgk7l6MU3hYLVGTXNvKeFZJWtDSEOPqImAfr0Rmli30nAt/HxkhDOQkOsy6MNFv2jxzd39AFZXYlSLqmjffQCoIajiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EREmVSRp; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 64C98882D6;
	Fri,  5 Jul 2024 17:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720192148;
	bh=jALVO3F6XaL3jTmJOTYpD+uupjSNfNsIznHlOfTwMlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EREmVSRpCyEgD9Oq2/7NM+8+uoL4XtnwKVF6afxXc4ctT3V/EWAHhLkqY4O6hUAqa
	 eZ0nkwO7ivwB289/60cvRIEI4LTNbyJQ37vpBl/nvVudsPtnea09cCZwnoeBCO3A9G
	 55oaV4oV4ZTHVgWopdOqYC0p04PWZOKRH7e4rKjrwb5G0PfnMQg7YtpoIMV2XSHfOW
	 dgx+M69HBOiUj8t+wuDqOAEjLOMhlv9XvU6DPEKQGAp0pcItmiaROZjVBz6STi0yMy
	 ylTSuE7ndK07BLZlxvv3qJ1/xKBcSi8R6Gfc44Qz/5BrttCLQL13e6FH+gYNUlfdYZ
	 Psr9+smKvIXvQ==
Message-ID: <13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
Date: Fri, 5 Jul 2024 16:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3b2ca0-6687ce00-3-4dab7280@52083650>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/5/24 12:42 PM, Shreeya Patel wrote:
> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> 
>> The "ltr,ltrf216a" compatible string is not documented in DT binding
>> document, remove it.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-iio@vger.kernel.org
>> ---
>>   drivers/iio/light/ltrf216a.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> index 68dc48420a886..78fc910fcb18c 100644
>> --- a/drivers/iio/light/ltrf216a.c
>> +++ b/drivers/iio/light/ltrf216a.c
>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>>   
>>   static const struct of_device_id ltrf216a_of_match[] = {
>>   	{ .compatible = "liteon,ltrf216a" },
>> -	{ .compatible = "ltr,ltrf216a" },
>>   	{}
> 
> This compatible string with a different vendor prefix was added for a specific reason.
> Please see the commit message of the following patch :-
> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/
> 
> We were very well aware that not documenting this was going to generate a warning so
> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood
> from his last message was that it wasn't necessary to fix the DT warning.

 From what I read in the aforementioned discussion thread, it seems Rob 
was very much opposed to this compatible string, so this shouldn't have 
gone in in the first place.

But it did ... so the question is, what now ?

