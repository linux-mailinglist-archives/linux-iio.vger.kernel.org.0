Return-Path: <linux-iio+bounces-21873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285FB0DDF6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32511AC3FA5
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292802ECEA2;
	Tue, 22 Jul 2025 14:09:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C22ECE94;
	Tue, 22 Jul 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193381; cv=none; b=bX4IX3MOQD7+feUjTAQJAhJ87D1/wn6S0tYxtuMFOjbp4/IewuWCOOKdQHWFqauWa11ly2VXHYuyeKLQ2l/Bat3WiT++mf31yESZ3Du+qn30jpFYiC8A7T5z8U06B/DdmyJ/w0kOxM3/AcUN7jqpUsaiAx+/pXsw8kZllbLFJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193381; c=relaxed/simple;
	bh=PQbJ9nekolxPAktW5mDMSSTldp2ptas8ZeWIr2Slddk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNWwjMDhXhj+EtA4ugYjQMd9yvxyDIaiJ/da8b1CT1FovFRkZMtCOVmp9pRqiYkLh1MW83/iDHFLkQr7DfLlKwN97mQhmISU+oyYOLWNGUxpPmVtLBB84dFvaLGLcNByBebl0sLaNgrEg83hi6TZ5wunjHwaFSzTGam5qxzYWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmfHZ0kkCz6H7XD;
	Tue, 22 Jul 2025 22:08:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 17F4B140446;
	Tue, 22 Jul 2025 22:09:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 16:09:32 +0200
Date: Tue, 22 Jul 2025 15:09:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <sboyd@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <srini@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <sre@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<u.kleine-koenig@baylibre.com>, <linux-arm-msm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<kernel@collabora.com>, <wenst@chromium.org>, <casey.connolly@linaro.org>
Subject: Re: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <20250722150930.00000a2f@huawei.com>
In-Reply-To: <20250722101317.76729-2-angelogioacchino.delregno@collabora.com>
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
	<20250722101317.76729-2-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Jul 2025 12:13:11 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Some devices connected over the SPMI bus may be big, in the sense
> that those may be a complex of devices managed by a single chip
> over the SPMI bus, reachable through a single SID.
> 
> Add new functions aimed at managing sub-devices of a SPMI device
> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
> for adding a new subdevice and removing it respectively, and also
> add their devm_* variants.
> 
> The need for such functions comes from the existance of	those
> complex Power Management ICs (PMICs), which feature one or many
> sub-devices, in some cases with these being even addressable on
> the chip in form of SPMI register ranges.
> 
> Examples of those devices can be found in both Qualcomm platforms
> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
> sub-devices, and in newer MediaTek platforms showing similar HW
> features and a similar layout with those also having many subdevs.
> 
> Also, instead of generally exporting symbols, export them with a
> new "SPMI" namespace: all users will have to import this namespace
> to make use of the newly introduced exports.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/spmi/spmi-devres.c | 23 +++++++++++
>  drivers/spmi/spmi.c        | 83 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spmi.h       | 16 ++++++++
>  3 files changed, 122 insertions(+)
> 
> diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
> index 62c4b3f24d06..7e00e38be2ff 100644
> --- a/drivers/spmi/spmi-devres.c
> +++ b/drivers/spmi/spmi-devres.c
> @@ -60,5 +60,28 @@ int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl
>  }
>  EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
>  
> +static void devm_spmi_subdevice_remove(void *res)
> +{
> +	spmi_subdevice_remove((struct spmi_subdevice *)res);

Why the cast?  Implicit casts are fine for void * to any other pointer type
so
	spmi_subdevice_remove(res);
should be fine.


> +}

>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("SPMI devres helpers");
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index 3cf8d9bd4566..62bb782b2bbc 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -19,6 +19,7 @@
>  
>  static bool is_registered;
>  static DEFINE_IDA(ctrl_ida);
> +static DEFINE_IDA(spmi_subdevice_ida);
>  
>  static void spmi_dev_release(struct device *dev)
>  {
> @@ -31,6 +32,18 @@ static const struct device_type spmi_dev_type = {
>  	.release	= spmi_dev_release,
>  };
>  
> +static void spmi_subdev_release(struct device *dev)
> +{
> +	struct spmi_device *sdev = to_spmi_device(dev);
> +	struct spmi_subdevice *sub_sdev = container_of(sdev, struct spmi_subdevice, sdev);
> +
> +	kfree(sub_sdev);
> +}
> +
> +static const struct device_type spmi_subdev_type = {
> +	.release	= spmi_subdev_release,
> +};
> +
>  static void spmi_ctrl_release(struct device *dev)
>  {
>  	struct spmi_controller *ctrl = to_spmi_controller(dev);
> @@ -90,6 +103,19 @@ void spmi_device_remove(struct spmi_device *sdev)
>  }
>  EXPORT_SYMBOL_GPL(spmi_device_remove);
>  
> +/**
> + * spmi_subdevice_remove() - Remove an SPMI subdevice
> + * @sub_sdev:	spmi_device to be removed
> + */
> +void spmi_subdevice_remove(struct spmi_subdevice *sub_sdev)
> +{
> +	struct spmi_device *sdev = &sub_sdev->sdev;
> +
> +	device_unregister(&sdev->dev);
> +	ida_free(&spmi_subdevice_ida, sub_sdev->devid);

Why not make the ida free part of the release? If not
the device_unregister could (I think) result in a reference
count drop and freeing of sub_sdev before you dereference it here.


> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_remove, "SPMI");
> +
>  static inline int
>  spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
>  {
> @@ -431,6 +457,63 @@ struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(spmi_device_alloc);
>  
> +/**
> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
> + * @sparent:	SPMI parent device with previously registered SPMI controller
> + *
> + * Returns:
> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
> + */
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sdev;
> +	int ret;
> +
> +	if (!sparent)
> +		return ERR_PTR(-EINVAL);

Is this protecting against a real possibility? Feels like something went
very wrong if you are allocating a subdevice of 'nothing'.
If it's just defensive programming I'd drop it.

> +
> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> +	if (!sub_sdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);

> +	if (ret < 0)
> +		goto err_ida_alloc;
> +
> +	sdev = &sub_sdev->sdev;
> +	sdev->ctrl = sparent->ctrl;
> +	device_initialize(&sdev->dev);

Read the device_initialize() documentation for what you need to do
if an error occurs after this point. Specifically the last 'NOTE'.


> +	sdev->dev.parent = &sparent->dev;
> +	sdev->dev.bus = &spmi_bus_type;
> +	sdev->dev.type = &spmi_subdev_type;
> +
> +	sub_sdev->devid = ret;
> +	sdev->usid = sparent->usid;
> +
> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> +	if (ret)
> +		goto err_set_name;
> +
> +	ret = device_add(&sdev->dev);
> +	if (ret) {
> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
> +			dev_name(&sdev->dev), ret);
> +		put_device(&sdev->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return sub_sdev;
> +
> +err_set_name:
> +	ida_free(&ctrl_ida, sub_sdev->devid);
> +err_ida_alloc:
> +	kfree(sub_sdev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
> +
>  /**
>   * spmi_controller_alloc() - Allocate a new SPMI controller
>   * @parent:	parent device
> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
> index 28e8c8bd3944..7cea0a5b034b 100644
> --- a/include/linux/spmi.h
> +++ b/include/linux/spmi.h
> @@ -69,6 +69,22 @@ int spmi_device_add(struct spmi_device *sdev);
>  
>  void spmi_device_remove(struct spmi_device *sdev);
>  
> +/**
> + * struct spmi_subdevice - Basic representation of an SPMI sub-device
> + * @sdev:	Sub-device representation of an SPMI device
> + * @devid:	Platform Device ID of an SPMI sub-device
> + */
> +struct spmi_subdevice {
> +	struct spmi_device	sdev;

Having something called a subdevice containing an instance of a device
does seem a little odd.  Maybe the spmi_device naming is inappropriate after
this patch?

> +	unsigned int		devid;
> +};
> +
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent);
> +void spmi_subdevice_remove(struct spmi_subdevice *sdev);
> +
> +struct spmi_subdevice *devm_spmi_subdevice_alloc_and_add(struct device *dev,
> +							 struct spmi_device *sparent);

