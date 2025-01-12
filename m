Return-Path: <linux-iio+bounces-14162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A3A0A865
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ED73A2CC9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D801A76D0;
	Sun, 12 Jan 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpisu4fq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429071465A5;
	Sun, 12 Jan 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678939; cv=none; b=OWfgGwaazsBGLUD3F2oV+o0+cwMErJ41SSzOS34V3cJodXdMQtYCoea/ZKZJrc+HBvLdYReMLEW2rBln5m/TniVfBWVqph5rjTpgl37j7N1MwqqVAKxAZPy2nukKnRbGUhbsLyuQd+IrAbAfOuqWrseMddZPwv54oUWf4d1rywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678939; c=relaxed/simple;
	bh=oULTT5EwEbcEQwD326RZMdpYMp5D5iwj0MiAB3wcB10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7UBwI1bozayKem9vizhMy+9OrshPgDByV6PL7W7rwFgTV/G9DYGoep2qct9Ey79EP8Hv+7mg8gG719gNAk3oH+GPitPumycWo18F5V9nQu6Ef3DwYy6Nx0y9u3LqgTRA1Ph9ZDQ3wBX7TtHZGYeA74neUDq56A1FP2ak7gTISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpisu4fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A5C4CEDF;
	Sun, 12 Jan 2025 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736678938;
	bh=oULTT5EwEbcEQwD326RZMdpYMp5D5iwj0MiAB3wcB10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qpisu4fqUssGJVqhHpAEw4ZpIcCxLEGKgZ4K4WNfUvwgSJH0oedW5/UhVDU+NKMGn
	 kk+2CRUJUhRv1f/hkUxBt7wHPLOY0UzxixEDB6I8lQItXz3Vixh41J/YdsUwnIQsE6
	 UIc4zAhDnXz6omXejWd2H3+shRczzvd6wO3nkK6zBLwfNeOoUR/pqaAufAknizH0qq
	 VsTnLYEk8oHVEJ+nL6XdpyJ0gXRMkjYa8dvtia7Nd1wkcITbce3ux+IrU5tHk/fw44
	 5cgOP28GkjDLg7rvtAcbrIIjAK7kD5b8jQc3H8h3LujTx0xEndlGiF17QuVbkV2w1O
	 HLGxQD7WxS3/g==
Date: Sun, 12 Jan 2025 10:48:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: accel: mc3230: add mount matrix support
Message-ID: <20250112104849.6ee09309@jic23-huawei>
In-Reply-To: <20250111-mainlining-mc3510c-v1-1-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-1-57be503addf8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 23:11:06 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio
> clients.

Trivial, but wrap patch descriptions to 75 chars (slightly
shorter than patches because tooling tends to indent it a bit!)

Otherwise this looks good to me.

Jonathan


> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index caa40a14a6316acae3a972f0ebe0b325db96eb44..48787c0494ae6f0ef1d4d22bc5a4608035cbe123 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -44,18 +44,34 @@ static const int mc3230_nscale = 115411765;
>  	.channel2 = IIO_MOD_##axis,	\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.ext_info = mc3230_ext_info, \
>  }
>  
> +struct mc3230_data {
> +	struct i2c_client *client;
> +	struct iio_mount_matrix orientation;
> +};
> +
> +static const struct iio_mount_matrix *
> +mc3230_get_mount_matrix(const struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct mc3230_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info mc3230_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mc3230_get_mount_matrix),
> +	{ }
> +};
> +
>  static const struct iio_chan_spec mc3230_channels[] = {
>  	MC3230_CHANNEL(MC3230_REG_XOUT, X),
>  	MC3230_CHANNEL(MC3230_REG_YOUT, Y),
>  	MC3230_CHANNEL(MC3230_REG_ZOUT, Z),
>  };
>  
> -struct mc3230_data {
> -	struct i2c_client *client;
> -};
> -
>  static int mc3230_set_opcon(struct mc3230_data *data, int opcon)
>  {
>  	int ret;
> @@ -141,6 +157,10 @@ static int mc3230_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "device_register failed\n");
> 


