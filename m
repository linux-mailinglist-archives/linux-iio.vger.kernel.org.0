Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB16EC8E4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDXJbW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDXJbV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 05:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2474A9
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682328635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=101bKGITvVbsCn8uk8n12Qj37pN3vKLXCMqjQeIoc04=;
        b=JC7ZfiCcS4Zr3L5bjEf7qrQHygpZVSxl84a8s7GAcRaXZXEpLZChwowAeRwN4HL6nD+6bl
        wf1o8EaRCGt64dRQhEviezm9R0CXLCW6qYGnYqHZn19PYgUtVuVEXBieDX8TUB33ArVx/w
        23wm1gcFLMMQG+c4iwA2F+R2eFn7xdY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-AjieBcXpO9GihiQi-wkNRA-1; Mon, 24 Apr 2023 05:30:33 -0400
X-MC-Unique: AjieBcXpO9GihiQi-wkNRA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94f0dd11762so431010166b.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682328632; x=1684920632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=101bKGITvVbsCn8uk8n12Qj37pN3vKLXCMqjQeIoc04=;
        b=KrbHKg6zu/671H8QZGYTgkiDiaAHjAQ+qHZ1USXG7z1E2jkWLGeuTeO3k/NrO3CbVC
         Ha8rd5iNckl+Cu68TxOt9fPRnAmMhn5gt3JyeSOViW3tsoXHKVQcjgAyaz/EOginnxZ/
         9qQRVF38BLQKjMWC9gPi1AD4kNZ5KsEyZhCn5ib/z+A+4fQ8/OCWjO1/E4zR1sZoVj5a
         J/3Tpc/3eSqb9uTMaVsgSA9Z3ONVh6KPAhWDuWi7/wIGzBgabM1dfkV2CwSXDxnqxkQ1
         oeEMdUt9m6JeC8K60NjN1rpEON83CndmpcUtNUgU9pL3nCV8n9dQuua+kp6Xjkji+4gl
         +Sew==
X-Gm-Message-State: AAQBX9cwe+rzuFUyVJgwOvYy4Iw8WLzKbLKObpNkv6l4isSBENMKc/q4
        +roWwsl0GUYhgTDtHfIKK5Pi73Os1F+IOcxLN9Ou1Pu2uGCXfzYPsRwr6YLkY59rkkDmxxoruGv
        snV+GSzPx4n+VLyyKDvTe
X-Received: by 2002:a17:906:e241:b0:94e:afa6:299f with SMTP id gq1-20020a170906e24100b0094eafa6299fmr9550198ejb.22.1682328632681;
        Mon, 24 Apr 2023 02:30:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YuoJDdENwGRzEw3EnT7JocGZPpFKQ1wMuqgxOLTmfcvo100QBMI5LoF2vURE8cFwqIEIHW5A==
X-Received: by 2002:a17:906:e241:b0:94e:afa6:299f with SMTP id gq1-20020a170906e24100b0094eafa6299fmr9550190ejb.22.1682328632361;
        Mon, 24 Apr 2023 02:30:32 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id fx21-20020a170906b75500b009531d9efcc4sm5269971ejb.133.2023.04.24.02.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:30:31 -0700 (PDT)
Message-ID: <4d6d9ed3-09a1-dbe5-9cf3-fa527775f58b@redhat.com>
Date:   Mon, 24 Apr 2023 11:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on devices
 without ACPI _ONT method
To:     Jonathan Cameron <jic23@kernel.org>,
        Marius Hoch <mail@mariushoch.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230416212409.310936-1-hdegoede@redhat.com>
 <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
 <20230423114855.1596fe0c@jic23-huawei>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230423114855.1596fe0c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/23/23 12:48, Jonathan Cameron wrote:
> On Tue, 18 Apr 2023 14:32:42 +0200
> Marius Hoch <mail@mariushoch.de> wrote:
> 
>> On 16/04/2023 23:24, Hans de Goede wrote:
>>> When apply_acpi_orientation() fails, st_accel_common_probe() will fall back
>>> to iio_read_mount_matrix(), which checks for a mount-matrix device property
>>> and if that is not set falls back to the identity matrix.
>>>
>>> But when a sensor has no ACPI companion fwnode, or when the ACPI fwnode
>>> does not have a "_ONT" method apply_acpi_orientation() was returning 0,
>>> causing iio_read_mount_matrix() to never get called resulting in an
>>> invalid mount_matrix:
>>>
>>> [root@fedora ~]# cat /sys/bus/iio/devices/iio\:device0/mount_matrix
>>> (null), (null), (null); (null), (null), (null); (null), (null), (null)
>>>
>>> Fix this by making apply_acpi_orientation() always return an error when
>>> it did not set the mount_matrix.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
>> Tested, with the LSM303D patches applied, on a Lenovo Yoga Tablet 2 1051-F.
>>
>> Tested-by: Marius Hoch <mail@mariushoch.de>
> 
> Needs a fixes tag:. I think...
> 
> Fixes: 3d8ad94bb175 ("iio: accel: st_sensors: Support generic mounting matrix")

Right, ack for adding that fixes tag.

Regards,

Hans





> 
> actually introduced the issue rather than the patch that added the _ONT support
> 
> Linus, that's one of yours.  Could you also take a glance at this.
> 
> Seems 'obviously' correct but I've been wrong before :)
>>
>>
>>> ---
>>>   drivers/iio/accel/st_accel_core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
>>> index 1628b177d0ed..f7b823ebc96b 100644
>>> --- a/drivers/iio/accel/st_accel_core.c
>>> +++ b/drivers/iio/accel/st_accel_core.c
>>> @@ -1291,12 +1291,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
>>>   
>>>   	adev = ACPI_COMPANION(indio_dev->dev.parent);
>>>   	if (!adev)
>>> -		return 0;
>>> +		return -ENXIO;
>>>   
>>>   	/* Read _ONT data, which should be a package of 6 integers. */
>>>   	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
>>>   	if (status == AE_NOT_FOUND) {
>>> -		return 0;
>>> +		return -ENXIO;
>>>   	} else if (ACPI_FAILURE(status)) {
>>>   		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
>>>   			 status);  
>>
> 

