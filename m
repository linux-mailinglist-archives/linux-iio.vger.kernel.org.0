Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078D745F4B0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbhKZShR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 13:37:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4176 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbhKZSfR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 13:35:17 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J13GK6Mqyz67hRB;
        Sat, 27 Nov 2021 02:30:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 19:31:59 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 18:31:58 +0000
Date:   Fri, 26 Nov 2021 18:31:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V3 1/4] dt-bindings: thermal: qcom: add PMIC5 Gen2
 ADC_TM bindings
Message-ID: <20211126183157.00003e63@Huawei.com>
In-Reply-To: <1637647025-20409-2-git-send-email-quic_jprakash@quicinc.com>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
        <1637647025-20409-2-git-send-email-quic_jprakash@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 11:27:01 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Add documentation for PMIC5 Gen2 ADC_TM peripheral.
> It is used for monitoring ADC channel thresholds for PMIC7-type
> PMICs. It is present on PMK8350, like PMIC7 ADC and can be used
> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
> on a target, through PBS(Programmable Boot Sequence).
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
This addressed my comments (still open question on whether Rob or anyone
else cares about hiding a typo fix in here, but I'll leave that to others
to comment on).

Thanks,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 3ea8c0c..feb390d 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -10,7 +10,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: qcom,spmi-adc-tm5
> +    enum:
> +      - qcom,spmi-adc-tm5
> +      - qcom,spmi-adc-tm5-gen2
>  
>    reg:
>      maxItems: 1
> @@ -33,6 +35,7 @@ properties:
>    qcom,avg-samples:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: Number of samples to be used for measurement.
> +            Not applicable for Gen2 ADC_TM peripheral.
>      enum:
>        - 1
>        - 2
> @@ -45,6 +48,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: This parameter is used to decrease ADC sampling rate.
>              Quicker measurements can be made by reducing decimation ratio.
> +            Not applicable for Gen2 ADC_TM peripheral.
>      enum:
>        - 250
>        - 420
> @@ -93,6 +97,29 @@ patternProperties:
>            - const: 1
>            - enum: [ 1, 3, 4, 6, 20, 8, 10 ]
>  
> +      qcom,avg-samples:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Number of samples to be used for measurement.
> +          This property in child node is applicable only for Gen2 ADC_TM peripheral.
> +        enum:
> +          - 1
> +          - 2
> +          - 4
> +          - 8
> +          - 16
> +        default: 1
> +
> +      qcom,decimation:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: This parameter is used to decrease ADC sampling rate.
> +          Quicker measurements can be made by reducing decimation ratio.
> +          This property in child node is applicable only for Gen2 ADC_TM peripheral.
> +        enum:
> +          - 85
> +          - 340
> +          - 1360
> +        default: 1360
> +
>      required:
>        - reg
>        - io-channels
> @@ -100,6 +127,31 @@ patternProperties:
>      additionalProperties:
>        false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc-tm5
> +
> +    then:
> +      patternProperties:
> +        "^([-a-z0-9]*)@[0-7]$":
> +          properties:
> +            qcom,decimation: false
> +            qcom,avg-samples: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc-tm5-gen2
> +
> +    then:
> +      properties:
> +        qcom,avg-samples: false
> +        qcom,decimation: false
> +
>  required:
>    - compatible
>    - reg
> @@ -124,7 +176,7 @@ examples:
>              #size-cells = <0>;
>              #io-channel-cells = <1>;
>  
> -            /* Other propreties are omitted */
> +            /* Other properties are omitted */
>              conn-therm@4f {
>                  reg = <ADC5_AMUX_THM3_100K_PU>;
>                  qcom,ratiometric;
> @@ -148,4 +200,58 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spmi_bus {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pmk8350_vadc: adc@3100 {
> +            reg = <0x3100>;
> +            compatible = "qcom,spmi-adc7";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #io-channel-cells = <1>;
> +
> +            /* Other properties are omitted */
> +            xo-therm@44 {
> +                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time = <200>;
> +            };
> +
> +            conn-therm@47 {
> +                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time = <200>;
> +            };
> +        };
> +
> +        pmk8350_adc_tm: adc-tm@3400 {
> +            compatible = "qcom,spmi-adc-tm5-gen2";
> +            reg = <0x3400>;
> +            interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
> +            #thermal-sensor-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            pmk8350-xo-therm@0 {
> +                reg = <0>;
> +                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
> +                qcom,decimation = <340>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time-us = <200>;
> +            };
> +
> +            conn-therm@1 {
> +                reg = <1>;
> +                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
> +                qcom,avg-samples = <2>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time-us = <200>;
> +            };
> +        };
> +    };
>  ...

