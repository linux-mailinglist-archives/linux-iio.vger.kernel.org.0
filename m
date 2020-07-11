Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E286E21C413
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jul 2020 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGKLtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jul 2020 07:49:41 -0400
Received: from first.geanix.com ([116.203.34.67]:44842 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgGKLtl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jul 2020 07:49:41 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id C501620249F3;
        Sat, 11 Jul 2020 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1594468177; bh=1DqkpjW+8C2KCKw5XE/qPQvlJf78p6+49XM8768LfYE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TEw6QIyTu2JUvqVEwutAoof/6d6TR7Obl4pJSm8WJN94gqeSrTm29h3W04q6jrYyO
         XUABHsi8SL+cgMWjD+/4ht8fsFpU6mfUgxXMPMls0iiTpRrpZVmVrIo5CUKN+YFcN3
         W+WogMpiQaZ8QiDMWvaTmyCiViKFD0og5oiKfF0+SCsdpkz7LJxxvB5XJYnLcMiQ8X
         /bC1TpNyCLL1OlhlZsZnrDZuhEFRSJYlm1KUT/Zio8BuibcztFdj+m3gmRuU79bBHJ
         7OMqAonQeuk//2Wc5SkJL+Vs+f9fizQuE+d/Hb9/OPe9X9+1vn1JxPNz3VFRDclU68
         k53+1nCud0V6w==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: reset hw ts after resume
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <15dadc531c5b30819a72b289ccd5c25e04f73657.1594388801.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f639082c-91b9-c056-673d-2835ba05ac03@geanix.com>
Date:   Sat, 11 Jul 2020 13:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15dadc531c5b30819a72b289ccd5c25e04f73657.1594388801.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on ff3d05386fc5
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/07/2020 15.49, Lorenzo Bianconi wrote:
> Reset hw time sampling after the device resume in order to keep timing
> in sync
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
>   .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
>   3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index b56df409ed0f..529970195b39 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>   				u16 watermark);
>   int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
>   int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode);
> +int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
>   int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index afd00daeefb2..7de10bd636ea 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>   	return err;
>   }
>   
> -int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> -			     enum st_lsm6dsx_fifo_mode fifo_mode)
> +static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> +				    enum st_lsm6dsx_fifo_mode fifo_mode)
>   {
>   	unsigned int data;
>   
> @@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
>   	return 0;
>   }
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
>   /*
>    * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
>    * in order to avoid a kmalloc for each bus access
> @@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>   		goto out;
>   
>   	if (fifo_mask) {
> -		/* reset hw ts counter */
> -		err = st_lsm6dsx_reset_hw_ts(hw);
> -		if (err < 0)
> -			goto out;
> -
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>   		if (err < 0)
>   			goto out;
>   	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index c8ddeb3f48ff..346c24281d26 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2457,7 +2457,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>   	}
>   
>   	if (hw->fifo_mask)
> -		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +		err = st_lsm6dsx_resume_fifo(hw);
>   
>   	return err;
>   }

