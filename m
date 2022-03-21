Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EB4E2C15
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 16:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbiCUPYK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 11:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350108AbiCUPYI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 11:24:08 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B301168DE;
        Mon, 21 Mar 2022 08:22:41 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id b19so21157349wrh.11;
        Mon, 21 Mar 2022 08:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3abe80l9msZOhwxOubLxAre+q+fnEX/6XNWvjvUZElY=;
        b=zFaz3E+ag6L9SDKqkHEK+hByAsVqtWk5ob2H6YUhqxUu6xJD7WIR2twzbE2IPafGwq
         b2k6uSYsrYPBG01+vcRoZCbBGpX5dt6vAXbZ6RaK4gZQ5KvG4sxMH6phJOHgg9ebs09O
         0y9h+4YJR5PTGTPyRCi7oY48ZsQMzCWInPta2LufzNKAUJBlITpmVToporUf3P26lPaQ
         MW0NGEdyTzG3dIRZHwfd2J3tVEbsv5VQuRc8VGSxzIoPjrpwW+yBgCRfF0VMrsv5yc5X
         bR/4i2rP7O5L8QaAFMS1L+Z8SJODZlakIzmYykxnqms5v1FOHpg6CVG7mev+zUiooOFe
         oo1A==
X-Gm-Message-State: AOAM531E3CRhxaL3O94/BSqgIP5jGYtiVACZVLRVbCKkn7vreaM+g7xH
        i+UkVHalOfSFPvG2EEn16jY=
X-Google-Smtp-Source: ABdhPJxGalA37R+AGX12fTKU66XvtKTXi23oNPipCgdiBchO47NP9cFOXlUBspj04cLQSWTSzKUYmQ==
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id t4-20020adff604000000b00203d9cabccfmr18684891wrp.331.1647876159732;
        Mon, 21 Mar 2022 08:22:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id n23-20020a05600c3b9700b0038b7c4c0803sm17375625wms.30.2022.03.21.08.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:22:39 -0700 (PDT)
Message-ID: <47d67c82-788e-2ced-54cc-4959c67922fc@kernel.org>
Date:   Mon, 21 Mar 2022 16:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
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
In-Reply-To: <20220321150411.00002206@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/03/2022 16:04, Jonathan Cameron wrote:
> On Mon, 21 Mar 2022 09:04:11 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 20/03/2022 16:12, Jonathan Cameron wrote:
>>> On Thu, 10 Mar 2022 22:24:03 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>>>   
>>>> On 10/03/2022 19:56, Michael Srba wrote:  
>>>>> Hi,
>>>>> the thing is, the only reason the different compatible is needed at all
>>>>> is that the chip presents a different WHOAMI, and the invensense,icm20608
>>>>> compatible seems to imply the non-D WHOAMI value.    
>>>>
>>>> But this is a driver implementation issue, not related to bindings.
>>>> Bindings describe the hardware.  
>>>
>>> Indeed, but the key thing here is the WHOAMI register is hardware.
>>>   
>>>>  
>>>>> I'm not sure how the driver would react to both compatibles being present,
>>>>> and looking at the driver code, it seems that icm20608d is not the only
>>>>> fully icm20608-compatible (to the extent of features supported by
>>>>> the driver, and excluding the WHOAMI value) invensense IC, yet none
>>>>> of these other ICs add the invensense,icm20608 compatible, so I guess I
>>>>> don't see a good reason to do something different.    
>>>>
>>>> Probably my question should be asked earlier, when these other
>>>> compatibles were added in such way.
>>>>
>>>> Skipping the DMP core, the new device is fully backwards compatible with
>>>> icm20608.  
>>>
>>> No. It is 'nearly' compatible...  The different WHOAMI value (used
>>> to check the chip is the one we expect) makes it incompatible.  Now we
>>> could change the driver to allow for that bit of incompatibility and
>>> some other drivers do (often warning when the whoami is wrong but continuing
>>> anyway).   
>>
>> Different value of HW register within the same programming model does
>> not make him incompatible. Quite contrary - it is compatible and to
>> differentiate variants you do not need specific compatibles.
> 
> Whilst I don't personally agree with the definition of "compatible"
> and think you are making false distinctions between hardware and software...
> 
> I'll accept Rob's statement of best practice.  However we can't just
> add a compatible that won't work if someone uses it on a new board
> that happens to run an old kernel.
> 

The please explain me how this patch (the compatible set I proposed)
fails to work in such case? How a new board with icm20608 (not
icm20608d!) fails to work?

To remind, the compatible has a format of:
comaptible = "new", "old"
e.g.: "invensense,icm20608d", "invensense,icm20608"

Best regards,
Krzysztof
