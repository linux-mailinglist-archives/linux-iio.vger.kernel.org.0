Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88320C165
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgF0NMo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 09:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0NMn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 09:12:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29F22207E8;
        Sat, 27 Jun 2020 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593263561;
        bh=BBlB1KWcJsLKGF5UEELLanB5fxTeYHN5Td1hV7IMtX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WmAAzLWEEhP6renhj/FnBq5Y1K/M0rUJeqQXg7o8ZNsrt1fJ9kduyZToekGWCZmCr
         SoFj/bW0aZw6JC2pwYLL22Dfli+WKvnb2D0/l0MO4gcQI70vTfqrI251BvYcv+WceU
         gply+j+G+m5ovH9mwj95rw2UK1IhVzBlkiZf+Y5Y=
Date:   Sat, 27 Jun 2020 14:12:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V7 1/7] iio: adc: Convert the QCOM SPMI ADC bindings to
 .yaml format
Message-ID: <20200627141235.6496c668@archlinux>
In-Reply-To: <1592897399-24089-2-git-send-email-jprakash@codeaurora.org>
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
        <1592897399-24089-2-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Jun 2020 12:59:53 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Convert the adc bindings from .txt to .yaml format.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
I applied all but patch 7 from the previous version (I think)

Given there doesn't seem to be a chance log I'll assume only
that patch changed and apply that one on top.

If there were any other changes then please send an incremental
patch.

Clearly this means I'm not adding Andy's additional Acks as that
would require a rebase I'd rather not do.  Sorry about that Andy!

Jonathan



> ---
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 --------------
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 252 +++++++++++++++++++++
>  2 files changed, 252 insertions(+), 173 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> deleted file mode 100644
> index c878768..0000000
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ /dev/null
> @@ -1,173 +0,0 @@
> -Qualcomm's SPMI PMIC ADC
> -
> -- SPMI PMIC voltage ADC (VADC) provides interface to clients to read
> -  voltage. The VADC is a 15-bit sigma-delta ADC.
> -- SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> -  voltage. The VADC is a 16-bit sigma-delta ADC.
> -
> -VADC node:
> -
> -- compatible:
> -    Usage: required
> -    Value type: <string>
> -    Definition: Should contain "qcom,spmi-vadc".
> -                Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
> -                Should contain "qcom,spmi-adc-rev2" for PMIC rev2 ADC driver.
> -                Should contain "qcom,pms405-adc" for PMS405 PMIC
> -
> -- reg:
> -    Usage: required
> -    Value type: <prop-encoded-array>
> -    Definition: VADC base address in the SPMI PMIC register map.
> -
> -- #address-cells:
> -    Usage: required
> -    Value type: <u32>
> -    Definition: Must be one. Child node 'reg' property should define ADC
> -            channel number.
> -
> -- #size-cells:
> -    Usage: required
> -    Value type: <u32>
> -    Definition: Must be zero.
> -
> -- #io-channel-cells:
> -    Usage: required
> -    Value type: <u32>
> -    Definition: Must be one. For details about IIO bindings see:
> -            Documentation/devicetree/bindings/iio/iio-bindings.txt
> -
> -- interrupts:
> -    Usage: optional
> -    Value type: <prop-encoded-array>
> -    Definition: End of conversion interrupt.
> -
> -Channel node properties:
> -
> -- reg:
> -    Usage: required
> -    Value type: <u32>
> -    Definition: ADC channel number.
> -            See include/dt-bindings/iio/qcom,spmi-vadc.h
> -
> -- label:
> -    Usage: required for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2"
> -    Value type: <empty>
> -    Definition: ADC input of the platform as seen in the schematics.
> -            For thermistor inputs connected to generic AMUX or GPIO inputs
> -            these can vary across platform for the same pins. Hence select
> -            the platform schematics name for this channel.
> -
> -- qcom,decimation:
> -    Usage: optional
> -    Value type: <u32>
> -    Definition: This parameter is used to decrease ADC sampling rate.
> -            Quicker measurements can be made by reducing decimation ratio.
> -            - For compatible property "qcom,spmi-vadc", valid values are
> -              512, 1024, 2048, 4096. If property is not found, default value
> -              of 512 will be used.
> -            - For compatible property "qcom,spmi-adc5", valid values are 250, 420
> -              and 840. If property is not found, default value of 840 is used.
> -            - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
> -              512 and 1024. If property is not present, default value is 1024.
> -
> -- qcom,pre-scaling:
> -    Usage: optional
> -    Value type: <u32 array>
> -    Definition: Used for scaling the channel input signal before the signal is
> -            fed to VADC. The configuration for this node is to know the
> -            pre-determined ratio and use it for post scaling. Select one from
> -            the following options.
> -            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
> -            If property is not found default value depending on chip will be used.
> -
> -- qcom,ratiometric:
> -    Usage: optional
> -    Value type: <empty>
> -    Definition: Channel calibration type.
> -            - For compatible property "qcom,spmi-vadc", if this property is
> -              specified VADC will use the VDD reference (1.8V) and GND for
> -              channel calibration. If property is not found, channel will be
> -              calibrated with 0.625V and 1.25V reference channels, also
> -              known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> -              if this property is specified VADC will use the VDD reference
> -              (1.875V) and GND for channel calibration. If property is not found,
> -              channel will be calibrated with 0V and 1.25V reference channels,
> -              also known as absolute calibration.
> -
> -- qcom,hw-settle-time:
> -    Usage: optional
> -    Value type: <u32>
> -    Definition: Time between AMUX getting configured and the ADC starting
> -            conversion. The 'hw_settle_time' is an index used from valid values
> -            and programmed in hardware to achieve the hardware settling delay.
> -            - For compatible property "qcom,spmi-vadc" and "qcom,spmi-adc-rev2",
> -              Delay = 100us * (hw_settle_time) for hw_settle_time < 11,
> -              and 2ms * (hw_settle_time - 10) otherwise.
> -              Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
> -              900 us and 1, 2, 4, 6, 8, 10 ms.
> -              If property is not found, channel will use 0us.
> -            - For compatible property "qcom,spmi-adc5", delay = 15us for
> -              value 0, 100us * (value) for values < 11,
> -              and 2ms * (value - 10) otherwise.
> -              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 800,
> -              900 us and 1, 2, 4, 6, 8, 10 ms
> -              Certain controller digital versions have valid values of
> -              15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
> -              If property is not found, channel will use 15us.
> -
> -- qcom,avg-samples:
> -    Usage: optional
> -    Value type: <u32>
> -    Definition: Number of samples to be used for measurement.
> -            Averaging provides the option to obtain a single measurement
> -            from the ADC that is an average of multiple samples. The value
> -            selected is 2^(value).
> -            - For compatible property "qcom,spmi-vadc", valid values
> -              are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
> -              If property is not found, 1 sample will be used.
> -            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> -              valid values are: 1, 2, 4, 8, 16
> -              If property is not found, 1 sample will be used.
> -
> -NOTE:
> -
> -For compatible property "qcom,spmi-vadc" following channels, also known as
> -reference point channels, are used for result calibration and their channel
> -configuration nodes should be defined:
> -VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
> -VADC_GND_REF and VADC_VDD_VADC.
> -
> -Example:
> -
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> -#include <linux/irq.h>
> -/* ... */
> -
> -	/* VADC node */
> -	pmic_vadc: vadc@3100 {
> -		compatible = "qcom,spmi-vadc";
> -		reg = <0x3100>;
> -		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		#io-channel-cells = <1>;
> -		io-channel-ranges;
> -
> -		/* Channel node */
> -		adc-chan@VADC_LR_MUX10_USB_ID {
> -			reg = <VADC_LR_MUX10_USB_ID>;
> -			qcom,decimation = <512>;
> -			qcom,ratiometric;
> -			qcom,hw-settle-time = <200>;
> -			qcom,avg-samples = <1>;
> -			qcom,pre-scaling = <1 3>;
> -		};
> -	};
> -
> -	/* IIO client node */
> -	usb {
> -		io-channels = <&pmic_vadc VADC_LR_MUX10_USB_ID>;
> -		io-channel-names = "vadc";
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> new file mode 100644
> index 0000000..de8d243
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -0,0 +1,252 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-vadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC ADC
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  SPMI PMIC voltage ADC (VADC) provides interface to clients to read
> +  voltage. The VADC is a 15-bit sigma-delta ADC.
> +  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> +  voltage. The VADC is a 16-bit sigma-delta ADC.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: qcom,pms405-adc
> +          - const: qcom,spmi-adc-rev2
> +
> +      - items:
> +        - enum:
> +          - qcom,spmi-vadc
> +          - qcom,spmi-adc5
> +          - qcom,spmi-adc-rev2
> +
> +  reg:
> +    description: VADC base address in the SPMI PMIC register map
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      End of conversion interrupt.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      For compatible property "qcom,spmi-vadc" following channels, also known as
> +      reference point channels, are used for result calibration and their channel
> +      configuration nodes should be defined:
> +      VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
> +      VADC_GND_REF and VADC_VDD_VADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          ADC channel number.
> +          See include/dt-bindings/iio/qcom,spmi-vadc.h
> +
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: |
> +            ADC input of the platform as seen in the schematics.
> +            For thermistor inputs connected to generic AMUX or GPIO inputs
> +            these can vary across platform for the same pins. Hence select
> +            the platform schematics name for this channel.
> +
> +      qcom,decimation:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            This parameter is used to decrease ADC sampling rate.
> +            Quicker measurements can be made by reducing decimation ratio.
> +
> +      qcom,pre-scaling:
> +        description: |
> +            Used for scaling the channel input signal before the signal is
> +            fed to VADC. The configuration for this node is to know the
> +            pre-determined ratio and use it for post scaling. It is a pair of
> +            integers, denoting the numerator and denominator of the fraction by which
> +            input signal is multiplied. For example, <1 3> indicates the signal is scaled
> +            down to 1/3 of its value before ADC measurement.
> +            If property is not found default value depending on chip will be used.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +        oneOf:
> +          - items:
> +            - const: 1
> +            - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
> +
> +          - items:
> +            - const: 10
> +            - const: 81
> +
> +      qcom,ratiometric:
> +        description: |
> +            Channel calibration type.
> +            - For compatible property "qcom,spmi-vadc", if this property is
> +              specified VADC will use the VDD reference (1.8V) and GND for
> +              channel calibration. If property is not found, channel will be
> +              calibrated with 0.625V and 1.25V reference channels, also
> +              known as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> +              if this property is specified VADC will use the VDD reference (1.875V)
> +              and GND for channel calibration. If property is not found, channel
> +              will be calibrated with 0V and 1.25V reference channels, also known
> +              as absolute calibration.
> +        type: boolean
> +
> +      qcom,hw-settle-time:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            Time between AMUX getting configured and the ADC starting
> +            conversion. The 'hw_settle_time' is an index used from valid values
> +            and programmed in hardware to achieve the hardware settling delay.
> +
> +      qcom,avg-samples:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +            Number of samples to be used for measurement.
> +            Averaging provides the option to obtain a single measurement
> +            from the ADC that is an average of multiple samples. The value
> +            selected is 2^(value).
> +
> +    required:
> +      - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-vadc
> +
> +    then:
> +      patternProperties:
> +        "^.*@[0-9a-f]+$":
> +          properties:
> +            qcom,decimation:
> +              enum: [ 512, 1024, 2048, 4096 ]
> +              default: 512
> +
> +            qcom,hw-settle-time:
> +              enum: [ 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
> +                      4, 6, 8, 10 ]
> +              default: 0
> +
> +            qcom,avg-samples:
> +              enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 ]
> +              default: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc-rev2
> +
> +    then:
> +      patternProperties:
> +        "^.*@[0-9a-f]+$":
> +          properties:
> +            qcom,decimation:
> +              enum: [ 256, 512, 1024 ]
> +              default: 1024
> +
> +            qcom,hw-settle-time:
> +              enum: [ 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
> +                      4, 6, 8, 10 ]
> +              default: 0
> +
> +            qcom,avg-samples:
> +              enum: [ 1, 2, 4, 8, 16 ]
> +              default: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc5
> +
> +    then:
> +      patternProperties:
> +        "^.*@[0-9a-f]+$":
> +          properties:
> +            qcom,decimation:
> +              enum: [ 250, 420, 840 ]
> +              default: 840
> +
> +            qcom,hw-settle-time:
> +              enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1, 2,
> +                      4, 6, 8, 10, 16, 32, 64, 128 ]
> +              default: 15
> +
> +            qcom,avg-samples:
> +              enum: [ 1, 2, 4, 8, 16 ]
> +              default: 1
> +
> +examples:
> +  - |
> +    spmi_bus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      /* VADC node */
> +      pmic_vadc: adc@3100 {
> +        compatible = "qcom,spmi-vadc";
> +        reg = <0x3100>;
> +        interrupts = <0x0 0x31 0x0 0x1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +        io-channel-ranges;
> +
> +        /* Channel node */
> +        adc-chan@39 {
> +          reg = <0x39>;
> +          qcom,decimation = <512>;
> +          qcom,ratiometric;
> +          qcom,hw-settle-time = <200>;
> +          qcom,avg-samples = <1>;
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        adc-chan@9 {
> +          reg = <0x9>;
> +        };
> +
> +        adc-chan@a {
> +          reg = <0xa>;
> +        };
> +
> +        adc-chan@e {
> +          reg = <0xe>;
> +        };
> +
> +        adc-chan@f {
> +          reg = <0xf>;
> +        };
> +      };
> +    };

