Return-Path: <linux-iio+bounces-14776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4AA2437A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157B21887EEA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD71F3D38;
	Fri, 31 Jan 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q23EfnKS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220291F37D2;
	Fri, 31 Jan 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352521; cv=none; b=L3+bbzMpS/+ODmBicRlYO44yh9OYgkClR7k21fCBgu9w8lLwkD7lGpyP+ZybRP3+g7xR6USUPNNO2+Ph1MjbaEb2TUwxODufJI3weJ+VJP5qaANUlZcfKRbW23tOWbRj8IIknY1LEThnpzk6Gc223hmiAHa0XrFVwbIE3ZMoiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352521; c=relaxed/simple;
	bh=U40K1H2zKRQjgt07Uis7pNfCl0meSZyRnzDBQMu7134=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XGLbdD6NgZDeGZZrtiTlvUpxG718FLoKQWAaGgI8S350RaQmcxakYiFdLPQsI3U/mt3xpmYuljnD6YkkNOPfpmuyKQfzjq2IxdlPfLp83xDSPN4F/sF6Yvfn9ZgxLDu2Dr+8WHjHb6vVFPVSY+tRS5oCoUa3bPP6jmc/oEHGEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q23EfnKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AFCC4AF09;
	Fri, 31 Jan 2025 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738352520;
	bh=U40K1H2zKRQjgt07Uis7pNfCl0meSZyRnzDBQMu7134=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Q23EfnKSbdZuE5d+ULVEWex+vfy1ngq7nJVLObCd/g5yiJS5O2LE2uKDwfagvDI22
	 89EZjKVCleaJBXuLwjbqmgvycfMPJpRvhDkCf0aDBOkYO3p+OmSu3k/TQ2IJsuDP4r
	 LHdl+F64p060ltNKe+MT8An8syPLua5rfKoL3Mjhpddy03Ewo0EA0Q5A/WJ7hJ72RJ
	 r7vtOpJSCuuf0YNODasIQQf4DICw6tRjg7z70L+ekkY+Xk0zl1vYmJ+HD0H0Po8O2W
	 QaS33K2o46jUkLo6nadseQFEb+OTu4f4v1PQChddHWv8sAdlvmVXMhI9AdY22I+Ezs
	 9rqmgQUWPkSiQ==
Date: Fri, 31 Jan 2025 13:41:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: rui.zhang@intel.com, lee@kernel.org, agross@kernel.org, 
 konradybcio@kernel.org, cros-qcom-dts-watchers@chromium.org, 
 conor+dt@kernel.org, anjelique.melendez@oss.qualcomm.com, 
 david.collins@oss.qualcomm.com, quic_kamalw@quicinc.com, 
 lukasz.luba@arm.com, devicetree@vger.kernel.org, neil.armstrong@linaro.org, 
 lars@metafoo.de, linux-iio@vger.kernel.org, amitk@kernel.org, 
 linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org, jic23@kernel.org, 
 sboyd@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 rafael@kernel.org, linux-pm@vger.kernel.org, thara.gopinath@gmail.com, 
 andersson@kernel.org, quic_skakitap@quicinc.com, 
 dmitry.baryshkov@linaro.org, subbaraman.narayanamurthy@oss.qualcomm.com
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com>
Message-Id: <173835251554.3936459.14441041624354472103.robh@kernel.org>
Subject: Re: [PATCH V5 2/5] dt-bindings: iio: adc: Split out QCOM VADC
 channel properties


On Sat, 01 Feb 2025 00:02:39 +0530, Jishnu Prakash wrote:
> Split out the common channel properties for QCOM VADC devices into a
> separate file so that it can be included as a reference for devices
> using them. This will be needed for the upcoming ADC5 Gen3 binding
> support patch, as ADC5 Gen3 also uses all of these common properties.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  .../iio/adc/qcom,spmi-vadc-common.yaml        | 87 +++++++++++++++++++
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 75 +---------------
>  2 files changed, 89 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dts:88:18: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
   88 |         #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250131183242.3653595-3-jishnu.prakash@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


