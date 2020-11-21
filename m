Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284FC2BC045
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKUPjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgKUPjw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:39:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4658A221FE;
        Sat, 21 Nov 2020 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605973191;
        bh=8tU9k43v5FZyRWrx0THa7YOGc2pAgq8YzvOisS70/CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zMHVIMrep8vmBFG6LjzwGTaTTZMVvC4e3qNzEskwRWCXUM3MWHfg8iuxFbG6yIWYA
         pPdEmk4QVyvIsBKqcIIV6JHTJipCdu1KDiaQrwMVj1BHGkbtHFiNs1jvSFIFZVcx8F
         Moly1U0caocgqHQnPyiJHnh8mAigf+HJiAwNdYsc=
Date:   Sat, 21 Nov 2020 15:39:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: adc: ad7887: add binding doc for
 AD7887
Message-ID: <20201121153946.0d82620a@archlinux>
In-Reply-To: <20201119100748.57689-4-alexandru.ardelean@analog.com>
References: <20201119100748.57689-1-alexandru.ardelean@analog.com>
        <20201119100748.57689-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 12:07:48 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change adds a simple device-tree binding for thhe Analog Devices
> AD7887 ADC.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hi Alexandru

Few things inline.

Jonathan

> ---
>  .../bindings/iio/adc/adi,ad7887.yaml          | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> new file mode 100644
> index 000000000000..9b30f4569b4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7887.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7887 low power, 12-bit ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices AD7887 low power, 12-bit analog-to-digital converter (ADC)
> +  that operates from a single 2.7 V to 5.25 V power supply.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7887
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  avcc-supply: true

On datasheet this seems to be vdd-supply
As driver doesn't currently use it I assume ti would be safe to make them
match?

> +
> +  spi-max-frequency: true
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply

Perhaps worth mentioning that not supplying this will result in a 2.5V internal
reference being used unless we are in dual-channel-mode in which case it
will be VDD.  (I originally started looking at datasheet when I wondered
if we could just use the absence of this regulator to configure to single / dual
channel mode - but we can't because of the 2.5V internal reference).

> +
> +  adi,dual-channel-mode:
> +    description:
> +      Configures dual-channel mode for the ADC. In dual-channel operation,
> +      the AIN1/VREF pin assumes its AIN1 function, providing a second analog
> +      input channel. In this case, he reference voltage for the part is provided
> +      via the VDD pin. As a result, the input voltage range on both the AIN0 and
> +      AIN1 inputs is 0 to VDD.
> +    type: boolean
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - spi-cpol
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +                compatible = "adi,ad7887";
> +                reg = <0>;
> +                spi-max-frequency = <1000000>;
> +                spi-cpol;
> +                spi-cpha;
> +
> +                avcc-supply = <&adc_supply>;
> +                vref-supply = <&adc_vref>;
> +        };
> +    };
> +...

