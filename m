Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61015D9A6
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgBNOlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgBNOlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:41:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9512187F;
        Fri, 14 Feb 2020 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691284;
        bh=X7nxSf+TdFKUgOrq0QSzcJl+85nrsvyq6cslSzbr2Xg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AHHXNhhoYIYor+r4NV2gN0+AHVyMRnle6rx9Kj1J15ieuENXEc/u7ukUjG/X0rqBN
         0rxoykMFTfxeVBeCaeyaTy5gjZXmvNUre5ODMOx8Ff8bVx/dRb4zWfHy4uuE7x/oTJ
         Hh3B3i61j+6qPY1qSJOv+iHDp0xmmJasEd1h3fWs=
Date:   Fri, 14 Feb 2020 14:41:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 7/9] iio: imu: adis: add support product ID check in
 adis_initial_startup
Message-ID: <20200214144121.2c4864a6@archlinux>
In-Reply-To: <20200210132606.9315-7-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:26:04 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Each driver/chip that wants to validate it's product id, can now
> specify a 'prod_id_reg' and an expected 'prod_id' value.
> The 'prod_id' value is intentionally left 0 (uninitialized). There aren't
> (yet) any product IDs with value 0; this enforces that both 'prod_id_reg'
> and 'prod_id' are specified.
> 
> At the very least, this routine validates that the SPI connection to the
> ADIS chip[s] works well.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 23 ++++++++++++++++++++++-
>  include/linux/iio/imu/adis.h |  5 +++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 0bd6e32cf577..a8afd01de4f3 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -373,6 +373,10 @@ static int adis_self_test(struct adis *adis)
>   * via GPIOLIB. If no pin is configured a SW reset will be performed.
>   * The RST pin for the ADIS devices should be configured as ACTIVE_LOW.
>   *
> + * After the self-test operation is performed, the function will also check
> + * that the product ID is as expected. This assumes that drivers providing
> + * 'prod_id_reg' will also provide the 'prod_id'.
> + *
>   * Returns 0 if the device is operational, a negative error code otherwise.
>   *
>   * This function should be called early on in the device initialization sequence
> @@ -382,6 +386,7 @@ int __adis_initial_startup(struct adis *adis)
>  {
>  	const struct adis_timeout *timeouts = adis->data->timeouts;
>  	struct gpio_desc *gpio;
> +	uint16_t prod_id;
>  	int ret;
>  
>  	/* check if the device has rst pin low */
> @@ -401,7 +406,23 @@ int __adis_initial_startup(struct adis *adis)
>  			return ret;
>  	}
>  
> -	return adis_self_test(adis);
> +	ret = adis_self_test(adis);
> +	if (ret)
> +		return ret;
> +
> +	if (!adis->data->prod_id_reg)
> +		return 0;
> +
> +	ret = adis_read_reg_16(adis, adis->data->prod_id_reg, &prod_id);
> +	if (ret)
> +		return ret;
> +
> +	if (prod_id != adis->data->prod_id)
> +		dev_warn(&adis->spi->dev,
> +			 "Device ID(%u) and product ID(%u) do not match.",
> +			 adis->data->prod_id, prod_id);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(__adis_initial_startup);
>  
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index b7feca4e5f26..ac7cfd073804 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -41,6 +41,8 @@ struct adis_timeout {
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> + * @prod_id_reg: Register address of the PROD_ID register
> + * @prod_id: Product ID code that should be expected when reading @prod_id_reg
>   * @self_test_reg: Register address to request self test command
>   * @status_error_msgs: Array of error messgaes
>   * @status_error_mask:
> @@ -54,6 +56,9 @@ struct adis_data {
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;
>  	unsigned int diag_stat_reg;
> +	unsigned int prod_id_reg;
> +
> +	unsigned int prod_id;
>  
>  	unsigned int self_test_mask;
>  	unsigned int self_test_reg;

