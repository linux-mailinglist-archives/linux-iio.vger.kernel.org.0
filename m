Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3073038DB01
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhEWLH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 07:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231687AbhEWLHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 07:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621767958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bs5hatLmLqDDqWfEu5qFTnq+OE5Ryali+tI2dHlFutI=;
        b=eDn5Bh40DXaPkBQPS/a0wfrLzOBYtafxYuUJRC5++6dn6WViWVUBh88ujVYDr79A7xCTDl
        4iRx0PDo8VGYFSbqgMJ5priO8yyMGY/rDzS9PywXQSdP/kIYIkfS7swL0HBGTGWV6XaQwz
        /ZVsRO8S2lZZkEkTEQRoW7SuHIOjHZ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-HjcIE_-BOCykGFs6CjMAJg-1; Sun, 23 May 2021 07:05:57 -0400
X-MC-Unique: HjcIE_-BOCykGFs6CjMAJg-1
Received: by mail-ed1-f70.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so13942342edd.2
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 04:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bs5hatLmLqDDqWfEu5qFTnq+OE5Ryali+tI2dHlFutI=;
        b=HST7mJckzNeYwqrBecCCk3h2MogJq6ipC0E+fJXrBXanhUYG+QRFWk0iq0G8fMdXWu
         U9euGBewvdjRkbOPSV8h32ZrjToD+uWAlD88+4gLGF8PlLzxQOgcKjNiSd4CD7llaa3i
         DT2hq4acYwzflImurmcGBbxKI27BSjsAwzHHjqSafgpbYLMFwsKct5rFQ9F3wAq2Qoc+
         +MwIgSm7CGqfGOCpvRAZJkyDD/ioxwnRyAFd2AP+J2PgJXqZPcMOQpzUEcvR9xmISqwh
         pYVcgE1oJmW72Kc7Qe4j5xFhK8nYMhTsylTBx74cUnGCIZniQ9r1HJsdiCPe3F2lwAW9
         GtYw==
X-Gm-Message-State: AOAM532QwOM0IGDdM5uJhXQbXot2yk9haw+CWZDl0ShTE9e4hmF9nPsA
        n07mD8YQv6EqMP+tFcEnimbSd0ycn5DBOyfzEMFjm2oxEZjNzSJDkUvDEXJUkx22MRqR0p1o/Qn
        7qgE+At/BuaV8z1xty3ge
X-Received: by 2002:a17:906:c218:: with SMTP id d24mr17831601ejz.363.1621767956109;
        Sun, 23 May 2021 04:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQe4wCYR6Ld9L8K18a2z6YZwaqpAwtryb4ceNJphiDJn2+1fZj8JhYopG48DcgKxvYLs2RIw==
X-Received: by 2002:a17:906:c218:: with SMTP id d24mr17831583ejz.363.1621767955937;
        Sun, 23 May 2021 04:05:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id md21sm6462319ejb.110.2021.05.23.04.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 04:05:55 -0700 (PDT)
Subject: Re: [PATCH 0/8] iio: accel: bmc150: Add support for yoga's with dual
 accelerometers with an ACPI HID of DUAL250E
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210522190138.1715b095@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6019fc0c-ff75-824c-5b7c-e888b7fdf800@redhat.com>
Date:   Sun, 23 May 2021 13:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210522190138.1715b095@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:01 PM, Jonathan Cameron wrote:
> On Fri, 21 May 2021 19:14:10 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi All,
>>
>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
>> to allow the OS to determine the angle between the display and the base
>> of the device, so that the OS can determine if the 2-in-1 is in laptop
>> or in tablet-mode.
>>
>> We already support this setup on devices using a single ACPI node
>> with a HID of "BOSC0200" to describe both accelerometers. This patch
>> set extends this support to also support the same setup but then
>> using a HID of "DUAL250E".
>>
>> While testing this I found some crashes on rmmod, patches 1-2
>> fix those patches, patch 3 does some refactoring and patch 4
>> adds support for the "DUAL250E" HID.
>>
>> Unfortunately we need some more special handling though, which the
>> rest of the patches are for.
>>
>> On Windows both accelerometers are read (polled) by a special service
>> and this service calls a DSM (Device Specific Method), which in turn
>> translates the angles to one of laptop/tablet/tent/stand mode and then
>> notifies the EC about the new mode and the EC then enables or disables
>> the builtin keyboard and touchpad based in the mode.
>>
>> When the 2-in-1 is powered-on or resumed folded in tablet mode the
>> EC senses this independent of the DSM by using a HALL effect sensor
>> which senses that the keyboard has been folded away behind the display.
>>
>> At power-on or resume the EC disables the keyboard based on this and
>> the only way to get the keyboard to work after this is to call the
>> DSM to re-enable it (similar to how we also need to call a special
>> DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).
>>
>> Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
>> 2 accelerometers specifying which one is which.
> 
> Given only thing I'm planning to do is tweak the line wrapping, I'm
> happy to pick this series up.
> 
> The two fixes will slow things down a bit though as we should probably
> get those upstream this cycle.
> 
> I'm going to leave this on list for a few days before I take anything
> though, to give others time to take a look.

I'll do a v2 addressing a few minor things which Andy pointed out,
I'll also take care of the comment re-wrap in the v2.

> One side note, cc list includes a few random choices... Seems you've
> accidentally included alsa people as well as IIO ones. 

You're right, I accidentally included the address-list which I use
for ASoC patches. ASoc folks, sorry for the noise.

Regards,

Hans



>> Hans de Goede (8):
>>   iio: accel: bmc150: Fix dereferencing the wrong pointer in
>>     bmc150_get/set_second_device
>>   iio: accel: bmc150: Don't make the remove function of the second
>>     accelerometer unregister itself
>>   iio: accel: bmc150: Move check for second ACPI device into a separate
>>     function
>>   iio: accel: bmc150: Add support for dual-accelerometers with a
>>     DUAL250E HID
>>   iio: accel: bmc150: Move struct bmc150_accel_data definition to
>>     bmc150-accel.h
>>   iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor
>>     functions
>>   iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the
>>     hinge angle
>>   iio: accel: bmc150: Set label based on accel-location for ACPI
>>     DUAL250E fwnodes
>>
>>  drivers/iio/accel/bmc150-accel-core.c |  87 ++----------
>>  drivers/iio/accel/bmc150-accel-i2c.c  | 192 +++++++++++++++++++++-----
>>  drivers/iio/accel/bmc150-accel.h      |  66 ++++++++-
>>  3 files changed, 239 insertions(+), 106 deletions(-)
>>
> 

