Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808BF38D6D8
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhEVSLl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhEVSLl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621707015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4W2QcH7GGhbjcz45YQXs8r26c8aVBBmE8RTGqgNUAzA=;
        b=LB7RvtCAGyeo0oHmUwqIr+wyKNZsPCkaFfrSdzFFVg2SIA22M5ck2HoJ2ONyfdlC+Zp7Vw
        k6lcexajxfhgSEsQ0qPtpCWuDdMgQVS96iW42brG89hMbWC95URj9BJRMaKslnP9ptKSd3
        f/J6DP4KJQOyUL/M8pyuc5wcrOQ5bYM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-dpEO83ygMKCLikkAdYh7ww-1; Sat, 22 May 2021 14:10:14 -0400
X-MC-Unique: dpEO83ygMKCLikkAdYh7ww-1
Received: by mail-ed1-f72.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so4958087edb.13
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4W2QcH7GGhbjcz45YQXs8r26c8aVBBmE8RTGqgNUAzA=;
        b=COvoiLcGUD1U8IY+9VAcLRSZiG1r24k/NvMQ6GiTD6UmnY55vFJjroPz4ALIB40B/o
         lyX78a3e+9aj8BeIxuIGDd3KtmGBu/AuDxgnUk+risomMSUXeeNqQC+32A4ASPC+840d
         RgaSGQ3DYWnf7l2daNSuXAymXEr5C5Imf1uki3UCcCEN5Jgl65syxzaLftLLAKz5MqPz
         tTM1C8Y6LB7RoeuuMktsSbmkpZsfI/UG8/eZslJSPFtE+GmADhxdYhmHek2WP/FytcTQ
         c3jceErv6pd3oe7bCaqMZelv9feTojh+77EUWNKo81rXnAvP9Vh7/sq1SwGW6GoIFPqv
         86zw==
X-Gm-Message-State: AOAM5328dsfy4fIIzRrIpdcD6circq/7ZiMK2Us24OoqD6lWKMybrpZO
        rwmLo+srJeBqVDJy2BdQL/M2eO+rRcaOV0bZfi+VbE4ukn9Qc3o+fc5Tb5iy3K0GO/93Z6Db/7j
        fDR/CUsSEuRuLQ8O+9EZA
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr15377147eji.538.1621707013115;
        Sat, 22 May 2021 11:10:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDDRmIS+L1ZyDel3O6pfJ1kfu8hHyQboMTZ25cTa+wEBEqX7ZEtMU1ZbxLOAuGTslV7Zx0hA==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr15377135eji.538.1621707012974;
        Sat, 22 May 2021 11:10:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s11sm6716936edt.27.2021.05.22.11.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 11:10:12 -0700 (PDT)
Subject: Re: [PATCH 2/8] iio: accel: bmc150: Don't make the remove function of
 the second accelerometer unregister itself
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-3-hdegoede@redhat.com>
 <CAHp75VchPrngr5h91sfqxEPk81DHG43UkOsjhXpz4iNDagPjaw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <88627e31-b417-c0b3-2019-84fd9be69a0b@redhat.com>
Date:   Sat, 22 May 2021 20:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VchPrngr5h91sfqxEPk81DHG43UkOsjhXpz4iNDagPjaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:06 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On machines with dual accelerometers described in a single ACPI fwnode,
>> the bmc150_accel_probe() instantiates a second i2c-client for the second
>> accelerometer.
>>
>> A pointer to this manually instantiated second i2c-client is stored
>> inside the iio_dev's private-data through bmc150_set_second_device(),
>> so that the i2c-client can be unregistered from bmc150_accel_remove().
>>
>> Before this commit bmc150_set_second_device() took only 1 argument so it
>> would store the pointer in private-data of the iio_dev belonging to the
>> manually instantiated i2c-client, leading to the bmc150_accel_remove()
>> call for the second_dev trying to unregister *itself* while it was
>> being removed, leading to a deadlock and rmmod hanging.
>>
>> Change bmc150_set_second_device() to take 2 arguments: 1. The i2c-client
>> which is instantiating the second i2c-client for the 2nd accelerometer and
>> 2. The second-device pointer itself (which also is an i2c-client).
>>
>> This will store the second_device pointer in the private data of the
>> iio_dev belonging to the (ACPI instantiated) i2c-client for the first
>> accelerometer and will make bmc150_accel_remove() unregister the
>> second_device i2c-client when called for the first client,
>> avoiding the deadlock.
> 
> I would rather call it aux device (at least in the code). The
> terminology maybe needs more clarification (like the main one in the
> block with the display panel and aux in the keyboard).
> 
> If you disagree, ignore this comment. I have no strong opinion here
> since I don't know the difference between them (accelerometers).

Thank you for your input, but both sensors are identical, so calling
one aux sounds of to me, so lets keep this as is.

Regards,

Hans

