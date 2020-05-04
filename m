Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB01C3646
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgEDJ5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 05:57:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728196AbgEDJ5h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588586254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duzcKOL+clYMFWvtQmG1hWE1PDdpjEpPG5bALVD7E4M=;
        b=LpBYT9KZDyrOh9wCLjnAf13jYBr1lJq50qzPVuq43ZLxLfh3t4UEAQqJvIauY611Na6oJO
        oRshw4op4tITiGIwk0bjArmJXG+SCm0CWtZD5ST4JhmfaW73A6JhxX2PEsNjWR+mz7HUfk
        n1/wWvGcpKWcHK2E6/8Dw7uVs/jrPbs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-kyKvIJq_MICINmPRDr02qg-1; Mon, 04 May 2020 05:57:33 -0400
X-MC-Unique: kyKvIJq_MICINmPRDr02qg-1
Received: by mail-wm1-f70.google.com with SMTP id v185so3242350wmg.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2020 02:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=duzcKOL+clYMFWvtQmG1hWE1PDdpjEpPG5bALVD7E4M=;
        b=JsH47QYyZKyWPzImyaxL6mdB0Ydgpe6gOX+uU+td52n8h/SVc/jKBr6LGzvmEkZ+pJ
         /yoE86SLOk8V6wuZSRkVf6w8gWoqCh5QzW14MAIqB2JSUbCMaEt4+N2FCXvNxsKTYsOj
         M9VyQx4O5zCHkzskM1BjbKWvEiqvqazafWvUTSO8vDDQdkA5Xjo3ADlOg/DAsAJuJvtT
         yKl+JTwyY/IGKgEt9n1OzXg+kGeE6A7cZxNMspZVQSuXAowtRmitb7X7XJ2XimdWbkhn
         uHvfkekiGsSOeDK+i4gWDnWbNsOdS3m14FluDeEeGWLqgGV9SDlpjgi04kx2URdXtpkQ
         5xmw==
X-Gm-Message-State: AGi0PuYkccA9Dy70xpKGGcXMBtaA6indgMea5/k657GKOuTYiFogqjp5
        VKrKI+0HAW33mi7mh/PU8jov7IqRFGxRcA9k868wfCAP2kormOyEAhMcL9y+bgkyjVpZ0y89JxT
        YkwfyAUSKUhim8uVY7seH
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr13135776wmc.114.1588586251826;
        Mon, 04 May 2020 02:57:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypI9NIOO7zq7z+wfpId4cCkZOfl2NWIgFJBJaj03kXgs1WsWzLPwY4so37bdEHIB8L8uXpceWQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr13135741wmc.114.1588586251519;
        Mon, 04 May 2020 02:57:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q18sm12054672wmj.11.2020.05.04.02.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 02:57:30 -0700 (PDT)
Subject: Re: [PATCH v3 10/11] iio: light: cm32181: Add support for parsing
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
References: <20200428172923.567806-1-hdegoede@redhat.com>
 <20200428172923.567806-10-hdegoede@redhat.com>
 <20200503122237.4af34181@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d72cda48-79cd-8f73-066e-e5ef7a2e9ee1@redhat.com>
Date:   Mon, 4 May 2020 11:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200503122237.4af34181@archlinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/3/20 1:22 PM, Jonathan Cameron wrote:
> On Tue, 28 Apr 2020 19:29:22 +0200
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
> 
> I assume it's far too much to hope this CPM0 / CPM1 stuff is actually defined
> in a spec anywhere?
> 
> There are standard way of adding vendor specific data blobs to ACPI and this
> isn't one of them (unless I'm missing something).  People need to beat
> up vendors earlier about this stuff.

To be fair, most devices with these sensors are quite old, the T100TA
was released in 2013. I have adding support for these on my todo list
for quite some time now (years really), but I never got around to it until
now.

Surprisingly enough, the recent released Chuwi Hi 13 device is also using
a CM32181 sensor though, so even though these are old they are still
being used.

Anyways what I'm trying to say is that the CPM0 / CPM1 objects predate
specs for doing this in a more standardized ways by many years.

Also the specs to do this in a standardized way are mostly being driven
from the ARM side of things and x86 hardware/firmware developers are
used to just doing there own things for decades now, so I would not
expect them to pick this up anytime soon, sorry.

Regards,

Hans



>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Factor out the parsing into a separate helper function
>> ---
>>   drivers/iio/light/cm32181.c | 101 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index cae2264e4336..d8b128286527 100644
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
>>   /* CM3218 Family */
>>   static const int cm3218_als_it_bits[] = { 0, 1, 2, 3 };
>>   static const int cm3218_als_it_values[] = { 100000, 200000, 400000, 800000 };
>> @@ -65,6 +75,7 @@ static const int cm32181_als_it_values[] = {
>>   
>>   struct cm32181_chip {
>>   	struct i2c_client *client;
>> +	struct device *dev;
>>   	struct mutex lock;
>>   	u16 conf_regs[CM32181_CONF_REG_NUM];
>>   	unsigned long init_regs_bitmap;
>> @@ -76,6 +87,92 @@ struct cm32181_chip {
>>   	const int *als_it_values;
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
>> +
>> +	count = min_t(int, cpm->package.count, count);
>> +	for (i = 0; i < count; i++) {
>> +		elem = &(cpm->package.elements[i]);
>> +		values[i] = elem->integer.value;
>> +	}
>> +
>> +	kfree(buffer.pointer);
>> +
>> +	return count;
>> +}
>> +
>> +static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
>> +{
>> +	u64 vals[CPM0_HEADER_SIZE + CM32181_CONF_REG_NUM];
>> +	struct device *dev = cm32181->dev;
>> +	int i, count;
>> +
>> +	count = cm32181_acpi_get_cpm(dev, "CPM0", vals, ARRAY_SIZE(vals));
>> +	if (count <= CPM0_HEADER_SIZE)
>> +		return;
>> +
>> +	count -= CPM0_HEADER_SIZE;
>> +
>> +	cm32181->init_regs_bitmap = vals[CPM0_REGS_BITMAP];
>> +	cm32181->init_regs_bitmap &= GENMASK(count - 1, 0);
>> +	for_each_set_bit(i, &cm32181->init_regs_bitmap, count)
>> +		cm32181->conf_regs[i] =	vals[CPM0_HEADER_SIZE + i];
>> +
>> +	count = cm32181_acpi_get_cpm(dev, "CPM1", vals, ARRAY_SIZE(vals));
>> +	if (count != CPM1_SIZE)
>> +		return;
>> +
>> +	cm32181->lux_per_bit = vals[CPM1_LUX_PER_BIT];
>> +
>> +	/* Check for uncalibrated devices */
>> +	if (vals[CPM1_CALIBSCALE] == CM32181_CALIBSCALE_DEFAULT)
>> +		return;
>> +
>> +	cm32181->calibscale = vals[CPM1_CALIBSCALE];
>> +	/* CPM1 lux_per_bit is for the current it value */
>> +	cm32181_read_als_it(cm32181, &cm32181->lux_per_bit_base_it);
>> +}
>> +#else
>> +static void cm32181_acpi_parse_cpm_tables(struct cm32181_chip *cm32181)
>> +{
>> +}
>> +#endif /* CONFIG_ACPI */
>> +
>>   /**
>>    * cm32181_reg_init() - Initialize CM32181 registers
>>    * @cm32181:	pointer of struct cm32181.
>> @@ -119,6 +216,9 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>>   	cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
>>   	cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
>>   
>> +	if (ACPI_HANDLE(cm32181->dev))
>> +		cm32181_acpi_parse_cpm_tables(cm32181);
>> +
>>   	/* Initialize registers*/
>>   	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
>>   		ret = i2c_smbus_write_word_data(client, i,
>> @@ -361,6 +461,7 @@ static int cm32181_probe(struct i2c_client *client)
>>   
>>   	cm32181 = iio_priv(indio_dev);
>>   	cm32181->client = client;
>> +	cm32181->dev = dev;
>>   
>>   	mutex_init(&cm32181->lock);
>>   	indio_dev->dev.parent = dev;
> 

