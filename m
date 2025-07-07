Return-Path: <linux-iio+bounces-21435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E8AFB99F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 19:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAAB4A6EEE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80EF2E8899;
	Mon,  7 Jul 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWCEone0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549512264A0;
	Mon,  7 Jul 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908006; cv=none; b=R4J6g4OSSUqDWSh+BqKgXCWzobuiA2fVbOoEzHG8dK7GOZZmhoP7UgJ1FTOmoGF8MWq0jsoG/O8vhwTm9XNr+Ol446sWe+Eb2MZSAQbTWZczUYS8fubPcQzh78ba2ScNuzfMqQck1h7k3D7X1tWXfXxrsrjA5LEnwUYJkJk6m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908006; c=relaxed/simple;
	bh=RmgBMi2VW8e/N4LvJnOaj4Wgc8weyyjOi7wU4geY8+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prZ9M2ZfbnSRseMdGd1bNg5cas9vzMtGfq45DhHHlnCYu09X9UxL9ZV+TlcREOi/vkKH2rMrmlwlCCzhqbisTmoTenppv65OHNJdJfdmPDxbwVjob4/QDkP7rdj/3Xh1Mz8bZqoM0dUcIiRGK9nrt3gquxrC394tDsTgt3igTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWCEone0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F7C4CEFA;
	Mon,  7 Jul 2025 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751908005;
	bh=RmgBMi2VW8e/N4LvJnOaj4Wgc8weyyjOi7wU4geY8+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWCEone0nNbiHJxkCKz0vnh51AVh/vJy0rWCQrBt2WkMeze4hEgcDH97m75KDycrK
	 mxoRh7QXG/32b7PiDrQ+kaBICHKPE5MUKDkCHh4JYxvS+vBEVAc/m2+EHg2udAjV7Q
	 FWxxqpNYsQO+oiuFWcfesOWnOUqyhtNmM4Io5/B88l0pCaYuALyRF430bgAAKh4BXn
	 CVZALtGxrQiNikRInRzoneEcekpnNalAZHlTvavpGdCPXjR/GM15DRfQSWfBhaqcNJ
	 fLPvspMAoBH1fvPweStN9HzAdvp7eCj2qoxI2yKsLp06pGRxL54Y8LRH5QPhEgvMg1
	 t0PFw9aHTc0WQ==
Date: Mon, 7 Jul 2025 18:06:36 +0100
From: Simon Horman <horms@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	"Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Petar Stoykov <pd.pstoykov@gmail.com>,
	shuaijie wang <wangshuaijie@awinic.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/3] net: qrtr: Define macro to convert QMI version and
 instance to QRTR instance
Message-ID: <20250707170636.GR89747@horms.kernel.org>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
 <20250406140706.812425-3-y.oudjana@protonmail.com>
 <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com>
 <aMbAZigHiAN2xupOYs9DodY2mOdNtw_oVjOaweflgA8IoXRQ5ctoZ8GYJ8PNAKDgL4f9N_UD7tFmkePUy9BCE8v20Mae2x-eL1ZpyJEdLZY=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMbAZigHiAN2xupOYs9DodY2mOdNtw_oVjOaweflgA8IoXRQ5ctoZ8GYJ8PNAKDgL4f9N_UD7tFmkePUy9BCE8v20Mae2x-eL1ZpyJEdLZY=@protonmail.com>

On Sat, Jul 05, 2025 at 06:29:39PM +0000, Yassine Oudjana wrote:
> On Wednesday, April 9th, 2025 at 3:54 PM, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
> > On 4/6/25 4:07 PM, Yassine Oudjana wrote:

...

> > > diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrtr.h
> > > index 4d7f25c64c56..10c89a35cbb9 100644
> > > --- a/include/linux/soc/qcom/qrtr.h
> > > +++ b/include/linux/soc/qcom/qrtr.h
> > > @@ -13,6 +13,8 @@ struct qrtr_device {
> > > 
> > > #define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> > > 
> > > +#define QRTR_INSTANCE(qmi_version, qmi_instance) (qmi_version | qmi_instance << 8)
> > 
> > 
> > Please use FIELD_PREP + GENMASK to avoid potential overflows
> > 
> > Konrad
> 
> Since I'm using this macro in initializing QRTR match tables I am unable to use
> FIELD_PREP. When I do, I get such errors:

Does using FIELD_PREP_CONST, say in a QRTR_INSTANCE_CONST variant, help?

> 
> In file included from ../arch/arm64/include/asm/sysreg.h:1108,
>                  from ../arch/arm64/include/asm/memory.h:223,
>                  from ../arch/arm64/include/asm/pgtable-prot.h:8,
>                  from ../arch/arm64/include/asm/sparsemem.h:8,
>                  from ../include/linux/numa.h:23,
>                  from ../include/linux/cpumask.h:17,
>                  from ../include/linux/smp.h:13,
>                  from ../include/linux/lockdep.h:14,
>                  from ../include/linux/mutex.h:17,
>                  from ../include/linux/kernfs.h:11,
>                  from ../include/linux/sysfs.h:16,
>                  from ../include/linux/iio/buffer.h:9,
>                  from ../drivers/iio/common/qcom_smgr/qcom_smgr.c:8:
> ../include/linux/bitfield.h:114:9: error: braced-group within expression allowed only inside a function
>   114 |         ({                                                              \
>       |         ^
> ../include/linux/soc/qcom/qrtr.h:21:10: note: in expansion of macro 'FIELD_PREP'
>    21 |         (FIELD_PREP(GENMASK(7, 0), qmi_version) | FIELD_PREP(GENMASK(15, 8), qmi_instance))
>       |          ^~~~~~~~~~
> ../drivers/iio/common/qcom_smgr/qcom_smgr.c:825:29: note: in expansion of macro 'QRTR_INSTANCE'
>   825 |                 .instance = QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
>       |                             ^~~~~~~~~~~~~

...

