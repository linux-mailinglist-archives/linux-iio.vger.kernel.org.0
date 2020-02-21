Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90955168128
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBUPHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 10:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbgBUPHx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 10:07:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7DC206EF;
        Fri, 21 Feb 2020 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582297671;
        bh=QbzsH1rdu5rS8dVWQGh+5kwltd8Y/KBAWxKBBTeFYm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zh9Qq9O2QoH+szrVZUv/fd0qB2W1LWpnfcP1Us/p9f3Rvf2JB31XobGAay/yJ/oAn
         WhgcK859xlt7vOrpAuM9oh1/+8RHxuakHGanMZ+9wS+nf8ZsRdctAn7s3PCLS9GO1e
         J2V1w/EXZDhm5xNf3YVn3d3Bx7iseeRQ+JV8DhQo=
Date:   Fri, 21 Feb 2020 15:07:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: dac: Add docs for AD5770R DAC
Message-ID: <20200221150748.2b7c0b2a@archlinux>
In-Reply-To: <20200218121031.27233-3-alexandru.tachici@analog.com>
References: <20200218121031.27233-1-alexandru.tachici@analog.com>
        <20200218121031.27233-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Feb 2020 14:10:31 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Adding dt-bindings documentation for AD5770R DAC.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 185 ++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> new file mode 100644
> index 000000000000..13d6b5ff479d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -0,0 +1,185 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5770r.yaml#
Umm. adc?  Please make sure you run the build tests on bindings and that
you have a recent version of the dt schema stuff.

I have applied with that fixed, but will be looking to add an Ack from Rob
ideally before I push this out as a non rebasing tree.

Thanks,

Jonathan

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5770R DAC device driver
> +
> +maintainers:
> +  - Mircea Caprioru <mircea.caprioru@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5770R.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5770r
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      AVdd voltage supply. Represents two different supplies in the datasheet
> +      that are in fact the same.
> +
> +  iovdd-supply:
> +    description:
> +      Voltage supply for the chip interface.
> +
> +  vref-supply:
> +    description: Specify the voltage of the external reference used.
> +      Available reference options are 1.25 V or 2.5 V. If no
> +      external reference declared then the device will use the
> +      internal reference of 1.25 V.
> +
> +  adi,external-resistor:
> +    description: Specify if an external 2.5k ohm resistor is used. If not
> +      specified the device will use an internal 2.5k ohm resistor.
> +      The precision resistor is used for reference current generation.
> +    type: boolean
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be
> +      asserted during driver probe.
> +    maxItems: 1
> +
> +  channel0:
> +    description: Represents an external channel which are
> +      connected to the DAC. Channel 0 can act both as a current
> +      source and sink.
> +    type: object
> +
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          const: 0
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/int32-array
> +            - items:
> +                - enum: [0 300000]
> +                - enum: [-60000 0]
> +                - enum: [-60000 300000]
> +
> +  channel1:
> +    description: Represents an external channel which are
> +      connected to the DAC.
> +    type: object
> +
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          const: 1
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 140000]
> +                - enum: [0 250000]
> +
> +  channel2:
> +    description: Represents an external channel which are
> +      connected to the DAC.
> +    type: object
> +
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          const: 2
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 140000]
> +                - enum: [0 250000]
> +
> +patternProperties:
> +  "^channel@([3-5])$":
> +    type: object
> +    description: Represents the external channels which are connected to the DAC.
> +    properties:
> +      num:
> +        description: This represents the channel number.
> +        items:
> +          minimum: 3
> +          maximum: 5
> +
> +      adi,range-microamp:
> +          description: Output range of the channel.
> +          oneOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> +            - items:
> +                - enum: [0 45000]
> +                - enum: [0 100000]
> +
> +required:
> +- reg
> +- diff-channels
> +- channel0
> +- channel1
> +- channel2
> +- channel3
> +- channel4
> +- channel5
> +
> +examples:
> +  - |
> +        spi {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                ad5770r@0 {
> +                        compatible = "ad5770r";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        vref-supply = <&vref>;
> +                        adi,external-resistor;
> +                        reset-gpios = <&gpio 22 0>;
> +
> +                        channel@0 {
> +                                num = <0>;
> +                                adi,range-microamp = <(-60000) 300000>;
> +                        };
> +
> +                        channel@1 {
> +                                num = <1>;
> +                                adi,range-microamp = <0 140000>;
> +                        };
> +
> +                        channel@2 {
> +                                num = <2>;
> +                                adi,range-microamp = <0 55000>;
> +                        };
> +
> +                        channel@3 {
> +                                num = <3>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +
> +                        channel@4 {
> +                                num = <4>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +
> +                        channel@5 {
> +                                num = <5>;
> +                                adi,range-microamp = <0 45000>;
> +                        };
> +                };
> +        };
> +...

