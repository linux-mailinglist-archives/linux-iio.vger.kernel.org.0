Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3452C225DBC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgGTLqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgGTLql (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:46:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE8A2070A;
        Mon, 20 Jul 2020 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595245601;
        bh=wpmJJCyqA+D6teN6g831zjXX70JObwRpZq5xuhIILbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASMXH9rsObja4YpElsxPHACrlV3jlmlNDX9FbjBm6cr1TY+NEksxzdYf8kblQkzDd
         lIVAIdUJqsrLRD86jwV5ND1KYv4erNxGiAnSTBd44HBF4NZN5C9m81xeRC4fMgSiJb
         2D2dx4a+Y8e7eu94hNBi7T+9TWmNwxEJpkN2l8VY=
Date:   Mon, 20 Jul 2020 12:46:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     sean@geanix.com, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: reset hw ts after resume
Message-ID: <20200720124637.4f2dcabb@archlinux>
In-Reply-To: <4eb556ec9e68dccde35fa01fddad252a746a2fd3.1594640279.git.lorenzo@kernel.org>
References: <4eb556ec9e68dccde35fa01fddad252a746a2fd3.1594640279.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jul 2020 13:40:19 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Reset hw time samples generator after system resume in order to avoid
> disalignment between system and device time reference since FIFO
> batching and time samples generator are disabled during suspend.
> 
> Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the fixes-togreg branch of iio.git.  I may well yank this
into the togreg branch if I get a pull out later this week.
That will probably hit mainline faster than the fixes branch.

> ---
> Changes since v1:
> - add missing Fixes tag
> - improve commit log
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
>  3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0f..529970195b39 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>  				u16 watermark);
>  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode);
> +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..7de10bd636ea 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  	return err;
>  }
>  
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode)
> +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> +				    enum st_lsm6dsx_fifo_mode fifo_mode)
>  {
>  	unsigned int data;
>  
> @@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
>  	return 0;
>  }
>  
> +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
> +{
> +	int err;
> +
> +	/* reset hw ts counter */
> +	err = st_lsm6dsx_reset_hw_ts(hw);
> +	if (err < 0)
> +		return err;
> +
> +	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +}
> +
>  /*
>   * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
>   * in order to avoid a kmalloc for each bus access
> @@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  		goto out;
>  
>  	if (fifo_mask) {
> -		/* reset hw ts counter */
> -		err = st_lsm6dsx_reset_hw_ts(hw);
> -		if (err < 0)
> -			goto out;
> -
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>  		if (err < 0)
>  			goto out;
>  	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c8ddeb3f48ff..346c24281d26 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2457,7 +2457,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>  	}
>  
>  	if (hw->fifo_mask)
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>  
>  	return err;
>  }

