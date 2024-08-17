Return-Path: <linux-iio+bounces-8532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F179557C8
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1503282B9B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD814D2B3;
	Sat, 17 Aug 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeEYyhjJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E73145341;
	Sat, 17 Aug 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897609; cv=none; b=sJA+Npzq6NnE+ZXopkNOz/wCkwdfAgqdDfYkxrif4n7N8A6oBcbQ/QSsV7sWvnw4DoDfJpzdcPlTCar7FEtZn6wrtrMAZ5YbYpUfLkZcrQVd6hLIZy/s4vRO4foHNpWF/rAvEWeM1bBU/Gito7G99kb1Z0VSZ3jsSzXK0hBOTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897609; c=relaxed/simple;
	bh=kF+/iTDYmVlm6ai7F9rWIiLZy5+GP0XM77EBVLSK+YE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF/CMkL/rRDtlKi1S4kNY1csTUmyuAcR43+2x3JwdnbBQ+SvKw3M6v1w3Hn+6egjba9OK6UUy13ZzMPsqgBIVeZ0gdpvUvEg8QG1v2TFgkd+k/AhRAb5IubXlQs0n5ICs1yWIle4ZQv+UfvJ5FrnCUxaIzCimH9Rayn3Di2cTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeEYyhjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD0C116B1;
	Sat, 17 Aug 2024 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723897609;
	bh=kF+/iTDYmVlm6ai7F9rWIiLZy5+GP0XM77EBVLSK+YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeEYyhjJBfjfIRyr0E4xLypY6cJv1IXQI8NZabxzxVEGbN/zSvPkihlKqt6eJO2lW
	 ukFxDabb2DHehHuZ2ozeCEzJzlawKndvXVZN3tgpdpRyEEnCCwki1dj78ei2Xic4EV
	 6k++xqXJoUi58+nxpRY5G7glyb2+goOREdahdLD+BzYHPqrXJEoH4b3QwAUaPDm2j9
	 bss0C9bEK8GePIveFS2sQ9jq+5Ze5mfz7a44bBbrZ17N38jcdeiSWHEMx1dxfZNpE1
	 0HBvLwVxLmQFGC641sPccTJCQbVzbihsdDshc7i3NWSB+syd3GkusZscMnQP9Dy53W
	 VoS657/4yBWxw==
Date: Sat, 17 Aug 2024 13:26:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH v3 2/4] iio: magnetometer: ak8975: Fix reading for
 ak099xx sensors
Message-ID: <20240817132641.2902418e@jic23-huawei>
In-Reply-To: <20240809-ak09918-v3-2-6b036db4d5ec@mainlining.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
	<20240809-ak09918-v3-2-6b036db4d5ec@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Aug 2024 22:25:40 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> Move ST2 reading with overflow handling after measurement data
> reading.
> ST2 register read have to be read after read measurment data,
> because it means end of the reading and realease the lock on the data.
> Remove ST2 read skip on interrupt based waiting because ST2 required to
> be read out at and of the axis read.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
This still needs a fixes tag to tell us when the bug was first
introduced into the driver so that we know how far to back port it.

One other comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 6357666edd34..f8355170f529 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -692,22 +692,7 @@ static int ak8975_start_read_axis(struct ak8975_data=
 *data,
>  	if (ret < 0)
>  		return ret;
> =20
> -	/* This will be executed only for non-interrupt based waiting case */
> -	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
> -		ret =3D i2c_smbus_read_byte_data(client,
> -					       data->def->ctrl_regs[ST2]);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "Error in reading ST2\n");
> -			return ret;
> -		}
> -		if (ret & (data->def->ctrl_masks[ST2_DERR] |
> -			   data->def->ctrl_masks[ST2_HOFL])) {
> -			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	return 0;
> +	return !data->def->ctrl_regs[ST1_DRDY];
>  }
> =20
>  /* Retrieve raw flux value for one of the x, y, or z axis.  */
> @@ -734,6 +719,20 @@ static int ak8975_read_axis(struct iio_dev *indio_de=
v, int index, int *val)
>  	if (ret < 0)
>  		goto exit;
> =20
> +	/* Read out ST2 for release lock */
> +	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error in reading ST2\n");
> +		goto exit;
> +	}
> +
> +	if (ret & (data->def->ctrl_masks[ST2_DERR] |
> +		   data->def->ctrl_masks[ST2_HOFL])) {
> +		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +
>  	mutex_unlock(&data->lock);
> =20
>  	pm_runtime_mark_last_busy(&data->client->dev);
> @@ -746,7 +745,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev=
, int index, int *val)
> =20
>  exit:
>  	mutex_unlock(&data->lock);
> -	dev_err(&client->dev, "Error in reading axis\n");
> +	dev_err(&client->dev, "Error in reading axis %d\n", ret);

In most of the paths above there is already a detailed print. I'd not bother
adding the return value to this one.  It just adds noise to the patch.

>  	return ret;
>  }
> =20
>=20


