Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3276F7D38
	for <lists+linux-iio@lfdr.de>; Fri,  5 May 2023 08:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjEEGrX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 May 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjEEGrW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2023 02:47:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9B10C
        for <linux-iio@vger.kernel.org>; Thu,  4 May 2023 23:47:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso2080892a12.1
        for <linux-iio@vger.kernel.org>; Thu, 04 May 2023 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269239; x=1685861239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvgN318sT0yfBIN/aP/qcfyseQBG87rA5CSxzTBMcCg=;
        b=LlmHlROVf+CF/F+YYmB7vT5vPFDolgM2wqHp5gsFmU3cvKBtaLw28AXBOWOb7thKXj
         aaPBM9chfc7Oxma9ovvDYfZHTQfCEg/nqgZBVGV6xfrHwOH0ZfiEpS3v6NoiU9R5atrx
         ryO2Bj4A6p2Ytz5ZSlD8o7yjFSJgRiEy5SgKGa7wQP8DmXZ6jypiLsK705FJ/95iXNLN
         UNiuwlHfo7Y9GTG2KH8lEF8ri7P29HmEHHQeBXXxcGnIdSobjCp40vubYp7E2x49FnHy
         4o4k32DyLHQWV5FtURMQX13LrZ291YkhrZGRH/6mpMECANuc/RJBTPqELhiGum5LLxGy
         +AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269239; x=1685861239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvgN318sT0yfBIN/aP/qcfyseQBG87rA5CSxzTBMcCg=;
        b=eIBWy50Pl/tRwOYtPffbvvgzPVC5SHUJ0Vajiz7Jow/XDSyL9sTdY3QfLiL3HAygmm
         DDo9wgYvSTQvxek7YCGid9YY+bfwDkuHFfzmedg8OLlCI9HLOB7WgpcoeFQcmmTtvx6K
         Z3ztwl/BZUwHPNU+qWGmBvoFkgQX1FLerKyS9IhNVulPeZgIwDzySrHXlVV8ds9qQLoc
         bltb05cAG1Ez5hW6SOO/kS8D2y+0b/ZMeR7isG9XMjU8GbVP8soJnhAV8m9DZOyTt0UZ
         xK4XcKSrrjIBPaJ5/fFkVPs9WeNVMsPfNYLNTGHZcGfT84+yzGdcKnr5B3pN7ikTLVhO
         fj7Q==
X-Gm-Message-State: AC+VfDxaWBZax5wUSAaRHdwLc7NHhbpM1l5TIJMtG/WgRPC2euSw1RGV
        hL4zEcIYBLGE2CwrWu9CoG0mOecsH5IhTYWU8Ksdow==
X-Google-Smtp-Source: ACHHUZ617oSGRYLQ033DYm8gUv1Nc/kxyw6P01hhEkt+ijKxYBRPZhkX/hcblYpLaINYzuWfHJy1mA==
X-Received: by 2002:a05:6402:1a48:b0:50b:c3bf:c9ef with SMTP id bf8-20020a0564021a4800b0050bc3bfc9efmr597880edb.40.1683269239274;
        Thu, 04 May 2023 23:47:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402516c00b0050bd2f16ef5sm2657796ede.84.2023.05.04.23.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:47:18 -0700 (PDT)
Message-ID: <0f271a02-dffe-876c-3e41-5697c5917503@linaro.org>
Date:   Fri, 5 May 2023 08:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings:iio:temperature:melexis,mlx90614:
 Document MLX90615 support
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20230504194750.4489-1-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504194750.4489-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/05/2023 21:47, Marek Vasut wrote:
> Document support for MLX90615 Infra Red Thermometer, which seems to
> be the predecesor of MLX90614 . There are significant differences in
> the register layout compared to MLX90614, but the functionality of
> the device is virtually identical.

Subject: add spaces after each prefix:.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

