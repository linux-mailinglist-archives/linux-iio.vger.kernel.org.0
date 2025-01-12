Return-Path: <linux-iio+bounces-14239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBEA0AAD8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED527A27FB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B061BDA97;
	Sun, 12 Jan 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuFvnct9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB220DF4;
	Sun, 12 Jan 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699318; cv=none; b=Rgkhwy3JRYSMJnRPFB4IL/8oz3dEHm4wLjILrS3Kps/gtPCcwztjXmNC16AuwSO4sTN8gLD6l0wEjSw8mWP3pf/1PjNeFyB4vNXow/3hlRHPHaMdGMDOYWFW6UWQlT0GRQzhwxYcu4EIzPcECRdLUw8NxcumjGK070feBShExKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699318; c=relaxed/simple;
	bh=d6WbAgUvVWJM2txfvcWV+rFy2gLwA7SLblKDpX8dCCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEtN3cLm27qwpQyVSk/IsAAo7rlTJ4KX7iJjePjeMWNkS7Ux2GuFvCIWx3q85Kj3v6wl3wJyLI5/ezPfiOlaMjXGxAuL7/nZ/x4Xcp0E2MjKSqtErZOoba9QBdE/v5elqmEatWuBsEbqWvpvZ1ln/3EbkhaZrc5wkELulQwRI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuFvnct9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7B5C4CEDF;
	Sun, 12 Jan 2025 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699318;
	bh=d6WbAgUvVWJM2txfvcWV+rFy2gLwA7SLblKDpX8dCCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuFvnct9G03+Uunf5jdiABk9vdUiuHv050tbPUbSy8DyffylFsQqql+d9aW1HCv2u
	 QrmYsdncs8pOeQfjKgY4bCXBA6Xeyer9kYpvRjYD0gGw6jMQNC/ECk5lKLtW5NSx6P
	 rNMlw261kQJl0ZIZhGvpAv7mTVxVsGkPNQr4FwRbYBOjxTqEcoQDcwrUXvsVPboLf8
	 e6t+mpN2Th1pG+LetAOGap5QS1DfwG/2oNIor0a1HYiS+IMJI0kApDPjvXAid0KAgC
	 d5R0R2fOpg6U0O0elLJYMdZRPTS2jQFwqnZnd1dbUw/HniPhQFxC1uaSwIVaJ9WO/L
	 7NaAnfTcyViMw==
Date: Sun, 12 Jan 2025 16:28:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: accel: mc3230: add mount matrix support
Message-ID: <20250112162829.2dc2548a@jic23-huawei>
In-Reply-To: <20250112-mainlining-mc3510c-v3-2-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
	<20250112-mainlining-mc3510c-v3-2-9ee6520ab69d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 15:25:36 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This patch allows to read a mount-matrix device tree
> property and report to user-space or in-kernel iio clients.
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index caa40a14a6316acae3a972f0ebe0b325db96eb44..a153a3f715ed7f2f1417618715767f265b49191d 100644
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
> +	{}
Trivial but if you are going around again for some other reason:
I'm (slowly) trying to standarize on { } (with a space) for these terminators in IIO.

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


