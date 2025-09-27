Return-Path: <linux-iio+bounces-24482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E719FBA5FE1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BE03BF9CF
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6A2E090A;
	Sat, 27 Sep 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJV/NKbi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B616F2F2;
	Sat, 27 Sep 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758980895; cv=none; b=oik/Xk9m2+CdokN/UuurTKJ+5oeE5eKal9dfSp2M3syaZZu+E9lbJkTSCGcTwPqeKSZX71jPNIy7HvK7es6bH2h+aReDsqaym6iVheJZZ4a1cflBsdH5TJUC76WfPBIJXHnsgJxFProR3230SS0lmM/v420qaV6A+yiTWDE+q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758980895; c=relaxed/simple;
	bh=xPv55APnDxR98J78zg7XwhLgcPoi+E8ffL/ShjKi7gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPxeBz+3LM/m0MjNZMFK08Gn6T/m5JEumXgHZ+rCguDx3FpcXwEbis0n2Uf86Sw48OMxpGwl06sr4JVO20PK+YTFJe7qtndZNBklrHw6dU8zbVXomEKkprHgA9/f4y5HIrhxtkVkzBZ5xkux05udIRBJ5CKcdZ26BVkdKwZ+ETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJV/NKbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FBEC4CEF7;
	Sat, 27 Sep 2025 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758980894;
	bh=xPv55APnDxR98J78zg7XwhLgcPoi+E8ffL/ShjKi7gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJV/NKbi6AUjWrpVLUkMU55EbQhfBVy6ESr1HcAdWeObVluWSv7SYpq7W9yPZ4ni+
	 qYUznKvX3PZETbN86auvXo9CUTL+/rlx70lZXp6D5WVD5O3mllIwDXJkQtmpQE22WI
	 +Enfn6+ZI4mipHjznJHQoaS8AFRCPA5tsYN09D4ULoFqUuB0t/01Cg9kKmXhVFZiSK
	 pr3B+t3tQlHPF7yilWih2Lx+G37+sZvedY2HFxvCVfDR2NH5qupAhUu7/D99mkHyXD
	 MWFZeCx/eZFZ3IkpVzBu/T2ljNzLXcynVg4ZWAisKlEw5DPI2d4p44944wPv/elg4V
	 stS+dY+WY4nHg==
Date: Sat, 27 Sep 2025 14:47:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC
Message-ID: <20250927144757.4d36d5c8@jic23-huawei>
In-Reply-To: <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
	<20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
	<20250829-classic-dynamic-clam-addbd8@kuoka>
	<5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
	<4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
	<a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
	<8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
	<5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 20:17:43 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Krzysztof,
> 
> On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
> > On 18/09/2025 04:47, Jishnu Prakash wrote:  
> >> Hi Krzysztof,
> >>
> >> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:  
> >>> On 16/09/2025 16:28, Jishnu Prakash wrote:  
> >>>>> You cannot have empty spaces in ID constants. These are abstract
> >>>>> numbers.
> >>>>>
> >>>>> Otherwise please point me to driver using this constant.  
> >>>>
> >>>> These constants are for ADC channel numbers, which are fixed in HW.
> >>>>
> >>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
> >>>> which is added in patch 4 of this series.
> >>>>
> >>>> They can be found in the array named adc5_gen3_chans_pmic[].  
> >>>
> >>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
> >>>  
> >>
> >> We may not be using all of these channels right now - we can add them
> >> later based on requirements coming up. For now, I'll remove the channels
> >> not used in adc5_gen3_chans_pmic[].  
> > 
> > You are not implementing the feedback then. Please read it carefully.
> >   
> 
> Sorry, I misunderstood - so you actually meant I should remove the
> empty spaces in the definitions, like this?
> 
> -#define ADC5_GEN3_VREF_BAT_THERM               0x15
> +#define ADC5_GEN3_VREF_BAT_THERM 0x15
> 
> I thought this at first, but I somehow doubted this later, as I saw some
> other recently added files with empty spaces in #define lines, like:
> 
> include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
> include/dt-bindings/regulator/st,stm32mp15-regulator.h
> 
> I can make this change, if you prefer this. Please let me know
> if I'm still missing something.
> 
> Also please let me know if you want me to remove the unused
> channels - I would prefer to keep them if there's no issue,
> as we might need them later.
> 
He is referring to 0x14 and below not being defined values.  So what
do they mean if they turn up in the DT?

Hence the request for context on how this define is being used so that
you can get some feedback on how it should be done.

J
> Thanks,
> Jishnu
> 
> > Best regards,
> > Krzysztof  
> 


