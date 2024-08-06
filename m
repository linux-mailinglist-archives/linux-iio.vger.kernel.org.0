Return-Path: <linux-iio+bounces-8288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97689495CB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B972B259F5
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8E36124;
	Tue,  6 Aug 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNOtgoiX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478B18D635;
	Tue,  6 Aug 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961174; cv=none; b=SxauEAwGRuuxn980NrTTLbw91k7kvx5y7Suz/+t1BJk9K792C8Uxm18OyuosOXutZ3cD36iOCn3iYaNFmeJT0Q6f6gKj0EFWSZdlqe5/Xp0TjS7GBX1yx2YPSFZoN1usyAC9WZt3WN4llycLycCHltU89kCfbzjd5WL4QsnuzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961174; c=relaxed/simple;
	bh=YeNtWL8whpfWe7Qhmm7tHCJLQzbTIh7pEh655CaEFFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+txbm3g5AYhT5oGRcFjk6e0Cgz12l7K7Wf+TrrKx1o7QLIgf8GFwAw4xP/+vluRXt0lWVi8+GEFqXfkjB9ygGl6t9SMnAUkd9ldY52VAtB8PdfScaJ+cvpfFdnQYN83HV6gDvWYbJTK6vm5P3xabdc5KRZPegw14fpyjrBuZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNOtgoiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023CDC32786;
	Tue,  6 Aug 2024 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961173;
	bh=YeNtWL8whpfWe7Qhmm7tHCJLQzbTIh7pEh655CaEFFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNOtgoiXpqhi2l5U0hIfOOGOMtr3BCH/EYqpGxvsw0J7FroWVXiwp612R5h38NtvU
	 0/MZk25DK+ZpC9BfU7PjObNECuLOCz5ztnCNAbElxac5znoLkA9JY8xYQhZDpzQFEY
	 mXR6Lk8c53nHymIO4QJ/FjEscPnPzMimE+3A8axjXXcLhuYrdEQ2/naPsnw5H9zOLW
	 dCy6DiHc8j0XJIk61Vyqa0SRyPNUKgHJWOwAH1ePJxJhJjH7RtbAK8rkPntvRwNz4k
	 Va+OT4Uoir/xwaHnPCmu4kmL3cjYkBd88b7GbondYR9xRmUUF3q+/49VLDqtmH+Cni
	 vRZYopRvLPaFw==
Date: Tue, 6 Aug 2024 17:19:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH v2 1/3] iio: magnetometer: ak8975: Fix reading for
 ak099xx sensors
Message-ID: <20240806171925.7c512c63@jic23-huawei>
In-Reply-To: <20240806-ak09918-v2-1-c300da66c198@mainlining.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
	<20240806-ak09918-v2-1-c300da66c198@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 08:10:18 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

Hi Barnab=C3=A1s,

Welcome to IIO.

> ST2 register read should be placed after read measurment data,
> because it will get correct values after it.

What is the user visible result of this? Do we detect errors when none
are there?  Do we have a datasheet reference for the status being
update on the read command, not after the trigger?
>
Needs a Fixes tag to let us know how far to backport the fix.

A few comments inline.
=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>
> ---
>  drivers/iio/magnetometer/ak8975.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index dd466c5fa621..925d76062b3e 100644
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
This completely removes the check from the _fill_buffer() path

> -	return 0;
> +	return !(ret & data->def->ctrl_masks[ST1_DRDY]);
returning a positive value here is unusual enough you should add a comment =
for
the function + use that return value.

>  }
> =20
>  /* Retrieve raw flux value for one of the x, y, or z axis.  */
> @@ -731,6 +716,20 @@ static int ak8975_read_axis(struct iio_dev *indio_de=
v, int index, int *val)
>  	ret =3D i2c_smbus_read_i2c_block_data_or_emulated(
>  			client, def->data_regs[index],
>  			sizeof(rval), (u8*)&rval);
No longer gated on ret & data->def->ctrl_masks[ST1_DRDY] which seems uninte=
ntional.

Still need a check on ret here.

> +	ret =3D i2c_smbus_read_byte_data(client,
> +				       data->def->ctrl_regs[ST2]);
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
>  	if (ret < 0)
>  		goto exit;

And this one ends up redundant I think which suggests to me the
code is inserted a few lines early.

> =20
>=20


