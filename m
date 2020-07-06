Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E395C215380
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGFHve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 03:51:34 -0400
Received: from first.geanix.com ([116.203.34.67]:50650 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgGFHve (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Jul 2020 03:51:34 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id D43D72260689;
        Mon,  6 Jul 2020 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1594021891; bh=Kh87M4Ly4yTXldCRas6Fx1Hr37VGDaSUeY3ind/u/ts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=R8ashBHXByOeW9gxm8igXGnreSeOH1HOF9rPzkaU/ZidRumTYVJQGOeojMV2dGbGT
         uJYquIzRP7FJv8IhvedGbYjBsBOjbIEd8nLJvg1/FONKQi08m+z/RMWaVMZQVqaBi8
         y8KJVYA04vsK3AITJmmgWykAKaJEFpPZwZbADQq957SSydXB8UkahQwq5x/ZVBV0tW
         7gQxOjKaLizbtWuWthJgZgQtJqyN6ZWQr3cQrHx8MXxgaZmpsTGWo+EHJfB9GggBSx
         dUWbKba9bsve1x/5wRe5XT7LNjxMDEZmVP0Q2WLj3rtZJSMLboHrSXgb7BasmU0D7d
         0/aZiOWe4VeAg==
Subject: Re: [PATCH] dt-bindings: iio: ti,ads8688 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200705131720.240574-1-jic23@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <905c1b8a-7902-580c-4df1-21c6eb1ebf0b@geanix.com>
Date:   Mon, 6 Jul 2020 09:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200705131720.240574-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 05/07/2020 15.17, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Fairly simple binding.  Most of the changes were filling in information
> not previously found in the binding.  I dropped the previous explicit
> mention of spi-max-frequency as that is covered by the generic SPI
> binding.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>
> Sean, are you fine with being explicitly listed at the maintainer
> of this binding?  Previously we didn't have that formally laid
> out in the old txt bindings but it's now a required field.
Yes :)
>
> I'm going to slowly work my way through some of the simpler yaml conversions
> over the next few months.   Of course I welcome anyone else taking
> some of these on but for purposes of review, please keep it to only
> a few at a time.
>
>   .../bindings/iio/adc/ti,ads8688.yaml          | 45 +++++++++++++++++++
>   .../bindings/iio/adc/ti-ads8688.txt           | 20 ---------
>   2 files changed, 45 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
>   delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
> new file mode 100644
> index 000000000000..97fe6cbb2efa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads8688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS8684 and ADS8688 ADC chip
> +
> +maintainers:
> +  - Sean Nyekjaer <sean@geanix.com>
> +
> +description: |
> +   SPI 16bit ADCs with 4/8 channels.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads8684
> +      - ti,ads8688
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: Optional external reference.  If not supplied, assume
> +      REFSEL input tied low to enable the internal reference.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads8688";
> +            reg = <0>;
> +            vref-supply = <&vdd_supply>;
> +            spi-max-frequency = <1000000>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> deleted file mode 100644
> index a02337d7efa4..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -* Texas Instruments' ADS8684 and ADS8688 ADC chip
> -
> -Required properties:
> - - compatible: Should be "ti,ads8684" or "ti,ads8688"
> - - reg: spi chip select number for the device
> -
> -Recommended properties:
> - - spi-max-frequency: Definition as per
> -		Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Optional properties:
> - - vref-supply: The regulator supply for ADC reference voltage
> -
> -Example:
> -adc@0 {
> -	compatible = "ti,ads8688";
> -	reg = <0>;
> -	vref-supply = <&vdd_supply>;
> -	spi-max-frequency = <1000000>;
> -};

