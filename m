Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212C12D9B9
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2019 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2J5V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 May 2019 05:57:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35734 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2J5V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2019 05:57:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so2856863edr.2
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2019 02:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y53TCSsKTwv22KtbB3ddc4kHEiT+bShgIe40w1C8rMU=;
        b=NLHFSpASZeJnuavSZuAmM4DVt/rNZSSWac4NjyY0Ur0qxFkT2cOq+V1BFPtjjyynP4
         ICdtPnKK+pqo5omgDjMEzo+i1u0bCtaeBhdh3op9CDHrwvJrsbf7K8ZK8Q29ixDTTYyi
         /KMh3/lw5Irm/EyblQxfn4zzPwnZF1RYhRQb/06diInN7s40yFR8Zk6DJHMpmRrY16TR
         R3M0Ckw6W6p4Abs2gdAqwdbl0k8hFsJc1tKh028zPUKmV/iCSQmA1xLPSf2h4BsCPOp1
         ZF+tySzR/N8pGWTrfPBjDTsZfRJpJOl3GIWNN7DU3a3nhMEFLhNG7g5rVbZyn7KfUEOo
         VPww==
X-Gm-Message-State: APjAAAXxRpwLIAZ8QM5R/om5tKyBa3WgJatbhr1LNzUUeCwMVc3BGtmg
        pAcBouVgVPOLWmbBdJJo6s3iuJ40SRU=
X-Google-Smtp-Source: APXvYqwNHlzl9kDv8S9x+Dd8wJ1lRnWXnH4Y32FWMp33oafgyOQFZtLTd7J1a0aKoDkTQgOPNhq0yQ==
X-Received: by 2002:a50:b56a:: with SMTP id z39mr134800736edd.91.1559123838596;
        Wed, 29 May 2019 02:57:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id l11sm2726493ejr.46.2019.05.29.02.57.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:57:17 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based
 ultrabooks
To:     =?UTF-8?Q?Lu=c3=ads_Ferreira?= <luis@aurorafoss.org>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
 <20190402160433.15810-1-luis@aurorafoss.org>
 <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
 <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
 <c34e15ec4be9d783c7134491639eb176@_>
 <9d8458a1-fc47-0727-4dc8-1d1eb185886d@redhat.com>
 <CAPyOxm9Q0Chq+TVjyK1eFWXCSJb0d-pttnEFVRB0Sw4QZnMM+Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <96658776-bd09-4b2d-2049-f2b213d60f8a@redhat.com>
Date:   Wed, 29 May 2019 11:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPyOxm9Q0Chq+TVjyK1eFWXCSJb0d-pttnEFVRB0Sw4QZnMM+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/23/19 2:03 PM, Luís Ferreira wrote:
> Hi Hams,
> 
> https://github.com/systemd/systemd/pull/12322
> https://github.com/hadess/iio-sensor-proxy/pull/262
> 
> As all the pull requests to systemd and iio-sensor-proxy has already
> been merged, I just need your review on this:
> https://github.com/systemd/systemd/pull/12449
> 
> Then, I guess this patch is ready to go. Please let me know if theres any issue.

Thank you for your work on this. I've given a favorable review to the

last systemd  pull-req.

Regards,

Hans


> On Wed, 17 Apr 2019 at 16:08, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 15-04-19 17:40, luis@aurorafoss.org wrote:
>>> April 6, 2019 10:36 AM, "Hans de Goede" <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>>> Yes that seems the best way forward with this.
>>>>
>>>> Note I think "base" is better then "keyboard" for the sensor which
>>>> is in the base/keyboard. But neither is perfect, so go which whatever
>>>> you prefer.
>>>
>>> Reference to:
>>> - https://github.com/hadess/iio-sensor-proxy/pull/262 > - https://github.com/systemd/systemd/pull/12322
>>
>> Thank you for your work on this, I see that Bastien has
>> already reviewed the iio-sensor-proxy changes.
>>
>> I've just added one small remark to the systemd changes,
>> except for that small remark the systemd changes look good to me.
>>
>> Regards,
>>
>> Hams
>>
>>
>>
>>
>>>> On 06-04-19 01:01, Luís Ferreira wrote:
>>>>
>>>>> Hi,
>>>>> Basically we need to come up with a convention to (optionally) indicate
>>>>
>>>> the sensors location with a udev attribute set by:
>>>> /lib/udev/hwdb.d/60-sensor.hwdb
>>>>> So should we start adding `ACCEL_LOCATION=display` and
>>>>> `ACCEL_LOCATION=keyboard` attributes to that file and patch
>>>>> iio-sensor-proxy to ignore the keyboard ones as a first step ?
>>>>
>>>> Yes that seems the best way forward with this.
>>>>
>>>> Note I think "base" is better then "keyboard" for the sensor which
>>>> is in the base/keyboard. But neither is perfect, so go which whatever
>>>> you prefer.
>>>>
>>>> Thanks & Regards,
>>>>
>>>> Hans
>>>>
>>>>> On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 02-04-19 18:04, Luís Ferreira wrote:
>>>>> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on display
>>>>> and KIOX020A sensor on keyboard base, to detect tablet mode or screen
>>>>> orientation.
>>>>
>>>> I deliberately left out the KIOX020A id for now, because currently
>>>> userspace cannot really deal with having 2 sensors.
>>>>
>>>> See:
>>>> https://github.com/systemd/systemd/issues/6557
>>>> https://github.com/hadess/iio-sensor-proxy/issues/166
>>>>
>>>> Basically we need to come up with a convention to (optionally) indicate
>>>> the sensors location with a udev attribute set by:
>>>> /lib/udev/hwdb.d/60-sensor.hwdb
>>>>
>>>> And then patch iio-sensor-proxy to consume that attribute and ignore
>>>> the one which has e.g. ACCEL_LOCATION=keyboard in its udev properties
>>>>
>>>> Ignoring would be a first step, maybe later it can do something useful
>>>> with it, see e.g. : https://github.com/alesguzik/linux_detect_tablet_mode
>>>>
>>>> IMHO we really should minimally get code in place for iio-sensor-proxy
>>>> to ignore the keyboard accelerometer before merging this patch.
>>>>
>>>> I realize that having the code in place will not magically get it on
>>>> all users machines, but I believe this is the minimum which needs to
>>>> happen before we push this out and potentially breaks people screen
>>>> rotation.
>>>>
>>>> I've had working on this on my TODO list for a long long time now,
>>>> but -ENOTIME. If you have some time to work on this then that would
>>>> be great.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>> Signed-off-by: Luís Ferreira <luis@aurorafoss.org>
>>>>> ---
>>>>> drivers/iio/accel/kxcjk-1013.c | 1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>>>>> index 7096e577b23f..9a5e445facc1 100644
>>>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>>>> @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>>>>> {"KIOX0009", KXTJ21009},
>>>>> {"KIOX000A", KXCJ91008},
>>>>> {"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
>>>>> + {"KIOX020A", KXCJ91008},
>>>>> {"KXTJ1009", KXTJ21009},
>>>>> {"KXJ2109", KXTJ21009},
>>>>> {"SMO8500", KXCJ91008},
