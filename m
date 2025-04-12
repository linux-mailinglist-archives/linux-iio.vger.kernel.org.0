Return-Path: <linux-iio+bounces-17999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D5DA86CB2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07629A0B58
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8291DA61B;
	Sat, 12 Apr 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttjREQTT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D119E7ED;
	Sat, 12 Apr 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744455599; cv=none; b=f8YXW1luBQ/U2zcgWO6xdZ5bYWVucuMfHP7z98AbIlmnc/1QcwH7qYwOJN0ChJYPah+TqsDZKr5MaCW4cb9KGU+x3zTZYKNQgDEZVT38B6R+qJQEhm3zPbGVrmMWIsnPuA38wdnjlR92KVFPhEm6kO7j9K8n2w06fiRiroKx9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744455599; c=relaxed/simple;
	bh=EFgXr0bMbTaSoQfTQqzJfgugYO9JjK/1RtgWK8K5BSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAxR9cgTKPY6byeVXm+VCBtoBmrBRI5k8G2tUwaCb7z0gm903VZfaVECNfF58wA3MioNOtr25m5xTBrZ8IrjjL45qpT+9lT6WMpHiq1cCxT73fQRL0LbOyzkW5bJE1qlpC9bpp8FROcEGiITjYjhkWNyLZqQUs/1XnNZn49NBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttjREQTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D164C4CEE3;
	Sat, 12 Apr 2025 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744455598;
	bh=EFgXr0bMbTaSoQfTQqzJfgugYO9JjK/1RtgWK8K5BSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttjREQTTBtbr6GDE1ykBUGbLT7TViaFRw9FvHMpMJkRfYr8HYJBqNgh4R9yqxbnbq
	 ZT0w5o11RUu7nB+I+JL83VxyIz8JE+R7afK4PtA+3dGNsJUJ7x/xie0rtjZWzfNPBD
	 s16YnpvfJrLjSbgE8Lb2cZZTHpp50/KeO+sWl+IpziRo/oSRa32ltu9EvbLwLIA9mV
	 dmsSkUJ7OfQweSRmBYz2sg4AUGe/qIbGVaSYse/gu49uW10rDQFpq9BH3hgh3oJj6J
	 NMd4FzsIOnbanb5Ux/tSe3pu3hcE6qIqJ+Zw5B6hZSA7K2kdjfRJY+yhCcEBpwe2O8
	 VwyGgOzn9Da8w==
Date: Sat, 12 Apr 2025 11:59:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer
 <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie
 wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/3] net: qrtr: Turn QRTR into a bus
Message-ID: <20250412115944.6528abcd@jic23-huawei>
In-Reply-To: <373f4699-4b3d-4fa4-8a75-9e71b9dccc5c@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
	<20250406140706.812425-2-y.oudjana@protonmail.com>
	<20250406170111.7a11437a@jic23-huawei>
	<373f4699-4b3d-4fa4-8a75-9e71b9dccc5c@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 12:44:25 +0000
Yassine Oudjana <y.oudjana@protonmail.com> wrote:

> Missed one comment so sending a second reply.
> 
> On 06/04/2025 7:01 pm, Jonathan Cameron wrote:
> > On Sun, 06 Apr 2025 14:07:43 +0000
> > Yassine Oudjana <y.oudjana@protonmail.com> wrote:
> >   
> >> Implement a QRTR bus to allow for creating drivers for individual QRTR
> >> services. With this in place, devices are dynamically registered for QRTR
> >> services as they become available, and drivers for these devices are
> >> matched using service and instance IDs.
> >>
> >> In smd.c, replace all current occurences of qdev with qsdev in order to
> >> distinguish between the newly added QRTR device which represents a QRTR
> >> service with the existing QRTR SMD device which represents the endpoint
> >> through which services are provided.
> >>
> >> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>  
> > Hi Yassine
> > 
> > Just took a quick look through.
> > 
> > It might make more sense to do this with an auxiliary_bus rather
> > than defining a new bus.  
> 
> I'm not familiar with auxiliary bus, but reading the documentation it 
> seems to me like it's used like MFD where there is a device that has 
> multiple functions, just without the subdevices having physical 
> addresses. QRTR is not really a device but more closely resembles 
> something like PCI or I2C as a communication interface.

Fair enough. If this has real bus like properties then it may make
sense to go with a new explicit bus.

Jonathan



