Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709F2222F6
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfERKAq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:00:46 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45942 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERKAq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 06:00:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 0E3E49E8357;
        Sat, 18 May 2019 11:00:44 +0100 (BST)
Date:   Sat, 18 May 2019 11:00:43 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: frequency: ad9523: add eeprom read/write
 verification
Message-ID: <20190518110043.3c7fb04b@archlinux>
In-Reply-To: <20190517141938.10315-1-alexandru.ardelean@analog.com>
References: <20190517141938.10315-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019 17:19:38 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This change adds a basic verification of the EEPROM by writing a known
> value to the customer version ID register, and reading it back.
> 
> This validates that the EEPROM & SPI communication are functioning
> properly, and the device is ready to use.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I'm going to assume that the write cycle limitations of that eeprom
have been taken into account here and it won't be an issue until
a very large number of probe and remove cycles.  There is also the
slightly amusing possibility of breaking a customer part if someone
managed to pull the power whilst you have the wrong customer ID
in the eeprom.  However your device and I assume there is a customer
who really wants this sanity check so fair enough...

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 9b9eee27176c..dd159a1237f3 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -749,6 +749,30 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad9523_verify_eeprom(struct iio_dev *indio_dev)
> +{
> +	int ret, id;
> +
> +	id = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> +	if (id < 0)
> +		return id;
> +
> +	ret = ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, 0xAD95);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad9523_read(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != 0xAD95) {
> +		dev_err(&indio_dev->dev, "SPI Read Verify failed (0x%X)\n", ret);
> +		return -EIO;
> +	}
> +
> +	return ad9523_write(indio_dev, AD9523_EEPROM_CUSTOMER_VERSION_ID, id);
> +}
> +
>  static const struct iio_info ad9523_info = {
>  	.read_raw = &ad9523_read_raw,
>  	.write_raw = &ad9523_write_raw,
> @@ -780,6 +804,10 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = ad9523_verify_eeprom(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	/*
>  	 * PLL1 Setup
>  	 */

