Return-Path: <linux-iio+bounces-23354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F45B3B3FF
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5556E3ACD8E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690272638BA;
	Fri, 29 Aug 2025 07:13:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C625F973;
	Fri, 29 Aug 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451582; cv=none; b=M6pblzZwX25VEH2DF96NUN3Gy+4prUH45y7Yp+mVZmhX4dIEH6H1MO+jgB/PBNepFdE0kQjCEqHFbLrFM/MML36RITuVgiH1osrYWwuZ0o680/flOjTb884JZhyrCvzflgWkMMFvjVTs2gT2/MWokULAkhGVrRwe1ZlEA2XxKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451582; c=relaxed/simple;
	bh=USC1CL05TRQzKCK+7iAXv9X4SgjlaU1Xd5JXs27hD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0lJfvcQFV6mskB+781vB1/M311uwl9MZH+n+AYuMnV3rwtn2HgEaJpULeZDt/AzHc+opIVbOHpW/VtHgvdot8yD/Qn0mxmkie3qrBKTPncHCCUX1xOS8tqAqoPxgrbfCLLBNEXCLsOgzI78jPHVPMfTy0rVq2ni7Z/TCu0y6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096D7C4CEF4;
	Fri, 29 Aug 2025 07:13:01 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:12:59 +0200
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
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <20250829-demonic-soft-guppy-512c13@kuoka>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 02:06:52PM +0530, Jishnu Prakash wrote:
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
>  create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
>  rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (78%)
>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> 
> 
> base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf

What's the base commit?

git show 0f4c93f7eb861acab537dbe94441817a270537bf
fatal: bad object 0f4c93f7eb861acab537dbe94441817a270537bf


b4 diff fails here, so you are not making this process easier for us.

b4 diff '20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com'
Grabbing thread from lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/t.mbox.gz
Checking for older revisions
Grabbing search results from lore.kernel.org
  Added from v6: 6 patches
---
Analyzing 53 messages in the thread
Preparing fake-am for v6: dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
ERROR: Could not fake-am version v6
---
Could not create fake-am range for lower series v6

> 

