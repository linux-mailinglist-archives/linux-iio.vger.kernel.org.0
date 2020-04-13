Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0469B1A698D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgDMQOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbgDMQOp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:14:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248C52072C;
        Mon, 13 Apr 2020 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586794484;
        bh=I6EHlbscrcmXYTiKJFDDkY/yKiNbibAtfCLXIQN3Mag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8kt6Dz2dJE/X7OU1kzm6ZZp69UqLLhwJ+IBatdE32wRictLUBHXuozbmA2S3zt1E
         hGx26ObMjgLKwEDXhs24O+YCll8qr2PsJ9vY8yMkwfbbwYmvFaFuHY/DLN2Bi0YPDe
         5tM1Ahwv8WhS7YdZDHjJdcHGV6iJvQ+moEpKMoDc=
Date:   Mon, 13 Apr 2020 17:14:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandru.tachici@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Message-ID: <20200413171441.13794dd9@archlinux>
In-Reply-To: <20200413082044.81101-2-alexandru.ardelean@analog.com>
References: <20200413082044.81101-1-alexandru.ardelean@analog.com>
        <20200413082044.81101-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 11:20:44 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The change is more cosmetic. There is no need to reference this table in
> the probe function since 'of_device_get_match_data' is used, which obtains
> this information from the driver object.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I'm obviously not going to take this one as a fix.  It's a reasonable patch
so feel free to remind me of it's existence once the fix has worked its
way around to be in my togreg/testing branch.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 7e8662c5cb0e..cef61f962e60 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -908,15 +908,6 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static const struct of_device_id ad7192_of_match[] = {
> -	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
> -	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
> -	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
> -	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, ad7192_of_match);
> -
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
> @@ -1050,6 +1041,15 @@ static int ad7192_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id ad7192_of_match[] = {
> +	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
> +	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
> +	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
> +	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad7192_of_match);
> +
>  static struct spi_driver ad7192_driver = {
>  	.driver = {
>  		.name	= "ad7192",

