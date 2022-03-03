Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B424CB4D2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Mar 2022 03:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiCCCVs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 21:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiCCCVr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 21:21:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A0419B5
        for <linux-iio@vger.kernel.org>; Wed,  2 Mar 2022 18:21:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2378607wmb.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2022 18:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YosZDFeXptiC33UXbPIO0HEuSbJGy65IpZJdV/TWjgA=;
        b=jJLZI5i0Ck0+Hnj3y884WZHhITW8HQovIkoV5aAHRABzbqczKw9z6z+RJ5ewkazcd7
         IHmrZ2zoeDHxaObWeZLJEtPkJT/26E6uBRGaHrEae9SbkZqRMn8KbqoVcHsYZQqUdJr3
         6/4NFCe2idaJZsmnTpiVWS8A+pBL+4icdywp5dezEkQ0j/RqnxPNbgzNDvSGkm2H+PRW
         C/xXpTUJ7wnZ5ZGQFK3t2VyjrpZvmMeJ1YDyUslaipStNJ1yJBG5AZSq7uy6keo2no5v
         gaxU55v49fSFFEg2xrm2f1ALojVkXQzDitOftK0G+QNiIeZMKcpyVR7wXg6Puugvx9i9
         /dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YosZDFeXptiC33UXbPIO0HEuSbJGy65IpZJdV/TWjgA=;
        b=LBknXncQNIMH5qplRPMrPbsVVzozjgoM6w3GCxcRP18oCx9bsHtB6dkmH1JIW2TMDT
         6kT/Kv6D6UdGsUfZKUOzljGSmr89m5WgTNFMS/4itGEfmGPLDjKNdBlGYD7izB4Cnmzd
         ZZLMUSZXVP1B/InE+wQhbJt6s0lngThW55plQEb2CJtkWGlK6gyrdhgMI6/ZhEwsoe8j
         0vlWPKbB/lvzJF4Ai7g7gzSJQta5669kKRX0wpS+w42o/6J7q/rlFKYxePFVUsZHI649
         M59ACPbtKQRH5mKYo3MP6RjUHCi8TNoOu6AFXjP+xYHKCp4wheQetq6DBDwp813JpcPa
         fwCA==
X-Gm-Message-State: AOAM533CQUTSaUCuhtOouRp7xmWMNG+Ahk+36HXdOnT5ti77BMem5Uv1
        Uf8irdfCp4FgUloTOQUzBJeWIA==
X-Google-Smtp-Source: ABdhPJzzoGXhCa62ixTrNDgr3R2pGQv07jzN3IzEfK/mCFmqw7kJa7Z5BTZkznSfdPqdFP/YknehtQ==
X-Received: by 2002:a05:600c:190c:b0:37d:1f40:34c2 with SMTP id j12-20020a05600c190c00b0037d1f4034c2mr1989927wmq.115.1646274059881;
        Wed, 02 Mar 2022 18:20:59 -0800 (PST)
Received: from [192.168.0.30] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k184-20020a1ca1c1000000b0038617ae5297sm2268503wme.33.2022.03.02.18.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 18:20:59 -0800 (PST)
Message-ID: <da96bd50-e346-a20c-de53-561c996e826c@linaro.org>
Date:   Thu, 3 Mar 2022 02:20:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v8 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, kernel test robot <lkp@intel.com>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
 <20220221220743.541704-3-caleb.connolly@linaro.org>
 <Yhft4zNcbD3ojN6i@builder.lan> <YhiYY/sXMvQ4VCZd@google.com>
 <20220225090452.GP3943@kadam> <YhigDPC6r7dTJUXd@google.com>
 <20220225094024.GQ3943@kadam>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220225094024.GQ3943@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 25/02/2022 09:40, Dan Carpenter wrote:
> On Fri, Feb 25, 2022 at 09:23:24AM +0000, Lee Jones wrote:
>> On Fri, 25 Feb 2022, Dan Carpenter wrote:
>>
>>> On Fri, Feb 25, 2022 at 08:50:43AM +0000, Lee Jones wrote:
>>>> On Thu, 24 Feb 2022, Bjorn Andersson wrote:
>>>>
>>>>> On Mon 21 Feb 16:07 CST 2022, Caleb Connolly wrote:
>>>>>
>>>>>> Some PMIC functions such as the RRADC need to be aware of the PMIC
>>>>>> chip revision information to implement errata or otherwise adjust
>>>>>> behaviour, export the PMIC information to enable this.
>>>>>>
>>>>>> This is specifically required to enable the RRADC to adjust
>>>>>> coefficients based on which chip fab the PMIC was produced in,
>>>>>> this can vary per unique device and therefore has to be read at
>>>>>> runtime.
>>>>>>
>>>>>> [bugs in previous revision]
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>
>>>>> This says is that "kernel test robot" and Dan reported that something
>>>>> needed to be fixed and this patch is the fix for this.
>>>>>
>>>>> So even though their emails asks for you to give them credit like this
>>>>> you can't do it for new patches.
>>>>
>>>> Right, or else you'd have to give credit to anyone who provided you
>>>> with a review.  This could potentially grow to quite a long list.
>>>>
>>>
>>> I always feel like people who find crashing bugs should get credit but
>>> no credit for complaining about style.  It's like we reward people for
>>> reporting bugs after it gets merged but not before.
>>>
>>> We've had this debate before and people don't agree with me or they say
>>> that it's fine to just include the Reported-by kbuild tags and let
>>> people figure out from the context that probably kbuild didn't tell
>>> people to write a new driver.
>>
>> Reviews will often consist of both style and logic recommendations.
>> If not spotted and remedied, the latter of which would likely result
>> in undesired behaviour a.k.a. bugs.  So at what point, or what type of
>> bug would warrant a tag?
>>
> 
> If it's a crash or memory leak.  Style comments and fixing typos are
> their own reward.  Basically it's the same rule as Fixes tags.  We
> shouldn't use Fixes tags for typos.

Hi Dan,

How (if at all) would you like me to reference the bug reported by LKP
in my next revision of this patch? It doesn't seem like a fixed conclusion
was reached here.

It seems like Reported-by doesn't really represent things well, perhaps we
could try for "Bugchecked-by" or something like that?
> 
> regards,
> dan carpenter
> 

-- 
Kind Regards,
Caleb (they/them)
