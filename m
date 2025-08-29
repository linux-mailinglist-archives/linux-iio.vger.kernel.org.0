Return-Path: <linux-iio+bounces-23353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDFB3B3F9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91379189D908
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D5262FD9;
	Fri, 29 Aug 2025 07:11:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AD22F14C;
	Fri, 29 Aug 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451470; cv=none; b=nhQP+cUnYuhl6tT5jNIBnPm3U4J63tJAdsVw9Mt/GcppFOkzSmDcmnEH3FEq3iCVe2eJj/PU+vZ/8r/Z0kqWgmeA449/J+ZbjT+2pWpCPCIJ0kIqxGS2DR0n6ax1nRi00HZLsHwlOP1/7yKrNhGqbJ9HUpFtNbTWzt7wvfou7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451470; c=relaxed/simple;
	bh=RacbaW6HROrZlrLpRE7PsOFx1DubGHgeEsxYtz3nnBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2H1QvfikHmoiu+ClDtNvlY+z5I26e9mY6cuHsL8jviRHfr8ndpR8IayUAlNLrxy1Jf7oQm4pmv35amG2E+luUy4XyCPKy00KIxTxKxXeLW7bBeD4BSnEDK0Egmf+S7+016X/6DHJ5Eymz5O23g4Lu37ejz/v01snUONnCbrApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981BC4CEF0;
	Fri, 29 Aug 2025 07:11:09 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:11:07 +0200
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
Message-ID: <20250829-imaginary-dove-of-music-afdb36@kuoka>
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
> PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. The major difference is
> that the register interface used here is that of an SDAM present on
> PMK8550, rather than a dedicated ADC peripheral. There may be more than one
> SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
> be used for either immediate reads (same functionality as previous PMIC5 and
> PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
> Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
> combined into the same driver.
> 
> Patch 1 is a cleanup, to move the QCOM ADC dt-bindings files from
> dt-bindings/iio to dt-bindings/iio/adc folder, as they are
> specifically for ADC devices. It also fixes all compilation errors
> with this change in driver and devicetree files and similar errors
> in documentation for dtbinding check.
> 
> Patch 2 splits out the common ADC channel properties used on older
> VADC devices, which would also be reused on ADC5 Gen3.
> 
> Patch 3 adds bindings for ADC5 Gen3 peripheral.
> 
> Patch 4 adds the main driver for ADC5 Gen3.
> 
> Patch 5 adds the auxiliary thermal driver which supports the ADC_TM
> functionality of ADC5 Gen3.
> 
> Changes since v6:
> - Updated auxiliary device cleanup handling to fix memory freeing issues
> - Updated copyright license in newly added files

Eveyrthing is an update.... What did you change in copyright and
license? And why?

> - Addressed some reviewer comments in documentation and driver patches.

What changed specifically?

> - Link to v6: https://lore.kernel.org/all/20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com/
> 

Best regards,
Krzysztof


