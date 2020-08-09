Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC523FDEF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHILnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHILnd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:43:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951A1206B5;
        Sun,  9 Aug 2020 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596973413;
        bh=dnio2izJ1JeZiTWgd2dGmyXEXTWvquXUnsADWvbcpxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2lLYQ+rAL0YUCkSEbnhjrH8doIo6J1tkvxKGKJOGsvE1+4z/XUrXcYfKyg/i/Tbff
         ppnXYsxiOA6dsquFGBhTl32RYD+FUYNnJKLKDJVJeFssM69Yyw6H+cZSfGjgBRKvBv
         iMPfD3W8tmYWH5DSrobFZIWGLSmgzFfM+3jaRVGU=
Date:   Sun, 9 Aug 2020 12:43:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:temperature:mlx90632: Some stylefixing leftovers
Message-ID: <20200809124329.5ed66c0b@archlinux>
In-Reply-To: <20200806212139.923270-1-cmo@melexis.com>
References: <20200806212139.923270-1-cmo@melexis.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Aug 2020 23:21:39 +0200
Crt Mori <cmo@melexis.com> wrote:

> There is some inconsistency and whitespace cleanup performed in this
> patch. It was done on top of my other patches, but I can rebase to head
> of the togreg branch if it would go in sooner.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
If not already done so, probably just add this to the other series.

If you prefer to keep it separate then remind me if I seem to have
lost this one after those patches are in place.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/mlx90632.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index bb35a65bb9f0..d966e5387c48 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -100,10 +100,10 @@
>  #define MLX90632_DSP_VERSION	5 /* DSP version */
>  #define MLX90632_DSP_MASK	GENMASK(7, 0) /* DSP version in EE_VERSION */
>  #define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
> -#define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> -#define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
> -#define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
> +#define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> +#define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
> +#define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
> +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
>  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
>  
>  struct mlx90632_data {
> @@ -884,7 +884,7 @@ static int mlx90632_probe(struct i2c_client *client,
>  		mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
>  	} else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
>  		dev_dbg(&client->dev,
> -			"Detected Unknown EEPROM calibration %x\n", read);	
> +			"Detected Unknown EEPROM calibration %x\n", read);
>  	} else {
>  		dev_err(&client->dev,
>  			"Wrong DSP version %x (expected %x)\n",

