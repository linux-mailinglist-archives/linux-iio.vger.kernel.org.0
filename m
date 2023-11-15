Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BD7E1CC4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Nov 2023 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjKFI5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Nov 2023 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjKFI5J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Nov 2023 03:57:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3C10C2
        for <linux-iio@vger.kernel.org>; Mon,  6 Nov 2023 00:57:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507bd19eac8so5375384e87.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Nov 2023 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699261021; x=1699865821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVIPqExVEDcYW9stsKCFCucn8fRishcYDXtJBl5fSIQ=;
        b=uO+0GCMSJgc/RF/5JDwDcr0aMdudlsyy6VZIRzPhnt9j9lO7quL/WtNOofCpH+KecK
         55l5i9hWc6J/YiILEsIng8r9fZdVa0oLebhhRaiSZYufkio/2LrjQ8jurn1xFrm1D5N5
         5MTDdmtlALa1XiUf1n6m0vH8x3ZmSybhjqjGUYslAu5vzQZzohEb7svNF8Fkl5Uv4e9S
         DfF5ySJIoRGqikIA8A6PP+2IA7yfle4Tu9eFyub3dAA13vD9mhLBi8gicEogEzhCx1wz
         zbQnzc5U7cRyfIUju+ts+U0ygbjtqb1T8HXGnnA2nNbsEy8gY3j04B32lx0cato7Kvmy
         NQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261021; x=1699865821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVIPqExVEDcYW9stsKCFCucn8fRishcYDXtJBl5fSIQ=;
        b=MNgKuv/igR3KSGdgPkNAmFQlRGwAqsUYfz0qkWKdK6acpXSttkZc2qbKYVrHesZEjR
         tt9yK9vysspWlSB62oqFApaDFv7T61csh15NcXPqc9kWhqXa/5l0tBQmqG0Bgb/lPUuV
         MtRi/88fommYfv+b4+ThEQSxKn+/kgHj5qzu9sOH4i+CTb3yuTqCGuwzhD6kP+Eq61b8
         /n+K5yEZew5DENcCFjwHiFYUvRHUztYQkQMUX3VYbmW25ELXyORHc99JoQ/SXBuZ3hX9
         1rtwtsQADroj60OD0FLpQld7ve1K7pD1DkBclKqoRmbxtDzL358AjJldQroOlKpss4/S
         rPYg==
X-Gm-Message-State: AOJu0YwRUaVI+0PtPZP6rkoAyY1x+ckJuWZYdDK2Wpt9tqzp89NGSfki
        VVAE65HRIUUVzhw9b3fePsEp0g==
X-Google-Smtp-Source: AGHT+IG6nU0uTWnuuTHSGPSIPFuDTfFbH2mmiEM0WIVkO1AqNHVaQTLjH2JumFVB1WXwtqob+zBH1w==
X-Received: by 2002:ac2:5398:0:b0:507:9f69:e8d9 with SMTP id g24-20020ac25398000000b005079f69e8d9mr20568958lfh.49.1699261020775;
        Mon, 06 Nov 2023 00:57:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4708000000b0032d9523de65sm8857395wrq.48.2023.11.06.00.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 00:57:00 -0800 (PST)
Message-ID: <e5c9eaaa-a8f3-4ca5-acf6-9ff714a07898@linaro.org>
Date:   Mon, 6 Nov 2023 09:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: ad7192: Add AD7194 support
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-3-alisadariana@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231105193132.47009-3-alisadariana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/11/2023 20:31, alisadariana@gmail.com wrote:
> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
> 
> Also add an example for AD7194 devicetree.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..b9a9f7b20670 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    reg:
>      maxItems: 1
>  
> @@ -96,6 +103,31 @@ required:
>    - spi-cpol
>    - spi-cpha
>  
> +patternProperties:
> +  "^channel@([0-9a-f])$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 0
> +        maximum: 7

Your pattern a bit above is not correct then: [0-7]

> +
> +      diff-channels:
> +        description: |
> +          The differential channel pair for Ad7194 configurable channels. The
> +          first channel is the positive input, the second channel is the
> +          negative input.
> +        items:
> +          minimum: 1
> +          maximum: 16
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -127,3 +159,40 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "adi,ad7194";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            clocks = <&ad7192_mclk>;
> +            clock-names = "mclk";
> +            interrupts = <25 0x2>;
> +            interrupt-parent = <&gpio>;
> +            dvdd-supply = <&dvdd>;
> +            avdd-supply = <&avdd>;
> +            vref-supply = <&vref>;
> +
> +            adi,refin2-pins-enable;
> +            adi,rejection-60-Hz-enable;
> +            adi,buffer-enable;
> +            adi,burnout-currents-enable;
> +
> +            channel@0 {

Why cannot you add this to the existing example?



Best regards,
Krzysztof

