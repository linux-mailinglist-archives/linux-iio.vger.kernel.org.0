Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DCCDCA1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJGHyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 03:54:54 -0400
Received: from first.geanix.com ([116.203.34.67]:47774 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGHyy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 03:54:54 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1EA8850530;
        Mon,  7 Oct 2019 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570434810; bh=g5bJGUK8qhU+Z4h6XAfKFU+TWpdB+U4AVeVasLwJgHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M+hgdBKpW1GBNkoKB4b+PlV1y4d9wo+IpLVreCqORE6lGAwJYf7MszEAjfPPR/Inm
         1TXcAoAV+fHgxhupoMhVrTT92JUyMDMctvGhDykeZsKUArmgcTY/BG4D3+XXpvAcoy
         m+wloY4QBgS5olHFRxFJhpqguepa7mcRh4oR+ig+jqAqpuOoG6BTWaMd2knoUweTos
         oH7Nxd8br/IllD2v27Ho1H2VPYHrSejMzc15f8MZb2GUQlKS4Vaw1AEhdANiXk4/Wd
         OpDi7AEa982zFUoRLYzVvhPyBzcv2hvrAh1uw7FTUBFp4If3vpQLycDd5IxjMQ1k+b
         23Eu/ubjz6HjQ==
Subject: Re: [PATCH 01/13] iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in
 st_lsm6dsx_report_motion_event
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
References: <cover.1570367532.git.lorenzo@kernel.org>
 <a837aedc32b5726e09b14ae6a883655576184869.1570367532.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <2d5ff3b9-903e-d258-79e4-cdc2d751319f@geanix.com>
Date:   Mon, 7 Oct 2019 09:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a837aedc32b5726e09b14ae6a883655576184869.1570367532.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=disabled
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/10/2019 15.21, Lorenzo Bianconi wrote:
> Rely on st_lsm6dsx_read_locked in st_lsm6dsx_report_motion_event since
> it can run concurrently with sensor hub configuration. Move event
> related code in st_lsm6dsx_report_motion_event
> 
> Fixes: 1aabad1fb5e9 ("iio: imu: st_lsm6dsx: add motion report function and call from interrupt")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 34 ++++++++++++--------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 8a813ddba19c..df270905f21d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1757,10 +1757,23 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>   	return iio_dev;
>   }
>   
> -static void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +static bool
> +st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
>   {
> -	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +	const struct st_lsm6dsx_event_settings *event_settings;
> +	int err, data;
> +	s64 timestamp;
>   
> +	if (!hw->enable_event)
> +		return false;
> +
> +	event_settings = &hw->settings->event_settings;
> +	err = st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
> +				     &data, sizeof(data));
> +	if (err < 0)
> +		return false;
> +
> +	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>   	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
>   	    (hw->enable_event & BIT(IIO_MOD_Z)))
>   		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> @@ -1790,30 +1803,23 @@ static void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
>   						  IIO_EV_TYPE_THRESH,
>   						  IIO_EV_DIR_EITHER),
>   						  timestamp);
> +
> +	return data & event_settings->wakeup_src_status_mask;
>   }
>   
>   static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>   {
>   	struct st_lsm6dsx_hw *hw = private;
> +	bool event;
>   	int count;
> -	int data, err;
> -
> -	if (hw->enable_event) {
> -		err = regmap_read(hw->regmap,
> -				  hw->settings->event_settings.wakeup_src_reg,
> -				  &data);
> -		if (err < 0)
> -			return IRQ_NONE;
>   
> -		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> -			st_lsm6dsx_report_motion_event(hw, data);
> -	}
> +	event = st_lsm6dsx_report_motion_event(hw);
>   
>   	mutex_lock(&hw->fifo_lock);
>   	count = hw->settings->fifo_ops.read_fifo(hw);
>   	mutex_unlock(&hw->fifo_lock);
>   
> -	return count ? IRQ_HANDLED : IRQ_NONE;
> +	return count || event ? IRQ_HANDLED : IRQ_NONE;
>   }
>   
>   static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> 
