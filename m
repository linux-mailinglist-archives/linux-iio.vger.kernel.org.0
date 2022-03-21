Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297404E2FA4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiCUSJn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiCUSJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 14:09:42 -0400
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACE2B1A6;
        Mon, 21 Mar 2022 11:08:12 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc1b.ko.seznam.cz (email-smtpc1b.ko.seznam.cz [10.53.13.15])
        id 7be6592620e80d4f7a4f9578;
        Mon, 21 Mar 2022 19:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1647886054; bh=hIG+XZnMpWDgbwOqfCXDAjb4ztBGpTtgq9+OPkhp6qM=;
        h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
         Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:X-szn-frgn:X-szn-frgc;
        b=jDNRlrk6Wk2Z67iIEct6xoK75RDc77TKJyZRjgt4zyqMLlY2KuS2XNWL9EbJsRlf1
         BsN2C+t4YgwOyDHxDrVMf8CvWXHSWq7ggYUodUtydoM9mM/3N9afkv9JzEfz3Zt+kT
         hsD1V4YsZqmonOyiyT/juUKx9r3PYvQcv0tYuSh8=
Received: from [192.168.88.151] (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay13.ko.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Mon, 21 Mar 2022 19:07:29 +0100 (CET)  
Message-ID: <f8ba569f-d230-92a8-6a56-fbcaf620af36@seznam.cz>
Date:   Mon, 21 Mar 2022 19:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20220310133938.2495-1-michael.srba@seznam.cz>
 <20220310133938.2495-2-michael.srba@seznam.cz>
 <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
 <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
 <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
 <20220320151223.3a9b13bd@jic23-huawei>
 <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
 <20220321150411.00002206@Huawei.com>
 <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
 <20220321174202.00007895@Huawei.com>
From:   Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20220321174202.00007895@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-szn-frgn: <fdd3ab9c-2f1d-418d-8dca-a1aa962050d9>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 21. 03. 22 18:42, Jonathan Cameron wrote:
> On Mon, 21 Mar 2022 16:22:38 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>> On 21/03/2022 16:04, Jonathan Cameron wrote:
>>> On Mon, 21 Mar 2022 09:04:11 +0100
>>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>    
>>>> On 20/03/2022 16:12, Jonathan Cameron wrote:
>>>>> On Thu, 10 Mar 2022 22:24:03 +0100
>>>>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>>>>>      
>>>>>> On 10/03/2022 19:56, Michael Srba wrote:
>>>>>>> Hi,
>>>>>>> the thing is, the only reason the different compatible is needed at all
>>>>>>> is that the chip presents a different WHOAMI, and the invensense,icm20608
>>>>>>> compatible seems to imply the non-D WHOAMI value.
>>>>>> But this is a driver implementation issue, not related to bindings.
>>>>>> Bindings describe the hardware.
>>>>> Indeed, but the key thing here is the WHOAMI register is hardware.
>>>>>      
>>>>>>     
>>>>>>> I'm not sure how the driver would react to both compatibles being present,
>>>>>>> and looking at the driver code, it seems that icm20608d is not the only
>>>>>>> fully icm20608-compatible (to the extent of features supported by
>>>>>>> the driver, and excluding the WHOAMI value) invensense IC, yet none
>>>>>>> of these other ICs add the invensense,icm20608 compatible, so I guess I
>>>>>>> don't see a good reason to do something different.
>>>>>> Probably my question should be asked earlier, when these other
>>>>>> compatibles were added in such way.
>>>>>>
>>>>>> Skipping the DMP core, the new device is fully backwards compatible with
>>>>>> icm20608.
>>>>> No. It is 'nearly' compatible...  The different WHOAMI value (used
>>>>> to check the chip is the one we expect) makes it incompatible.  Now we
>>>>> could change the driver to allow for that bit of incompatibility and
>>>>> some other drivers do (often warning when the whoami is wrong but continuing
>>>>> anyway).
>>>> Different value of HW register within the same programming model does
>>>> not make him incompatible. Quite contrary - it is compatible and to
>>>> differentiate variants you do not need specific compatibles.
>>> Whilst I don't personally agree with the definition of "compatible"
>>> and think you are making false distinctions between hardware and software...
>>>
>>> I'll accept Rob's statement of best practice.  However we can't just
>>> add a compatible that won't work if someone uses it on a new board
>>> that happens to run an old kernel.
>>>    
>> The please explain me how this patch (the compatible set I proposed)
>> fails to work in such case? How a new board with icm20608 (not
>> icm20608d!) fails to work?
> I'm confused.  An actual icm20608 would work.
> I guess you mean an icm20608d via compatible "invensense,icm20608"?
>
>> To remind, the compatible has a format of:
>> comaptible = "new", "old"
>> e.g.: "invensense,icm20608d", "invensense,icm20608"
> Old kernel fails to match invensense,icm20608d, matches on invensense,icm20608.
> Checks the WHOAMI value and reports a missmatched value and fails the probe
> as it has no idea what the part was so no idea how to support it.
>
> Obviously it wouldn't work anyway with an old kernel, but
> without the fallback compatible at least there would be no error message
> saying that the device is not the icm20608 we expected to see.
I'm not sure if that's really an issue?
The old kernel is clearly not handling the compatible "correctly",
since the compatible says that the interface is a superset of
the icm20608 interface, and that using the icm20608
interface will work.
If the driver makes the incorrect assumption that
the WHOAMI being different means the interface cannot
be icm20608 compatible, then that seems like an issue
with the driver?
And I believe the single reason for why catering to
a broken driver would ever be considered is if not doing
so would result in breaking the devicetree ABI promise,
which doesn't seem to happen here.

btw, when this is resolved, I will be sending a v3 with
fixed dt-schema errors now that I managed to reproduce
those errors locally.

Regards,
Michael.
> Jonathan
>
>> Best regards,
>> Krzysztof

