Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7962DAD0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Nov 2022 13:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiKQM3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Nov 2022 07:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiKQM2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Nov 2022 07:28:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC4A15A21
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 04:28:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c1so2524044lfi.7
        for <linux-iio@vger.kernel.org>; Thu, 17 Nov 2022 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaV4zTImQ9m6pb9NhstVvLhblGt5Yc3IF7BX7u0m3cA=;
        b=HZnrzIGAYGbh+QP2qNAap3x2wWoNfEbQisc3dfbYBg9OeECrBvMO5K0IFvBxZZvlUB
         4CWmeZxBXjNuJzLO15EVRrKZzCWMlV6t58sQ7IN+1+crJm6P4QYKho9KYH3oHZK5LQvO
         vwn+n/hQSmLSRxoib57GmS9aq30F3PHiP4DiaZuLXKaIegUQSxnt0LJXhCZgTdSVaq8E
         dKJbfW3rw5b/3mUFq4K6zVUTj0qO03SCHtF+tiNu3rwwIcDLZeIHTnq+/3Ih8L7WsPYy
         E+A/aVnnUVEwSFTxyBP9ujnMhAUgvY/lTHUQk1cbEae8o//P2MtSBiKyvcl4pjGrVyI9
         n8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LaV4zTImQ9m6pb9NhstVvLhblGt5Yc3IF7BX7u0m3cA=;
        b=fabklVSNsPKr8bEg5Yq4AZO5JhlanAIfYp0ny0WzmXHcqxl8oW9D4hrMi/FLrxGI+y
         f2KjQJkrGkvoDeRPnI9CCyO7Hiu5+rE7eOPvlQ6OgNA75uZ3gm95rG8NwBMhEsZ5Hj5V
         4lCHbiV2lkiXGWsMfqG5SZ9L66J/H3J5PtX5DhhDatO2n7xUAFUwf93hkEsc8Se1+VqI
         cme1tIhthr1gLpm+0MU8DZulWhFjb7+VaCu52G5PAyAi1kwEHv/fDgBGh8TP+643JRpZ
         tO5zu7UfKwb1pTQrO0xzDNAd29wLJO23nBnEkeGu2Fx6MFPVnDMwS26BQ9a0LHZHx0uH
         Y4Mg==
X-Gm-Message-State: ANoB5pnBrg92B0ey6j6rUNCsBMIUQMrhYwz1G7xxSSoJJPLJCTUKjH/d
        PF5hMICP0PYJyNaNSfokaB0MRA==
X-Google-Smtp-Source: AA0mqf5+ZifQCXbi70+2WGQf3dE4b5msdrwfnRA4Y5oqrR/WDBI7n3uYsrARQOWdpgzREgWvze50/w==
X-Received: by 2002:ac2:4d93:0:b0:4a2:70a5:992f with SMTP id g19-20020ac24d93000000b004a270a5992fmr747564lfe.341.1668688114935;
        Thu, 17 Nov 2022 04:28:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b00497a0ea92desm126731lfi.135.2022.11.17.04.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:28:34 -0800 (PST)
Message-ID: <a3da2ab9-ad36-2283-0659-ad8ebf877e17@linaro.org>
Date:   Thu, 17 Nov 2022 13:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
 <20221117122256.GG93179@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117122256.GG93179@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/11/2022 13:22, Manivannan Sadhasivam wrote:
> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:
>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
>> changed to take sid argument:
>>
>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
> see this example.
> 
> Thanks for fixing!
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

This should not go via Bjorn's tree without IIO ack and
Jonathan/Lars-Peter/IIO lists were not in CC.

Best regards,
Krzysztof

