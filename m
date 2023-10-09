Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1C7BD7AD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjJIJwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbjJIJwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 05:52:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7E97
        for <linux-iio@vger.kernel.org>; Mon,  9 Oct 2023 02:52:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3248e90f032so4269418f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Oct 2023 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696845135; x=1697449935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTlCqvJvWR1oqZWw+hzx3aeKDF9bM2oUn/096ZaKcwQ=;
        b=cRlQLn/bMrK+fOgp0JS65vtETwDuMcTZ7ySMj57YxmaGhmSisSu0y5zp4yLaoSoyDH
         klGcr2l7OxRwMdyi7k+/KThOguM4n7zRzwDzp4uFKIdVPkdsO0G68xtinxWMeItBcouy
         k22awPaoqmFYVDTU108dAkHkWNOd2Uw5sGmjpetmHNUzK3BvH5ImegB4cD+s80RZFcav
         sunuu8o1ORd5WpmcZaPpxSP7Mim4XuGXxf56GBCcFeHQ0ZRMXaY6nPiIN2DTVMZ0r7T9
         zlZ12TNNGkysQpvjyJQ+Fog0H8G5Grt5uHgfm1vyH4TfolMtT0V07lyWEZGWR3lkRT+9
         aF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845135; x=1697449935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTlCqvJvWR1oqZWw+hzx3aeKDF9bM2oUn/096ZaKcwQ=;
        b=pOfOF6ljXATMkFAeAZu1MXRaJAomlnme0NQtVvx4u4m9zsI+SIFsYlAF9H/PcmKL2z
         3FrcrBClKgTRQX4HkcmV3emTY0kOrwVKuDvdNXJQmBUqfn2tLSPnz+EA5b7k3j3Uhm5C
         fvRPoSAw01Z3GiMuUdZkt6x1i5MrdWx6Gv10EPVBAJJWIK5bSVPnnw8NqiztJkOJxeVo
         Wbgk2dKY7ccOO/RtgkXh2Odngz6QWAnURno0WwTBUmJ6vY9H3OudO5zJZcmG6dfVBifA
         WdzaSI4evM8CTNZMj6LLnp0ZkLwKLrEfXE0G8X32EO3lltykhHodY0WeRji+me5yv18S
         ky/A==
X-Gm-Message-State: AOJu0Yz7rL4coGtm3yBW7DojGRVIVig4dej45X4ifhnkpfU2c5DnjGax
        757imc/DdyoSIP8CudBqvwNh0g==
X-Google-Smtp-Source: AGHT+IHMPU/ttq6UzR4WDhz6H1sSoSmpPEbYEoiffHswXnHcX5EM8YUtNHk4AdOQOQliiw/LHSs02w==
X-Received: by 2002:adf:ec4d:0:b0:31f:b79a:c4b7 with SMTP id w13-20020adfec4d000000b0031fb79ac4b7mr13874817wrn.24.1696845134761;
        Mon, 09 Oct 2023 02:52:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:88ad:b7c0:92ba:cace? ([2a05:6e02:1041:c10:88ad:b7c0:92ba:cace])
        by smtp.googlemail.com with ESMTPSA id b16-20020adfe650000000b003266ece0fe2sm9026653wrn.98.2023.10.09.02.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:52:14 -0700 (PDT)
Message-ID: <576809c2-b7bc-4342-9c63-0662bfcecebf@linaro.org>
Date:   Mon, 9 Oct 2023 11:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <TYCPR01MB112697D67514D2E6FC690B9F886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 09/10/2023 08:54, Biju Das wrote:
> Hi all,
> 
> Gentle ping. This patch is in the patch work for a while.
> It is acked/reviewed by Conor Dooley and Geert Uytterhoeven.
> 
> Can we apply to mainline if you are happy? Or do you want me
> to RESEND the patches? Please let me know.

Krzysztof ?


>>> On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
>>>> This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
>>>> Also it fixes overflow/underflow interrupt names.
>>>>
>>>> v2->v3:
>>>>   * Dropped patch#4, as it accepted for 6.5 fixes.
>>>>   * Moved patch#2 to patch#1 as it is fixes patch.
>>>>   * Added Rb tag from Geert for patch#1 and patch#3.
>>>>   * Updated the link to lore for Closes tag for patch#2.
>>>>   * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
>>>>
>>>> v1->v2:
>>>>   * Added Ack tags from Conor Dooley for binding patches
>>>>   * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
>>>>   * Fixed build error reported by kernel test robot by replacing
>>>>     GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
>>>>
>>>> Biju Das (5):
>>>>    dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>>>>      names
>>>>    dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>>>>    dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>>>>    arm64: dts: renesas: r9a07g043: Add MTU3a node
>>>>    arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

