Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8771CEF12
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgELI02 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 04:26:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728891AbgELI01 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 04:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589271985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8nO5fHZLrM6PQkaLb7BJDAZwymlyJdLzlZKx/2lNbQ=;
        b=GiGu1QjtVT1dv7MFf6PyHsQJ+YsJX/wY4Y7AIfXdFCZx9Y6qguJnqdRBwzUrU4e8K9P6rB
        XeWtYy+Y6KB8qqHicf39lTOfK++9wAOODQg8Kq/EdHa0jmWUfeERURhEFFfEvbaqHUy/Dj
        ffWGaXRHNV68L7k3ddZoZ3cCIbbzLXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-VEzcLOCiN6W4LXeceB4Kjg-1; Tue, 12 May 2020 04:26:22 -0400
X-MC-Unique: VEzcLOCiN6W4LXeceB4Kjg-1
Received: by mail-wm1-f71.google.com with SMTP id l21so9634946wmh.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2020 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8nO5fHZLrM6PQkaLb7BJDAZwymlyJdLzlZKx/2lNbQ=;
        b=EAhCIF5s9mXiczjLA86BpCu7fFEsUu6nesQlm1oBmS0K9nHcXPdygNcgV46OMc+Ju5
         ZwRTCrN3N2w3oBZnP7Y9S0FOYg9sGmC7/lLmP9GkNP7+Xjcc1BV9G/DF+C4UiNSXMkUR
         epAA19So38iGtVzCUeLbQED8XQCMMKs4R0ir88GGmcjfWT7myfrXt6Z4bERt2VhcGaPN
         jmjMb3Xvc2uFjv9v4f7I1FzPwE09d6zEp2whrMFbzuoJF/PfaMZBezo/kUxBXBY4OZHi
         ZdQTLSr+7SR/fA2Kc4NFK7u+hfMNBWZISvyqBaXvucmUaxR3hUHoVFMsGGc3JvX2pTdW
         WU6A==
X-Gm-Message-State: AGi0PuavQ+aDQliKvclAnDWjnFkrunkarPwGnhb+vIlgfdC2OospM7VW
        jbaY4Hw+e5PI+aLlsuMib+OTc2UQ65Gh4c2wpIFmEufDsDihmRphJJAklyAmAy2yFDg3kVKiI30
        6j9naal1dUiIThcUUNA1n
X-Received: by 2002:adf:e951:: with SMTP id m17mr17948594wrn.352.1589271981663;
        Tue, 12 May 2020 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJaP1MQDVNSlNDB+rfcXseLw/jvYwxAe7dLaeN9+oNEFlGNo3DJhrTWQZYK/JV1Zy235MDWlw==
X-Received: by 2002:adf:e951:: with SMTP id m17mr17948573wrn.352.1589271981411;
        Tue, 12 May 2020 01:26:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m7sm7453572wmc.40.2020.05.12.01.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 01:26:20 -0700 (PDT)
Subject: Re: [PATCH v4 10/11] iio: light: cm32181: Add support for parsing
 CPM0 and CPM1 ACPI tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
 <20200504125551.434647-10-hdegoede@redhat.com>
 <20200511202023.45f2d130@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7dc53183-d3e8-3437-5ac2-a5b74dea643e@redhat.com>
Date:   Tue, 12 May 2020 10:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200511202023.45f2d130@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/11/20 9:20 PM, Jonathan Cameron wrote:
> On Mon,  4 May 2020 14:55:50 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> On ACPI based systems the CPLM3218 ACPI device node describing the
>> CM3218[1] sensor typically will have some extra tables with register
>> init values for initializing the sensor and calibration info.
>>
>> This is based on a newer version of cm32181.c, with a copyright of:
>>
>>   * Copyright (C) 2014 Capella Microsystems Inc.
>>   * Author: Kevin Tsai <ktsai@capellamicro.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms of the GNU General Public License version 2, as published
>>   * by the Free Software Foundation.
>>
>> Which is floating around on the net in various places, but the changes
>> from this newer version never made it upstream.
>>
>> This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
>> Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tiny thing 0-day picked up that I've just fixed and pushed out.
> 
>> ---
>> Changes in v2:
>> - Factor out the parsing into a separate helper function
>> ---
>>   drivers/iio/light/cm32181.c | 101 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index a0812e3cba9b..5eeefa3ee4f1 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -4,6 +4,7 @@
>>    * Author: Kevin Tsai <ktsai@capellamicro.com>
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/i2c.h>
>> @@ -53,6 +54,15 @@
>>   
>>   #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
>>   
>> +/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
>> +#define CPM0_REGS_BITMAP		2
>> +#define CPM0_HEADER_SIZE		3
>> +
>> +/* CPM1 Index 0: lux_per_bit, 1: calibscale, 2: resolution (100000) */
>> +#define CPM1_LUX_PER_BIT		0
>> +#define CPM1_CALIBSCALE			1
>> +#define CPM1_SIZE			3
>> +
>>   struct cm32181_chip_info {
>>   	const char *name;
>>   	const int *als_it_bits;
>> @@ -61,6 +71,7 @@ struct cm32181_chip_info {
>>   };
>>   
>>   struct cm32181_chip {
>> +	struct device *dev;
>>   	struct i2c_client *client;
>>   	const struct cm32181_chip_info *info;
>>   	struct mutex lock;
>> @@ -95,6 +106,92 @@ const struct cm32181_chip_info cm32181_chip_info = {
>>   	.num_als_it = ARRAY_SIZE(cm32181_als_it_bits),
>>   };
>>   
>> +static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
>> +
>> +#ifdef CONFIG_ACPI
>> +/**
>> + * cm32181_acpi_get_cpm() - Get CPM object from ACPI
>> + * @client	pointer of struct i2c_client.
>> + * @obj_name	pointer of ACPI object name.
>> + * @count	maximum size of return array.
>> + * @vals	pointer of array for return elements.
>> + *
>> + * Convert ACPI CPM table to array.
>> + *
>> + * Return: -ENODEV for fail.  Otherwise is number of elements.
>> + */
>> +static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>> +				u64 *values, int count)
>> +{
>> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	union acpi_object *cpm, *elem;
>> +	acpi_handle handle;
>> +	acpi_status status;
>> +	int i;
>> +
>> +	handle = ACPI_HANDLE(dev);
>> +	if (!handle)
>> +		return -ENODEV;
>> +
>> +	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(dev, "object %s not found\n", obj_name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpm = buffer.pointer;
>> +	if (cpm->package.count > count)
>> +		dev_warn(dev, "%s table contains %d values, only using first %d values\n",
>> +			 obj_name, cpm->package.count, count);
> 
> cpm->package.count is unsigned.

Ok, thank you for letting me know.

Regards,

Hans




