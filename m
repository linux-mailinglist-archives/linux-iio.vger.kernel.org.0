Return-Path: <linux-iio+bounces-19427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E33AB2834
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42D61755AD
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D3256C82;
	Sun, 11 May 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSCaQuJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F824A32;
	Sun, 11 May 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746966670; cv=none; b=FkSJKujrc28+5ST9Udp+XjV9gvU+m1SOaz16knyOIzSIs/AlHg2gP35be61H/g7g1UB4KHcOSPng27Hc6gcOqFbzdA9BQOpBcvO222FHY47gbUXHiP1K3zyf6mWSFawyA7KC4AYxloVG1JuA39/5kMqqzY7aNkMP9qvtNqfjKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746966670; c=relaxed/simple;
	bh=VSz21wUvN2aP6s/5btPI9FEniypUewFNORjJoSRIo7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXfMBckOwSzHZUjyUp+yQ7pHBhHKByA/aa2O8XY9ZenwE8w9cxrAWQXMreAFNiPeb+1JuL+QX7GnQpZiQFpIW/qVkySwuYCO0TP5nFTNnDg6A4kBgXRL2JZmvkkl3hHO/d+jPvwzr4E8yhNuduFpZD2LCcbY22QNDjJrrYmpUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSCaQuJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C1EC4CEE4;
	Sun, 11 May 2025 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746966669;
	bh=VSz21wUvN2aP6s/5btPI9FEniypUewFNORjJoSRIo7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSCaQuJ0/MUpfUzd7QxOEEn0mGYPMDciCACql8otHm7xQ7GbDhBJ0XhwaWy9D81rQ
	 QG85NN1RwGEaqByCq9d8jsZ5LlSxaqzd6JaZMSxtpuRQeAv9vdSmgZtgjf/Y6pUnjJ
	 +72nLbg0GR6lGgun3Qpz7lrBbVC36dX7P6nduwP2hKxRo+HlR01K1dhVboKVAkQV6X
	 iQnJqSbCRcQq9WtjAYOjaTtplSuVnpNr6Vq87AvVaE8/kptzV/ZlerfVIp3dVa73Jd
	 gGB4doQCdEHQoVwyfFTR4121tz45MQY8PNV21Ka4CzJLmxE8R7lYuNFV0No+lVYW8O
	 YJucwlWuSyfZA==
Date: Sun, 11 May 2025 13:30:55 +0100
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
Subject: Re: [PATCH V6 3/5] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC
Message-ID: <20250511133055.54869b61@jic23-huawei>
In-Reply-To: <20250509110959.3384306-4-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-4-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:39:57 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

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

This looks fine to me.  The dependencies on previous two patches
make this a little tricky to handle though. I don't like splitting the
path the binding and the driver take to upstream but in this case
we probably either have to merge them in different cycles or this
needs to go with those code movement patches.  It looked like an
immutable branch would be very messy given additions that the 1st patch
touches probably mean an immutable would have to include a lot of
stuff that is queued up in the Qualcomm SoC tree.

If the rest of the necessary reviews turn up this cycle to get everything
in this cycle merge (seems unlikely) then I don't thing routing this
via the SoC tree will be a problem.

To enable that

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I suspect given timing best we can hope for is patches 1 and 2 go
via the SoC tree asap and we deal with the rest at start of next cycle
but I like to be optimistic :)

Jonathan

