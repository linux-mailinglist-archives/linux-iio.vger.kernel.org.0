Return-Path: <linux-iio+bounces-16310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22FA4CFB7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 01:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FCB7A7BEC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C153FC7;
	Tue,  4 Mar 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8rweL6z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB81F92A;
	Tue,  4 Mar 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046991; cv=none; b=Jrc4hszOHWLLMJ18bqCa0DObidmhKIdLfpXo9jb+EdLH4qWAb/wbPiBXXhGCROEFpUtpgzpgg+LafJWtRoxOS6StlqVIwVE11tdVE3+rXlVlf0+pduiFEvZsfHCGwNxw+8r0IJmOEgklBYyNxEqf8x2PKFOq6iS0UNCUY5uu4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046991; c=relaxed/simple;
	bh=HYDy0V16CbXKV+Z0Ebwz9QqNroH1o7OVsMOOPFZOv8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjypXU5gyzx8AbixocZWMiNSVRsmFe12eXEUFlnphTNgla63GMO2goH6ZGz2TG8izyseh6Vdea+z+SBAqZo7BJ14QPBt+8ViRtI97B6mao3blSzhDdKdkBPctO/B7C/jaWcLHB7YH7WRZEAkieYGGCKHaQ68ObyM1Qb8nxb/+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8rweL6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92D3C4CEE4;
	Tue,  4 Mar 2025 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741046990;
	bh=HYDy0V16CbXKV+Z0Ebwz9QqNroH1o7OVsMOOPFZOv8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8rweL6z8sb03sGNJu6P+EjwBBwv8zF1+YLwXCWEPWym0DdxXODtNhIrVss7pzQuF
	 ht+XrUeCTypcwk4Sf5/2Dzy7AVdsJsTxvhL/IkCKRAu6Ih7aKaE37UZHC8fEo9Y8Dz
	 +xTRikR0XQQ68mdX1zTebYrZ2ZOM02sYc3MLzCMH2FUmX+WtyUK/DE3YH7UjKlDSU5
	 xsrniPbzjCkDbNHZ6AGjVKAqTJjXlhnUyXVj77GzEnLIBqi5tRmNIQL9dWUr4NzSvy
	 zv+ZZz1iKxkpvYuIQLcpoeYNw4i1AbeSiCYNa8YmfH69T6sR9PHknK3KcJOXUvt8zg
	 bVqlAq6dyNbaw==
Date: Tue, 4 Mar 2025 00:09:31 +0000
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
Message-ID: <20250304000931.5be25de1@jic23-huawei>
In-Reply-To: <449712bb-961e-4ccf-bf74-50dd55315abc@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
	<20250201121134.53040aae@jic23-huawei>
	<9e14f58f-e345-4bae-b14e-de25fc28d9a8@oss.qualcomm.com>
	<20250301032519.16e77288@jic23-huawei>
	<449712bb-961e-4ccf-bf74-50dd55315abc@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 19:26:37 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 3/1/2025 8:55 AM, Jonathan Cameron wrote:
> > On Wed, 26 Feb 2025 14:22:05 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> ...
> >>>> +void adc5_take_mutex_lock(struct device *dev, bool lock)
> >>>> +{
> >>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> >>>> +	struct adc5_chip *adc = iio_priv(indio_dev);
> >>>> +
> >>>> +	if (lock)
> >>>> +		mutex_lock(&adc->lock);
> >>>> +	else
> >>>> +		mutex_unlock(&adc->lock);
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, "QCOM_SPMI_ADC5_GEN3");    
> >>>
> >>> This is potentially going to make a mess for sparse.  Might be better to split
> >>> it in two so you can had __acquires and __releases markings.
> >>>
> >>> If you don't get any warnings with sparse then I guess we are fine.
> >>>     
> >>
> >> I had tried building with sparse in my local workspace and I did not get any errors in this file. Do you think I can keep this unchanged?
> >> Also, would any kernel bots run sparse later on this patch, if it's not already done?  
> > 
> > Problems around this tend to turn up a bit late in build tests as requires
> > particular combinations of features.  Here you may not see problems because
> > sparse can't see far enough to understand the locking.
> > 
> > I would still split this into lock / unlock as that matches better
> > with common syntax for locks.  We can then add markings
> > as necessary later.
> >   
> 
> OK, I can split this into separate lock and unlock functions.
> And for markings, you mean I should add these:
> 
>     __acquires(&adc->lock)
>     __releases(&adc->lock)
> 
> under the lock and unlock functions respectively?
yes

> 
> Thanks,
> Jishnu
> 
> >>>> +/*    
> >>>
> >>> Looks like valid kernel doc, so /** and check it builds fine
> >>> with the kernel-doc script.
> >>>     
> 


