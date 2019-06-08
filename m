Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF939FBE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFHM5R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfFHM5R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:57:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453C320693;
        Sat,  8 Jun 2019 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998636;
        bh=h3gVQBetnM9jUpS8v4u7mK5yh96McX86B0/5R8QAWQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4cVe3dZ3CNytMxF2bIFsjS+8Y8NXM4IMDVoDtz/xm3++h1pJXRfAtABy2eSt50SK
         AllxAAzx4ZdhCPWFmOWKWdmIoWDMG9zioahota8F63G8a2gBM5LYhVfknb8FNgDDBw
         0Vtk+gRBUG+JYfc3plwGcOn/HtLP1H6NcHWppR78=
Date:   Sat, 8 Jun 2019 13:57:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Martijn Braam <martijn@brixit.nl>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] iio: light: stk3310: Add support for stk3335
Message-ID: <20190608135710.25117605@archlinux>
In-Reply-To: <20190603192040.24101-1-luca@z3ntu.xyz>
References: <20190603192040.24101-1-luca@z3ntu.xyz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Jun 2019 21:20:39 +0200
Luca Weiss <luca@z3ntu.xyz> wrote:

> From: Martijn Braam <martijn@brixit.nl>
> 
> The stk3335 light/proximity sensor is similar to the stk3310 and stk3311
> sensors and works with the stk3310 driver.
> 
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 6e2a169da950..a25cc35f334e 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -40,6 +40,7 @@
>  
>  #define STK3310_CHIP_ID_VAL			0x13
>  #define STK3311_CHIP_ID_VAL			0x1D
> +#define STK3335_CHIP_ID_VAL			0x51
>  #define STK3310_PSINT_EN			0x01
>  #define STK3310_PS_MAX_VAL			0xFFFF
>  
> @@ -454,7 +455,8 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	if (chipid != STK3310_CHIP_ID_VAL &&
> -	    chipid != STK3311_CHIP_ID_VAL) {
> +	    chipid != STK3311_CHIP_ID_VAL &&
> +	    chipid != STK3335_CHIP_ID_VAL) {
>  		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
>  		return -ENODEV;
>  	}
> @@ -666,6 +668,7 @@ static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
>  static const struct i2c_device_id stk3310_i2c_id[] = {
>  	{"STK3310", 0},
>  	{"STK3311", 0},
> +	{"STK3335", 0},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
> @@ -673,6 +676,7 @@ MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
>  static const struct acpi_device_id stk3310_acpi_id[] = {
>  	{"STK3310", 0},
>  	{"STK3311", 0},
> +	{"STK3335", 0},
>  	{}
>  };
>  

