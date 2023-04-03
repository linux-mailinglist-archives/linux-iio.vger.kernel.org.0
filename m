Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0F6D416D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjDCKA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjDCKA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 06:00:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A51B6
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 03:00:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h25so37307021lfv.6
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680516022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/b2mr9DLso7O/8pyyRJ750O0L69iF5ANfkU0tX/dSQ=;
        b=iT1VHtKCiabIWlreiIH2DfjuKbygI/FWVo0g9b2/AeO1URR0BUTJf65c6WbCYG3i8i
         yQ+tjKqnwHz78oslJFBauSzTNg3/Ozm6AyBpnnz9wEUE4UubhwjTKHaevF12F+AR+VRb
         mE8DaubFU0h0a/Ne4TrRxMPFI3ctgBgZJoODSVFfmigOqndKtPTIbJYK6unf6XlZ7P6H
         FXfpbSFAEQqA2sSyqtNkbzQPFVyh4/tFP6H3l/zRXrSMgLJs/Qt9KsXDDWGgdPpk6ySN
         8h3m2C7y1TI0edRyhlnaEoScdOA0uTIm8a1cfh1r2BamA1mZbahq5SreTCfoVy7LSWCf
         TI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680516022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/b2mr9DLso7O/8pyyRJ750O0L69iF5ANfkU0tX/dSQ=;
        b=inXPZQrDPQbbzeTnUtyaTjgwkEi5VlEQF1QXEx7UNWoYqs2PW+skIGSLuCkcN/gbqz
         V88z2Is17Z0LwwqkM/NZww7Y+qgmHzRRDsDAcRFWOGCjc6bgppk2EUY7H6ZxE/blH0J4
         xn0AlxKQp2J5yyIlnykdMkXGSdWTYJoV3q0rehE7h6gWVWJKw1gu56WepaiCLC08HJbj
         Po5haUrrFGFhgYh/2G8joIULJxGq7vH92VjbuHpvBvrg+cZtXaHSy+/fEFCIVVFN841j
         FicrKaYkowI8EWyTOKeL9OQMjSp5ZHk9GLbUAPKpPQqasuSA6BE3118uEZ8xWV/xjaRz
         2aEA==
X-Gm-Message-State: AAQBX9eN6xFRQtMdlidVTJJFCyhs4dSBm7EJcxNSo3c2tsXVK0hzUt2x
        0l9jMnOLYT7RADrABVgHrUbLCw==
X-Google-Smtp-Source: AKy350YWnIoPvTFt270RYeOrqtzdDXhIogEQC45yPWL4NczHLVM0MLWLFUUeRkCR9QqpAvzk430ywg==
X-Received: by 2002:ac2:5607:0:b0:4c0:91d0:e7ab with SMTP id v7-20020ac25607000000b004c091d0e7abmr8492911lfd.28.1680516022540;
        Mon, 03 Apr 2023 03:00:22 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b004b40c1f1c70sm1693279lfh.212.2023.04.03.03.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:00:22 -0700 (PDT)
Message-ID: <cdba9174-6de1-137f-e902-3ae2f4a78ee9@linaro.org>
Date:   Mon, 3 Apr 2023 12:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: pm8350b: fix thermal zone node
 name
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4c4450b5-28a3-0a4d-ccd0-5ec96c2ded82@linaro.org>
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



On 3.04.2023 11:50, Dmitry Baryshkov wrote:
> On 03/04/2023 12:09, Krzysztof Kozlowski wrote:
>> On 02/04/2023 13:02, Dmitry Baryshkov wrote:
>>> On 02/04/2023 13:34, Krzysztof Kozlowski wrote:
>>>> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>>>>> Correct the thermal zone node name to remove the clash with
>>>>> pm8350c.dtsi. Remove unused labels.
>>>>>
>>>>> Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
>>>>
>>>> Please describe the observable bug from that commit being fixed here.
>>>> Any future clash, which did not exist that time, is not a bug. It's future.
>>>>
>>>> Naming changes here are more a matter of style, because the old names
>>>> were correct according to our coding guidelines, just not precise (c
>>>> instead of b). But node names anyway are not important from the point of
>>>> view fixes and adding such tag will cause a needless backport.
>>>
>>> It is needed. Including both pm8350c.dtsi and pm8350b.dtsi will result
>>> in one thermal zone overriding another one.
>>
>> I don't understand. You used future tense "will", but we talk about
>> past. So where is the bug in commit 5c1399299d9d?
> 
> At that time there already existed sm8350-mtp which included both of dtsi files.
> 
pm8350[bc] both have a node named /pm8350c-thermal, which means one will
get overriden with the other. Since we sort the includes alphabetically,
the one in pm8350b.dtsi will never be taken into account and hence the
temp alarm will never be associated to any thermal zone.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
