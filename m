Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AF36A2D4
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhDXTpa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 15:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhDXTp3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 15:45:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C764C061574;
        Sat, 24 Apr 2021 12:44:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q22so19912532lfu.8;
        Sat, 24 Apr 2021 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mO3sollJXZniXSf0grEoONPkmuT+3IbFGgVs9iYyV8E=;
        b=pvfFOoGhgD3fJNBowis2wY9x0DEqAj80crAq3qOlg9WJbbUKnUd9v0gXwFImHVOD1K
         uEMb10HNan7vcrfZc7iXdJQoyIj1srf/oCkfcSHatmcHDxa8tNnhn350O4QEzifpwmIi
         4f3+771ygsS9+2mqlQJhunTd30V4RpVI9nimLA+9Oh/hH1/MFEeJKhr8KmvRBv73BUK5
         vCZfILXCBL/JL6jPztA9viZ0N+wmg9E8bQcmQYLBigfZ3wxSiBGBrva8SUJh3JZWdli8
         eMLynngnH9oZmKnysrqYPl8S96Q3n+naUYZdwASTN0a57PXCBRUx1qblToZwSjV4gMTi
         DjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mO3sollJXZniXSf0grEoONPkmuT+3IbFGgVs9iYyV8E=;
        b=Va/glmU7LYNZ5ulUn2aPYKSbUFD3c/Lnwk8eNSDz/c3q5NbJj5yLKawg0K5rjFYnXv
         Z55NXTATG1Z9pv8xF+9aqdk05qOZtIuB6eouFpBv/VXRY9M5z49O2mcbnP9mxWxhI6jI
         V816CxoXqePtfuAtcXzoBwO2vb+BVkHiFBrm2b8ZsGgZRPaefbXNMhwoVY2xuXa21uyK
         sRG7XGACq7iRzYX0uGzCEIu9JiZzZmCPQF7D0/WMTs2n6j9r5lMXdQY9Eo9pFUlY1kdn
         lH0k4/Z2BaoIilarH29rJIx8K+iZAHn5AiTotfhysckMg+5lwrGg0n6wU40cmVdFiZ+B
         aQXg==
X-Gm-Message-State: AOAM530a9KgMpNW52yEROWPuIZ3388vds1z3xHZvegjNTmj3bQbFIDq6
        e51JJZ4m0ZkfM1ZDGizFgaABlnwdRx4=
X-Google-Smtp-Source: ABdhPJwYk9mTutWRrKfeRp0qlc/0icenaV/0c0ne4PejCC1OSrEePMsevvkneNprURiXoLlPpefoUg==
X-Received: by 2002:ac2:4c85:: with SMTP id d5mr6924076lfl.79.1619293483582;
        Sat, 24 Apr 2021 12:44:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id z10sm927974ljz.71.2021.04.24.12.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 12:44:43 -0700 (PDT)
Subject: Re: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210423020959.5023-1-digetx@gmail.com>
 <BL0PR12MB5011563BCD5E11683D51F34EC4459@BL0PR12MB5011.namprd12.prod.outlook.com>
 <edd85a7f-4c1f-9d2f-0425-93a6e45f13bb@gmail.com>
 <20210424114650.6abb21a0@jic23-huawei>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9be008bf-e0b2-65b3-ced8-99d7097a5a41@gmail.com>
Date:   Sat, 24 Apr 2021 22:44:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210424114650.6abb21a0@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

24.04.2021 13:46, Jonathan Cameron пишет:
> On Sat, 24 Apr 2021 07:58:08 +0300
> Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> 23.04.2021 13:14, Jean-Baptiste Maneyrol пишет:
>>> Hello,
>>>
>>> thanks for this work.
>>>
>>> Temperature value should obviously be 16 bits signed, thanks for the fix. By looking at our internal datasheets, I can confirm the values for MPU-30x0 family (div by 280 and 23000 offset LSB).
>>>
>>> I'm sorry I don't have access to these more than 1 decade old chips, so I cannot test on my side. But there is no reason it wouldn't be OK.
>>>
>>> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
>>
>> Thank you very much for confirming that the equation is correct, very
>> appreciate that.
> 
> Thanks. Applied to the fixes-togreg branch of iio.git.
> Note these won't go upstream until after rc1 but hopefully will soon after
> that.
> 
> Thanks for the detective work etc on this!

Thank you.
