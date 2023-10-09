Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7C17BE256
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjJIOSW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJIOSV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 10:18:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E421A3
        for <linux-iio@vger.kernel.org>; Mon,  9 Oct 2023 07:18:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so41970405e9.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Oct 2023 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696861095; x=1697465895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buP33NIbDErwx8CzHiVracuxo64oF8KO6esE1+yX/Y4=;
        b=w+KUHqiV9yfdSGsJGrvtxnoe+NHvayroURvG/+nKo/Mo1u8yYbnJ3LB8Ys8/QFNLXx
         XEogjcwMVvMB9ah7rDzaVllGPo276MIbEzLEWVeKFeklKq89xOy+jVCBny6kwW9wYlT1
         eOeW2tdWb8dVZcH1INcraxyq2kRTSW/hm1BwRY6soGw+Aw9wk9wOUedgK4YPXqf9J1WP
         2v1Yv1xIKd+C+kUhWUyWTkCdO2HJhIbtHQDX7UKC5kYA/mopRYux98hr9SSslMm5Nbzv
         kFb94t248t3lyTw8fyZPq9Tbox60JO/jvq4FNqpPbJHypRURX4hAnoYdJ9lAL215p558
         iDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696861095; x=1697465895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buP33NIbDErwx8CzHiVracuxo64oF8KO6esE1+yX/Y4=;
        b=Hb2RuisFCdS5nUR9nAh6i+bJki8Y8CBcZQC5wrs9fWcG6ncem3+GpbRom0PM1hN8b7
         0V89/ZvlF6Ce1xZ8OtTJn6WNZANhFs0GbH0WCqhX9/S4eOgh84PdyPm2/LU1ePZuoXGX
         YyApYbYG2pBr9E8N0RKdBqkfjcSBciSYW7ZqeeNVnqjDL40AxDQxm4wt2cN5Rz5Vfj+A
         K0sLqcaTVdwwptNe6vLLp0u88LbHHMKGcDPJwRJUf3JlUCBJ/6jLGS8x5ZWY0Enog+uc
         sllTeEHQTkZgB+7FAxlFcBzW2WopOQumTu4DmzPC4YIfQHyWTVLKe+5dTmPww2pLLqgj
         J2jg==
X-Gm-Message-State: AOJu0YzYFgtn/eGo7m92+do5FTfyJbQqgm/AvROtPVTbpqhHvtmk9Wez
        XDcQpQCVTCcry0g1sIzpPoVEzA==
X-Google-Smtp-Source: AGHT+IHlLPC8hrKalFu6kj/FTfm3MoFE1i1WfPwnAhhawPgy4hd+swddiIE4JiYf9jSjbBasbLOVCw==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id 15-20020a05600c22cf00b0040145425eddmr13766645wmg.34.1696861094962;
        Mon, 09 Oct 2023 07:18:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:88ad:b7c0:92ba:cace? ([2a05:6e02:1041:c10:88ad:b7c0:92ba:cace])
        by smtp.googlemail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm13521923wmi.27.2023.10.09.07.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 07:18:14 -0700 (PDT)
Message-ID: <42ed1a41-a59c-478b-8ef2-4000f0509150@linaro.org>
Date:   Mon, 9 Oct 2023 16:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor@kernel.org>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
 <20230831-iphone-muscular-7442cda2c39e@spud>
 <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <TYCPR01MB112697D67514D2E6FC690B9F886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <576809c2-b7bc-4342-9c63-0662bfcecebf@linaro.org>
 <20231009-lure-overcome-f33ee1fd6480@wendy>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231009-lure-overcome-f33ee1fd6480@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 09/10/2023 15:59, Conor Dooley wrote:
> On Mon, Oct 09, 2023 at 11:52:13AM +0200, Daniel Lezcano wrote:
>> On 09/10/2023 08:54, Biju Das wrote:
>>> Hi all,
>>>
>>> Gentle ping. This patch is in the patch work for a while.
>>> It is acked/reviewed by Conor Dooley and Geert Uytterhoeven.
>>>
>>> Can we apply to mainline if you are happy? Or do you want me
>>> to RESEND the patches? Please let me know.
>>
>> Krzysztof ?
> 
> Daniel ?
> 
> (Or for the non-telepathic, what is "Krzysztof ?" supposed to mean?)

Sorry I missed you were in the DT bindings maintainer list. I was 
expecting Krzysztof tag.

I'll pick the patches now.

Thanks

>>>>> On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
>>>>>> This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
>>>>>> Also it fixes overflow/underflow interrupt names.
>>>>>>
>>>>>> v2->v3:
>>>>>>    * Dropped patch#4, as it accepted for 6.5 fixes.
>>>>>>    * Moved patch#2 to patch#1 as it is fixes patch.
>>>>>>    * Added Rb tag from Geert for patch#1 and patch#3.
>>>>>>    * Updated the link to lore for Closes tag for patch#2.
>>>>>>    * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
>>>>>>
>>>>>> v1->v2:
>>>>>>    * Added Ack tags from Conor Dooley for binding patches
>>>>>>    * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
>>>>>>    * Fixed build error reported by kernel test robot by replacing
>>>>>>      GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
>>>>>>
>>>>>> Biju Das (5):
>>>>>>     dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>>>>>>       names
>>>>>>     dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>>>>>>     dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>>>>>>     arm64: dts: renesas: r9a07g043: Add MTU3a node
>>>>>>     arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
>>>
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

