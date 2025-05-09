Return-Path: <linux-iio+bounces-19386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF4AB178C
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F93BBEAE
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB6226165;
	Fri,  9 May 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAKdA479"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1422541B
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801352; cv=none; b=i1vRVJoA5erzb3C7gNLKbw7GaBl4KlZY31Abkzm4Xckry+J6kFtQ/4dFzEYzBe9I0fu7R0+a6EaOofQ2U90JRBDBpAqimueUgOij0dhDnWlKR9B8ImcPNJZpMKRNkDF9Xlg89SExmXN3vnnfxKrKIRnsw/5xjl0TLi8M+yoCH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801352; c=relaxed/simple;
	bh=aceWHAVBJfxRTj11YLdK2aK0D497kVDPFJNfXfja/7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TAWH4rLnSdlddSU/+0e1ZfxkPMk0RnAeJlc4ZP/M0erTZ6HaIPGhmpQVCc+Etwrqfn0jhqsorR894QU4MgVzjhb8Mnpybfes0e4CNbmryZVsbBJNrlP5xrA0OxKAyFsn7P9OC01HgEFeHjnIusb80AMzPVzQ3E51u88vJjjifIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RAKdA479; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so527319f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 09 May 2025 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746801347; x=1747406147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiIJegG0MiY9Mwil1ByXpZ97BLf/qEs17io1yqZRm3M=;
        b=RAKdA479KVcfHGo8qvQLirA5MwXCU+NBK+6huIB3yqhjd7P2flb90CTLSzLOE2TVW2
         CFYzVPno+6FWke7NqVSr1uwNB0ghTHV+JRq20SObK1mf1IiCyVD2QIr0ESPqImsoCTWf
         +qVtD6FgOy2qlrOHjkkXPoaF0Yty49UWwxXBrFICx4Bz0DIM39qkZ1WsiOTkw3k76cDo
         PhSbS0dxS8SLFfmcRdPfPeATF6ulfMNMWis/g8x2tiMW92aVoICU2RUkYfoGxkQP03nA
         wGD3apWBrkMa7PJBXxqC7sIhTqK/TGE0GBAi9Hw2JkRTOz8ty23tu4ReHXZdAjTEs/qS
         1hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746801347; x=1747406147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qiIJegG0MiY9Mwil1ByXpZ97BLf/qEs17io1yqZRm3M=;
        b=Ejg/gOHPJH+/iNNXU5X7woyrfSJPodJrykxFKw6K7yRq2vkvvXEswVR3+1yIQwVQ1d
         nxeOKxqelojc44RPZ3Y8B+cabylzJDf1ryQCNXUFFZH6EPhY1n1a3VEpwyZQPCchyGyM
         R1mrfj4L3lQv+nmdUTDSxR7g4fvCUo+wRBq/COgxnQI5eTd2JVTCcVzr0e86VAliAIUw
         c+XxZJS0/bkg4fVYId5H6JUfV7Tr0ObfFRhU9YegcSWH+k+sq3uZc21qN9PeVUSZA/Fd
         HRoAvApbKzHG1FT+tYaXW6WrSSUZy5LjBqbwezb2JGcDljFb5+/u9r1/45H7jMLuVJU1
         uHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6N6h9Xb4+5fTumaTJ5+hyvuEafQsGC+DeuMoRqcWWNRgtrXXb+FkAKEpQCsBcB0ZlIy6+gJMltXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUD5nIErALJVngSgLUJjMsxov3Jjf9nD4iG+9vW8FRVReE47d8
	4v2UwRlhICkhdKOqD5SbW96wE6vyW1e3ynBUSZKJH9WM5yYK3PzPALuqRzDiFBQ=
X-Gm-Gg: ASbGnctPwwwNUizC+ym9z0ZLyxCCJp/N/0bGQ9YLroxzKwDMTtiI9fwVqgW9tvbmUx7
	EEWPGJ1ODT1s6TbFa1yKHG9icd6n2NXFPEPWzfKkbtJYgl8jHst4waqlD97onIw69z8VcS5WJPe
	DJc8mF0dRYd31iEofGCqd/2KUU07BON9nMTkijcky7LIOgQen+rj/mjC1FCe+BaIA6C3fZmc0wN
	7p0Ll/r/3z4J9PPcd2KlLRJlnHi/aFQuF74XR044SA35XwmAetGa/J8R25OhmpMTdvzi8XN67t8
	K+Maaa7hwc+KeHOYYOQuOT166xFhWIyOcAGdAh03siDvLj9jFaKAF8pXSf109LzQwzjfSX9StRz
	+CceDN4X8miIhZvg=
X-Google-Smtp-Source: AGHT+IGms7B5elNBtCqBYNt4NfjvLePAFifL8WbwLZLXK+7kj5sY1Mu2X/iDoZ0/S5ygmLkcMYI3lw==
X-Received: by 2002:a05:6000:200d:b0:3a0:6f92:ef7c with SMTP id ffacd0b85a97d-3a1f64314c7mr3391869f8f.17.1746801347370;
        Fri, 09 May 2025 07:35:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d37fsm3464468f8f.68.2025.05.09.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:35:46 -0700 (PDT)
Message-ID: <8736dea0-2a5b-49d8-8445-239e5d11174e@linaro.org>
Date: Fri, 9 May 2025 16:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH V6 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_skakitap@quicinc.com,
 stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-4-jishnu.prakash@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250509110959.3384306-4-jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,
On 09/05/2025 13:09, Jishnu Prakash wrote:
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

The following is missing to allow it to be a qcom,spmi-pmic subnode:

=========================><================================================
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 11da55644262..b97f0e7b269e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -127,6 +127,7 @@ patternProperties:
    "^adc@[0-9a-f]+$":
      type: object
      oneOf:
+      - $ref: /schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
        - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
        - $ref: /schemas/iio/adc/qcom,spmi-rradc.yaml#
        - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
=========================><================================================

Thanks,
Neil

> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v5:
> - Added more details in binding description explaining how number
>    of SDAM peripherals used for ADC is allocated per SoC.
> - Renamed per-PMIC binding files listing ADC channel macro names
>    and addressed other reviewer comments.
> 
> Changes since v4:
> - Added ADC5 Gen3 documentation in a separate new file to avoid complicating
>    existing VADC documentation file further to accomodate this device, as
>    suggested by reviewer.
> 
> Changes since v3:
> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
>    instead of adding separate file and updated top-level constraints in documentation
>    file based on discussion with reviewers.
> - Dropped default SID definitions.
> - Addressed other reviewer comments.
> 
> Changes since v2:
> - Moved ADC5 Gen3 documentation into a separate new file.
> 
> Changes since v1:
> - Updated properties separately for all compatibles to clarify usage
>    of new properties and updates in usage of old properties for ADC5 Gen3.
> - Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
>    mentioning this convention.
> - Used predefined channel IDs in individual PMIC channel definitions
>    instead of numeric IDs.
> - Addressed other comments from reviewers.
> 
>   .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 155 ++++++++++++++++++
>   .../iio/adc/qcom,spmi-vadc-common.yaml        |   4 +-
>   .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
>   .../iio/adc/qcom,pm8550-adc5-gen3.h           |  46 ++++++
>   .../iio/adc/qcom,pm8550b-adc5-gen3.h          |  85 ++++++++++
>   .../iio/adc/qcom,pm8550vx-adc5-gen3.h         |  22 +++
>   .../iio/adc/qcom,pmk8550-adc5-gen3.h          |  52 ++++++
>   include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++++
>   8 files changed, 445 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>   create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
>   create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
>   create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
>   create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
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
> +    const: 1
> +
> +  interrupts:
> +    items:
> +      - description: SDAM0 end of conversion (EOC) interrupt
> +      - description: SDAM1 EOC interrupt
> +    minItems: 1
> +
> +patternProperties:
> +  "^channel@[0-9a-f]+$":
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
> +    description:
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      qcom,decimation:
> +        enum: [ 85, 340, 1360 ]
> +        default: 1360
> +
> +      qcom,hw-settle-time:
> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700,
> +                1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000 ]
> +        default: 15
> +
> +      qcom,avg-samples:
> +        enum: [ 1, 2, 4, 8, 16 ]
> +        default: 1
> +
> +      qcom,adc-tm:
> +        description:
> +          ADC_TM is a threshold monitoring feature in HW which can be enabled
> +          on any ADC channel, to trigger an IRQ for threshold violation. In
> +          earlier ADC generations, it was implemented in a separate device
> +          (documented in Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
> +          In Gen3, this feature can be enabled in the same ADC device for any
> +          channel and threshold monitoring and IRQ triggering are handled in FW
> +          (PBS) instead of another dedicated HW block.
> +          This property indicates ADC_TM monitoring is done on this channel.
> +        type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h>
> +    #include <dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h>
> +    #include <dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h>
> +    #include <dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h>
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
>       description:
>         ADC channel number.
>         See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> -      For PMIC7 ADC, the channel numbers are specified separately per PMIC
> -      in the PMIC-specific files in include/dt-bindings/iio/adc.
> +      For PMIC7 ADC and PMIC5 Gen3 ADC, the channel numbers are specified
> +      separately per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
>       maxItems: 1
>   
>     label:
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index b0ccad00c1a6..b77af38440fe 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -15,6 +15,8 @@ description: |
>     voltage. The VADC is a 15-bit sigma-delta ADC.
>     SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>     voltage. The VADC is a 16-bit sigma-delta ADC.
> +  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
> +  it can be considered like PMIC5 Gen2.
>   
>   properties:
>     compatible:
> diff --git a/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> new file mode 100644
> index 000000000000..9940715683b4
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
> +#define PM8550_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PM8550_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8550_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8550_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PM8550_ADC5_GEN3_AMUX_THM1(sid)			((sid) << 8 | ADC5_GEN3_AMUX1_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM2(sid)			((sid) << 8 | ADC5_GEN3_AMUX2_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM3(sid)			((sid) << 8 | ADC5_GEN3_AMUX3_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM4(sid)			((sid) << 8 | ADC5_GEN3_AMUX4_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM5(sid)			((sid) << 8 | ADC5_GEN3_AMUX5_THM)
> +#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
> +#define PM8550_ADC5_GEN3_AMUX1_GPIO3(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX2_GPIO4(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
> +
> +/* 100k pull-up */
> +#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
> +
> +/* 1/3 Divider */
> +#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
> +#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_DIV3)
> +
> +#define PM8550_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> new file mode 100644
> index 000000000000..1226597c02a7
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
> +#define PM8550B_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PM8550B_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8550B_ADC5_GEN3_VREF_VADC(sid)		((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8550B_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM)
> +#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM)
> +#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM)
> +#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM)
> +#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM)
> +#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
> +#define PM8550B_ADC5_GEN3_AMUX1_GPIO1(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
> +#define PM8550B_ADC5_GEN3_AMUX2_GPIO5(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
> +#define PM8550B_ADC5_GEN3_AMUX3_GPIO6(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
> +#define PM8550B_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
> +
> +#define PM8550B_ADC5_GEN3_CHG_TEMP(sid)			((sid) << 8 | ADC5_GEN3_CHG_TEMP)
> +#define PM8550B_ADC5_GEN3_USB_SNS_V_16(sid)		((sid) << 8 | ADC5_GEN3_USB_SNS_V_16)
> +#define PM8550B_ADC5_GEN3_VIN_DIV16_MUX(sid)		((sid) << 8 | ADC5_GEN3_VIN_DIV16_MUX)
> +#define PM8550B_ADC5_GEN3_VREF_BAT_THERM(sid)		((sid) << 8 | ADC5_GEN3_VREF_BAT_THERM)
> +#define PM8550B_ADC5_GEN3_IIN_FB(sid)			((sid) << 8 | ADC5_GEN3_IIN_FB)
> +#define PM8550B_ADC5_GEN3_TEMP_ALARM_LITE(sid)		((sid) << 8 | ADC5_GEN3_TEMP_ALARM_LITE)
> +#define PM8550B_ADC5_GEN3_SMB_IIN(sid)			((sid) << 8 | ADC5_GEN3_IIN_SMB)
> +#define PM8550B_ADC5_GEN3_SMB_ICHG(sid)			((sid) << 8 | ADC5_GEN3_ICHG_SMB)
> +#define PM8550B_ADC5_GEN3_ICHG_FB(sid)			((sid) << 8 | ADC5_GEN3_ICHG_FB)
> +
> +/* 30k pull-up */
> +#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_30K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_30K_PU)
> +
> +/* 100k pull-up */
> +#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
> +
> +/* 400k pull-up */
> +#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_400K_PU)
> +#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_400K_PU)
> +
> +/* 1/3 Divider */
> +#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_DIV3)
> +#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_DIV3)
> +#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
> +
> +#define PM8550B_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
> +#define PM8550B_ADC5_GEN3_VBAT_SNS_QBG(sid)		((sid) << 8 | ADC5_GEN3_VBAT_SNS_QBG)
> +#define PM8550B_ADC5_GEN3_VBAT_SNS_CHGR(sid)		((sid) << 8 | ADC5_GEN3_VBAT_SNS_CHGR)
> +#define PM8550B_ADC5_GEN3_VBAT_2S_MID_QBG(sid)		((sid) << 8 | ADC5_GEN3_VBAT_2S_MID_QBG)
> +#define PM8550B_ADC5_GEN3_VBAT_2S_MID_CHGR(sid)		((sid) << 8 | ADC5_GEN3_VBAT_2S_MID_CHGR)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> new file mode 100644
> index 000000000000..03a353440325
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
> +#define PM8550VS_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PM8550VS_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8550VS_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PM8550VE_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PM8550VE_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PM8550VE_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PM8550VE_ADC5_GEN3_DIE_TEMP(sid)		((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> new file mode 100644
> index 000000000000..88fed365cc9e
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
> +#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +/* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
> +#define PMK8550_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
> +#define PMK8550_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
> +#define PMK8550_ADC5_GEN3_VREF_VADC(sid)		((sid) << 8 | ADC5_GEN3_VREF_VADC)
> +#define PMK8550_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> +
> +#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM)
> +#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM)
> +#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM)
> +#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM)
> +#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM)
> +#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
> +#define PMK8550_ADC5_GEN3_AMUX1_GPIO6(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
> +
> +/* 30k pull-up */
> +#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
> +
> +/* 100k pull-up */
> +#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
> +
> +/* 400k pull-up */
> +#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
> +#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
> +
> +#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H */
> diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> index ef07ecd4d585..73efd8fda4b2 100644
> --- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> @@ -1,6 +1,8 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
> + *
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
> @@ -300,4 +302,83 @@
>   #define ADC7_SBUx				0x94
>   #define ADC7_VBAT_2S_MID			0x96
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
> +#define ADC5_GEN3_IIN_FB			0x17
> +#define ADC5_GEN3_TEMP_ALARM_LITE		0x18
> +#define ADC5_GEN3_IIN_SMB			0x19
> +#define ADC5_GEN3_ICHG_SMB			0x1b
> +#define ADC5_GEN3_ICHG_FB			0xa1
> +
> +/* 30k pull-up1 */
> +#define ADC5_GEN3_AMUX1_THM_30K_PU		0x24
> +#define ADC5_GEN3_AMUX2_THM_30K_PU		0x25
> +#define ADC5_GEN3_AMUX3_THM_30K_PU		0x26
> +#define ADC5_GEN3_AMUX4_THM_30K_PU		0x27
> +#define ADC5_GEN3_AMUX5_THM_30K_PU		0x28
> +#define ADC5_GEN3_AMUX6_THM_30K_PU		0x29
> +#define ADC5_GEN3_AMUX1_GPIO_30K_PU		0x2a
> +#define ADC5_GEN3_AMUX2_GPIO_30K_PU		0x2b
> +#define ADC5_GEN3_AMUX3_GPIO_30K_PU		0x2c
> +#define ADC5_GEN3_AMUX4_GPIO_30K_PU		0x2d
> +
> +/* 100k pull-up2 */
> +#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
> +#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
> +#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
> +#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
> +#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
> +#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
> +#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
> +#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
> +#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
> +#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
> +
> +/* 400k pull-up3 */
> +#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
> +#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
> +#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
> +#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
> +#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
> +#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
> +#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
> +#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
> +#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
> +#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
> +
> +/* 1/3 Divider */
> +#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
> +#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
> +#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
> +#define ADC5_GEN3_AMUX4_GPIO_DIV3		0x8d
> +
> +#define ADC5_GEN3_VPH_PWR			0x8e
> +#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
> +
> +#define ADC5_GEN3_VBAT_SNS_CHGR			0x94
> +#define ADC5_GEN3_VBAT_2S_MID_QBG		0x96
> +#define ADC5_GEN3_VBAT_2S_MID_CHGR		0x9d
> +
> +#define ADC5_GEN3_OFFSET_EXT2			0xf8
> +
>   #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */


