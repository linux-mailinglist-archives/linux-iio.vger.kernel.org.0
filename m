Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431836A24C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhDXRJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 13:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhDXRJY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 13:09:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C74961181;
        Sat, 24 Apr 2021 17:08:43 +0000 (UTC)
Date:   Sat, 24 Apr 2021 18:09:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings:iio:adc:adi,ad7474: Add missing
 binding document
Message-ID: <20210424180924.5ba2ca78@jic23-huawei>
In-Reply-To: <20210424170346.526242-3-jic23@kernel.org>
References: <20210424170346.526242-1-jic23@kernel.org>
        <20210424170346.526242-3-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Apr 2021 18:03:46 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Let's just pretend that it says ad7476 in the patch title
(I'll fix it whilst applying).

Oops.

Jonathan

> 
> This binding covers class of simple SPI ADCs which only provide
> data output - they don't have MOSI pin.
> 
> The only real variation between them is over how many supplies they
> use and which one is used for the reference.
> 
> Michael listed as maintainer for this one as it is his driver and
> falls under the catch all MAINTAINERS entry for ADI devices.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iio/adc/adi,ad7476.yaml          | 174 ++++++++++++++++++
>  1 file changed, 174 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> new file mode 100644
> index 000000000000..cf711082ad7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7476.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7476 and similar simple SPI ADCs from multiple manufacturers.
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  A lot of simple SPI ADCs have very straight forward interfaces.
> +  They typically don't provide a MOSI pin, simply reading out data
> +  on MISO when the clock toggles.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091
> +      - adi,ad7091r
> +      - adi,ad7273
> +      - adi,ad7274
> +      - adi,ad7276
> +      - adi,ad7277
> +      - adi,ad7278
> +      - adi,ad7466
> +      - adi,ad7467
> +      - adi,ad7468
> +      - adi,ad7475
> +      - adi,ad7476
> +      - adi,ad7476a
> +      - adi,ad7477
> +      - adi,ad7477a
> +      - adi,ad7478
> +      - adi,ad7478a
> +      - adi,ad7495
> +      - adi,ad7910
> +      - adi,ad7920
> +      - adi,ad7940
> +      - ti,adc081s
> +      - ti,adc101s
> +      - ti,adc121s
> +      - ti,ads7866
> +      - ti,ads7867
> +      - ti,ads7868
> +      - lltc,ltc2314-14
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      Main powersupply voltage for the chips, sometimes referred to as VDD on
> +      datasheets.  If there is no separate vref-supply, then this is needed
> +      to establish channel scaling.
> +
> +  vdrive-supply:
> +    description:
> +      Some devices have separate supply for their digital control side.
> +
> +  vref-supply:
> +    description:
> +      Some devices have a specific reference voltage supplied on a different pin
> +      to the other supplies. Needed to be able to establish channel scaling
> +      unless there is also an internal reference available (e.g. ad7091r)
> +
> +  spi-max-frequency: true
> +
> +  adi,conversion-start-gpios:
> +    description: A GPIO used to trigger the start of a conversion
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +allOf:
> +  # Devices where reference is vcc
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091
> +              - adi,ad7276
> +              - adi,ad7277
> +              - adi,ad7278
> +              - adi,ad7466
> +              - adi,ad7467
> +              - adi,ad7468
> +              - adi,ad7940
> +              - ti,adc081s
> +              - ti,adc101s
> +              - ti,adc121s
> +              - ti,ads7866
> +              - ti,ads7868
> +      required:
> +        - vcc-supply
> +  # Devices with a vref
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091r
> +              - adi,ad7273
> +              - adi,ad7274
> +              - adi,ad7475
> +              - lltc,ltc2314-14
> +    then:
> +      properties:
> +        vref-supply: true
> +    else:
> +      properties:
> +        vref-supply: false
> +  # Devices with a vref where it is not optional
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7273
> +              - adi,ad7274
> +              - adi,ad7475
> +              - lltc,ltc2314-14
> +    then:
> +      required:
> +        - vref-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7475
> +              - adi,ad7495
> +    then:
> +      properties:
> +        vdrive-supply: true
> +    else:
> +      properties:
> +        vdrive-supply: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091
> +              - adi,ad7091r
> +    then:
> +      properties:
> +        adi,conversion-start-gpios: true
> +    else:
> +      properties:
> +        adi,conversion-start-gpios: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "adi,ad7091r";
> +        reg = <0>;
> +        spi-max-frequency = <5000000>;
> +        vcc-supply = <&adc_vcc>;
> +        vref-supply = <&adc_vref>;
> +      };
> +    };
> +...

