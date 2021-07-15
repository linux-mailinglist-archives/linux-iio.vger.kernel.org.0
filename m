Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42883CA27B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGOQgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 12:36:48 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38590 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhGOQgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 12:36:48 -0400
Received: by mail-io1-f47.google.com with SMTP id k11so7186664ioa.5;
        Thu, 15 Jul 2021 09:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y6bIe4Hr1YorCPfBGvzQ6LpfYt1mUHZ0WYD1UKQ11fI=;
        b=OddwE8C60Dd27dV54u5M1RJKaYtymzqwYRMPD7bgAmQK3SvIsfXUT0kLiTsNxKbbAg
         /relrKhwAdeHMhsjM9K4Qez5v2C8zYtmoNqKx/1bL4d2i96mPMqbp5f4gTeFxST3yxbA
         Taah/w/JX4gfngi144B3kbQLe5O9fprZexAwerFIJccVrRTwwnT3cnFf6KOAItJTFOLz
         AuypePdbGeZKh/2KwvPjMb3a/WbKMZQYNde9Gn9+mNgbbFt/Epi84aBWJ8AiBkogmdC4
         SJ7ySCEkxlL2x15q7+igCDHhHqabaEzNhYx72p/yuj03WauJ9/815Dzpj71D30AXR4F6
         vA2A==
X-Gm-Message-State: AOAM532DenXw5O5ru+DseSs52MoJ8Rg9Dyx766eS3XIOp0tk+4vf0V0e
        xww+yW8xIrZoDH/G10xpgA==
X-Google-Smtp-Source: ABdhPJwjABnFg4T6xJSJ0P5H8lKstHXlXYapvPvsNoHN3wsp0lAAJVLxEKy3tFw/NsOsULzmDiFcUg==
X-Received: by 2002:a5d:8d16:: with SMTP id p22mr3786404ioj.90.1626366834397;
        Thu, 15 Jul 2021 09:33:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f16sm3263591ilc.53.2021.07.15.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:33:53 -0700 (PDT)
Received: (nullmailer pid 1202003 invoked by uid 1000);
        Thu, 15 Jul 2021 16:33:50 -0000
Date:   Thu, 15 Jul 2021 10:33:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: iio: adc: ad7949: add per channel
 reference
Message-ID: <20210715163350.GA1196436@robh.at.kernel.org>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
 <20210713043425.3321230-5-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713043425.3321230-5-liambeguin@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 13, 2021 at 12:34:25AM -0400, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Add bindings documentation describing per channel reference voltage
> selection.
> This adds the adi,internal-ref-mv property, and child nodes for each
> channel. This is required to properly configure the ADC sample request
> based on which reference source should be used for the calculation.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 71 +++++++++++++++++--
>  1 file changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> index 9b56bd4d5510..18abba3b0b4d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> @@ -26,19 +26,65 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vrefin-supply:
> +    description:
> +      Buffered ADC reference voltage supply.
> +
>    vref-supply:
>      description:
> -      ADC reference voltage supply
> +      Unbuffered ADC reference voltage supply.
>  
>    spi-max-frequency: true
>  
> -  "#io-channel-cells":
> +  '#io-channel-cells':
>      const: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +

extra blank line.

>  required:
>    - compatible
>    - reg
> -  - vref-supply
> +
> +patternProperties:
> +  '^channel@([0-7])$':
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +          Up to 4 channels, numbered from 0 to 3 for adi,ad7682.
> +          Up to 8 channels, numbered from 0 to 7 for adi,ad7689 and adi,ad7949.
> +        items:
> +          minimum: 0
> +          maximum: 7
> +
> +      adi,internal-ref-mv:

Use standard unit suffix name. Then you can drop the type $ref.

> +        description: |
> +          Internal reference voltage selection in millivolts.
> +
> +          If no internal reference is specified, the channel will default to the
> +          external reference defined by vrefin-supply (or vref-supply).
> +          vrefin-supply will take precedence over vref-supply if both are defined.
> +
> +          If no supplies are defined, the reference selection will default to
> +          4096mV internal reference.
> +
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [2500, 4096]
> +        default: 4096
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
>  
>  additionalProperties: false
>  
> @@ -49,9 +95,26 @@ examples:
>          #size-cells = <0>;
>  
>          adc@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
>              compatible = "adi,ad7949";
>              reg = <0>;
> -            vref-supply = <&vdd_supply>;
> +            vrefin-supply = <&vdd_supply>;
> +
> +            channel@0 {
> +                adi,internal-ref-mv = <4096>;
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                adi,internal-ref-mv = <2500>;
> +                reg = <1>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +            };
>          };
>      };
>  ...
> -- 
> 2.30.1.489.g328c10930387
> 
> 
