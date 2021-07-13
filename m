Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5593C79A9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhGMWeE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 18:34:04 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:34660 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhGMWeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 18:34:04 -0400
Received: by mail-io1-f44.google.com with SMTP id g22so29291778iom.1;
        Tue, 13 Jul 2021 15:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lrndWu7lNiq0sA/tde7IoC1obagG8mGb0tqKYgh0kLI=;
        b=jp5/D6XUYWFFGQE37A2HSiS4OZzs002hAqf2MdYaThpqrZFynxFm6XcVHVXbDGh67I
         4hp4MKZayQ5cR2e5KvNqBhoJQz7hKB9DCmCXDmCniOHaij6+cqWGfxAnKlMhxi5J95p9
         7aKizJ/Mi/UJZbokelSPhhXJ1ePMMk1BEyRN+MZjBHWH1a3OakbleKixgaHAWXE54lMM
         r60Ty1h3Zz1gdbU5vGs6EUbZLsaBANf6YvV7oSlP6SZcoF2ws3Jf2RQpSUZU3szXxZ/Q
         MxfaWKNRLwpZwuK/VX7XDYiXUKs4E6dn3fPEkxTV/CXmX5VTymQkxah4sXelGjYtTz6b
         b/Rg==
X-Gm-Message-State: AOAM532bKkYKs2PUc4fnqh90c/sKSXTGLZvKaqQ7Oqp3Lt0ofycODVet
        GN4cuL2f2FAbJH4Ie/OT/A==
X-Google-Smtp-Source: ABdhPJxc32eJmB20sDC3/vQrTR1MrloABvFZNzCFEjf4118wC2YYZbRhQoF0i+iRbXECtfj99cQQzg==
X-Received: by 2002:a5e:8a06:: with SMTP id d6mr4962216iok.82.1626215472242;
        Tue, 13 Jul 2021 15:31:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m24sm92999ion.3.2021.07.13.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:31:11 -0700 (PDT)
Received: (nullmailer pid 967501 invoked by uid 1000);
        Tue, 13 Jul 2021 22:31:10 -0000
Date:   Tue, 13 Jul 2021 16:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        git-dev@xilinx.com, michal.simek@xilinx.com, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Message-ID: <20210713223110.GA959341@robh.at.kernel.org>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
 <20210624182939.12881-4-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624182939.12881-4-anand.ashok.dumbre@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 24, 2021 at 07:29:38PM +0100, Anand Ashok Dumbre wrote:
> Xilinx AMS have several ADC channels that can be used for measurement of
> different voltages and temperatures. Document the same in the bindings.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
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

If your going to hardcode the unit-address, then it's a fixed string and 
should be under 'properties' instead.

The unit-address is also wrong. This is memory-mapped ranges, right? If 
so, this should just be '0' and the next one '400'.

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

Don't we have a common property for this now?

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
> -- 
> 2.17.1
> 
> 
