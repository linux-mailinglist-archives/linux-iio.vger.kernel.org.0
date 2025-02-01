Return-Path: <linux-iio+bounces-14817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424CA2499B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BB07A319C
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B661BD9D8;
	Sat,  1 Feb 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCPf99Z0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8417A90F;
	Sat,  1 Feb 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738421282; cv=none; b=J3T/IbC9slRXBYrXZh07/AnYFbAcWgJKQirgwx3Wk7jxCENE6LnboNNP4Z/V0G6gnh3cY43xJaqwgxEOrC2V40zUsTFLSgLPzBseNfsIXnV7IR1CyCocl3FczH8Enx02TpLJ12sGyrJKlhZxLGcRk3d9YjyENpQXZDISQSzEYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738421282; c=relaxed/simple;
	bh=okj62UF4pK6//854DvZwQDMWkeOk9AUhtYI013xIhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ6q773qMe5ykTQa0InL7aI6H/y0OiAQL7JZxxtSyMYUJ1drQYX8nUuMbgurTlER1NziMC1R0rQYKzPCa8IPhE9HZnOtMBiBeU7NnV+xgCXcsk50r3jLA85xBahAV4RZXsJGy868/VRpSlmzCJvshIuLuSFyE+mYjQYAKU+B908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCPf99Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00844C4CED3;
	Sat,  1 Feb 2025 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738421281;
	bh=okj62UF4pK6//854DvZwQDMWkeOk9AUhtYI013xIhz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FCPf99Z0mALeuSB775yNtNdZM84tquAmHOaecRtnBgUfuOJlOvsM2pdW5sfIkMCQq
	 xd1QJVFWYGLAxYFBxRhfZ/gHNRirSka7UDkRyhV2tBBIlZyr12eZwTtTfddMhFTLdZ
	 rfU0ekqjyGHebz2MW+8huyeYTZNzRfiE9zB7tISNL+CTIAGd/oFg3gD3QHZSlAzUGa
	 5ITBT5S4q8GMrddNCSIXTyfaWGbBO5R8dyFaLkCi5warCoUAfOJTzby89P0+GhvbeW
	 l42QYhUtoq2rlsuiIZgIRzs2Q6JZvUq/36Q7Ug5S+b3FWqBUnCQAOQ3Okvu4AgQNiX
	 LiMOx/JqLENig==
Date: Sat, 1 Feb 2025 14:47:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] iio: imu: adis: Add DIAG_STAT register size
Message-ID: <20250201144750.36e7564b@jic23-huawei>
In-Reply-To: <20250129082053.19077-4-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
	<20250129082053.19077-4-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2025 10:20:43 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Some devices may have more than 16 bits of status. This patch allows the
> user to specify the size of the DIAG_STAT register. It defaults to 2 if
> not specified. This is mainly for backward compatibility.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v5:
> - added local variable
> - mentioned default handling of diag_stat_size in comments=20
>=20
>  drivers/iio/imu/adis.c       | 14 +++++++++++---
>  include/linux/iio/imu/adis.h |  3 +++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 84344f052fb7..57e724412f52 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -304,11 +304,16 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
>   */
>  int __adis_check_status(struct adis *adis)
>  {
> -	u16 status;
> +	unsigned int status;
> +	int diag_stat_bits;
>  	int ret;
>  	int i;
> =20
> -	ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> +	if (adis->data->diag_stat_size)
> +		ret =3D adis->ops->read(adis, adis->data->diag_stat_reg, &status,
> +				      adis->data->diag_stat_size);
> +	else
> +		ret =3D __adis_read_reg_16(adis, adis->data->diag_stat_reg, (u16 *)&st=
atus);

You can't just cast a pointer like this.  What happens will depend on endia=
nness
of the host CPU.  Use a local variable for the u16 then set status =3D stat=
us16
or something like that.


>  	if (ret)
>  		return ret;
> =20
> @@ -317,7 +322,10 @@ int __adis_check_status(struct adis *adis)
>  	if (status =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < 16; ++i) {
> +	diag_stat_bits =3D BITS_PER_BYTE * (adis->data->diag_stat_size ?
> +					  adis->data->diag_stat_size : 2);
> +
> +	for (i =3D 0; i < diag_stat_bits; ++i) {
>  		if (status & BIT(i)) {
>  			dev_err(&adis->spi->dev, "%s.\n",
>  				adis->data->status_error_msgs[i]);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 13beb6a7317b..ad40fb95fcdc 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -44,6 +44,8 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @diag_stat_size: Length (in bytes) of the DIAG_STAT register. If not
> + *					defined, default value is 2 bytes long.

If 0, rather than not defined (it's defined whatever, just a question of wh=
at
value it has!)

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


