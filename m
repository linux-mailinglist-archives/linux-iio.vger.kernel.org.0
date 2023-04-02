Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2F6D36A2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDBJr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBJr2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 05:47:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4507C19AB
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 02:47:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so106274743edc.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680428846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcPEW/fU+HSUxmyrURzhSPS3MkAlKArgWKHjF8kaX/A=;
        b=s5ercffMxwZJXRMxxHnx1D9sCBIchZqgWUbw3dgLIg7H+W2wqm/xsKEZf2HhOrwdJT
         qwicJLwgMuZFKBBiFE9pYetTkhlf9Y178aHfgyzV6XS9FewEm2ZW6e9EDXZUp8Ha+oAB
         kRTLLOmbN/RJ0gIH8qPbILmu4RHRGbMpSpbpfUuAdC2fTd3k6qby63tvrJWvnhcq9Lkp
         inX6qRQl0G8sSmRfmRMSNQJcOfsRdfCnxEHlCct75JX0hAwfjZqa5VuOU4TRFqARa80l
         OFpb1jxx1PfmCIeUjKZBxmZXQ6pjwhUKz0yF6RBqfXSCaCOoVLilDgEsEKVhtJVckroF
         MOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680428846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcPEW/fU+HSUxmyrURzhSPS3MkAlKArgWKHjF8kaX/A=;
        b=nfoq9emgqlsY7TMzpMlBK4bdT9PowEtl0io1ZToZKhqwKR6gaeOVy+Lsv2LZkRCd9i
         VmsWrHsNt3dAkYpjQrlQNFECT2mnrtRfrKIyZRe3TNfR/rlqHCSps5YrwYNEc6W747x4
         fb6Pam3RTTdxTxJb1No2/CoAirrBYCL6BsKASixVffU96YS6F5ogqlEVjl2yLjfvxfDi
         bOZyErGJAxuIZLlR0oWNSCK7r/akZrlC63ftTa7fgwISk49/LLE9evQwN/oPH3CyNFiK
         52oXsFH3xW4YSeapyDXXVn83O5DtkMnH3bjJi/QFqL4jqHOr0kPgWtTzTapnGZIM579j
         mWQA==
X-Gm-Message-State: AAQBX9enE6+X+TdSrJSD3Qpm2uX9YRfFaKFcaU8YzjmIFSQC4L8xmyGp
        CpkX9iNvSrH0aoTrLNV6NUySGg==
X-Google-Smtp-Source: AKy350bhEERVWSccArtnTOWjpQACVIbk5hc8rsqgANsF1kpbIxZtcxwQ43+zwqJ0vnYrtsVXuvRdJw==
X-Received: by 2002:a17:906:26c4:b0:933:130e:e81a with SMTP id u4-20020a17090626c400b00933130ee81amr12807581ejc.32.1680428845762;
        Sun, 02 Apr 2023 02:47:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709061c5600b00927f6c799e6sm3027703ejg.132.2023.04.02.02.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 02:47:25 -0700 (PDT)
Message-ID: <eecb67a5-38eb-5870-1124-0199766d1189@linaro.org>
Date:   Sun, 2 Apr 2023 11:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 20/22] arm64: dts: qcom: pm8150: convert to use dynamic
 SID/LABEL
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-21-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401220810.3563708-21-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2023 00:08, Dmitry Baryshkov wrote:
> SA8450p-based platforms have 4 instances of pm8150. Convert pm8150.dtsi
> to use pmic-dyn-header.dtsi in order to support dynamic and label
> assignment.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          | 53 ++++++++++++-------
>  arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi |  1 +
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index db90c55fa2cf..77bb325e425b 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -9,13 +9,28 @@
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/iio/qcom,spmi-vadc.h>
>  
> +/* (Sadly) this PMIC can be configured to be at different SIDs */
> +#ifndef PMIC_SID
> +	#define PMIC_SID 0
> +#endif

No, the DTS code must be simple, no ifndefs for some defines. This means
that sometimes you expect here define, sometimes not. It's not easy to
maintain and understand the code. Define must be simple and always
defined, not sometimes.

> +
> +#ifndef PMIC_SID1
> +	#define PMIC_SID1 1
> +#endif
> +
> +#ifndef PMIC_LABEL
> +	#define PMIC_LABEL pm8150
> +#endif
> +
> +#include "pmic-dyn-header.dtsi"
> +
>  / {
>  	thermal-zones {
> -		pm8150-thermal {
> +		NODE(thermal) {
>  			polling-delay-passive = <100>;
>  			polling-delay = <0>;
>  
> -			thermal-sensors = <&pm8150_temp>;
> +			thermal-sensors = <&LABEL(temp)>;
>  
>  			trips {
>  				trip0 {
> @@ -41,9 +56,9 @@ trip2 {
>  };
>  
>  &spmi_bus {
> -	pm8150_0: pmic@0 {
> +	pmic@0 {
>  		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x0 SPMI_USID>;
> +		reg = <PMIC_SID SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> @@ -55,7 +70,7 @@ pon: pon@800 {
>  
>  			pon_pwrkey: pwrkey {
>  				compatible = "qcom,pm8941-pwrkey";
> -				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts = <PMIC_SID 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
>  				debounce = <15625>;
>  				bias-pull-up;
>  				linux,code = <KEY_POWER>;
> @@ -65,7 +80,7 @@ pon_pwrkey: pwrkey {
>  
>  			pon_resin: resin {
>  				compatible = "qcom,pm8941-resin";
> -				interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
> +				interrupts = <PMIC_SID 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
>  				debounce = <15625>;
>  				bias-pull-up;
>  
> @@ -73,22 +88,22 @@ pon_resin: resin {
>  			};
>  		};
>  
> -		pm8150_temp: temp-alarm@2400 {
> +		LABEL(temp): temp-alarm@2400 {

NAK for all defines creating labels.


Best regards,
Krzysztof

