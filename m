Return-Path: <linux-iio+bounces-11502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E008C9B3749
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970BB1F22136
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B71DF25A;
	Mon, 28 Oct 2024 17:04:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF713AD11;
	Mon, 28 Oct 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135070; cv=none; b=T8I24kD583kREFU+4KylQUEIzBP0YKYVjW4xSLp0jizPj+9lll9JZLsm0K8MHni7O5qqAdD7IffyR7Awj3okGi2GubsufmrTeZxbg/whqCN7FkjQselCsYrNm1DPIbIGYot9D7KEWr62FHL9xQf/7UpHo9kJ2tPCVQsuDdyWOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135070; c=relaxed/simple;
	bh=OuicQiwNtfy0YQk4X+DKdY/poDmSmOjj+bNq/lZa4+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+30A+ubUx0NVZBZmRySIiU/RnKJgEmJzDiyTeYQzI+g1yJ9MvuFL7VO+gQkFpbJf6pjVpea3ddgOfxUqa9/mwUkgGKnRjxTcdHqe+7ut3r4JmS8/lF7cnpUH3V670GEa747VIzKIlugTjmGY3cj6N/HYgT/w5NnmQ6H6TohFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcfkc6QzCz6LDYk;
	Tue, 29 Oct 2024 00:59:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 55B8B1404FC;
	Tue, 29 Oct 2024 01:04:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 18:04:24 +0100
Date: Mon, 28 Oct 2024 17:04:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
	<ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, "Michael Hennerich"
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jagath Jog J
	<jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 2/5] iio: imu: adis: Add DIAG_STAT register size
Message-ID: <20241028170422.00001865@Huawei.com>
In-Reply-To: <20241028122543.8078-3-robert.budai@analog.com>
References: <20241028122543.8078-1-robert.budai@analog.com>
	<20241028122543.8078-3-robert.budai@analog.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:25:34 +0200
Robert Budai <robert.budai@analog.com> wrote:

> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Some devices may have more than 16 bits of status. This patch allows the
> user to specify the size of the DIAG_STAT register. It defaults to 2 if
> not specified. This is mainly for backward compatibility.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
I'd rather we didn't use a default for this one.
The value 2 isn't obvious.  So just update all existing cases
in this patch and drop the check on whether it is set.

Again, remember to add your SoB on this.

One other minor comment inline.

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 12 +++++++++---
>  include/linux/iio/imu/adis.h |  3 +++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 504d18a36f90..f03f35c94f76 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -304,11 +304,17 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
>   */
>  int __adis_check_status(struct adis *adis)
>  {
> -	u16 status;
> +	unsigned int status =3D 0;
>  	int ret;
>  	int i;
> +	/* default to 2 bytes */
> +	unsigned int reg_size =3D 2;
> =20
> -	ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> +	if (adis->data->diag_stat_size)
> +		reg_size =3D adis->data->diag_stat_size;
> +
> +	ret =3D adis->ops->read(adis, adis->data->diag_stat_reg, &status,
> +			      reg_size);
>  	if (ret)
>  		return ret;
> =20
> @@ -317,7 +323,7 @@ int __adis_check_status(struct adis *adis)
>  	if (status =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < 16; ++i) {
> +	for (i =3D 0; i < (reg_size * 8); ++i) {
BITS_PER_BYTE instead of 8 and no need for the brackets around (reg_size * =
BITS_PER_BYTE)

>  		if (status & BIT(i)) {
>  			dev_err(&adis->spi->dev, "%s.\n",
>  				adis->data->status_error_msgs[i]);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 7b589cc83380..fae31042a622 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -44,6 +44,8 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @diag_stat_size: Length (in bytes) of the DIAG_STAT register.
> + *		    Defaults to 2 if not set.
>   * @prod_id_reg: Register address of the PROD_ID register
>   * @prod_id: Product ID code that should be expected when reading @prod_=
id_reg
>   * @self_test_mask: Bitmask of supported self-test operations
> @@ -70,6 +72,7 @@ struct adis_data {
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;
>  	unsigned int diag_stat_reg;
> +	unsigned int diag_stat_size;
>  	unsigned int prod_id_reg;
> =20
>  	unsigned int prod_id;


