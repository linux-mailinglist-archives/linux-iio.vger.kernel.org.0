Return-Path: <linux-iio+bounces-13618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9A9F69DA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCD67A4F5C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FCB13DDD3;
	Wed, 18 Dec 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="COktTU/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E611B4233
	for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535069; cv=none; b=khR2/WJmFBfwsT1oZSFmB9XgKjMZdnTxFRov39V+lBPENqd0/5PiuzpkYV27yVwAmFMS9RMj899x47LgJ4D/1YRvaYRDNEJBO7l8APD/oLrEA2wprO5bS/wif7BTXmYUHqLwFUhopGOZ1uYl9KmFxqzsWPrgzv9t7bHF2GmAqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535069; c=relaxed/simple;
	bh=5NJ6pIot8+0pvM6LtkETerACOgIy0iHfKl37XP/iDvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJ4VY/QjcsEd8u6sAuIpuWDMq/9ANK0UGyBSpFDlVTZMhVuuRz0qIDG0lC6xd5KSdalcXXd3ApNArjJp8W29x5/oEf7RNUL0RisPPKj5GUL0HqsCGUemAc2+YsnjDnC6Bp8Yj9lrx70URgbYOERP1Sqx6gZN0WaUhXSVGsHUNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=COktTU/J; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f362c3950dso1341876eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734535065; x=1735139865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mueA8G+pAaD8m1QaOhjicnLM7XcQxaxCrEuNZaj5EQ=;
        b=COktTU/JfLw8byN3qx7pXiz5OJGwk3XDchTsbBtZ7u2d1Pmlgj8rto6TfIzEWJdsdh
         ZDP5Q1cWxv92mi1gEbqY2FvKh3WkR3kbEjzLbL3/kbzsr1aYP7R/wgYX9tOCWee/3zQq
         2tPUBYY49jZnlKCx8MNgoJZhVcMS5zrPLotrpvlj0Q3Z3OwQbdL7rKg1SCl3Baa6cbQj
         zGRfEjE7G7jZ7iN9bx6bTxR0sOMrjFwYZILdcxKME0+b+rhSAjZdyPwgGbrybLWvzsSV
         71pAUG+zaNxF7lv/YuIhVkScIt6C8X8Sx3HXtOJp/Xw4A4J+tyZJ5AFlUxev+rP7ZAHi
         N4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734535065; x=1735139865;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mueA8G+pAaD8m1QaOhjicnLM7XcQxaxCrEuNZaj5EQ=;
        b=JXa71W8pWqatMgXIz1BdM6c61ZKw627NWXdRc1IEPIbNA1XYsZH983UqP3DTWwt0n+
         bHJ43mj6zAnJCfnSjVLdyIGlHS5VVuk0iIaX/B9muiVyMA5y+qsImtlH+A1efcpXbUfj
         HA3SlagNYM1oicIF46iWFa8VpVoK1v3n5a3UP+aHlBGv6hgSggTyNLKAC9dWtJsiXDwp
         YBCw4FJ05qi1hY1auere9jnOGof0c3CDFHiXnZFYqJ+2os+/dFFgK2fVpRjgPA+O8WMw
         yuUEapbfOKCvIVwz2WhHMacSjrQfuLmiv4dqXz0QsiIlCeDz78yBbDcVCrm4Tu3Vq0Ct
         4NDg==
X-Forwarded-Encrypted: i=1; AJvYcCVfWNUOmTFCUOIGO3Q6WajaJ8CBvcR2nYmxlU+8JJ7cCKc5XjjCINWrI30AIGIi4J1Ct2jDiU4x6zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQUhQiNUWg/2soJLuMInd5OfOwSzl4WVgzGRgI3/WcA5lrZAP
	hjuclNCAnJJJJMh6+dIr7vSZE+7x8x9FxZSqYIcAgTkFJY7h62J2c0GK3nXBQ6A=
X-Gm-Gg: ASbGnctHbfHZ00yMY0kM2HTZFPgPxwyVkhO2OxFQiIuT97vsQL530KHsEM+FmfE5Fen
	Mo2C92O4YQfkzBJihkHQJetA/nSGsmKT/du5kIsUmZA8Fwm2hSIGpiS4e2QL0mhmgzRDDZKBEXS
	GdTyJpM531AMIzuDuYiAYOkK66tgwCKZ6s034hD4tpI27UGkCAmjvzmWAcEWfL4F1UawIS7EbbP
	ArN9nhiesMHa1/g2WfCKJ9oWDK6O6ioiBqM3ufk7Ou7Tv7OlfcreYgmH6OBe2RImdH0bPU2AyqC
	YXCqbAFnCGQFOWg9LQ==
X-Google-Smtp-Source: AGHT+IGbYgF8Hk3CR1cekwwZ+DKAnSD04hz9wQulZ9HxHSPWc19jn8x5Cw+Ea+nPDOhQLmzvjSRk+Q==
X-Received: by 2002:a05:6870:971e:b0:29e:70c7:a3eb with SMTP id 586e51a60fabf-2a7b3025f25mr1620526fac.7.1734535065551;
        Wed, 18 Dec 2024 07:17:45 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2541725sm3479964fac.12.2024.12.18.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 07:17:44 -0800 (PST)
Message-ID: <82e97712-3765-4d93-bdb5-f50fa7025e81@baylibre.com>
Date: Wed, 18 Dec 2024 09:17:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional
 optimization for simplicity
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzysztof.kozlowski@linaro.org,
 nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
 abhashkumarjha123@gmail.com, jstephan@baylibre.com, jackoalan@gmail.com,
 k.wrona@samsung.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241214191421.94172-1-vassilisamir@gmail.com>
 <20241214191421.94172-4-vassilisamir@gmail.com>
 <5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>
 <Z2IMQXJC-A0TjQK2@vamoirid-laptop>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z2IMQXJC-A0TjQK2@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 5:41 PM, Vasileios Amoiridis wrote:
> On Mon, Dec 16, 2024 at 03:57:44PM -0600, David Lechner wrote:
>> On 12/14/24 1:14 PM, Vasileios Amoiridis wrote:
>>> Drop conditional in favor of always calculating the timestamp value.
>>> This simplifies the code and allows to drop usage of internal private
>>> variable "scan_timestamp" of the struct iio_dev.
>>>
>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>> ---
>>>  drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
>>> index caa404edd9d0..6b86b5315694 100644
>>> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
>>> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
>>> @@ -8,6 +8,8 @@
>>>  #include <linux/iio/kfifo_buf.h>
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/unaligned.h>
>>> +#include <linux/units.h>
>>>  #include "ssp_iio_sensor.h"
>>>  
>>>  /**
>>> @@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
>>>  int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>>>  			    unsigned int len, int64_t timestamp)
>>>  {
>>> -	__le32 time;
>>>  	int64_t calculated_time = 0;
>>>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
>>>  
>>> @@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>>>  	 */
>>>  	memcpy(spd->buffer, buf, len);
>>>  
>>> -	if (indio_dev->scan_timestamp) {
>>> -		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
>>> -		calculated_time =
>>> -			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
>>> -	}
>>> +	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;
>>
>> Don't we still need to cast to 64 bit to avoid multiplication overflow?
>>
> 
> Hi David,
> 
> Thanks for your message!
> 
> Aren't we already covered by the fact that MEGA is defined as an
> unsigned long?

That is only 64-bits on 64-bit architectures, so could still overflow on
32-bit architectures where long is 32-bit.

> 
> 	include/linux/units.h:12:#define MEGA 1000000UL
> 
> Cheers,
> Vasilis
> 
>>>  
>>>  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
>>>  						  calculated_time);
>>


