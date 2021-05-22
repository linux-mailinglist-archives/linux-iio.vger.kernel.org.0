Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9896738D6AD
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhEVRlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 13:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhEVRlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 13:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621705199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6GRUfQ7toTMa5QoVTx0BLLhOXrwhuDv3dHLxh4TMh4=;
        b=DBAs/6tFB0ILRFuoZjrIjXrSEUL/QzE701Wu9dnEcAfV6RdM8yc43MOcCIVvdfzy87hVND
        bNTLZ12FR/gN4qMG+O6mUUSu1hDMgDfdd79ndqhYnSNKCw1x9Kk3sU0FLw/V/gIHMIDAFK
        cRzmtYvWY1V5GaAPNr8zy1luJO60VDU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-rbm1Y9iaMzaSyWjVihrMDg-1; Sat, 22 May 2021 13:39:58 -0400
X-MC-Unique: rbm1Y9iaMzaSyWjVihrMDg-1
Received: by mail-ed1-f72.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso13230827edu.18
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q6GRUfQ7toTMa5QoVTx0BLLhOXrwhuDv3dHLxh4TMh4=;
        b=WQUddQTHYro6x5Xv6iydxxLQIRZtORU8lkxlTkUiSnOu6HGggHAeQRlvQ9DRKfBtPv
         MKXazj7MPWdMqKxeHwHHmQJvOjD3Z0Yn/qru2hgsJ+K0Sv6axk42GJQu12GHghmrMkMQ
         Zq3TpF3vItbStsx2D0kJJ7SJjaMltHHFw5+iz4phSgGzbLnUoApmjAS6L++t5P9i6aLT
         RAKisAUcF6e84BQMjP11yrxCF6lF6irESeIO8utci7hBfkwTG8OBOaKsczTWzKE+9eq4
         9M/b9/8BUVL2RE33flEIKTciLbrHMEBpRggn8/yJv97IAQdQl045dEw4jMwv/aRxrVut
         1egQ==
X-Gm-Message-State: AOAM530Msr/R2KXBjLaZCzEWeY26S7FEwCR7cz7ocp72uq2MvoDi2Fjq
        f9+PJt+Uxo49mVygNlFRoAIMudqpYFcNkBnfe3E8n7wGwxKXqT5JxZDPL/05Jh0F4iYrPfKj/Th
        pmcACZfv+PxF9xmVKvd0o
X-Received: by 2002:aa7:dc4a:: with SMTP id g10mr17531562edu.316.1621705196851;
        Sat, 22 May 2021 10:39:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymVgzUdFnQBYxhHAhGpOdOtkG0BYLr85w0DgReMRnsGWhcVPAmfJTY7VD2m35ptvGoK+kjow==
X-Received: by 2002:aa7:dc4a:: with SMTP id g10mr17531546edu.316.1621705196673;
        Sat, 22 May 2021 10:39:56 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g21sm6492108edb.92.2021.05.22.10.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 10:39:56 -0700 (PDT)
Subject: Re: [PATCH 3/8] iio: accel: bmc150: Move check for second ACPI device
 into a separate function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-4-hdegoede@redhat.com>
 <20210522183703.4328c4d8@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e547192-928c-64dd-f2fe-7658f2f6f061@redhat.com>
Date:   Sat, 22 May 2021 19:39:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210522183703.4328c4d8@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 7:37 PM, Jonathan Cameron wrote:
> On Fri, 21 May 2021 19:14:13 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Move the check for a second ACPI device for BOSC0200 ACPI fwnodes into
>> a new bmc150_acpi_dual_accel_probe() helper function.
>>
>> This is a preparation patch for adding support for a new "DUAL250E" ACPI
>> Hardware-ID (HID) used on some devices.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> A few places I'd like comments rewrapped on basis of still having
> a minor preference for a 80 chars limit unless there is a reason to
> do otherwise.
> 
> If this is all that turns up in the series, I can do that whilst
> applying.

Thank for the review.

If you can do the comment rewrapping while applying that would be
great, thanks. If a v2 is necessary I will take care of the 
rewrapping myself.

Regards,

Hans



> 
> Thanks,
> 
> Jonathan
> 
> 
>> ---
>>  drivers/iio/accel/bmc150-accel-i2c.c | 80 +++++++++++++++++-----------
>>  1 file changed, 49 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
>> index 2afaae0294ee..e24ce28a4660 100644
>> --- a/drivers/iio/accel/bmc150-accel-i2c.c
>> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
>> @@ -21,6 +21,51 @@
>>  
>>  #include "bmc150-accel.h"
>>  
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
>> +	{"BOSC0200"},
>> +	{ },
>> +};
>> +
>> +/*
>> + * Some acpi_devices describe 2 accelerometers in a single ACPI device, try instantiating
> 
> 80 char wrap still preferred when it doesn't otherwise hurt readability.
> 
>> + * a second i2c_client for an I2cSerialBusV2 ACPI resource with index 1.
>> + */
>> +static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>> +	struct i2c_client *second_dev;
>> +	struct i2c_board_info board_info = {
>> +		.type = "bmc150_accel",
>> +		/*
>> +		 * The 2nd accel sits in the base of 2-in-1s. Note this
>> +		 * name is static, as there should never be more then 1
>> +		 * BOSC0200 ACPI node with 2 accelerometers in it.
> 
> Given the lesser indent after pulling this out into a new function, it would
> be good to rewrap this text as nearer to 80 chars.
> 
>> +		 */
>> +		.dev_name = "BOSC0200:base",
>> +		.fwnode = client->dev.fwnode,
>> +		.irq = -ENOENT,
>> +	};
>> +
>> +	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
>> +		return;
>> +
>> +	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
>> +	if (!IS_ERR(second_dev))
>> +		bmc150_set_second_device(client, second_dev);
>> +}
>> +
>> +static void bmc150_acpi_dual_accel_remove(struct i2c_client *client)
>> +{
>> +	struct i2c_client *second_dev = bmc150_get_second_device(client);
>> +
>> +	i2c_unregister_device(second_dev);
>> +}
>> +#else
>> +static void bmc150_acpi_dual_accel_probe(struct i2c_client *client) {}
>> +static void bmc150_acpi_dual_accel_remove(struct i2c_client *client) {}
>> +#endif
>> +
>>  static int bmc150_accel_probe(struct i2c_client *client,
>>  			      const struct i2c_device_id *id)
>>  {
>> @@ -30,7 +75,6 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>  		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
>>  		i2c_check_functionality(client->adapter,
>>  					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
>> -	struct acpi_device __maybe_unused *adev;
>>  	int ret;
>>  
>>  	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
>> @@ -46,42 +90,16 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>  	if (ret)
>>  		return ret;
>>  
>> -	/*
>> -	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
>> -	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
>> -	 * ACPI resource with index 1. The !id check avoids recursion when
>> -	 * bmc150_accel_probe() gets called for the second client.
>> -	 */
>> -#ifdef CONFIG_ACPI
>> -	adev = ACPI_COMPANION(&client->dev);
>> -	if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
>> -		struct i2c_board_info board_info = {
>> -			.type = "bmc150_accel",
>> -			/*
>> -			 * The 2nd accel sits in the base of 2-in-1s. Note this
>> -			 * name is static, as there should never be more then 1
>> -			 * BOSC0200 ACPI node with 2 accelerometers in it.
>> -			 */
>> -			.dev_name = "BOSC0200:base",
>> -			.fwnode = client->dev.fwnode,
>> -			.irq = -ENOENT,
>> -		};
>> -		struct i2c_client *second_dev;
>> -
>> -		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
>> -		if (!IS_ERR(second_dev))
>> -			bmc150_set_second_device(client, second_dev);
>> -	}
>> -#endif
>> +	/* The !id check avoids recursion when probe() gets called for the second client. */
> 
> Won't hurt readability to wrap this to 80 chars as a multiline comment.
> 
>> +	if (!id && has_acpi_companion(&client->dev))
>> +		bmc150_acpi_dual_accel_probe(client);
>>  
>>  	return 0;
>>  }
>>  
>>  static int bmc150_accel_remove(struct i2c_client *client)
>>  {
>> -	struct i2c_client *second_dev = bmc150_get_second_device(client);
>> -
>> -	i2c_unregister_device(second_dev);
>> +	bmc150_acpi_dual_accel_remove(client);
>>  
>>  	return bmc150_accel_core_remove(&client->dev);
>>  }
> 

