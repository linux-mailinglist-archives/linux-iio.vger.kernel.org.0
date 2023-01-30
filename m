Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F78680CE1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 13:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjA3MFy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjA3MFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 07:05:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2901421D
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 04:04:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n6so8065453edo.9
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 04:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlmCKryd0TCPUKJmzeUsfMUXX3bWYASbG2BZCu/nQ2Q=;
        b=ihvZW5fYcITMq929Dky1UQ2FUPEu6gwQVDACQG4AYfqJ5s55Lhpv/BBzQOX0HSKY2P
         QioqhV9P9299OFPGGP3m2jJJ3JDuOxr82bzdPjuM5hVO3HQsCdVbIVFGbgFFYz8xjMMI
         qcWzRYkyG9tQlVsBtC5erAueVGacD2h4nwXqDG05TqFruurDuXd+bsUwwSBzPPTmvHhg
         Lvght/cwNL748ZMJy7Z+kT36dbX4Xmqkb8lv9RNgwGBKZhT//NJZ++H62dHxGotm0Xd5
         Jem7YBvESag1LGvA2TYokrpIzacK6X93hqxl9yVXIaXLvrAqwo09/Ksj6kjm09qOocKh
         JP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OlmCKryd0TCPUKJmzeUsfMUXX3bWYASbG2BZCu/nQ2Q=;
        b=3O9wI+wHjyGnJeWWF6WJV7lbLhBzCiKB9santzv9aKrrce28eQh4yVRt9uZoW+0qLc
         vGwbVzsGy6idmoCSQQJeuyQJMakdI/6zWHROTZj41/qTHu1zc2x4Z1t+H/AL6iYC9nCU
         +sM8D7vBguAm2EGFgQBy7JGW0W8n2bibFyzwdZRbiXW99w6vaFmoJaLLknO1ttg44+c7
         oUEQWBdRl5w3eRqst0jAxOpKmyO0STbfOlVJmdt0z4gAM4JVEi7YcJT2H06Bu/AsmH6v
         m2fqpKwmUaWtocP1FaWWxZyV6Jwwx6y8iIoUeQJAmcy4KAKALxKJ5qsP7JclFrM3d8GC
         yt3Q==
X-Gm-Message-State: AFqh2kqBYs4CQR33f/cO9AogXYxtpDZQ6srEiHfXZWlECmQEpyuQuAE+
        Uo45N53owaXxOHDWJvJlG+U=
X-Google-Smtp-Source: AMrXdXtP+ojpQz6BdIUXy+uOtzV4mHWDnuFFxsDC1RvS2/LJM5TbBWTRhfVshgF7GdVpPXbebXkcng==
X-Received: by 2002:aa7:c045:0:b0:49e:4254:60a9 with SMTP id k5-20020aa7c045000000b0049e425460a9mr50315549edo.29.1675080294757;
        Mon, 30 Jan 2023 04:04:54 -0800 (PST)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id ay10-20020a170906d28a00b00882f9130eb3sm3679874ejb.223.2023.01.30.04.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:04:54 -0800 (PST)
Message-ID: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
Date:   Mon, 30 Jan 2023 14:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, en-GB
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: ROHM ALS, integration time
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

Hi deee Ho peeps,

I am currently writing drivers for couple of ROHM light sensors. At 
least two RGBC+IR and one ALS. I have some difficulties deciding how 
some of the IIO API values should be mapped to the sensor configs. (So, 
not missing much, right? Basically just THE THING any IIO driver is 
expected to do XD).

Okay, that's for the intro. I'll ask about the ALS first.

=== The Hardware:

The sensor gets the data from 3 photo-diodes - values from each are 
readable via own channel (say, data0, data1, data2).

data0 and data1 have the sensitivity peaks around 500 and 600 nm - which 
is visible light but channels are not really R/G/B. The data2 is 
probably IR - but I am not really 100% sure so I plan to skip it at first.

The channel gain can be set individually,. The sampling time can be set 
globally for all channels.


=== The driver draft I'm working with

I have some kind of formula for converting the channel0 and channel1 
data to lux. So, I thought I'll provide 3 channels from driver - one 
IIO_CHAN_INFO_PROCESSED IIO_LIGHT channel spilling out luxes (with 
appropriate scale) - and two IIO_INTENSITY channels spilling out the raw 
register values so that if greater accuracy is needed one can do better 
algorithms to user-space.

Q1 - does this sound like reasonable option?

Then, I thought I'll support setting the GAIN for channels using the 
IIO_CHAN_INFO_SCALE. Straightforward division / multiplication (I hope).

Eg, for the IIO_INTENSITY channels I though I'll just implement 
raw_write/raw_read for scale so, that raw_read returns 
IIO_VAL_INT_PLUS_NANO - and then for example gain 4x would be
val = 0, val2 = 250 MEGA, 8x would be 0, 1 * GIGA / 8 ...
Eg, val2 for gain values > 1 would be GIGA/gain using IIO_VAL_INT_PLUS_NANO.

I hope this makes sense :)

Well, currently my "not-yet-implemented using C w/o floats" - algorithm 
takes the scale into account and always returns luxes (for 
IIO_CHAN_INFO_PROCESSED IIO_LIGHT - channel). However, the IIO_INTENSITY 
channels return raw data from registers - so setting GAIN (scale) has 
direct impact to the INTENSITY values. I guess this is Ok as the 
IIO_CHAN_INFO_SCALE is only set in .info_mask_separate for the 
IIO_INTENSITY type channels - not for the IIO_CHAN_INFO_PROCESSED 
IIO_LIGHT channel. [Even though I decided to go this route I am still 
somewhat unsure if this is the right thing to do(tm). My problem is that 
in HW level, setting the GAIN does also impact the data based on which 
the IIO_LIGHT values are computed. The scale just is not visible in 
computed values as it is taken into account by the equation. 
Furthermore, setting GAIN(or scale) for IIO_LIGHT would not be 
unambiguous as the IIO_LIGHT is composed from two channels, both having 
own gain settings.]

I hope this is all Ok from interface POV.

Now, finally, my dear persistent readers - the question:
As mentioned, sensor allows setting the sampling time. I thought I'll 
map this to the IIO_CHAN_INFO_INT_TIME. This config is not per/channel 
in the hardware. Again, my lux-computing algorithm takes the integration 
time into account - and changing the time should not be reflected to the 
IIO_LIGHT channel values (other than accuracy). However, the values 
spilled from raw IIO_INTENSITY channels will change when integration 
time is changed. So, should I use the info_mask_shared_by_type = 
BIT(IIO_CHAN_INFO_INT_TIME) for IIO_INTENSITY channels?

Sorry for the long post. I do appreciate all help/pointers on my journey 
to writing my first light sensor drivers ;) And yes, my plan is to send 
out the patches - when I first get the sensor hardware at my hands ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
