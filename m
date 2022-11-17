Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26CE62DA93
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiKQMXF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 07:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiKQMXF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 07:23:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28063716CB
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 04:23:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p21so1458852plr.7
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Z65m0DgunHILIy2ME/mQky7Pas/nTA/BCKHp6AXOSY=;
        b=Qj3MYPr3dBnSlxUwOIve/Ri50g8A0uPXUF7X+99Is8mVhZSVOhFLCazeEJ0v4UYfyW
         xJ/Ih267QLKKnZXqWcVQIdPoDU6Jz88En47W3BnahE+TZHL4GIgc27+cWoDEZfcMqa+W
         b5iPMco4iYPZKZzPJpCjXlgtMphMZPWikQ0J0buq9Il/5lfL0isrPU95rMtD6e/cRLgx
         RZg1ltn6w+49jcJd8TPB2nllVVeCiDtku7XBmzJeJ734xTdPYQnSLui8eXsXL5PRej5x
         9acvKWDchlcorpInv8/THpzBp0jqWXZ6SjgGumQg3b8z71GuCqRc3KllwWawzpsxIMcO
         1YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z65m0DgunHILIy2ME/mQky7Pas/nTA/BCKHp6AXOSY=;
        b=kpKEdLVJIC7Nc2Z+Ijnn0CpMwNWlDAk+JQbSu0MZvIlDqdDOJICuuAoyPhdu0oSaa5
         DmsbbZLqx4I5BOAjO6Po+Faxw1gAIJVNu5umiIt+KBK+ByTacH7c8BVn3q9tbUmSMr39
         cOyXBBtZqa3HjVp2TP3jtC8+eBvkY3tR8axT0U9tZxgoSHbcH/HdBF+QOaGFjQZnENsz
         nVBJnPTQYedipxjTAWiVO2FCYec8I2CsjJPTaucxoAleI9oorKOaki+B+Y0GyOjpDnHn
         wDdGWR3ozB7983BWk7eGDw4BHURra9rfFG/Vsn3XtDkFY7wvYa9/5dUuaj3eaEkSXpvX
         Y/Mg==
X-Gm-Message-State: ANoB5pmvDA13AGdvYw3+Nmgq4AT52ufJOcdiOhuBG/AfZ6j56RUe1RsP
        wAz5pHgsqjWJygkBj+achaTS
X-Google-Smtp-Source: AA0mqf4Wo4+kNnV3lxmeTlDpo6H+hjTXpl1VEPBYMQ2o1Sr4hlgXHXt0iXsPG72d8S6WQ9HLfYB96Q==
X-Received: by 2002:a17:902:bc83:b0:188:eebf:2361 with SMTP id bb3-20020a170902bc8300b00188eebf2361mr2480619plb.125.1668687783183;
        Thu, 17 Nov 2022 04:23:03 -0800 (PST)
Received: from thinkpad ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id t29-20020aa7947d000000b0056b6d31ac8asm994236pfq.178.2022.11.17.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:23:02 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:52:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Message-ID: <20221117122256.GG93179@thinkpad>
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:
> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
> changed to take sid argument:
> 
>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
see this example.

Thanks for fixing!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> 
> ---
> 
> Issue is caused by commit 22f1d06f4f28 ("dt-bindings: iio: qcom:
> adc7-pm8350: Allow specifying SID for channels") from Bjorn's tree.
> 
> Unfortunately get_maintainers.pl were not used, so IIO maintaners were
> not CCed.
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index f1522196042d..bd6e0d6f6e0c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -299,7 +299,7 @@ examples:
>              };
>  
>              conn-therm@47 {
> -                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
> +                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
