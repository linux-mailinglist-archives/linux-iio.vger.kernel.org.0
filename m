Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7522A1B9
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 00:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGVWB4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgGVWB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 18:01:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242EC0619DC;
        Wed, 22 Jul 2020 15:01:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so1640109pls.9;
        Wed, 22 Jul 2020 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nfmyBUAQL76p5vvykk7yec7Gv8UDJNvuxOk2+zdUHgY=;
        b=V/tlrbNoym0WHCnEm9sclnQ0lEv7YVD4Fmzze6z8Sk7VSx8Exhnrp0Z+qJ3ylnsMK3
         vl9X/yjds5wUdVujgEpopAtqG3yNvHqOyW3Og7IB0TSaqvtY8jhJhiuC4AyeIkD40F3W
         jD6yGDSWih/aw0ERZ3aE02RFaNfWNdXYhUBkp7fRhGw16olrb/vF+dFDPZ4Sgls/BIfP
         aZqizXiQV/3J+TzlHNBVotiRy7GVD0FFP/NVFN8bxsXJjVT5beYIH5IwOHzOaEPdgH1c
         fx/wYQF+I4UOtdrNKmsq4RNuQDs0NOE6K/gxCZSFnYa/XFjBQ9ADZQi9gc0HYas+XHxd
         0iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nfmyBUAQL76p5vvykk7yec7Gv8UDJNvuxOk2+zdUHgY=;
        b=bxkf34zVhpElV9kVRI19rYAJ1qpr5AX8fNvvYubTmF9sSJPuau3OTOizduH0c/tVVL
         20AGutg5TuhBbVglHsHf64b+wjSmhqPh7nRzXr3pCIvzqzGx4U0CVgPaOfynsPASpawm
         7swCo51vy0zOFz1rLjdIiGtxA825NC7hFB/W5eV5q25+o5kF9oWT55eAlu29ogEoAJQV
         T0nRim9RrnrpgHvPyGniJh0cTbezWNr8jRNOor+t/6pm2AXt75g/PXNviPlOPR+2g9Ux
         VgUvnaBGQO8N1yrDw5Ol+IMCW+R3civvO2BfIDBtFrl9bGcgEmIF2Ce3BnHs4Hc3zGDm
         MHzg==
X-Gm-Message-State: AOAM533AYmfcvB0O4kj9fxkk3/RGJ1s19aN+uLLLuKN8ClGywhnze2eU
        sw4MGRGLQMXu8v99NB3+sYg=
X-Google-Smtp-Source: ABdhPJyaLrYut3AxfoVCwPwwSpHlRUyZNYiYZ2GtKKBBhH1njkCyDVQNvoaxeB1RgItgL7tJYA/OmQ==
X-Received: by 2002:a17:90a:2a4d:: with SMTP id d13mr1271253pjg.195.1595455315497;
        Wed, 22 Jul 2020 15:01:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n15sm691052pjf.12.2020.07.22.15.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 15:01:54 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Aseda Aboagye <aaboagye@chromium.org>
References: <20200720202243.180230-1-linux@roeck-us.net>
 <20200720202243.180230-5-linux@roeck-us.net>
 <401aec54-ff21-7e0f-85dc-e32435df2672@collabora.com>
 <20200721142320.GA20067@roeck-us.net> <20200722215220.GA2137556@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <53ab8a45-088d-c7d4-c7c4-46a5aae8f8c9@roeck-us.net>
Date:   Wed, 22 Jul 2020 15:01:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722215220.GA2137556@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/22/20 2:52 PM, Brian Norris wrote:
> + drinkcat, aseda
> 
> On Tue, Jul 21, 2020 at 07:23:20AM -0700, Guenter Roeck wrote:
>> On Tue, Jul 21, 2020 at 01:29:01PM +0200, Enric Balletbo i Serra wrote:
>>> On 20/7/20 22:22, Guenter Roeck wrote:
>>>> +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
>>
>> Any idea for EC_RES_INVALID_HEADER_VERSION ? I am not entirely happy
>> with -EBADMSG: the error is distinctly different to CRC errors.
>> EPROTONOSUPPORT as well, maybe, or something else ?
> 
> FWIW, these (INVALID_HEADER_VERSION, INVALID_HEADER_CRC,
> INVALID_DATA_CRC) aren't actually used on any firmware yet. This has
> been open forever:
> https://crbug.com/787159
> Added here:
> https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/780452/
> 
> Unfortunately, the linked design doc (still in draft) is not public.
> 
> My understanding is that while they're not all exactly the same (CRC is
> different than the others), they are all still supposed to represent
> "corrupt request [from the Application Processor]". EBADMSG seems good
> enough to me.
> 

SGTM, and make sense.

Thanks,
Guenter

> Brian
> 
> P.S. for those added late -- you can grab the whole thread from here:
> https://lore.kernel.org/lkml/20200720202243.180230-1-linux@roeck-us.net/
> or in mbox form:
> https://lore.kernel.org/lkml/20200720202243.180230-1-linux@roeck-us.net/t.mbox.gz
> 

