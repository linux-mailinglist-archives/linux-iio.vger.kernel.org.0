Return-Path: <linux-iio+bounces-3004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526928625E4
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7EC282107
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14947781;
	Sat, 24 Feb 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPW+ZFbA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6345028
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790485; cv=none; b=U/qveZ/Ar+XdtrMy+ufJ1aJieLBBe6DDHAJPy8QdvpiNeJcv84ICV4Zj46xEGeN5aIpee6ya19kujjaxLjVpuewGpiZQbOSuIiE+FiLtGmI7VR5BIyX1o91MeJA9T74N+nuiFF8DAzdMg3QMPLDRrvV4yuzJkA42nvo+J9LScKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790485; c=relaxed/simple;
	bh=ZPN7/d+Xjnit+tWnBtXqwvnEGHvlAkpt3S/THC6ApN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/p0NCm1KaiBfgUXg3oR9qOYf/kwZRmb5AnK2S6exKhrl8pq3+XsZAT5zdin+2+Wc/TpMFDDuQxjMme/tidhQ009xoxja/Zv6VOWiXiuSmENTQfrQ+EOGw0WLnmfAmBS4e97eT0uLu8XYxosK2Ztorwi8M+rLDw9uWqG2osYpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPW+ZFbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FEFC433F1;
	Sat, 24 Feb 2024 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790484;
	bh=ZPN7/d+Xjnit+tWnBtXqwvnEGHvlAkpt3S/THC6ApN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPW+ZFbAqy7yGAovVvBhFjnWncfxUxnkeHPzn55q3RAHLG+9vEk9lXyKX8hEoNPEn
	 6I5+kR0BFpxUG/iS77VV2LGZD0F5negMt27e738vV+CxeMQRqRI2LSfocViVa1i37m
	 h4SnCS05OZp00z244J5zzbXlhvuMlyq4NmznpPdVG+V9+EOVbre0ZBtVFwMRR/2zSo
	 YvJVFYLAU+MgoFyrj5YKczCReKsy4P/OyTqsH/RlHjctPYPn4UYbME3+IC0vibgHBd
	 nyFjWXn2pYRkgh8tlv8rFHUe6mVAOt4gWSlneNJwFRfAxzsAuUZ8+Fo9pv2WrVyW+z
	 XRk0bl9ualxDQ==
Date: Sat, 24 Feb 2024 16:01:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] iio: accel: kxcjk-1013: Implement ACPI method ROTM
 to retrieve mount matrix.
Message-ID: <20240224160112.3d8dd0a7@jic23-huawei>
In-Reply-To: <19d7a10aae5238a2c8db37da1f74edb86480e17e.1708293140.git.sean@starlabs.systems>
References: <19d7a10aae5238a2c8db37da1f74edb86480e17e.1708293140.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Feb 2024 21:53:37 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

> Implement kxj_acpi_orientation to retrieve mount matrix
> from ACPI ROTM method
>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---

There should be a change log here...
Otherwise looks fine to me.

Applied to the togreg branch of iio.git and initially pushed out as testing
for 0-day to get a first look at it and see if it can find anything we miss=
ed.

Thanks,

Jonathan


>  drivers/iio/accel/kxcjk-1013.c | 87 ++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 894709286b0c..771bdc2b2e36 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -619,6 +619,84 @@ static int kxcjk1013_set_power_state(struct kxcjk101=
3_data *data, bool on)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_ACPI
> +static bool kxj_acpi_orientation(struct device *dev,
> +				 struct iio_mount_matrix *orientation)
> +{
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +	char *str;
> +	union acpi_object *obj, *elements;
> +	acpi_status status;
> +	int i, j, val[3];
> +	bool ret =3D false;
> +
> +	if (!acpi_has_method(adev->handle, "ROTM"))
> +		return false;
> +
> +	status =3D acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
> +		return false;
> +	}
> +
> +	obj =3D buffer.pointer;
> +	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
> +		dev_err(dev, "Unknown ACPI mount matrix package format\n");
> +		goto out_free_buffer;
> +	}
> +
> +	elements =3D obj->package.elements;
> +	for (i =3D 0; i < 3; i++) {
> +		if (elements[i].type !=3D ACPI_TYPE_STRING) {
> +			dev_err(dev, "Unknown ACPI mount matrix element format\n");
> +			goto out_free_buffer;
> +		}
> +
> +		str =3D elements[i].string.pointer;
> +		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) !=3D 3) {
> +			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
> +			goto out_free_buffer;
> +		}
> +
> +		for (j =3D 0; j < 3; j++) {
> +			switch (val[j]) {
> +			case -1: str =3D "-1"; break;
> +			case 0:  str =3D "0";  break;
> +			case 1:  str =3D "1";  break;
> +			default:
> +				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
> +				goto out_free_buffer;
> +			}
> +			orientation->rotation[i * 3 + j] =3D str;
> +		}
> +	}
> +
> +	ret =3D true;
> +
> +out_free_buffer:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
> +static bool kxj1009_apply_acpi_orientation(struct device *dev,
> +					  struct iio_mount_matrix *orientation)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +
> +	if (adev && acpi_dev_hid_uid_match(adev, "KIOX000A", NULL))
> +		return kxj_acpi_orientation(dev, orientation);
> +
> +	return false;
> +}
> +#else
> +static bool kxj1009_apply_acpi_orientation(struct device *dev,
> +					  struct iio_mount_matrix *orientation)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
>  {
>  	int ret;
> @@ -1449,9 +1527,12 @@ static int kxcjk1013_probe(struct i2c_client *clie=
nt)
>  	} else {
>  		data->active_high_intr =3D true; /* default polarity */
> =20
> -		ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
> -		if (ret)
> -			return ret;
> +		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation))=
 {
> +			ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
> +			if (ret)
> +				return ret;
> +		}
> +
>  	}
> =20
>  	ret =3D devm_regulator_bulk_get_enable(&client->dev,


