Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9287D6CCED9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC2Afz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjC2Afy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:35:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3D1BCA
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:35:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z42so14373083ljq.13
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680050150;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlQYroGfkrEESXavEKCaYfu6GvJdtSQOh+xRf0smNE4=;
        b=N3vwMyYU8eoftb6iewXuC5jlROewgubnGUApSf6LzmZET5yS1tb8CoTF4kmTKhPOJa
         tOMyqjwmnH2iAzdq/DFOb6O/ymtQZyIUPJrqYcnIH4rBllg9f5j+cSaMOg8YS7j0HN7M
         xwYvIWXer2g7Z4keDMsy+W9CmYCaE134NFb5pkL/bXPyBbWlEgcxYn47AyAy5trSZbkM
         hK6vBP7hAjXW7M+ucqSNQAkw7HaIu1aXRs3FMLzU23VOu9HFpX3AG1ig3cIchm3BYiF4
         JMDoRnA5AnpuBOi2q0zbWeWHaRP6nlC6+8b7UbnPi2xje4mPDKIdRFTA6etJ3stRUq6H
         Ymzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680050150;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlQYroGfkrEESXavEKCaYfu6GvJdtSQOh+xRf0smNE4=;
        b=hUozJMSP4RSGiPFqwzKB57dELrOoODOGWd0lQyvJ5frKUcmX8nL517fVOE2wM/21oJ
         V2zYkFV2wwNPVqVpZfX24plRiBqw14DBAripPS+/ws/FmnhoNMMeclOUWhWUn/MUbXSR
         DLkUM9+A1GXdUPb/agYFDCbR3wQh99jxau+nnjugwPTk+JTwVZONGL9WfZGJY5NM7mrP
         8v6gEEJKpZehCwb9lvrRF8/1sNSmylXBBc04M9V2xHOzofsxBA3Fm8ZJYESScChjnyJR
         YEbKqlMeWuXM7kuQ3o8xhhjCtCXUh92UPzWgppI+aFdKDd9SGK9YJCdIuerekoImeMcW
         L2cA==
X-Gm-Message-State: AAQBX9eE2Qg2cyOL17z9vu3X+/VdsQA+1+OPISwX2olcqloTzG8Ii5Ou
        4LlnzxVMyxFmjbpFFuy9iAda+Q==
X-Google-Smtp-Source: AKy350a7O6hcne230BIOILTxthjZzxnWjCcu/dZ0N0zGTJTZemqKU1izaOIrF1FYX+/9+byL9nKKDQ==
X-Received: by 2002:a2e:9f0a:0:b0:29a:3a61:bbd4 with SMTP id u10-20020a2e9f0a000000b0029a3a61bbd4mr5352546ljk.48.1680050150637;
        Tue, 28 Mar 2023 17:35:50 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e80c2000000b0028b6e922ba1sm5261581ljg.30.2023.03.28.17.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 17:35:50 -0700 (PDT)
Message-ID: <09b97204-514e-1262-04ee-3536a11e7ffc@linaro.org>
Date:   Wed, 29 Mar 2023 02:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6] arm64: dts: qcom: use main pmk8350.dtsi for sc8280xp
 platform
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
 <20230329000833.2507594-4-dmitry.baryshkov@linaro.org>
 <9746792b-fd4a-6808-0c6b-4834ffc9c059@linaro.org>
 <195dddb5-25f7-ac8c-8609-776ed6724650@linaro.org>
In-Reply-To: <195dddb5-25f7-ac8c-8609-776ed6724650@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 29.03.2023 02:29, Konrad Dybcio wrote:
> 
> 
> On 29.03.2023 02:27, Konrad Dybcio wrote:
>>
>>
>> On 29.03.2023 02:08, Dmitry Baryshkov wrote:
>>> Employ existing PMK8350_SID and switch sc8280xp-pmics to use
>>> pmk8350.dtsi to reduce duplication and possible discrepancies.
>>>
>>> For example, this changes sc8280xp platforms to use qcom,pmk8350-pon
>>> for the pon device compatibility rather than the incorrect
>>> qcom,pm8998-pon.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>> Bit of a loaded patch..
>>
>> This could probably go like:
>>
>> 1. outer join 8280 on pmk8350 (for feature parity)
>> 2. rename all labels in 8280 to 8350 (for 3.)
>> 3. switch over to the actual 8350 file, remove 8280 (with Fixes:)
>>
>> [...]
>>
>>> +#define PMK8350_SID 0
>>> +#include "pmk8350.dtsi"
>>> +#undef PMK8350_SID
>> Not sure if this undef is necessary
> It looks like it would be for multiple instances though
> 
> Konrad
Also, it'd be a good idea to use interrupt-parent, as:

1) it would be a regression for OpenBSD and friends to remove it
2) the interrupts=<> is dangerously long with SPMI

Konrad
>>
>> With or without all that though, the goal lgtm..
>>
>> Konrad
>>
>>>  
>>> +&spmi_bus {
>>>  	pmc8280_1: pmic@1 {
>>>  		compatible = "qcom,pm8350", "qcom,spmi-pmic";
>>>  		reg = <0x1 SPMI_USID>;
