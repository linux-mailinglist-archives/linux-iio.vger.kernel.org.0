Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA038D71B
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhEVTGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 15:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhEVTGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 15:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621710293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTYqpU4ltDUcNSbPoUdnAx3Y5FQHMd2LMPQn4HBUBaw=;
        b=bDJ24nJ30MjCO0nWULCHfJThkpxGBM4PM8n5Y3bEk5W1RRjs7ojZGZWU4g9gKTmhYn7Wsj
        e9sseSl5+/YlRm9cUcFHq1Nztvr5daI3tmM3XuAqRE7S5pGFVO2gNc9qEA6VkJD8AgIz/U
        RPfZlZTD0phyM+jqbX4qEJTO5ruik84=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-OosBQTBRPcqzyYurV0TYdA-1; Sat, 22 May 2021 15:04:51 -0400
X-MC-Unique: OosBQTBRPcqzyYurV0TYdA-1
Received: by mail-ed1-f71.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so5006270edb.13
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 12:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTYqpU4ltDUcNSbPoUdnAx3Y5FQHMd2LMPQn4HBUBaw=;
        b=ShQKrV5kFWYiQ8B94fOAE49cNODldW76mIkpPBpWJF9vd3IZb8E9Qfz9jpAsbSRBI1
         Lo0ZBMmOYqQqfQqXBu/HfXkfuAfRMtGhNI2PL4g/48jLpK5LVdUImjdhSS5ukThDbRiB
         1x5FVem4RLEIqrT/LgB5DmnunTHu/Tdz8vmqj9a43b+4dTenT9XcX3kcqZ+SM1JoWe8y
         84CneP2MvbyxNRPRvqOvRRBX/ECv9DaqREboFIv88MFJISdVnyNzzCuaFeAr2p63fNJ8
         8GPJcqiVMxhfORyPRaZMXb+gs9DQJ6Kvthbw+ziGXm7GR7V6KYoKN9noK/8/hazLlvV4
         7fSw==
X-Gm-Message-State: AOAM5335wtRLhJbiJ6kUao9ntIELwVyPu5DBzroMoyY0edUG4tcGaYNR
        0kWjTnnNl9oX8AC3QHxKSqHF2kkB9dAQnxtwNB7B8RC0q771zy7pu25oetiC2UQWAwuBSQLOZmG
        2wWxuVEG91R9XbzPJW7Rz
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr16119705ejc.292.1621710290720;
        Sat, 22 May 2021 12:04:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5S9lzwdzwMNz7zIjzaMkasypoc/wWhCqbx5Y97aDyj6iRIBkj7CbgYdIxqOAU0FN4XsRhYw==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr16119700ejc.292.1621710290572;
        Sat, 22 May 2021 12:04:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p11sm194424edt.22.2021.05.22.12.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 12:04:50 -0700 (PDT)
Subject: Re: [PATCH 8/8] iio: accel: bmc150: Set label based on accel-location
 for ACPI DUAL250E fwnodes
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
 <20210521171418.393871-9-hdegoede@redhat.com>
 <CAHp75VeOpT9yJx8FT57NwQQCo0ojs+-sHZn7D3DSA=caH3FZMg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <da47ac52-e584-7369-e153-09cb474d9708@redhat.com>
Date:   Sat, 22 May 2021 21:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeOpT9yJx8FT57NwQQCo0ojs+-sHZn7D3DSA=caH3FZMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:34 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some Yoga laptops with 1 accelerometer in the display and 1 in the base,
>> use an ACPI HID of DUAL250E instead of BOSC0200.
>>
>> Set the iio-device's label for DUAL250E devices to a value indicating which
>> sensor is which, mirroring how we do this for BOSC0200 dual sensor devices.
>>
>> Note the DUAL250E fwnode unfortunately does not include a mount-matrix.
> 
>> +       /* Special case for devices with a "DUAL250E" HID */
>> +       if (adev && acpi_dev_hid_uid_match(adev, "DUAL250E", NULL)) {
>> +               if (strcmp(dev_name(dev), "i2c-DUAL250E:base") == 0)
>> +                       label = "accel-base";
>> +               else
>> +                       label = "accel-display";
>> +
>> +               indio_dev->label = label;
>> +               return false; /* DUAL250E fwnodes have no mount matrix info */
>> +       }
>> +
>>         if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
>>                 return false;
> 
> 
> This sounds to me like
> 
> _apply_orientation_generic()
> ...
> 
> _apply_orientation_dual250e()
> 
> 
> _apply_orientation()
> 
> if ()
>   return _apply_orientation_generic()
> 
> if ()
>  return _apply_orientation_dual250e
> 
> return false;

Good point, I'll give that a try for v2 and see if I like the end result
of that. If it turns out to be a bit ugly I'll just stick with
what is in v1.

Regards,

Hans

