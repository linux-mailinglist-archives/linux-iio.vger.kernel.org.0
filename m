Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24BA69B18D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 18:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBQRCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 12:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBQRCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 12:02:12 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1C6605E
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 09:02:11 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r2so126608ljn.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AZFtNAIUiTQAFCQGfdU/BJAXNf6boY6NRMgBh3eXb0=;
        b=jaXD6jiBp+poUhJh0xgS3z7qImc+vljXB41TtbQmXUPcw50ZMCv599c3kdEvOPPeDO
         FcOdKf5UdU7fNGLr4oMBr1D59LlJyHs2PqOVDByUEWGQjLN+U/pp4aiAU5g3slW07RE9
         77vOCQqwB+PAR9Rmzgif1B9vJ9vRxyMQ5IYkJ8PC44mjuuCclPIZp8SryNVXhXGWcnrf
         brBKDymvrOcPNVmKSpnTGDCo5WlUI55RYgwwq/9/pvXyug8sWZTrfHyoqAUUcH8QLWH9
         H+r72GZAfDSoUJGtwW3WEuSgv8A78oHRuZqc8efSAzA63pmsh+9O9BiKdnZkKqwKYK41
         l44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AZFtNAIUiTQAFCQGfdU/BJAXNf6boY6NRMgBh3eXb0=;
        b=4fFKtp0jBo1NcI4DVbUKVoI7xWIRPxwZPXOZjjHsE9uQL2uq4YU0+ceDE7OaK4GhNW
         QFnLiB6ATXin2+2tEd/5Gf4mZEElTSO77Iz4Ho+YrSsBYOlOOtErkBPv3f562BzeMvVi
         /DzuWAKAuKrIWyKUsVcj4CMN2ByKQ0BBNT8vOeiuTK8IOi4yxPvMn1lpcdQ5/OO7276Q
         TmNJLVmlAMK9/K0kz44B5iGNj9K2ktLXrJQQYx7slzWNBTNiDD9sGJMCetw9/vdGm6a2
         XJI8kpmg5nWB1aTG1m76uAZRYju+oJuWJIWkUmsdPQKSStlweMX0cGlWNqxAobFLy3gZ
         weTQ==
X-Gm-Message-State: AO0yUKUFfP1Zpm32m/NcE/2oYkNhC15EwmZFfbUTm7s4iQNXDkjPbGJ6
        CeZHadVA1DPYQRzeO3GAexE=
X-Google-Smtp-Source: AK7set/NKtThgcJ4dMmG3rrnXTrzCc9AnYRbG53VogsL7vHvWWmh1d6xURXA/NVY8yYKnRa6VfTTwQ==
X-Received: by 2002:a2e:9c0a:0:b0:28d:cca5:2193 with SMTP id s10-20020a2e9c0a000000b0028dcca52193mr564936lji.53.1676653329133;
        Fri, 17 Feb 2023 09:02:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o4-20020a2e9444000000b002935284f5a4sm657577ljh.13.2023.02.17.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:02:08 -0800 (PST)
Message-ID: <cde24815-bfe4-9347-f950-ed8497edd4ca@gmail.com>
Date:   Fri, 17 Feb 2023 19:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Content-Language: en-US, en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
References: <Y+6QoBLh1k82cJVN@carbian>
 <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
 <20230217114308.00004a31@Huawei.com>
 <a4e69c59-d5c5-be8e-da7c-1955cc8b0ad7@gmail.com>
 <20230217142828.00007ed8@Huawei.com> <Y++Sju++GBxLAoCH@carbian>
 <20230217152713.000007ee@Huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230217152713.000007ee@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/17/23 17:27, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 15:43:26 +0100
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
>> On Fri, Feb 17, 2023 at 02:28:28PM +0000, Jonathan Cameron wrote:
>>> On Fri, 17 Feb 2023 13:59:16 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> On 2/17/23 13:43, Jonathan Cameron wrote:
>>>>> On Fri, 17 Feb 2023 07:56:22 +0200
>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>      
>>>>>> Hi Mehdi,
>>>>>>
>>>>>> On 2/16/23 22:22, Mehdi Djait wrote: 

>>
>> So should I send a patch with data->timestamp as I suggested ?
> 
> I think so.

Please do! That would be very much appreciated :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

