Return-Path: <linux-iio+bounces-12877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CA9DF277
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8342162EC4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E51A76C8;
	Sat, 30 Nov 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq5xlcsr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321B192D6E;
	Sat, 30 Nov 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990009; cv=none; b=FxVQKuzJNtLUKd0Rz9vSh+ZxddBZxerez4Urm6fUJhGLnrDO22J5uCpTEhSnTSO38uo3FGVQDypEnW4VTMYoEvgKBINVNC/KWfX38aU36TuNuTfjI0oCBpV1NFs8uhXIgoruY4JSkEn9r45HLiMG/UE9/6RIEcmxcHy1Yuy3ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990009; c=relaxed/simple;
	bh=QoYeSS1hADKQtStPydaoUoJCheHsMe8g5J8VnplG2II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg5fbRjh1PNra4HH2QnYP/toOjJyTQ70RH6fusnm+t8y/jk5omEmej+16UeOnXKbEhlIQnmwORWKQ3fmRKCTOinwpFDPeoVosV2BaX3BJ+VLmRC4ruboALrD1B74enfmdPzHAK420WaM0OFYHFp7Lm8ieD6tA2gz1XJr/va5Mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq5xlcsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79610C4CECC;
	Sat, 30 Nov 2024 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990008;
	bh=QoYeSS1hADKQtStPydaoUoJCheHsMe8g5J8VnplG2II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xq5xlcsr8ucnfoVZ5gIRPXN8fA3Uv5qoSVjrh+jvG/j7zkXyuH7QJbuzbP/GrNXFV
	 mYlb1zTG2GmqsAPVaqvWRMnEnWjSb8TrTJXXeVAKO9vjnEc4ulegGWXhWKMifX2zTh
	 Ikncoq5SbgCcZcreCmMmEvmTomoI6p4CEIX27KDQorSaJXyxkJGcn2TAUzuYoX2OrF
	 1DGxV2XuvcDqXLVVhsYCeYFz4NveYiV0sOf8vYf2UcepwujAmjJdSycoaqxq80tqw+
	 1GewFvUwd1WEozdcE/+9/xGUgQkjYOkHe6/owZtC26Xanmv78j9zcgYRMYXlUlNce+
	 JjCao30aarRyA==
Date: Sat, 30 Nov 2024 18:06:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: kx022a: Support ROHM KX134ACR-LBZ
Message-ID: <20241130180640.6de3b5b4@jic23-huawei>
In-Reply-To: <27c43c595de1f3f698ace671922d4f5a48c3cd54.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
	<27c43c595de1f3f698ace671922d4f5a48c3cd54.1732783834.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:02:45 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The register interface of the ROHM KX134ACR-LBZ accelerometer is
> almost identical to the KX132ACR-LBZ. The main difference between these
> accelerometers is that the KX134ACR-LBZ supports different G-ranges. The
> driver can model this by informing different scale to users. Also, the
> content of the "who_am_I" register is different.
> 
> Add an ID and scales for the KX134ACR-LBZ.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied 2-4

Thanks,

Jonathan

> 
> ---
> Revision history:
>   v2 => v3:
>   - patch number changed because patches were dropped.
>   v1 => v2:
>   - patch number changed because a change was added to the series.
>   - rebased on iio/testing to avoid conflicts with queued fixes.
> ---
>  drivers/iio/accel/kionix-kx022a-i2c.c |  2 ++
>  drivers/iio/accel/kionix-kx022a-spi.c |  2 ++
>  drivers/iio/accel/kionix-kx022a.c     | 36 +++++++++++++++++++++++++++
>  drivers/iio/accel/kionix-kx022a.h     |  2 ++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> index 8a1d4fc28ddd..9fd049c2b62e 100644
> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> @@ -39,6 +39,7 @@ static const struct i2c_device_id kx022a_i2c_id[] = {
>  	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
>  	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
>  	{ .name = "kx132acr-lbz", .driver_data = (kernel_ulong_t)&kx132acr_chip_info },
> +	{ .name = "kx134acr-lbz", .driver_data = (kernel_ulong_t)&kx134acr_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
> @@ -47,6 +48,7 @@ static const struct of_device_id kx022a_of_match[] = {
>  	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>  	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
>  	{ .compatible = "rohm,kx132acr-lbz", .data = &kx132acr_chip_info },
> +	{ .compatible = "rohm,kx134acr-lbz", .data = &kx134acr_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
> index f798b964d0b5..b20978afc565 100644
> --- a/drivers/iio/accel/kionix-kx022a-spi.c
> +++ b/drivers/iio/accel/kionix-kx022a-spi.c
> @@ -39,6 +39,7 @@ static const struct spi_device_id kx022a_id[] = {
>  	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
>  	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
>  	{ .name = "kx132acr-lbz", .driver_data = (kernel_ulong_t)&kx132acr_chip_info },
> +	{ .name = "kx134acr-lbz", .driver_data = (kernel_ulong_t)&kx134acr_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, kx022a_id);
> @@ -47,6 +48,7 @@ static const struct of_device_id kx022a_of_match[] = {
>  	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
>  	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
>  	{ .compatible = "rohm,kx132acr-lbz", .data = &kx132acr_chip_info },
> +	{ .compatible = "rohm,kx134acr-lbz", .data = &kx134acr_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, kx022a_of_match);
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index b23a27623a46..9fe16802c125 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -408,6 +408,14 @@ static const int kx022a_scale_table[][2] = {
>  	{ 0, 4788403 },
>  };
>  
> +/* KX134ACR-LBZ ranges are (+/-) 8, 16, 32, 64 G */
> +static const int kx134acr_lbz_scale_table[][2] = {
> +	{ 0, 2394202 },
> +	{ 0, 4788403 },
> +	{ 0, 9576807 },
> +	{ 0, 19153613 },
> +};
> +
>  static int kx022a_read_avail(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     const int **vals, int *type, int *length,
> @@ -1236,6 +1244,34 @@ const struct kx022a_chip_info kx132acr_chip_info = {
>  };
>  EXPORT_SYMBOL_NS_GPL(kx132acr_chip_info, IIO_KX022A);
>  
> +const struct kx022a_chip_info kx134acr_chip_info = {
> +	.name				= "kx134acr-lbz",
> +	.regmap_config			= &kx022a_regmap_config,
> +	.channels			= kx022a_channels,
> +	.num_channels			= ARRAY_SIZE(kx022a_channels),
> +	.scale_table			= kx134acr_lbz_scale_table,
> +	.scale_table_size		= ARRAY_SIZE(kx134acr_lbz_scale_table) *
> +					  ARRAY_SIZE(kx134acr_lbz_scale_table[0]),
> +	.fifo_length			= KX022A_FIFO_LENGTH,
> +	.who				= KX022A_REG_WHO,
> +	.id				= KX134ACR_LBZ_ID,
> +	.cntl				= KX022A_REG_CNTL,
> +	.cntl2				= KX022A_REG_CNTL2,
> +	.odcntl				= KX022A_REG_ODCNTL,
> +	.buf_cntl1			= KX022A_REG_BUF_CNTL1,
> +	.buf_cntl2			= KX022A_REG_BUF_CNTL2,
> +	.buf_clear			= KX022A_REG_BUF_CLEAR,
> +	.buf_status1			= KX022A_REG_BUF_STATUS_1,
> +	.buf_read			= KX022A_REG_BUF_READ,
> +	.inc1				= KX022A_REG_INC1,
> +	.inc4				= KX022A_REG_INC4,
> +	.inc5				= KX022A_REG_INC5,
> +	.inc6				= KX022A_REG_INC6,
> +	.xout_l				= KX022A_REG_XOUT_L,
> +	.get_fifo_bytes_available	= kx022a_get_fifo_bytes_available,
> +};
> +EXPORT_SYMBOL_NS_GPL(kx134acr_chip_info, IIO_KX022A);
> +
>  int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
>  {
>  	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 36e9d9de8c13..ea32fd252a38 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -14,6 +14,7 @@
>  #define KX022A_REG_WHO		0x0f
>  #define KX022A_ID		0xc8
>  #define KX132ACR_LBZ_ID		0xd8
> +#define KX134ACR_LBZ_ID		0xcc
>  
>  #define KX022A_REG_CNTL2	0x19
>  #define KX022A_MASK_SRST	BIT(7)
> @@ -190,5 +191,6 @@ int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chi
>  extern const struct kx022a_chip_info kx022a_chip_info;
>  extern const struct kx022a_chip_info kx132_chip_info;
>  extern const struct kx022a_chip_info kx132acr_chip_info;
> +extern const struct kx022a_chip_info kx134acr_chip_info;
>  
>  #endif


