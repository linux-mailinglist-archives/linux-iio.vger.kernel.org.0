Return-Path: <linux-iio+bounces-9299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563E970330
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2806282AF1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08E15FCE7;
	Sat,  7 Sep 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKiuVA79"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB81B85DC;
	Sat,  7 Sep 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727234; cv=none; b=ND6nXY78S7YM4IMxenkfnirBMa7AV1jiKivZwAg/PEczLMrWweUn0j30xFaert1SBDmOEI/CKTZQSSbXm+vmk88GVG/VjivvZYaVJvb0WGe8jR918k67LrGr1RwQYVQ7Tj6dcQrHI8zCP5QV5aba7PqeO6ViksNvULELjz7i62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727234; c=relaxed/simple;
	bh=hTd2Jrdk4vfPdEIOB7bAzp4qujyHJie0PQKTucUpqNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/bdjrDuQJdADaCFwlkL7GKJt8qvlRWOYyNTBjWYmlYmXJ9PY3/vA5AkvdsWYmGD3xy+GulitUcRCI4kyCzbe6pCWwQrOXXsVI6CF0HBB151F35swk+Gl9abqixTcX6LBqgYVPXrQPyqt8Jd+YD300rnp7koKIibgCbSmbUlWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKiuVA79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA8C4CEC2;
	Sat,  7 Sep 2024 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725727233;
	bh=hTd2Jrdk4vfPdEIOB7bAzp4qujyHJie0PQKTucUpqNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKiuVA79Ui3kx6VNzzYi41/ZZ4Y55+8vGtfzAMC4pl125Bv1rbfADeZeLFDkhvgkZ
	 hlsw64wv0ik5QeG1apozIMrUaTDjdUYLcleYTC2IE/FUAhC7bn718ce02ZuNC8XNAw
	 lgeyrofviW4t81FkXNQjRtw0728wIt+bOrA0MhIwo3PhvKaPNcakFrJm/mb3MIJ9aq
	 cVy95rshMoGxxrYINDQShNvlxeemaZ6M0YqVu4KwU/f7KAYqMzn4AgIxhd/xhtO8yJ
	 Wb6DSsoyIK6UaiUBKvPHMvbdW6XO42fXRo5qO4aQYD4Up+Vo4hXX0OWXAktBOgGmQE
	 43Rp4N48ECupA==
Date: Sat, 7 Sep 2024 17:40:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID
 check
Message-ID: <20240907174028.75840886@jic23-huawei>
In-Reply-To: <20240903035636.9559-2-abhashkumarjha123@gmail.com>
References: <20240903035636.9559-1-abhashkumarjha123@gmail.com>
	<20240903035636.9559-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 09:26:35 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> The commit adds a check for the sensor's model ID. We read the model
> identification register (0xC0) and expect a value of 0xEE.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

Small comment on the message below

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 8d4f3f849..31d6aeb95 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -39,8 +39,11 @@
>  
>  #define VL_REG_RESULT_INT_STATUS			0x13
>  #define VL_REG_RESULT_RANGE_STATUS			0x14
> +#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
>  #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
>  
> +#define VL53L0X_MODEL_ID_VAL				0xEE
> +
>  struct vl53l0x_data {
>  	struct i2c_client *client;
>  	struct completion completion;
> @@ -223,6 +226,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
>  	int error;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -237,6 +241,13 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> +	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	if (ret != VL53L0X_MODEL_ID_VAL)
> +		dev_info(&client->dev, "Received invalid model id: 0x%x", ret);
Unknown model id:

It's probably valid, we just don't know what it means!

> +
>  	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_supply))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> @@ -265,8 +276,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  
>  	/* usage of interrupt is optional */
>  	if (client->irq) {
> -		int ret;
> -
>  		init_completion(&data->completion);
>  
>  		ret = vl53l0x_configure_irq(client, indio_dev);


