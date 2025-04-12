Return-Path: <linux-iio+bounces-17998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC2A86CAD
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C8C1B6039E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0B1D89E3;
	Sat, 12 Apr 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT/VsOF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BF1A5B91;
	Sat, 12 Apr 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744455516; cv=none; b=UcWq73Sp+AskzsGEa3gJoNi2r/7nrC4MUmIQuGcUq0yUDFkWPl417+P2ynVmEOxuR08MT/m6N9631uHyzDwHm3xGCNbUVh/g1R8Ohw1JFnPuGEjNBQeZCBqT3hZ9th2F/Xgl5bAOSGOar5xh32QmnyKFlvtKRbZuIvWTqQRwUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744455516; c=relaxed/simple;
	bh=v1schcvx/waqBZ5un5XqVAQVNS19s1oAx1ITFiQcrpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAAUceAC2ULRQ/06D2qTrV/DjoNhJ616v6gMtxEOHQDVYERGBKV661PLY5/6MrDWo0YC390UY3lOwZsUZdKnFeoam3xbMJMAVplOzaCD5muqWeOXFvPgznhzpvgFn5qFMk/G59MLCHxYJ8iKgDWV2juwVdoVoqol2lYu8VJnhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT/VsOF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1102CC4CEE3;
	Sat, 12 Apr 2025 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744455516;
	bh=v1schcvx/waqBZ5un5XqVAQVNS19s1oAx1ITFiQcrpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pT/VsOF5b+4t5DIlcEnuLMdNtbl7VP9O+54QQsU9sdRQVz/CT15xo4WkXVJbUsHpY
	 thgH0oJNZOA12yp7RyUWEVgKR+s3BW+E+6AahjBthYf7EOpxYj3XdhA7UMxkyKEY2T
	 TcX8SBCYPrYUwPpat/DuqWXfmrd8n1nHDcfU/zMbC/OXPJhLnkA9aKQJHaMttgMe27
	 PM6T+Cv9VCeX5UcQf698EfS4S44EXmh+IzvzTH6LLBCtyz6LCuSmN1Uuy4Ssj8uCCu
	 VCIqIn/3olCUDrItzMQcmUMAbil4kjtOougBPv0pXZalmWYJ08F2qvsZJOFZ0dHLsO
	 PvdTgqSSMGXNA==
Date: Sat, 12 Apr 2025 11:58:21 +0100
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
Message-ID: <20250412115821.72f35c07@jic23-huawei>
In-Reply-To: <02aeebee-0acc-4a03-a7f1-a920a34fb378@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
	<20250406140706.812425-2-y.oudjana@protonmail.com>
	<20250406170111.7a11437a@jic23-huawei>
	<02aeebee-0acc-4a03-a7f1-a920a34fb378@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 12:10:54 +0000
Yassine Oudjana <y.oudjana@protonmail.com> wrote:

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
> > 
> > I'd also split out the renames as a precursor patch.
> > 
> > Various other comments inline.
> > 
> > Jonathan
> >   
> >> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> >> index 00c51cf693f3..e11682fd7960 100644
> >> --- a/net/qrtr/af_qrtr.c
> >> +++ b/net/qrtr/af_qrtr.c
> >> @@ -435,6 +435,7 @@ static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
> >>   int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
> >>   {
> >>   	struct qrtr_node *node = ep->node;
> >> +	const struct qrtr_ctrl_pkt *pkt;
> >>   	const struct qrtr_hdr_v1 *v1;
> >>   	const struct qrtr_hdr_v2 *v2;
> >>   	struct qrtr_sock *ipc;
> >> @@ -443,6 +444,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
> >>   	size_t size;
> >>   	unsigned int ver;
> >>   	size_t hdrlen;
> >> +	int ret = 0;
> >>
> >>   	if (len == 0 || len & 3)
> >>   		return -EINVAL;
> >> @@ -516,12 +518,24 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
> >>
> >>   	qrtr_node_assign(node, cb->src_node);
> >>
> >> +	pkt = data + hdrlen;
> >> +
> >>   	if (cb->type == QRTR_TYPE_NEW_SERVER) {
> >>   		/* Remote node endpoint can bridge other distant nodes */
> >> -		const struct qrtr_ctrl_pkt *pkt;
> >> -
> >> -		pkt = data + hdrlen;
> >>   		qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
> >> +
> >> +		/* Create a QRTR device */
> >> +		ret = ep->add_device(ep, le32_to_cpu(pkt->server.node),
> >> +					       le32_to_cpu(pkt->server.port),
> >> +					       le32_to_cpu(pkt->server.service),
> >> +					       le32_to_cpu(pkt->server.instance));
> >> +		if (ret)
> >> +			goto err;
> >> +	} else if (cb->type == QRTR_TYPE_DEL_SERVER) {
> >> +		/* Remove QRTR device corresponding to service */
> >> +		ret = ep->del_device(ep, le32_to_cpu(pkt->server.port));
> >> +		if (ret)
> >> +			goto err;
> >>   	}
> >>
> >>   	if (cb->type == QRTR_TYPE_RESUME_TX) {
> >> @@ -543,8 +557,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
> >>
> >>   err:
> >>   	kfree_skb(skb);
> >> -	return -EINVAL;
> >> -
> >> +	return ret ? ret : -EINVAL;  
> > How do we get here with non error value given we couldn't before?  
> 
> We don't, but we may have errors in ret other than -EINVAL returned by 
> the newly added add_device and del_device which we should propagate.

Ah. Got it (I misread that!).  Personally I'd go for setting ret in the
other error paths explicitly to -EINVAL.  Mixing two styles of handling
where you have some paths setting ret and some not is rather confusing to read.




> >> +
> >> +	return qdev->port == port;
> >> +}
> >> +
> >> +static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
> >> +{
> >> +	struct qrtr_new_server *new_server = container_of(work, struct qrtr_new_server, work);
> >> +	struct qrtr_smd_dev *qsdev = new_server->parent;
> >> +	struct qrtr_device *qdev;
> >> +	int ret;
> >> +
> >> +	qdev = kzalloc(sizeof(*qdev), GFP_KERNEL);
> >> +	if (!qdev)
> >> +		return;
> >> +  
> > Maybe
> > 	*qdev = (struct qrtr_device *) {
> > 	};  
> 
> (struct qrtr_device)

oops. Indeed that!


Jonathan

