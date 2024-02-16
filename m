Return-Path: <linux-iio+bounces-2651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F623858232
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A981F22496
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC512FB31;
	Fri, 16 Feb 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4Y+r+Nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474612FB28
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100024; cv=none; b=OFHIyMVUUCybh2fDvUOC461gwotiDHlffz5ULGe36nC3pUXPGpovbOAWAZkFjfvTsw5nBWBMDW7zXLvltDAsbH2g5B3R7y5MVOjjXby7/T5ZIhOfAog9b42Vcpvw+vN97J+XMuklEMx6CXwe/4iL6xCwwQUKT3l3090qqUrK7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100024; c=relaxed/simple;
	bh=yUYiywfmTHHqxS9pf0VM98hatSkSuB3N+6oh78bt6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTHwiambFnWEJtODIj6PG1QlfhN68Edbu10+b6aF/s5ErxtSaynDRJAyV/oBBD1XCvu1ENhl2Kr96m8UOJ1+Ji6PQ50T3sgxq1aFSLbhWv0bhza8ImN/BmuPApW8mvO58TZ34/FZr6JnNCLodMWTncH6H78o0hxuSahN0vmzRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4Y+r+Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A87DC433F1;
	Fri, 16 Feb 2024 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708100023;
	bh=yUYiywfmTHHqxS9pf0VM98hatSkSuB3N+6oh78bt6ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4Y+r+NurLEPeKx7IdBOLLk1cTHGDPHzw5uH19psROJ7FdS9CYlRPdU+tvkA/IygK
	 GnfMAlMWfFlYzhLAdvSs7K+1zcKJZxpU4o26RnaTDUUGrs+SSYua4sDtx+DonUW/a+
	 zJwS5XLUi5ZA7OGa2Icr5K8+/HtOeoH9f2AdOk0rQGrcnKdCrY+28nBZjzzbyg160W
	 LorqKYKFt4jMDnWy+/WlWO82LM4F7Uw31W1QXq18kXQKenZLx0MoL2fGYWxuYsnxDx
	 s9Mc0pTFoEYCMNimx0Z4dijYHHWH5A68oEUoVcJt3EzYbbH8ccJ8cNS0hK9rZi/+wa
	 4y1SYnh/LI5iw==
Date: Fri, 16 Feb 2024 16:13:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] iio: accel: kxcjk-1013: Implement ACPI method ROTM
 to retrieve mount matrix.
Message-ID: <20240216161332.5305c5bb@jic23-huawei>
In-Reply-To: <7d047e344ef05efab76f7ba3799346c9fe7dfea9.1708096118.git.sean@starlabs.systems>
References: <7d047e344ef05efab76f7ba3799346c9fe7dfea9.1708096118.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 15:09:20 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

> Implement kxj_acpi_orientation to retrieve mount matrix
> from ACPI ROTM method
>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Hi Sean, looks like your build tests aren't building this for some reason...

Also shows what my eyes will skip over on assumption it can't possibly
be a problem :(

> ---
>  drivers/iio/accel/kxcjk-1013.c | 83 ++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 894709286b0c..d6b068cfa68a 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -619,6 +619,80 @@ static int kxcjk1013_set_power_state(struct kxcjk101=
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
> +	acpi_status status;
> +
> +	if (!acpi_has_method(adev->handle, "ROTM"))
> +		return false;
> +
> +	status =3D acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
> +		return false; // Removed goto, no buffer to free on ACPI failure

Don't leave comment there. It doesn't provide helpful info to have in the s=
ource
code.

> +	}
> +
> +	obj =3D buffer.pointer;
Obj isn't declared.
> +	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
> +		dev_err(dev, "Unknown ACPI mount matrix package format\n");
> +		goto out_free_buffer;
> +	}
> +
> +	elements =3D obj->package.elements;
elements also not declared.

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
no such thing as j
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
ret doesn't exist either.
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
> @@ -1449,9 +1523,12 @@ static int kxcjk1013_probe(struct i2c_client *clie=
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


