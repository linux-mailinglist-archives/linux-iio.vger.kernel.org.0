Return-Path: <linux-iio+bounces-14228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A19A0AA8F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EB71659F8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A21BCA1B;
	Sun, 12 Jan 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1VKQz5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643701B4135;
	Sun, 12 Jan 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696377; cv=none; b=RR3n4bwsKNTkF1eMTTpha7k/i6CG4Y9aSlMI6WZqKGEcEMnecteP/dGCznqL7u8BcQlZxkombxOtQM+2mnZQcgOngC60rvNUJr0SWpophWvLcSpylKut887CNulUf8dWEoZo4h09QryVZkt/Ihh+dZlWz8b8lYdsHDmDfa+pXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696377; c=relaxed/simple;
	bh=zVcq1MXH4eaGfKbuEOUGU0udRLF0UfMgYoQ6ZxWuSKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti4LG5AH9GYr20jfCQdMAjhlg35LlpVMZVY9UgisI1oWSMwJr3z7M9b2wKJOTdjt1zZ5V6dw55Yx4vgKzqHnA24xhj3B3sbz/GMTZQhfwoFMSiJh/HFIb5lAgc1p8XJL/eTDjjXl/jRIGxTVH2DqI0FyX3+h7fQ88srYtxzZIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1VKQz5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC6C4CEDF;
	Sun, 12 Jan 2025 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736696376;
	bh=zVcq1MXH4eaGfKbuEOUGU0udRLF0UfMgYoQ6ZxWuSKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B1VKQz5CV1TbeYV4VLPkJUA2WcuTXJz2pcTYSESYuq4+U9isnd0zwZHtWAU1LfHvF
	 MKMKurdnuOoYIGcRioyzDHU7n2RbEQLJtyHrETBC50J5slkmnQsKAroX9ZQnGx2+S5
	 uSo3gRe7GGdPJuy3ClXpaeXadrKC9a34qMgmLTYkrZ7xQnxpfdTY09ECOQFforriCV
	 6pTk3e2zI1o5JTjCJ4xx+N1ECDkuU2oKrbbXegmI2rAiWSlOPF0IhS74NoFAzvf4sy
	 SQbPxQHpUrbJOJXPv0PqL7OgrEqbXceAx+w8hKHoFKKGLmUDntJ71ywHCA5nvJmAqY
	 ytmXrDRoNrr2g==
Date: Sun, 12 Jan 2025 15:39:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano
 <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] iio: imu: adis: Add DIAG_STAT register size
Message-ID: <20250112153925.0e7ae045@jic23-huawei>
In-Reply-To: <20250110074254.38966-4-robert.budai@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
	<20250110074254.38966-4-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2025 09:42:51 +0200
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
>  drivers/iio/imu/adis.c       | 11 ++++++++---
>  include/linux/iio/imu/adis.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 9e4113473dc4..a072307bfb6a 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -304,11 +304,15 @@ EXPORT_SYMBOL_NS(__adis_enable_irq, "IIO_ADISLIB");
>   */
>  int __adis_check_status(struct adis *adis)
>  {
> -	u16 status;
> +	unsigned int status;
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
>  	if (ret)
>  		return ret;
> =20
> @@ -317,7 +321,8 @@ int __adis_check_status(struct adis *adis)
>  	if (status =3D=3D 0)
>  		return 0;
> =20
> -	for (i =3D 0; i < 16; ++i) {
> +	for (i =3D 0; i < BITS_PER_BYTE * ((adis->data->diag_stat_size) ?
> +					 adis->data->diag_stat_size : 2); ++i) {

This is getting hard to read.  I think a local variable is appropriate.

>  		if (status & BIT(i)) {
>  			dev_err(&adis->spi->dev, "%s.\n",
>  				adis->data->status_error_msgs[i]);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 52652f51db2e..b888b22f5c8c 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -44,6 +44,7 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @diag_stat_size: Length (in bytes) of the DIAG_STAT register.

Add something about 0 being treated as meaning 2. Or add this to
all instances of this structure so we don't need that 0 case.
Whilst there are quite a lot instances, they are mostly filled
by a couple of macros so it shouldn't be too bad to update them all.

>   * @prod_id_reg: Register address of the PROD_ID register
>   * @prod_id: Product ID code that should be expected when reading @prod_=
id_reg
>   * @self_test_mask: Bitmask of supported self-test operations
> @@ -70,6 +71,7 @@ struct adis_data {
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;
>  	unsigned int diag_stat_reg;
> +	unsigned int diag_stat_size;
>  	unsigned int prod_id_reg;
> =20
>  	unsigned int prod_id;


