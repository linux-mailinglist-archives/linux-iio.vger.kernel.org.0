Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D29165BF83
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jan 2023 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjACL6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Jan 2023 06:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjACL6b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2023 06:58:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68916DFF8
        for <linux-iio@vger.kernel.org>; Tue,  3 Jan 2023 03:58:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bn26so9741533wrb.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Jan 2023 03:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TM/fv8r72lGY1GkkNJAibywbzPYZQ5pCj0+GnYUBcVE=;
        b=S9pzhbApE4DSBcx8w0AJB2s+gmZXZHMhAw15lib1KWhbytevy9S8uApTmEAXV8l+DO
         t2lkOLId5MBnR2GrBjxK5tuOSIIZM873lOa0Vf2ESmAxxbVjfBvqw0SzQ3PexlH+VHQk
         RVrBZi5lXAbd6f6sfydjbOZ9JncrgY75S+hukiYVr4Fxyv6hBmKOjmNnj3R8KEvNzdZ3
         i4Nq+FxOYTcPr/tBClvHOAasNcfQkb2zMTYLU+jXRFSZwSc+lBWnPSmqlThQVbLpdLfe
         EdYSgb2LJ+sfF1SmlA3YsnbHFJNun3HFiigamI+rf6Ibo1tWfM/xpCYL5P2pPNuDfnTU
         OBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TM/fv8r72lGY1GkkNJAibywbzPYZQ5pCj0+GnYUBcVE=;
        b=38MnlqEgtSa4TWxVzDwNCx04/nIBseFrUEqxJOXmUxAqAIR34YnlPhelKZ5CNymnEF
         jA8Hsa4yknMw5/Qo5l3jVGiflDaBKYMWZ0jzUlCox5a9kVwB1tqSNdDH+8cJRLYaSs8L
         xLFXsgiC67wRXHpN2ZPYfFv76OFwWM8fulsiNNYLWwC0HQTeSFfA9IloNEtk9smt87FQ
         fi7bfiWv7goa1THJ7h59GZtTdLcCfzPGaH6ENj45gGZQUeJftYQC7s81mgRS4eGFOQex
         wnlx9u9nm5yx6BEcrXoH28ijtS6IQiwU6CXsUTDVDF5RFuuRIWCKBgAU94kQ8LriYAqz
         eyTA==
X-Gm-Message-State: AFqh2krkcJBrsQ2MYWJJdIWRWhIlDDW1dqepIvIVBg8vyR1PSyBOE2+B
        VCssd7Ehr0z2ZYmr46D4NBu2Cw==
X-Google-Smtp-Source: AMrXdXto5B4pnQxpO4E1hO08Dv+wSKzyJnlYGGjudihTtX6h1rcgkc8jXUuQ7G9YvGMckIGAIgFk+g==
X-Received: by 2002:adf:a159:0:b0:284:356:3400 with SMTP id r25-20020adfa159000000b0028403563400mr18099556wrr.30.1672747108877;
        Tue, 03 Jan 2023 03:58:28 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm31073289wrq.10.2023.01.03.03.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:58:28 -0800 (PST)
Message-ID: <c5ef569d-0f36-19ac-da53-3a5acdca4165@linaro.org>
Date:   Tue, 3 Jan 2023 11:58:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles
 enum ordering
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        jic23@kernel.org, lars@metafoo.de, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, evgreen@chromium.org,
        gregkh@linuxfoundation.org, a39.skl@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
 <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
 <1fac581e-ef02-4576-0dbf-67662a29f724@collabora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1fac581e-ef02-4576-0dbf-67662a29f724@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 16/11/2022 08:50, AngeloGioacchino Del Regno wrote:
> Il 15/11/22 17:42, Krzysztof Kozlowski ha scritto:
>> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>>> Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
>>> alphabetical ordering.
>>>
>>> Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible 
>>> strings")
>>
>> It's a style, code readability, but not a bug. I propose to drop the tag.
>>
>> With that:
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>>
> 
> Should I send a v3, or is it possible to drop the tag while applying it?

Applied after dropping fixes tag..

--srini
> 
> Thanks,
> Angelo
> 
