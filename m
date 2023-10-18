Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A217CE89D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjJRURY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRURX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 16:17:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414D125
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 13:17:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so81955e87.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Oct 2023 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697660240; x=1698265040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3NJUMrDjBU3byV16K9U0/VADUEPkW9PWtdnemsvPE=;
        b=DWWHs8UeEPUZmyWWrVZRmEhcEV8WkTlvwE1OLr6Z63Vh2H/WyBXscJZN5XQruxjis9
         eayECUFYTPHiFv6pAoTzZ1qiw0O5nYHQli/GTCVM8tTSJfedb43sMxMKNBUzmuA/lAll
         SATXX2qand7o+q0LHPrjpUqUNZI2TesX+C5ujfmwxDvFcGQm4OihPB70pdwoDSYE641R
         wQMeotc9he7+roPqU+rl+qrVKlqqsVMaSyqiAk7HONxcBYJV/2/dSVgX8grr/Y7kd8bV
         /KQCFHwRBinwSeKKHsmPw9vXx9ZGkL44Qj3EYAsLmOff5ubvrhoP8dfSCFrVASuf9fc/
         c4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697660240; x=1698265040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3NJUMrDjBU3byV16K9U0/VADUEPkW9PWtdnemsvPE=;
        b=kvC5bwJqxbNu0TuGXEZh4/CVjIvaJzEY5pRYdEOfg3WTM0MnG47puMjhRvfGmWtzuU
         qZNPnbFtScFBMNqZUER6zm8VAzBf9JqrYsbwfr9cHdJWqkIZ7Un1uYB9ZkMHtkbFUfgY
         yHEKnWUiU9FelzsZHB5YgIg5/8Svt2TyFlg4bW3tl3VhUKd/ED+xWyAKZfgsYS+TysaL
         ToydgcZPyUB/Pb22R/X3glz0kEMUTYywrMuJmATD5+S9qHyaducX1BLPIdDHFfPGknfH
         Z5bXzto4OYshlatLkrRUPViqskKrITjxNKckF8jzRdGsLzYLeVQshOW1JgOUVs9qq04O
         LhDw==
X-Gm-Message-State: AOJu0YzxrS720q6prCj2wDXNHq8ZSNcrHu0aUnWebdY5TnxO4CxSUNR8
        Ekvn7X1i7qNqAFYfPn+t+DlnCQ==
X-Google-Smtp-Source: AGHT+IHZdpeLyJD4QGbEa/SXZTiImOc1XIVZW9/SWzkUvsh1PU5KK/ZjOgGRaY8L8um6sUiDmzbVyA==
X-Received: by 2002:a05:6512:ba9:b0:507:cd54:e93e with SMTP id b41-20020a0565120ba900b00507cd54e93emr143176lfv.2.1697660239552;
        Wed, 18 Oct 2023 13:17:19 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d13-20020ac25ecd000000b0050799f689ddsm831295lfq.200.2023.10.18.13.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:17:19 -0700 (PDT)
Message-ID: <6ac842b8-5fcb-4094-8488-4d6e250bf102@linaro.org>
Date:   Wed, 18 Oct 2023 22:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8350: Fix remoteproc interrupt
 type
Content-Language: en-US
To:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231018-nia-sm8350-for-upstream-v2-0-7b243126cb77@igalia.com>
 <20231018-nia-sm8350-for-upstream-v2-4-7b243126cb77@igalia.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231018-nia-sm8350-for-upstream-v2-4-7b243126cb77@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/18/23 16:25, Nia Espera wrote:
> In a similar vein to
> https://lore.kernel.org/lkml/20220530080842.37024-3-manivannan.sadhasivam@linaro.org/,
> the remote processors on sm8350 fail to initialize with the 'correct'
> (i.e., specified in downstream) IRQ type. Change this to EDGE_RISING.
> 
> Signed-off-by: Nia Espera <nespera@igalia.com>
> ---
Hm, apparently 8250 and 7180 have the same thing.

Mani, could you elaborate on this?

Konrad
