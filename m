Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0F5680DE
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiGFINe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGFINd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 04:13:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332C638F
        for <linux-iio@vger.kernel.org>; Wed,  6 Jul 2022 01:13:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n15so17443204ljg.8
        for <linux-iio@vger.kernel.org>; Wed, 06 Jul 2022 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=q5HVmA8sCnStfWK2o12uYQzpyK3n2MMa6yOBkWT5nc4=;
        b=UJKrwkK63DRqwhebPcgtSGFbf7L+yQsuZmf9S5ZHrdlc6imWTd1nqHKtSlKQehwDPh
         hQB+zUPmYC2sxSjkvPh3bWn9xlglh/esdgKNDgT9pC5KoS+/qCdZLsN69ezSikNawyqb
         5D1sWBTiEVCKSbWnB4MYAoS4DxLz+fgDk0Wrh5Sfzz8SW4HpAi8ajwFmRDv8xxxgVvmg
         3RJvE32/5ItiWrjQoo42fJFHMeh5TXzpK6l2UpD1tP+eww+YVfYmNIeiU5kBc8vao9Ez
         rukvHk7q5byYRDYQX/CnjsKbIHzKPNNo/M4d/wFXiFTVLKeByVHAn2+kQUiEAvPYyzPL
         S8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q5HVmA8sCnStfWK2o12uYQzpyK3n2MMa6yOBkWT5nc4=;
        b=XSKUUM4MKiX4LRby5sbtnilJlCGR92mdxVqwAhoqkt7jDC/8vFp+/XF1NEfD+YvPI5
         djc6wM8ZwD/xhUZjX/taxnPJUwrt0mZqZ8Za3R8Iro7e0YxNAfdZ7Wcax46jSe/zctGY
         5G4ms7gQamvOPiTtMa+p8UQGRXofjN/zybkMTQSiAvQvUB7qIX2qcvZcptLTy+DoR4tX
         r6AW4ji9Z4DhbIf6ySjV8OtkEiZWsQJ/2Zmmmd+y+RxoAozKOjptESW2d6YDcXhNJL1m
         jy9JV9pLl06KGO4cyt2s6sPNtzD5p7wWgHi4c2wqq1o8RezsSlClD1xmQ7w7/btzR9r/
         WlAg==
X-Gm-Message-State: AJIora+8mI0WMI+qXV2qjCoc9UBf+KwqNQUc+z8iEK2FLbECUvp7Vz8f
        k3vtk8aJ0Jk0zeAPbP7vOiYGHQ==
X-Google-Smtp-Source: AGRyM1vHeSTTD8DYfDtNiJtCXkLRLR8Aas+YPJtmy/Ovp5zENmXzxSMK84WqWuvevJD+G+V8OJfG8g==
X-Received: by 2002:a05:651c:623:b0:25d:30c0:22e9 with SMTP id k35-20020a05651c062300b0025d30c022e9mr5275970lje.290.1657095209978;
        Wed, 06 Jul 2022 01:13:29 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id a19-20020a05651c031300b0025d4853f35dsm104129ljp.62.2022.07.06.01.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:13:28 -0700 (PDT)
Message-ID: <93926f8a-6c40-a953-0435-34fc1b9ae120@linaro.org>
Date:   Wed, 6 Jul 2022 10:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 11/12] arm64: dts: qcom: add PMP8074 DTSI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220704212402.1715182-1-robimarko@gmail.com>
 <20220704212402.1715182-11-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704212402.1715182-11-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/07/2022 23:24, Robert Marko wrote:
> PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
> controlled via SPMI.
> 
> Add DTSI for it providing GPIO, regulator and RTC support.
> 
> RTC is disabled by default as there is no built-in battery so it will
> loose time unless board vendor added a battery, so make it optional.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v6:
> * Add RTC and GPIO nodes
> 
> Changes in v5:
> * Remove #address-cells and #size-cells as they are not required for
> regulator subnodes
> ---
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi | 125 ++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> new file mode 100644
> index 000000000000..a3b395e4d78f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pmp8074", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmp8074_adc: adc@3100 {
> +			compatible = "qcom,spmi-adc-rev2";
> +			reg = <0x3100>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			ref_gnd@0 {

Don't use underscores in node names, unless something depends on this.



Best regards,
Krzysztof
