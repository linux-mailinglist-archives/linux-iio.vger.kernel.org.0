Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CAC7CA915
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjJPNOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJPNOS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 09:14:18 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA74123;
        Mon, 16 Oct 2023 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y2/hJrft5KsN2wzR6O03LEUQXPAWB/CVRjq8kYLbQFA=; b=mBuKvjPGuQ42OppO+9GNYDhpgj
        OicPxC5i7HFvRlo+OvM8P1Zfs2i4u60SFLe9JyaS/26aW5EXiOe+Ip1qkb+6kFCtg8X/7aHB/75po
        GV19XeDwL9Al6kiJ9nkaaVdnpPdI+6I8BTSxFI2Y1KwVDf4uZZ8fB4zRV0PwdBooZTX0tYwPTa1K7
        F/wd6sA+Ly7e3vH9ZELvRizvKXnCeo7GgMcD1ASsFDQDqXeTeN7LhsNBjOhLIQpp7lcswVzRDUPPm
        XeOzoWZR6yD5TQBj8vYvyRtYaG7tAm3xDO7BpaXHl/io2DK7p3MstGpjacj3DcvaNV7GZ/aYAKppO
        fw6lZFmQ==;
Received: from re-byods-146-50-198-227.wireless.uva.nl ([146.50.198.227])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qsNQ3-0014Bx-Pw; Mon, 16 Oct 2023 15:14:03 +0200
Message-ID: <ef10aa1b-8365-41e1-992e-ee8711ae24cb@igalia.com>
Date:   Mon, 16 Oct 2023 15:14:02 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8350-lemonade(p): new devices
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
From:   Nia Espera <nespera@igalia.com>
Autocrypt: addr=nespera@igalia.com; keydata=
 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
 T+I7o407lOB8a/PJA2YXM4VVC/iyMBM=
In-Reply-To: <5382aff2-30b0-4e6d-9fcd-ffd6dac0abff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,

On 10/16/23 15:02, Caleb Connolly wrote:
>
> On 16/10/2023 13:47, Nia Espera wrote:
>> Device tree files for OnePlus 9 and 9 Pro. Details of supported features
>> mentioned in the cover letter for this patch series, but for
>> accessibility also repeated here:
>>
>> - USB OTG
>> - UFS
>> - Framebuffer display
>> - Touchscreen (for lemonade)
>> - Power & volume down keys
>> - Battery reading
>> - Modem, IPA, and remoteproc bringup
>>
>> Steps to get booting:
>>
>> - Wipe dtbo partition
>> - Flash vbmeta with disabled verity bit
>> - Flash kernel and initfs to boot partition with CLI args pd_ignore_unused
>> and clk_ignore_unused
>> - Flash rootfs to some other partition (probably super or userdata)
>>
>> Signed-off-by: Nia Espera <nespera@igalia.com>
> Small comment below, for the next revision:
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  |    2 +
>>   .../arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi | 1247 ++++++++++++++++++++
>>   .../boot/dts/qcom/sm8350-oneplus-lemonade.dts      |   82 ++
>>   .../boot/dts/qcom/sm8350-oneplus-lemonadep.dts     |   37 +
>>   4 files changed, 1368 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 2cca20563a1d..369ad4721b29 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -211,6 +211,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonade.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-oneplus-lemonadep.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>> new file mode 100644
>> index 000000000000..2f6768f35259
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-oneplus-common.dtsi
>> @@ -0,0 +1,1247 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Caleb Connolly <caleb.connolly@linaro.org>
> This is loosely based on some initial work I did, but not to the degree
> where this copyright is necessary, feel free to drop it on the next
> revision.
Will do!
>> + *
>> + * Copyright (c) 2023 Igalia S.L.
>> + * Authors:
>> + *	Nia Espera <nespera@igalia.com>
>> + */
>> +
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
>> +#define SMB139x_1_SID 0x0b
>> +#define SMB139x_2_SID 0x0c
>> +#include <dt-bindings/iio/qcom,spmi-adc7-smb139x.h>
>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sm8350.dtsi"
>> +#include "pm8350.dtsi"
>> +#include "pm8350b.dtsi"
>> +#include "pm8350c.dtsi"
>> +#include "pmk8350.dtsi"
>> +#include "pmr735a.dtsi"
>> +#include "pmr735b.dtsi"
>> +
>> +/ {
>> +	/* As with the Sony devices, msm-id and board-id aren't needed here */
>> +	chassis-type = "handset";
>> +	interrupt-parent = <&intc>;
>> +
> [...]
>
>> +
>> +	/*
>> +	 * Hack; OP9 bootloader specifically checks that the timer node has
>> +	 * this label.
>> +	 */
>> +	arch_timer: timer {};
> For this to work you also need to build the DTB with labels (the -@ flag
> to dtc), otherwise this board won't boot. You can add the following to
> the Makefile:
>
> DTC_FLAGS_sm8350-oneplus-lemonade := -@
> DTC_FLAGS_sm8350-oneplus-lemonadep := -@
This actually isn't necessary if building the image as an Android version 1
image; it will boot fine without, since it won't try to append to the DTB. I
should probably mention to do that in the patch, though.
> See for reference:
> https://lore.kernel.org/linux-arm-msm/20231009172717.2695854-1-dmitry.baryshkov@linaro.org/
>
> Regards,
>


