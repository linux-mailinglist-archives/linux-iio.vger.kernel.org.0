Return-Path: <linux-iio+bounces-11651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F619B6D7D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9F1C238E1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B41D1730;
	Wed, 30 Oct 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca+W3XUD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A61BD9D4;
	Wed, 30 Oct 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319630; cv=none; b=g3n5ujLuVf2geIVC9Vrk4VS1ArNPRd4WxT6+Ww02rVjOKUDLu/QaXhDcJ6ypL09AU0AToEVPB2OHpBhAlOk/Uam9spB6Ua4MfJfc8NF0L3aphvRPdpbvjXaSIYlwHPTmszPxiuZDANk0X+THB41ryxs29rSAjG1JHG5W8NA4MN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319630; c=relaxed/simple;
	bh=Fe0AGIhC3Q9D5yXjlxtSyBat7s/WsQfnTkImMDN2xO8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=icZRDFELTqaGfVivRi+eWn3OGJmGuhG4ipCAUx780h4mHHDDR3Ug68fB2YTSokhor3O0wNaIcvPEqybQwGKTMS9I7nfF/zLmz1JA7JrlavDFEoqykGd/midAvGzrS/dkyJGp3MnoUqeoiu7XdQhdESCNLF/o5OaaEGP7TgURqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca+W3XUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EDCC4CECE;
	Wed, 30 Oct 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730319629;
	bh=Fe0AGIhC3Q9D5yXjlxtSyBat7s/WsQfnTkImMDN2xO8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ca+W3XUDX6ixNlBx1mLT0Ay2zs+9nycgfAJLrwV+LLhEYCu4jsn00cZAWeZRmfNC9
	 HnNkXhboJryCzaJ/DrWYaLpYQtUN/S1D4v7eyF7VI/neG1UWCvONafxKImHQ2F0hA9
	 1hVwZkojCPpAs5lsbP0TA9Sf7NFqw9jqK+f5Hg3Oi1tQ/MfJCJBRsj8mpu/JqLbNAT
	 4lu05ILX2UHeQ8HSep7U8rN/MOn60G12jSM+RbNdH6Mkh0H7dnC58zt3HO+sxh5nIZ
	 0PUqCmXe9aXBKp7WBBnc8343say3VQJcgOFpvly9x6Q2jISSufzlCFR+wtrAqbZPvq
	 WIHMP6uQKcRYA==
Date: Wed, 30 Oct 2024 15:20:27 -0500
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
Cc: quic_skakitap@quicinc.com, daniel.lezcano@linaro.org, 
 andersson@kernel.org, lee@kernel.org, cros-qcom-dts-watchers@chromium.org, 
 linux-kernel@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org, 
 quic_subbaram@quicinc.com, rafael@kernel.org, quic_kamalw@quicinc.com, 
 agross@kernel.org, amitk@kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 quic_amelende@quicinc.com, neil.armstrong@linaro.org, conor+dt@kernel.org, 
 linux-iio@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 quic_collinsd@quicinc.com, konrad.dybcio@linaro.org, jic23@kernel.org, 
 devicetree@vger.kernel.org, lukasz.luba@arm.com, rui.zhang@intel.com, 
 sboyd@kernel.org
In-Reply-To: <20241030185854.4015348-2-quic_jprakash@quicinc.com>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-2-quic_jprakash@quicinc.com>
Message-Id: <173031962644.1844672.11198879616520852521.robh@kernel.org>
Subject: Re: [PATCH V4 1/4] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder


On Thu, 31 Oct 2024 00:28:51 +0530, Jishnu Prakash wrote:
> There are several files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since all of these
> are specifically for adc, move the files to the
> include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation
> errors seen with this move and update documentation files to fix
> dtbinding check errors for the same.
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
> Changes since v3:
> - Updated files affected by adc file path change in /arch/arm, which
>   were missed earlier. Updated some more new devicetree files requiring
>   this change in /arch/arm64.
> 
> Changes since v2:
> - Updated some more new devicetree files requiring this change.
> 
>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 8 ++++----
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
>  arch/arm/boot/dts/qcom/pm8226.dtsi                        | 2 +-
>  arch/arm/boot/dts/qcom/pm8941.dtsi                        | 2 +-
>  arch/arm/boot/dts/qcom/pma8084.dtsi                       | 2 +-
>  arch/arm/boot/dts/qcom/pmx55.dtsi                         | 2 +-
>  arch/arm64/boot/dts/qcom/pm4125.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi                       | 2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi                     | 2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi                      | 2 +-
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts        | 4 ++--
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts          | 4 ++--
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts                   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 4 ++--
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi               | 2 +-
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi              | 6 +++---
>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts         | 2 +-
>  arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts      | 6 +++---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                   | 8 ++++----
>  drivers/iio/adc/qcom-spmi-adc5.c                          | 2 +-
>  drivers/iio/adc/qcom-spmi-vadc.c                          | 2 +-
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h | 2 +-
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    | 2 +-
>  .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h    | 2 +-
>  include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h        | 0
>  49 files changed, 63 insertions(+), 63 deletions(-)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:80:
./scripts/dtc/include-prefixes/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h:13:10: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
   13 | #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241030185854.4015348-2-quic_jprakash@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


