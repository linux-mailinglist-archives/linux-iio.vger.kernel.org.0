Return-Path: <linux-iio+bounces-7434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A556992A176
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C291F22014
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02B7E0E9;
	Mon,  8 Jul 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sjTfCPP0"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC41CD15;
	Mon,  8 Jul 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439269; cv=none; b=U7nXgtH4kJ2soBEKM28mA4FAfVMsCIe+Q5nk8sWyGn9SwZnjVv7oMv1pmQPPt5SFj0Zuvquu2ki0BLkD2tNKxlMfkTtmkHUTOdXwZxu7AsiZUC4fWbHPf2moU/da2fy01PNcPbwwyMp1m4Gb3cDrT7fHUm8N5QiC30hQC0CQSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439269; c=relaxed/simple;
	bh=4ZnzU1vEYHnOHqWiB+3/e+5l73HWxSTbv1ScgMEFivk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soEuOZ2xJQZlxx9IbP/8MvpRZCRV1cMkmslkkS9mqBTi1CzaokLa0H7ROg9s/C8jAkMaFsP1PMr9TMAfsdtOJWDdYf/U8a4Ltv7yLqw0BWHk2tg7mqr+xNYn7S7nhljMKyn2sb/yFsCc+LaOjfSf62iXcXPuq4Zla+KFd3DIa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sjTfCPP0; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 103F48862E;
	Mon,  8 Jul 2024 13:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720439265;
	bh=EFmGyz3lelBPdoSOrsqSXvVCTJmdQXWKj40ri3YNSmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sjTfCPP0ub4B6h6FkQcJFmPUj3L6y43xWPnShIwEE9UMJ2BEfyJxps3XquZPVSGi1
	 myNcT6lGdWYGHZas2GZ/LoHmAp1VhyOMqXH0tPYL/nO6JmtOhqlKS0gFEUclwrqkRK
	 jclzXVurBRavR9fkPKb4QKWL+hOk6bxAIInhVWB8l4b8CQYM39xEl0FpMp9MYnZWSi
	 eCrHhRFrw+ICavdmvFRZ9AlUk1LdWa0vRHcSKP6rE2jPo3k01KmBwyhzLqMUkOvIfL
	 fFcayKZ/x0DDxjknmiaHC7/9sgk6ZPuvHIuTGpmtW5LMqreNo7alaEsKClNV9Jt36z
	 ULt3D/Km+logg==
Message-ID: <c6c53b0f-c65d-47c4-9ad0-672cbf4cabc1@denx.de>
Date: Mon, 8 Jul 2024 13:41:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: ltrf216a: Add LTR-308 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>, devicetree@vger.kernel.org
References: <20240705091222.86916-1-marex@denx.de>
 <20240705091222.86916-2-marex@denx.de> <20240707144922.1a9140da@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240707144922.1a9140da@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/7/24 3:49 PM, Jonathan Cameron wrote:
> On Fri,  5 Jul 2024 11:11:45 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
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
> One additional question inline...
> 
>> ---
>>   drivers/iio/light/ltrf216a.c | 49 ++++++++++++++++++++++++++++--------
>>   1 file changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> index 68dc48420a886..375312db4ef58 100644
>> --- a/drivers/iio/light/ltrf216a.c
>> +++ b/drivers/iio/light/ltrf216a.c
>> @@ -68,6 +68,13 @@ static const int ltrf216a_int_time_reg[][2] = {
>>   	{  25, 0x40 },
>> @@ -382,15 +394,19 @@ static bool ltrf216a_writable_reg(struct device *dev, unsigned int reg)
>>   
>>   static bool ltrf216a_volatile_reg(struct device *dev, unsigned int reg)
>>   {
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct ltrf216a_data *data = iio_priv(indio_dev);
>> +
>>   	switch (reg) {
>>   	case LTRF216A_MAIN_STATUS:
>> -	case LTRF216A_ALS_CLEAR_DATA_0:
>> -	case LTRF216A_ALS_CLEAR_DATA_1:
>> -	case LTRF216A_ALS_CLEAR_DATA_2:
>>   	case LTRF216A_ALS_DATA_0:
>>   	case LTRF216A_ALS_DATA_1:
>>   	case LTRF216A_ALS_DATA_2:
>>   		return true;
>> +	case LTRF216A_ALS_CLEAR_DATA_0:
>> +	case LTRF216A_ALS_CLEAR_DATA_1:
>> +	case LTRF216A_ALS_CLEAR_DATA_2:
> 
> Is there any point in this covering registers we have already stated above are
> not readable?  I guess we could argue that having this change is acting
> as a form of documentation.  Maybe just adding a comment that they
> don't exist would be clearer?

I'll add a comment, thanks.

