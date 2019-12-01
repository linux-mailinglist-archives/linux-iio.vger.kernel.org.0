Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3892010E378
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLAUtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 15:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfLAUtl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 15:49:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E51720833;
        Sun,  1 Dec 2019 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575233380;
        bh=EgQ1tAZMHpmo/bpwthSG1cnF8McT9duH6h6KKGbOkiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8EJpipjvvpzv5qm7Orzay6YGReJXrfpFJkjyAjQARLH0qEyBCYT1Hw6Rp0NP2lzR
         fZ3GbHhj8fDDOB2wy1mbp5BOsAK/5rcIHhJlIi9JRWULP7LfINMYzvPjJVbySPFvlX
         LRgw3twf19IBPrLxep/XafRoVxhPwBN4xkY2KJoY=
Date:   Sun, 1 Dec 2019 20:49:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: track hw FIFO buffering with
 fifo_mask
Message-ID: <20191201204936.0c4c3ded@archlinux>
In-Reply-To: <844cd314df8ff354859bad1e43b13778f60b08bb.1574954314.git.lorenzo@kernel.org>
References: <844cd314df8ff354859bad1e43b13778f60b08bb.1574954314.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Nov 2019 17:42:30 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Track hw FIFO state introducing fifo_mask since now the accel sensor
> can be enabled during suspend/resume in order to trigger the wake-up
> enabling the FIFO in st_lsm6dsx_resume even if it was disabled before
> the suspend

What is the user visible result of not having this patch?

Otherwise looks fine to me.

Jonathan

> 
> Fixes: 4c997dfa692d ("iio: imu: st_lsm6dsx: add wakeup-source option")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +--
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 25 +++++++++++--------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  4 +--
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index c605b153be41..b54aefcdaad4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -351,9 +351,9 @@ struct st_lsm6dsx_sensor {
>   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>   * @page_lock: Mutex to prevent concurrent memory page configuration.
> - * @fifo_mode: FIFO operating mode supported by the device.
>   * @suspend_mask: Suspended sensor bitmask.
>   * @enable_mask: Enabled sensor bitmask.
> + * @fifo_mask: Enabled hw FIFO bitmask.
>   * @ts_gain: Hw timestamp rate after internal calibration.
>   * @ts_sip: Total number of timestamp samples in a given pattern.
>   * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> @@ -373,9 +373,9 @@ struct st_lsm6dsx_hw {
>  	struct mutex conf_lock;
>  	struct mutex page_lock;
>  
> -	enum st_lsm6dsx_fifo_mode fifo_mode;
>  	u8 suspend_mask;
>  	u8 enable_mask;
> +	u8 fifo_mask;
>  	s64 ts_gain;
>  	u8 ts_sip;
>  	u8 sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index d416990ae309..bfd4c6306c0b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -176,17 +176,10 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode)
>  {
>  	unsigned int data;
> -	int err;
>  
>  	data = FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
> -	err = st_lsm6dsx_update_bits_locked(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> -					    ST_LSM6DSX_FIFO_MODE_MASK, data);
> -	if (err < 0)
> -		return err;
> -
> -	hw->fifo_mode = fifo_mode;
> -
> -	return 0;
> +	return st_lsm6dsx_update_bits_locked(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +					     ST_LSM6DSX_FIFO_MODE_MASK, data);
>  }
>  
>  static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> @@ -608,11 +601,17 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 fifo_mask;
>  	int err;
>  
>  	mutex_lock(&hw->conf_lock);
>  
> -	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
> +	if (enable)
> +		fifo_mask = hw->fifo_mask | BIT(sensor->id);
> +	else
> +		fifo_mask = hw->fifo_mask & ~BIT(sensor->id);
> +
> +	if (hw->fifo_mask) {
>  		err = st_lsm6dsx_flush_fifo(hw);
>  		if (err < 0)
>  			goto out;
> @@ -642,15 +641,19 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  	if (err < 0)
>  		goto out;
>  
> -	if (hw->enable_mask) {
> +	if (fifo_mask) {
>  		/* reset hw ts counter */
>  		err = st_lsm6dsx_reset_hw_ts(hw);
>  		if (err < 0)
>  			goto out;
>  
>  		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		if (err < 0)
> +			goto out;
>  	}
>  
> +	hw->fifo_mask = fifo_mask;
> +
>  out:
>  	mutex_unlock(&hw->conf_lock);
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 11b2c7bc8041..6f628c3cd133 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2300,7 +2300,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  		hw->suspend_mask |= BIT(sensor->id);
>  	}
>  
> -	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
> +	if (hw->fifo_mask)
>  		err = st_lsm6dsx_flush_fifo(hw);
>  
>  	return err;
> @@ -2336,7 +2336,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>  		hw->suspend_mask &= ~BIT(sensor->id);
>  	}
>  
> -	if (hw->enable_mask)
> +	if (hw->fifo_mask)
>  		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>  
>  	return err;

