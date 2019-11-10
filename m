Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96BAF6A04
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKJQHa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 11:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJQHa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 11:07:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C8F2077C;
        Sun, 10 Nov 2019 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573402048;
        bh=bylpvtXJkXYP4LOqiJTWE/7hZGBeS3NIX4op0xlPr1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECIhi3OjtpG+Vn/ebQjP5t7KglWq3sDtQcRAMNZIX6Jz7oVBQis6SQj++fHAunCku
         VNaS760tiqxaYvLTNA01AM4G+3TGoMwzcjKXH4P5/eS1fOFBGwf8fyKuRRzsuJkndB
         5p6QH3jlH5LW2ySHaDBTKiWWmTyZzK8f0bGLnDWc=
Date:   Sun, 10 Nov 2019 16:07:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     robh@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <20191110160723.0d0b66d7@archlinux>
In-Reply-To: <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
        <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Nov 2019 10:56:09 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a devicetree schema for AD7292 monitor and control system.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Seems like you have addressed everything Rob raised, so I'll apply this
and it can go out for build testing.  Still some time for Rob to add
a tag if he wants to!

Thanks,

Jonathan

> ---
> Changelog V3 -> V4:
> - updated SPDX identifier to GPL-2.0-only
> - changed maxitems constraint on channel property
> 
>  .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> new file mode 100644
> index 000000000000..b68be3aaf587
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7292 10-Bit Monitor and Control System
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> +
> +description: |
> +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> +  Temperature Sensor, and GPIOs
> +
> +  Specifications about the part can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7292
> +
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC and DAC reference voltage.
> +
> +  spi-cpha: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 8 channels numbered from 0 to 7.
> +        items:
> +          maximum: 7
> +
> +      diff-channels:
> +        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ad7292: adc@0 {
> +        compatible = "adi,ad7292";
> +        reg = <0>;
> +        spi-max-frequency = <25000000>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@0 {
> +          reg = <0>;
> +          diff-channels = <0 1>;
> +        };
> +        channel@2 {
> +          reg = <2>;
> +        };
> +        channel@3 {
> +          reg = <3>;
> +        };
> +        channel@4 {
> +          reg = <4>;
> +        };
> +        channel@5 {
> +          reg = <5>;
> +        };
> +        channel@6 {
> +          reg = <6>;
> +        };
> +        channel@7 {
> +          reg = <7>;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32bf5f8116d0..5d00e871c4c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -813,6 +813,13 @@ S:	Supported
>  F:	drivers/iio/adc/ad7124.c
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
>  
> +ANALOG DEVICES INC AD7292 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +
>  ANALOG DEVICES INC AD7606 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-iio@vger.kernel.org

