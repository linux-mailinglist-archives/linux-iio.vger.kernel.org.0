Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97362AB48
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEZQsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 12:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfEZQsV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 May 2019 12:48:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5072075B;
        Sun, 26 May 2019 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558889300;
        bh=x4dqeuIvJrDaN+3pgCeK86xTfTM7GmjCgcfqftJvVoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2Uh7m0Tsk+LZwAal/HGTJQx3tn4DQ7hp6mkBwwsqwB7EqY2N/mn+FXX+UQsKdLMo
         Zt4HUv9hL6UHtdZLktGj/TdkFSDn2FD1RAslydiIYqXKxPSB2SmV9aGS+jGtn4QmKH
         dxqlLC2IlPT0JfeyEtdu3KWLfXMFUmeLY39tUOfs=
Date:   Sun, 26 May 2019 17:48:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mlx90632 Relax the compatibility
 check
Message-ID: <20190526174817.6d59b9f6@archlinux>
In-Reply-To: <20190523120722.25848-1-cmo@melexis.com>
References: <20190523120722.25848-1-cmo@melexis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 May 2019 14:07:22 +0200
Crt Mori <cmo@melexis.com> wrote:

> Register EE_VERSION contains mixture of calibration information and DSP
> version. So far, because calibrations were definite, the driver
> compatibility depended on whole contents, but in the newer production
> process the calibration part changes. Because of that, value in EE_VERSION
> will be changed and to avoid that calibration value is same as DSP version
> the MSB in calibration part was fixed to 1.
> That means existing calibrations (medical and consumer) will now have
> hex values (bits 8 to 15) of 83 and 84 respectively. Driver compatibility
> should be based only on DSP version part of the EE_VERSION (bits 0 to 7)
> register.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
Hi.

I'm going to take this via the slow path as you haven't called it out that
you want it applied as a fix (so for stable kernels).  Let me know if these
parts are in the wild and hence we should send it earlier.   We can do that
after it is in mainline anyway as a specific request to the stable maintainers.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Umm. This didn't actually apply to the current tree, so I did what I think
was intended by hand. Please take a look at the testing branch of iio.git
and check it is correct.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/mlx90632.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 2243e8057ffc..2d54d9cac61d 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -81,6 +81,8 @@
>  /* Magic constants */
>  #define MLX90632_ID_MEDICAL	0x0105 /* EEPROM DSPv5 Medical device id */
>  #define MLX90632_ID_CONSUMER	0x0205 /* EEPROM DSPv5 Consumer device id */
> +#define MLX90632_DSP_VERSION	5 /* DSP version */
> +#define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
>  #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
>  #define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
>  #define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
> @@ -666,10 +668,13 @@ static int mlx90632_probe(struct i2c_client *client,
>  	} else if (read == MLX90632_ID_CONSUMER) {
>  		dev_dbg(&client->dev,
>  			"Detected Consumer EEPROM calibration %x\n", read);
> +	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
> +		dev_dbg(&client->dev,
> +			"Detected Unknown EEPROM calibration %x\n", read);
>  	} else {
>  		dev_err(&client->dev,
> -			"Wrong DSP version %x (expected %x or %x)\n",
> -			read, MLX90632_DSPv5);
> +			"Wrong DSP version %x (expected %x)\n",
> +			read, MLX90632_DSP_VERSION);
>  		return -EPROTONOSUPPORT;
>  	}
>  

