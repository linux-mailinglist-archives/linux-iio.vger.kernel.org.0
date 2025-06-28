Return-Path: <linux-iio+bounces-21058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4906EAEC8C8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6E07AF090
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF2248F5B;
	Sat, 28 Jun 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQLRPRhw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFE1FBC91;
	Sat, 28 Jun 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128290; cv=none; b=pr01PVPTSHTCBt2jf6lX0J65fsenBWujCNNue20F0PmOZICJfXkFFg9knj92X6zDAafrMSOf3XoKM2PDazOih37dRdPr7ZC4sPgRM+mU7X5SSK914i+y4B1ds7+gONDaGemG1d54naVry+MrIg9NzkC2pRa9X7PCtMPauGpuaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128290; c=relaxed/simple;
	bh=ysZnhmJGpruuPPRq6A2SjBxDODaSwvv2FXxAy1Z+NAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOA7oGGwB2aC+X81oeXVdQfFUc3s7Z0mB1RRtEbv1HqtQ8VK3pgKHcLz1fHKDRPegMi/EtpQ5irUiIYqhalOQaRqFsGQCDtu8B7XHv0Fh/WwhfX5H/spCuw8XxGp1QxAqF891Y53T+HM5zHxbXQv2dQ2jkXVOl+SNqx9kvW1URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQLRPRhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B22FC4CEEA;
	Sat, 28 Jun 2025 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751128289;
	bh=ysZnhmJGpruuPPRq6A2SjBxDODaSwvv2FXxAy1Z+NAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQLRPRhw66r3jlKJvSsokpA4kp2y7IfYSnOzLuHFlNANWAlwbsQKroxvqexfBCtBT
	 ibCgevepYqNNLNmW+b2sHYFpjTzJrmi1/EE6mHmgURM78btgzKj0RPx/P7SiXFQGoP
	 8r79mIpKkjRINMdE9p8XvawckltNbQwre6ka0DlFEJA6nm5yQdRpcZfDdLHkI01hC3
	 zB37K3GcFxk/xjQYjuiRVn6U7nnJwraiWyV2ZlqKucdanxoovTqdr7W5DokKX0VB4Q
	 Vqb22IaqoYwQttdDphBj9SOG+Fk11E4AV3YYnxtJWiZU3OFioexl9vp6reRWFlRSpm
	 TEOPM9ofze1AA==
Date: Sat, 28 Jun 2025 17:31:12 +0100
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
Message-ID: <20250628173112.63d9334e@jic23-huawei>
In-Reply-To: <ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
	<20250511140418.33171ca3@jic23-huawei>
	<ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



> >> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> >> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
> >> +				  1000, 2000, 4000, 8000, 16000, 32000,
> >> +				  64000, 128000 },  
> > Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
> > elements per line make it much easier to see which element is which in these arrays.
> > Reduce the indent a little to allow that here.  
> 
> Does this look fine?
> 
> 	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> 			  { 15, 100, 200, 300, 
> 			    400, 500, 600, 700,
> 			    1000, 2000, 4000, 8000,
> 			    16000, 32000, 64000, 128000 },
Look good.

> >> +static int adc5_gen3_probe(struct platform_device *pdev)
> >> +{  
> >   
> >> +
> >> +	platform_set_drvdata(pdev, indio_dev);
> >> +	init_completion(&adc->complete);
> >> +	mutex_init(&adc->lock);  
> > If spinning again for other reasons, in new code I have slight preference for
> > 	ret = devm_mutex_init(&adc->lock);
> > 	if (ret)
> > 		return ret;
> > 
> > It was never worth bothering with release until we had devm managed form but
> > now we do the code complexity cost is low enough to make it reasonable.
> >   
> >> +	indio_dev->name = pdev->name;  
> > 
> > Just to check.  Does that end up as a part number or similar?  
> 
> I printed this name and it appeared like this:
> 
> indio_dev->name: c426000.spmi:pmic@0:adc@9000
> 
> It only gets the DT node names, which are generic, there are 
> no part numbers in this name.
I thought it might be something along those lines.

indio_dev->name should be the part number so hard code it rather than
getting it from the pdev->name


Jonathan

