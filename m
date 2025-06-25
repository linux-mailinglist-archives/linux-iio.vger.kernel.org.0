Return-Path: <linux-iio+bounces-20955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98312AE7BAA
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F773AA370
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AD281357;
	Wed, 25 Jun 2025 09:11:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FE27281C
	for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842691; cv=none; b=rhdsNgldYkjQG5gYpilAqzBLS2MGItoi/48n61p/WhOPRsmQRxw90XN4wGuNbh64hJ0xJGXHynmhtSFFPO+zI2P11ANxhMsYCPq0U9dPHA9TOS4BhmMxyTfp6LuZObybg0DNHH20UTv+R7wzl96GsPgkhxg6WyuQk946LIviwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842691; c=relaxed/simple;
	bh=d3B5Xx/M3UsmL29fcuhJf9yshEUi89TKqRTjtbr8PwY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr5Su0CXZtluEYOKK+/2trRMNQm6//W3UzQmFtq/7nAZ2mSAwepO9Fu4xCAQD9bcBecKIFbrJVzRYp3BE4+ohjT6czAho/XVgInBHEDQQnFbsWAumqByfDrZZ6bPvw0DlcbgQoDDOypNVHp7fSNSHq5x8VVUB4nDvOJYHShMQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRwwc69c1z6GDDF;
	Wed, 25 Jun 2025 17:08:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EEE0140446;
	Wed, 25 Jun 2025 17:11:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 11:11:20 +0200
Date: Wed, 25 Jun 2025 10:11:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?C=E9sar?= Bispo <dm.cesaraugusto@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "=?ISO-8859-1?Q?C=E9sar?=
 Bispo" <cesar.bispo@ime.usp.br>, Gabriel Ferreira
	<gabrielfsouza.araujo@usp.br>
Subject: Re: [PATCH v1] iio: adc: Use devm_iio_device_register() and
 dev_err_probe()
Message-ID: <20250625101119.00003c34@huawei.com>
In-Reply-To: <20250625023402.86861-1-cesar.bispo@ime.usp.br>
References: <20250625023402.86861-1-cesar.bispo@ime.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 23:33:51 -0300
"C=E9sar Bispo" <dm.cesaraugusto@gmail.com> wrote:

> Replace iio_device_register() with devm_iio_device_register() to let the
> core handle cleanup automatically. This simplifies the driver and avoids
> manual error paths.
>=20
> Also use dev_err_probe() for improved error handling and cleaner logs
> when deferrals happen.
>=20
Hi. Always include the driver name in the patch title so that people
can quickly see if they care about it not!

iio: adc: qcom-pm8xxx-xoadc: USe devm_iio_device_register() and dev_err_pro=
be()

> Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> Co-developed-by: Gabriel Ferreira <gabrielfsouza.araujo@usp.br>
> Signed-off-by: Gabriel Ferreira <gabrielfsouza.araujo@usp.br>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-p=
m8xxx-xoadc.c
> index 31f88cf7f7f1..447a924eca6d 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -934,20 +934,18 @@ static int pm8xxx_xoadc_probe(struct platform_devic=
e *pdev)
>  	indio_dev->channels =3D adc->iio_chans;
>  	indio_dev->num_channels =3D adc->nchans;
> =20
> -	ret =3D iio_device_register(indio_dev);
> +	ret =3D devm_iio_device_register(dev, indio_dev);
Look at how devm works before considering any such changes.
This change creates a race where you have turned the
power off before removing the userspace interfaces which is a very bad idea.

>  	if (ret)
> -		goto out_disable_vref;
> +		return dev_err_probe(dev, ret, "Unable to register %s\n", indio_dev->n=
ame);
> =20
>  	ret =3D pm8xxx_calibrate_device(adc);
>  	if (ret)
> -		goto out_unreg_device;
> +		return ret;
> =20
>  	dev_info(dev, "%s XOADC driver enabled\n", variant->name);
> =20
>  	return 0;
> =20
> -out_unreg_device:
> -	iio_device_unregister(indio_dev);
>  out_disable_vref:
>  	regulator_disable(adc->vref);
> =20


