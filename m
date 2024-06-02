Return-Path: <linux-iio+bounces-5626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838618D7592
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47881C20D68
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B93BB25;
	Sun,  2 Jun 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu5OP0yy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB210795;
	Sun,  2 Jun 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333704; cv=none; b=Yrf/daOrwtmMC4813g6RYpgc2EpN7ScLZ1enRgBpBSlrEFtoIcPqzn4M9SAqtCDzjo7Sl8cZSxExP9tyOxpNt1Hy1P7jMjMfdix5bdoLxL6JRg7Wvl10HXi0PI2fSdiLZsjbV4rjM1KD3n2l1m086M6V4GV2182lEfT3pTkUf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333704; c=relaxed/simple;
	bh=gGA8q7p+HL++NKusv8U13tSZ+AcCuP1M407ZMinv5V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cS3VvJgY9dtGbBm0AexqdwN2QpjHnq07F6fFIQxqGNxNujgKZUM5egmaNxvWF/HWGDJ8ex8bnOo66MDyOaDNJ7MKo/yc0pwEKpOr9l2yIXn6ivDO+hHMPoO1Up2PvwFzTNcr2Q+yafyh5tdICO19QIx4Me265DCZYJPk3RGOKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu5OP0yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3043C2BBFC;
	Sun,  2 Jun 2024 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333703;
	bh=gGA8q7p+HL++NKusv8U13tSZ+AcCuP1M407ZMinv5V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cu5OP0yy5qkHwglCJBgKIiwSAegEkQGaL7n75TV8f+tz943v0K5NbQMJOvYejY1o1
	 PMGKAHmSErTQlC0mmYuYoKzDNQB+pdbSPWjxAZXZvvwEBnohGzl6qNCB3mM87/D+Kr
	 BREMP3Cn8ykJIIC52YBxRDaxa916/2mkz4pgN5kgBU2Z51/Gax98LWOspMaUAB13+Y
	 ZEOzTsCxAnnBCZs2tfoMimO+qj8wbw2jDsVr7T00w0/2lndWvGVN6DMAuO129Qu+Ss
	 nMSf8cjUTnzrqhTw2kmW+KMMz5AUmUsTY6kolLq55MLu5LvNkYH56fa1EW+/Z/OI3K
	 nT1HTFWsog3kA==
Date: Sun, 2 Jun 2024 14:08:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma7660: add mount-matrix support
Message-ID: <20240602140814.642417b2@jic23-huawei>
In-Reply-To: <20240527080043.2709-1-val@packett.cool>
References: <20240527080043.2709-1-val@packett.cool>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 05:00:18 -0300
Val Packett <val@packett.cool> wrote:

> Allow using the mount-matrix device tree property to align the
> accelerometer relative to the whole device.
> 
> Signed-off-by: Val Packett <val@packett.cool>
Applied to the togreg branch of iio.git.  Initially pushed out as testing
to let 0-day see if it can find anything we missed

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7660.c | 50 ++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 260cbceaa..9d23f28d5 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -38,21 +38,6 @@
>  
>  static const int mma7660_nscale = 467142857;
>  
> -#define MMA7660_CHANNEL(reg, axis) {	\
> -	.type = IIO_ACCEL,	\
> -	.address = reg,	\
> -	.modified = 1,	\
> -	.channel2 = IIO_MOD_##axis,	\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -}
> -
> -static const struct iio_chan_spec mma7660_channels[] = {
> -	MMA7660_CHANNEL(MMA7660_REG_XOUT, X),
> -	MMA7660_CHANNEL(MMA7660_REG_YOUT, Y),
> -	MMA7660_CHANNEL(MMA7660_REG_ZOUT, Z),
> -};
> -
>  enum mma7660_mode {
>  	MMA7660_MODE_STANDBY,
>  	MMA7660_MODE_ACTIVE
> @@ -62,6 +47,21 @@ struct mma7660_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	enum mma7660_mode mode;
> +	struct iio_mount_matrix orientation;
> +};
> +
> +static const struct iio_mount_matrix *
> +mma7660_get_mount_matrix(const struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan)
> +{
> +	struct mma7660_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info mma7660_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mma7660_get_mount_matrix),
> +	{ }
>  };
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, MMA7660_SCALE_AVAIL);
> @@ -75,6 +75,22 @@ static const struct attribute_group mma7660_attribute_group = {
>  	.attrs = mma7660_attributes
>  };
>  
> +#define MMA7660_CHANNEL(reg, axis) {	\
> +	.type = IIO_ACCEL,	\
> +	.address = reg,	\
> +	.modified = 1,	\
> +	.channel2 = IIO_MOD_##axis,	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.ext_info = mma7660_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec mma7660_channels[] = {
> +	MMA7660_CHANNEL(MMA7660_REG_XOUT, X),
> +	MMA7660_CHANNEL(MMA7660_REG_YOUT, Y),
> +	MMA7660_CHANNEL(MMA7660_REG_ZOUT, Z),
> +};
> +
>  static int mma7660_set_mode(struct mma7660_data *data,
>  				enum mma7660_mode mode)
>  {
> @@ -187,6 +203,10 @@ static int mma7660_probe(struct i2c_client *client)
>  	mutex_init(&data->lock);
>  	data->mode = MMA7660_MODE_STANDBY;
>  
> +	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->info = &mma7660_info;
>  	indio_dev->name = MMA7660_DRIVER_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


