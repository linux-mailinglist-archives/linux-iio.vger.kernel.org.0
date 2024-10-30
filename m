Return-Path: <linux-iio+bounces-11652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF609B6D82
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD051C23A30
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4191E7C3A;
	Wed, 30 Oct 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBJuiYp0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18141DF759;
	Wed, 30 Oct 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319632; cv=none; b=J8zYx2kUE2LyPfRW7hemBp9zaf0HPCBZ7fWlb+qhljHm6TzyBm7Z1AjNgXvxrF63GmOevymS3GroWoOjHim63BGTqNm7h8V+o24in6v8ZkOIJkQffvQ4/tx1UbJihQggng2oWSkurmfwPtM0hesRGyyWQnqoPee25QWRq0t/u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319632; c=relaxed/simple;
	bh=8ElXhHDMPlB4YMcwTevnyyvaRx/P6HvO3oQkTIL7QeE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=En3VtRZI+70ExDjUgz1cu015QW+kRfF88YRQ0wvf3/ZBO9C3sEInQqJq1qgFIjXCQZQ4XS3ww8r4wIyhTd5ea6q28ET/RsD0i5LZ4AaDMc7SFSi6UpMn4RDP+n2rZbdMFUZ96n5ZGOvw4XbAVnZtXvCZUzYj2Cey1W+LmBU+n08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBJuiYp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B9C4CECE;
	Wed, 30 Oct 2024 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319631;
	bh=8ElXhHDMPlB4YMcwTevnyyvaRx/P6HvO3oQkTIL7QeE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IBJuiYp0WV8KJZ7FZGxLlAWnJ28gyG+A2eRnHAbKx3fWWezYhafCMlMobfjg86Q2t
	 Gb12JoLPYRGPX/DgQyhix+vPtbTkugViUPTcJ7YhUTqTWMmUs0gB4fRgMl7mMpzlun
	 vIsEYZq6BdWQ25Y7Sjp+cmQC9SuugkquK8kkTfWsvnDoAjCqaQcPI8TCLD2GZJTChE
	 sA7SUdT09KBHziR21080sRfuMSlkxjAXiyGUYCWAFs9kSoDjAxiYhA4oHCCcMKOzdy
	 jjH1Jbbm6n1U7lbIAe7OKP70N72a+BZrO4eqX06OsseJKClMQZquU2+Yfv5EWRdzGL
	 3y6l6G0BGmnew==
Date: Wed, 30 Oct 2024 15:20:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, quic_amelende@quicinc.com, 
 konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
 quic_subbaram@quicinc.com, dmitry.baryshkov@linaro.org, agross@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, quic_kamalw@quicinc.com, 
 conor+dt@kernel.org, quic_collinsd@quicinc.com, andersson@kernel.org, 
 devicetree@vger.kernel.org, rui.zhang@intel.com, lars@metafoo.de, 
 jic23@kernel.org, amitk@kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
 neil.armstrong@linaro.org, linux-pm@vger.kernel.org, 
 quic_skakitap@quicinc.com, sboyd@kernel.org, lee@kernel.org, 
 lukasz.luba@arm.com, robh+dt@kernel.org
In-Reply-To: <20241030185854.4015348-3-quic_jprakash@quicinc.com>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
Message-Id: <173031962774.1845163.4517987585866209271.robh@kernel.org>
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC


On Thu, 31 Oct 2024 00:28:52 +0530, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on an SDAM (Shared
> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> channels and virtual channels (combination of ADC channel number and
> PMIC SID number) per PMIC, to be used by clients of this device.
> 
> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
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
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 220 ++++++++++++++++--
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  46 ++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  85 +++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 ++
>  .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  52 +++++
>  include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++
>  6 files changed, 486 insertions(+), 20 deletions(-)
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dts:88:18: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
   88 |         #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241030185854.4015348-3-quic_jprakash@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


