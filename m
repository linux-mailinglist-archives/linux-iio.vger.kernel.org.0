Return-Path: <linux-iio+bounces-17681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27FAA7CEDB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA547A497E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206022155B;
	Sun,  6 Apr 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu0S56rn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1C14A82;
	Sun,  6 Apr 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743955284; cv=none; b=N8zW9IkzSBO5DlBpaiKTuWAvnzhS3rEF3dIrHn0f2uY+wvx5/bBlNMB53pZ10schVzEFP+UAL10wiu0XVwsA8Bd/OiUHYtqMPoVnDdh2w7wISdUik7txlQIwad7DoBG+kb0z+d/X+3icXLtUiwGTGtZQ3ZTFDJhEFuaGy4ZDoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743955284; c=relaxed/simple;
	bh=xiYT3OXSwrXnf48Kqo+AeUKLe4LHpkaxA4SGgwPbfk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=penBVpV9AmIOq3Q2UE/JTSyla2J9jrzS6Q/zpR/7x69CsiILryKfGNe4OxlyhpctSExEl4Me738ep9gT0YRliV7E3KYXBtnrlJoOaZ3nkMtI+86ovtZNbnKUyGpOgwyPqmCrOkDbROfEIKhV+4qIvweM3pCbm0F1QUq7RDHYPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu0S56rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32215C4CEE3;
	Sun,  6 Apr 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743955283;
	bh=xiYT3OXSwrXnf48Kqo+AeUKLe4LHpkaxA4SGgwPbfk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nu0S56rnZGLVOf5sZzzAgHErmGBZT2nk1Mm6ebz9+qcFK9VLpELK9y799JB9UvAES
	 Y46/AcM32/K48BBaEPK/htz4p4rCoX8tvuGt48J+DVSxdzU+yfh9HPT9xCpBEdh4ES
	 M9mN8uDJ6i16NTFmA5Htwd1EYhJk0wbOHAWHpL4r19clnsyiRDlGnFMEr988ldQolG
	 y+EQNvgn9sXsY1F3VaU3rX/chASZ9ay9vIe2wIqK+W/ESxDrv6LV4J6J89DhD8AAFU
	 kYGCMQdDPNMAZ8kyzVd0uCCLtPyTh2OI4wkHGazx8iykI/76pP6K7Ex9cC31AuM7N/
	 fD7hkehpT/MSg==
Date: Sun, 6 Apr 2025 17:01:11 +0100
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
Message-ID: <20250406170111.7a11437a@jic23-huawei>
In-Reply-To: <20250406140706.812425-2-y.oudjana@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
	<20250406140706.812425-2-y.oudjana@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Apr 2025 14:07:43 +0000
Yassine Oudjana <y.oudjana@protonmail.com> wrote:

> Implement a QRTR bus to allow for creating drivers for individual QRTR
> services. With this in place, devices are dynamically registered for QRTR
> services as they become available, and drivers for these devices are
> matched using service and instance IDs.
> 
> In smd.c, replace all current occurences of qdev with qsdev in order to
> distinguish between the newly added QRTR device which represents a QRTR
> service with the existing QRTR SMD device which represents the endpoint
> through which services are provided.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Hi Yassine

Just took a quick look through.

It might make more sense to do this with an auxiliary_bus rather
than defining a new bus.

I'd also split out the renames as a precursor patch.

Various other comments inline.

Jonathan

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index 00c51cf693f3..e11682fd7960 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -435,6 +435,7 @@ static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
>  int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  {
>  	struct qrtr_node *node = ep->node;
> +	const struct qrtr_ctrl_pkt *pkt;
>  	const struct qrtr_hdr_v1 *v1;
>  	const struct qrtr_hdr_v2 *v2;
>  	struct qrtr_sock *ipc;
> @@ -443,6 +444,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  	size_t size;
>  	unsigned int ver;
>  	size_t hdrlen;
> +	int ret = 0;
>  
>  	if (len == 0 || len & 3)
>  		return -EINVAL;
> @@ -516,12 +518,24 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  
>  	qrtr_node_assign(node, cb->src_node);
>  
> +	pkt = data + hdrlen;
> +
>  	if (cb->type == QRTR_TYPE_NEW_SERVER) {
>  		/* Remote node endpoint can bridge other distant nodes */
> -		const struct qrtr_ctrl_pkt *pkt;
> -
> -		pkt = data + hdrlen;
>  		qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
> +
> +		/* Create a QRTR device */
> +		ret = ep->add_device(ep, le32_to_cpu(pkt->server.node),
> +					       le32_to_cpu(pkt->server.port),
> +					       le32_to_cpu(pkt->server.service),
> +					       le32_to_cpu(pkt->server.instance));
> +		if (ret)
> +			goto err;
> +	} else if (cb->type == QRTR_TYPE_DEL_SERVER) {
> +		/* Remove QRTR device corresponding to service */
> +		ret = ep->del_device(ep, le32_to_cpu(pkt->server.port));
> +		if (ret)
> +			goto err;
>  	}
>  
>  	if (cb->type == QRTR_TYPE_RESUME_TX) {
> @@ -543,8 +557,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  
>  err:
>  	kfree_skb(skb);
> -	return -EINVAL;
> -
> +	return ret ? ret : -EINVAL;
How do we get here with non error value given we couldn't before?


>  }
>  EXPORT_SYMBOL_GPL(qrtr_endpoint_post);
>  

> diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
> index c91bf030fbc7..fd5ad6a8d1c3 100644
> --- a/net/qrtr/smd.c
> +++ b/net/qrtr/smd.c
> @@ -7,6 +7,7 @@

> +
> +static int qcom_smd_qrtr_uevent(const struct device *dev, struct kobj_uevent_env *env)
> +{
> +	const struct qrtr_device *qdev = to_qrtr_device(dev);
> +
> +	return add_uevent_var(env, "MODALIAS=%s%x:%x", QRTR_MODULE_PREFIX, qdev->service,
> +			      qdev->instance);
> +}


> +void qrtr_driver_unregister(struct qrtr_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(qrtr_driver_unregister);

Given this is a 'new thing' maybe namespace it from the start?
EXPORT_SYMBOL_NS_GPL();


> +
> +static int qcom_smd_qrtr_match_device_by_port(struct device *dev, const void *data)
> +{
> +	struct qrtr_device *qdev = to_qrtr_device(dev);
> +	unsigned int port = *(unsigned int *)data;
	unsinged int *port = data;
	
	return qdev->port == *port;

> +
> +	return qdev->port == port;
> +}
> +
> +static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
> +{
> +	struct qrtr_new_server *new_server = container_of(work, struct qrtr_new_server, work);
> +	struct qrtr_smd_dev *qsdev = new_server->parent;
> +	struct qrtr_device *qdev;
> +	int ret;
> +
> +	qdev = kzalloc(sizeof(*qdev), GFP_KERNEL);
> +	if (!qdev)
> +		return;
> +
Maybe 
	*qdev = (struct qrtr_device *) {
	};
and free new_server after all of these are filled in.
	
> +	qdev->node = new_server->node;
> +	qdev->port = new_server->port;
> +	qdev->service = new_server->service;
> +	qdev->instance = new_server->instance;
> +
> +	devm_kfree(qsdev->dev, new_server);

As below.

> +
> +	dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);
> +
> +	qdev->dev.bus = &qrtr_bus;
> +	qdev->dev.parent = qsdev->dev;
> +	qdev->dev.release = qcom_smd_qrtr_dev_release;
> +	qdev->dev.driver = NULL;

it's kzalloc'd so no need to set this.

> +
> +	ret = device_register(&qdev->dev);
> +	if (ret) {
> +		dev_err(qsdev->dev, "Failed to register QRTR device: %pe\n", ERR_PTR(ret));
> +		put_device(&qdev->dev);
> +	}
> +}
> +
> +static void qcom_smd_qrtr_del_device_worker(struct work_struct *work)
> +{
> +	struct qrtr_del_server *del_server = container_of(work, struct qrtr_del_server, work);
> +	struct qrtr_smd_dev *qsdev = del_server->parent;
> +	struct device *dev = device_find_child(qsdev->dev, &del_server->port,
> +					       qcom_smd_qrtr_match_device_by_port);
> +
> +	devm_kfree(qsdev->dev, del_server);
If we are always going to free what was alocated in qcom_smd_qrtr_del_device()
why use devm at all?  
> +
> +	if (dev)
> +		device_unregister(dev);
If this doesn't match anything I'm guessing it's a bug?   So maybe an error message?

> +}
> +
> +static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsigned int node,
> +				    unsigned int port, u16 service, u16 instance)
> +{
> +	struct qrtr_smd_dev *qsdev = container_of(parent, struct qrtr_smd_dev, ep);
> +	struct qrtr_new_server *new_server;
> +
> +	new_server = devm_kzalloc(qsdev->dev, sizeof(struct qrtr_new_server), GFP_KERNEL);

As below. sizeof(*new_server)

> +	if (!new_server)
> +		return -ENOMEM;
> +
	*new_server = (struct qtr_new_server) {
		.parent = qsdev,
		.ndoe = node,
...
	};

perhaps a tiny bit easier to read?

> +	new_server->parent = qsdev;
> +	new_server->node = node;
> +	new_server->port = port;
> +	new_server->service = service;
> +	new_server->instance = instance;
> +
> +	INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
> +	schedule_work(&new_server->work);
> +
> +	return 0;
> +}
> +
> +static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsigned int port)
> +{
> +	struct qrtr_smd_dev *qsdev = container_of(parent, struct qrtr_smd_dev, ep);
> +	struct qrtr_del_server *del_server;
> +
> +	del_server = devm_kzalloc(qsdev->dev, sizeof(struct qrtr_del_server), GFP_KERNEL);

sizeof(*del_server)
preferred as then no one has to check types match.

> +	if (!del_server)
> +		return -ENOMEM;
> +
> +	del_server->parent = qsdev;
> +	del_server->port = port;
> +
> +	INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
> +	schedule_work(&del_server->work);
> +
> +	return 0;
> +}
> +
> +static int qcom_smd_qrtr_device_unregister(struct device *dev, void *data)
> +{
> +	device_unregister(dev);

One option that may simplify this is to do the device_unregister() handling
a devm_action_or_reset() handler that is using the parent device as it's dev
but unregistering the children.  That way the unregister is called in the
reverse order of setup and you only register a handler for those devices
registered (rather walking children).  I did this in the CXL pmu driver
for instance.

> +
> +	return 0;
> +}
> +

> @@ -82,9 +276,11 @@ static int qcom_smd_qrtr_probe(struct rpmsg_device *rpdev)
>  
>  static void qcom_smd_qrtr_remove(struct rpmsg_device *rpdev)
>  {
> -	struct qrtr_smd_dev *qdev = dev_get_drvdata(&rpdev->dev);
> +	struct qrtr_smd_dev *qsdev = dev_get_drvdata(&rpdev->dev);

May be worth doing the rename in a precursor patch to simplify a little what is
in this one.

> +
> +	device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unregister);
>  
> -	qrtr_endpoint_unregister(&qdev->ep);
> +	qrtr_endpoint_unregister(&qsdev->ep);
>  
>  	dev_set_drvdata(&rpdev->dev, NULL);
>  }
> @@ -104,7 +300,27 @@ static struct rpmsg_driver qcom_smd_qrtr_driver = {
>  	},
>  };
>  
> -module_rpmsg_driver(qcom_smd_qrtr_driver);
> +static int __init qcom_smd_qrtr_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&qrtr_bus);
> +	if (!ret)
> +		ret = register_rpmsg_driver(&qcom_smd_qrtr_driver);
This style tends to extend badly. Go with more conventional errors
out of line style.

	if (ret)
		return ret;

	ret = register_rpmsg_driver(&qcom_smd_qrtr_driver);
	if (ret) {
		bus_unregister(&qtr_bus);
		return ret;		
	}

	return 0;

> +	else
> +		bus_unregister(&qrtr_bus);
> +
> +	return ret;
> +}
> +
> +static void __exit qcom_smd_qrtr_exit(void)
> +{
> +	bus_unregister(&qrtr_bus);

Order should be the reverse of what happened in probe so swap these round.

> +	unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
> +}
> +
> +subsys_initcall(qcom_smd_qrtr_init);
> +module_exit(qcom_smd_qrtr_exit);
>  
>  MODULE_ALIAS("rpmsg:IPCRTR");
>  MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
>

