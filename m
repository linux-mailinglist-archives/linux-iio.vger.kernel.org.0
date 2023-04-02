Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03536D369D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDBJoc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 05:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBJob (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 05:44:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7619AB
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 02:44:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er13so65263629edb.9
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680428668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vn5NEjd5HxbmJ5xnivXojSVCvItNCyhz+rzufNyUSX8=;
        b=UeMgt12la9dzr72IcV5i6pLKXlWfuOQPANo1sTu+HocyldeCdIfWhR2E7VddSfDr7b
         y0yvKxXbRQx/dwNvd13T2GkPWi8UnPeFM4UsYPQBhBndcR4URSrT36O+9jFRquZnGM4W
         SygoPqFvJUGqZ3k2abPEgt3nGfvNOORqa6ZLmwf/FReduYnj6MyPd5SaUnAtwGFhYO5+
         SHIyRAi5O5/a9b+OyhQenau6GBysxjPsILtArM34zPcYbBlSObjgABhJC1XZXvtBHEwt
         8WomHY1oPD1lvc+zJg5knt8HMeg0z7ibPFZOYF2EWdWUqho5JgpHogly73QRQOjyFG7m
         LphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680428668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vn5NEjd5HxbmJ5xnivXojSVCvItNCyhz+rzufNyUSX8=;
        b=5DQeVFmYvMUi9W1VaD4uZU858+upFpHB2zmqe4C/in3GT0x2QmILy397kASifs/cZs
         WEG9xK9Tuz3ZLijvd8CemlJw//ebx3TYQld1X5B6knlbrfsrdwi65fVBEwFDu5kHcTM4
         DxeHwvqqDJpaGumls/Fab3XqmcSZ3xpqNMpqW9gM9pichxqJX3ZzVaNbIkOW9UVTVNT4
         JnqmFYLmkfD2DDeQwasVTDIP2UA3lumjSgX4sWdmt5zVz11BbbNPtpq00dY6hUJPrOQG
         VvvfaIWd4RtkU+bovM6ygdSfaeDVl/7obXUSuqCJxj9CYTs0w38YzJSlGBfue16PQS28
         HO3g==
X-Gm-Message-State: AAQBX9eE3ylYShW7r2Cc6PZVeKlrhLUUMyyeJe74Zmr0X/mIXUrD1ekR
        yZ5Iu+4LC0+X1nNkEr3Xi9qCeQ==
X-Google-Smtp-Source: AKy350ZMwsCRQlnRgKv7v+6WOTDv5YiGE0CHA/yKzYVpxAcQqLEcK9k4443zKfTFU2IkMRh1CIxNyg==
X-Received: by 2002:a17:906:8a41:b0:92b:6f92:7705 with SMTP id gx1-20020a1709068a4100b0092b6f927705mr29131753ejc.40.1680428668508;
        Sun, 02 Apr 2023 02:44:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7f7f:6a30:7a20:94d5? ([2a02:810d:15c0:828:7f7f:6a30:7a20:94d5])
        by smtp.gmail.com with ESMTPSA id b17-20020a50b411000000b004bf7905559asm3106582edh.44.2023.04.02.02.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 02:44:28 -0700 (PDT)
Message-ID: <127c7d41-b7dc-6c9a-0653-f5bf2a626907@linaro.org>
Date:   Sun, 2 Apr 2023 11:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/22] arm64: dts: qcom: pmk8350: allow overriding the
 label
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <20230401220810.3563708-10-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401220810.3563708-10-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2023 00:07, Dmitry Baryshkov wrote:
> sc8280xp-pmics.dtsi incorporates a copy of pmk8350, but the dts files
> use labels following the markings found in the schematics. Allow
> overriding the labels in pmk8350.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi | 13 +++++++++
>  arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi | 14 ++++++++++
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 28 +++++++++++--------
>  3 files changed, 44 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> new file mode 100644
> index 000000000000..1c81269f0783
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/* cleanly revert the effects pmic-dyn-header.dtsi */
> +
> +#undef LABEL
> +#undef _LABEL
> +#undef __LABEL

That makes the code less readable.

> +
> +#undef PMIC_SID
> +#undef PMIC_LABEL

And it keeps growing and confusing.

> diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> new file mode 100644
> index 000000000000..75f0448568bd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/*
> + * Preprocessor symbols to assist in describing PMICs which have configurable
> + * SID. All effects of this header (or its parameters) must be reverted in
> + * pmic-dyn-footer.dtsi.
> + */
> +
> +#define LABEL(name) _LABEL(PMIC_LABEL, name)
> +#define _LABEL(pmic, name) __LABEL(pmic, name)
> +#define __LABEL(pmic, name) pmic ## _ ## name

No, defines in DTS should be simple. This makes it ungrepable.



Best regards,
Krzysztof

