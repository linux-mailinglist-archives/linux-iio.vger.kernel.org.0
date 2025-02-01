Return-Path: <linux-iio+bounces-14803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B8A2488D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5183A7FC4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAD417C220;
	Sat,  1 Feb 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3DNKCdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937525760;
	Sat,  1 Feb 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738409657; cv=none; b=EH1yDrflDDMTrVuOoZpFRd7ucfZ82hS6DQxInN9o2nf5sNWuBcQ6ooqI2zjVGy3GRCmbRxaBoU9/Zm85nN6OW/fyyN35jJuJ4ZiWMjZAyv5eYU04GCwDhqiOJ4ym1H19jCBFEEZZdWTdsG5PiJchDUz+1wkcVK7eOz+uXayTmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738409657; c=relaxed/simple;
	bh=FrpZsbP2/uqqlpmV9owZx7N7u+9rg/ypvnTHzl8h6hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eh/MAghdT4Z2cSx+a+qZTdt+z3s4NGqcHOikIBhtJ4mhax/AJ0oKXqnTheCXF1MeXyHcJj4ShSiNaAYXck8t4KqrJAa4lv+1sErjVVwbHgiB5cdhTMvxjG7RU2ZbK9WAgEOyvjc8sWB5kUdKyqBlurRnSBo06ENvQ01125IpgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3DNKCdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D335C4CED3;
	Sat,  1 Feb 2025 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738409653;
	bh=FrpZsbP2/uqqlpmV9owZx7N7u+9rg/ypvnTHzl8h6hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3DNKCdlNWgAd+OQeVROOh8z0aqG5YvACuG3sQsbDgH13veUff6Ef0vPzbh2QEPGv
	 RDaMYnwSo9df79sNw5OtXLorKo77MySGXGhcO9xIXJpTLoPluxc7JcwmHADw/Q6/A1
	 LZ1Sswi2cMS51A5rbsEgEB7K+z8QCv4o1+8hR3WxQY2X0nWuqCKYRDAWQR6VvJEZ2k
	 FSyuTqEI6RB21jgPegXY4uzVZs1yxkv5YZUZBkA3etWeEBPJD1C/agt6cjNBy89FHX
	 Ek4vUQ+Po5LVDc4EqE9fVjweS+aqynFcHg02BAtZ5BYzHGZMxJ4bAEvr9YJI0Jbf05
	 XTIdWmvzg8VVA==
Date: Sat, 1 Feb 2025 11:33:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 lars@metafoo.de, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V5 3/5] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC
Message-ID: <20250201113358.565de2e1@jic23-huawei>
In-Reply-To: <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Feb 2025 00:02:40 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on SDAM (Shared
> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> channels and virtual channels (combination of ADC channel number and
> PMIC SID number) per PMIC, to be used by clients of this device.

A few really minor comments inline given you are going to be doing a v6
for the build errors Rob's bot found.  I guess this is racing
with some other changes.

> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v4:
> - Added ADC5 Gen3 documentation in a separate new file to avoid complicating
>   existing VADC documentation file further to accomodate this device, as
>   suggested by reviewer.
> 
> Changes since v3:
> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>   instead of adding separate file and updated top-level constraints in documentation
>   file based on discussion with reviewers.
> - Dropped default SID definitions.
> - Addressed other reviewer comments.
> 
> Changes since v2:
> - Moved ADC5 Gen3 documentation into a separate new file.
> 
> Changes since v1:
> - Updated properties separately for all compatibles to clarify usage
>   of new properties and updates in usage of old properties for ADC5 Gen3.
> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>   mentioning this convention.
> - Used predefined channel IDs in individual PMIC channel definitions
>   instead of numeric IDs.
> - Addressed other comments from reviewers.
> 
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 157 ++++++++++++++++++
>  .../iio/adc/qcom,spmi-vadc-common.yaml        |   4 +-
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  46 +++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  85 ++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 +++
>  .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  52 ++++++
>  include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++++
>  8 files changed, 447 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> 
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

Trivial but slightly short wrap. I think dt bindings use 80 chars
as the limit.

> +  clients to read voltage. It is a 16-bit sigma-delta ADC.
> +  It also performs the same thermal monitoring function as
> +  the existing ADC_TM devices.
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
> +
> +  interrupt-names:
> +    items:
> +      - const: sdam0
> +      - const: sdam1
> +    minItems: 1
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
> +  "^channel@[0-9a-f]+$":
> +    type: object
> +    unevaluatedProperties: false
> +    description: |
Doesn't look like it needs formatting. So no need for |

> +      Represents the external channels which are connected to the ADC.

Maybe better to move ref before description.

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

Might be more readable as groups of 8. We love powers of two ;)

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



