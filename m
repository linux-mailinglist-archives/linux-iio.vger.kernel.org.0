Return-Path: <linux-iio+bounces-9598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DEB9795C6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2024 10:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D881F22521
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2024 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EB19884C;
	Sun, 15 Sep 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE8kHD5/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4E3D551;
	Sun, 15 Sep 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726389077; cv=none; b=JkxpASaPyhLhg4wQRY7eQEHUcjpmc4kIz4n0aVc3AUNGJoap2Z6f0JwmGr/wJ5l6sybc0Pkf+uS7lL6mYS8Fy/s29F4A1YxtwByEPsnoOuU4mkfrrdR+t+dRe7pHA4HpsviuHjBltQFM99KmNQYaC9qVrREOKxOD6NLmClN+hRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726389077; c=relaxed/simple;
	bh=Ig1FkFcRZSJZYcQ6hxBNwKQh2ZnsvOEtNNR7FzfafWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmCLEfgx/PIdGRey1Zv07eqJ+CCR/xaDY9A0kgvZNSYdHuHthR7QfzmjeZLzMjM8SxZAn9+INvQECgJnIi3SjhqkDubV68fvq3FpwZus61JYYVu8oXsj+zORiFJUbI6xW657jrlKZSK9XC0BJfHbnaMKoEu187tOLTYgFPhyPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE8kHD5/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8ce5db8668so589179666b.1;
        Sun, 15 Sep 2024 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726389074; x=1726993874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IozNnz9tpUO80GrsvBdDl8DQ07b0U3NFAs75ot5NvHA=;
        b=mE8kHD5/qyE46B/DGEi8Xy/+7TM8EiJTyZAfEetfQp6KzTdLb9ao8te/62gxNnlOXl
         qd0pDcGIynKojXUsvGIquQfUjqObt29OmZPhleLY6lAtqgl8TvcFpzbY/AwhZhR1Q0Xd
         wM1d290W4mp9cLupU3QSLCLVxRZvje50YYpYbqppzjrqS27KQwtblyxsouF3BSkOgjPw
         IDDNbaaIqoIwowtJMHTzdmSbmp9RIPNSKIdfWdP4emP90Gkbv26I7OOzLFkKzCiTwzBb
         6NZikxtWZ3q66Va2JW4hbq7H4Ua8bzwbdfTIs1bjqWAPwyH1goIp75pNuGFpBWl2Sy/C
         pxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726389074; x=1726993874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IozNnz9tpUO80GrsvBdDl8DQ07b0U3NFAs75ot5NvHA=;
        b=VN/OO2P0xueRsLPD6Mu5O3Cy4WYYp8rxmrcZJYCX7nettkGxSlilRs+rvFnwa6UiI2
         AJiv0s4QUuFuCf5SlR7otJfnn8l1DvxxOIq+tmiFEjYKWV5tk51kMN9NEZYqi+df6jMC
         mrHQiRhuOr96TjTY5c4+wazOw1PzmhlPLUWnEX6ZkcxM5oOMXgpmSbnQoKxcspwENvtP
         1IYfe/PmX4mYuRsZPFsNZXn7wXasxs7mf6QBe1onTgUV65TDgXkN7jSJLGTPtD+Ezygy
         Iyoa+TFzKTTy9h5x4j6197hjY3DFa91XwsVE+7KLbJx430/X0y8yaw5Pt0/6NZjgU6ag
         5pPg==
X-Forwarded-Encrypted: i=1; AJvYcCUPfivvz3Nk39Q8rnmWlVILNxDifh8TtKsDiGZyhw1ATSBaSHwTi4E8Fp8+qdXUHRdG0+R57gIJ1dIt@vger.kernel.org, AJvYcCVK8j8qOV9H3fs4tVBCWssX0n99yPywDm1uG39u0ycnrZk91Q/yZJm3GUuQFywQQpR63wL35D5yAne2U+aV@vger.kernel.org, AJvYcCXAOBmRqr3Cl+MdRMs5hvhnFY/ZlWRqV9kVcfSxLzA4Y5pqJBOyoDagTxCSzQTZ8XnqRf8fiMNgTOVk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz911QsrYEi4X0GN119e/WvBTQF8xRIM2GBZVYnRAkYVUHWvqpo
	yMZqlnhJBp7Tzeaw/w1f1rvENUMl4YbqPokkfY46g+R0uLrDcwrupV3V+g==
X-Google-Smtp-Source: AGHT+IELc630NWg4QW94es9Z90TBuWreYukrYfytcd2kPVGaBtQoeWpEgY5v6+Y0K/lfZHBmYwp9Tg==
X-Received: by 2002:a17:907:9446:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a90293c4fe5mr1293596266b.9.1726389073723;
        Sun, 15 Sep 2024 01:31:13 -0700 (PDT)
Received: from [192.168.0.106] (178.115.72.241.wireless.dyn.drei.com. [178.115.72.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061116388sm170985166b.92.2024.09.15.01.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 01:31:13 -0700 (PDT)
Message-ID: <5199bc7c-c3fe-49e8-9122-78b476c4aa90@gmail.com>
Date: Sun, 15 Sep 2024 10:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] iio: light: veml6030: update sensor resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
 <20240913-veml6035-v1-5-0b09c0c90418@gmail.com>
 <20240914155716.09496630@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240914155716.09496630@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/09/2024 16:57, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 15:19:00 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The driver still uses the sensor resolution provided in the datasheet
>> until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
>> 28-Nov-2023. The original ambient light resolution has been updated from
>> 0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
>> the current device datasheet.
>>
>> Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
>> original 4608 mlux/cnt to the current value from the "Resolution and
>> maximum detection range" table (Application Note 84367, page 5), 5376
>> mlux/cnt.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Interesting.  So does the datasheet say this was fixing an error, or
> is there any chance there are different versions of the chip out there?
> 
> Also, should we treat this as a fix?  I think we probably should given
> we don't really want stable kernels to have wrong data being reported.
> If so, please reply with a fixes tag.
> 
> Jonathan
>

According to the Product Information Notification (link in the cover
letter):

"Reason for Change: Adjusted resolution as this was wrongly stated in
the current datasheet."

"If resolution is defined in the particular application by the customer,
no changes in the system should be made. In the case resolution was
taken from the datasheet or app note, this has to be adjusted accordingly."

Which means that stable kernels are using the wrong resolution. I don't
know what IIO usually does in such cases, because a fix could
potentially make existing applications return "wrong data". If that is
alright, and applications are meant to be adjusted after the kernel
update, I have no problems to make this patch as a fix and add the
stable tag.

Best regards,
Javier Carrasco

>> ---
>>  drivers/iio/light/veml6030.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
>> index 5d4c2e35b987..d5add040d0b3 100644
>> --- a/drivers/iio/light/veml6030.c
>> +++ b/drivers/iio/light/veml6030.c
>> @@ -779,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
>>  
>>  	/* Cache currently active measurement parameters */
>>  	data->cur_gain = 3;
>> -	data->cur_resolution = 4608;
>> +	data->cur_resolution = 5376;
>>  	data->cur_integration_time = 3;
>>  
>>  	return ret;
>>
> 


