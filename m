Return-Path: <linux-iio+bounces-23356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94DB3B424
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9435822F9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3A2586E8;
	Fri, 29 Aug 2025 07:19:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3B54279;
	Fri, 29 Aug 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451999; cv=none; b=AJpM9mb7EwQdb8mnA2Napf+Hyea7xEXy16WKfko6ikyEclhepxV4AjSDaUiQx7aR+Hdw8so/ZTjJdT9kq2op2Rei0qlYZa6L3g5oYFAnaIforxxolXGScXsn+KmPwmQ21WdYqZHAOhAFHvrQXAk1zj3pE6xaog2z+auPH5JBY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451999; c=relaxed/simple;
	bh=9ZZDicF89XaFxqoOkA/eseBFWRwCoxHtf7yIIFi7nRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGTRuK/GZhLLEZkZieRMbNWvP66ul71DUSgjC2YaJf5R5aZkCitUae7oJrurFFi2o8c7qzMUriKZTAqCW3aWBC5RCZYpS2gIkhb6VJyBh8AOas00Ps5TeS8aZSII6+HzRIUEKn6tP+Bl3uac3RzUkJMxtZQe2q+t+xyv7hdtdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EDDC4CEF0;
	Fri, 29 Aug 2025 07:19:58 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:19:56 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, lumag@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org, daniel.lezcano@linaro.org, 
	sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org, 
	rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, 
	kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Message-ID: <20250829-classic-dynamic-clam-addbd8@kuoka>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 02:06:55PM +0530, Jishnu Prakash wrote:
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
> PMIC SID number) per PMIC, to be used by clients of this device. Also
> update SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v6:
> - Updated SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode and
>   copyright license in newly added files.

So you did not implement my requests/comments from v5? I did not request
above, I had many, many other comments.



> 
> Changes since v5:
> - Added more details in binding description explaining how number
>   of SDAM peripherals used for ADC is allocated per SoC.
> - Renamed per-PMIC binding files listing ADC channel macro names 
>   and addressed other reviewer comments.
> 
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
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 155 ++++++++++++++++++
>  .../iio/adc/qcom,spmi-vadc-common.yaml        |   4 +-
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
>  .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
>  .../iio/adc/qcom,pm8550-adc5-gen3.h           |  46 ++++++
>  .../iio/adc/qcom,pm8550b-adc5-gen3.h          |  85 ++++++++++
>  .../iio/adc/qcom,pm8550vx-adc5-gen3.h         |  22 +++
>  .../iio/adc/qcom,pmk8550-adc5-gen3.h          |  52 ++++++
>  include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  79 +++++++++
>  9 files changed, 444 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> new file mode 100644
> index 000000000000..40eb20b9d9de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -0,0 +1,155 @@
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
> +  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to clients to read
> +  voltage. It is a 16-bit sigma-delta ADC. It also performs the same thermal
> +  monitoring function as the existing ADC_TM devices.
> +
> +  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
> +  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
> +  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
> +  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
> +  All boards using a particular (SOC + master PMIC) combination will have the
> +  same number of ADC SDAMs supported on that PMIC.
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

Nothing improved here, still mess with quotes.

I am not going to check the rest of comments, because:
1. Your changelog is vague and claims you did not implement them,
2. b4 diff does not work, base-commit is unknown.
3. Main changelog is even more vague.

You make it difficult for us to review your patches, fine. You will get:

NAK (plus one more comment below)

> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> index ef07ecd4d585..b1b89e874316 100644
> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> @@ -300,4 +300,83 @@
>  #define ADC7_SBUx				0x94
>  #define ADC7_VBAT_2S_MID			0x96
>  
> +/* ADC channels for PMIC5 Gen3 */
> +
> +#define ADC5_GEN3_REF_GND			0x00
> +#define ADC5_GEN3_1P25VREF			0x01
> +#define ADC5_GEN3_VREF_VADC			0x02
> +#define ADC5_GEN3_DIE_TEMP			0x03
> +
> +#define ADC5_GEN3_AMUX1_THM			0x04
> +#define ADC5_GEN3_AMUX2_THM			0x05
> +#define ADC5_GEN3_AMUX3_THM			0x06
> +#define ADC5_GEN3_AMUX4_THM			0x07
> +#define ADC5_GEN3_AMUX5_THM			0x08
> +#define ADC5_GEN3_AMUX6_THM			0x09
> +#define ADC5_GEN3_AMUX1_GPIO			0x0a
> +#define ADC5_GEN3_AMUX2_GPIO			0x0b
> +#define ADC5_GEN3_AMUX3_GPIO			0x0c
> +#define ADC5_GEN3_AMUX4_GPIO			0x0d
> +
> +#define ADC5_GEN3_CHG_TEMP			0x10
> +#define ADC5_GEN3_USB_SNS_V_16			0x11
> +#define ADC5_GEN3_VIN_DIV16_MUX			0x12
> +#define ADC5_GEN3_VREF_BAT_THERM		0x15

You cannot have empty spaces in ID constants. These are abstract
numbers.

Otherwise please point me to driver using this constant.

Best regards,
Krzysztof


