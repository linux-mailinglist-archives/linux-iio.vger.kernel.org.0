Return-Path: <linux-iio+bounces-2356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495188504FA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FE81F2304C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE605BAE1;
	Sat, 10 Feb 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7XZomMS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8D3D554
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579816; cv=none; b=ZuvnDX+UH4CHYZ0kL3ZboN3uNSablnU+HB4D8bNz/NuR3bfh0TGtqG78JGZUNnIcxPSr7laqcIpeOsvUhFPLgDVpYhF7g5TiQkriJVndTX07E4PkEP8cdKcIhqr2/iPetoQr0PF+GyovR5vIP2KiDxkREWxc0AqOA9B4S8FFcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579816; c=relaxed/simple;
	bh=tI85fRvU1rMv2kR8S5slF0dja/it//LTrjG8j790NSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaiWrXyXzCOCVlYLqloD6qYVvP+DrYgLvzkUl3WxweOAjBpuwogX1J/PXQIxJ3gLjzGCEUyI/c+1vdNJE4PXoAjBGUmrruLEgvKgPWNPASytv0K0hz0uWGtakOQS3T+LhW8OKiQxFZfHWi3JbWTugSSZwu3hDWZV484wMgoRKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7XZomMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912B8C433F1;
	Sat, 10 Feb 2024 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707579815;
	bh=tI85fRvU1rMv2kR8S5slF0dja/it//LTrjG8j790NSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S7XZomMSJRudSFnaUmIA+wkbpu2hOboa7pm1NluwznsHd7fGtf4hhzCdlEKd6MKcn
	 +JgWULPFI4ZLKAdlOHYx69uCFy+JuD1dUV4QZNMH3NhVfzI918XR89gvWvT6pLF9Jz
	 dkcpkYBkHLQW3NtSz/7F2cy0qZhYQji1Jf1Y/Gi3IGvCcbS8R7sYdMjJ2enOM5wIYf
	 f8zZ1LE7d+hDqjKu4ooG20XQGw5IHfHHFc7eVnu5M5reRnXfejV2TzHBbCmgik25y/
	 2pf9qpSrGAsrXqgYvPM8jg2w4ziX4WPl6kQ/Se/F8kpcTEd8PUFo6xIfjFP3xm1Xss
	 G/9AmBN1ZYoow==
Date: Sat, 10 Feb 2024 15:43:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] drivers/iio/accel/kxcjk-1013: Retrieve mount-matrix
 from ACPI Implement kxj_acpi_orientation to retrieve mount matrix from ACPI
 ROTM method
Message-ID: <20240210154324.2274ec53@jic23-huawei>
In-Reply-To: <560489c23cb702e60d4f32c5b6c9f758d39841d2.1707426098.git.sean@starlabs.systems>
References: <560489c23cb702e60d4f32c5b6c9f758d39841d2.1707426098.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Feb 2024 21:03:26 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Hi Sean.

Please make sure to match local style for patch titles.
Something along the lines of:

iio: accel: kxcjk-1013: Implement ACPI method ROTM to retrieve mount matrix.

A few minor things inline. Otherwise this looks fine.
At somepoint it might be nice to factor out a library for this call
as it seems to be reasonably common (I think it's a windows thing as it's n=
ot
standard ACPI spec stuff).  *mutters darkly that they should at least have
reserved the ID rather than making it up*

Jonathan


> ---
>  drivers/iio/accel/kxcjk-1013.c | 86 ++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 894709286b0c..f5ac06d5566c 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -619,6 +619,83 @@ static int kxcjk1013_set_power_state(struct kxcjk101=
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
> +	if (!acpi_has_method(adev->handle, "ROTM")) {
> +		return false;
> +	}
Kernel style is only use brackets for multiple line statements.
	if (!..)
		return false;

> +
> +	status =3D acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
> +		goto out;
It would be unusual if this has as side effect on error of leaving the buff=
er
allocated. Looking at the code there might be a path, if the copy fails,
acpi_ut_copy_iobject_to_eobject() but I think that can't actually fail beca=
use
we've already checked the source object is valid when querying it's size et=
c.

Other cases (I checked a couple only ) we have in tree assume that we don't=
 need to free the buffer
if we fail this call.

> +	}
> +
> +	obj =3D buffer.pointer;
> +	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
> +		dev_err(dev, "Unknown ACPI mount matrix package format\n");
> +		goto out;
> +	}
> +
> +	elements =3D obj->package.elements;
> +	for (i =3D 0; i < 3; i++) {
> +		if (elements[i].type !=3D ACPI_TYPE_STRING) {
> +			dev_err(dev, "Unknown ACPI mount matrix element format\n");
> +			goto out;
> +		}
> +
> +		str =3D elements[i].string.pointer;
> +		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) !=3D 3) {
> +			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
> +			goto out;
> +		}
> +
> +		for (j =3D 0; j < 3; j++) {
> +			switch (val[j]) {
> +			case -1: str =3D "-1"; break;
> +			case 0:  str =3D "0";  break;
> +			case 1:  str =3D "1";  break;
> +			default: goto unknown_format;

? Where does that go?

> +			}
> +			orientation->rotation[i * 3 + j] =3D str;
> +		}
> +	}
> +
> +	ret =3D true;
> +
> +out:
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
> @@ -1449,9 +1526,12 @@ static int kxcjk1013_probe(struct i2c_client *clie=
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


