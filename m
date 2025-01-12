Return-Path: <linux-iio+bounces-14164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB91A0A874
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18733A75BF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56A1A8F7A;
	Sun, 12 Jan 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iittqiyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420AB6FB0;
	Sun, 12 Jan 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679700; cv=none; b=lq3IQhPAABvlu6Vo9eiRaHUCInR5RApm9fBLIsdTkaONtmGxTY/nxgrAH5dbQOjoafKoB9u3AzOfaHBVLmauk+aUyy9IKw+IBcNGB40opGiHCt1QoQDQRcanlLd2og2N9jdax0bB3vEeBTwe6YyI/mCyKjvvb9SGZi+Z6srewMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679700; c=relaxed/simple;
	bh=XGOHkLyKfL1ZlOo2dvUVuMj4ArhO40Qqjv1iydV4reg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2pj/1dPV28xEomD4slq19yMNWfi9zmjog4B7jmQU3pWN73Rr1iTpYVIU1O+pIeE8sQKoRLRNY70uUiZUXJGOvKind0f2xeQD4gN8JLaKy+Q0TcfeR5hoqMRNIEAXqs+Ztu19vmiGoSFQWL70WyU9Gx7WTmlixTxGNQxFXuHYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iittqiyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1BEC4CEDF;
	Sun, 12 Jan 2025 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736679699;
	bh=XGOHkLyKfL1ZlOo2dvUVuMj4ArhO40Qqjv1iydV4reg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iittqiyWL1RNIvNE7SbSW+cOwVxkEFX8gRIJf/6oUhXaVZqQVISrMLxoRBDnjdPJU
	 FvtB5BUEfoIeJY716Rutgz0VCtBnsM3f7wA7O34AU1phG5eb+ohAXU15m8kHiVmSiD
	 IUrywhnUbyVttCQgTHvciDFaSn0vuyQs7XmQ5PGUafZs6JmcUbpPUEQZRI1EPkso7R
	 GJSz6qV090QYkV60pW0vdBjlx8BryAySxddr5Q7IKH0YkVNaoy4NpEssAgIXgwcbW6
	 iBa4ZBTLmr9NdPtD6N4QjenoD5TFvh1zkosDjKj27M0INjJX3mAXU39uwSFfE4fsZr
	 k0MlkFQathuiw==
Date: Sun, 12 Jan 2025 11:01:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: accel: mc3230: add mc3510c support
Message-ID: <20250112110130.6fbb848d@jic23-huawei>
In-Reply-To: <20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 23:11:08 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This commit integrates support for the mc3510c into the mc3230 driver.
> 
> Tested on Huawei MediaPad T3 10 (huawei-agassi)
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
General approach to this sort of change is a first 'no operation' patch
that refactors the driver to allow for multiple device support, and a second
patch that adds the support. In this case the second patch is very simple
though so I don't mind that much.

Mostly looks good, but a few things that are non obvious the first
time you write a patch like this.  Mostly avoiding pitfalls we have fallen
down in the past ;)

Jonathan

> ---
>  drivers/iio/accel/mc3230.c | 55 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 3cad6f2d7a2a79df38f90e5656763f6ed019a920..ebbb96c658d87a83007c7c3c7212ce9ebf039963 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -22,20 +22,41 @@
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
> +enum mc3xxx_chips {

In IIO drivers avoid use of wild cards in naming of anything.
They go wrong far too often as other parts match the coding and
drivers start supporting additional devices that don't
Name everything after the first supported part unless it applies
only to a different device, in which case name it after the first
device it applies to.  This is a hard learned lesson over the years!

> +	MC3230,
> +	MC3510C,
> +};
> +
> +struct mc3xxx_chip_info {
> +	const char *name;
> +	const u8 chip_id;
> +	const u8 product_code;
> +	const int scale;
> +};
> +
> +static struct mc3xxx_chip_info mc3xxx_chip_info_tbl[] = {
> +	[MC3230] = {
> +		.name = "mc3230",
> +		.chip_id = 0x01,
> +		.product_code = 0x19,
> +		.scale = 115411765, // (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765

As noted in Markuss' review /* */ for comments preferred for consistency
reasons.

> +	},
> +	[MC3510C] = {
> +		.name = "mc3510c",
> +		.chip_id = 0x23,
> +		.product_code = 0x10,
> +		.scale = 625000000, // Was obtained empirically
> +	},
> +};
We used to do this table thing a lot, but have over time come to conclusion
it is much clearer just to have separate named structures and no enum.

struct mxc3230_chip_info mx3230_chip_info = {
};
struct mxc3230_chip_info mx3510c_chip_info = {
};
etc

>  
>  #define MC3230_CHANNEL(reg, axis) {	\
>  	.type = IIO_ACCEL,	\
> @@ -50,6 +71,7 @@ static const int mc3230_nscale = 115411765;
>  struct mc3230_data {
>  	struct i2c_client *client;
>  	struct iio_mount_matrix orientation;
> +	const struct mc3xxx_chip_info *chip_info;
>  };
>  
>  static const struct iio_mount_matrix *
> @@ -111,7 +133,7 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> -		*val2 = mc3230_nscale;
> +		*val2 = data->chip_info->scale;
>  		return IIO_VAL_INT_PLUS_NANO;
>  	default:
>  		return -EINVAL;
> @@ -127,15 +149,23 @@ static int mc3230_probe(struct i2c_client *client)
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct mc3230_data *data;
> +	const struct mc3xxx_chip_info *chip_info;
>  
> +	chip_info = i2c_get_match_data(client);
Whilst very unlikely to fail (it won't), usual convention is to check
the chip_info is not NULL anyway.  Maybe in future that function will gain
paths that more likely to fail than today so good to be paranoid on this one.
We aren't completely consistent on this, so some drivers may not check it.

>  	/* First check chip-id and product-id */
>  	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
> -	if (ret != MC3230_CHIP_ID)
> +	if (ret != chip_info->chip_id) {
> +		dev_err(&client->dev,
> +		"chip id check fail: 0x%x != 0x%x !\n", ret, chip_info->chip_id);
dev_info() and do not fail on this.  Also, indent the message to align
below the &

Hard matches against chip IDs break the concept of Device Tree fallback
compatibles.  If a new device is released that is backwards compatible
with an older one we want the driver to work.  It is fine to print
a message thought to say we don't recognise it.

>  		return (ret < 0) ? ret : -ENODEV;
> +	}
>  
>  	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
> -	if (ret != MC3230_PRODUCT_CODE)
> +	if (ret != chip_info->product_code) {
> +		dev_err(&client->dev,
> +		"product code check fail: 0x%x != 0x%x !\n", ret, chip_info->product_code);
>  		return (ret < 0) ? ret : -ENODEV;
As above.

> +	}



