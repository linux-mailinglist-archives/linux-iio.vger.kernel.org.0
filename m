Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DD61FF51
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 21:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiKGUOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 15:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiKGUOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 15:14:07 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4062BB1C
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 12:13:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k15so11689265pfg.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Nov 2022 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=DLbUXpx5BGpG1DMQLOiBzekr6LKIQl3xNK69EzWu9cBTt0IhkdmZEwISLEFENb2XyY
         F6/uOEAYvPy0pCsiKqNfvo+OIfm6SIX23KDx3yvMgH3sgSWchQIKDJE3GlzipiOCntXn
         /clhW8ucjAP0zT0zof+RkYMmEXv6b4ZGsStnqT8oNHT2Ijc8ADMZhCAzlI2lH+fr1/YO
         x8c4BelTxgBcJGxLGvn23wE5GsMamdtb7aMOLH1Yng9pUzNmTj0K1sanTKJko582ilbk
         F/TgKqkz4ALp59zsfD87HDFQgUw9Nn7h4v9gTInuzb4aaEecdA3lo3c7rkliEi2oPP/4
         KM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=H+3YJ0LhgNj7OZOUdgauQ4XO3mSPVY2ckcM3AaQcPTYfVkAiU662EUonyCR+G2lXHD
         Ii3k5VcgChh/hkQz1f0UjIzAqITtQDrX+G7060waHuJGCaFuZwzUpevbJcDDPuMsYXaB
         fA4JfEUrwVPgMd4SiDA7Bj0v3jT6J1FhHgy2SrL+iHaFjTTCDwsdkSYGN1kT3yu08SNK
         gdR7pNMOKAQvzRhxz9k3YFNlOEN9UULq+7NpFW+dFDyjBw4jJ9spMDya+NQ3E5b/SJfe
         A5eBPEnJY6QBPCni8Lhyz2Z+fRtntWpcLs8LXPAtubQjC2VOj08XB6g94ZtlPo/cwW2u
         vRgw==
X-Gm-Message-State: ACrzQf1c9dhQIqRaHpr3EJDHX4XkCE9OO6Wcb8US8FI/73eqvDK9asJg
        d7jaiqjtIkxdlV7xqIHX9FVWceXvHcUh5s3v5nNMsg==
X-Google-Smtp-Source: AMsMyM74vaf7W54OL8zd+LH6la1LzG3+QlIhG7MtdJ/FbfqblOiiJopqiebGx/275JBCdBk/+joGXH2EXp7Nnh5kKbs=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr46115918pgk.595.1667852038821; Mon, 07
 Nov 2022 12:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com> <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:22 +0100
Message-ID: <CAPDyKFramrp3gvOCCULC6anTh9ZfFbdtSgrmE_iGCJgbT0vYLQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Nov 2022 at 18:22, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Document the compatible for the SDHCI controller(s) found on MSM8976.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index a96f143479c7..fc8a6b345d97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,msm8226-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
> +              - qcom,msm8976-sdhci
>                - qcom,msm8916-sdhci
>                - qcom,msm8992-sdhci
>                - qcom,msm8994-sdhci
> --
> 2.37.2
>
