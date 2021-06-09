Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92923A1E34
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFIUn0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFIUn0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 16:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623271291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znrKQOWEodZxBceY9cETqZO4z0p+j3t/z1v80KCCMd0=;
        b=d09VgfWvWJrPni7mzIWBQDASriE6s6rnlZwMb3M6US5PKOwyypKtcEfypBeOMCmWXjQFpU
        xcpKZMD77pF8kMGMgH0oiX5dLCe06ZXnGRJRDjktuLrkcI1k0mjjLUf2A6+e43NCF+mxBX
        il7mHcqEm+xL7nRhxQxkVnstCyR+74M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-WC8fz4ccMaq7wOjgWgplKA-1; Wed, 09 Jun 2021 16:41:30 -0400
X-MC-Unique: WC8fz4ccMaq7wOjgWgplKA-1
Received: by mail-ed1-f70.google.com with SMTP id c13-20020a50f60d0000b02903900105f127so12927783edn.22
        for <linux-iio@vger.kernel.org>; Wed, 09 Jun 2021 13:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znrKQOWEodZxBceY9cETqZO4z0p+j3t/z1v80KCCMd0=;
        b=gIDNfyVfI2f2Bb7QDuJXZKw2es8cfSRhpB6t2nNkNL1U6TlPovirEPgWo2lCabDldh
         8rAxKRR3y6NYBZLC8txEs0WXtutv4Kuz63uJ4yqc7lIdF+u+7q9hgfT7mKoRPN906bGG
         rRAPZKvDLUhAnKHP9MfpZE8p0IQ6PTjUlldkNPB9SUPBHF/7t85a6+589+wlTxAwLWWh
         XxprpgwECfKkMbPc1Gu/gWV2Srt53x6jdy8mxY+/O13vithr8y62KA2LIVdv6a+vnnkh
         +l9qyll7PPp6c6lmEGhWOEBdqRKEVRwscvlQGGOrB9vQgN4ASWeeVTAz2eb6G9otv9iC
         m3ZA==
X-Gm-Message-State: AOAM530o+SkItF3BtkXWn/EYlKs4s9Px1/Mru90cKcw3JcOQwhSMc1qm
        KOEz0mmalRMTU+Ze08JWYhgslR/0Mo6A2Rkbwh2J4Z0JhIiVulC98uSb2xbjwbEbhSd1QwVyxo3
        o69YohxMko+TsnsxWViAnUADFxZDsV8hKG4sSdGaLn4iBjHD7FUlWF8ukfJlL5CMiNG5hUGuL
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr1462351ejc.263.1623271288091;
        Wed, 09 Jun 2021 13:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIbSGf1AdnTQMAZDH/sadVIqjPLY9fQMQs8pJDTgsZ/kVHsWjrfHZY7v88z4L6mvzHsgIsCA==
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr1462335ejc.263.1623271287838;
        Wed, 09 Jun 2021 13:41:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b14sm133216ejk.120.2021.06.09.13.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:41:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] iio: accel: bmc150: Don't make the remove function
 of the second accelerometer unregister itself
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
References: <20210523170103.176958-1-hdegoede@redhat.com>
 <20210523170103.176958-3-hdegoede@redhat.com>
 <20210526175541.35db2461@jic23-huawei> <20210609204953.5314cbd0@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <795438da-7c5f-9f2e-db32-b4cf99011901@redhat.com>
Date:   Wed, 9 Jun 2021 22:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609204953.5314cbd0@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/9/21 9:49 PM, Jonathan Cameron wrote:
> On Wed, 26 May 2021 17:55:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Sun, 23 May 2021 19:00:56 +0200
>> Hans de Goede <hdegoede@redhat.com> wrote:
>>
>>> On machines with dual accelerometers described in a single ACPI fwnode,
>>> the bmc150_accel_probe() instantiates a second i2c-client for the second
>>> accelerometer.
>>>
>>> A pointer to this manually instantiated second i2c-client is stored
>>> inside the iio_dev's private-data through bmc150_set_second_device(),
>>> so that the i2c-client can be unregistered from bmc150_accel_remove().
>>>
>>> Before this commit bmc150_set_second_device() took only 1 argument so it
>>> would store the pointer in private-data of the iio_dev belonging to the
>>> manually instantiated i2c-client, leading to the bmc150_accel_remove()
>>> call for the second_dev trying to unregister *itself* while it was
>>> being removed, leading to a deadlock and rmmod hanging.
>>>
>>> Change bmc150_set_second_device() to take 2 arguments: 1. The i2c-client
>>> which is instantiating the second i2c-client for the 2nd accelerometer and
>>> 2. The second-device pointer itself (which also is an i2c-client).
>>>
>>> This will store the second_device pointer in the private data of the
>>> iio_dev belonging to the (ACPI instantiated) i2c-client for the first
>>> accelerometer and will make bmc150_accel_remove() unregister the
>>> second_device i2c-client when called for the first client,
>>> avoiding the deadlock.
>>>
>>> Fixes: 5bfb3a4bd8f6 ("iio: accel: bmc150: Check for a second ACPI device for BOSC0200")
>>> Cc: Jeremy Cline <jeremy@jcline.org>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
>> Patches 1 and 2 applied to the fixes-togreg branch of iio.git and marked for stable.
>> The rest will have to wait for now.
> Cycle has gone past rather quicker than expected, so I've changed
> my mind on these two and pulled them across to the togreg branch
> targeting 5.14.
> That will mean the hit stable a little later (after 5.14-rc1)

Ok, note the problems fixed in the first 2 patches are only hit on
a rmmod (or an unbind), so there is no big hurry in getting them
in to the stable series.

> but pretty much ensures the rest of the series makes it into 5.14

Getting the rest of the series into 5.14 without issues is much
appreciated, thank you.

Regards,

Hans



>>> ---
>>>  drivers/iio/accel/bmc150-accel-core.c | 4 ++--
>>>  drivers/iio/accel/bmc150-accel-i2c.c  | 2 +-
>>>  drivers/iio/accel/bmc150-accel.h      | 2 +-
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
>>> index 3a3f67930165..8ff358c37a81 100644
>>> --- a/drivers/iio/accel/bmc150-accel-core.c
>>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>>> @@ -1815,11 +1815,11 @@ struct i2c_client *bmc150_get_second_device(struct i2c_client *client)
>>>  }
>>>  EXPORT_SYMBOL_GPL(bmc150_get_second_device);
>>>  
>>> -void bmc150_set_second_device(struct i2c_client *client)
>>> +void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev)
>>>  {
>>>  	struct bmc150_accel_data *data = iio_priv(i2c_get_clientdata(client));
>>>  
>>> -	data->second_device = client;
>>> +	data->second_device = second_dev;
>>>  }
>>>  EXPORT_SYMBOL_GPL(bmc150_set_second_device);
>>>  
>>> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
>>> index 69f709319484..2afaae0294ee 100644
>>> --- a/drivers/iio/accel/bmc150-accel-i2c.c
>>> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
>>> @@ -70,7 +70,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
>>>  
>>>  		second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
>>>  		if (!IS_ERR(second_dev))
>>> -			bmc150_set_second_device(second_dev);
>>> +			bmc150_set_second_device(client, second_dev);
>>>  	}
>>>  #endif
>>>  
>>> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
>>> index 6024f15b9700..e30c1698f6fb 100644
>>> --- a/drivers/iio/accel/bmc150-accel.h
>>> +++ b/drivers/iio/accel/bmc150-accel.h
>>> @@ -18,7 +18,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>>>  			    const char *name, bool block_supported);
>>>  int bmc150_accel_core_remove(struct device *dev);
>>>  struct i2c_client *bmc150_get_second_device(struct i2c_client *second_device);
>>> -void bmc150_set_second_device(struct i2c_client *second_device);
>>> +void bmc150_set_second_device(struct i2c_client *client, struct i2c_client *second_dev);
>>>  extern const struct dev_pm_ops bmc150_accel_pm_ops;
>>>  extern const struct regmap_config bmc150_regmap_conf;
>>>    
>>
> 

