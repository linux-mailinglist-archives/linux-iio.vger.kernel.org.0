Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E412619FD6
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 19:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiKDS13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKDS11 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 14:27:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D6FAC7
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 11:27:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l15so3537925qtv.4
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pPymEQjLByLqJ1LJVQ6h2zBy5/jBzUdgR2p9+XMI4k=;
        b=Wh0vpAL6+49zc/HAr/bIXmX03WkQ3mA0rFRcZO1LrepQYZzY+nIx5/iAm6ypMQ0c2V
         8kW56O9PjQTKjLd01tbzs914EO+tevPIyrOumnfGZkS9ix9Ifw6SedYRuRIlcNFxhPBr
         WICXDY9YJDXL22t1FctnlPspiY+tfoogiL1qYfcNya7srwuLgugcxCGi0+pAiToWBNL9
         ma1mTodsCQ3soMlCxcAhrX0VtLs8NDPI52WmDUfYSBjfJ5pmGET0YO790cvnNdOZHIEq
         4mDr4DnvIgwMPcheKaiyYxKZ5xtY39gIg5ijdY4ELDXffQ8cJwvMpEwMfZig/IiZ9sE3
         2Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pPymEQjLByLqJ1LJVQ6h2zBy5/jBzUdgR2p9+XMI4k=;
        b=BWncYy4yamM0i7JJLlgatU3iVDo/008k0fbvlxn8syP/+VG4rZCqkCtuuiB8s4wFBS
         Pm0JLKXN3U7n9DInGNpPTJBXbn15n//SYXxkUZTSkMQzCa3sVnvTg98fw0Kh02r0L57E
         Z7VqakFh1BpBfUf3gavOaWNEQvYklnswqIPLsNGkdKQjgx31ht8H/jL+TO5mT+y6U/lB
         seP86A/nQ0rZJ0leEfOUwSX/+bR/XBuRlwviwpRftRKafA15XKsYByDXbGjRzlXW0/Kg
         y/5YlRJSDNVFKkvcSvFtqwR7poY2XACvpZrQoZcxonEixhxh55uM2ykZCiV9KMzNeGb3
         CptQ==
X-Gm-Message-State: ACrzQf0HIJjdlCh5AnjdEe3T4sr4aLH2uOc/+WEDvP/CzA3V8K3qHF74
        3C38S9cfDUxhZgPoKyk7qVL6GA==
X-Google-Smtp-Source: AMsMyM75bhGOaJabuRzsV40E9zH2/tYcYQGUATEhMFO2Fg1ghbZcEsfB5vffoi3yX/3hmSOs2eAjNA==
X-Received: by 2002:a05:622a:40ce:b0:3a5:6162:71ca with SMTP id ch14-20020a05622a40ce00b003a5616271camr5519254qtb.581.1667586445407;
        Fri, 04 Nov 2022 11:27:25 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id m7-20020ac807c7000000b003a4d5fed8c3sm2807816qth.85.2022.11.04.11.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:27:24 -0700 (PDT)
Message-ID: <9e8a1990-c090-3a07-7769-307aca10e45c@linaro.org>
Date:   Fri, 4 Nov 2022 14:27:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/9] dt-bindings: arm: qcom: Document msm8956 and msm8976
 SoC and devices
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Note that msm8976 is omitted as a compatible, since there are currently
> no boards/devices using it.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

