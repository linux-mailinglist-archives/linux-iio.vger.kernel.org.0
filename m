Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518555970D
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jun 2022 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiFXJzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jun 2022 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJzC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2022 05:55:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9D47543
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 02:55:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so3656124ejb.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2022 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LxlyydORZPOFGaHD/uBTpE1Gv4F+iq5krFi3Trgnneo=;
        b=kCV6DXPBi376m/3DfvAqd6ndBKXGtDzBRFbudq61NQjy6Uq6nv7w+e/mF/mlzHURsX
         FukknfrtqBTMFrKtSKWFP7pgG4d+RWSuyL+PQtR8j+IHEan3Aj41GekjEOpUix9bWccZ
         6SyU5ySj/zSHAY5D1yP6fekCYn64g4C1ldqtnq4ceo4HydidWDv4tPw+JCezyVMlJHoR
         Qt0/hTiF1EItHJwvXM7Xub1i1/ifI2lWQzVXQisA9kSEo3DbMQvSg+CznyNXxOcKsFT+
         n5PvIATpiSdfYJIutwYkPKyU4RL+jy1G25uNJStB7WQ8DU6uXrFpym0DqTK5iw5mI6Dd
         DYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LxlyydORZPOFGaHD/uBTpE1Gv4F+iq5krFi3Trgnneo=;
        b=iQvH59X61TuysCi72019RELqiJ2ZH73qaKRHysmrG57RscumJENu2kwIXlwtAq6fk4
         jgIMdOkRudCbIBpl+9JklbCDVYPSHQXEABBYqEWEvWWPlBJWLCijV12uzhG/668tV6na
         bnQE/VtOnNs0hyoe9bop/1U3Nf8W581RaKQTP4uGtE/VWAzanbX92fi3fntHS5gwe9Ek
         uSUQXxtvpL1bEDOajDqYm2xbBD26+hIaHoak8hKgSN3d4x3hGDsF/fGMQLPAihN7i87v
         Rrgu0J6dtk/Kso+/lNoSKI45gM1rvoqJcJkmZg0Qi4S5br4qpNiD/3sI7BQ+dSKa4Py8
         sxnA==
X-Gm-Message-State: AJIora9OHKu1yC7x6o6KnD/3dRBobrA+rhor90gkfUwtQouFINxhYd8T
        s6RmRbll/7D7jsialyQDabxK9Q==
X-Google-Smtp-Source: AGRyM1ty12gQWhn+V/hw4oN+c21S3LnvTt1UPjo3aNH+hHBj3AkOKOyhMw8+kEmm9+Om156boJ6xlg==
X-Received: by 2002:a17:906:20c6:b0:718:cc95:ccaf with SMTP id c6-20020a17090620c600b00718cc95ccafmr12598031ejc.714.1656064499807;
        Fri, 24 Jun 2022 02:54:59 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kj20-20020a170907765400b00722dac96232sm824451ejc.126.2022.06.24.02.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 02:54:59 -0700 (PDT)
Message-ID: <789e8a4e-f5a3-9e92-da2c-22145ba272d9@linaro.org>
Date:   Fri, 24 Jun 2022 11:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 05/10] dt-bindings: iio: adc: mcp3911: add
 microchip,data-ready-hiz entry
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-5-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623170844.2189814-5-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/06/2022 19:08, Marcus Folkesson wrote:
> The Data Ready Output Pin is either hard wired to work as high
> impedance or push-pull. Make it configurable.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 95ab285f4eba..74b333e44bfd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -36,6 +36,14 @@ properties:
>      description: IRQ line of the ADC
>      maxItems: 1
>  
> +  microchip,data-ready-hiz:
> +    description:
> +      Data Ready Pin Inactive State Control bit

"Bit" of what? Do not describe the programming model but the actual feature.

> +      true = The DR pin state is high-impedance when data are NOT ready
> +      false = The DR pin state is a logic high when data are NOT ready
> +    type: boolean
> +    default: false

You do not need default for bools.

> +
>    microchip,device-addr:
>      description: Device address when multiple MCP3911 chips are present on the same SPI bus.
>      $ref: /schemas/types.yaml#/definitions/uint32


Best regards,
Krzysztof
