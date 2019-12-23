Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB812989E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWQTM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLWQTM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:19:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEE320709;
        Mon, 23 Dec 2019 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117951;
        bh=7sJfZaUPwVZ9Fwf5zAIOnH3dkIV1hzyV9a4DKTixzwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTHBogiBBguWcuHCGquCU/YoyAt8LSMCOYs8xGAtlBEdoDfDQ3Iw4LxXPI/JHPrtJ
         frlA3iwAfiYYoHzviCOniT1gbpJuJv0iBBohaB260EPJdu42DnpW5S7CZW1PpSmOxk
         fZxfysbPl/oz4W1q/7ajvyJG9ze4nTyEACUo37Vw=
Date:   Mon, 23 Dec 2019 16:19:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 3/9] iio: pressure: st_press: Drop unnecessary #else
 branch for ACPI
Message-ID: <20191223161907.5494dccc@archlinux>
In-Reply-To: <20191216173853.75797-3-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
        <20191216173853.75797-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 19:38:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ACPI_PTR() takes care of the argument in case of !CONFIG_ACPI.
> Remove unnecessary #else branch.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

> ---
>  drivers/iio/pressure/st_pressure_i2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 71d2ed6b4948..6203bc9d5c2d 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -61,8 +61,6 @@ static const struct acpi_device_id st_press_acpi_match[] = {
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
> -#else
> -#define st_press_acpi_match NULL
>  #endif
>  
>  static const struct i2c_device_id st_press_id_table[] = {

