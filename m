Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12044E21AD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 09:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiCUIFl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiCUIFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 04:05:39 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF4EF7B7;
        Mon, 21 Mar 2022 01:04:15 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id z92so15880104ede.13;
        Mon, 21 Mar 2022 01:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=seVgojW/zlWNvrBzb6hrZW5u7TKNx7byPEwEOUQQwbE=;
        b=TAvu4/eHzAOgsdo3OMcl8RTTosOCqLNhsXzbQ8uqq+IrYl82NXNW+0H7NE8/yEkvg4
         MuPQtroj6kbZ7Xat80EcctOSokCWF0uzPWf4WWt6pHK6KQxVV3kLNXIxwgjNUC6Z6eFu
         dBukqM96tVMVr0rlJsbsCeRPwSUpaQjjY7v5oULMNpAuX/rsx/ceajM6G+cHQXPnf5HI
         TLDO40LcLdAG8hfyA6EANTVrrtn6YlszczVQAGJs83w2YkxPKdukeWOA7V8TxRoX9hSn
         3WrglEFgZQS05Plc8rTD+yjqj8oPQCbjKyOCscs++NwxrNDRtySEcSzKnBdAU1AwBGA2
         +rLA==
X-Gm-Message-State: AOAM531Je+Ohl7jtxuWRxNZZJrPuUDQ9SaRxfH/5XFocZyKDLoFTrPiy
        kq9k9+ImgLapjvaauioKZFQ=
X-Google-Smtp-Source: ABdhPJyyJlCtzapDTQNJIkOqJyC7Emqs/orbyZC4z6K6j5clqxhxGwdWlrk7cSYLB9tAUoRV/UVqUA==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr21182658edw.113.1647849853418;
        Mon, 21 Mar 2022 01:04:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id bw26-20020a170906c1da00b006c8aeca8febsm6581091ejb.47.2022.03.21.01.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:04:12 -0700 (PDT)
Message-ID: <ca80bd79-338c-98a4-2f4d-4dcfc52ed538@kernel.org>
Date:   Mon, 21 Mar 2022 09:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Srba <Michael.Srba@seznam.cz>,
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220320151223.3a9b13bd@jic23-huawei>
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

On 20/03/2022 16:12, Jonathan Cameron wrote:
> On Thu, 10 Mar 2022 22:24:03 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> 
>> On 10/03/2022 19:56, Michael Srba wrote:
>>> Hi,
>>> the thing is, the only reason the different compatible is needed at all
>>> is that the chip presents a different WHOAMI, and the invensense,icm20608
>>> compatible seems to imply the non-D WHOAMI value.  
>>
>> But this is a driver implementation issue, not related to bindings.
>> Bindings describe the hardware.
> 
> Indeed, but the key thing here is the WHOAMI register is hardware.
> 
>>
>>> I'm not sure how the driver would react to both compatibles being present,
>>> and looking at the driver code, it seems that icm20608d is not the only
>>> fully icm20608-compatible (to the extent of features supported by
>>> the driver, and excluding the WHOAMI value) invensense IC, yet none
>>> of these other ICs add the invensense,icm20608 compatible, so I guess I
>>> don't see a good reason to do something different.  
>>
>> Probably my question should be asked earlier, when these other
>> compatibles were added in such way.
>>
>> Skipping the DMP core, the new device is fully backwards compatible with
>> icm20608.
> 
> No. It is 'nearly' compatible...  The different WHOAMI value (used
> to check the chip is the one we expect) makes it incompatible.  Now we
> could change the driver to allow for that bit of incompatibility and
> some other drivers do (often warning when the whoami is wrong but continuing
> anyway). 

Different value of HW register within the same programming model does
not make him incompatible. Quite contrary - it is compatible and to
differentiate variants you do not need specific compatibles.

Using arguments how driver behaves is wrong. Driver does not determine
hardware/bindings.

> 
>> Therefore extending the compatible makes sense. This is not
>> only correct from devicetree point of view, but also is friendly towards
>> out of tree users of bindings.
>>
>> The Linux driver behavior about whoami register does not matter here.
>> Not mentioning that it would be easy for driver to accept multiple
>> values of whoami.
> 
> I disagree entirely. Any driver that makes use of the whoami will not
> be compatible with this new part.

Driver implementation is not related to bindings, does not matter. You
cannot use driver implementation as argument in discussion about
bindings and compatibility. Implementation differs, is limited, can be
changed.

>   It's a driver design choice on whether
> to make use of that, but it's a perfectly valid one to refuse to probe
> if it doesn't detect that the device is the one it expects.

Still not argument about bindings and compatibility but about driver.

> + There is code out there today doing this so inherently it is not
> compatible.

Still code of driver, not bindings/DTS/hardware.

> 
> So no, a fall back compatible is not suitable here because it simply
> is not compatible.
> 
> Now, if intent was to provide a backwards compatible path from this
> more advanced part then the behaviour of every register defined for
> the simpler part, must be identical on the more advanced part.

There is no backwards compatibility of advanced path, so the DMP core.
The device (not driver, we do not talk here about driver) is compatible
with basic version fully. 100%. Only this part you need to keep always
compatible between each other,

> Extra functionality could only make use of fields in registers marked
> reserved, or of new registers that didn't exist on the simpler device.

Extra functionality is for new, extended compatible. See
Documentation/devicetree/bindings/ABI.rst which exactly explains this case.



Best regards,
Krzysztof
