Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43193BAE37
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDSI0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 14:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhGDSIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 14:08:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E043A61248;
        Sun,  4 Jul 2021 18:05:46 +0000 (UTC)
Date:   Sun, 4 Jul 2021 19:08:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <git-dev@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <20210704190810.004a531f@jic23-huawei>
In-Reply-To: <20210624182939.12881-4-anand.ashok.dumbre@xilinx.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
        <20210624182939.12881-4-anand.ashok.dumbre@xilinx.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jun 2021 19:29:38 +0100
Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:

> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

Definitely some fiddly bits in here, but it looks fine to me.
It's odd enough that I'll be relying on Rob taking a look though :)


> ---
>  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 228 ++++++++++++++++++
>  1 file changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> new file mode 100644
> index 000000000000..a065ddd55d38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> @@ -0,0 +1,228 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/xlnx,zynqmp-ams.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Ultrascale AMS controller
> +
> +maintainers:
> +  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +
> +description: |
> +  The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
> +  that can be used to sample external voltages and monitor on-die operating
> +  conditions, such as temperature and supply voltage levels.
> +  The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
> +  PS (Processing System) SYSMON.
> +  All designs should have AMS registers, but PS and PL are optional. The
> +  AMS controller can work with only PS, only PL and both PS and PL
> +  configurations. Please specify registers according to your design. Devicetree
> +  should always have AMS module property. Providing PS & PL module is optional.
> +
> +  AMS Channel Details
> +  ```````````````````
> +  Sysmon Block  |Channel|                       Details                                 |Measurement
> +                |Number |                                                               |Type
> +  ---------------------------------------------------------------------------------------------------------
> +  AMS CTRL      |0      |System PLLs voltage measurement, VCC_PSPLL.                    |Voltage
> +                |1      |Battery voltage measurement, VCC_PSBATT.                       |Voltage
> +                |2      |PL Internal voltage measurement, VCCINT.                       |Voltage
> +                |3      |Block RAM voltage measurement, VCCBRAM.                        |Voltage
> +                |4      |PL Aux voltage measurement, VCCAUX.                            |Voltage
> +                |5      |Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.       |Voltage
> +                |6      |VCC_PSINTFP_DDR voltage measurement.                           |Voltage
> +  ---------------------------------------------------------------------------------------------------------
> +  PS Sysmon     |7      |LPD temperature measurement.                                   |Temperature
> +                |8      |FPD temperature measurement (REMOTE).                          |Temperature
> +                |9      |VCC PS LPD voltage measurement (supply1).                      |Voltage
> +                |10     |VCC PS FPD voltage measurement (supply2).                      |Voltage
> +                |11     |PS Aux voltage reference (supply3).                            |Voltage
> +                |12     |DDR I/O VCC voltage measurement.                               |Voltage
> +                |13     |PS IO Bank 503 voltage measurement (supply5).                  |Voltage
> +                |14     |PS IO Bank 500 voltage measurement (supply6).                  |Voltage
> +                |15     |VCCO_PSIO1 voltage measurement.                                |Voltage
> +                |16     |VCCO_PSIO2 voltage measurement.                                |Voltage
> +                |17     |VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).                 |Voltage
> +                |18     |VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).                 |Voltage
> +                |19     |VCC_PSADC voltage measurement.                                 |Voltage
> +  ---------------------------------------------------------------------------------------------------------
> +  PL Sysmon     |20     |PL temperature measurement.                                    |Temperature
> +                |21     |PL Internal voltage measurement, VCCINT.                       |Voltage
> +                |22     |PL Auxiliary voltage measurement, VCCAUX.                      |Voltage
> +                |23     |ADC Reference P+ voltage measurement.                          |Voltage
> +                |24     |ADC Reference N- voltage measurement.                          |Voltage
> +                |25     |PL Block RAM voltage measurement, VCCBRAM.                     |Voltage
> +                |26     |LPD Internal voltage measurement, VCC_PSINTLP (supply4).       |Voltage
> +                |27     |FPD Internal voltage measurement, VCC_PSINTFP (supply5).       |Voltage
> +                |28     |PS Auxiliary voltage measurement (supply6).                    |Voltage
> +                |29     |PL VCCADC voltage measurement (vccams).                        |Voltage
> +                |30     |Differential analog input signal voltage measurment.           |Voltage
> +                |31     |VUser0 voltage measurement (supply7).                          |Voltage
> +                |32     |VUser1 voltage measurement (supply8).                          |Voltage
> +                |33     |VUser2 voltage measurement (supply9).                          |Voltage
> +                |34     |VUser3 voltage measurement (supply10).                         |Voltage
> +                |35     |Auxiliary ch 0 voltage measurement (VAux0).                    |Voltage
> +                |36     |Auxiliary ch 1 voltage measurement (VAux1).                    |Voltage
> +                |37     |Auxiliary ch 2 voltage measurement (VAux2).                    |Voltage
> +                |38     |Auxiliary ch 3 voltage measurement (VAux3).                    |Voltage
> +                |39     |Auxiliary ch 4 voltage measurement (VAux4).                    |Voltage
> +                |40     |Auxiliary ch 5 voltage measurement (VAux5).                    |Voltage
> +                |41     |Auxiliary ch 6 voltage measurement (VAux6).                    |Voltage
> +                |42     |Auxiliary ch 7 voltage measurement (VAux7).                    |Voltage
> +                |43     |Auxiliary ch 8 voltage measurement (VAux8).                    |Voltage
> +                |44     |Auxiliary ch 9 voltage measurement (VAux9).                    |Voltage
> +                |45     |Auxiliary ch 10 voltage measurement (VAux10).                  |Voltage
> +                |46     |Auxiliary ch 11 voltage measurement (VAux11).                  |Voltage
> +                |47     |Auxiliary ch 12 voltage measurement (VAux12).                  |Voltage
> +                |48     |Auxiliary ch 13 voltage measurement (VAux13).                  |Voltage
> +                |49     |Auxiliary ch 14 voltage measurement (VAux14).                  |Voltage
> +                |50     |Auxiliary ch 15 voltage measurement (VAux15).                  |Voltage
> +  --------------------------------------------------------------------------------------------------------
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,zynqmp-ams
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    description: AMS Controller register space
> +    maxItems: 1
> +
> +  ranges:
> +    description:
> +      Maps the child address space for PS and/or PL.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^ams-ps@0,400$":
> +    type: object
> +    description: |
> +      PS (Processing System) SYSMON is memory mapped to PS. This block has
> +      built-in alarm generation logic that is used to interrupt the processor
> +      based on condition set.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - xlnx,zynqmp-ams-ps
> +
> +      reg:
> +        description: Register Space for PS-SYSMON
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false
> +
> +  "^ams-pl@400,400$":
> +    type: object
> +    description:
> +      PL-SYSMON is capable of monitoring off chip voltage and temperature.
> +      PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> +      from external master. Out of this interface currently only DRP is
> +      supported. This block has alarm generation logic that is used to
> +      interrupt the processor based on condition set.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - xlnx,zynqmp-ams-pl
> +
> +      reg:
> +        description: Register Space for PL-SYSMON.
> +        maxItems: 1
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^channel@([2-4][0-9]|50)$":
> +        type: object
> +        description:
> +          Describes the external channels connected.
> +
> +        properties:
> +          reg:
> +            description:
> +              Pair of pins the channel is connected to. This value is
> +              same as Channel Number for a particular channel.
> +            minimum: 20
> +            maximum: 50
> +
> +          xlnx,bipolar:
> +            $ref: /schemas/types.yaml#/definitions/flag
> +            type: boolean
> +            description:
> +              If the set channel is used in bipolar mode.
> +
> +        required:
> +          - reg
> +
> +        additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        xilinx_ams: ams@ffa50000 {
> +            compatible = "xlnx,zynqmp-ams";
> +            interrupt-parent = <&gic>;
> +            interrupts = <0 56 4>;
> +            reg = <0x0 0xffa50000 0x0 0x800>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            #io-channel-cells = <1>;
> +            ranges = <0 0 0xffa50800 0x800>;
> +
> +            ams_ps: ams-ps@0,400 {
> +                compatible = "xlnx,zynqmp-ams-ps";
> +                reg = <0 0x400>;
> +            };
> +
> +            ams_pl: ams-pl@400,400 {
> +                compatible = "xlnx,zynqmp-ams-pl";
> +                reg = <0x400 0x400>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                channel@30 {
> +                    reg = <30>;
> +                    xlnx,bipolar;
> +                };
> +                channel@31 {
> +                    reg = <31>;
> +                };
> +                channel@38 {
> +                    reg = <38>;
> +                    xlnx,bipolar;
> +                };
> +            };
> +        };
> +    };

