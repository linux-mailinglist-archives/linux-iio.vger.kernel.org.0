Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419F468A65
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhLEKyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 05:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhLEKyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 05:54:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBEAC061751
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 02:50:44 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i63so15318664lji.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Dec 2021 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2s+VwgSqLqvkFO3wYIggCnaS4ihJvSlM944/U7Hrs1s=;
        b=w4yffush2DrvoU77h+0CwkxMF1i8hvsyKLfm2H7bf0L12rO234gPgRH1JTP+PWwmVX
         IrRQHEt/dlwQ3oJxrTPxabG6Nqhuhw5cm3vZ+9cmXbLvyCkp4y+wbwiIddyI15euUTFs
         LMuqpdFUVSNRJPqIqepb9CH9R44jlxkk34RFEstj3iHfB+qGb8uFWkpGmlRj9m42eDwr
         dUe3w1EcHZeJGtHlcR2r1gLsSuCSADB/Y3jbWR5ih2b2OUM6Bm+8TgfEkrBuOXbST3xf
         woULq9moiOe66Ur4zmyspBwWquWhiF0VGj77Zly3JHAn4/x7+Rf6yBanROBd7ZhfdOhS
         CtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2s+VwgSqLqvkFO3wYIggCnaS4ihJvSlM944/U7Hrs1s=;
        b=MQnAata8SYEBz8KOHCQEZeIsiLoJE5QsGQDISydf60hoD56tMLfYawrt4SEKdX3P1k
         woiRIehpGoLgzFboQ9/lNwE1QRwEHD307InF3xSB43OV2HW3b3J4OdC3rcal3pV+VOVx
         ZlLZQZ+V1Vh5iNVoEUth+s92lS2e2wwKWpCZGvK1lHkAVhzlbn9q2koszWLs+RNh8l2C
         WXZsEB1GaPmkpqwd5pMDzh0Eq7dY1eJr1QLWbdVrphih1yUQVtIXY/sh+1Xa/V95lN7H
         BwsxmWlBIkyr1EMt6FbKMjKcXoZXGifjgfioRipkaA8O+95IFsUah5ttp/krLlqMe6Ts
         YLtQ==
X-Gm-Message-State: AOAM533KmsOuvPCzP1rgPzUVZnq9hsI+SB08+eiPUXqPmVqH2ANnh0VE
        fjp4oQUICfXnHD7x1ZIu+i+NLQ==
X-Google-Smtp-Source: ABdhPJxfihr3Fi6TaU5fQnGybICickaoNBBFCHrcjLqorb6H7LfDDlD/mDM1RkbUqZoMHrjNTsUiFQ==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr28842986ljc.44.1638701442018;
        Sun, 05 Dec 2021 02:50:42 -0800 (PST)
Received: from [192.168.1.213] (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.googlemail.com with ESMTPSA id h6sm1046507lfv.202.2021.12.05.02.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 02:50:41 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
 <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
 <20211201110241.kts5caycdmzqtp3i@fiqs>
 <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
 <20211203204754.2ucaiiwyrvbtwgbz@earth.universe>
 <20211204152621.4f15b3d0@jic23-huawei>
 <CACRpkdZ+WWz7JoyE3a1Ra8dx27YcHH6zRNcTmNJyX_vfcu0n7w@mail.gmail.com>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <a45c37e5-caa3-e5e4-62d2-e2418ed95441@wirenboard.com>
Date:   Sun, 5 Dec 2021 13:50:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ+WWz7JoyE3a1Ra8dx27YcHH6zRNcTmNJyX_vfcu0n7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus!

05.12.2021 04:02, Linus Walleij пишет:
> On Sat, Dec 4, 2021 at 4:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
>> If we were going to do something like this, I'd see the battery as a
>> consumer of the the temperature measurement from the NTC (might also consume other
>> things from axp directly).  So it should be
>>
>> Temperature / events flow.
>>
>> battery <---temperature----- NTC driver <--Voltage----   axp
> That's the idea.
>
> I think the battery will get a handle on a thermal zone and then
> you get the temperature from that.



>
>> Threshold configuration flow
>>
>> battery --temp thresh-----> NTC driver ---volt thres--> axp
> I don't understand this so not commenting.
>
>>>> Personally, I think better approach with NTCs is to place the
>>>> resistance-temperature tables for bunch of models to .dtsi
>>>> files, describe the thermistor node in DT and then make all drivers (hwmon
>>>> NTC, iio-afe, this one) to use this data in the same way
>>>> it's done with monitored-battery node.
> The DT maintainers are not happy about the device tree being used
> as a general data container. The rule of thumb is that things that are
> configurable should be in the device tree, things which are hard data
> from a datasheet should be in a struct in the driver, and the compatible
> string tells you which data to use.
>
> For an NTC the resistance-to-temperature is a clear case of data from
> a datasheet and should not be in the device tree but in a table in
> the kernel.
>
>> Agreed those tables would be needed whatever the solution.  We might
>> stick to 'standard' tables for simple cases but someone will always wire
>> a circuit up that does something we haven't thought of.
> What we usually do is model the wiring in the device tree like we (I) have
> already done with much pain in:
> Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
Earlier in this thread I mentioned our use case with AXP221s: we ended 
up wiring 10k NTC in series with 12k fixed resistance.
The only reason was to work around poorly-designed AXP NTC detection 
"feature", which would turn off protection whenever
the voltage on TS pin drops below 0.2V.

How would you suggest to handle such a wiring?

>
>>> Linus W. recently sent a series for NTC support in power-supply
>>> core, please synchronize with him (added to Cc):
>>>
>>> https://lore.kernel.org/linux-pm/20211122234141.3356340-1-linus.walleij@linaro.org/
> For the type of battery described in
> Documentation/devicetree/bindings/power/supply/battery.yaml
> a thermistor node inside the battery will be needed and then code
> added to the power management core to spawn a OF-based
> platform device from that.
>
> battery: battery {
>          compatible = "simple-battery";
>
>          ntc-resistor {
>                  ...
>          };
> };
>
> For the Samsung batteries my plan is to spawn a platform device from inside the
> Samsung battery driver and add pull-down resistor value and
> compatible using software nodes from within the kernel.
In this example, the ntc-resistor node will be handled by current NTC 
hwmon driver, right?
Frankly, I'm quite confused about hwmon vs iio choice in this case.
Wouldn't it be better to use iio here, say, by extending iio-afe?



>
> Since I already have the compatible of the battery itself, I know
> which thermistor this is and how it is mounted with an ID resistor
> as pull-down and Samsung batteries can just hardcode that from the
> kernel without
> modeling the resistor in the device tree at all.
As for pull-down it's the same for AXP, the only difference is there 
will be fixed injection current instead.
But you still need to describe the particular NTC model in device tree, 
right?
>
> Yours,
> Linus Walleij


-- 
С уважением,
     Евгений Богер / Evgeny Boger
     CTO, Wiren Board Team
     https://wirenboard.com/ru
     +7 495 150 66 19 (# 33)

