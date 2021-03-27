Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C658834B618
	for <lists+linux-iio@lfdr.de>; Sat, 27 Mar 2021 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhC0K2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhC0K2E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 06:28:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32269C0613B1
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 03:28:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l3so6577243pfc.7
        for <linux-iio@vger.kernel.org>; Sat, 27 Mar 2021 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4PGTbNdoG+HY2/qTcdV4fTRPwEOaZ+x1HHRRWYY/Hk=;
        b=oQIKGAjuMT8O7JDf00EO9ZsTH2LXkJZY4mec4F96fChZjZfSLKaw560bMarFXmpcpp
         TScF8LPcl8/r5UeUSJwQjA9e5a/d+B9dafkWcSYniqtujs+RPF5UIjk+LJe2t/X2cgw6
         RVMOUaOM5dw4eIl3i/wSquWVF+Mk11MkQTG1eHWYInI+rqdZBF7BKwwO7FJZeDxEobvk
         lm8dTwPYkPCtIZydqz1ZNNOijFG6vaZbxa3TznATnu0wQz4Uqo68I0Ct9Hre6bnjYWK8
         6Hhl2dSVSZHb+TM/J0f+vFz4c7W9niTLwAPLhxtfh/vNTrjC63aHtuSAkntdaBS7tGMk
         agtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4PGTbNdoG+HY2/qTcdV4fTRPwEOaZ+x1HHRRWYY/Hk=;
        b=rnm6gCNZAVx64L1Hak9ovrO/qtZeIg7a0O7JtdTedV8X5yrY7/1l+4MJOxVWrCS3l5
         ovBJ/RDWYDCAq9+M+F6XAIj1+B3NC082CAWmpmqqgEQrbGTT9l88oym309GZFe5FlfTF
         1R/JjPBSq18XAjCoCpo30AKplctHALnZ7AMOBA6dIAt/lVvGl/k3v9VgVD7rty+2cNhg
         IYHfBVqvOYOaq+F9r5QigP/kBxLk1Il+N19PETg0iZl+vfrfcOxBK7I6HZHsJCoCA9JA
         q9X72TiTLtvaUYAm+6XhwIzl4sZxJTOsv/yJs5x9d7/Bmg0/GasNt+7/qxV98UUiq/C/
         g8WQ==
X-Gm-Message-State: AOAM53000MjNWVP2wKLODRbQeytdcYWjpaMRFDetSIoGepmdBhpON6x9
        C79wLDcfIi5IWfTtukNYPH0=
X-Google-Smtp-Source: ABdhPJypchjfNorAkmAIHJsAkd33J6rzm/MFVq65JzIv7vBGZumy2RAg9IKMylgD7FEHSxNVG46jbw==
X-Received: by 2002:a63:494b:: with SMTP id y11mr15688922pgk.99.1616840883435;
        Sat, 27 Mar 2021 03:28:03 -0700 (PDT)
Received: from ?IPv6:2409:4072:183:1c64:881a:3344:4c61:9a4b? ([2409:4072:183:1c64:881a:3344:4c61:9a4b])
        by smtp.gmail.com with ESMTPSA id s3sm11671973pfs.185.2021.03.27.03.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:28:02 -0700 (PDT)
Subject: Re: [RFC] GSoC'21 IIO project: Mugil
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
References: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
 <CAHp75VcP8CbJ7w-9LjAvg4scKVNtMaMfqzS7umtXhWVnVavmwQ@mail.gmail.com>
From:   Mugilraj D <dmugil2000@gmail.com>
Message-ID: <98c35f3c-59dc-c2f9-bab5-151bfa3c5fac@gmail.com>
Date:   Sat, 27 Mar 2021 15:57:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcP8CbJ7w-9LjAvg4scKVNtMaMfqzS7umtXhWVnVavmwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 26/03/21 4:37 pm, Andy Shevchenko wrote:
> On Fri, Mar 26, 2021 at 11:53 AM Mugil Raj <dmugil2000@gmail.com> wrote:
>>
>> Hello All,
>>
>> [Dragos here you have a quick intro about me if you want,
>> https://lore.kernel.org/linux-iio/CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com/]
>>
>> For GSoC'21 IIO project I would like to choose  AD4695/AD4696 device
>> for implementing the driver.
>> I referred Analog Device, Inc.'s page that lists all drivers and
>> their kernel tree, but there is no existence of any compatible drivers
>> for this component.
>>
>> About AD4695:
>> - 16-Channel, 16-bit 500 kSPS SAR ADC
>> - "Recommended for New Designs" phase
>> - SPI digital output
>> - Datasheet in [1]
>> - Product overview in [2]
>>
>> Is there any other factor I should consider before choosing a component
>> to make a driver for?
> 
> I would consider the "popularity" of the component, e.g. how many
> questions on SO or similar forums about the component, how many
> (broken, ugly, etc) drivers are floating around.

I searched about it but unable to find any device. If you 
have any such device please suggest me.

>> Do I go ahead with AD4695  in my
>> proposal? If yes, are there any recommendations/suggestions you'd like
>> to provide for a beginner indulging in making a kernel driver for such a
>> component?
>>
>> Thanks,
>> Mugil
>>
>> [1] https://www.analog.com/media/en/technical-documentation/data-sheets/ad4695_4696.pdf
>> [2] https://www.analog.com/en/products/ad4695.html#product-overview
>
