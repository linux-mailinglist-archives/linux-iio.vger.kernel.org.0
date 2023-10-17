Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4797CC852
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbjJQQFL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjJQQFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 12:05:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395C9E
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:05:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c50906f941so61334231fa.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697558706; x=1698163506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpl0IEEBpo2+vCTVkUTCV6LVt68FmaU7qfc6DIs4Uok=;
        b=fxdBagBQfBM8/5JEt1iiLqcLb05372y7gNbTHFpEUbXIw3LNlWdOj+thEcFXaPOuHu
         WjsvWdbjUO4jDdx/hwqe+nEEsuBZKmxQ2vh+NITEvSZ/YYvVxIQy/YNNYa56Ty8XdAHh
         OM1NwqJ7MWQPg+sU+jebXm4RTgddYt2sp/MSiAnRYYCZN344LH5sk5s6tHkk1AoZyGN4
         wWfyXYpwRv8aUa/JMv2e7bGUpDRDMvNdOUbzpN4r3RJ1tmH/zcuq6Sz0UH/lb7pyvHg0
         ytOOio3/tgcmjQ98DJCiKizLG+9aGUb0e0mu2OLmKn/mVWnjt4aarEomTOm7NY8PWyDE
         14bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558706; x=1698163506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpl0IEEBpo2+vCTVkUTCV6LVt68FmaU7qfc6DIs4Uok=;
        b=Ulz0rIK0gB4H/bw+m8cDeXmaq6OFeR6Lg5fi3/ejj8ZCxv749rUP+azYzP/Gkl97kQ
         8S1HW9IMIRgWQyVU1ULZnqGbC197U3K/cdbjy+Ku+xk9Xlow7h7jaVaNoLYGniqmILn6
         yZtncVyYtYzf2M+JOyrVOB50VwUqzcWm/19kC8L3a6a67dZyNFNhX0vkUx6eG5y/kBZv
         XbsN9PUUJ8T0McEknt7VdKaEWy4Hj7vc/ujLt8D/HSWbbhxpaMNKk43iHhRK+WqjfWrs
         LXrRiR8qx6CAdPe4bDHiW3Lchlz2SNscz6IFiAJvhvD44NsNhapMKyLqlfgo3vNEP3Q1
         /YIA==
X-Gm-Message-State: AOJu0Yxqg80iWEd2a2w24up+0nY49AkIb1lDhAvV6VY7ykVElcOby+A/
        i6Cw3JXiqw4VqYhWi1+H1Bop3Q==
X-Google-Smtp-Source: AGHT+IF3YfUnVeLx0IkWt7o3PFMF1fp39lH7ikypo14lurXsdGqba/iFAcbblTmg1R28GDI0V2f1ag==
X-Received: by 2002:ac2:5187:0:b0:507:bb10:4354 with SMTP id u7-20020ac25187000000b00507bb104354mr2162392lfi.62.1697558705851;
        Tue, 17 Oct 2023 09:05:05 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w26-20020ac2443a000000b005030c533843sm329505lfl.154.2023.10.17.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:05:05 -0700 (PDT)
Message-ID: <099f9bd8-f3c6-4864-8346-0151babc99b6@linaro.org>
Date:   Tue, 17 Oct 2023 18:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Nia Espera <nespera@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-5-bb557a0af2e9@igalia.com>
 <5382aff2-30b0-4e6d-9fcd-ffd6dac0abff@linaro.org>
 <ef10aa1b-8365-41e1-992e-ee8711ae24cb@igalia.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ef10aa1b-8365-41e1-992e-ee8711ae24cb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/16/23 15:14, Nia Espera wrote:
> Hey,
> 
> On 10/16/23 15:02, Caleb Connolly wrote:
>>
>> On 16/10/2023 13:47, Nia Espera wrote:
>>> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
>>> mentioned in the cover letter for this patch series, but for
>>> accessibility also repeated here:
>>>
>>> - USB OTG
>>> - UFS
>>> - Framebuffer display
>>> - Touchscreen (for lemonade)
>>> - Power & volume down keys
>>> - Battery reading
>>> - Modem, IPA, and remoteproc bringup
>>>
>>> Steps to get booting:
>>>
>>> - Wipe dtbo partition
>>> - Flash vbmeta with disabled verity bit
>>> - Flash kernel and initfs to boot partition with CLI args 
>>> pd_ignore_unused
>>> and clk_ignore_unused
>>> - Flash rootfs to some other partition (probably super or userdata)
>>>
>>> Signed-off-by: Nia Espera <nespera@igalia.com>
>> Small comment below, for the next revision:
>>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>>>   .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 
>>> ++++++++++++++++++++
>>>   .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
>>>   .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
>>>   4 files changed, 1368 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>>> b/arch/arm64/boot/dts/qcom/Makefile
>>> index 2cca20563a1d..369ad4721b29 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>>> sm8250-xiaomi-elish-csot.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8350-hdk.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8350-microsoft-surface-duo2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8350-mtp.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm8350-oneplus-lemonade.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm8350-oneplus-lemonadep.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8350-sony-xperia-sagami-pdx214.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8350-sony-xperia-sagami-pdx215.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8450-hdk.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>>> new file mode 100644
>>> index 000000000000..2f6768f35259
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>>> @@ -0,0 +1,1247 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023 Caleb Connolly <caleb.connolly@linaro.org>
>> This is loosely based on some initial work I did, but not to the degree
>> where this copyright is necessary, feel free to drop it on the next
>> revision.
> Will do!
>>> + *
>>> + * Copyright (c) 2023 Igalia S.L.
>>> + * Authors:
>>> + *    Nia Espera <nespera@igalia.com>
>>> + */
>>> +
>>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
>>> +#define SMB139x_1_SID 0x0b
>>> +#define SMB139x_2_SID 0x0c
>>> +#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "sm8350.dtsi"
>>> +#include "pm8350.dtsi"
>>> +#include "pm8350b.dtsi"
>>> +#include "pm8350c.dtsi"
>>> +#include "pmk8350.dtsi"
>>> +#include "pmr735a.dtsi"
>>> +#include "pmr735b.dtsi"
>>> +
>>> +/ {
>>> +    /* As with the Sony devices, msm-id and board-id aren't needed 
>>> here */
>>> +    chassis-type = "handset";
>>> +    interrupt-parent = <&intc>;
>>> +
>> [...]
>>
>>> +
>>> +    /*
>>> +     * Hack; OP9 bootloader specifically checks that the timer node has
>>> +     * this label.
>>> +     */
>>> +    arch_timer: timer {};
>> For this to work you also need to build the DTB with labels (the -@ flag
>> to dtc), otherwise this board won't boot. You can add the following to
>> the Makefile:
>>
>> DTC_FLAGS_sm8350-oneplus-lemonade := -@
>> DTC_FLAGS_sm8350-oneplus-lemonadep := -@
> This actually isn't necessary if building the image as an Android version 1
> image; it will boot fine without, since it won't try to append to the 
> DTB. I
> should probably mention to do that in the patch, though.
>> See for reference:
>> https://lore.kernel.org/linux-arm-msm/20231009172717.2695854-1-dmitry.baryshkov@linaro.org/
Yes, using mkbootimg arguments to our advantage to avoid hacks in the dt 
is good.

Konrad
