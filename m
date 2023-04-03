Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D766D418B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjDCKHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjDCKGu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:06:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A17113FD
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:06:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so115071060edc.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vxf+j7nwp38oMPxfUAn6vX6VpUdYcFQH7ABonjYa1h0=;
        b=jayDUas/Z/vecvYgBcuWnjQjOAKb/6d5i2DO3mu7xBYQsPyyNxTs3gNtmT0RrxZP9u
         LK3hDLKZBqZKKCzwHCQ8yqLWaVraY9FUlScUZWcuE5SdjfrSjwqyyrjpLjCmrHuKU8+L
         99OMbrBOJ8OLKBbp7DNB1caNOEe62rvgtLILPeqJEKcDYCnSeB3ligsI0MU5sibr8rn7
         ZckRRmj6fcLERGTsoaz9VZfbEkLbweX5nHYnR5tSJpjjCSltAl/ssDp4sNlOOk+3CCDc
         rvkcvKizPMvBk9qFcU35hTOVdYOyp7mPrqGQsL87GTyEqLq755fhRwJzT3gY+fSYotPt
         tOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vxf+j7nwp38oMPxfUAn6vX6VpUdYcFQH7ABonjYa1h0=;
        b=EQKdipQVCORdwVTWiCVu7XiGio3Ss+/6MqdijvBsp5nrg8LLBw2jsRIyBxKg6NlTxa
         CNftPGY6L6ARJd1DVgl1tfPn3fY9Q1JgetlIZd7faJ89bD8ml/c1xZVIGdCbJxIC3mG6
         iDq8z49+eE4v2e0HIfr281G5hNiz0bUyyGP/u8dm3PRutZMNtAXgCiclct+0ep9T+gm7
         HhY1IKLm0RxkgLMvcYnsU6Pd3pxW6JTg4ltPas3K45xm94OT9qRlxYQhM5pCEKlh3XnZ
         VYRw+YCydoWjupoUnxDa0Ejw+7m07nPlucT8a7oEQ3Twx+o3E4q4EaddlABZ9Txk2Lip
         A87g==
X-Gm-Message-State: AAQBX9dg8bn4BHPSVxgSYOU4R4G3emGkBpaJvhYH+Ci4Q7wa4R+heXSu
        CuqOPV4+Ekko2NPVM5sLF+5VAw==
X-Google-Smtp-Source: AKy350bcBVTyphXmxrUGT1mKHubBEY4YTGKeKza+kmtP4dQZThvRP+prbPBPAIHl038dezT4p9SMmw==
X-Received: by 2002:a17:906:6849:b0:930:e3a0:8636 with SMTP id a9-20020a170906684900b00930e3a08636mr34538060ejs.57.1680516405039;
        Mon, 03 Apr 2023 03:06:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b00882f9130eafsm4257902eju.26.2023.04.03.03.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:06:44 -0700 (PDT)
Message-ID: <d1a9d857-4a2a-f767-fb27-dd368b27c848@linaro.org>
Date:   Mon, 3 Apr 2023 12:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: pm8350b: fix thermal zone node
 name
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <20230401220810.3563708-3-dmitry.baryshkov@linaro.org>
 <47efb05a-d1e7-a3c5-c423-4eb53fe86386@linaro.org>
 <33430a31-b9da-5f1c-bae0-9ec6f24fda99@linaro.org>
 <f31cfa7d-08cf-efc1-322f-a8e4bbe76476@linaro.org>
 <4c4450b5-28a3-0a4d-ccd0-5ec96c2ded82@linaro.org>
 <cdba9174-6de1-137f-e902-3ae2f4a78ee9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cdba9174-6de1-137f-e902-3ae2f4a78ee9@linaro.org>
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

On 03/04/2023 12:00, Konrad Dybcio wrote:
> 
> 
> On 3.04.2023 11:50, Dmitry Baryshkov wrote:
>> On 03/04/2023 12:09, Krzysztof Kozlowski wrote:
>>> On 02/04/2023 13:02, Dmitry Baryshkov wrote:
>>>> On 02/04/2023 13:34, Krzysztof Kozlowski wrote:
>>>>> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>>>>>> Correct the thermal zone node name to remove the clash with
>>>>>> pm8350c.dtsi. Remove unused labels.
>>>>>>
>>>>>> Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
>>>>>
>>>>> Please describe the observable bug from that commit being fixed here.
>>>>> Any future clash, which did not exist that time, is not a bug. It's future.
>>>>>
>>>>> Naming changes here are more a matter of style, because the old names
>>>>> were correct according to our coding guidelines, just not precise (c
>>>>> instead of b). But node names anyway are not important from the point of
>>>>> view fixes and adding such tag will cause a needless backport.
>>>>
>>>> It is needed. Including both pm8350c.dtsi and pm8350b.dtsi will result
>>>> in one thermal zone overriding another one.
>>>
>>> I don't understand. You used future tense "will", but we talk about
>>> past. So where is the bug in commit 5c1399299d9d?
>>
>> At that time there already existed sm8350-mtp which included both of dtsi files.
>>
> pm8350[bc] both have a node named /pm8350c-thermal, which means one will
> get overriden with the other. Since we sort the includes alphabetically,
> the one in pm8350b.dtsi will never be taken into account and hence the
> temp alarm will never be associated to any thermal zone.

OK, if I understand correctly, this overwrite of thermal node was
already happening at commit 5c1399299d9d. It looks good then.

Best regards,
Krzysztof

