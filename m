Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98076D44FC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjDCM5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDCM5D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 08:57:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AE55AB
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 05:57:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t10so116785273edd.12
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680526621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9PXbgDl7LeRBeujLG4sJDCnMB4TWVsRHSKuyMeCJLc=;
        b=Ovu9SuSRZuBTPFeZVLE4CtW9jF4sSj8AI99HjwWXOch+RnqponLdZXviwvIFo8d4Ga
         HfKie88WuwpL10J+WMmIdyb+nryWYi+Hvynb3tEJGxaWVSf7hfCKvhbRB1BFaACgNIuT
         mMAmeKPdSvtSMD+YFDtLMNj/ntAGWzz30l4eS9uURoBevGJ4dz0nTIniwp6/YjCkB6Az
         eBqe+OqNnQtOsA+1ue5FcRb5vmY5WZY9QAqO7hWETr5A1YD/56nARDy2GQoTE7KizoYd
         PajbNil5N8AygAcMFA5zN7tNgARwt/KEI1Zak6kSjn54GE8HWFIhEUVytADY33h6omCn
         fJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9PXbgDl7LeRBeujLG4sJDCnMB4TWVsRHSKuyMeCJLc=;
        b=4I36ZYzjstvnTr1/w8dhvG1z0R+il0rB9/GVKb7uj2GgopjVUCuUwDae+anVMdObGd
         726h9kuQUC1Mn1WrFNAwpg53mUxepnVdRsuyn+Kin/ZPwiqmPjNrLzFRj0bPkJQidx6N
         Tc7v8QAaKGWfpwcF/ROBh933Fvoi3Sf+uu2wU7KgdA7Sxo77wF2F5cg9cSPjENgM3fcs
         x17b5o80Sx7WlrfvCA61abbESr9CCSXF61gCNyO+3IXK7ma3/wNQyCQXSVrwdPoISsqn
         NoXdr0fRv12j6LhigFZxa+cseD5Ww/Y4zt2pOWrNHQZPvBGr9ZcoJO3RUKe0KVR9A1mm
         OFWA==
X-Gm-Message-State: AAQBX9enZmivRVQRQBfxNwgGEkpjSt17DRBicannMSyGTEjY1FrWIUrF
        1Oqx4IClgV9vVeLiJzXYbx/h/Q==
X-Google-Smtp-Source: AKy350abfZ6sIteFU0M7hfXJkWONPCgcKYoCCqznwTV3GlqPHt5XHyN3ybOGekoNoWZk7JDL60xBlg==
X-Received: by 2002:aa7:d806:0:b0:4fc:3777:f630 with SMTP id v6-20020aa7d806000000b004fc3777f630mr33601867edq.0.1680526620839;
        Mon, 03 Apr 2023 05:57:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id d12-20020a50f68c000000b004af73333d6esm4605441edn.53.2023.04.03.05.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:57:00 -0700 (PDT)
Message-ID: <46658cbb-fff5-e98b-fdad-88fa683a9c75@linaro.org>
Date:   Mon, 3 Apr 2023 14:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 21/22] arch: arm64: dts: qcom: pm8150: support SID
 greater that 9
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-22-dmitry.baryshkov@linaro.org>
 <af18b9a3-2960-8fbb-0d19-ee7d3b3f89ab@linaro.org>
 <b33337de-1a09-aa72-7f1f-fabf85ddcd9d@linaro.org>
 <CAA8EJprnv0uqEq=uJ8z+Az-izwk-kscXiELVqrP9BPBFQpJE4A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJprnv0uqEq=uJ8z+Az-izwk-kscXiELVqrP9BPBFQpJE4A@mail.gmail.com>
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

On 03/04/2023 13:45, Dmitry Baryshkov wrote:
>> Konrad
>>>> +
>>>>  #undef PMIC_SID
>>>>  #undef PMIC_SID1
>>>>  #undef PMIC_LABEL
>>>
>>> Same comment as for previous patches - all undefs must be gone.
> 
> This means that we can not include two copies of the same PMIC (which
> do have on both platforms).

Consider spi15 and spi16:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi?h=v6.3-rc5&id=7e364e56293bb98cae1b55fd835f5991c4e96e7d#n1045

Do you see it written as #include "qcom-sm8250-spi.dtsi" with
parametrizing the reg/unit address, interrupts etc?

No. Neither PMIC should be. It is not a special device.

Best regards,
Krzysztof

