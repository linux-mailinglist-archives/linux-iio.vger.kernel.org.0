Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7966129909
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWRBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRBq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:01:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B051320709;
        Mon, 23 Dec 2019 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577120505;
        bh=HpDJM9++Hlx1Im+m8QAEq+zXncQOikpZDCWOzhDSr24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktwTo0cWgWeNLnaWZUi6WBtjMUlqGWyWOcbHI+sdN+uXh+fiPPVqpmJjez2Q7jtMm
         9qXkqrX4KI6nlc7Bi4EjFzfz+ujwYsflqvtGBytWkVIoJAFs47M4+lROQZge9o+NHW
         vfi28t9gc3GiwCnjWj6ZH5re5Iu4Pzg+t7cuKGLU=
Date:   Mon, 23 Dec 2019 17:01:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 5/6] iio: imu: st_lsm6dsx: rename
 st_lsm6dsx_shub_read_reg in st_lsm6dsx_shub_read_output
Message-ID: <20191223170141.51fd18db@archlinux>
In-Reply-To: <3b95fb08efff46b9ea0de33bf332d23a207f903c.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
        <3b95fb08efff46b9ea0de33bf332d23a207f903c.1576341963.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Dec 2019 17:52:58 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Rename st_lsm6dsx_shub_read_reg routine in st_lsm6dsx_shub_read_output
> since it is used to read from sensorhub channel0 output register
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index ccc59682cb66..dc739dfb36f2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -101,13 +101,13 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  }
>  
>  /**
> - * st_lsm6dsx_shub_read_reg - read i2c controller register
> + * st_lsm6dsx_shub_read_output - read i2c controller register
>   *
>   * Read st_lsm6dsx i2c controller register
>   */
>  static int
> -st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 *data,
> -			 int len)
> +st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data,
> +			    int len)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	int err;
> @@ -243,7 +243,8 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
>  
>  	st_lsm6dsx_shub_wait_complete(hw);
>  
> -	err = st_lsm6dsx_shub_read_reg(hw, data, len & ST_LS6DSX_READ_OP_MASK);
> +	err = st_lsm6dsx_shub_read_output(hw, data,
> +					  len & ST_LS6DSX_READ_OP_MASK);
>  
>  	st_lsm6dsx_shub_master_enable(sensor, false);
>  
> @@ -725,7 +726,7 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
>  
>  		st_lsm6dsx_shub_wait_complete(hw);
>  
> -		err = st_lsm6dsx_shub_read_reg(hw, &data, sizeof(data));
> +		err = st_lsm6dsx_shub_read_output(hw, &data, sizeof(data));
>  
>  		st_lsm6dsx_shub_master_enable(sensor, false);
>  

