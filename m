Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2256D25765E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHaJTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbgHaJTN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:19:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D97E2073A;
        Mon, 31 Aug 2020 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598865552;
        bh=QuZiCJwqeHnmcdP4bKufX3OFEsHwrj6ZVw63kDhGXuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XBQhlRwZwMDng0hIXjaB/TnqVFtzbC5aAY6/EcaMDMSbx9sHvJmBNEZCSQiUzxB0c
         LIXv08E4kRVLNdffyesZHc4uG+evkjl9WuPRws4fOCMf1BBMGO4blUX0n4PJMkhOZp
         hDKRjxv4J60dsnm4JFwVU+fJF5bhV9NUKGlDfU8c=
Date:   Mon, 31 Aug 2020 10:19:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 5/8] iio: accel: bma220: Drop ACPI_PTR() and
 accompanying ifdeffery
Message-ID: <20200831101908.52cb216e@archlinux>
In-Reply-To: <20200831090813.78841-5-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
        <20200831090813.78841-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 12:08:10 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The driver is quite likely used only on ACPI based platforms and
> rarely build with CONFIG_ACPI=n. Even though, the few dozens of bytes
> is better than ugly ifdeffery and inclusion of heavy header.

Given this part is readily available on maker type break out boards
I doubt it is mostly ACPI.  Rest of the comment is fine though.

Jonathan


> 
> As a result, replace acpi.h with mod_devicetable.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/accel/bma220_spi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index e55c5f5dd6b4..105c1dece890 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -5,8 +5,8 @@
>   * Copyright (c) 2016, Intel Corporation.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> @@ -310,20 +310,18 @@ static const struct spi_device_id bma220_spi_id[] = {
>  	{}
>  };
>  
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id bma220_acpi_id[] = {
>  	{"BMA0220", 0},
>  	{}
>  };
>  
>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);
> -#endif
>  
>  static struct spi_driver bma220_driver = {
>  	.driver = {
>  		.name = "bma220_spi",
>  		.pm = &bma220_pm_ops,
> -		.acpi_match_table = ACPI_PTR(bma220_acpi_id),
> +		.acpi_match_table = bma220_acpi_id,
>  	},
>  	.probe =            bma220_probe,
>  	.remove =           bma220_remove,

