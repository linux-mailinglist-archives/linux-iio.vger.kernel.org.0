Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3D6A2887
	for <lists+linux-iio@lfdr.de>; Sat, 25 Feb 2023 10:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBYJfT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Feb 2023 04:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYJfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2023 04:35:18 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0713D76
        for <linux-iio@vger.kernel.org>; Sat, 25 Feb 2023 01:35:17 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id by8so1474442ljb.7
        for <linux-iio@vger.kernel.org>; Sat, 25 Feb 2023 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiJAJE4FfD2rP9SWjzqbnFHQ/bHKat6AXGbjwcc7HFo=;
        b=J3ULBf7KkCw38I/BiaMzLxn9u24qdYi5r4LWVJx8+LCK8msNA9MqiIvnLjv8z78yPx
         c/D8FZhSmU/HsrdTKGtfH93GNIDr2MWfyMbRhFyBD1Xz2BW6HD0XIP1owxxEG45IW5Qw
         t9KTLCmZGU+ZoHijt574WR7oUeBjTj0zQirxpGQjWMm4p3CXn7ocIi8aVOOjHuxhSBjK
         5sAK+IPPZF71InyOM2MBvUSYaKM7XG5ItAqRSgZQrzqFXYnziAWUddl/Atx2f+2lF1pL
         L2SeXVcH9RmLQrzFKHMuSLe6jmU+g9gNTl4HlX7pqM23zv2v+VlwppCKEXU6Vjv6NUWH
         4O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiJAJE4FfD2rP9SWjzqbnFHQ/bHKat6AXGbjwcc7HFo=;
        b=bt5OupqnJr8vgMRmNmrzqaxz1qqobFsfDbS08tDU1zilGsPPxO4emsqPVHOISSzPRz
         cpp9FIjhu880h110+yo1ZLz8uI2wo140pP74hDldyKVcNaxz1IrU/XlZ5Ql/CL7iR8uC
         +G6Q6UjPcsmky0PYKOTlU8DV+/x/+ip4uG2kNuW37Xtep6PAikZIQR6hyVAGXUQsfqpc
         SZl3dvqJpkUVpC5BkxJ/272hA9k3GXcJMNhoY3++Vn61Ys0ZQspajUDkkRemtz70ymIJ
         BeTmplpYo0DSXKqyFCh1k+LhsyHlrjuCVg2WgL5klGBeCATIYxlCKs3jfgMAkVrteYNM
         JvHA==
X-Gm-Message-State: AO0yUKW9T/ws7fzKm7wde0ufZOgazDkx/2hVHkHUtJidGvo9TzQEJLub
        jTwREnXNCKJW1HN1W2T7LTw=
X-Google-Smtp-Source: AK7set+FmmnR59fo7+AhCHq+cZVoCA2m0qURuz0M3GPKWHptCix0hKrRJYiJdaJABzSvxgvdCN3T4A==
X-Received: by 2002:a2e:964f:0:b0:28e:732e:206a with SMTP id z15-20020a2e964f000000b0028e732e206amr6722836ljh.12.1677317715504;
        Sat, 25 Feb 2023 01:35:15 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a28-20020a2eb55c000000b0029352fc39fbsm106272ljn.63.2023.02.25.01.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 01:35:15 -0800 (PST)
Message-ID: <71d17152-ad12-1465-2a5d-4dbe98057ca3@gmail.com>
Date:   Sat, 25 Feb 2023 11:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
 <20230130130231.000013b6@Huawei.com>
 <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
 <20230202165714.0a1c37ac@jic23-huawei>
 <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [low prio, just pondering] About the light sensor "sensitivity area"
In-Reply-To: <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/6/23 16:34, Vaittinen, Matti wrote:
> On 2/2/23 18:57, Jonathan Cameron wrote:
>> On Tue, 31 Jan 2023 09:31:53 +0000
>> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
>>
>>> On 1/30/23 15:02, Jonathan Cameron wrote:
>>>> On Mon, 30 Jan 2023 14:04:53 +0200
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>
>>> As a side note - I had always thought measuring the light is just simple
>>> value reading from a sensor. I never regarded the fact that human eye
>>> sees only certain wavelengths or that the sensors sensitivity changes
>>> depending on the wavelength. It's funny how I always end up knowing less
>>> when I know more ;)
>>
>> Light sensors are a pain in many ways!  We've had a few datasheets over the
>> years that have insisted that the color channels have well specified units
>> despite there being no such definition that I'm aware of (and no means
>> to define one for cheap sensors. What is standard Red? :))  All the
>> illuminance values are just approximations to the official curve.
>>
>> Sometime in the past we debated trying to describe the curves, but it's
>> hard to do as they aren't nice shapes (so 3DB points don't make much
>> sense).

This is a low-priority mail with just some very initial pondering. Feel 
free to skip this if you're in a hurry.

I guess the problem of telling what the sensor values represent for 
sensors where the sensitivity is a poor match to a colour has been 
dwelling in the background :)

I don't have any long experience on these devices so I have seen only 
couple of the light sensor data-sheets, and mostly just for ROHM 
sensors. Maybe this is the reason why the common thing I have seen in 
these data-sheets representing the sensitivity to wave lengths has been 
a "spectral response" curve. All of the data-sheets have represented a 
curve where "sensor responsivity" is in the Y-Axis and wave length at 
the X-axis. And yes, in many cases this curve (especially for a CLEAR 
light) is of arbitrary shape for example like this:




S                                           ***
e                                      *       *
n                                  *            *
s                        **       *             *
i                   *       **   *               *
t                *             *                  *
i              *                                  *
v             *                                    *
i         **                                       *
t      *                                           *
y    *                                             *
    *                                                ***
   *                                                     ******
  *                                                            *
  *                                                            *
400		500		600		700		800nm
                W a v e l e n g h t


Having this in mind it seems to be impossible to have just one or a few 
categories of sensitivity, or to describe it accurately by just some 
"peak-sensitivity" wave-lenght and a value representing "width of the 
curve".

So, maybe we should abandon the idea of having a great categorization / 
abstraction in-driver or IIO framework (other than the R,G,B,C,IR,UV - 
which works fine for some sensors). What I could think of is providing a 
set of 'data points' representing the sensitivity curves. Say, we had 
in_sensitivity_wavelength_calibpoints and 
in_sensitivity_wavelength_num_calibpoints (or what ever could fit for 
the IIO naming scheme) - where user could get sensor provided datapoints 
that represent the sensitivity as a function of wavelength. Userland 
could then decide the best curve fitting for the data-points and compute 
the sensitivity according to the best available algorithms. I think this 
kind of curve-fitting-to-datapoints is quite standard stuff in the 
user-space these days - but it feels like an overwhelming task in the 
kernel land/drivers...

This all is just some pondering. I do not have a proper use-case for 
this kind of a sensitivity curve data as I work for a component vendor 
instead of doing actual systems utilizing these components :/ It's 
actually a little sad as I seem to keep thinking what kind of a device I 
could build using these components - just to end up noticing that I am 
not in a position where I was building these devices :p (You wouldn't 
believe how cool imaginary clocking device for driving a camera clock 
with light sensor detecting flickering I just designed in my head the 
other night XD).

Well, I still hope I can help creating device driver/framework stuff 
people can use to build devices - in the end of the day it will also 
benefit the component vendor as the components are typically used in 
these devices ;)

Oh. Got carried away. Anyways, have you considered just offering an 
entry with sensitivity data-points instead of offering wavelength and 
3DB-limits? Do you think that could be useful?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

