Return-Path: <linux-iio+bounces-5228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B083F8CD88D
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E715B22D81
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686181804A;
	Thu, 23 May 2024 16:39:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD21B7FD
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482376; cv=none; b=qQTjayrzY4arI7RguRNDQQkVuRsuEXzVvIjCdBCGn3JZkeB6UnBDMBSHo3Jl20h38VWhI3NCWsXjXS2c4wPC7SSzYhjoMgJep1pLoC7Hn8a4DkJMKviyeTJCq5MS5/trW7gI1s9LEyEsF4osanOjG7xG4JlIR2fYXGGjLanqOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482376; c=relaxed/simple;
	bh=D9B9S/sH+HsDt94B+0KR/l5B3PXiFYTkQz+sQjXfdlY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuIFWrfkZm3fPrn0JyXdo9aN1JkvPr2d5arSjxxqYFftpao48tE+G4BM8YbufZg1moaXdw5q9Z1O1rCo1NGkGpB35ib4dlyAXmvyntdxmBWDtomPHN5mC+9qU7IIbq1AAeVu5oxR2mdIsM79ZkNwmCME4wnoasRb1ZWOqJvj3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlYgr1qlkz6J6rK;
	Fri, 24 May 2024 00:35:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BDFC1400DB;
	Fri, 24 May 2024 00:39:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 17:39:31 +0100
Date: Thu, 23 May 2024 17:39:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?ISO-8859-1?Q?Vin=EDcius?= Lima <viniciusflima@usp.br>
CC: <marius.cristea@microchip.com>, <jic23@kernel.org>, Lucas Quaresma
	<lucasqml08@usp.br>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: mcp3564.c: Use
 device_for_each_child_node_scoped() to simplify error paths
Message-ID: <20240523173930.00005eb3@Huawei.com>
In-Reply-To: <20240523162437.3823-1-viniciusflima@usp.br>
References: <20240523162437.3823-1-viniciusflima@usp.br>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 13:24:35 -0300
Vin=EDcius Lima <viniciusflima@usp.br> wrote:

> From: Vin=EDcius Henrique Ferraz Lima <viniciusflima@usp.br>
>=20
> Use another method to automatically release the handle on early exit,
> reducing leaks.
>=20
> Co-developed-by: Lucas Quaresma <lucasqml08@usp.br>
> Signed-off-by: Lucas Quaresma <lucasqml08@usp.br>
> Signed-off-by: Vin=EDcius Lima <viniciusflima@usp.br>
> ---
>  drivers/iio/adc/mcp3564.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 311b613b6..52c864974 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *=
indio_dev)
>  	struct mcp3564_state *adc =3D iio_priv(indio_dev);
>  	struct device *dev =3D &adc->spi->dev;
>  	struct iio_chan_spec *channels;
> -	struct fwnode_handle *child;
>  	struct iio_chan_spec chanspec =3D mcp3564_channel_template;
>  	struct iio_chan_spec temp_chanspec =3D mcp3564_temp_channel_template;
>  	struct iio_chan_spec burnout_chanspec =3D mcp3564_burnout_channel_templ=
ate;
> @@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev=
 *indio_dev)
>  	if (!channels)
>  		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
> =20
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		node_name =3D fwnode_get_name(child);
> =20
>  		if (fwnode_property_present(child, "diff-channels")) {
> @@ -1041,13 +1040,11 @@ static int mcp3564_parse_fw_children(struct iio_d=
ev *indio_dev)
>  			inputs[1] =3D MCP3564_AGND;
>  		}
>  		if (ret) {
> -			fwnode_handle_put(child);

Drop the {} as well if there is only one statement left after removing
the fwnode_handle_put()=20

>  			return ret;
>  		}
> =20
>  		if (inputs[0] > MCP3564_INTERNAL_VCM ||
>  		    inputs[1] > MCP3564_INTERNAL_VCM) {
{} can go here as well,


Otherwise looks good.

Thanks,

Jonathan


> -			fwnode_handle_put(child);
>  			return dev_err_probe(&indio_dev->dev, -EINVAL,
>  					     "Channel index > %d, for %s\n",
>  					     MCP3564_INTERNAL_VCM + 1,


