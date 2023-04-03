Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F196D414C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjDCJwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjDCJwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 05:52:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE810401
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 02:51:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g19so24162490lfr.9
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQBY05AOjaIMaj3OfW7f9Js5C948ogr/TmDq8HawSXE=;
        b=PR85roNO69i75rd5vzOUAO8QRkmNr4yEYMnXfaNYOEtvanhiTeK+NYERofuybvqpAt
         DL/8yNL34tpgkab+5WASTBrmbcugQs+b8JEXghhZnXpqUK/HVKRGtu5aup2+aY9PPuMq
         mfEmgQcuOW4VBeGhbu5ANqoAEHT7n8kwHkSheWuJXWCXyyTVzOfvuytQXyBHNXRhOxrJ
         thk+bVwNsMvYueaXxgUS5dTytirMfZsc6JZm9aOr6ekMBVj3PgonA8ry32qGpSnMmArw
         vrMYNs7A+0rY4ZiYY9tJOxE7McxlptWKpDYWhk3HFnAQLTk1cAKQXrDxtvAaCa5pd/Ul
         UTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQBY05AOjaIMaj3OfW7f9Js5C948ogr/TmDq8HawSXE=;
        b=bf83iUMYsWjcPV9QYysjEizgN+lE2egBWBn9lf5ycvwGVmhy5S+UTZ7Sv3nhzN5SwA
         LA1gZyYNQF1/f4cCWMYMbJcVulIVIIHcssDdCqby6GzOxBDszLJi1F2BhR1pXLiGG7uA
         ZEfZt96KQ26eSiPHKyVr5sKapldMb7+uAXGYAs9hbd9cR60/XdoKpZjKJSAXSewy+wFI
         R6McSZqXKTbva0tWvpInkbCBFNdFgbkdDVJed6Kr4afx7foGFx2T3/qPS56wGdGmrUjS
         SCErYUAQqQVCwp2BTlAtiqxOiK4xdQ6i4byAez5DwjG6aBzlOHTslzE9B7QjpDanxpFz
         gPyA==
X-Gm-Message-State: AAQBX9eQMcfzGvHWiYw2c6o9c04Qa2/61T84o9VGBK0fJZk6q2QCj0gn
        ta63AacDF2CUn0H2GIfymSGF/Q==
X-Google-Smtp-Source: AKy350Zmy+TIvkUh34TNtpGTgMU5rLvc+FQOvXpVfUFOF8O+EO+a+uf2iWQrDMC3B4ZOxj7rUQ8W2Q==
X-Received: by 2002:ac2:52af:0:b0:4dd:b766:37ae with SMTP id r15-20020ac252af000000b004ddb76637aemr9290270lfm.13.1680515452057;
        Mon, 03 Apr 2023 02:50:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g3-20020ac25383000000b004e849f6836csm1665810lfh.167.2023.04.03.02.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:50:51 -0700 (PDT)
Message-ID: <4c4450b5-28a3-0a4d-ccd0-5ec96c2ded82@linaro.org>
Date:   Mon, 3 Apr 2023 12:50:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: pm8350b: fix thermal zone node
 name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20230401220810.3563708-3-dmitry.baryshkov@linaro.org>
 <47efb05a-d1e7-a3c5-c423-4eb53fe86386@linaro.org>
 <33430a31-b9da-5f1c-bae0-9ec6f24fda99@linaro.org>
 <f31cfa7d-08cf-efc1-322f-a8e4bbe76476@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f31cfa7d-08cf-efc1-322f-a8e4bbe76476@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 03/04/2023 12:09, Krzysztof Kozlowski wrote:
> On 02/04/2023 13:02, Dmitry Baryshkov wrote:
>> On 02/04/2023 13:34, Krzysztof Kozlowski wrote:
>>> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>>>> Correct the thermal zone node name to remove the clash with
>>>> pm8350c.dtsi. Remove unused labels.
>>>>
>>>> Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
>>>
>>> Please describe the observable bug from that commit being fixed here.
>>> Any future clash, which did not exist that time, is not a bug. It's future.
>>>
>>> Naming changes here are more a matter of style, because the old names
>>> were correct according to our coding guidelines, just not precise (c
>>> instead of b). But node names anyway are not important from the point of
>>> view fixes and adding such tag will cause a needless backport.
>>
>> It is needed. Including both pm8350c.dtsi and pm8350b.dtsi will result
>> in one thermal zone overriding another one.
> 
> I don't understand. You used future tense "will", but we talk about
> past. So where is the bug in commit 5c1399299d9d?

At that time there already existed sm8350-mtp which included both of 
dtsi files.

-- 
With best wishes
Dmitry

