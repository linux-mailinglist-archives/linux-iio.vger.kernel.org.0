Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530B938D6B3
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhEVRq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 13:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhEVRq0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 13:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621705501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jC3jhxNv/qIkNfpBzHT2TvRGq7NRssKdrwCbRNryedI=;
        b=QdRgD+qnXMVWYoaEDXEzuhd48eDgELiGdc5SDo1d+YsRhia+1n7UwLop1GyEUo2f4JraIl
        HADgK3OzZQ5o9HTOv3XUvkrCX1kC3inJ+j86lOfhvDz+ICpMpsEHA7u4QQb9LL/R/jM0yZ
        58ktXjP9011HZwJfhGari2mOrzZzK0I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-n16RpzjVNvi18L_8QoGq-g-1; Sat, 22 May 2021 13:44:57 -0400
X-MC-Unique: n16RpzjVNvi18L_8QoGq-g-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a0564023492b029038d5ad7c8a8so8189191edc.11
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 10:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jC3jhxNv/qIkNfpBzHT2TvRGq7NRssKdrwCbRNryedI=;
        b=VUQOGLiy+8L/nDW4xFPhqhB/YxuuDc4u5SXuLQWJcL/JYz91APKfzsQEkAfoIxDPoQ
         65KRNzyqNR/F3EdgaXyeFXMnW/cCq8dy7RNlzW0cjA5QBoht/vdIswLr3aOrAPxa3Hzq
         cS8D3bw2Cq6cC1WG/2touWdlGznq62mpVfNGQAur8tDKZIgBOc1+vcoxzQDhp32nLtYJ
         ZbvRgfW+CEeVmPn7hKNacHARl71l47G3j60/GNcNTp6Jn+s6Jx+tAuRMPFxU2UgizwJl
         SaRwQHv7xgy7u781k6Q4D1uVlTMoC9kiRUuF+XWFPjbArnFSIeo9GrvET3EjHhqrc+ru
         q99A==
X-Gm-Message-State: AOAM533JBtg/RuM2uVx+iBOhKf2UWyUw6PwFFyJ4ZlKPGXn7jeaR5QLv
        WXIyGqEEGExpR0/ZIc17H6z5dXLlVht8NRjEJEI/HiBT2+eIbQMobVGZ7AWZ2ybGG3QcR0a4QR2
        691pdculLFHBQoWTVnbGY
X-Received: by 2002:aa7:ce18:: with SMTP id d24mr17403308edv.170.1621705496490;
        Sat, 22 May 2021 10:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyywc+DHhVZr1MdvxfMdnZnNBW1sqmSOhcYE0W7ACb44q4wRsF1b7AXLXI8blA6J7srE5DFJg==
X-Received: by 2002:aa7:ce18:: with SMTP id d24mr17403301edv.170.1621705496362;
        Sat, 22 May 2021 10:44:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b12sm5591971ejg.89.2021.05.22.10.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 10:44:55 -0700 (PDT)
Subject: Re: [PATCH 4/8] iio: accel: bmc150: Add support for
 dual-accelerometers with a DUAL250E HID
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-5-hdegoede@redhat.com>
 <20210522184336.09c219cd@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3273a327-2b25-8b42-6870-e09982125119@redhat.com>
Date:   Sat, 22 May 2021 19:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210522184336.09c219cd@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 7:43 PM, Jonathan Cameron wrote:
> On Fri, 21 May 2021 19:14:14 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The Lenovo Yoga 300-11IBR has a ACPI fwnode with a HID of DUAL250E
>> which contains I2C and IRQ resources for 2 accelerometers, 1 in the
>> display and one in the base of the device. Add support for this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/iio/accel/bmc150-accel-i2c.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
>> index e24ce28a4660..b81e4005788e 100644
>> --- a/drivers/iio/accel/bmc150-accel-i2c.c
>> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
>> @@ -24,6 +24,7 @@
>>  #ifdef CONFIG_ACPI
>>  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
>>  	{"BOSC0200"},
>> +	{"DUAL250E"},
>>  	{ },
>>  };
>>  
>> @@ -35,21 +36,24 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
>>  {
>>  	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>>  	struct i2c_client *second_dev;
>> +	char dev_name[16];
> 
> I'm a bit in two minds about having a fixed length array for this.
> Obviously this is always big enough (I think a bit too big), but it
> might be a place where a future bug is introduced.  Perhaps it's worth the dance
> of a kasprintf and kfree, to avoid that possibility?

I would prefer to keep this as is, using malloc + free always leads
to problems if an error-exit path shows up between the 2.

But if you've a strong preference for switching to
kasprintf + kfree I can do that for v2.

Regards,

Hans



> 
>>  	struct i2c_board_info board_info = {
>>  		.type = "bmc150_accel",
>> -		/*
>> -		 * The 2nd accel sits in the base of 2-in-1s. Note this
>> -		 * name is static, as there should never be more then 1
>> -		 * BOSC0200 ACPI node with 2 accelerometers in it.
>> -		 */
>> -		.dev_name = "BOSC0200:base",
>> +		.dev_name = dev_name,
>>  		.fwnode = client->dev.fwnode,
>> -		.irq = -ENOENT,
>>  	};
>>  
>>  	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
>>  		return;
>>  
>> +	/*
>> +	 * The 2nd accel sits in the base of 2-in-1s. The suffix is static, as
>> +	 * there should never be more then 1 ACPI node with 2 accelerometers in it.
>> +	 */
>> +	snprintf(dev_name, sizeof(dev_name), "%s:base", acpi_device_hid(adev));
>> +
>> +	board_info.irq = acpi_dev_gpio_irq_get_by(adev, NULL, 1);
>> +
>>  	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
>>  	if (!IS_ERR(second_dev))
>>  		bmc150_set_second_device(client, second_dev);
>> @@ -114,6 +118,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>>  	{"BMA222E",	bma222e},
>>  	{"BMA0280",	bma280},
>>  	{"BOSC0200"},
>> +	{"DUAL250E"},
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> 

