Return-Path: <linux-iio+bounces-27227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF8CD0DD0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7979E30038D2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722A3930C6;
	Fri, 19 Dec 2025 16:21:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78273930C5
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161297; cv=none; b=IEe6pnPRulFRM493rwRNH92qJvfW1C4JxADTp9ZyJAXXhmHNWx84Eu1GP1NDVRwu6wkj827up0SfajoC8JKadCR9kQ6Tgu8lysFKv46LOeXr58+U+QyPTXlT+xscktfABXgxIg3ANWyNK3jvfC4A+b7cGStrR1CtHaAXJQa18kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161297; c=relaxed/simple;
	bh=oKpvRf15PKI/JexCOmdqnaIYBcrKocXGJ7JPTW/odUE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeKwSC8YTMepOgc+rR+OqJsW/4raxa+X5pHNO8mYGDmi43TDjvfQInHVl1fONW2xOtTCYMDOakLcSwKeQDA1QYK+E6DUpJwMOGYFh8ZoXGzHWIKrt/U5KoEcSH9iOE5ZjW+NszV1HAOqGVElSxg76gHxHqhSfQPBaMLaISJE+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXt7Z3XBzzJ46Zv;
	Sat, 20 Dec 2025 00:20:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 583B140086;
	Sat, 20 Dec 2025 00:21:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 16:21:30 +0000
Date: Fri, 19 Dec 2025 16:21:29 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= via B4 Relay
	<devnull+nuno.sa.analog.com@kernel.org>
CC: <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: dac: adi-axi-dac: Make use of dev_err_probe()
Message-ID: <20251219162129.00006aa9@huawei.com>
In-Reply-To: <20251219-iio-axi-dac-minor-changes-v2-1-e9fccc019b01@analog.com>
References: <20251219-iio-axi-dac-minor-changes-v2-1-e9fccc019b01@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 15:54:29 +0000
Nuno S=E1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Be consistent and use dev_err_probe() as in all other places in the
> .probe() path.
>=20
> While at it, remove the line break in the version condition. Yes, it
> goes over the 80 column limit but I do think the line break hurts
> readability in this case. And use a struct device *dev helper for
> neater code.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>

This has turned into a bit of an X and Y and Z patch.  In theory
should be split up but I guess it's not too bad.

However I'm not sure why you fixed one indent and left a bunch of similar
cases looking worse?

Jonathan

> ---
> Ended up dropping the dev_info() -> dev_dbg() patch.
> ---
> Changes in v2:
> - Patch 1
>   * Added helper struct device variable as suggested by Andy;
>   * Removed the braces as suggested by David.
> - Link to v1: https://lore.kernel.org/r/20251203-iio-axi-dac-minor-change=
s-v1-0-b54650cbeb33@analog.com
> ---
>  drivers/iio/dac/adi-axi-dac.c | 63 +++++++++++++++++++++----------------=
------
>  1 file changed, 30 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 0d525272a8a8..ceab9f6fa3b4 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c


>  	/* Let's get the core read only configuration */
>  	ret =3D regmap_read(st->regmap, AXI_DAC_CONFIG_REG, &st->reg_config);
> @@ -975,34 +972,34 @@ static int axi_dac_probe(struct platform_device *pd=
ev)
> =20
>  	mutex_init(&st->lock);
> =20
> -	ret =3D devm_iio_backend_register(&pdev->dev, st->info->backend_info, s=
t);
> +	ret =3D devm_iio_backend_register(dev, st->info->backend_info, st);
>  	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> +		return dev_err_probe(dev, ret,
>  				     "failed to register iio backend\n");
> =20
> -	device_for_each_child_node_scoped(&pdev->dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		int val;
> =20
>  		if (!st->info->has_child_nodes)
> -			return dev_err_probe(&pdev->dev, -EINVAL,
> +			return dev_err_probe(dev, -EINVAL,
>  					     "invalid fdt axi-dac compatible.");
> =20
>  		/* Processing only reg 0 node */
>  		ret =3D fwnode_property_read_u32(child, "reg", &val);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, ret,
> +			return dev_err_probe(dev, ret,
>  						"invalid reg property.");
>  		if (val !=3D 0)
> -			return dev_err_probe(&pdev->dev, -EINVAL,
> +			return dev_err_probe(dev, -EINVAL,
>  						"invalid node address.");
> =20
>  		ret =3D axi_dac_create_platform_device(st, child);
>  		if (ret)
> -			return dev_err_probe(&pdev->dev, -EINVAL,
> -						"cannot create device.");
> +			return dev_err_probe(dev, -EINVAL,
> +					     "cannot create device.");
I'm not against this fixing up the indent but why not the ones above htat l=
ook
just as bad?


>  	}
> =20
> -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> +	dev_info(dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
>  		 ADI_AXI_PCORE_VER_PATCH(ver));
>=20
> ---
> base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
> change-id: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
> --
>=20
> Thanks!
> - Nuno S=E1
>=20
>=20
>=20
>=20


