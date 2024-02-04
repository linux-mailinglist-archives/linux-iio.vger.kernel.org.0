Return-Path: <linux-iio+bounces-2154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C51848EEB
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1FA1F22152
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008E225AC;
	Sun,  4 Feb 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAx+Hpn1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2F225A9
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060481; cv=none; b=g2WI+r6cK1Adoam42CKgqTU086aZ9wyV8u91ZWV78+anMvHmT2nUcu4i1MsAxHcA5bD5iuEws8ObMWtAKqfzcFmW82Qruwz/lVI9cJdccNSnd3jG649UxuYWhvQ7do+03CHCgSQU1gWmzoaSZK7nrO0YwbCkkaHdIDmIYirvTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060481; c=relaxed/simple;
	bh=0BzUgZLZgSyPtfTyWBnGqyZGwVV7Oq5gfdcWkV/2cQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4YJ42IqJYrIQjEGp9wpNx9VaDBV82zCoWshiI82VjzeTEoJuny6SlGChRPVhnBTw4Coy48Yr07KoO14Rl6+snOj1bEGNWnc2HxUou6WorN0ol7xqzLrA719lhkTC4e/Ayl/r0w7Rum8e1Zn0R0FIpAVy6d3Mde/Lr7SOu6M6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAx+Hpn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565FBC433F1;
	Sun,  4 Feb 2024 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707060480;
	bh=0BzUgZLZgSyPtfTyWBnGqyZGwVV7Oq5gfdcWkV/2cQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AAx+Hpn1INc7vtI+XJCwrksI1nUfTibapGy17w5KgtNlWhXDguWIypxCGVuyjpEiz
	 VZ927wCzfeTgHDyHsls8eetfMpo+xFWTSaJYOU39rQm4dnH2hFTLqeloakeUbvxkEy
	 eVlqBN/yS+ByuQmrq3ap0pt6fPFZiM942qN2zCDLwbVGywt7tfvgXOo+G9hB8c6juq
	 zC4g4+aB4/WH+dmFAI6USzxq5Na2etE4CN6M4FliNK64njipNvidmP74fy60vC5/ba
	 0AvMLVw3UiuWpw+lcvooub2rASpTtpbVUpYMN/QTe8jcEuidqdY4h3pE5EebEGhwgg
	 eLUAnokGPbKgw==
Date: Sun, 4 Feb 2024 15:27:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] drivers/iio/accel/kxcjk-1013: Add support for
 retrieving the mount-matrix
Message-ID: <20240204152745.76463241@jic23-huawei>
In-Reply-To: <77875d90b21d3065b533d89b620c143b29d141a0.1706619185.git.sean@starlabs.systems>
References: <77875d90b21d3065b533d89b620c143b29d141a0.1706619185.git.sean@starlabs.systems>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2024 12:53:20 +0000
Sean Rhodes <sean@starlabs.systems> wrote:

> Add support for reading the "ROTM" method from APCI which contains
> the mount matrix.
>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 88 ++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 894709286b0c..760bbd95b73c 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -619,6 +619,85 @@ static int kxcjk1013_set_power_state(struct kxcjk101=
3_data *data, bool on)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_ACPI
> +/*
> + * Support for getting accelerometer information from KIOX000A ACPI node=
s.
> + *
> + */
> +static bool kxj_acpi_orientation(struct device *dev,
> +				 struct iio_mount_matrix *orientation)
> +{
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);Media4 Inc=09
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +	char *name, *alt_name, *label, *str;
> +	union acpi_object *obj, *elements;
> +	acpi_status status;
> +	int i, j, val[3];
> +
> +	if (acpi_has_method(adev->handle, "ROTM")) {
> +		name =3D "ROTM";
> +	} else {
> +		return false;
> +	}
Flip logic
	if (!acpi_has_method(adev->handle, "ROTM"))
		return false;

Given it's only called ROTM in this handler, just use that string
directly in the next call.


> +
> +	status =3D acpi_evaluate_object(adev->handle, name, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);

If ROTM exists and we fail to read it I think we should return an error and=
 fail
to probe.  This sort of bug is one we want to more than warn about. We want=
 to
figure out why and fix it!

> +		return false;
> +	}
> +
> +	obj =3D buffer.pointer;
> +	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3)
> +		goto unknown_format;

This sort of unknown format is very different from the string being wrongly
formatting below. I'd use a more specific message in each case.

> +
> +	elements =3D obj->package.elements;
> +	for (i =3D 0; i < 3; i++) {
> +		if (elements[i].type !=3D ACPI_TYPE_STRING)
> +			goto unknown_format;
> +
> +		str =3D elements[i].string.pointer;
> +		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) !=3D 3)
> +			goto unknown_format;
> +
> +		for (j =3D 0; j < 3; j++) {
> +			switch (val[j]) {
> +			case -1: str =3D "-1"; break;
> +			case 0:  str =3D "0";  break;
> +			case 1:  str =3D "1";  break;
> +			default: goto unknown_format;
> +			}
> +			orientation->rotation[i * 3 + j] =3D str;
> +		}
> +	}
> +
> +	kfree(buffer.pointer);
> +	return true;

Use a local variable for the return then a goto above the kfree
will work for good and bad cases.

> +
> +unknown_format:
> +	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
> +	kfree(buffer.pointer);
> +	return false;
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
> @@ -1449,9 +1528,12 @@ static int kxcjk1013_probe(struct i2c_client *clie=
nt)
>  	} else {
>  		data->active_high_intr =3D true; /* default polarity */
> =20
> -		ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
> -		if (ret)
> -			return ret;
> +		if (!apply_kcj1009_acpi_orientation(&client->dev, &data->orientation))=
 {

I'm confused. That doesn't seem to be the name of the function?

Also, use an integer return that you can then pass on.
Should distinguish between it wasn't there, in which case use the iio_read_=
mount_matrix()
or it was and we failed to read it, in which case fail the probe an print a=
 big
message as we have something to debug.

Jonathan


> +			ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
> +			if (ret)
> +				return ret;
> +		}
> +
>  	}
> =20
>  	ret =3D devm_regulator_bulk_get_enable(&client->dev,


