Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B2789DC2
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjH0MAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjH0MAR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 08:00:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9D13D
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 05:00:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1d03e124so300410766b.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137611; x=1693742411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1vb1NKNxPWmF22t3LyBlcMBv4ZL6aYsl1zImyCmPqk=;
        b=nkU9QDA3ZQPrE80K5WNGyInIxQ+rjGO9+Y4Z8NK3FX1YJWYxfR7fjbDSFwSImABVDH
         mbe2eh0mTre7O4pp4wCf+6X4jRtTLqa2PUZZKoW/ZvG5GF2LO2sed8c7OXzDTFtn3LQ+
         LPZbcQXOI5ABjn1Zq1JssUMUBZp/svujuVqjbJBLcf/ydP0ypHWCa/pCMRvMbKT6r7Xk
         RHvdiFofd8NiFURYeL0gJ2wKwK/4q1ssGyQARjsVPjFKJenIRN9VcAUWg37/GiNyxMm5
         ubi0xkOFN34WVQPEMIKTSyZZwrShzqb8fk4TPyncxI/tDiNojq9UvDAqSgWtnrwrh+mZ
         MlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137611; x=1693742411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1vb1NKNxPWmF22t3LyBlcMBv4ZL6aYsl1zImyCmPqk=;
        b=Fa8eHHkYh4Vf+JBoxkL2/MeX+/k07E2vuueGKQAAaGz3EohIEyK+fy1smReWNBHpZW
         BQj/QUr61MKdTcMSiCsLEVL5JGILM926DvuZKWYN8QdES2x2yJ+5EPQhtMLEoir69v3X
         b3mWJXlHwSvQogjRRRFylN3NvhBsa/LuZ5BkZPgmsw9DJo/v/Jk/cGFt5SWzTVnf3Ld5
         iwSCjVqWkoZi4ECPn0ZMN6aH4NriP5KTkjILHDoeHrvvxg15f/NTxNUk3KHSuRywAvct
         f0Wuxjh3WqZJDl4HrtYaKMCtzmrZU/BGCjpBFWsp32iP0CJFMNXr7Q1uBDGFlOYaq3h2
         raPw==
X-Gm-Message-State: AOJu0YyYGmJUpbY1bmIAAKl65YDsBq1cATPMCWKdkZtUMJCXk5EH4FWb
        v/WaBMGRkEtxTgUAqBRhFJsYBQ==
X-Google-Smtp-Source: AGHT+IHfvkkfwHnTPi8nCl9XpByE/JPq0GfNI6XI37kZ85boixd1ibZVDvSULqUh7Q6KLm4+pQXTmw==
X-Received: by 2002:a17:906:18a1:b0:99d:fab5:e888 with SMTP id c1-20020a17090618a100b0099dfab5e888mr16063184ejf.34.1693137611153;
        Sun, 27 Aug 2023 05:00:11 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id w26-20020a1709064a1a00b009786c8249d6sm3385960eju.175.2023.08.27.05.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 05:00:10 -0700 (PDT)
Message-ID: <e6340d20-40f3-be5c-b4fc-33da59799d91@linaro.org>
Date:   Sun, 27 Aug 2023 14:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 03/38] dt-bindings: mfd: qcom-pm8xxx: allow using
 interrupts-extended
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
 <20230827005920.898719-4-dmitry.baryshkov@linaro.org>
 <39af3ab5-4fa5-5b3c-395a-e86e70bbe803@linaro.org>
 <CAA8EJppw0Kxo3W560ucWey959368M1c8BFnvF4Ggi5XKCOfesw@mail.gmail.com>
 <74dcc5b4-dda2-5de7-9e58-4191a0fb7972@linaro.org>
 <CAA8EJpoWvoNfomMg34cL=h+qBLHQq3bZO2X-02Pcz6oLiKRxWA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpoWvoNfomMg34cL=h+qBLHQq3bZO2X-02Pcz6oLiKRxWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27/08/2023 13:48, Dmitry Baryshkov wrote:
> On Sun, 27 Aug 2023 at 14:12, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/08/2023 12:42, Dmitry Baryshkov wrote:
>>> On Sun, 27 Aug 2023 at 11:35, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 27/08/2023 02:58, Dmitry Baryshkov wrote:
>>>>> Allow using interrupts-extended, which is a preferred form of interrupts
>>>>> specification compared to the interrupt-parrent + interrupts pair.
>>>>>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 10 +++++++++-
>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
>>>>> index 7fe3875a5996..33d9615e63c8 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
>>>>> @@ -37,6 +37,9 @@ properties:
>>>>>    interrupts:
>>>>>      maxItems: 1
>>>>>
>>>>> +  interrupts-extended:
>>>>> +    maxItems: 1
>>>>
>>>> The entire patch is not needed. At least should not be needed. What
>>>> problem are you trying to solve here?
>>>
>>> The main problem is the next chunk, which (currently) explicitly
>>> requires `interrupts' property. My goal is to allow
>>> `interrupts-extended' in addition to `interrupts'.
>>
>> They are allowed. Why do you think they aren't? That's why I don't
>> understand what real problem is here.
> 
> qcom-pm8xxx.yaml lists `interrupts' property under the `required'
> clause. So I can not simply replace it with `interrupts-extended'

Since when? So again: The entire patch is not needed.


Best regards,
Krzysztof

