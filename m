Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9155341081C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhIRSXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 18 Sep 2021 14:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhIRSXM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:23:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8349460EDF;
        Sat, 18 Sep 2021 18:21:46 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:25:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-binding: iio: Add documentation for AD799x
 driver
Message-ID: <20210918192525.2a0a540e@jic23-huawei>
In-Reply-To: <20210914145142.138324-2-florian.boor@kernelconcepts.de>
References: <20210914145142.138324-1-florian.boor@kernelconcepts.de>
        <20210914145142.138324-2-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Sep 2021 16:51:42 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

Patch title should be dt-bindings: iio: ad779x: Add binding document.

Also, all bindings need to be sent to Rob and the dt mailing list.

Otherwise looks good to me.

Whilst I've +cc'd Rob and device tree lists I don't think patchwork will
pick it up so you should send a v4 (where did version number go on this one)
with them cc'd to be sure it's on their radar.

Thanks,

Jonathan


> New documentation for AD799x series of I²C ADC ICs.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
> ---
>  .../bindings/iio/adc/adi,ad799x.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> new file mode 100644
> index 000000000000..66de61050deb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad799x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7991, AD7992, AD7993, AD7994, AD7995, AD7997, AD7998,
> +       AD7999 and similar analog to digital converters
> +
> +maintainers:
> +  - Michael Hennerich, Analog Devices Inc. <Michael.Hennerich@analog.com>
> +
> +description: |
> +  Specifications on the converters can be found at:
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
> +        adc1: ad7991@28 {
> +                reg = <0x28>;
> +                compatible = "adi,ad7991";
> +                interrupts = <13 2>;
> +                interrupt-parent = <&gpio6>;
> +
> +                vcc-supply = <&vcc_3v3>;
> +                vref-supply = <&adc_vref>;
> +        };
> +...

