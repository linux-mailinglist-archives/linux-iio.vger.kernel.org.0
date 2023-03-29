Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134C6CCECB
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjC2AaE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2AaD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:30:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4010DE
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:30:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bi9so18019547lfb.12
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680049799;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtYtLy+iYEQZ9jilb8kqzIHG2ngl3OfZQGZFUbtzZ9w=;
        b=AAZ0w9bsyOwccLyFDTM4ViUYHzP8FZAqm4UTs8ik2KE0E1ZQv8ONcmwK/leUsNonY2
         C/ar0O+fjeiDbhydXondasll0bzXbVK1kftyOfm4KwIHYTtUBg0YjId6J18EyKp1Y/xb
         67muvu6iQuDpfSdNbPrKwbYEtAY5slLTemflXKhPUYlvSJjhWAvJJ3lU+aiNjRWWjxAl
         HQ0tfyNEd/jNCNYwW9J81ldHZDYVQTAn1i3BXjVZypRJgnFGv84sBm3XWQvGQ6JtNcQo
         xr9NLqT9v0FEX5vA02h7FKq9j+GSvOsCngjlrEVah7fdnw6fhZ87/3nbW5NoFU28/+2V
         DRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680049799;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtYtLy+iYEQZ9jilb8kqzIHG2ngl3OfZQGZFUbtzZ9w=;
        b=RsCQvS/56nO/DllJNJCEzoqPhSgYZF+qTf1f+ZPzb5Ba0iHiVEc3lyTR6iqZoOpmoA
         Lf8yiL4BrBb+qupWA+LXnnbfKao7oAZymjjUatNNKDS9Wco9pWQ/zo5bjX0tWjGlcH6K
         SD6K/eys62Bk8iR8xnGgiHGOOLm/g9VFnRkhLmuK0Rvgj9sM5a1JvZ9+QLi9mEKE6jC4
         6BEiBQ0kOC/R0xkmkY01eVQzU/uceieChyNtR+ZtfAUC9Dy8C8I3UIgbW1rrOUfIr67J
         5i3RkAfmnCm7Q6PbDXALo/3MNYujEykc49yvdBuHF4p9HrxRbaNKBwMPETZn/HsksKJf
         yPlg==
X-Gm-Message-State: AAQBX9fmg+SA/tzk+sFaDnr2bFxJ1cO4q/esSOwTBNCV+NNb5fnyceN+
        JMxBWSDGFrwZSZDbIahjrE0b7A==
X-Google-Smtp-Source: AKy350Y9fyMcXq0Xk84PoOwHAHi1V85oVdI9ZmgnEX9+yB/JKW6e0GhAVheH0gP1RN/fHVDTxD9btw==
X-Received: by 2002:ac2:5a4c:0:b0:4dd:a7ab:b148 with SMTP id r12-20020ac25a4c000000b004dda7abb148mr4376644lfn.49.1680049799238;
        Tue, 28 Mar 2023 17:29:59 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g14-20020a19ee0e000000b004dc4c5149dasm5249346lfb.301.2023.03.28.17.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 17:29:58 -0700 (PDT)
Message-ID: <195dddb5-25f7-ac8c-8609-776ed6724650@linaro.org>
Date:   Wed, 29 Mar 2023 02:29:57 +0200
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
In-Reply-To: <9746792b-fd4a-6808-0c6b-4834ffc9c059@linaro.org>
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



On 29.03.2023 02:27, Konrad Dybcio wrote:
> 
> 
> On 29.03.2023 02:08, Dmitry Baryshkov wrote:
>> Employ existing PMK8350_SID and switch sc8280xp-pmics to use
>> pmk8350.dtsi to reduce duplication and possible discrepancies.
>>
>> For example, this changes sc8280xp platforms to use qcom,pmk8350-pon
>> for the pon device compatibility rather than the incorrect
>> qcom,pm8998-pon.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
> Bit of a loaded patch..
> 
> This could probably go like:
> 
> 1. outer join 8280 on pmk8350 (for feature parity)
> 2. rename all labels in 8280 to 8350 (for 3.)
> 3. switch over to the actual 8350 file, remove 8280 (with Fixes:)
> 
> [...]
> 
>> +#define PMK8350_SID 0
>> +#include "pmk8350.dtsi"
>> +#undef PMK8350_SID
> Not sure if this undef is necessary
It looks like it would be for multiple instances though

Konrad
> 
> With or without all that though, the goal lgtm..
> 
> Konrad
> 
>>  
>> +&spmi_bus {
>>  	pmc8280_1: pmic@1 {
>>  		compatible = "qcom,pm8350", "qcom,spmi-pmic";
>>  		reg = <0x1 SPMI_USID>;
