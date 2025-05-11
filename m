Return-Path: <linux-iio+bounces-19425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1CAB2827
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EA33A9E26
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B99229B13;
	Sun, 11 May 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsIWFiJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4F1DC9A3;
	Sun, 11 May 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746966083; cv=none; b=AusjnNd6pMMKO3bAJZcYmydWM9iiOwldrVgBZiBZJOnu3BD8yoSAVglANaYNLocvNFnQXXUCHb5HxdJNUqQEeooXPb0vLqUY6zvpEwwKY2/IXwpxyipgirqfy2TJ27dAeH0CjvdTzwZGQ3iksG2/slQ20hQMF9iUOoRKjp9/YAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746966083; c=relaxed/simple;
	bh=lJx6aFl8eT/aMf8qVUu6/nixz99eQvqqO/GkONxzHxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYq3bf8WnflOaxXVS15AJIGp4Cois+LXh0yBLbkAseaSKots3i1X85BVq5lgDR9w2vRKba+I30byhs2HsMCi3xxl9oYRYmbDNa9mZT2Jco2EbbpwUgBXwPswQ4AwJhscu/rLt/hJ0jm6+jd9JkxVF5VvzO45DGehUmWxVPCBwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsIWFiJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D971FC4CEE4;
	Sun, 11 May 2025 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746966081;
	bh=lJx6aFl8eT/aMf8qVUu6/nixz99eQvqqO/GkONxzHxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsIWFiJqd1z0iSlC8kQvyTcujU+yozmOnrGg2zHd1us6Ez+wcrmwOAooxQRndD800
	 E9XT2CBDjpF8Tad4gdsrf1QRkNoN1p9SEdM7iOSX98zNtL7goqBGTAB2XMxXv9XW73
	 iRuOTb+cVPeyqwFfvJVdkLpkWsNXdl/1TRhWdzCAlnr9MFUzgMp2UiXgOmZCB+qDv4
	 lhcYBoinY8FOHAiYVJof+/ZyDB3fg+h6DxZI7foXWAHdzWnnD2GDSBKqmGkrcPmfPi
	 LCW6E155Ji6lFDu3UeoJMSJ4Sqf3h/TU5/q3antOTxJy+R9/83UuvkZDcdTfWFFgrt
	 Op4S+8Rk1PK5w==
Date: Sun, 11 May 2025 13:21:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V6 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Message-ID: <20250511132107.0dc2db8b@jic23-huawei>
In-Reply-To: <20250509110959.3384306-2-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-2-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:39:55 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> There are several files containing QCOM ADC macros for channel names right now
> in the include/dt-bindings/iio folder. Since all of these are specifically for
> adc, move the files to the include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation errors
> seen with this move and update documentation files to fix dtbinding check errors
> for the same.
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi. 

So this seems like it's going to be messy to apply except via the appropriate
QC tree. So I'll assume it goes that way (unlike the driver changes)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since v5:
> - Updated one more devicetree file requiring this change.
>   Ran full dt_binding_check and dtbs_check and verified that no
>   errors were reported related to this patch.
> 
>   Mentioning this explicitly as there was an invalid error reported on
>   this patch in the last two patch series, from upstream kernel
>   automation:
> 
>   fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
> 
>   The error is invalid as this file does get added in this patch, in
>   previous patch series too.
> 
>   Links to discussion for same in v5:
>   https://lore.kernel.org/all/cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com/
>   https://lore.kernel.org/all/9f24e85d-f762-4c29-a58f-ed7652f50919@oss.qualcomm.com/
> 
>   Links to discussion for same in v4:
>   https://lore.kernel.org/all/16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com/
> 
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
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts              | 4 ++--
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
>  53 files changed, 68 insertions(+), 68 deletions(-)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index c28db0d635a0..a4f72c0c1ec6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -70,9 +70,9 @@ patternProperties:
>          maxItems: 1
>          description: |
>            ADC channel number.
> -          See include/dt-bindings/iio/qcom,spmi-vadc.h
> +          See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
>            For PMIC7 ADC, the channel numbers are specified separately per PMIC
> -          in the PMIC-specific files in include/dt-bindings/iio/.
> +          in the PMIC-specific files in include/dt-bindings/iio/adc.
>  
>        label:
>          description: |
> @@ -276,8 +276,8 @@ examples:
>      };
>  
>    - |
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      pmic {
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 078a6886f8b1..11da55644262 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -276,7 +276,7 @@ examples:
>      #include <dt-bindings/input/input.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>      #include <dt-bindings/spmi/spmi.h>
>  
>      pmic@0 {
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
> index bfad8130a042..65b8c8cf802f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
> @@ -110,7 +110,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      pmic {
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 4470a5942fb2..5d19a82b0319 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -163,7 +163,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      pmic {
> @@ -204,8 +204,8 @@ examples:
>      };
>  
>    - |
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      pmic {
> diff --git a/arch/arm/boot/dts/qcom/pm8226.dtsi b/arch/arm/boot/dts/qcom/pm8226.dtsi
> index 2fd4f135ed84..774120aa50bc 100644
> --- a/arch/arm/boot/dts/qcom/pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom/pm8226.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: BSD-3-Clause
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm/boot/dts/qcom/pm8941.dtsi b/arch/arm/boot/dts/qcom/pm8941.dtsi
> index aca0052a02b7..d995cc6eaebf 100644
> --- a/arch/arm/boot/dts/qcom/pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom/pm8941.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
> index 309f5256754b..f8790bbc225e 100644
> --- a/arch/arm/boot/dts/qcom/pma8084.dtsi
> +++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm/boot/dts/qcom/pmx55.dtsi b/arch/arm/boot/dts/qcom/pmx55.dtsi
> index da0851173c69..af05ec5a009c 100644
> --- a/arch/arm/boot/dts/qcom/pmx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/pmx55.dtsi
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2020, Linaro Limited
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
> index cf8c822e80ce..db175a55035c 100644
> --- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2023, Linaro Ltd
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> index d0db28336fa9..2bc669e8763b 100644
> --- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> index 59524609fb1e..24fbfee8de79 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> index 334f976f1154..5c0ae7a06bd0 100644
> --- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> index 156b2ddff0dc..0ae38647ec49 100644
> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2020, Konrad Dybcio
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> index 3f8b9eafe164..585d206b02be 100644
> --- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2020, Konrad Dybcio
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> index 0761e6b5fd8d..6ad46722ae38 100644
> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> index d2568686a098..caf952e19d60 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
> @@ -7,7 +7,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  / {
>  	thermal-zones {
> diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> index 3f7b0b6a1d10..5192ab94e75e 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2019, Linaro Limited
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> index 3911d6d0d2e2..7822214f07b0 100644
> --- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2019, Linaro Limited
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> index f8e4829ff7f7..3a709095cda7 100644
> --- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> index 77809c3534a7..e54a92839c71 100644
> --- a/arch/arm64/boot/dts/qcom/pm8937.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> index ed72c6101813..c1462d659ff2 100644
> --- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> index 64258505f9ba..9427062b8af5 100644
> --- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
> index 353e4a6bd088..26cbcfd06d05 100644
> --- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 3ecb330590e5..b948b98835a9 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /* Copyright 2018 Google LLC. */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
> index 8c899d148e46..eff176851b83 100644
> --- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> index 3d3b1cd97cc3..9bd5b895cd58 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> index 5084de66fc46..3dd3adfa096b 100644
> --- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
> @@ -6,7 +6,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  / {
>  	thermal-zones {
> diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> index 0d0a846ac8d9..9f3e4121d834 100644
> --- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  &spmi_bus {
>  	pmic@0 {
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 3f9100c7eff4..86c17094a92a 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -5,7 +5,7 @@
>  
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/input/linux-event-codes.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 0f1c83822f66..33c3f2577161 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -9,8 +9,8 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> index 712f29fbe85e..fb0c483d7850 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> @@ -9,8 +9,8 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 5fbcd48f2e2d..2bb279ab55d4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -9,8 +9,8 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index b5fe7356be48..1dd4aa300f7f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -7,7 +7,7 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
>  #include "sc7280-idp.dtsi"
>  #include "pmr735a.dtsi"
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 7370aa0dbf0e..00d68a9588d3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include "sc7280.dtsi"
>  #include "pm7325.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index 7d1d5bbbbbd9..8fcd3e1bb815 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -11,8 +11,8 @@
>   * Copyright 2022 Google LLC.
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> index 451c9b984f1f..ed1fcfdc3584 100644
> --- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
> @@ -7,7 +7,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  / {
>  	thermal-zones {
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> index 1667c7157057..22fb116330a2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
> @@ -11,7 +11,7 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index d36fc1ebe50e..7f6bfb3a561c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -6,7 +6,7 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
> index 812251324002..2c1dbb30814d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
> @@ -8,7 +8,7 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/gpio-keys.h>
>  #include <dt-bindings/input/input.h>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index 307df1d3dcd2..f7633730eaa2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -3,9 +3,9 @@
>   * Copyright (c) 2022, Linaro Limited
>   */
>  
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 52b16a4fdc43..dcf51d57d9c4 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -14,7 +14,7 @@
>  
>  #include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> diff --git a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
> index 85a928f98077..9c38bdd8f18e 100644
> --- a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
> @@ -8,9 +8,9 @@
>  
>  #include <dt-bindings/arm/qcom,ids.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 2ff40a120aad..cadf4e2f534e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -6,10 +6,10 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
>  #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include "sm8450.dtsi"
>  #include "pm8350.dtsi"
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index af3c2f659f5e..389454edbf75 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -20,7 +20,7 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  #define ADC5_USR_REVISION1			0x0
>  #define ADC5_USR_STATUS1			0x8
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 00a7f0982025..e4878770f88c 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -20,7 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/log2.h>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* VADC register and bit definitions */
>  #define VADC_REVISION2				0x1
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
> similarity index 98%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
> index 96908014e09e..f0ab57078ca4 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
> @@ -10,7 +10,7 @@
>  #define PM7325_SID					1
>  #endif
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PM7325_ADC for PMIC7 */
>  #define PM7325_ADC7_REF_GND			(PM7325_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
> similarity index 98%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
> index 5d98f7d48a1e..ef818248ec8c 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
> @@ -6,7 +6,7 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PM8350_ADC for PMIC7 */
>  #define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
> similarity index 99%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
> index 57c7977666d3..d841bf00b7b0 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
> @@ -10,7 +10,7 @@
>  #define PM8350B_SID					3
>  #endif
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PM8350B_ADC for PMIC7 */
>  #define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
> similarity index 97%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
> index 3d1a41a22cef..161b211ec126 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
> @@ -10,7 +10,7 @@
>  #define PMK8350_SID					0
>  #endif
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PMK8350_ADC for PMIC7 */
>  #define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
> similarity index 95%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
> index c5adfa82b20d..fedc9e3882b8 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
> @@ -10,7 +10,7 @@
>  #define PMR735A_SID					4
>  #endif
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PMR735A_ADC for PMIC7 */
>  #define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
> similarity index 95%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
> index fdb8dd9ae541..812f33872e5e 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
> @@ -10,7 +10,7 @@
>  #define PMR735B_SID					5
>  #endif
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* ADC channels for PMR735B_ADC for PMIC7 */
>  #define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> similarity index 93%
> rename from include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> index c0680d1285cf..750a526af2c1 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
> +++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
> @@ -6,7 +6,7 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
>  #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
> diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
> similarity index 100%
> rename from include/dt-bindings/iio/qcom,spmi-vadc.h
> rename to include/dt-bindings/iio/adc/qcom,spmi-vadc.h


