Return-Path: <linux-iio+bounces-9551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F597911E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E81C21A1D
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906A1CFEBD;
	Sat, 14 Sep 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaNXHwwV"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835381CEEAB
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321569; cv=none; b=Hy2yElaN4CWEMHFTDv3DRLP3FzDcs/7pT7lH1Ga+HFPPMOLJC57pnaPR1jUGqjKIJrbKAmBYF7bPvY2Q/hWiN5ogDpGge6D1v0Out8ncX9eqAinbAPWm25Az2vXBUzeqNpEGpYjMqEjKLHfgxPQQh+8gAw8IxAlzdS102TgSKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321569; c=relaxed/simple;
	bh=7LIgMNt/HYMs9JMX58x8rEKmnOParwufdKZfl4X/AQk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WetbhlpPi89b+iYbG6OJ7Bdebrf72dyb+mWeuFV5JpmK3AqeIR2W/3LNCvtSaKf33SxFvSeCY5GFTw4t7v1Skp8kD45jneMs97cDDcJQ4kxxD0rp/xZHrVVlN6qjz+MjYizQyggqetsaKZL9NoOZ+baIpJYp3Mhz01m0bxKtjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaNXHwwV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726321566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcbH6xKjPio0d3vBUKsMg5DSPgp+NCqhlSRBuQiAMdA=;
	b=IaNXHwwVutC4b8f6J3EKaAU+MKcX1ChHsQLnv90r1gpMv3x16sbhHJr/n6CUzZOB5b1kZ6
	qahVLtYjvJZaNCTiuaMzXgnB7xRcQBN5lT/HjAsWYIcV6KlOUPoYzFs0r0DMfzpHaGdt1E
	uWxIewAxb0u0V3PHUqACd5i9b7UadHk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-jCFvoHNHPAyLmZTm2W3flA-1; Sat, 14 Sep 2024 09:46:05 -0400
X-MC-Unique: jCFvoHNHPAyLmZTm2W3flA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c269f277eeso2098102a12.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 06:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321560; x=1726926360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcbH6xKjPio0d3vBUKsMg5DSPgp+NCqhlSRBuQiAMdA=;
        b=eJYw/IX95wRC6REZdhXQpJt0k+F1w+AZPLFg2L4vuoHOh9lSS2Ls4EEK2YzO2Lji9R
         4aY8FjnQJhpC4zz4RizLZNKVlV8Lmzxn88kFMjQuFBCvYLkcwfgFf75GyEcyUwXV4JlX
         gGshVra0asGjol6l/Fq6a4rajOMGVZ8Q0M294lSojHfLpU3SZXW1oaq7yk2kbtfESr95
         mDzogxtBhV08jaDn0Al6lKR0LK4lzJncgZae8m8iAx6qU8/Njjp9hMQyDq4m2aLddfcy
         pVIGDAQrjW2XLEYwlWxJZtD3E5PyVDjDWqLKVWqCUx2ukgaZpL9YWt/MY5bJlY/TIvsz
         2qDw==
X-Forwarded-Encrypted: i=1; AJvYcCXU+ZnffUZvKk4nzX6arld0FyChTBlMNjo+nYD5KuVAwDAzsVSt3FJNEu/VQEvSu4xOszFSl5RegII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvpqgOIC7r2lrZiecCvZC/NjoonkFzkzQxjrGgTT7NYa6NU4/
	8zkINFpsKtst0/3i/CbBXdBK5TBKDwd731wUkueatiTFmTAeq80/wCBSB2UZlSp5rjjGjE37D+P
	e+0A9bFslwRtZG6LynCS02UB0eC5mnfK1EioU/1TsFIwM5SibNcQbF1WFcQ==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8706911a12.0.1726321560605;
        Sat, 14 Sep 2024 06:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgr+Inr50L4KRA7VVQODXZub0jVSMHk2Ur9cSfsqmJ1S2LbHYM3ln4qatBW8FyycvFp6pErw==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8706886a12.0.1726321559975;
        Sat, 14 Sep 2024 06:45:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e97sm679519a12.65.2024.09.14.06.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 06:45:59 -0700 (PDT)
Message-ID: <9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com>
Date: Sat, 14 Sep 2024 15:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
 <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 9/12/24 3:51 PM, Hans de Goede wrote:
> Hi,
> 
> On 9/11/24 11:22 PM, Andy Shevchenko wrote:
>> The commit in question does not proove that ACPI ID exists.
>> Quite likely it was a cargo cult addition while doint that
>> for DT-based enumeration.  Drop most likely fake ACPI ID.
>>
>> Googling for LTERxxxx gives no useful results in regard to DSDT.
>> Moreover, there is no "LTER" official vendor ID in the registry.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On 9/13/24 11:31 AM, Andy Shevchenko wrote:
> Have you grepped over your collection of real DSDTs?

Yes I did, but I just double-checked looking for only LTER and there
are several DSDTs using LTER0303 for an ambient light sensor.

duckduckgo-ing for LTER0303 finds:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303

which is actually quite an interesting URL to search for ACPI
HID-s used in any Windows drivers.

Checking for LTER0301:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301

Shows that that HID is also actually used, so:

> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Correction, at least the LTER0301 ACPI id seems to actually be real:

https://www.catalog.update.microsoft.com/Search.aspx?q=lter0301

So NACK for dropping all 3 HIDs.

It seems to me that the LTER05xx HIDs can be dropped and
a LTER0303 HID should be added instead of dropping all HIDs.

Note I do not have any hw with a ltr303 light sensor, so
I cannot test this.

Regards,

Hans




>> ---
>>  drivers/iio/light/ltr501.c | 23 -----------------------
>>  1 file changed, 23 deletions(-)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 8c516ede9116..0e0420573286 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -15,7 +15,6 @@
>>  #include <linux/err.h>
>>  #include <linux/delay.h>
>>  #include <linux/regmap.h>
>> -#include <linux/acpi.h>
>>  #include <linux/regulator/consumer.h>
>>  
>>  #include <linux/iio/iio.h>
>> @@ -1422,17 +1421,6 @@ static int ltr501_powerdown(struct ltr501_data *data)
>>  				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
>>  }
>>  
>> -static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
>> -{
>> -	const struct acpi_device_id *id;
>> -
>> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> -	if (!id)
>> -		return NULL;
>> -	*chip_idx = id->driver_data;
>> -	return dev_name(dev);
>> -}
>> -
>>  static int ltr501_probe(struct i2c_client *client)
>>  {
>>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>> @@ -1523,8 +1511,6 @@ static int ltr501_probe(struct i2c_client *client)
>>  	if (id) {
>>  		name = id->name;
>>  		chip_idx = id->driver_data;
>> -	} else  if (ACPI_HANDLE(&client->dev)) {
>> -		name = ltr501_match_acpi_device(&client->dev, &chip_idx);
>>  	} else {
>>  		return -ENODEV;
>>  	}
>> @@ -1609,14 +1595,6 @@ static int ltr501_resume(struct device *dev)
>>  
>>  static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>>  
>> -static const struct acpi_device_id ltr_acpi_match[] = {
>> -	{ "LTER0501", ltr501 },
>> -	{ "LTER0559", ltr559 },
>> -	{ "LTER0301", ltr301 },
>> -	{ },
>> -};
>> -MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
>> -
>>  static const struct i2c_device_id ltr501_id[] = {
>>  	{ "ltr501", ltr501 },
>>  	{ "ltr559", ltr559 },
>> @@ -1640,7 +1618,6 @@ static struct i2c_driver ltr501_driver = {
>>  		.name   = LTR501_DRV_NAME,
>>  		.of_match_table = ltr501_of_match,
>>  		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
>> -		.acpi_match_table = ltr_acpi_match,
>>  	},
>>  	.probe = ltr501_probe,
>>  	.remove	= ltr501_remove,
> 


