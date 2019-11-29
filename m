Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B210D309
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfK2JNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 04:13:36 -0500
Received: from first.geanix.com ([116.203.34.67]:52062 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2JNg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Nov 2019 04:13:36 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 294DD93D1F;
        Fri, 29 Nov 2019 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575018581; bh=lVgGG1ir/CU38NyexA16D5bvW+7RFFdmOj/PX/DGlmY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Swxh86Md+jh7W1qZccN4aNx3fhxkGCXcCnFLEt8lax5gY8DmFCgu7SfyDJQ/6hJQ0
         q3c1Yy0w9OlWLSe7tNV45rLFv5Z4f0f9h9FmEII8oYhGCbgjGeXR87yo1tNxOP0uD2
         /j969FGg6Wc6IxY1PeXgEVnirvX5EjT41HcMvwvHjjcbuUFwmhPt3MRy9CWK7f/rfz
         aCcs4E00py84YP15qf+vS8QYWpqsOKA3pqaXMFmK3BrQiDGeSZkB8c48JbmJ2Py23W
         stuD3C3UlS/9zDNh3l3qRCb9YRRgXRCjIh1FttM1al7d0i77n9o0zkh+Jyd3iA5Rpj
         4cD59JhEoK59A==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: track hw FIFO buffering with
 fifo_mask
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
References: <844cd314df8ff354859bad1e43b13778f60b08bb.1574954314.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5558eefc-9a44-d164-9b9f-165167fa59db@geanix.com>
Date:   Fri, 29 Nov 2019 10:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <844cd314df8ff354859bad1e43b13778f60b08bb.1574954314.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/11/2019 16.42, Lorenzo Bianconi wrote:
> Track hw FIFO state introducing fifo_mask since now the accel sensor
> can be enabled during suspend/resume in order to trigger the wake-up
> enabling the FIFO in st_lsm6dsx_resume even if it was disabled before
> the suspend
> 
> Fixes: 4c997dfa692d ("iio: imu: st_lsm6dsx: add wakeup-source option")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +--
>   .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 25 +++++++++++--------
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  4 +--
>   3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index c605b153be41..b54aefcdaad4 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -351,9 +351,9 @@ struct st_lsm6dsx_sensor {
>    * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
>    * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>    * @page_lock: Mutex to prevent concurrent memory page configuration.
> - * @fifo_mode: FIFO operating mode supported by the device.
>    * @suspend_mask: Suspended sensor bitmask.
>    * @enable_mask: Enabled sensor bitmask.
> + * @fifo_mask: Enabled hw FIFO bitmask.
>    * @ts_gain: Hw timestamp rate after internal calibration.
>    * @ts_sip: Total number of timestamp samples in a given pattern.
>    * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> @@ -373,9 +373,9 @@ struct st_lsm6dsx_hw {
>   	struct mutex conf_lock;
>   	struct mutex page_lock;
>   
> -	enum st_lsm6dsx_fifo_mode fifo_mode;
>   	u8 suspend_mask;
>   	u8 enable_mask;
> +	u8 fifo_mask;
>   	s64 ts_gain;
>   	u8 ts_sip;
>   	u8 sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index d416990ae309..bfd4c6306c0b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -176,17 +176,10 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>   			     enum st_lsm6dsx_fifo_mode fifo_mode)
>   {
>   	unsigned int data;
> -	int err;
>   
>   	data = FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
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
>   }
>   
>   static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> @@ -608,11 +601,17 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>   int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>   {
>   	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 fifo_mask;
>   	int err;
>   
>   	mutex_lock(&hw->conf_lock);
>   
> -	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
> +	if (enable)
> +		fifo_mask = hw->fifo_mask | BIT(sensor->id);
> +	else
> +		fifo_mask = hw->fifo_mask & ~BIT(sensor->id);
> +
> +	if (hw->fifo_mask) {
>   		err = st_lsm6dsx_flush_fifo(hw);
>   		if (err < 0)
>   			goto out;
> @@ -642,15 +641,19 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>   	if (err < 0)
>   		goto out;
>   
> -	if (hw->enable_mask) {
> +	if (fifo_mask) {
>   		/* reset hw ts counter */
>   		err = st_lsm6dsx_reset_hw_ts(hw);
>   		if (err < 0)
>   			goto out;
>   
>   		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		if (err < 0)
> +			goto out;
>   	}
>   
> +	hw->fifo_mask = fifo_mask;
> +
>   out:
>   	mutex_unlock(&hw->conf_lock);
>   
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 11b2c7bc8041..6f628c3cd133 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2300,7 +2300,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>   		hw->suspend_mask |= BIT(sensor->id);
>   	}
>   
> -	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
> +	if (hw->fifo_mask)
>   		err = st_lsm6dsx_flush_fifo(hw);
>   
>   	return err;
> @@ -2336,7 +2336,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>   		hw->suspend_mask &= ~BIT(sensor->id);
>   	}
>   
> -	if (hw->enable_mask)
> +	if (hw->fifo_mask)
>   		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>   
>   	return err;
> 
