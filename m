Return-Path: <linux-iio+bounces-16216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DFBA4A845
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 04:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC73BB682
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682911ADC68;
	Sat,  1 Mar 2025 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV1yj3pP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D71CD15;
	Sat,  1 Mar 2025 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740799542; cv=none; b=ScnnbYWqzmdzoGXE7nkjSnfZJVQ8vmffM9DycY0871rBPwT+RpSLLmAYsnSpB3dXb+UavnZjdzdDCylHML2GZ5rlrKCMph0sA0pP4x+wyZBfKskjUvIf4mHD/NjrCXLNSn/JSXVbiJUuhy1Nc66wfRq3xy8Xjq3dpjzvNxh5Fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740799542; c=relaxed/simple;
	bh=FmQ/Wz4ZtwGsNlXMLA2I4TgbrEPenZCG9Iv0gdXbVDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uI+aXHhdrVCV1cgBOwZr6u4L9UN6Zod/qpIMXK4nk8ZlvQar017VVd6yXsgmOKKCOoehfgOuDok5afU8eG2UI21aPI3rJrx5luLb59VkR3uwcthIPmMDzpp6FNdJg7u/rNKQWbC56rMb3Zjt8ww+wQ1LSP/6itkHM35BcqUibug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV1yj3pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A14C4CED6;
	Sat,  1 Mar 2025 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740799541;
	bh=FmQ/Wz4ZtwGsNlXMLA2I4TgbrEPenZCG9Iv0gdXbVDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qV1yj3pP/YiTqZmytVT+45Crbjp118n/HZY9xCXrKEDhw6EhxgHtjfA2o8ZdUF12+
	 ZbIOz258SUZx59KzguFDK05TvwmCAgWyRV2iOzm2Zx2M5WeHOQOSsUR3rJeRR26G9j
	 vWwoRxzoBRTKWaFrFAp8HenVq+Z0uSLafSMVdOHiDYHg36sCMgNiQUSFbPaAY0h1o6
	 6WCCeGb5OyzmoNepcX1bJQmEy4U+82W5hnAVDVz0qYLpN17t3CkijlOR0tHcHNF1k9
	 ry4cRubRiLiX08yUeLpCZosIvSYsZLp7m+uDTzl3ze6ScOZg9eHc77y5kbk1THz1Kl
	 Q1XbG+Sek+o7A==
Date: Sat, 1 Mar 2025 03:25:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 lars@metafoo.de, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20250301032519.16e77288@jic23-huawei>
In-Reply-To: <9e14f58f-e345-4bae-b14e-de25fc28d9a8@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
	<20250201121134.53040aae@jic23-huawei>
	<9e14f58f-e345-4bae-b14e-de25fc28d9a8@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 14:22:05 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 2/1/2025 5:41 PM, Jonathan Cameron wrote:
> > On Sat,  1 Feb 2025 00:02:41 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS.
> >>
> >> One major difference is that the register interface used here is that
> >> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> >> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> >> channels, which may be used for either immediate reads (same functionality
> >> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> >> (same as ADC_TM functionality).
> >>
> >> By convention, we reserve the first channel of the first SDAM for all
> >> immediate reads and use the remaining channels across all SDAMs for
> >> ADC_TM monitoring functionality.
> >>
> >> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> >> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> >> driver.
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
> > Hi,
> > 
> > A few minor things inline.  One general one is keep to under 80 chars
> > for line wrap unless going over that makes a significant improvement
> > to readability.
> > 
> > Jonathan
> >   
> >> ---
> >> Changes since v4:
> >> - Moved out common funtions from newly added .h file into a separate .c
> >>   file to avoid duplicating them. Updated interrupt name as suggested
> >>   by reviewer. Updated namespace export symbol statement to have a string
> >>   as second argument to follow framework change.
> >>  
> 
> ...
> 
> >> +
> >> +			if (!conv_req)
> >> +				return 0;
> >> +		}
> >> +
> >> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);  
> > fsleep() perhaps as I doubt the extra tolerance that will give will matter
> > much.  
> >> +	}
> >> +
> >> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
> >> +	return -ETIMEDOUT;
> >> +}
> >> +EXPORT_SYMBOL(adc5_gen3_poll_wait_hs);  
> > 
> > At some point may be worth namespacing all these exports.
> > Probably not in this series though!  
> 
> In the main driver file (qcom-spmi-adc5-gen3.c), I have already exported some functions to a namespace ("QCOM_SPMI_ADC5_GEN3"),
> which is imported in the auxiliary driver file (qcom-spmi-adc-tm5-gen3.c).
> 
> Do you think I should export these functions to the same or a different namespace? Or should we check this later?
Later is fine.

> >> +void adc5_take_mutex_lock(struct device *dev, bool lock)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >> +	struct adc5_chip *adc = iio_priv(indio_dev);
> >> +
> >> +	if (lock)
> >> +		mutex_lock(&adc->lock);
> >> +	else
> >> +		mutex_unlock(&adc->lock);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, "QCOM_SPMI_ADC5_GEN3");  
> > 
> > This is potentially going to make a mess for sparse.  Might be better to split
> > it in two so you can had __acquires and __releases markings.
> > 
> > If you don't get any warnings with sparse then I guess we are fine.
> >   
> 
> I had tried building with sparse in my local workspace and I did not get any errors in this file. Do you think I can keep this unchanged?
> Also, would any kernel bots run sparse later on this patch, if it's not already done?

Problems around this tend to turn up a bit late in build tests as requires
particular combinations of features.  Here you may not see problems because
sparse can't see far enough to understand the locking.

I would still split this into lock / unlock as that matches better
with common syntax for locks.  We can then add markings
as necessary later.

> >> +/*  
> > 
> > Looks like valid kernel doc, so /** and check it builds fine
> > with the kernel-doc script.
> >   
> >> + * struct adc5_channel_prop - ADC channel property.
> >> + * @channel: channel number, refer to the channel list.
> >> + * @cal_method: calibration method.
> >> + * @decimation: sampling rate supported for the channel.
> >> + * @sid: slave id of PMIC owning the channel.  
> > 
> > In common with most of the kernel, if there is another name that
> > can be used, I'd prefer avoiding that term.
> > ID probably fine for example or leave it ambiguous as SID
> >   
> 
> Just to be sure, does this look fine?
> 
> @sid: ID of PMIC owning the channel.
Ok.
> 
> I'll address all your other comments in the next patch series.
> 
When replying with feedback on some items crop out the rest
of the email just to maintain relevant context.
Saves time and makes less likely important parts of your reply
might be missed.

thanks,

Jonathan

> Thanks,
> Jishnu

