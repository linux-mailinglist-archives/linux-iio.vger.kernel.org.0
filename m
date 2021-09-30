Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955141DF72
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhI3QpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 30 Sep 2021 12:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhI3QpU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:45:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C2461209;
        Thu, 30 Sep 2021 16:43:35 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:47:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: iio: ad779x: Add binding document
Message-ID: <20210930174730.5c87e108@jic23-huawei>
In-Reply-To: <20210930104249.2924336-2-florian.boor@kernelconcepts.de>
References: <20210930104249.2924336-1-florian.boor@kernelconcepts.de>
        <20210930104249.2924336-2-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Sep 2021 12:42:49 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

> New binding documentation for AD799x series of I²C ADC ICs.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>

Rob gave a tag on v5 subject to some changes I assume you've made in here.
Please make sure to pick those up as they won't get picked up across versions
by the b4 which I'm using to grab patches from lore.kernel.org.

Patches look fine to me, but I'll leave them on list a day or two to see if anyone
else has feedback.

Thanks,

Jonathan


> ---
> 
> Changes in v6:
> - Minor documentation change (label and contact info)
> 
> Changes in v5:
> - Correct errors in documentation found by
>   'make DT_CHECKER_FLAGS=-m dt_binding_check'
>   + Reduce title length
>   + Move information to description
>   + Add I²C bits to example
> 
>  .../bindings/iio/adc/adi,ad799x.yaml          | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> new file mode 100644
> index 000000000000..29641ce7175b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad799x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD799x analog to digital converters
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +
> +description: |
> +    Support for Analog Devices AD7991, AD7992, AD7993, AD7994, AD7995, AD7997, AD7998,
> +    AD7999 and similar analog to digital converters.
> +    Specifications on the converters can be found at:
> +    AD7991, AD7995, AD7999:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7991_7995_7999.pdf
> +    AD7992:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7992.pdf
> +    AD7993, AD7994:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7993_7994.pdf
> +    AD7997, AD7998:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7997_7998.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7991
> +      - adi,ad7992
> +      - adi,ad7993
> +      - adi,ad7994
> +      - adi,ad7995
> +      - adi,ad7997
> +      - adi,ad7998
> +      - adi,ad7999
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      ADC power supply
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply, optional for AD7991, AD7995 and AD7999
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +       adc1: adc@28 {
> +               reg = <0x28>;
> +               compatible = "adi,ad7991";
> +               interrupts = <13 2>;
> +               interrupt-parent = <&gpio6>;
> +
> +               vcc-supply = <&vcc_3v3>;
> +               vref-supply = <&adc_vref>;
> +        };
> +    };
> +...

