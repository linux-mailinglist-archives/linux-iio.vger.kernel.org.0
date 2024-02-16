Return-Path: <linux-iio+bounces-2639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8834857FDA
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9500528A4D2
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7B12EBF6;
	Fri, 16 Feb 2024 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKHuNipG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3965465D
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095428; cv=none; b=CCioVbMfH/NKxSSgGUEiwS9KcJOGjGSAq2Bg94P8ZSu5A+toO+9LPrRSVdnQnqTDB/LTSnHmQoxRIs4FVn+1d3Yusutg/xs9VTMljUrtzUwio8yB3IaZdAfZXpkHvycs73L64NVLV8x8ZmbiUjO5JEtXp3fExmcPYdlECbceesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095428; c=relaxed/simple;
	bh=FC0jhDuQeREBTXDl9cIwGpDHJuYLwF38KNTiy0CpCtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTpA/841Je1BABzkWPqLcCXyIH0px/9vzJje2t1uxcJ3I/TRJ+rU4sHSl3Uk9y67ExL1rJR1PL5hSVbev4K3D7w4il+h/KT3ic2jryBJU3GM6+6NS/DcxnhSY+wB59w3n5lrfYVJvsavKxsahwGo8F+qTEWrcCjOl/1LR4Na6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKHuNipG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42DDC433F1;
	Fri, 16 Feb 2024 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095427;
	bh=FC0jhDuQeREBTXDl9cIwGpDHJuYLwF38KNTiy0CpCtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKHuNipGIj0AXIS0DcwmiCU4lFRDZjZzFfqOO2jKqh814p4WxIgKoWjgnd5wmaLnR
	 PkwRkFCWn+sEvNvjXcG7z41hxj8KglFE+tBr4Aj0pSpU5PIIgyLutL+UDUDSHI6Kul
	 PyxyhsE3ZNPGOpi1AXcwCXOcbBUVXOB2p5mlqge6nPqTXmK4lIbfypUXtOzZBcnheJ
	 YYl7wKS4rIwAUPR6IY8elkYhfbK5Ia1lHv6tPG/SyuWqV+o/H4zQP3I534gjjcgrKq
	 1nfZ41HC8s9l/E55w/FayBBNtXoDApD0sqZSPg6PhRwQ4mK4wZztSuUTUaSbcy8uxD
	 l811Nz5J7ywyA==
Date: Fri, 16 Feb 2024 14:56:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Implement ACPI method ROTM to
 retrieve mount matrix.
Message-ID: <20240216145656.462b724a@jic23-huawei>
In-Reply-To: <ecf63cc9cc99eb4a9d813b11d976547eb3a610bd.1707744504.git.sean@starlabs.systems>
References: <ecf63cc9cc99eb4a9d813b11d976547eb3a610bd.1707744504.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2024 13:30:26 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

I assume this is v3?  Pass -v2 to git format-email and it will make the
title [PATCH V3] ...

Without that I may well get wrong version, and automated tools like b4 have
no reliable way to know what to pick up either.


> Implement kxj_acpi_orientation to retrieve mount matrix
> from ACPI ROTM method
Wrap at 75 chars.

>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---

change log belongs here.

>  drivers/iio/accel/kxcjk-1013.c | 87 ++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 894709286b0c..864c27fa75bc 100644
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
> +		goto out_free_buffer;

I'm not seeing a reply, or a change to reflect you accepted the suggestion,
to my review comment on my understanding that there should be no buffer to =
free
if this results in an error.

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


