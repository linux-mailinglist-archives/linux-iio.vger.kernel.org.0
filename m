Return-Path: <linux-iio+bounces-26720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C7CA2B28
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 08:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 882913059AC9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382DB30BF5C;
	Thu,  4 Dec 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQUAni4/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8627FD75;
	Thu,  4 Dec 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834855; cv=none; b=q4nfAUKQKrx1e5IfxjszsJsqSzCRUbhImHrRFO1cNi9j+TWUfP9zEyrg/Y06XhwbiGznbG6LtyPniX6byRXOwVlNmxlmElhl4dREFJbQhfozHTllaVHtdlCG+pEw1ONwNctK8Wr2oo9PS/SOLaZP00ecyhE+96hMfr3Zw798RuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834855; c=relaxed/simple;
	bh=1Ib33Her8OuTDOdAAgFO5hGU9wgziL8tIdQe50lbKrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvJZmKOKldJAAV21TVIX1MPswrvOpX5BtE/1bE9DP/yUOVzUtj4RrxjdX3m70SWZH0Xs+CQbdyTT5bDywA3YkcXcqHhVozbCoMdZFSsiTBDXwBbMvyqPJg+I0k/j3lFkzaDqFUyxQOStwwphGqlpy1ugoojY7lXdjY2BTRYMbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQUAni4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36C1C4CEFB;
	Thu,  4 Dec 2025 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764834854;
	bh=1Ib33Her8OuTDOdAAgFO5hGU9wgziL8tIdQe50lbKrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQUAni4/k/cqI8PgkKYNjiG3JRMdxqVeUHQcbNWHP2v1s5SNBVXaYvhc9KtkN1ouU
	 IBkEkyR+RPhVx0XYAC2WNoHEKeQf69e1g4r96Xc714M+ZNW1BvDB+FCkVIP91RPwnI
	 potgy5EuZmem/YSvYMg0uRaN3+xWUNnRgq8pPK5Qx76MKiFf7mgjRe2lFRCpcs1JVc
	 eVmtvBCDiXB8IxNhgNdLIUPnUsmMehQVswGDACV1Dq06GSEoqoKi5jGt01muzTWbh3
	 ou3F+1edIwifSpZcJrNfUyqmJRK4Y7Zl8tBgudpqNd4IHd0ZAMEd2LDgVf4UvDBHnU
	 UuECRoxXZjbVg==
Date: Thu, 4 Dec 2025 08:54:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org, 
	daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	lee@kernel.org, rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com, 
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com, 
	kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, 
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V8] dt-bindings: iio/adc: Move QCOM ADC channel
 definitions out of bindings folder
Message-ID: <20251204-calculating-sloth-of-valor-0e30ac@quoll>
References: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>

On Thu, Nov 27, 2025 at 07:09:03PM +0530, Jishnu Prakash wrote:
> There are several header files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since these are hardware
> constants mostly used in devicetree and not exactly bindings, move the
> files to the arch/arm(64)/boot/dts/qcom folders.
> 
> Correct the header file paths in all affected devicetree files to fix
> compilation errors seen with this move. Update documentation files
> similarly to fix dtbinding check errors for the same. Make a copy
> of the header file with constants used in ADC driver files in the
> /include/linux/iio/adc folder and update driver files to use this
> path to include it.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
> Changes since v7:
> - Based on a discussion with Krzysztof concluded here: 
>   https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
>   moved ADC macro header files to arch/arm(64)/boot/dts/qcom folders. The file
>   include/dt-bindings/iio/qcom,spmi-vadc.h is moved to arch/arm/boot/dts/qcom/
>   as it is used in both arm and arm64 SoCs and other per-PMIC adc7 header files
>   are moved to arch/arm64/boot/dts/qcom.
> - Updated affected devicetree and documentation files based on path changes above.
> - Made a copy of qcom,spmi-vadc.h in /include/linux/iio/adc folder
>   for inclusion in ADC driver files and updated affected driver files to use it.
> - Dropped Acked-by tags from Lee, Rob and Jonathan due to these significant changes
>   made in latest patch version.
> - Updated some more devicetree files affected by this change.
> - Pushing this as a standalone change separate from ADC5 Gen3 series, as that
>   series will no longer depend upon this patch for the location of
>   qcom,spmi-vadc.h, as ADC5 Gen3 macros will be added in separate new files.
> - Link to v7: https://lore.kernel.org/all/20250826083657.4005727-2-jishnu.prakash@oss.qualcomm.com/
> 
> Changes since v6:
> - Collected Acked-by tag from Jonathan.
> 
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
> - Collected Acked-by tags from Rob and Lee.
> 
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   4 +-
>  .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-

You have a checkpatch warning for a reason. You should not make these
combined into one change.

>  arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
>  arch/arm/boot/dts/qcom/pm8941.dtsi            |   3 +-
>  arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
>  arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
>  .../arm/boot/dts/qcom}/qcom,spmi-vadc.h       |   0
>  arch/arm64/boot/dts/qcom/pm4125.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6125.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6150.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
>  arch/arm64/boot/dts/qcom/pm660l.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8937.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8953.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8994.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pmi632.dtsi          |   2 +-
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |   2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         |   2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi          |   2 +-
>  .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |   4 +-
>  .../dts/qcom/qcm6490-particle-tachyon.dts     |   4 +-
>  .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm7325.h    |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350.h    |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h   |   2 +-
>  .../boot/dts/qcom}/qcom,spmi-adc7-smb139x.h   |   2 +-
>  .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   4 +-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |   4 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   4 +-
>  arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |   2 +-
>  .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |   2 +-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   2 +-
>  .../dts/qcom/sc8280xp-microsoft-blackrock.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |   6 +-
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
>  .../boot/dts/qcom/sm7325-nothing-spacewar.dts |   6 +-
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   9 +-
>  drivers/iio/adc/qcom-spmi-adc5.c              |   3 +-
>  drivers/iio/adc/qcom-spmi-vadc.c              |   3 +-
>  include/linux/iio/adc/qcom,spmi-vadc.h        | 303 ++++++++++++++++++
>  56 files changed, 374 insertions(+), 73 deletions(-)
>  rename {include/dt-bindings/iio => arch/arm/boot/dts/qcom}/qcom,spmi-vadc.h (100%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm7325.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h (98%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h (96%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h (96%)
>  rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-smb139x.h (93%)

Huh, what? How can you drop the header? Are you sure you checked
previous commits, e.g. pinctrl headers, how this should be done? Where
did you see such commit dropping the ABI?

>  create mode 100644 include/linux/iio/adc/qcom,spmi-vadc.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index b9dc04b0d307..0860243819f6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -276,8 +276,8 @@ examples:
>      };
>  
>    - |
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> -    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
> +    #include <arm64/qcom/qcom,spmi-adc7-pmk8350.h>
> +    #include <arm64/qcom/qcom,spmi-adc7-pm8350.h>

I would not touch these and I also wonder whether this actually works.

...

> index 000000000000..c69b4fea65b0
> --- /dev/null
> +++ b/include/linux/iio/adc/qcom,spmi-vadc.h

Why Linux header is part of this patchset? This is completely irrelevant
to DTS. You mixed here two or three subsystems. :/


Best regards,
Krzysztof


