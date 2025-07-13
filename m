Return-Path: <linux-iio+bounces-21598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A64B03130
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5AD7AE10D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5C278153;
	Sun, 13 Jul 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAegdKTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD752E36EE;
	Sun, 13 Jul 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413523; cv=none; b=b1JQan0EgwLp3bOWgDmFnZba54aWusJXuXGoGWPPLh20alCTK3rteNIuFPXEGFFBgxjeeU9kj9bUxVSR+lvbXk1dLF0DH/gIEDwK2BWpQV+7c5umMQKbrpg/1W3wwkOWbPED7c/8//hmxBS2uj1EAZ8pKaCPW+qSJ73N8OZ8FsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413523; c=relaxed/simple;
	bh=Sb3s9wGLtY+M3hpUawaRjK8gLZhXFTW3DV50k1kRVJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5UlI19pSGRpHBPoEnhsrzEQ9XmBlVx9H4hDW85gh2WJJCAVFTlzxeZCff0GD31EGavpqmPje4/9LnSFczI1h23xnnUTWsmOzAqhcijukPzl252xvspiPYvTCxBfm8FTfbCRqtSTDx8OFA45Kuvv1WGQ/14K0E0uyWUc5kwo31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAegdKTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777A8C4CEE3;
	Sun, 13 Jul 2025 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413522;
	bh=Sb3s9wGLtY+M3hpUawaRjK8gLZhXFTW3DV50k1kRVJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAegdKTPKXSfJBWKEKnuLJNpg9fH+kLU+vrlCoQ7OP338WeTPONfSThypHjdeSOVT
	 A95XJ4ylTaepmvs4WD8z4IMQkPw4LAcyrhdjHZlPZEdE9VO7CpR/187EOpglKIg7b5
	 ZI+Pz3l96kXSCxZasGnWyjDF8CeMbXuiRyMLt23yjFPAEw88mmxbOaWMP0eH8opNoK
	 4QRZTH9T8y/Ek6EXZcQifKk/HTaVOENHWL6l9Y86JAwzJ/hNOiB367Nx1lqd+nIrc3
	 CIfWMMgyTItPLY0pISIAHe5MzyBmF0GeeGO5IqioLi0YqWq9G8K+LWb38n6epAeEf5
	 C610H2UshMx5w==
Date: Sun, 13 Jul 2025 14:31:49 +0100
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
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20250713143149.60763b52@jic23-huawei>
In-Reply-To: <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
	<20250511140418.33171ca3@jic23-huawei>
	<ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
	<20250628173112.63d9334e@jic23-huawei>
	<5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 12:14:13 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 6/28/2025 10:01 PM, Jonathan Cameron wrote:
> > 
> >   
> >>>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> >>>> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
> >>>> +				  1000, 2000, 4000, 8000, 16000, 32000,
> >>>> +				  64000, 128000 },    
> >>> Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
> >>> elements per line make it much easier to see which element is which in these arrays.
> >>> Reduce the indent a little to allow that here.    
> 
> ...
> 
> >>>
> >>> It was never worth bothering with release until we had devm managed form but
> >>> now we do the code complexity cost is low enough to make it reasonable.
> >>>     
> >>>> +	indio_dev->name = pdev->name;    
> >>>
> >>> Just to check.  Does that end up as a part number or similar?    
> >>
> >> I printed this name and it appeared like this:
> >>
> >> indio_dev->name: c426000.spmi:pmic@0:adc@9000
> >>
> >> It only gets the DT node names, which are generic, there are 
> >> no part numbers in this name.  
> > I thought it might be something along those lines.
> > 
> > indio_dev->name should be the part number so hard code it rather than
> > getting it from the pdev->name
> >   
> 
> Actually there would be more than one PMIC which can function as the master PMIC
> for Gen3 ADC functionality, so I don't think I can simply hard code a name here
> based on PMK8550, if we want to keep the part number correct.
> 
> Since we can't get the part number directly from the DT node names, we
> could try one of the following ways to add it:
> 
> 1. Add a devicetree property for the part number
>    This would be simple, but I'm not sure if this is the best way, 
>    if the below method looks good.
Nope as if you need a part number, that's should be via the compatible.
> 
> 2. Add a string in the compatible property for the part number.
>    This means updating the compatible from "qcom,spmi-adc5-gen3"
>    to something like this for PMK8550:
> 
>    compatible = "qcom,pmk8550-adc5-gen3", "qcom,spmi-adc5-gen3";
> 
>    and then extracting the part number from the first string.

Do it via a compatible lookup + data in relevant tables rather
than messing with string break up.  Sometimes we'll get the
part number of the fallback compatible but I don't really care.
However, see below - I think spmi-adc5-gen3 is effectively the
part number for the IP. It just happens to be inside a PMIC
that has another name.

> 
> Please let me know which method you would prefer.
> 
> In addition, does the below string look fine, to assign to
> indio_dev->name for PMK8550?
> 
> pmk8550_adc

That's ok, though given it's an ADC anyway, pmk8550 should be sufficient
for this IIO specific name.
If it makes no practical difference what PMIC it is for this driver
then simply use spmi-adc5-gem3 or something along those lines.
So kind of a generic part number for the IP rather than specifics of
which PMIC it is implemented in.

Jonathan


> 
> Please let me know if you want a different format here.
> 
> Thanks,
> Jishnu
> 
> > 
> > Jonathan  
> 
> 


