Return-Path: <linux-iio+bounces-4387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F728ABB46
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA10B2111A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0429402;
	Sat, 20 Apr 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnouBbUz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482E2563;
	Sat, 20 Apr 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611637; cv=none; b=u6+zP09U+MLsq4oVPjj2bxjP2ManRjngUgnTPqrkJVqa6IXh6TiM9BRkBNN02slaP8WZsca0snPlD2SSxgLoyfVWXws7Fy6WNB/sEcDwYA4/yd0b7cWKdZ8D0eXxcORzLkqZOYtP25lEP65BOsc4NakzlBQjiG8R/swWeQhWJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611637; c=relaxed/simple;
	bh=L1dFuGO/fPNJZQJV5N+sxU9LuBKwzp5GGaOXnsefV7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c35Fjwv4MhAZYH67MWOjORHXLLf0OmSfAM6boGBTEOK0/BQRmabbk4riMeh9D+oXK5P5PQDKvrlB7oSdJj5fYzYStlLImm80yK7aL5wwufvPNgTBC5B8MYvHyFYnnhmFKA55W+2/+U9nSpakOS4c/pWs5Mfw4I5EDHa14uTbqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnouBbUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC16C072AA;
	Sat, 20 Apr 2024 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713611636;
	bh=L1dFuGO/fPNJZQJV5N+sxU9LuBKwzp5GGaOXnsefV7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MnouBbUzCzzwrabi/2GkOxhofxkUVgIcpm1EmcxIDy++YBU2ize9NWN2A+6t29FVq
	 a/aE99f9w8kAzK1AlQic+PGXbPST1PYwtmxJYANwueDXRKoQqtx8UARuRYupNlW8HM
	 4gwxH2nFY5poVMGOcpfZ+Q6Trlyq9Ljbf5lM1jRz0uL9SSAZmD0ZoZejRkmPoavVfm
	 +JxPu9/Z6VhQ5Qzg3rc5moJjGXnwWtAgev3OUb23nw33w0J8mApDQMXxxI2l6p2Y1d
	 soghhqpDFtXqT1kcYcFnIoo9+St4PCtnF6eNap4Zg43yt7VMlkgF46SfDkkU3q2iv0
	 gFkMRZeWvM+PQ==
Date: Sat, 20 Apr 2024 12:13:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sean Rhodes
 <sean@starlabs.systems>, linux-iio@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] iio: accel: kxcjk-1013: Move ACPI ROTM parsing to
 new acpi-helpers.h
Message-ID: <20240420121345.26c2edf1@jic23-huawei>
In-Reply-To: <20240417164616.74651-3-hdegoede@redhat.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
	<20240417164616.74651-3-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 18:46:14 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
> between bmc150-accel-core.c and kxcjk-1013.c and a third user of this is
> coming.
>=20
> Move the ROTM parsing from kxcjk-1013.c, which has slightly better error
> logging (and otherwise is 100% identical), into a new acpi-helpers.h file
> so that it can be shared.
>=20
> Other then moving the code the only 2 other changes are:
>=20
> 1. Rename the function to acpi_read_mount_matrix() to make clear this
>    is a generic ACPI mount matrix read function.
> 2. Add a "char *acpi_method" parameter since some bmc150 dual-accel setups
>    (360=C2=B0 hinges with 1 accel in kbd/base + 1 in display half) declar=
e both
>    accels in a single ACPI device with 2 different method names for
>    the 2 matrices.
>=20
> Cc: Sean Rhodes <sean@starlabs.systems>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Tempted to ask you to rename this to
acpi_non_standard_microsoft_extension_that_they_never_agreed_with_aswg_read=
_mount_matrix()
but meh, I'll cope with a reference to:
https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-=
acpi-entries
and a comment saying this is not part of the ACPI standard.

I'm not grumpy at all about companies who add non standard stuff without
at least reserving the ID space.

Why isn't it a _DSM (Device Specific Method) with a microsoft defined UUID?=
 Harrumph.

+CC Rafael and linux-acpi as whilst this remains in IIO, it is named such t=
hat it
ends up in the acpi_* namespace.  They may not care, but best to check!

Jonathan


> ---
>  drivers/iio/accel/acpi-helpers.h | 76 ++++++++++++++++++++++++++++++++
>  drivers/iio/accel/kxcjk-1013.c   | 71 ++---------------------------
>  2 files changed, 79 insertions(+), 68 deletions(-)
>  create mode 100644 drivers/iio/accel/acpi-helpers.h
>=20
> diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-he=
lpers.h
> new file mode 100644
> index 000000000000..a4357925bf07
> --- /dev/null
> +++ b/drivers/iio/accel/acpi-helpers.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* ACPI helper functions for parsing ACPI rotation matrices */
> +
> +#include <linux/acpi.h>
> +#include <linux/dev_printk.h>
> +#include <linux/iio/iio.h>
> +#include <linux/sprintf.h>
> +
> +#ifdef CONFIG_ACPI
> +static inline bool acpi_read_mount_matrix(struct device *dev,
> +					  struct iio_mount_matrix *orientation,
> +					  char *acpi_method)
> +{
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +	char *str;
> +	union acpi_object *obj, *elements;
> +	acpi_status status;
> +	int i, j, val[3];
> +	bool ret =3D false;
> +
> +	if (!adev || !acpi_has_method(adev->handle, acpi_method))
> +		return false;
> +
> +	status =3D acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffe=
r);
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
> +#else
> +static inline bool acpi_read_mount_matrix(struct device *dev,
> +					  struct iio_mount_matrix *orientation,
> +					  char *acpi_method)
> +{
> +	return false;
> +}
> +#endif
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index bb1660667bb0..7e19278491dc 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -24,6 +24,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/accel/kxcjk_1013.h>
> =20
> +#include "acpi-helpers.h"
> +
>  #define KXCJK1013_DRV_NAME "kxcjk1013"
>  #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
> =20
> @@ -636,73 +638,6 @@ static int kxcjk1013_set_power_state(struct kxcjk101=
3_data *data, bool on)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_ACPI
> -static bool kxj1009_apply_acpi_orientation(struct device *dev,
> -					   struct iio_mount_matrix *orientation)
> -{
> -	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> -	char *str;
> -	union acpi_object *obj, *elements;
> -	acpi_status status;
> -	int i, j, val[3];
> -	bool ret =3D false;
> -
> -	if (!adev || !acpi_has_method(adev->handle, "ROTM"))
> -		return false;
> -
> -	status =3D acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
> -		return false;
> -	}
> -
> -	obj =3D buffer.pointer;
> -	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
> -		dev_err(dev, "Unknown ACPI mount matrix package format\n");
> -		goto out_free_buffer;
> -	}
> -
> -	elements =3D obj->package.elements;
> -	for (i =3D 0; i < 3; i++) {
> -		if (elements[i].type !=3D ACPI_TYPE_STRING) {
> -			dev_err(dev, "Unknown ACPI mount matrix element format\n");
> -			goto out_free_buffer;
> -		}
> -
> -		str =3D elements[i].string.pointer;
> -		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) !=3D 3) {
> -			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
> -			goto out_free_buffer;
> -		}
> -
> -		for (j =3D 0; j < 3; j++) {
> -			switch (val[j]) {
> -			case -1: str =3D "-1"; break;
> -			case 0:  str =3D "0";  break;
> -			case 1:  str =3D "1";  break;
> -			default:
> -				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
> -				goto out_free_buffer;
> -			}
> -			orientation->rotation[i * 3 + j] =3D str;
> -		}
> -	}
> -
> -	ret =3D true;
> -
> -out_free_buffer:
> -	kfree(buffer.pointer);
> -	return ret;
> -}
> -#else
> -static bool kxj1009_apply_acpi_orientation(struct device *dev,
> -					  struct iio_mount_matrix *orientation)
> -{
> -	return false;
> -}
> -#endif
> -
>  static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
>  {
>  	int ret;
> @@ -1533,7 +1468,7 @@ static int kxcjk1013_probe(struct i2c_client *clien=
t)
>  	} else {
>  		data->active_high_intr =3D true; /* default polarity */
> =20
> -		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation))=
 {
> +		if (!acpi_read_mount_matrix(&client->dev, &data->orientation, "ROTM"))=
 {
>  			ret =3D iio_read_mount_matrix(&client->dev, &data->orientation);
>  			if (ret)
>  				return ret;


