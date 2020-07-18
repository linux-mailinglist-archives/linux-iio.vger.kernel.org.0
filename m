Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18708224CDF
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGRQNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGRQNO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:13:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C162070E;
        Sat, 18 Jul 2020 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088794;
        bh=e554OwEh/JVBkbBwC3gyWMTLTXY+2kQFnjc/gfeyC08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XqPB8NXLfKr8Q1U42KRegWlcILXr8o4DFYqvvCEX2Pq+PWZK+kwpB2yrkZcP77+tA
         TE/2I6+GG9+zRoseQveGTNHah1tCHSwBfd2sihuGfumVafTQHMrz7VcoqIOK3QENZc
         l0JsxtTSgTlK9EMMHtL7rkj8T4Ur1OQrgRchZ7gY=
Date:   Sat, 18 Jul 2020 17:13:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 28/30] iio: imu: st_lsm6dsx: st_lsm6dsx_shub: Demote
 obvious misuse of kerneldoc to standard comment blocks
Message-ID: <20200718171310.3a710610@archlinux>
In-Reply-To: <20200717165538.3275050-29-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-29-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:36 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> No attempt has been made to document any of the demoted functions here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'hw' not described in 'st_lsm6dsx_shub_read_output'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_read_output'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:174: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_read_output'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'hw' not described in 'st_lsm6dsx_shub_write_reg'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_write_reg'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_write_reg'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:205: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_write_reg'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'sensor' not described in 'st_lsm6dsx_shub_read'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_read'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_read'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:285: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_read'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'sensor' not described in 'st_lsm6dsx_shub_write'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'addr' not described in 'st_lsm6dsx_shub_write'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'data' not described in 'st_lsm6dsx_shub_write'
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:335: warning: Function parameter or member 'len' not described in 'st_lsm6dsx_shub_write'
> 
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index c1f83fe0d8dad..9a14dde4795da 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -163,7 +163,7 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  	msleep((2000000U / odr) + 1);
>  }
>  
> -/**
> +/*
>   * st_lsm6dsx_shub_read_output - read i2c controller register
>   *
>   * Read st_lsm6dsx i2c controller register
> @@ -195,7 +195,7 @@ st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data,
>  	return err;
>  }
>  
> -/**
> +/*
>   * st_lsm6dsx_shub_write_reg - write i2c controller register
>   *
>   * Write st_lsm6dsx i2c controller register
> @@ -273,7 +273,7 @@ static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
>  	return err;
>  }
>  
> -/**
> +/*
>   * st_lsm6dsx_shub_read - read data from slave device register
>   *
>   * Read data from slave device register. SLV0 is used for
> @@ -323,7 +323,7 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
>  					 sizeof(config));
>  }
>  
> -/**
> +/*
>   * st_lsm6dsx_shub_write - write data to slave device register
>   *
>   * Write data from slave device register. SLV0 is used for

