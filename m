Return-Path: <linux-iio+bounces-11681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF59B7578
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49BF1C24C32
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012814A09F;
	Thu, 31 Oct 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahwbu6H5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20864149C54;
	Thu, 31 Oct 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360207; cv=none; b=dEAYdqcqW61SiV8Cp6csR4fFdiR7Gr2Xym77MSerUY1O3clL0/c17Dtv1CX2nHFh7UX8GrjbLXGlWu7U9hRJH5bPpKUURPFe8i5iEBgkTKOvW0Ofdw9vOgTykE/YQBYxCUDTgSo8cHof/VLwP7ULzpiEPj5qE3uIgd4iNLqJMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360207; c=relaxed/simple;
	bh=Q1aV6rGqCQlq2aELxThGs+q8I/yjm7V3satrDVXpHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXcwJKC+t816Q+ZxReX7HnusTreKXyoCdkee3wVIlcKm2mcez02rhKhGa5Bpe5S3zBivbFevl8CUPeJQfovl4b3xFLl7w08nitLi9ggk0YdQieSYdaCpA4G7dmJL6mmU5F2p6lpVqymka1img1/jY5kQlL0jPFP0jQZSNbGRmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahwbu6H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789EC4CEC3;
	Thu, 31 Oct 2024 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360206;
	bh=Q1aV6rGqCQlq2aELxThGs+q8I/yjm7V3satrDVXpHi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ahwbu6H5HG9lVu/5J77HI7tAOJuawifD1MFA/FuGxixJWdC+IRfrWJZl9Cop3NInD
	 diUILWcIGV0F/JEejh/7cyibK7MBCjEJiHBeKqm5sE5qvb+uoXv8oiAti3YowG/TCA
	 1FVdGDI3eJczqHNO6DeBd4lNTR7dLAMqwZb+6ISwmKAuefrq8yfbod3Mr3B8/KVizy
	 QjZlCcjP9vzRJMn5Tc1JF8sqRWFjZXToego7Np9jlF8dw9CGvkdMt4llSA2d62Y6FO
	 0yBpy5iHb/7AAStQ984O/fU8jGOvvMEJ/PViIutiM+Ei6Q/BtOknEHYbEzry9pH0Na
	 aEBc7HQO5HMjw==
Date: Thu, 31 Oct 2024 08:36:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, 
	sboyd@kernel.org, quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, 
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com, amitk@kernel.org, lee@kernel.org, 
	rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de, 
	quic_skakitap@quicinc.com, neil.armstrong@linaro.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH V4 0/4] Add support for QCOM SPMI PMIC5 Gen3 ADC
Message-ID: <f2c2zxxmsk74rbgbhus7nyrxppwdeq2esgifigt7c326zzlmla@6vdb2rmbjptl>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030185854.4015348-1-quic_jprakash@quicinc.com>

On Thu, Oct 31, 2024 at 12:28:50AM +0530, Jishnu Prakash wrote:
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
> Patch 2 adds bindings for ADC5 Gen3 peripheral.
> 
> Patch 3 adds the main driver for ADC5 Gen3.
> 
> Patch 4 adds the auxiliary thermal driver which supports the ADC_TM
> functionality of ADC5 Gen3.
> 
> Changes since v3:
> - Updated files affected by adc file path change in /arch/arm folder,
>   which were missed earlier.

I don't think this was tested afterwards...

Best regards,
Krzysztof


