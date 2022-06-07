Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DE2539E2C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jun 2022 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348345AbiFAH0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jun 2022 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiFAH0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2022 03:26:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7E606C8
        for <linux-iio@vger.kernel.org>; Wed,  1 Jun 2022 00:26:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w27so938787edl.7
        for <linux-iio@vger.kernel.org>; Wed, 01 Jun 2022 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yFS3Rnzfb0unp6UI0nuTf8G/mfgDKJWNbf+GB8d9uhI=;
        b=yzkX1bG3uR7Qmo+F7Qn+hD60uiQC931MBqEyL6CGfUOrTBWOWU+fSEZRlHsxL+o36H
         DaqBipXoh9uvBx5bddczFUvjkjeXBBibFH//xj8nkC6+BldNDlqO97uoNDCMjCR2tpbh
         iXPv3e4OV0sFLNf+AQh/N2HDdJtQ+bcBqcEhEHrumECnJcXgYb0c9sI5pRHJ8gOZ+I4j
         RKTmx02GpCBTx63+I8GebWfp/M1OilGCQSjE68nmPHe2DS2B4ln1SMWm5hTC543D1aM4
         c1kvAk/OltrRUqX0oU3syh9MOBrJ4FDVR9It+1wYbKDr/j4x1mN/vt4gTx3gFDbEUdsS
         MqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yFS3Rnzfb0unp6UI0nuTf8G/mfgDKJWNbf+GB8d9uhI=;
        b=tYWEzrnIKQl0zc5+puLPY/u93SXk+gDR1zYbx2qyG44iT0bBaIKgo2ob0Rwsn1EMef
         emzfx4TYpf9AWhfMQGiftbjUobioxHmtISgcgwK8e4zsKk5bMx1bRWhUkWROoJbiScrJ
         ucn42trQEkX2El87chmXE2MUwszvya4qk1eEgYPaDdI519vMDlbuP6B+dcRFkV99dusz
         HmFmdK+T0CIiZ2RThSOltYySm2jk5OAvApT3u5BeTognntX4w3jTHjMpXHJitYptXW59
         0V1HSab7IuEs3m47bid6cafspqcwt1HhMP1grlCp8bgEeqJAaqx4BFFh2n2wGmTg4Z3m
         Owrw==
X-Gm-Message-State: AOAM532QTXY0MpUBKcN7hDCvp79dB910qbjoEvKH/f2khysg0YLmMzFG
        hvCdGy/OVBDVcyFfgpmm7wOESQ==
X-Google-Smtp-Source: ABdhPJyfhUlStTcZTz+Ssrs2TvVIfO4c18Qt7HTJuB/uTfvjqG5vQ05BQvumt+AGIXmDE9LMcb26HA==
X-Received: by 2002:a05:6402:40ce:b0:42b:9d1:96e6 with SMTP id z14-20020a05640240ce00b0042b09d196e6mr66557011edb.262.1654068374634;
        Wed, 01 Jun 2022 00:26:14 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906110f00b006fe98c7c7a9sm359838eja.85.2022.06.01.00.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:26:14 -0700 (PDT)
Message-ID: <1f349852-34a7-ff27-3c34-462128802340@linaro.org>
Date:   Wed, 1 Jun 2022 09:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 09/14] dt-bindings: usb: Add Mediatek MT6370 TCPC binding
 documentation
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
 <20220531102809.11976-10-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531102809.11976-10-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/05/2022 12:28, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 TCPC binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/usb/mediatek,mt6370-tcpc.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
> new file mode 100644
> index 000000000000..49316633f92f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek MT6370 Type-C Port Switch and Power Delivery controller DT bindings

s/DT bindings//

> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  Mediatek MT6370 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
> +  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
> +  This document only describes MT6370 Type-C Port Switch and Power Delivery controller.

These lines do not look like wrapped at 80.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6370-tcpc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  connector:
> +    type: object
> +    $ref: /schemas/connector/usb-connector.yaml#

You need unevaluatedProperties:false within connector.

> +    description:
> +      Properties for usb c connector.

Skip description, it's not helpful.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts


Best regards,
Krzysztof
