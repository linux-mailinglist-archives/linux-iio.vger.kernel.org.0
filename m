Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C43274D6D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 01:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgIVXk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 19:40:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38451 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVXk3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 19:40:29 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so19061960ilp.5;
        Tue, 22 Sep 2020 16:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VwsVMKt5LBKzyalXTrKSfKxUe2cXNL/It3cmUBcn7mo=;
        b=C2xaSOvqEccJEgqXeoiYkG0CRrTMGay0FR2ZlP+8W2INwmFHOuJhuXkUdE6fDVFyDB
         bgENGBkfnHTwK77CQjbwGD9j0dcPK/XuxRsQOO+E/RUwkhsxXVySNpNVe2DmJ2ZjQMTq
         k41oxEhO3CEGIqFA2emyIzMDUTjAbL0PclZ1U9Izj5w1LWZo/FTVrROB6wzvjPcA4qz4
         yiZoP99M+CETbjbTpYfEj+/VBNItuy5zrEQF5Nf3QEH0vYPu8j4NWUcO6GDK1B3gU7cG
         InO3dcSP065BqmQiZLqzrQjmjTEKu3915jr8ZTjYiPyTpCfA1UcQIO5g1fswd9fpQftf
         wX2g==
X-Gm-Message-State: AOAM5301uHG+a4vXl2Qk0l2LEp0F1Deo6sEJh2M0MXukb0frIQl0rFaD
        zomVtbq7DrzNWicJOSCWJg==
X-Google-Smtp-Source: ABdhPJxFnNdmjaBaZyfVwVFSMX25MtAqn/YJ9Qp7imXCypWJrhabIOF0Va7O5nJxM9cLeWACGv1V5w==
X-Received: by 2002:a92:dd8a:: with SMTP id g10mr4661900iln.125.1600818027386;
        Tue, 22 Sep 2020 16:40:27 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p8sm5933411ilj.36.2020.09.22.16.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:40:26 -0700 (PDT)
Received: (nullmailer pid 3487336 invoked by uid 1000);
        Tue, 22 Sep 2020 23:40:25 -0000
Date:   Tue, 22 Sep 2020 17:40:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20200922234025.GA3476652@bogus>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
 <20200914154809.192174-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914154809.192174-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 14, 2020 at 06:48:01PM +0300, Dmitry Baryshkov wrote:
> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> close counterpart of VADC part of those PMICs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> new file mode 100644
> index 000000000000..432a65839b89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
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
> +            Quicker measurements can be made by reducing decimation ratio.
> +    enum:
> +      - 250
> +      - 420
> +      - 840
> +    default: 840
> +
> +patternProperties:
> +  "^([-a-z0-9]*)@[0-9]+$":

Less than 10 as unit-addresses are hex?

> +    type: object
> +    description:
> +      Represent one thermal sensor.
> +
> +    properties:
> +      reg:
> +        description: Specify the sensor channel.
> +        maxItems: 1

You need a range of values here.

> +
> +      io-channels:
> +        description:
> +          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
> +
> +      qcom,adc-channel:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Corresponding ADC channel ID.

Why is this not a cell in io-channels?

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

Time values should have a unit suffix. Seems like a commmon ADC 
property...

> +
> +      qcom,pre-scaling:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: Used for scaling the channel input signal before the
> +          signal is fed to VADC. See qcom,spi-vadc specification for the list
> +          of possible values.

I'd rather not. Need the values here to validate a DT.

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
> +    #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spmi_bus {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pm8150b_adc: adc@3100 {
> +            reg = <0x3100>;
> +            compatible = "qcom,spmi-adc5";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #io-channel-cells = <1>;
> +            io-channel-ranges;
> +
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
> +
> +            conn-therm@0 {
> +                reg = <0>;
> +                io-channels = <&pm8150b_adc ADC5_AMUX_THM3_100K_PU>;
> +                qcom,adc-channel = <ADC5_AMUX_THM3_100K_PU>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time = <200>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
