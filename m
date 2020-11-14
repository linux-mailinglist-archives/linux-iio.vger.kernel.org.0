Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0447F2B2EBE
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKNRHq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgKNRHq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 12:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605373664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7eOf6M4BZi7FI2MSpBtRxoJdPZ5Cq2ZPdN22WIQ0vY=;
        b=d1zJwjwI2oW3rMbBotMVqWeSLmkA8VV0GLVkwohNm93+wPLOzwcU8xb6qHFhriu8MZG60F
        kBoNHnkn/m9+hHSo5q82zr37DBX45jXB1Hf6tO+vcyVEJ6D0SDI9bffygaEPNnLifoeD17
        Lnmxqil9+3JTar76JbqEWGr8fa0nFPs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-zETcrxJpNeaJ4uka6Bq2pQ-1; Sat, 14 Nov 2020 12:07:42 -0500
X-MC-Unique: zETcrxJpNeaJ4uka6Bq2pQ-1
Received: by mail-ed1-f71.google.com with SMTP id s7so6277017eds.17
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2020 09:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7eOf6M4BZi7FI2MSpBtRxoJdPZ5Cq2ZPdN22WIQ0vY=;
        b=oEHCqhJGFU3Xk+TLPgGwSK4oXMRdoMBlA7Vo0qawQwYAJY7aR6rTJ2xLjEpLCH5a/b
         bh4Zlrc3Z6K5xybg1+k/i4HfLs5jBO8jfw60LXOdTBmwvQkBNV2R6CdKA6wB36acWIb1
         ddjqZc59ZlXHGkU9/umsTsGD+qSX6wer50e8jszO+YjEa57kefneTvqdZElq2o41gcMO
         34clelskn/Ux2GpJ3a6eI+IltTbL7mSxb1qRLu9a7hNsgvLBdEhzEv54H6OeOod08jk+
         ZMBhYRI004nzB8ZNCqgfga+Vl8TRFHtMQfhcWnlterxK7oVNvHDY2ojtndFKzzRBKruq
         0VMg==
X-Gm-Message-State: AOAM5311gFWTISjHondrYPo8WV8WNhBvrblb4TZ/Zpu5N3kf41RwqHWO
        Y9yBMxDj+o0GcT1Mc8cFcx34OM4P3ZgiWNEFaERxsSCdLEkU79GmiZdM0Rfj3PYjS8eUq+E3rHm
        bJ4vAxhwhUSQlhsiL1W0QmRl0YYnkT+OCCHEhT3fSWo8updcshlfHIzvnDk1AxYcw8odWLT8D
X-Received: by 2002:aa7:d407:: with SMTP id z7mr8365910edq.234.1605373660583;
        Sat, 14 Nov 2020 09:07:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJ7GAfEWSWjAtsh4hETHXTbhwEL3QPXyn5nwrC3W/btAGvDmEEEzcb2T9/+qafrTokRkOkzA==
X-Received: by 2002:aa7:d407:: with SMTP id z7mr8365881edq.234.1605373660346;
        Sat, 14 Nov 2020 09:07:40 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id h2sm7020151ejx.55.2020.11.14.09.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 09:07:39 -0800 (PST)
Subject: Re: [PATCH bugfix for 5.10 2/2] iio: accel: kxcjk1013: Add support
 for KIOX010A ACPI DSM for setting tablet-mode
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org
References: <20201110133835.129080-1-hdegoede@redhat.com>
 <20201110133835.129080-3-hdegoede@redhat.com>
 <20201114160118.0a373496@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <196bd93a-b005-e7fd-4db1-138934080ec8@redhat.com>
Date:   Sat, 14 Nov 2020 18:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201114160118.0a373496@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/14/20 5:01 PM, Jonathan Cameron wrote:
> On Tue, 10 Nov 2020 14:38:35 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
>> to allow the OS to determine the angle between the display and the base
>> of the device, so that the OS can determine if the 2-in-1 is in laptop
>> or in tablet-mode.
>>
>> On Windows both accelerometers are read by a special HingeAngleService
>> process; and this process calls a DSM (Device Specific Method) on the
>> ACPI KIOX010A device node for the sensor in the display, to let the
>> embedded-controller (EC) know about the mode so that it can disable the
>> kbd and touchpad to avoid spurious input while folded into tablet-mode.
>>
>> This notifying of the EC is problematic because sometimes the EC comes up
>> thinking that device is in tablet-mode and the kbd and touchpad do not
>> work. This happens for example on Irbis NB111 devices after a suspend /
>> resume cycle (after a complete battery drain / hard reset without having
>> booted Windows at least once). Other 2-in-1s which are likely affected
>> too are e.g. the Teclast F5 and F6 series.
>>
>> The kxcjk-1013 driver may seem like a strange place to deal with this,
>> but since it is *the* driver for the ACPI KIOX010A device, it is also
>> the driver which has access to the ACPI handle needed by the DSM.
>>
>> Add support for calling the DSM and on probe unconditionally tell the
>> EC that the device is laptop mode, fixing the kbd and touchpad sometimes
>> not working.
>>
>> Reported-and-tested-by: russianneuromancer <russianneuromancer@ya.ru>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Hi Hans,
> 
> *Mutters darkly about crazy firmware hacks*
> 
> I'm fine taking this but I assume we want to backport and for that I'm
> after a fixes tag.

Good point, I guess taking the commit which originally added the
KIOX010A ACPI Hardware-ID makes the most sense:

Fixes: 7f6232e69539 ("iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID")

Regards,

Hans



>> ---
>>  drivers/iio/accel/kxcjk-1013.c | 36 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index abeb0d254046..560a3373ff20 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -129,6 +129,7 @@ enum kx_chipset {
>>  enum kx_acpi_type {
>>  	ACPI_GENERIC,
>>  	ACPI_SMO8500,
>> +	ACPI_KIOX010A,
>>  };
>>  
>>  struct kxcjk1013_data {
>> @@ -275,6 +276,32 @@ static const struct {
>>  			      {19163, 1, 0},
>>  			      {38326, 0, 1} };
>>  
>> +#ifdef CONFIG_ACPI
>> +enum kiox010a_fn_index {
>> +	KIOX010A_SET_LAPTOP_MODE = 1,
>> +	KIOX010A_SET_TABLET_MODE = 2,
>> +};
>> +
>> +static int kiox010a_dsm(struct device *dev, int fn_index)
>> +{
>> +	acpi_handle handle = ACPI_HANDLE(dev);
>> +	guid_t kiox010a_dsm_guid;
>> +	union acpi_object *obj;
>> +
>> +	if (!handle)
>> +		return -ENODEV;
>> +
>> +	guid_parse("1f339696-d475-4e26-8cad-2e9f8e6d7a91", &kiox010a_dsm_guid);
>> +
>> +	obj = acpi_evaluate_dsm(handle, &kiox010a_dsm_guid, 1, fn_index, NULL);
>> +	if (!obj)
>> +		return -EIO;
>> +
>> +	ACPI_FREE(obj);
>> +	return 0;
>> +}
>> +#endif
>> +
>>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>>  			      enum kxcjk1013_mode mode)
>>  {
>> @@ -352,6 +379,13 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>>  {
>>  	int ret;
>>  
>> +#ifdef CONFIG_ACPI
>> +	if (data->acpi_type == ACPI_KIOX010A) {
>> +		/* Make sure the kbd and touchpad on 2-in-1s using 2 KXCJ91008-s work */
>> +		kiox010a_dsm(&data->client->dev, KIOX010A_SET_LAPTOP_MODE);
>> +	}
>> +#endif
>> +
>>  	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_WHO_AM_I);
>>  	if (ret < 0) {
>>  		dev_err(&data->client->dev, "Error reading who_am_i\n");
>> @@ -1262,6 +1296,8 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
>>  
>>  	if (strcmp(id->id, "SMO8500") == 0)
>>  		*acpi_type = ACPI_SMO8500;
>> +	else if (strcmp(id->id, "KIOX010A") == 0)
>> +		*acpi_type = ACPI_KIOX010A;
>>  
>>  	*chipset = (enum kx_chipset)id->driver_data;
>>  
> 

