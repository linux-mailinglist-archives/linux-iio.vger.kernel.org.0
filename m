Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2707422DEFD
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGZMbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZMbC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:31:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6090E206D8;
        Sun, 26 Jul 2020 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766662;
        bh=6MWqormlou6YQtHa7H1gjKpUJ28zRS67aZ4XrovKFpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WrabNVfILpo2BfBxLTEwhvO2vvndxnabMn6JOY85SyG1s4ZxpQfNaGWC+TNz+JpDh
         A7yDwW013RJi4VQxdqP/cWHVcsaNvRPsTdNlMu+Z20IabceDEQZOSsE7qImytr9Pio
         ZpZlDUsqLpIlDSdgpbIRqOp63ugPjaXuAkWLgz6E=
Date:   Sun, 26 Jul 2020 13:30:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v2] iio: adxl372_i2c: Add OF device ID table
Message-ID: <20200726133058.0b1f43b9@archlinux>
In-Reply-To: <20200722073003.67373-1-alexandru.ardelean@analog.com>
References: <20200720134931.71537-1-alexandru.ardelean@analog.com>
        <20200722073003.67373-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 10:30:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> The driver does not have a struct of_device_id table, but supported
> devices are registered via Device Trees. This patch adds OF device ID
> table.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * use linux/mod_devicetable.h include instead for the OF table
> * remove comma from null terminator
> 
>  drivers/iio/accel/adxl372_i2c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
> index e1affe480c77..9a07ab3d151a 100644
> --- a/drivers/iio/accel/adxl372_i2c.c
> +++ b/drivers/iio/accel/adxl372_i2c.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> @@ -46,9 +47,16 @@ static const struct i2c_device_id adxl372_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
>  
> +static const struct of_device_id adxl372_of_match[] = {
> +	{ .compatible = "adi,adxl372" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adxl372_of_match);
> +
>  static struct i2c_driver adxl372_i2c_driver = {
>  	.driver = {
>  		.name = "adxl372_i2c",
> +		.of_match_table = adxl372_of_match,
>  	},
>  	.probe = adxl372_i2c_probe,
>  	.id_table = adxl372_i2c_id,

