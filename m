Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3000A1C3600
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDJqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 05:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728360AbgEDJqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588585595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scFFt0BtLPxeOsN+SbAlNTW9udoDL7YI1oVFgdqCTZQ=;
        b=EsvJjMWca1dEh8G6lVVg4F1NQB5TuoyL2r/vJ6SS7br/+CZFaN/gf5gFjUA/KpQto4NDeh
        iWb4MHIeofMjewavizBE1kBEoPEIeFP+nrTNxfWcA2L9Lbv920eOqKb3Op6WLeiypTRiaZ
        IkFi3SzfjbLDbthzVz2TdJ4zapUcxy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-RIhSgbQJPEueZalICcztrQ-1; Mon, 04 May 2020 05:46:33 -0400
X-MC-Unique: RIhSgbQJPEueZalICcztrQ-1
Received: by mail-wm1-f72.google.com with SMTP id 71so3213196wmb.8
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2020 02:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scFFt0BtLPxeOsN+SbAlNTW9udoDL7YI1oVFgdqCTZQ=;
        b=pWHIzgvHH1KfY1lNCDMrU+fhw46jpG4Jdxb6o9Wyt9MJGLI3mc495BCQSP+MonNezL
         2azlPwaQaLXuVNI5ZRVQKs4YZVVhD8ktECy+VDwenmt8DVWPr7JuGpLWLg+2CEdMxTpc
         lizS2YJGEf1aKk/geCbiEt7PV5IyjCadTw7u4rW+kakQToSXQUklmmhlLTLj49aE38nw
         6/DW8h/HamfSlrZjD11mGZ5+L2zOJ2h9nM/yn28esmnf0V2whdiDug012R5TEjxCo733
         E7wgDyNjcUC0/eVlmSrvGb2IgOymPCsCfeZDl2icfy9heEX79t36rby2swdIFEMJk6ww
         c9Nw==
X-Gm-Message-State: AGi0Pualy0KWVUa1gijOSPtHa4uCNCf9Sv59sjEPYwRZK9dpo5V6LlvO
        0J79sS82/kH/Z7VKM+FUBiJmKRBvibrsKr+vV9wjXfU3DQZoDKuvUCX7rgeJxKp7dmUQMFRHFkv
        59PPO3xr8kaat3rmvKjaR
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr10850207wrt.215.1588585592348;
        Mon, 04 May 2020 02:46:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0l4tMFMDt9Hx6InMV/UDMk+rNzIMkzBVD6Xl95GsMPzXuuyBsYRdcehNHJEPa9EQux5wbsg==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr10850189wrt.215.1588585592165;
        Mon, 04 May 2020 02:46:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id z18sm17330878wrw.41.2020.05.04.02.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 02:46:31 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] iio: light: cm32181: Switch to new style
 i2c-driver probe function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200428172923.567806-1-hdegoede@redhat.com>
 <20200503115456.11a16411@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f6df1df-8c82-c14f-8862-c020d67d3df3@redhat.com>
Date:   Mon, 4 May 2020 11:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200503115456.11a16411@archlinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/3/20 12:54 PM, Jonathan Cameron wrote:
> On Tue, 28 Apr 2020 19:29:13 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Switch to the new style i2c-driver probe_new probe function and drop the
>> unnecessary i2c_device_id table (we do not have any old style board files
>> using this).
>>
>> This is a preparation patch for adding ACPI binding support.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - This is a new patch in v3 of this patch-set
>> ---
>>   drivers/iio/light/cm32181.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index 5f4fb5674fa0..cc57190a24cb 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -294,8 +294,7 @@ static const struct iio_info cm32181_info = {
>>   	.attrs			= &cm32181_attribute_group,
>>   };
>>   
>> -static int cm32181_probe(struct i2c_client *client,
>> -			const struct i2c_device_id *id)
>> +static int cm32181_probe(struct i2c_client *client)
>>   {
>>   	struct cm32181_chip *cm32181;
>>   	struct iio_dev *indio_dev;
>> @@ -316,7 +315,7 @@ static int cm32181_probe(struct i2c_client *client,
>>   	indio_dev->channels = cm32181_channels;
>>   	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
>>   	indio_dev->info = &cm32181_info;
>> -	indio_dev->name = id->name;
>> +	indio_dev->name = dev_name(&client->dev);
> 
> ABI breakage.  The name needs to be unaffected by this patch and I'm
> fairly sure it just gained the vendor prefix.
> 
> So to drop that table, you need to provide the 'clean' part number
> somewhere else.  Seeing as driver currently only supports one number,
> you could just provide it directly here. However, as you are
> going to add support for another part number later, you'll need
> to do something more clever when you introduce that.

Ok, I will fix this for the next version.

> I'll make this suggestion in that patch, but I think you should add
> a chip_info structure for each of the supported chips rather than using
> a switch to put a number of different elements in place.  The name
> would then go in there.

Ok, I will add a chip_info structure for the next version (version 4).

Regards,

Hans

