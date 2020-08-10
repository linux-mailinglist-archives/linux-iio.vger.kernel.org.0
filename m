Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0865F24008E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 02:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJAtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 20:49:22 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:45562 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHJAtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 20:49:21 -0400
Received: (qmail 7474 invoked by uid 5089); 10 Aug 2020 00:42:40 -0000
Received: by simscan 1.2.0 ppid: 7402, pid: 7403, t: 0.0695s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 10 Aug 2020 00:42:40 -0000
Subject: Re: [PATCH 13/13] dt-bindings: iio: adc: ti,tlc4541 binding
 conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-14-jic23@kernel.org>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <7de481eb-a3d1-09b2-5ced-aaff3a14dc72@electromag.com.au>
Date:   Mon, 10 Aug 2020 08:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809111753.156236-14-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/08/2020 19:17, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding so easy to convert.
> Dropped the stated value of maximum spi bus frequency as it does
> not seem to correspond to the datasheet.  The value of 200kHz
> is the max sampling frequency of the ADC, not the clock frequency of
> the SPI bus.
> 
> Added #io-channel-cells to allow use as a provider of channels to
> other devices via the consumer binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>

Yes, the spi frequency can be higher.
Thanks.

Reviewed-By: Phil Reid <preid@electromag.com.au>

> ---
>   .../bindings/iio/adc/ti,tlc4541.yaml          | 52 +++++++++++++++++++
>   .../bindings/iio/adc/ti-tlc4541.txt           | 17 ------
>   2 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
> new file mode 100644
> index 000000000000..6c2539b3d707
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,tlc4541.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TLC4541 and similar ADCs
> +
> +maintainers:
> +  - Phil Reid <preid@electromag.com.au>
> +
> +description: |
> +  14/16bit single channel ADC with SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tlc3541
> +      - ti,tlc4541
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  vref-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,tlc4541";
> +            reg = <0>;
> +            vref-supply = <&vdd_supply>;
> +            spi-max-frequency = <200000>;
> +            #io-channel-cells = <1>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
> deleted file mode 100644
> index 6b2692723a04..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -* Texas Instruments' TLC4541
> -
> -Required properties:
> - - compatible: Should be one of
> -	* "ti,tlc4541"
> -	* "ti,tlc3541"
> -	- reg: SPI chip select number for the device
> - - vref-supply: The regulator supply for ADC reference voltage
> - - spi-max-frequency: Max SPI frequency to use (<= 200000)
> -
> -Example:
> -adc@0 {
> -	compatible = "ti,tlc4541";
> -	reg = <0>;
> -	vref-supply = <&vdd_supply>;
> -	spi-max-frequency = <200000>;
> -};
> 


-- 
Regards
Phil Reid


