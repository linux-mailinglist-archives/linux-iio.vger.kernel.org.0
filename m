Return-Path: <linux-iio+bounces-8917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67496718C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2BA1F228AF
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61317E01C;
	Sat, 31 Aug 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Q/UXhy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A0193;
	Sat, 31 Aug 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725107084; cv=none; b=QLu7AQqYU1hSQrGEQRuzipRUIeXMpw5GkG/senRH9maVk2QNWHPJVGogfmjphlRD5TC5F2gZ8vscTyNxB4rk8W5LrGQM9ZZAVz8FMZmxFO3HAcQfF2twXE316ecf2ekQYLTR6ZIlD+JRX6o2oCuALzM4/8KyLy2m5o7npR/kKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725107084; c=relaxed/simple;
	bh=FJujHEIrIRqL8H5Byt3mi6S9BjorpsPwOOBwfAswh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNxeHNsB75YcbLZ98IAm6O8YlZ4zwLdu5tEX+Hri7gq6ZtQrcGn7zNU0THunHR6qyTyEc6/55Hune3nAhGBNPG3YyGTZ1m1ZZvNNpPOymQatqR/N6T1kV6K5qsYAntcUaeGz/ianCGamFk/zP+NtAL7e4RjnyijyrRJ0P5LeF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Q/UXhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4DAC4CEC0;
	Sat, 31 Aug 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725107083;
	bh=FJujHEIrIRqL8H5Byt3mi6S9BjorpsPwOOBwfAswh+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/Q/UXhyFDGsqQPUEPaiUtv+ZEsHHmSDZ/mH3w3eIsNPQAGOWhESCvknN5IlJPP+m
	 O+ugiZ+unttmWrJ2Pspggk8tCd6CQPzCw7xyBKG1XXaLu9laO6VoIFT6uLrmeHcVF9
	 5pIjLF1C4Q+D69UFsmKVUDo/kqwhmaaNFeRrrUwaZs9t2n9JI6dQrBsQBdv3ymnxYw
	 rYbbxlyGoKljjceG5Di42NheWktaq2tMKpNWMWFkuHJJKooAEvcUp5l/U0fW6IZnvR
	 P8tiY/RWevlyGhCck338odQKPTa92HRWm7qWhyRfbLFp7YdIew6eOao0xR+zUSvQw7
	 q71OwHXNWh9Fg==
Date: Sat, 31 Aug 2024 13:24:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: proximity: vl53l0x-i2c: Added sensor ID check
Message-ID: <20240831132437.1584a0e3@jic23-huawei>
In-Reply-To: <20240830201627.298264-2-abhashkumarjha123@gmail.com>
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
	<20240830201627.298264-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 01:46:25 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> The commit adds a check for the sensor's model ID. We read the model
> identification register (0xC0) and expect a value of 0xEE.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 8d4f3f849..2b3dd18be 100644
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
> @@ -237,6 +241,11 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> +	ret = i2c_smbus_read_byte_data(data->client, VL_REG_IDENTIFICATION_MODEL_ID);
> +	if (ret != VL53L0X_MODEL_ID_VAL)
> +		return dev_err_probe(&client->dev, ret,
This first ret should be the error return you want.  So -EINVAL or something like that.

> +				     "Received invalid model id: 0x%x", ret);

This needs to be message only, not an error return.

If we return an error here we break any future use of fallback device tree compatibles
for future devices running with an old kernel. 

So the most we should do is print a message that observes we don't recognise
the device, then carry on anyway.

We used to get this wrong in IIO and haven't yet fixed all drivers, but
I definitely don't want add such hard failures to more drivers.


> +
>  	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_supply))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> @@ -265,8 +274,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  
>  	/* usage of interrupt is optional */
>  	if (client->irq) {
> -		int ret;
> -
>  		init_completion(&data->completion);
>  
>  		ret = vl53l0x_configure_irq(client, indio_dev);


