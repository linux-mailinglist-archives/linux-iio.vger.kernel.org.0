Return-Path: <linux-iio+bounces-14863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DBA24E50
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4624B162C80
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AE1D90D4;
	Sun,  2 Feb 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjxMu+dO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB71D90A7;
	Sun,  2 Feb 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738503510; cv=none; b=Ij2bT2EuCUIXMce4KWGNn0ISIO6u79u47booNVf178JJ/5ahJaXmJym1DmvPlbn9U6UqEn5eOpO1shFuQr93WhxyyiNpLE6vr7gWhjg5MIfu+Ga2Nw13NEcAW6oxDQECTG01L134mVT4xQvsbkMeSw2MKJhJFQuLjfAzDDItxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738503510; c=relaxed/simple;
	bh=Rh/X6LJOfTkJBDg+yE0C0DAq5GEv901Lhj/SFiZN/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktz8FrgaIDfDe4uMG6AgOr5JUJmrG1NVZvAYvKmCaD+5BKXEGp/ZUdLgIWCW4M6VQGIjmn7YhblKkofLnKQB8WLADUaF0BhVSEO1t395y+oMhushCCqUGPEUtL3u1+nGjSzAFoJWaMoQ60wgCWfv8CrqgOXJS2xOVa04jjSfD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjxMu+dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524C4C4CED1;
	Sun,  2 Feb 2025 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738503510;
	bh=Rh/X6LJOfTkJBDg+yE0C0DAq5GEv901Lhj/SFiZN/J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjxMu+dOuFedE+UllPmgXHV0OKqHmlA82QA+b404nq5BAzo3XxU05wpTDpok+QC6p
	 2IapFJODjTyTMS0n4EBrmD22xxWhySNI0kWhKK9TCzSb7HoRrHfR9oBGXEuntSWAR9
	 njHpL9/QQO7Bv+ASc/zA7BbwFfPAWvYUrxASapVdihykNgao/8ZB0ayfzT2PVQby6T
	 2GWw/ak24CQEw6q/PD/Xds2yctxzUHCY7ODtymr+th/GjcK8Ns+q86Aktx391jfuSM
	 MlisXCj/UTGxGCOc1qqIEcNx81ZnINOLq+XOHDK0M7j6S9L0HsE4C9Dheam9VKxE+h
	 OFhFkY7a7X+qA==
Date: Sun, 2 Feb 2025 14:38:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, konradybcio@kernel.org, daniel.lezcano@linaro.org, 
	sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org, 
	rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, quic_kamalw@quicinc.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com, 
	neil.armstrong@linaro.org
Subject: Re: [PATCH V5 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Message-ID: <20250202-pragmatic-sparkling-spider-ccd90b@krzk-bin>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>

On Sat, Feb 01, 2025 at 12:02:40AM +0530, Jishnu Prakash wrote:
 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> new file mode 100644
> index 000000000000..d6f2d18623d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's SPMI PMIC ADC5 Gen3
> +
> +maintainers:
> +  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> +
> +description: |
> +  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to
> +  clients to read voltage. It is a 16-bit sigma-delta ADC.
> +  It also performs the same thermal monitoring function as
> +  the existing ADC_TM devices.

Don't wrap at 61, but at 80. See Coding style.

> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-adc5-gen3
> +
> +  reg:
> +    items:
> +      - description: SDAM0 base address in the SPMI PMIC register map
> +      - description: SDAM1 base address
> +    minItems: 1

Why is this flexible?

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
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  interrupts:
> +    items:
> +      - description: SDAM0 end of conversion (EOC) interrupt
> +      - description: SDAM1 EOC interrupt
> +    minItems: 1

Same question.

> +
> +  interrupt-names:
> +    items:
> +      - const: sdam0
> +      - const: sdam1
> +    minItems: 1

So basically interrupt 0 and 1, just drop the names property entirely.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +  - interrupts
> +  - interrupt-names
> +
> +patternProperties:

required block always goes after all properties, not in the middle.

> +  "^channel@[0-9a-f]+$":
> +    type: object
> +    unevaluatedProperties: false
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Represents the external channels which are connected to the ADC.
> +    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
> +
> +    properties:
> +      qcom,decimation:
> +        enum: [ 85, 340, 1360 ]
> +        default: 1360
> +
> +      qcom,hw-settle-time:
> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
> +                8000, 16000, 32000, 64000, 128000 ]
> +        default: 15
> +
> +      qcom,avg-samples:
> +        enum: [ 1, 2, 4, 8, 16 ]
> +        default: 1
> +
> +      qcom,adc-tm:
> +        description:
> +          ADC_TM is a threshold monitoring feature in HW which can be enabled on any
> +          ADC channel, to trigger an IRQ for threshold violation. In earlier ADC
> +          generations, it was implemented in a separate device (documented in
> +          Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
> +          In Gen3, this feature can be enabled in the same ADC device for any channel
> +          and threshold monitoring and IRQ triggering are handled in FW (PBS) instead of
> +          another dedicated HW block.
> +          This property indicates ADC_TM monitoring is done on this channel.
> +        type: boolean
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@9000 {
> +        compatible = "qcom,spmi-adc5-gen3";
> +        reg = <0x9000>, <0x9100>;
> +        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
> +                      <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "sdam0", "sdam1";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +        #thermal-sensor-cells = <1>;
> +
> +        /* PMK8550 Channel nodes */
> +        channel@3 {
> +          reg = <PMK8550_ADC5_GEN3_DIE_TEMP(0)>;
> +          label = "pmk8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        channel@44 {
> +          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU(0)>;
> +          label = "pmk8550_xo_therm";
> +          qcom,pre-scaling = <1 1>;
> +          qcom,ratiometric;
> +          qcom,hw-settle-time = <200>;
> +          qcom,adc-tm;
> +        };
> +
> +        /* PM8550 Channel nodes */
> +        channel@103 {
> +          reg = <PM8550_ADC5_GEN3_DIE_TEMP(1)>;
> +          label = "pm8550_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +
> +        /* PM8550B Channel nodes */
> +        channel@78f {
> +          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG(7)>;
> +          label = "pm8550b_vbat_sns_qbg";
> +          qcom,pre-scaling = <1 3>;
> +        };
> +
> +        /* PM8550VS_C Channel nodes */
> +        channel@203 {
> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
> +          label = "pm8550vs_c_die_temp";
> +          qcom,pre-scaling = <1 1>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
> index cd087911ee88..1531153e6ea8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
> @@ -17,8 +17,8 @@ properties:
>      description:
>        ADC channel number.
>        See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> -      For PMIC7 ADC, the channel numbers are specified separately per PMIC
> -      in the PMIC-specific files in include/dt-bindings/iio/adc.
> +      For PMIC7 ADC and PMIC5 Gen3 ADC, the channel numbers are specified
> +      separately per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>      maxItems: 1
>  
>    label:
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index b0ccad00c1a6..b77af38440fe 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -15,6 +15,8 @@ description: |
>    voltage. The VADC is a 15-bit sigma-delta ADC.
>    SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>    voltage. The VADC is a 16-bit sigma-delta ADC.
> +  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
> +  it can be considered like PMIC5 Gen2.
>  
>  properties:
>    compatible:
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
> new file mode 100644
> index 000000000000..9940715683b4
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h


Which is the name/model of the device? PM8550? If so, then this must
follow standard compatible naming, so qcom,pm8550-foo-bar. Unless device
name is somehow different.

Also drop redundant pieces here - can it be anything else than SPMI?
Like I2C?

Best regards,
Krzysztof


