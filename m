Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8450A6D4269
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjDCKpC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCKpA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:45:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033410EB
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:44:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g17so37472865lfv.4
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680518697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfF51ju6g2Vk9QLZ3M4JMJygNq7FzMSheocePpRa5mU=;
        b=FdX9gItFGUIXNc7xqH9k/2prUSCKixY9o8bWHzjX7jmZTKxnrGTWaJ50BjiUxutQZI
         tbn5a8QNppxvgldSJG0zBsvkbB5f4qy4AzzvnuIPKapS/Duc9dIMjsp1EtX936SnVipf
         GurwSz7MBChqbHMj6p2gvA3ejZXh6HYcsubW0JqEhNm3GVltfbVUZsYtFU3HwARvrJVm
         Q7vcPriF8y+pPwZd3p9+LsQpKa6gSfsZ7G/cwMxChwh/LU5AUZfLaPKt31YYZW3AD/ol
         F3GUhmwoMx9xiFKHkBglItsjcgywqdvezwuuk7FMrPRUbWKmv1zHMnJtZscSA2w2x0Hy
         L7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680518697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfF51ju6g2Vk9QLZ3M4JMJygNq7FzMSheocePpRa5mU=;
        b=c3qApRDgepaZqNL1W8OX3bMJ++3RIlTfjEKx3yH9Ym5ejO26/gfvmsz3u7PRoat+m/
         ZOfbe+I7QKnWyGQxRSrRkR3gaEFVkPNNpDB9k7CYkqROkqzeNybx+9x21IQMSgFi7oDR
         H8tHd6C7yz1dvxPO6PgOaSkKuOhh5BmTkBUseRWowlWeCAYCXMEI29vAhUlQH8SKBKJv
         ThBBMC0UFiCWfPWgb1bzvQpolLuY58Qj6DqLSrb+yBXScXZnMCvlen/hUjFYnJnAepQ9
         ldgL8h7R9Xg2MRmtGKm8tWXVYyfr06nb5K5Kxuhn9a7a/GaU0ADhTqOlA654ApG6hOW/
         5IJQ==
X-Gm-Message-State: AAQBX9faTyfVfYUsgGxCJJaVValHZi+y+KJZLs1KTalvE/eHCxD0ZZy4
        Hu5bK3DIi2q1z3+e9tjK3Snkaw==
X-Google-Smtp-Source: AKy350atmcdEqJQEBqDMyp+PVkd88PhNCs3kqcnM53Ri7ILtS5OQRoIS/jcyF64ER3LogOZqEeVFFg==
X-Received: by 2002:ac2:41c4:0:b0:4eb:1606:48db with SMTP id d4-20020ac241c4000000b004eb160648dbmr5900409lfi.22.1680518697663;
        Mon, 03 Apr 2023 03:44:57 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id e8-20020a2e8ec8000000b00293534d9757sm1690555ljl.81.2023.04.03.03.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:44:57 -0700 (PDT)
Message-ID: <c6f20137-299a-afb1-c42d-35f7386b1e27@linaro.org>
Date:   Mon, 3 Apr 2023 12:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 00/22] arm64: dts: qcom: remove duplication in PMIC
 declarations
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <10626c79-46da-3f66-0327-66576b3e5f2c@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <10626c79-46da-3f66-0327-66576b3e5f2c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2.04.2023 11:55, Krzysztof Kozlowski wrote:
> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>> The sc8280xp platform uses its own copy of PMIC declarations. This can
>> easily end up with the issues that are fixed in the main PMIC include
>> file, but are not fixed for sc8280xp (and vice versa). For example
>> commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the correct PON
>> compatible") changed pmk8350 to use "qcom,pmk8350-pon" compat for the
>> PON device, while sc8280xp-pmic.dtsi still has the incorrect
>> "qcom,pm8998-pon".
>>
>> Another example is pm8280_2_temp_alarm device, which uses interrupts
>> tied to SID 2, while having SID 3. This can be easily left unnoticed.
>>
>> Employ a small amount of C preprocessor magic to make
>> sc8280xp-pmics.dtsi use standard PMIC include files
> 
> Preprocessor magic is disliked in DTS. We allow only simple defines, no
> undefs. Sometimes some nodes or strings could be concatenated, but in
> obvious way. You should not parametrize it and have different, generated
> labels in DTS based on something coming external to that DTS.
This again begs the question, is it time we start moving parts of the
dts code to be autogenerated?

Should we keep a separate file for each SID?

Or should we consider the SPMI 'interrupts' implementation flawed and
work towards one that does not require a SID to be specified within?

Currently it's:

interrupts = <USID PERIPH_ADDR>>8 IRQ_WITHIN_PERIPH IRQ_TYPE>;

So the first two cells are effectively useless and can be retrieved
from the parent node and the reg property.

Getting rid of that would solve a decent chunk of problems that this
patchset concerns.

Konrad

> 
> Best regards,
> Krzysztof
> 
