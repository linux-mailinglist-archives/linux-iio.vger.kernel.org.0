Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D943DC674
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGaPAO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 11:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhGaPAN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 11:00:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CE460F56;
        Sat, 31 Jul 2021 15:00:03 +0000 (UTC)
Date:   Sat, 31 Jul 2021 16:02:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: ad7949: add per channel
 reference
Message-ID: <20210731160243.662065ef@jic23-huawei>
In-Reply-To: <20210727232906.980769-5-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
        <20210727232906.980769-5-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:29:05 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add bindings documentation describing per channel reference voltage
> selection.
> This adds the adi,internal-ref-microvolt property, and child nodes for
> each channel. This is required to properly configure the ADC sample
> request based on which reference source should be used for the
> calculation.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

I'm fine with this, but as it's a bit unusual, definitely want to give a
little more time for Rob and others to take a look.

Jonathan
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 69 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> index 9b56bd4d5510..893f72b8081e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> @@ -26,19 +26,63 @@ properties:
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
> +      adi,internal-ref-microvolt:
> +        description: |
> +          Internal reference voltage selection in microvolts.
> +
> +          If no internal reference is specified, the channel will default to the
> +          external reference defined by vrefin-supply (or vref-supply).
> +          vrefin-supply will take precedence over vref-supply if both are defined.
> +
> +          If no supplies are defined, the reference selection will default to
> +          4096mV internal reference.
> +
> +        enum: [2500000, 4096000]
> +        default: 4096000
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
>  
>  additionalProperties: false
>  
> @@ -49,9 +93,26 @@ examples:
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
> +                adi,internal-ref-microvolt = <4096000>;
> +                reg = <0>;
> +            };
> +
> +            channel@1 {
> +                adi,internal-ref-microvolt = <2500000>;
> +                reg = <1>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +            };
>          };
>      };
>  ...

