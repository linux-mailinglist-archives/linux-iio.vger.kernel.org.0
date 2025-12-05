Return-Path: <linux-iio+bounces-26782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F738CA6C88
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43AFB3102976
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EB31283E;
	Fri,  5 Dec 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDxUs0et"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6B28695;
	Fri,  5 Dec 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925030; cv=none; b=XDQ9V0lBk4IWR3xM6wqQiGHf7ZUlpMbhsyT9VXU+k/jFKEVMIOWYiw72JOHqJ+Uccl5zQqn7SlwXrUR8UlPZY6mZzGPoXP42XrK6HDBcu2SRyUmTPynDK2c71D+HZR6ONvjsTcOfL1DqUewH3NoIOM+hjCxJrfokBP+DVCnzWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925030; c=relaxed/simple;
	bh=lpKjmPXsQUzMI0XuJPHsR3L6oiyQDFc+I3FpnEdPT1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkUZPsMLEuS4lBCvsqEgv85bPS18Qk5Y0csnlDoQ4Qgq/h5jpF8sMfntR4OPZaYZqaxXQ8sgOfV/nOuDZs/xrqi22umTI8jZPwQ+EeQHjwolqn6V+xxZZ4b7qOqNL7w6ys/K/VYsmvrenaWVLvObPa2ZYWH/a+/EMGd2qBJI8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDxUs0et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FADC4CEF1;
	Fri,  5 Dec 2025 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925028;
	bh=lpKjmPXsQUzMI0XuJPHsR3L6oiyQDFc+I3FpnEdPT1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDxUs0etU8IbVRvDA6aOScBeSCgpwgo4oT6E6DP6lXnCBzOnffiA8MeDNO43RzgQr
	 sTJRawv80B2CsPkRXMi9/LelqzOkaS9PDauJ8vyX9iGWvDsL+iGo2swCxp7z+fUWhM
	 JsdMCNbsuxxvFc45rtPknRU/YUnCCsl+pPQsj7euTkm2V6FeVx6S/u04s/qheTIidD
	 6eYoxlZ+6DckRflmFoN+uCHVmU84uccZgaGWBQ9XzXLPzqURqAFmmrsyXpBEZJZLXG
	 7TUU9QiLNT7zNA55gRQcHLcRJz9siyCoW/J78P77UfwSJzvITuKHKVD1HnFfuIsVNq
	 j2TgtSpairqDw==
Date: Fri, 5 Dec 2025 09:57:06 +0100
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
	quic_kotarake@quicinc.com, neil.armstrong@linaro.org, stephan.gerhold@linaro.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH V8 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Message-ID: <20251205-savvy-festive-lyrebird-96bfa0@quoll>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
 <20251127134036.209905-3-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127134036.209905-3-jishnu.prakash@oss.qualcomm.com>

On Thu, Nov 27, 2025 at 07:10:34PM +0530, Jishnu Prakash wrote:
> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> 
> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> going through PBS(Programmable Boot Sequence) firmware through a single
> register interface. This interface is implemented on SDAM (Shared
> Direct Access Memory) peripherals on the master PMIC PMK8550 rather
> than a dedicated ADC peripheral.
> 
> Add documentation for PMIC5 Gen3 ADC and update SPMI PMIC bindings to
> allow ADC5 Gen3 as adc@ subnode.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


