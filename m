Return-Path: <linux-iio+bounces-21474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A9AFE840
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645B916AF4D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998C2D7816;
	Wed,  9 Jul 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvMd4y4R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76B2BD5BC;
	Wed,  9 Jul 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061959; cv=none; b=HR6+3k1yDHZ5vgGX31EnSeJfuMb+yAY/65NLe0Xe3vBaz5e/7D0DjOOmkvFIWOysEY20h9B3vFhXlfXA1iW8cRwuch22DBkriELa30n6TyN3Bwiw3OYSQpiPEQTFkU2jCakyh/PM1ECyFhw9QZHHd5StdJ5rT9OUOyHAkvMe88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061959; c=relaxed/simple;
	bh=BL4mdT3PrGBtb3/SFQL2jD7FRK8O1qchsF7KKukY9XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0juhkrdNJruGqJOhzhkQ5h0QdsKfYBfA+piqfRz1IFOFxPwXb0qdCFrX1n9AKdD2CYkMU1a0JzlZqfoqbzWGgKz51KX4nc81sH4FcIRylQA2CCZJCXAY6xUkth+64R6Prb2eLKlAHvSDIxhEfK4G3THRB+KjTC/e4nCN93cTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvMd4y4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA51C4CEEF;
	Wed,  9 Jul 2025 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061957;
	bh=BL4mdT3PrGBtb3/SFQL2jD7FRK8O1qchsF7KKukY9XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvMd4y4RA/rH/vBz2NPE24B+63jpq3mXdRvGp9SqOHHXWwIfAg4hSDnkNt+OD6ZKq
	 pCptueeS6OZeAkYaSoncsrNvJ8u0plrtK6kraivJUi5keG1qYYi/P/xx5bn/8eXvyR
	 bgAQnt/NEdrcBNe00v1fxZOl+2HxbH5n+TZCNwJsnoaiTpOQfOISq63SRXLeKMHbBf
	 /vVfgT1d1jJXYQdyNlQC/h5GtV9dYKqK2UcWJzRp9BDOpR/QokzyRzRDiPSc18bbIE
	 R3OMtJbRFhCw1LqhPxL3Zk6wo9iAW4YEBIzOnXGqiXThDpUxRj79ndz30ijP5ExInM
	 Rt85QuqDsa5Yw==
Date: Wed, 9 Jul 2025 12:52:28 +0100
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
Message-ID: <20250709115228.GY452973@horms.kernel.org>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
 <20250406140706.812425-3-y.oudjana@protonmail.com>
 <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com>
 <aMbAZigHiAN2xupOYs9DodY2mOdNtw_oVjOaweflgA8IoXRQ5ctoZ8GYJ8PNAKDgL4f9N_UD7tFmkePUy9BCE8v20Mae2x-eL1ZpyJEdLZY=@protonmail.com>
 <20250707170636.GR89747@horms.kernel.org>
 <X2KJB3xtnC-pWM7o5TBw6ln3ItpMwn7tdn5Z8gpZY3oW31isE8PLTX5GUbJ6HcZk_9s72jb6ImwGL-anIoto4dK1MINTxzdRKfbejp_nXcA=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X2KJB3xtnC-pWM7o5TBw6ln3ItpMwn7tdn5Z8gpZY3oW31isE8PLTX5GUbJ6HcZk_9s72jb6ImwGL-anIoto4dK1MINTxzdRKfbejp_nXcA=@protonmail.com>

On Wed, Jul 09, 2025 at 07:44:49AM +0000, Yassine Oudjana wrote:
> 
> 
> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Monday, July 7th, 2025 at 6:06 PM, Simon Horman <horms@kernel.org> wrote:
> 
> > On Sat, Jul 05, 2025 at 06:29:39PM +0000, Yassine Oudjana wrote:
> > 
> > > On Wednesday, April 9th, 2025 at 3:54 PM, Konrad Dybcio konrad.dybcio@oss.qualcomm.com wrote:
> > > 
> > > > On 4/6/25 4:07 PM, Yassine Oudjana wrote:
> > 
> > 
> > ...
> > 
> > > > > diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrtr.h
> > > > > index 4d7f25c64c56..10c89a35cbb9 100644
> > > > > --- a/include/linux/soc/qcom/qrtr.h
> > > > > +++ b/include/linux/soc/qcom/qrtr.h
> > > > > @@ -13,6 +13,8 @@ struct qrtr_device {
> > > > > 
> > > > > #define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> > > > > 
> > > > > +#define QRTR_INSTANCE(qmi_version, qmi_instance) (qmi_version | qmi_instance << 8)
> > > > 
> > > > Please use FIELD_PREP + GENMASK to avoid potential overflows
> > > > 
> > > > Konrad
> > > 
> > > Since I'm using this macro in initializing QRTR match tables I am unable to use
> > > FIELD_PREP. When I do, I get such errors:
> > 
> > 
> > Does using FIELD_PREP_CONST, say in a QRTR_INSTANCE_CONST variant, help?
> 
> That works, but do we want to have two variants? Or in this case maybe
> I should leave qmi_interface.c untouched and define the macro only for use
> in match tables?

FWIIW, my order of preference would be:

1. Two variants, declared next to each other
2. One variant (using FIELD_PREP_CONST)
3. Leave qmi_interface.c untouched

...

