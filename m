Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B02BC7B3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKVSUj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgKVSUj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 13:20:39 -0500
X-Greylist: delayed 777 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Nov 2020 10:20:38 PST
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3893C0613CF;
        Sun, 22 Nov 2020 10:20:38 -0800 (PST)
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BB28B9E0039;
        Sun, 22 Nov 2020 18:20:36 +0000 (GMT)
Date:   Sun, 22 Nov 2020 18:20:34 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 34/46] dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml
 format conversion.
Message-ID: <20201122182034.77043bd7@archlinux>
In-Reply-To: <20201031184854.745828-35-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-35-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 18:48:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple conversion of the binding doc for this subnode of the palmas
> PMIC.
> Given age of driver and lack interaction with original authors,
> I've guessed at Tony for a maintainer on this one.  Tony, if you
> are happy with that great, otherwise I can default back to myself.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tony Lindgren <tony@atomide.com>
Applied.  @Tony, if you aren't happy being listed as maintainer for this
binding we can either fix that up before I send a pull request of if
necessary send a follow up patch.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/palmas-gpadc.txt         | 48 ----------
>  .../bindings/iio/adc/ti,palmas-gpadc.yaml     | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> deleted file mode 100644
> index 4bb9a86065d1..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -* Palmas general purpose ADC IP block devicetree bindings
> -
> -Channels list:
> -	0 battery type
> -	1 battery temp NTC (optional current source)
> -	2 GP
> -	3 temp (with ext. diode, optional current source)
> -	4 GP
> -	5 GP
> -	6 VBAT_SENSE
> -	7 VCC_SENSE
> -	8 Backup Battery voltage
> -	9 external charger (VCHG)
> -	10 VBUS
> -	11 DC-DC current probe (how does this work?)
> -	12 internal die temp
> -	13 internal die temp
> -	14 USB ID pin voltage
> -	15 test network
> -
> -Required properties:
> -- compatible : Must be "ti,palmas-gpadc".
> -- #io-channel-cells: Should be set to <1>.
> -
> -Optional sub-nodes:
> -ti,channel0-current-microamp: Channel 0 current in uA.
> -	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
> -ti,channel3-current-microamp: Channel 3 current in uA.
> -	Values are rounded to derive 0uA, 10uA, 400uA, 800uA.
> -ti,enable-extended-delay: Enable extended delay.
> -
> -Example:
> -
> -pmic {
> -	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> -	...
> -	gpadc {
> -		compatible = "ti,palmas-gpadc";
> -		interrupts = <18 0
> -			      16 0
> -			      17 0>;
> -		#io-channel-cells = <1>;
> -		ti,channel0-current-microamp = <5>;
> -		ti,channel3-current-microamp = <10>;
> -		};
> -	};
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> new file mode 100644
> index 000000000000..692dacd0fee5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,palmas-gpadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Palmas general purpose ADC IP block devicetree bindings
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description: |
> +  This ADC is often used to provide channels via the io-channels
> +  consumer framework.
> +  Channels list:
> +    0 battery type
> +    1 battery temp NTC (optional current source)
> +    2 GP
> +    3 temp (with ext. diode, optional current source)
> +    4 GP
> +    5 GP
> +    6 VBAT_SENSE
> +    7 VCC_SENSE
> +    8 Backup Battery voltage
> +    9 external charger (VCHG)
> +    10 VBUS
> +    11 DC-DC current probe (how does this work?)
> +    12 internal die temp
> +    13 internal die temp
> +    14 USB ID pin voltage
> +    15 test network
> +
> +properties:
> +  compatible:
> +    const: ti,palmas-gpadc
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  ti,channel0-current-microamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Channel 0 current in uA.
> +    enum:
> +      - 0
> +      - 5
> +      - 15
> +      - 20
> +
> +  ti,channel3-current-microamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Channel 3 current in uA.
> +    enum:
> +      - 0
> +      - 10
> +      - 400
> +      - 800
> +
> +  ti,enable-extended-delay:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable extended delay.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    pmic {
> +        compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +        adc {
> +            compatible = "ti,palmas-gpadc";
> +            interrupts = <18 0
> +                          16 0
> +                          17 0>;
> +            #io-channel-cells = <1>;
> +            ti,channel0-current-microamp = <5>;
> +            ti,channel3-current-microamp = <10>;
> +        };
> +    };
> +...

