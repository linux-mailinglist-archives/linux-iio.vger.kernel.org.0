Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF78E6D4514
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDCNBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjDCNBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 09:01:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75A3C39
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 06:00:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ew6so116927273edb.7
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680526858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16UcNG/PukjzRElXQ0FZ/prdEavSXuL0hY9oDia7Fqw=;
        b=eycy1+5anorySr0EFsfJZnLN8eQhIR5TfCplDiItBZdFqBp2M6BsniseXTJiP8SoAS
         pSN8Bk+cdLzpMkjXTcvNgyt4LWQbT1STGcJ1VmYAFhbKbWgOACfOQDft9s7L4ueR7YUY
         Ppl09mPH+/NKn+33LmC/c4165oi+RSn9dJip2JCgOwhiZFWqVSx8cntBiPvFPRXwAbym
         VpTgJC5Wws9vHFG4EGWzl2IFCuE+i8ZdbFqGXlk+b+8ahyeKxOvCDhgr9/Ekn3DHHHc6
         QZHVSsfHj/eKd1nXglpsL3+DRbzgTvcavCB1S1MuKsUrlhT0Ef8wJJmCoV2jeQq7iJ/F
         AWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16UcNG/PukjzRElXQ0FZ/prdEavSXuL0hY9oDia7Fqw=;
        b=kIFgNZABol0OzoNAiYVq37EfoMW3qH+Vos2GxQbcq2LI4sHV2W5KzCeVJeef0iMwuo
         T4SECMvzSOXZNV+fY8CPSH4D8PzN1A0QDVcpTe1WbRkIHuw85ZcLryfukXTvGVIe86WS
         CnxoZ858Dxk12tmJIErh+5OaulFQyB9kOZ+xA12LJVGe8pwtrnxPbDU69jE2o02/RWPj
         uRpTF+OddgotSBwuJgqo/+63fZHfmOX/1PfzjfLu0uPNjIk0rwP3REddSywZ4n7P9c7v
         XOQv3XyJ2AHkpMOcxloe3AKVEfqS09dLIMHUCRfOrcs1zuxTCNySti0VvEIDHPXSc7lo
         woTw==
X-Gm-Message-State: AAQBX9e5gHWjL7EHyYvsn/aaLqCz3N9rsclQkwtdb+phUqHChBjr+0si
        18an/+8Nm0T5AAIr6zqnzEmLdA==
X-Google-Smtp-Source: AKy350b2E4l2oBqoAIHFcKHDtPoNN3TqQLCC/1CYg/oSDuyx1JvMR7UiSyE/Rixg0Bz1LHvkV/VLUw==
X-Received: by 2002:a17:906:bc57:b0:933:12d1:d168 with SMTP id s23-20020a170906bc5700b0093312d1d168mr33724368ejv.10.1680526858206;
        Mon, 03 Apr 2023 06:00:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id xb7-20020a170907070700b00948c2f245a9sm672737ejb.110.2023.04.03.06.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:00:57 -0700 (PDT)
Message-ID: <d30402fc-d7a1-f0bf-2f8b-04b4982b53d6@linaro.org>
Date:   Mon, 3 Apr 2023 15:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/22] arm64: dts: qcom: remove duplication in PMIC
 declarations
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
 <10626c79-46da-3f66-0327-66576b3e5f2c@linaro.org>
 <c6f20137-299a-afb1-c42d-35f7386b1e27@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c6f20137-299a-afb1-c42d-35f7386b1e27@linaro.org>
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

On 03/04/2023 12:44, Konrad Dybcio wrote:
> 
> 
> On 2.04.2023 11:55, Krzysztof Kozlowski wrote:
>> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>>> The sc8280xp platform uses its own copy of PMIC declarations. This can
>>> easily end up with the issues that are fixed in the main PMIC include
>>> file, but are not fixed for sc8280xp (and vice versa). For example
>>> commit c0ee8e0ba5cc ("arm64: dts: qcom: pmk8350: Use the correct PON
>>> compatible") changed pmk8350 to use "qcom,pmk8350-pon" compat for the
>>> PON device, while sc8280xp-pmic.dtsi still has the incorrect
>>> "qcom,pm8998-pon".
>>>
>>> Another example is pm8280_2_temp_alarm device, which uses interrupts
>>> tied to SID 2, while having SID 3. This can be easily left unnoticed.
>>>
>>> Employ a small amount of C preprocessor magic to make
>>> sc8280xp-pmics.dtsi use standard PMIC include files
>>
>> Preprocessor magic is disliked in DTS. We allow only simple defines, no
>> undefs. Sometimes some nodes or strings could be concatenated, but in
>> obvious way. You should not parametrize it and have different, generated
>> labels in DTS based on something coming external to that DTS.
> This again begs the question, is it time we start moving parts of the
> dts code to be autogenerated?

Do we auto-generate C-code? Just a bit, but in general no. There are
exceptions but coding style is here clear:
https://elixir.bootlin.com/linux/v6.1-rc2/source/Documentation/process/coding-style.rst#L828

Pre-processor generated code should be narrowed to some cases or simpler
structures.

For DTS we actually are even stricter.


Best regards,
Krzysztof

