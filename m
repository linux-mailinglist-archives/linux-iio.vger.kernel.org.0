Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B358D15D982
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNOaf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbgBNOaf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:30:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 619C32168B;
        Fri, 14 Feb 2020 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690634;
        bh=4tilaeWlKQDBKJP96290eZxsvddH5ioUkOgaUqE9bdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NnRlYLJ7Scf8P23QjejSDYY3EcgbXZFbFgkW4+rFAki86+81ya4tBKjkRBNBKE1v7
         hZ9vJ2j9VlLsuvq9Obkr9UFF5ljNPYZuhHmLU+93Vc62UX5VSafvMOuSw6zfkosnZS
         yO7vE4LNuB7GnwUTCTvbTqddVkDP+uGgDqN+xev0=
Date:   Fri, 14 Feb 2020 14:30:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 3/9] iio: gyro: adis16136: initialize adis_data
 statically
Message-ID: <20200214143029.33ec16b4@archlinux>
In-Reply-To: <20200210132606.9315-3-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
> structure"). It removes the memory allocation and moves the 'adis_data'
> information to be static on the chip_info struct.
> 
> This also adds a timeout structure to ADIS16334, since it was initially
> omitted. This was omitted (by accident) when the change was done.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adis16136.c | 61 +++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index d5e03a406d4a..1db1131e5c67 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -59,7 +59,7 @@
>  struct adis16136_chip_info {
>  	unsigned int precision;
>  	unsigned int fullscale;
> -	const struct adis_timeout *timeouts;
> +	const struct adis_data adis_data;
>  };
>  
>  struct adis16136 {
> @@ -466,22 +466,21 @@ static const char * const adis16136_status_error_msgs[] = {
>  	[ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL] = "Flash checksum error",
>  };
>  
> -static const struct adis_data adis16136_data = {
> -	.diag_stat_reg = ADIS16136_REG_DIAG_STAT,
> -	.glob_cmd_reg = ADIS16136_REG_GLOB_CMD,
> -	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,
> -
> -	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,
> -
> -	.read_delay = 10,
> -	.write_delay = 10,
> -
> -	.status_error_msgs = adis16136_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |
> -		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),
> -};
> +#define ADIS16136_DATA(_timeouts)					\
> +{									\
> +	.diag_stat_reg = ADIS16136_REG_DIAG_STAT,			\
> +	.glob_cmd_reg = ADIS16136_REG_GLOB_CMD,				\
> +	.msc_ctrl_reg = ADIS16136_REG_MSC_CTRL,				\
> +	.self_test_mask = ADIS16136_MSC_CTRL_SELF_TEST,			\
> +	.read_delay = 10,						\
> +	.write_delay = 10,						\
> +	.status_error_msgs = adis16136_status_error_msgs,		\
> +	.status_error_mask = BIT(ADIS16136_DIAG_STAT_FLASH_UPDATE_FAIL) |	\
> +		BIT(ADIS16136_DIAG_STAT_SPI_FAIL) |			\
> +		BIT(ADIS16136_DIAG_STAT_SELF_TEST_FAIL) |		\
> +		BIT(ADIS16136_DIAG_STAT_FLASH_CHKSUM_FAIL),		\
> +	.timeouts = (_timeouts),					\
> +}
>  
>  enum adis16136_id {
>  	ID_ADIS16133,
> @@ -506,41 +505,25 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
>  	[ID_ADIS16133] = {
>  		.precision = IIO_DEGREE_TO_RAD(1200),
>  		.fullscale = 24000,
> -		.timeouts = &adis16133_timeouts,
> +		.adis_data = ADIS16136_DATA(&adis16133_timeouts),
>  	},
>  	[ID_ADIS16135] = {
>  		.precision = IIO_DEGREE_TO_RAD(300),
>  		.fullscale = 24000,
> -		.timeouts = &adis16133_timeouts,
> +		.adis_data = ADIS16136_DATA(&adis16133_timeouts),
>  	},
>  	[ID_ADIS16136] = {
>  		.precision = IIO_DEGREE_TO_RAD(450),
>  		.fullscale = 24623,
> -		.timeouts = &adis16136_timeouts,
> +		.adis_data = ADIS16136_DATA(&adis16136_timeouts),
>  	},
>  	[ID_ADIS16137] = {
>  		.precision = IIO_DEGREE_TO_RAD(1000),
>  		.fullscale = 24609,
> -		.timeouts = &adis16136_timeouts,
> +		.adis_data = ADIS16136_DATA(&adis16136_timeouts),
>  	},
>  };
>  
> -static struct adis_data *adis16136_adis_data_alloc(struct adis16136 *st,
> -						   struct device *dev)
> -{
> -	struct adis_data *data;
> -
> -	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> -
> -	memcpy(data, &adis16136_data, sizeof(*data));
> -
> -	data->timeouts = st->chip_info->timeouts;
> -
> -	return data;
> -}
> -
>  static int adis16136_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -565,9 +548,7 @@ static int adis16136_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16136_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	adis16136_data = adis16136_adis_data_alloc(adis16136, &spi->dev);
> -	if (IS_ERR(adis16136_data))
> -		return PTR_ERR(adis16136_data);
> +	adis16136_data = &adis16136->chip_info->adis_data;
>  
>  	ret = adis_init(&adis16136->adis, indio_dev, spi, adis16136_data);
>  	if (ret)

