Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8514628B8
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 00:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhK3ABr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 19:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhK3ABq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 19:01:46 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33EC061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 15:58:27 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id i63so37639681lji.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KO5mECkLTd2/Kq731LEEyhx3Wv0rLfRhbeL+5NL+Auw=;
        b=t/Sk9qoSIpY+D/g0bC75CtVl+X562DwRCB0UBciMfxFRCQTEH2TQBOBSA2BEsqagrt
         9KsXSwDfN7X5n25KYyCwenAZuhTFacEJqlqVYHGxoRhyUCxJ7CH/rgwU4XUo2sO6+cln
         y7TcuG7slwdX8vYS62ONJ4rNdfJKjKgyOAafdeKwQ11oTfwwp1dujsmyWFVEz8/byHSv
         EwN/FBQV0bbSTUQ5jGmdeJSrIaDnbx4THnqDmwR/qzceBF+4MByLBRWY5zE2pxObq/wn
         t1r20hd51kjCVvKmUxIHBJcNsjjuDW/xuTEGZauzu0zMI5zaWNCXtGr4+p3sTan7iNZK
         qhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KO5mECkLTd2/Kq731LEEyhx3Wv0rLfRhbeL+5NL+Auw=;
        b=ZiQd2jY3yLw2fcBXhjZq3emp3KX42Vxdn8sfw3qjaAOES1IQ3qRdoWObfy0tC7JLUI
         CSe9OJi4X+LRexUXkJRKCiOI/uarlAdI6JdJm6ozzzKWsaeVkfL1obWMhQiCGTSI+toV
         J3shrxwvyXpQGco4QlgdeY/+3FggIhHOfEAHm7NpAQufrLa8SQUIG/DlzW7ZP20WII2f
         kwDUwgrwAvJ9FB0SpnVEMdMmAdYCLXAD/3N+5AcOh0t82UGBbuPPIX+p2B5Qam/N9XkP
         mXCERGIELt3fRjTlHcmGRK1cLaH33ZvSytSiveU64WfBwkHaSvr+6YP1aP1WPi72+WxJ
         svjg==
X-Gm-Message-State: AOAM532bOGXQddfqSRjcR7dQ7V4/4p//qTCJ6znIGFUd9MvjRgSmuLQa
        swNxeWILH6nuAEDYeHiyiBPWPw==
X-Google-Smtp-Source: ABdhPJyvpfx18asoOVpqIvpZYLuiQKQKGgTOPY82cdOcbsWzVcBYMSCSWlYJJDwBObmlgHvBOFVIYg==
X-Received: by 2002:a05:651c:1503:: with SMTP id e3mr52429897ljf.182.1638230305766;
        Mon, 29 Nov 2021 15:58:25 -0800 (PST)
Received: from [192.168.1.213] (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.googlemail.com with ESMTPSA id j16sm1504681lfe.4.2021.11.29.15.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 15:58:25 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Quentin Schulz <foss@0leil.net>, linux-sunxi@lists.linux.dev,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
Date:   Tue, 30 Nov 2021 02:58:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(added linux-pm@ list and maintainers)


Actually, on second though, I think it might be doable to add voltage to 
temperature conversion to this driver.

I think since the NTC thermistor belongs to the battery, not charger, 
the thermistor should be described in monitored battery node.
So I propose to extend battery node (power/supply/battery.yaml) by 
adding something like:

thermistor-resistance-temp-table = <25 10000>, <35 6530>, ...;

This driver will then interpolate between points to report temperature.

We can also adjust PMIC voltage thresholds based on this table and 
"alert-celsius" property already described in battery.yaml.

I think the driver should report raw TS voltage as well, because the TS 
pin can also be used as general-purpose ADC pin.




22.11.2021 14:35, Samuel Holland пишет:
> On 11/22/21 5:17 AM, Evgeny Boger wrote:
>> 22.11.2021 13:49, Maxime Ripard пишет:
>>> On Thu, Nov 18, 2021 at 05:12:33PM +0300, Evgeny Boger wrote:
>>>> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
>>>> TS pin. axp20x IIO driver now report the voltage of this pin via
>>>> additional IIO channel. Add new "ts_v" channel to the channel
>>>> description.
>>>>
>>>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
>>> Would it make sense to put the resistance in the DT as well or is it
>>> made mandatory by Allwinner?
>>>
>>> Maxime
>> Well, I don't think so. Basically, by default AXP20x injects 80uA
>> current into the TS pin and measure the voltage. Then, there are
>> voltage thresholds to stop charging if the battery is too hot or too
>> cold. The default thresholds were calculated by the manufacturer for
>> default 10k resistance and 80uA current. Finally, if TS pin is
>> shorted to GND, the AXP2xx will detect it and won't shut down
>> charging. Note that AXP2xx doesn't convert the measured voltage to
>> temperature.
> Agreed, since the ADC driver only works with voltages, the resistance is
> not relevant to it, so a resistance property does not belong here.
>
>> So while it's possible to use AXP2xx with resistance other than 10k,
>> it will require us to override these protection thresholds.
>> Moreover, if one want to put the actual resistance in DT, then the
>> driver would need to calculate these protection thresholds based on
>> NTC parameters and injection current.
> That means we do need a resistance property for the battery charger
> driver, because it does need to calculate temperature.
>
> Regardless of the reference design, the resistance is variable in
> practice. At least some early v1.0 PinePhones shipped with batteries
> containing a 3 kOhm NTC. And the battery is removable, with an
> off-the-shelf form factor, so users could install aftermarket batteries
> with any NTC resistance.
>
> Right now, people with these batteries are disabling the TS; otherwise
> the PMIC refuses to charge them. It would be good to re-enable the TS by
> coming up with the proper voltages for the min/max thresholds. And there
> are power supply properties we can use to expose the current temperature
> and those thresholds to userspace (at least as read-only).
>
> Regards,
> Samuel


