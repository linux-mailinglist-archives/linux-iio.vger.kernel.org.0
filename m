Return-Path: <linux-iio+bounces-14243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19FA0AAE8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC85F164B4B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960541BD9E3;
	Sun, 12 Jan 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYtzS9cx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB01E51D;
	Sun, 12 Jan 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699550; cv=none; b=RmfYrWf+FQp4nfut8uCXQpisX2XYEbbJcw7jgkBYdBSl2Uj5mOqAm9MwrTFpX+bESp2w12unyDMhjw/rEOV9hRkadSROEeZwqkgnVemmqwuYQUNUCfsEuCgLGNgyXXH2wW9AFkB1kz1/06cbHqxLWvegzTn3Ocaznww89HQFogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699550; c=relaxed/simple;
	bh=lz5zqOFL7ak19fBOSxS31MoANmKBShpcQahGIl3lwG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YckuCDhXOCBUYFubtBFhO+j7T75mBtcWf6V+misgQmWSo2v/Kom0/QiiMO7y8S1BSfstzAGe2fsozPJEBRmtZfpXQ2HPXgmFn3Bh4Tau1VW1UmsKMuKzzxFNu/2v/t6GZQn7oLIvmvffn+mthNmeY/J9Vo+Gqe90ScecDgNMGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYtzS9cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3265CC4CEDF;
	Sun, 12 Jan 2025 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699549;
	bh=lz5zqOFL7ak19fBOSxS31MoANmKBShpcQahGIl3lwG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYtzS9cxQY3xWp9Ttiwc4oRzqZvoPbajYUNBDHTI3+5S+rnGxdEO7Q0E6jJN0uIZI
	 64/0AhsTxRqih04sXSQtRJEoaDBHNvk8rNCWC5VlAPQRDU4czDhMH5LPQLVz7VI3NF
	 aS7DuXUzPZ6efNONQv0v3est9d4vfeEuEYhJCWoyZxENFG7qHPeOjc/fDLd/UtqZge
	 cFlymboGi25ZkVTxe25H1Kj3COkNjGhZKqy4TkPbCPEe/2aBYjnzlvL7E2bGuKxQ2R
	 W7lSe6GIJLIS+soJRK8/qISsixo2VMkT9lASL952LLjucUpOfuxHsS5rDly7eOeuMv
	 Cp7OMQRZjwT0g==
Date: Sun, 12 Jan 2025 16:32:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: accel: mc3230: add multiple devices support
Message-ID: <20250112163221.4782ad53@jic23-huawei>
In-Reply-To: <20250112-mainlining-mc3510c-v3-4-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
	<20250112-mainlining-mc3510c-v3-4-9ee6520ab69d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 15:25:38 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This patch allows to add new devices to this driver.
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
One comment inline.

Jonathan

> ---
>  drivers/iio/accel/mc3230.c | 50 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index ba30c904d3f67002deeb3ca5a7e12bfae312e05f..1b58f3ea50655b6563a78a2531b16a8088e8f8d5 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -22,20 +22,29 @@
>  #define MC3230_MODE_OPCON_STANDBY	0x03
>  
>  #define MC3230_REG_CHIP_ID		0x18
> -#define MC3230_CHIP_ID			0x01
> -
>  #define MC3230_REG_PRODUCT_CODE		0x3b
> -#define MC3230_PRODUCT_CODE		0x19
>  
>  /*
>   * The accelerometer has one measurement range:
>   *
>   * -1.5g - +1.5g (8-bit, signed)
>   *
> - * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
>   */
>  
> -static const int mc3230_nscale = 115411765;
> +struct mc3230_chip_info {
> +	const u8 chip_id;
> +	const char *name;
> +	const u8 product_code;

Keep chip_id and product_code together.  They are coming from
the same place and closely related fields.  Original
ordering in v1 made more sense than this.

> +	const int scale;
> +};
> +
> +static struct mc3230_chip_info mc3230_chip_info = {
> +	.chip_id = 0x01,
> +	.name = "mc3230",
> +	.product_code = 0x19,
> +	/* (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765 */
> +	.scale = 115411765,
> +};
>  
>  #define MC3230_CHANNEL(reg, axis) {	\
>  	.type = IIO_ACCEL,	\
> @@ -48,6 +57,7 @@ static const int mc3230_nscale = 115411765;
>  }
>  
>  struct mc3230_data {
> +	const struct mc3230_chip_info *chip_info;
>  	struct i2c_client *client;
>  	struct iio_mount_matrix orientation;
>  };
> @@ -111,7 +121,7 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> -		*val2 = mc3230_nscale;
> +		*val2 = data->chip_info->scale;
>  		return IIO_VAL_INT_PLUS_NANO;
>  	default:
>  		return -EINVAL;
> @@ -127,15 +137,28 @@ static int mc3230_probe(struct i2c_client *client)
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct mc3230_data *data;
> +	const struct mc3230_chip_info *chip_info;
> +
> +	chip_info = i2c_get_match_data(client);
> +	if (chip_info == NULL) {
> +		dev_err(&client->dev, "failed to get match data");
> +		return -ENODATA;
> +	}
>  
>  	/* First check chip-id and product-id */
>  	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
> -	if (ret != MC3230_CHIP_ID)
> -		return (ret < 0) ? ret : -ENODEV;
> +	if (ret != chip_info->chip_id) {
> +		dev_info(&client->dev,
> +			"chip id check fail: 0x%x != 0x%x !\n",
> +			ret, chip_info->chip_id);
> +	}
>  
>  	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
> -	if (ret != MC3230_PRODUCT_CODE)
> -		return (ret < 0) ? ret : -ENODEV;
> +	if (ret != chip_info->product_code) {
> +		dev_info(&client->dev,
> +			"product code check fail: 0x%x != 0x%x !\n",
> +			ret, chip_info->product_code);
> +	}
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev) {
> @@ -144,11 +167,12 @@ static int mc3230_probe(struct i2c_client *client)
>  	}
>  
>  	data = iio_priv(indio_dev);
> +	data->chip_info = chip_info;
>  	data->client = client;
>  	i2c_set_clientdata(client, indio_dev);
>  
>  	indio_dev->info = &mc3230_info;
> -	indio_dev->name = "mc3230";
> +	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = mc3230_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
> @@ -200,13 +224,13 @@ static int mc3230_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
>  
>  static const struct i2c_device_id mc3230_i2c_id[] = {
> -	{ "mc3230" },
> +	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>  
>  static const struct of_device_id mc3230_of_match[] = {
> -	{ .compatible = "mcube,mc3230" },
> +	{ .compatible = "mcube,mc3230", &mc3230_chip_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mc3230_of_match);
> 


