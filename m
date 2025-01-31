Return-Path: <linux-iio+bounces-14777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33241A2437F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21AB188778E
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBB1F3FEE;
	Fri, 31 Jan 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDLks/1s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4881F3FD9;
	Fri, 31 Jan 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352523; cv=none; b=GHkCEQACn7+CoMHfCy0RPdMEAn25FmO7YAB+3mu5b+1gLLNemICJagPnapNRIUW5mRej2TdIieMY7K0AH4syUMJssJdei5889SF7/8TcqKdSjqF+qmU6p42xTWH4Blx4H/G6kPG00x6IuBPupeSQYJknxseDFgg0EwH74eCflpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352523; c=relaxed/simple;
	bh=rzk8vrtBxsOfx7ZO1hhNFoa+WYNN7QPqD8TRe0Mfta8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VtTu2LeZamPK7jjJLonmg+qOJPwQPfWUr1c8Gr3WBP8dCeKVbsBTWSjCmTMDSe9oHFpzoOx9g+IMG1IXqP6/9dYNwoCRxoa5dUairpRnsClSWeulf6o3CHAhBTXkRMCnwk3+Q7UYdCfBJcH81bSkzg6qTYT/zb2xXHXBNIvdQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDLks/1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3570CC4CED1;
	Fri, 31 Jan 2025 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738352522;
	bh=rzk8vrtBxsOfx7ZO1hhNFoa+WYNN7QPqD8TRe0Mfta8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bDLks/1srt/Fjj1x+n4PVdvCLkdptjU8hW62ciVNJOGm5BgzHwS0LLAy6CGYN31Zy
	 DeEVqgjUveU7PgiTlbU2pe67BvSNr9SuK1uvY1ROGibd27gQsK0o2quQDkKaoYFWf1
	 nyqGxU1ihHM7XqZHLJB7k/j711g6tqNTIXoCbg824rW0Li5A20zJ0Z3TARBQQO/g8i
	 E+WoNX9n+JGB+x/eiKuWLoclD1lz6+90gfP7KJITyiDyj2ASsTmaxUkRo7nEsqeq17
	 yKMbtyQmKix6f4sdTP0vagMNH63dKZgzyX9BnoGHdliE4ODoHjG2VN3jrY7UYbJEWy
	 ctpY+zxHcPOIw==
Date: Fri, 31 Jan 2025 13:42:01 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lars@metafoo.de, subbaraman.narayanamurthy@oss.qualcomm.com, 
 thara.gopinath@gmail.com, linux-pm@vger.kernel.org, krzk+dt@kernel.org, 
 anjelique.melendez@oss.qualcomm.com, rafael@kernel.org, 
 daniel.lezcano@linaro.org, conor+dt@kernel.org, sboyd@kernel.org, 
 konradybcio@kernel.org, lukasz.luba@arm.com, lee@kernel.org, 
 amitk@kernel.org, jic23@kernel.org, david.collins@oss.qualcomm.com, 
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
 quic_skakitap@quicinc.com, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, andersson@kernel.org, linux-iio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 quic_kamalw@quicinc.com, agross@kernel.org, rui.zhang@intel.com
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com>
Message-Id: <173835251665.3936506.9049448203737374721.robh@kernel.org>
Subject: Re: [PATCH V5 3/5] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC


On Sat, 01 Feb 2025 00:02:40 +0530, Jishnu Prakash wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250131183242.3653595-4-jishnu.prakash@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


