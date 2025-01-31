Return-Path: <linux-iio+bounces-14775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08CEA24377
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A99D1887E46
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614351F2C59;
	Fri, 31 Jan 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2hCWztk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094651F2C22;
	Fri, 31 Jan 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352520; cv=none; b=o1OJej17Iz1XUizBCNzAe0Q0TIvGzgjFL0RIzX1znVzNQfldEjELVfiElkb6NZK0LCMEbDbcdZLHnzmNtXulp2b9MharPQmZN+KhUTqw3qkSsRDg2wYzeQIjA1+Q3WbSuznPLxDnSBkJBdypX0DuGOuBTT6GwhMUnUO3IHY+OH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352520; c=relaxed/simple;
	bh=1xU/Je09gCwCuPzB0Q1Mj+G9AQti/vFGzb82p88OmVs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Sg9NIY6bIekZSkcM0eOoULbMZasTpOpZL+XG+VmcZn8OqU4xhTZZm2krAkXRH4zaIJbFMOXqDkN/lTjQeH4k3+nIBC8YT1ljxVyG+gfCDw2L0yIF+aOK7S+HnXqORURVc5Sbb2lFpiH1jXfIoEBs2frqXk/VLVJbFc9hCQI37Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2hCWztk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D837C4CEDF;
	Fri, 31 Jan 2025 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738352519;
	bh=1xU/Je09gCwCuPzB0Q1Mj+G9AQti/vFGzb82p88OmVs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=l2hCWztkzTUo1PSkezz6W8LPyv2kjgso2CHrb0j/EVht9In4VMrHrvsOmn1VWS23Y
	 NxZLxcPByzvG39pSQL6A62V6y8GnKMGvIU8RPrgXzRv+CKNYb2xiHZGgJ5HhpvPMqa
	 y+I3leTPlDOwBy8LekQhDeGGOlDREzi96PnX1tlyEhIS9u6HiJWvDkjo04c3H5tTp5
	 9Yt7K4hRUx53ID8tjffqjMkG3UUFQmzqgCaSQV6yCVS0QkHe8KZn0A2tmeN7eI/ikA
	 P4cqqVgF6ikwzEcLaL48prqNNL0yc6XK7RWwP93s6aPUSWdtE9mY7yFxHOeiYDnUov
	 Ps88USTzo49gA==
Date: Fri, 31 Jan 2025 13:41:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, quic_kamalw@quicinc.com, daniel.lezcano@linaro.org, 
 quic_skakitap@quicinc.com, rafael@kernel.org, lars@metafoo.de, 
 cros-qcom-dts-watchers@chromium.org, anjelique.melendez@oss.qualcomm.com, 
 jic23@kernel.org, agross@kernel.org, dmitry.baryshkov@linaro.org, 
 lee@kernel.org, konradybcio@kernel.org, amitk@kernel.org, 
 linux-iio@vger.kernel.org, neil.armstrong@linaro.org, sboyd@kernel.org, 
 andersson@kernel.org, david.collins@oss.qualcomm.com, 
 thara.gopinath@gmail.com, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, rui.zhang@intel.com, 
 linux-arm-msm@vger.kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, lukasz.luba@arm.com, conor+dt@kernel.org
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
 <20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com>
Message-Id: <173835251464.3936394.5738804093745596757.robh@kernel.org>
Subject: Re: [PATCH V5 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder


On Sat, 01 Feb 2025 00:02:38 +0530, Jishnu Prakash wrote:
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
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v4:
> - Updated some more devicetree files requiring this change.
> 
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
>  arch/arm64/boot/dts/qcom/pm8937.dtsi                      | 2 +-
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
>  arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      | 2 +-
>  .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 2 +-
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
>  52 files changed, 66 insertions(+), 66 deletions(-)
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
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250131183242.3653595-2-jishnu.prakash@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


