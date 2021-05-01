Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F403708A7
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhEATGI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEATGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:06:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE4BC06174A;
        Sat,  1 May 2021 12:05:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i81so1526595oif.6;
        Sat, 01 May 2021 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hzY7ml5D1Lj+5qqGNYNgPf5EY6MHEru66Pd51XSIiy4=;
        b=O9xbrCf2Owj41NdnpXwMNAG/4ySFYtFrNtgJbvgDNo0rUMOrVJY/Iocm4U7RS6n5B2
         GD9uiku6sK/As9pPdn+iVuy5RhHl/Y7Zy1hPDaztTZmB0FYUH7KTuqPR1Gw7Kq+Ycr8r
         JlJ1hloMU1t1QABtgfaPzgDMOd+AEW5qUQaSshcrAy226KEEU4JOXmQaWcQ7LMS3Mwef
         Xhz5LvWdTnoVY0O8QNgEmdBR4YVCxGIM3R32dQL4qNXvaWdrOdmaC56Vypsgw8iciNmq
         DgE7re77TwQU9cZN2cxQ96WxcgvWwXU2XP35kM1l9HhcsLayBC0gDIaDgKx63ccuKoXV
         2e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hzY7ml5D1Lj+5qqGNYNgPf5EY6MHEru66Pd51XSIiy4=;
        b=r8tdPMHrHKIxp2KXuElUJqmVIXY1jMLalXGNNEiwHOkjRZfxUVigd/835uQcZ6UJq3
         Ipz9do0XCVx6W+FYFm8u61Qu3imQ2KnY1jNxPNriPihSGLmfpmc5jTbw6GZ6xDbmCFst
         Zi4QA/Ub87xr3wy0kuP2sGr/+l5aKPa3l8rZxHe1HmGkB4acbL74uA4pjyAIt80YEAcG
         JjCAPHMMgWMuHcD4vUU4tEPvvDIBz7QN/casmGpk27eVYlHyRU4yp75LM7GP2vX5Q+RG
         m4mM86nRzm/tKIHP/y0hULfCqVABMjRuOU46BA+5j9nj0aUyLaikIsYyULC407bE320s
         SKOA==
X-Gm-Message-State: AOAM532A2dnTy8I3UoQf2earih7KcoVt0RJLuTHZhjvRw3UivGuoxKJZ
        MXXWamsNYm6tmIb3REYtN/IiGrdfg/k=
X-Google-Smtp-Source: ABdhPJwRmk94Kxs6xTQRfQ4t26KVkSL6GWs/m+4Bjgddt7DA6k4ExEdWDAA24/m4NBKdYZTdtcLAfw==
X-Received: by 2002:a05:6808:1305:: with SMTP id y5mr15865611oiv.142.1619895917638;
        Sat, 01 May 2021 12:05:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g16sm1590521oof.43.2021.05.01.12.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 12:05:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        letux-kernel@openphoenux.org
References: <20210430232404.26d60fef@aktux>
 <20210501030213.GA3198376@roeck-us.net> <20210501102101.087c1f1d@aktux>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Q] tps65185 EPD PMIC temperature interface - which subsystem
Message-ID: <88f0fb11-1021-32e7-272c-d2080d716690@roeck-us.net>
Date:   Sat, 1 May 2021 12:05:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210501102101.087c1f1d@aktux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/1/21 1:21 AM, Andreas Kemnade wrote:
> On Fri, 30 Apr 2021 20:02:13 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Fri, Apr 30, 2021 at 11:24:04PM +0200, Andreas Kemnade wrote:
>>> Hi,
>>>
>>> I am going about to clean up stuff to further upstream support for my
>>> ebook readers. One question arises about the temperature interface of
>>> the EPD PMIC. Vendor code uses regulator_get_voltage in the EPDC
>>> driver to read a temperature in celsius and provides temperature through
>>> the regulator interface (besides sysfs/hwmon). That is ugly. But what
>>> are the options, if a kernel consumer should be able to reference it via
>>> devicetree phandle and read out from it? I see temperature sensors
>>> both in the iio and the hwmon subsystem, but do not find a description
>>> why these things are there. If I put it into the iio-subsystem
>>> iio_channel_get() and friends can be used, if I understand things
>>> correctly, there are no such functions in the hwmon subsystem, so I
>>> would not be able to use it there. So the better choice is to put it
>>> into the iio subsystem?
>>>   
>>
>> I am guessing a bit here since a lot of context is missing. Presumably
>> there is a regulator driver. That regulator driver could register itself
>> with the hwmon subsystem using [devm_]hwmon_device_register_with_info()
>> and tell it to register a thermal zone sensor. It should then be possible
>> to read the temperature of that sensor using thermal_zone_get_temp().
>>
> Well, I try to give first some missing context. It is about temperature
> compensation, not cooling vs. overheating protection. EPDs behave
> different at different temperatures, so the driver needs a temperature
> to compensate for it.
> EPDs need also a bit more exotic voltages, so usually there is a
> separate PMIC for them. Usually that PMIC can also deliver a
> temperature. So drivers for that should consist of
> - mfd (obvious)

I would disagree. The presence of a thermal sensor does not make a chip
a multi-function device. Many Ethernet controllers have thermal sensors
nowadays. That doesn't make them multi-function devices.

> - regulator (also obvious)
> - something for providing the temperature (and that "something" is not
>   that clear to me as there are several subsystems dealing with
>   temperature)
> 
There are distinct use cases. iio is for industrial io, thermal is for
thermal management, and hwmon is to expose sensor data to userspace
for hardware monitoring. Normally one would pick the (or a) primary
use case and go from there.

For the tps65185, I could imagine using the thermal sensor for hardware
monitoring, and I can imagine its use for thermal control. I don't really
see a use case as industrial io.

>  
> And on EPD controller side I would like to be able to define (besides
> other things) in the device tree
>   epd-temperature = <&some_sensor>;
> 
> So your idea was to have that temperature sensor as a hwmon and
> providing also a thermal_sensor. If I understand correcly that would
> also require me to define a thermal zone where I can add the
> thermal sensor and which I could then reference somewhere.
> According to devicetree/bindings/thermal/thermal-zones.yaml defining
> trip points is required. That does not make sense in this context So I
> am wondering whether I am right there since it is not about
> overheating but about compensation. And there is only a
> thermal_zone_get_zone_by_name() but not a thermal_zone_get_sensor_by_name().
> Maybe I am getting something wrong.

drivers/mmc/host/sdhci-omap.c seems to do something similar, and doesn't
have trouble using a thermal zone for it.

> Vendor kernels in the wild additionally provide temperature by abusing
> the regulator API which is IMHO not acceptable.
> 
> But if that thing would in to the iio subsystem, I would simply be able
> to use iio_channel_get() to get the sensor from the device tree and
> iio_channel_read() to read values from it. There is a iio_hwmon and no
> hwmon_iio, so if someone wants a hwmon interface for it, it would not
> block anything.
> 
> The main point about writing this mail now is that I do not want to
> submit a driver, spin some polishing rounds, then somebody says:"Please
> go to subsystem Y, not X"
> 

You seem to be set in going along the mfd/iio path, though, which is fine
with me. It is not me you'll have to convince, after all.

Good luck!

Thanks,
Guenter
