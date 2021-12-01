Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F184651F8
	for <lists+linux-iio@lfdr.de>; Wed,  1 Dec 2021 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbhLAPtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Dec 2021 10:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351101AbhLAPtQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2021 10:49:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4FC061748
        for <linux-iio@vger.kernel.org>; Wed,  1 Dec 2021 07:45:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id r26so63995235lfn.8
        for <linux-iio@vger.kernel.org>; Wed, 01 Dec 2021 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OE61jU/zTchzfCMCFpCpoIPbZYfQ/f0z3uvdC3qRv3Y=;
        b=jsCkKYayWuWpBldra8IM1e7mKcm43aeTjAm/Tv5v73w2g0eb7/keT9HN+yMTx9wb+s
         4zSE2NyRFOSZEsj5j4HGN0kmZGbV4zHlrFHEZp6LST5FO4vuQvK9qqq/yhvDplL52DgV
         g9CMbaQakPWgDox/9WkR9d3dlOh6voZO2vvrNCF3JsazB8brY4Nk81uq1NdXNH1SSLyy
         Fxhgd7qSiKG5MwzmGVkIYI+d4bp37alwgbM1u3LBcHHHK5G6gn65xJ/EqXpunw0Hu4Qn
         i0l7PDdnb/9ddafGZSQKU8ROgjZ4Hy1ZL/lLNNZ5aqc6X5nNIOP5cpgAipKENW0OE30X
         I1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OE61jU/zTchzfCMCFpCpoIPbZYfQ/f0z3uvdC3qRv3Y=;
        b=xjCpcxXViJz51OeFyg4ZCGdfctfjpXAXEGYSYIfPjFw/dkoHM1wp1gpqt0C98X+XT7
         iHRflfUb3z2tm2uZZFvRIUeE6RZgrlLxDTq5I6RUfv0yMv6yOI0sn8J9ZmsPSun+JMTn
         8SBQ0bo+O/bFJnDis+ZExA1Tg0la/k8BSxsz9fDi7EpPFLMEUovCZpouOKLFCI7MPS1C
         e3TRwo3M6shQU+FNGtjx0HlD6BW8I/BiLenYbWTet4y+bvhLIiUg1G4Esxpj5yCj7H12
         SHZ/iSHuwT98qFSvFlw6QhXKBywUoDv/KS5j+//OOLFA2iPf9U2viHHi4exGIvVts0bu
         4wFg==
X-Gm-Message-State: AOAM533BwZXcGEUXxA1gZvQ9TEx/jRzGYarHlp67Y37PU61u9Qhs7OCq
        Y+nPdo4XDyMnzY1FyZc6970fVW/J4TI6Mw==
X-Google-Smtp-Source: ABdhPJxkv1Hau/UVnCEPDjYxLIx6b4nKUZ188bkpdJ5MvnRMwpUT8DFScEjiy54Z4Nf+5BkeSe/jpA==
X-Received: by 2002:a19:f10a:: with SMTP id p10mr6502817lfh.487.1638373545727;
        Wed, 01 Dec 2021 07:45:45 -0800 (PST)
Received: from [192.168.0.145] (81.5.119.169.dhcp.mipt-telecom.ru. [81.5.119.169])
        by smtp.googlemail.com with ESMTPSA id n17sm18689ljg.128.2021.12.01.07.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 07:45:45 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
 <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
 <20211201110241.kts5caycdmzqtp3i@fiqs>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
Date:   Wed, 1 Dec 2021 18:45:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201110241.kts5caycdmzqtp3i@fiqs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Quentin,

thank you for the feedback!

01.12.2021 14:02, Quentin Schulz пишет:
> Hi all,
>
> On Tue, Nov 30, 2021 at 02:58:23AM +0300, Evgeny Boger wrote:
>> (added linux-pm@ list and maintainers)
>>
>>
>> Actually, on second though, I think it might be doable to add voltage to
>> temperature conversion to this driver.
>>
>> I think since the NTC thermistor belongs to the battery, not charger, the
>> thermistor should be described in monitored battery node.
>> So I propose to extend battery node (power/supply/battery.yaml) by adding
>> something like:
>>
>> thermistor-resistance-temp-table = <25 10000>, <35 6530>, ...;
>>
>> This driver will then interpolate between points to report temperature.
>>
> I disagree, I think it does not make much sense. This is already done by
> the NTC thermistor driver.
> The battery "subsystem" already provides operating-range-celsius and
> alert-celsius properties for that.
> Since the battery is linked to the AXP, all we need is to be able to ask
> the NTC thermistor driver to do the conversion from temperature to
> voltage of the two voltage values we get from the battery and use the
> result as threshold in the AXP registers.
> I wouldn't want to have the extrapolation done in two different places.
>
> I can see two ways of specifying that interation:
>
> battery -------------------> axp --------------------> ntc
> 	min/max °C			request °C to V
> 				 <--------------------
> 					response V
>
> This however would require a phandle in the AXP to the NTC thermistor
> driver and I don't feel like it's that good of an idea?
>
> Another way would be to use the battery as a proxy for the voltage
> request to ntc.
>
> 		     battery --------------------> axp
> 				min/max °C
> ntc <--------------- 	     <--------------------
> 	request °C to V		request °C to V
>      --------------->	     --------------------->
> 	response V		response V
>
> This would require a phandle to the ntc thermistor in the battery node,
> which kind of makes sense to me. And since the AXP already has knowledge
> of the battery, it can request the appropriate value to the battery
> which then proxies it to and back from the ntc.
>
> Forgive me for my poor ASCII drawing skills :) hopefully it's good
> enough to convey my thoughts.
I see quite a few problems with NTC driver approach.

The problem is, I don't know any suitable subsystem for that. NTC is not 
a subsystem,
NTC in kernel is a mere hwmon driver, and also is quite an old one.

Also, we already have iio-afe, which, in a sense, already does pretty 
much the same as NTC
hwmon driver. Maybe using iio-afe is the better idea?
But then, I think that's a very complicated interaction for a simple 
interpolation between points.

Another thing is, in our design we ended up using not a simple 10k NTC 
thermistor, but a 10k NTC is series with fixed 2.2k.
The reason why it's needed is that AXP NTC voltage thresholds are fixed 
at startup time, and if we somehow have to deal
with default thresholds to get different behaviour.  So the 
resistance-temperature curve in our case is different from any standard
NTC. Speaking of "standard" NTC, our supplier has like 15 different 
models for *each* resistance, which slightly differ in
resistance-temperature curve. Adding them all into a driver would be 
strange.

Personally, I think better approach with NTCs is to place the 
resistance-temperature tables for bunch of models to .dtsi
files, describe the thermistor node in DT and then make all drivers 
(hwmon NTC, iio-afe, this one) to use this data in the same way
it's done with monitored-battery node.


>
>> We can also adjust PMIC voltage thresholds based on this table and
>> "alert-celsius" property already described in battery.yaml.
>>
>> I think the driver should report raw TS voltage as well, because the TS pin
>> can also be used as general-purpose ADC pin.
>>
> Since the ntc anyway needs this raw TS voltage and that patch does that,
> I think it's fine. Specifically, re-using this pin as a general-purpose
> ADC won't impact the current patchset.
>
> What we'll need is to have a pinctrl driver for the few pins in the AXP
> which have multiple functions. But that's outside of the scope of this
> patchset.
Should it really be pinctrl, though? Unfortunately the choice will alter 
other
functions as well. Say, if we use TS pin in GPADC mode, we'll have to 
disable
temperature thresholds and current injection.
>
> Regarding the injected current, I don't have enough knowledge in
> electronics to understand how this will change things in the thermistor
> since in the NTC thermistor driver there's no logic related to the
> actual current being injected. Maybe it is related to some operating
> value required by the NTC? I can't say unfortunately.
It's basically Ohm's law, so it's not related to the NTC thermistor itself,
but more to the voltage across NTC that the AXP can measure.
Say, if maximum measurable voltage is 3.3V, than the maximum measurable 
resistance
at the given current would be 3.3V/80uA = 41 kOhm. In case of 10k NTC 
it's about -5C or so.

But again, one can't really alter startup voltage thresholds of the AXP. 
And also, regardless of
settings, at least AXP221s will completely disable TS-based protection 
if voltage on TS pin is below 0.2V.
So at the end, unfortunately, there are not so many options when it 
comes to the thermistor and the injection current.
>
> We can continue this discussion but I don't think this should block this
> patch as I don't see the outcome of this discussion change anything in
> this patchset.
>
> Reviewed-by: Quentin Schulz <foss+kernel@0leil.net>
>
> Thanks!
> Quentin

