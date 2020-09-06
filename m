Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AC525EE16
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgIFORK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgIFOQt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:16:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31DCB20714;
        Sun,  6 Sep 2020 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599401652;
        bh=RARGd5sTlXJsH1PMNVa4z6Dg9tpvxraIKMfswKQWg/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0bhGrkolg90PzA/+bx+YFG7ClPcbM6yDhMsuJRjN8zQO389wakB6CkgHDeKBF9o03
         2hZvNHzoEwfeGIlZxBnlkUZwWhh0n419gXCYh3tn5XjHP95sRsfpBlPQmW6Tg4SDs6
         IVRinTCl9K9sQyDobtV6m8oHNCHLV8UzoQiYa/t8=
Date:   Sun, 6 Sep 2020 15:14:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20200906151407.71ac5fde@archlinux>
In-Reply-To: <20200903132109.1914011-2-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
        <20200903132109.1914011-2-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 16:21:01 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> new file mode 100644
> index 000000000000..94aaf3720b9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC ADC-TM
> +maintainers:
> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-adc-tm5
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors. Since
> +      we have multiple sensors this is set to 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  io-channels:
> +    description:
> +      From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
> +
> +  io-channel-names:
> +    description:
> +      From common IIO binding. Names each of IIO channels. The name should
> +      be equal to the sensor's subnode name.
> +
> +  qcom,avg-samples:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of samples to be used for measurement.
> +    enum:
> +      - 1
> +      - 2
> +      - 4
> +      - 8
> +      - 16
> +    default: 1
> +
> +  qcom,decimation:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: This parameter is used to decrease ADC sampling rate.

Just curious, but how is it used?  What do 250, 420 etc actually refer to?

> +    enum:
> +      - 250
> +      - 420
> +      - 840
> +    default: 840
> +
> +patternProperties:
> +  "^([-a-z0-9]*)@[0-9]+$":
> +    type: object
> +    description:
> +      Represent one thermal sensor.
> +
> +    properties:
> +      reg:
> +        description: Specify the sensor channel.
> +        maxItems: 1
> +
> +      qcom,adc-channel:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Corresponding ADC channel ID.

Comment down at the example.

> +
> +      qcom,ratiometric:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Channel calibration type.
> +          If this property is specified VADC will use the VDD reference
> +          (1.875V) and GND for channel calibration. If property is not found,
> +          channel will be calibrated with 0V and 1.25V reference channels,
> +          also known as absolute calibration.
> +
> +      qcom,hw-settle-time:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Time between AMUX getting configured and the ADC starting conversion.
> +
> +      qcom,pre-scaling:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: Used for scaling the channel input signal before the signal is fed to VADC. See qcom,spi-vadc specification for the list of possible values.

Very long line.

> +        minItems: 2
> +        maxItems: 2
> +
> +    required:
> +      - reg
> +      - qcom,adc-channel
> +
> +    additionalProperties:
> +      false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        pm8150b_adc: adc@3100 {
> +            compatible = "qcom,spmi-adc5";
> +            /* Other propreties are omitted */
> +            conn-therm@4f {
> +                reg = <ADC5_AMUX_THM3_100K_PU>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time = <200>;
> +            };
> +        };
> +
> +        pm8150b_adc_tm: adc-tm@3500 {
> +            compatible = "qcom,spmi-adc-tm5";
> +            reg = <0x3500>;
> +            interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> +            #thermal-sensor-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
> +            io-channel-names = "conn-therm";
> +
> +            conn-therm@0 {
> +                reg = <0>;
> +                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;

Would we be better off putting the io-channels entry directly in the child
and lose the indirection? Would make the driver a bit more fiddly perhaps
but give a more elegant binding by dropping one level of indirection
/repetition.

> +                qcom,ratiometric;
> +                qcom,hw-settle-time = <200>;
> +            };
> +        };
> +...

