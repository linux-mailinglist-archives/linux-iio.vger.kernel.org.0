Return-Path: <linux-iio+bounces-16217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B3A4A849
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 04:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ED517798A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AE1ADC9B;
	Sat,  1 Mar 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSCGl9uL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F031CD15;
	Sat,  1 Mar 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740799761; cv=none; b=qAvJebN3k5IiClX2OhQhv290w0Nkqgl7rBNs5jIq0oISsRRfxxn84u2YaPcXQjMCX5B/wNmcmXQdm3AEaisVbwEn+8csxUqFkIaeK5NNAOhgKajhD/gCnFO/fmJU0Qaz9iSJYvI1K8Ig9Yik0ygfPgMjJgSMtFhtLnyY99wdh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740799761; c=relaxed/simple;
	bh=4zNZZHCJxSlrR3g9/cXq860pcRQMkMV544oAepV/mVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XacxifQZBogwBoDWKvpY10UJ33hSakVzka3zCHYlwcQJZNwwTTlsR8Fsyp1pZOJRha1d3LTMwH9YnwYrSIPnydHghhUwG6RWlPeCf00mDIJXNIYSoARDA6K9RLh6nC+BTszSUviJIv1xPKFSQvIsYpM8rVgEUBpC+9kjQpqXmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSCGl9uL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7A9C4CED6;
	Sat,  1 Mar 2025 03:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740799761;
	bh=4zNZZHCJxSlrR3g9/cXq860pcRQMkMV544oAepV/mVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSCGl9uLcYH6ad3F4/n1ymWtN4vyqST79ZuUJZLstzzgDx2Vj4YtuGJe7JX40UXyS
	 ScyPRNjHYUIop+6/hBOR9Nb6VINxAFQiGhalCRORVpi56FOKRZ1vzN+SANcwSu5+M7
	 HVIbkgNktO/kx6Lv+sMd7e8F3Knls5urquhj9waOlVJ+dpRWwibz594a1XYii3gvvr
	 kVo1vh/t9axIqdYU6NaBR6zPK3YAs7GSe15MBW20cIydgcuXBUmDr5AfNogwZASehE
	 YG4jwYTM9s3fKoOmvZ2rK8GvGm9pE4HJwk/yaLtLBJ9DUSKQ1az9vF9E6w3aQcoNzV
	 oaFED08wEbY+g==
Date: Sat, 1 Mar 2025 03:29:01 +0000
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
Subject: Re: [PATCH V5 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20250301032901.7b38fed4@jic23-huawei>
In-Reply-To: <dafe240f-c531-43f9-8787-bb8ba4ddea49@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-6-jishnu.prakash@oss.qualcomm.com>
	<20250201122731.2762b1f8@jic23-huawei>
	<dafe240f-c531-43f9-8787-bb8ba4ddea49@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 14:22:24 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 2/1/2025 5:57 PM, Jonathan Cameron wrote:
> > On Sat,  1 Feb 2025 00:02:42 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> Add support for ADC_TM part of PMIC5 Gen3.
> >>
> >> This is an auxiliary driver under the Gen3 ADC driver, which
> >> implements the threshold setting and interrupt generating
> >> functionalities of QCOM ADC_TM drivers, used to support thermal
> >> trip points.  
> > 
> > Very short wrap. For commit descriptions 75 chars is fine.
> >   
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
> > Various minor comments inline.
> > 
> > Jonathan
> >   
> >> ---
> >> Changes since v4:
> >> - Fixed a compilation error and updated dependencies in config as suggested
> >>   by reviewer.  
> 
> ...
> 
> >>
> >> +
> >> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
> >> +
> >> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
> >> +	.adrv = {
> >> +		.id_table = adctm5_auxiliary_id_table,
> >> +		.probe = adc_tm5_probe,
> >> +	},
> >> +	.tm_event_notify = adctm_event_handler,
> >> +};
> >> +
> >> +static int __init adctm5_init_module(void)
> >> +{
> >> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
> >> +}
> >> +
> >> +static void __exit adctm5_exit_module(void)
> >> +{
> >> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
> >> +}
> >> +
> >> +module_init(adctm5_init_module);
> >> +module_exit(adctm5_exit_module);  
> > 
> > Can use module_auxiliary_driver() to replace this boilerplate.
> > The embedded adrv shouldn't stop that working that I can see.
> >   
> 
> I tried to do this, but it does not work with the embedded adrv.
> 
> 
> When I tried this change:
> 
>     -static int __init adctm5_init_module(void)
>     -{
>     -       return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
>     -}
>     -
>     -static void __exit adctm5_exit_module(void)
>     -{
>     -       auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
>     -}
>     -
>     -module_init(adctm5_init_module);
>     -module_exit(adctm5_exit_module);
>     +module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
> 
> 
> Ideally this should have worked as I see module_auxiliary_driver() takes a single argument of type struct auxiliary_driver. But it failed with errors like this:
> 
> 
>     drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: expected '=', ',', ';', 'asm' or '__attribute__' before '.' token
>      module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
>                                                      ^
> 
>     drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: 'struct adc_tm5_auxiliary_drv' has no member named 'adrv_init'
>      module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
>                                                      ^
> 
>     drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:474:49: error: 'struct adc_tm5_auxiliary_drv' has no member named 'adrv_exit'
>      module_auxiliary_driver(adctm5gen3_auxiliary_drv.adrv);
>                                                      ^
> 
> 
> I think this happens because module_auxiliary_driver() is defined as a macro, like this:
> 
>     #define module_auxiliary_driver(__auxiliary_driver) \
>         module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
> 
> And when the text substitution for the argument is done, we would end up with lines like this in the expansion finally:
> 
>     module_init(adctm5gen3_auxiliary_drv.adrv_init);
>     module_exit(adctm5gen3_auxiliary_drv.adrv_exit);
> 
> 
> I'm facing similar issues, of the input argument being misinterpreted, if I use a pointer to the struct auxiliary_driver member (adrv), and dereference it as argument to module_auxiliary_driver().
> 
> I think module_auxiliary_driver() can only take a simple variable name as input, because in all the examples of its usage I found, I see there is a "struct auxiliary_driver" initialization just before the initialized variable is passed to module_auxiliary_driver().

Yes. Thinking more on this it uses that parameter as a source of naming for
some of the stuff it creates.

Thanks for trying this, and no problem with sticking to you original code
given this doesn't work :(

Jonathan


> 
> In this auxiliary driver, I need to have adrv embedded within the struct adc_tm5_auxiliary_drv wrapper, as I also need to have the .tm_event_notify member, to expose a callback to the main driver, so I don't think I can change this.
> 
> 
> I'll address your other comments in the next patch series.
> 
> Thanks,
> Jishnu
> 
> >   
> >> +
> >> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");  
> >   
> 


