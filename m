Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2569843D002
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbhJ0Rtj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235983AbhJ0Rtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:49:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3498660296;
        Wed, 27 Oct 2021 17:47:06 +0000 (UTC)
Date:   Wed, 27 Oct 2021 18:51:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <Jonathan.Cameron@huawei.com>,
        <amitk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] dt-bindings: thermal: qcom: add PMIC5 Gen2
 ADC_TM bindings
Message-ID: <20211027185133.0d7831fc@jic23-huawei>
In-Reply-To: <1635264275-12530-2-git-send-email-quic_jprakash@quicinc.com>
References: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
        <1635264275-12530-2-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Oct 2021 21:34:33 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Add documentation for PMIC5 Gen2 ADC_TM peripheral.
> It is used for monitoring ADC channel thresholds for PMIC7-type
> PMICs. It is present on PMK8350, like PMIC7 ADC and can be used
> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
> on a target, through PBS(Programmable Boot Sequence).
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Hi Jishnu,

A few comments inline.

Thanks,

Jonathan

> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 83 +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 3ea8c0c..71a05a3 100644
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

Why not use an matching statement to set
qcom,avg_samples: false
for that compatible rather than relying on the fuzzy nature of a coment.


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
> @@ -124,7 +151,7 @@ examples:
>              #size-cells = <0>;
>              #io-channel-cells = <1>;
>  
> -            /* Other propreties are omitted */
> +            /* Other properties are omitted */

Should really be a separate patch, but up to Rob.


>              conn-therm@4f {
>                  reg = <ADC5_AMUX_THM3_100K_PU>;
>                  qcom,ratiometric;
> @@ -148,4 +175,56 @@ examples:
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
> +                qcom,ratiometric;
> +                qcom,hw-settle-time-us = <200>;

Perhaps include the new properties you are defining in the example?

> +            };
> +
> +            conn-therm@1 {
> +                reg = <1>;
> +                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
> +                qcom,ratiometric;
> +                qcom,hw-settle-time-us = <200>;
> +            };
> +        };
> +    };
>  ...

