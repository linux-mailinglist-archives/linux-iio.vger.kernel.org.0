Return-Path: <linux-iio+bounces-17566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD87A79B36
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42443B66A1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FE19C574;
	Thu,  3 Apr 2025 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck7jLQ9x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C45339D;
	Thu,  3 Apr 2025 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657538; cv=none; b=DCocnTyO9JjU/I9I3bXRP5j6V0z2wlVCPSV5bhcNlAQbzOC100r93xkT2jgYx4l0p4FiARMShcyAjbmKNdspuKFX1w4Ern4bj2dq3z8tzw/d2nvDonAs2tLJ3ibpgsgag67YH0obAcGuSdwmsmlNwldvWMvgB7jqpbLsUkVIogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657538; c=relaxed/simple;
	bh=SbruppALhz0jiFblb2Kdub02TWtG8ZzvjkPIvhFGY1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzo9FO5DlKPCUs/ricjlN06k/Yi034E44FPSGY5pQof5j0C4QNVGzktmiUK0s1e5Dc8Njmu/Emq5X93SF7Eh2kt+Iem4YhYNwQrcVkI/AfjzHah3hMKXzvPsGnPo+nPc9dyhhG4HT1kHUy7VzWaP9YCnLdMNza8SjSKz1VbD/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck7jLQ9x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54af20849bbso577911e87.0;
        Wed, 02 Apr 2025 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743657535; x=1744262335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+vyPAE39gromhmoTHVrC91GtciRJneVkgJKPcyS5xU=;
        b=ck7jLQ9xDd7Sz7PO0loX2dnQYqkGsbxxqxSg5tb1zrlObzE8tVo59LDybxtUIJSHeN
         UKnVju4lSWIflD8iqDrdSM6fbPj4P5nAQSExA+eI5opmgfFGUdcyVoT+sLn4NwAG4ecT
         JHvMGWyit4JBMZulbkVCc7f7l/t3vIrHzzSS3y0zEKBuAjisUV3v4QDIGR0KjcNUmer0
         JlyWj8Fb9dEyC0iwmI3LgYOqIqHGJ8mjk9QYBMV0kGRFEdG1OQWgVCI5//ctFVyW4ytU
         EBP3qHrTkJMgJVILRqi/G1zVNgqn38WQFMA/U3x9DtluVTcBKSoXz/PZgCJU9QS0Nd1F
         m1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743657535; x=1744262335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+vyPAE39gromhmoTHVrC91GtciRJneVkgJKPcyS5xU=;
        b=UKs2kvqgGb0By3xmBM61c2PagWWGoW28KMDhfDZb7lXJMV9AguUsGuIxfY4Y4v8l/7
         O8uVY8Yxoe2b1EC66KrvsmST4Daq6SWZesLNz9J5SFbcXj0KzmgTy2AkEmhdf3BN56za
         18d3TQKaomRLgmxkLJ1WDLtg/UkC03L8+/q8M+nMRaEc85bp9dyzS/0h4gOue+VqdX9q
         xAjp/SGtqz2jg+yRFXMgfFwsCTlhPhSj0dR929cG3CxHEnGBLj+IcPkrz3aefTWPyfx6
         UWX+s58ri5uSluXMKOEKhEqNAZ+l1nvxoRhcLnyIZJ0/IBGLIRkwdt+qFAN6o7vh1faF
         QDKw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nwLImf0NSfL2RIV4ToTRVbp7sflvJ2vrp5ylPN9jkgQXV5WlkpTdn9r7AqZzow9ZzFad5IECiNED@vger.kernel.org, AJvYcCX0mdhxe0Pn7rPxnOBbCnka8UI4xkzjCXNAJMFK7SDNsiB84KtctRfUrfYTeLqc1wETEG57QURhiAUOS0XW@vger.kernel.org, AJvYcCXjZc+4nFNinWrY3G1TX77AkiWXaJSsqJ6K5QEFFxQESQ5eg0siOQOZDcxO52n+55p+nmjgQfA3p0kx@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfmeOET3GRA2Ypqi/N5+zmR6udEILpmioYTKMtF9yBmFUnwVP
	IqeXv2dGbNQhxaS3RnbE0kFyRxc6D01ZYg1TZfOJPIK0ponM1ALXU5dzVg==
X-Gm-Gg: ASbGncuUTXo+UDl7ib4IR2FEFTcnKDuhRaiB7xkFLiz+vKETmZDp4yCiAhuca6GDT8g
	68LcdGE8630hfbKqY4ZwbfBrCelcoYb4nfIb/ewVpgh/euarF1xdAR/ESsTJ2k8ph5kFrk1rJHz
	obPZSeD/S/e6qiqAVf0xjzfX0rsCFPUesa0NwHLPMXAGhx3j+apdJS/8JBp0/RmKWX8KJn2vOBi
	7pXriYBMLNWBATvlPH5eXzkDndjFZ/CnJ64yztU6wSQdgh3P9hvDed6YSYX8b9IuM7mPxpR5eMn
	VoUdEhe+kVDiRdS4Z0JJs/Zbmkkg0koUBIIRkMoY4CYGKXS/vFbvJ5dGRFZ+C6HYwdhl6j37sps
	MBUsshjFtmF76pijijpamKHuIPQ==
X-Google-Smtp-Source: AGHT+IFLK1ciS0hj0hBGAjCkmO7GMuKiPVBSBmt6+VYOv0vIsu7oz37xfqO/3ciKv6sdUsEAC3KwJA==
X-Received: by 2002:a05:6512:693:b0:545:5a5:b69f with SMTP id 2adb3069b0e04-54c1d89952dmr347234e87.9.1743657534833;
        Wed, 02 Apr 2025 22:18:54 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e635b3fsm52203e87.149.2025.04.02.22.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 22:18:54 -0700 (PDT)
Message-ID: <078ee3c4-bb55-479b-85ff-3cab5f9a9eff@gmail.com>
Date: Thu, 3 Apr 2025 08:18:52 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 7/7] iio: ti-adc128s052: Drop variable vref
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
 <dda9e0710a9293a9f52e64c092f79afd4b719536.1743573284.git.mazziesaccount@gmail.com>
 <c42b1dc3-34d9-4419-ae2e-5bacffa070b6@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <c42b1dc3-34d9-4419-ae2e-5bacffa070b6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2025 23:49, David Lechner wrote:
> On 4/2/25 1:10 AM, Matti Vaittinen wrote:
>> According to Jonathan, variable reference voltages are very rare. It is
>> unlikely it is needed, and supporting it makes the code a bit more
>> complex.
> 
> There is also around 60 other drivers where we could do something like this
> in case anyone is bored. :-p
> 
>>
>> Simplify the driver and drop the variable vref support.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision History:
>>   v2:
>>    - New patch
>> ---
>>   drivers/iio/adc/ti-adc128s052.c | 29 ++++++-----------------------
>>   1 file changed, 6 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index 0f93c6266527..0bfe4e558c69 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -29,13 +29,12 @@ struct adc128_configuration {
>>   struct adc128 {
>>   	struct spi_device *spi;
>>   
>> -	struct regulator *reg;
>>   	/*
>>   	 * Serialize the SPI 'write-channel + read data' accesses and protect
>>   	 * the shared buffer.
>>   	 */
>>   	struct mutex lock;
>> -
>> +	int vref;
> 
> Units in the name are helpful: vref_uv.
> 
> Could also consider doing division in probe and storing vref_mv instead
> since we never use the microvolts part.

Ah, thanks for the suggestions. I agree with both.

> 
>>   	union {
>>   		__be16 rx_buffer;
>>   		u8 tx_buffer[2];
> 

Yours,
	-- Matti


