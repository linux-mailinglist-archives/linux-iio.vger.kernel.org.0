Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4074C6C5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jul 2023 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGIRig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jul 2023 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjGIRif (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2023 13:38:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5FFA
        for <linux-iio@vger.kernel.org>; Sun,  9 Jul 2023 10:38:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso59530601fa.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Jul 2023 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688924313; x=1691516313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKdFK7UFqnvYacu1+A6rrJuMR3ECAGc1EkArluB3bgk=;
        b=EIkf7oR5mHW9ET9xqLGWmH4Ta4buPeq5JYwnaGxV7KgwHJhjiZAAn+pwWuKxkK85er
         FHdhAaPDbMalggKP+KMlk2RZeNPqNfSdPHxXe7wGgQjX7+aEWFxH2Yi8mYkh0G7Uz8vf
         GaF5eP91LxL2tP0QIV4ylOgkaw/q8hietq+8CT2P3ofhn9Q8DDgPBA+TGNcjdWm4eoa2
         ZOuKYZ0V+IbiqZ0S9eBkUstRhJfMMuGgZPtnhfI2j8fHE3ErWA8S9kel41lJGl3d5Pgb
         t6JSpp4glxoK1C2ESCIMLEliDRw+HAkoWo12C/LvTKHWZFv9rmegd8+77qRq6dHcXXoj
         +NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688924313; x=1691516313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKdFK7UFqnvYacu1+A6rrJuMR3ECAGc1EkArluB3bgk=;
        b=cQv1ZtVfyUNrPxN/7DRgJahmO/GELi4bDxZGUxtrWZD3Bkwbga0vsJJwc/6Pe6ZF3i
         RqiAsGUv/YAW+ms7RnSoe5I6mYFLTN64d0I3goKctOgF1u8eHEt8n3mrXkJltOE+6ZZM
         xuygSNeq6JemGFjclnsjVH0jxaXhfVl4qY7EEN7wFq0ZtU9/YOgJ7KitXdEEDFlhhMxW
         gLgXp3iN935TPuBojzQ1g8KMERzCa7mzeHjJgXHk0tJKJvJAV0g+Z8RVTJ0xBBVBrYiD
         tFp1q0/V99ODwymf4f4vUdH+wuDy5WUtBgFhN7CKTCIWZfrlDad/4GIY+tn54yJLdLfI
         DuKw==
X-Gm-Message-State: ABy/qLbtepfKUzmprLcCHcJiPBuQUVttauRKDwiJc07LYUORzDM/pkx7
        a5Q7REZhM82cqRaaLoQ5tQy9wQ==
X-Google-Smtp-Source: APBJJlHNb+8tglQs8vHY4lZ2CClvauiq1wbcrsR8u43ZfraYF4Na+06BhXn1BYHVWuszx3GTUShS9A==
X-Received: by 2002:a2e:b166:0:b0:2b7:117:e54 with SMTP id a6-20020a2eb166000000b002b701170e54mr8428516ljm.4.1688924312739;
        Sun, 09 Jul 2023 10:38:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b009894b476310sm5014978ejr.163.2023.07.09.10.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:38:32 -0700 (PDT)
Message-ID: <3b417e21-1726-a026-cd53-e68cc49b56fc@linaro.org>
Date:   Sun, 9 Jul 2023 19:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/11] iio: adc: qcom-spmi-adc5: remove support for ADC7
 compatible string
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-6-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-6-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> Now that usage of "ADC7" name has been replaced with usage of "ADC5
> Gen2" name everywhere, remove the "qcom,spmi-adc7" compatible string.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 4 ----

Your patchset is not bisectable. Neither this patch nor cover letter
marked this. This is not correct and will lead to broken kernels.

Even if not considering bisectability, this basically breaks the ABI
without any explanation and rationale.

Breaking ABI just because you want to rename something, is not the way
to go, so NAK. Sorry.

Best regards,
Krzysztof

