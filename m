Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5D54EC3A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379074AbiFPVKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378976AbiFPVKS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 17:10:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C388760B97
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 14:10:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1275185pjm.4
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1NvKVp9EY1lQLLZ0Uj/3ziHPWB5PBfQnDPktmmL6XEk=;
        b=Q6kggNEwsYy473XSBdvlOd5aXGi14mWaUXKCRel2oNoa9ukMQEm6VLZ36BSmEzjUw8
         xVjg+yj2Cf7WYniqQWa061j05YQBrlt3J8sWSdxuzyoIGAnHdsSZK0OPY2rgLYkZCGdz
         RGHvnW9PyQpZtnrKN3TNt9/AMOmKe76T+/caN0MOE3lbxICjjK5bFR+Qhp/bDFV7LEnZ
         ygPkdnsJl4x4bJeL8fdqMJEOMIyvVNtRqEeXO2BdN/B+P+LbfjtD4WyGc67vqWXugVv3
         iNbUjj0Z+ZhCSCUDlVRSwcvWTlaYCTp/0ixXT9BwdhOZGpaNiy9JJrytROI9rct/lCCR
         7ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1NvKVp9EY1lQLLZ0Uj/3ziHPWB5PBfQnDPktmmL6XEk=;
        b=rCqAA90Mq6V10lDKTXwg/1oWSw02NDUFs/INypwflTAb6THw8bPd6cRlGBCZpTNEY2
         TYYFbWqA2TfMa6DshZzigKftPjjbYxnvK9AY8AHP45d5kmfYBHnbyCMRflSDRYW6NmC8
         sL2beHuBZzgQKkvZ7wd452lWW7Aq/ZCy1hUWZBGz546wIq8JoyU9yWFuBmxEsFGcP1ki
         /CHmIQahpHf4gZqze6/002notlaCLmWyROA9AGHOds8QhUI76xt913wsl7ohTy447Gu8
         9yB5FO8Q0y9l1hrBDSgPnRTj2GjfmEVoFzh/b8qaw48KZqQxKct4wM+wOKG8BdqFNaVW
         bs0A==
X-Gm-Message-State: AJIora/+MUhPDSf7Lr1GUb2WTScKJ4Y2aBDnZaR478scKoibrLfgjEOj
        wt0UkIcS053iIXF/kf2Ax0ilUw==
X-Google-Smtp-Source: AGRyM1tx14RVi2zqlwVdwcg3qpvX916m1pZt9IXn7u8YC0Z2HVZLOyuzbvgSYCSqY81bOJn+l9i+nw==
X-Received: by 2002:a17:90b:4c8f:b0:1e6:9bf9:1ab8 with SMTP id my15-20020a17090b4c8f00b001e69bf91ab8mr6904606pjb.215.1655413814235;
        Thu, 16 Jun 2022 14:10:14 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id n46-20020a056a000d6e00b0051868418b06sm2167316pfv.35.2022.06.16.14.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 14:10:13 -0700 (PDT)
Message-ID: <f230c9b0-6e23-7409-62e8-58f849925e2e@linaro.org>
Date:   Thu, 16 Jun 2022 14:10:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 04/15] dt-bindings: leds: Add Mediatek MT6370
 flashlight
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-5-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613111146.25221-5-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/06/2022 04:11, ChiaEn Wu wrote:
> From: Alice Chen <alice_chen@richtek.com>
> 
> Add Mediatek MT6370 flashlight binding documentation.
> 
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> ---
>  .../leds/mediatek,mt6370-flashlight.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> new file mode 100644
> index 000000000000..13610bc23d0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-flashlight
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-1]$":
> +    type: object
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg:
> +        enum:
> +          - 0 # Address of LED1
> +          - 1 # Address of LED2

Just: enum: [0, 1]
No need for description.


> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false


Best regards,
Krzysztof
