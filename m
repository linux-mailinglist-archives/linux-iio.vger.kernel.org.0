Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29770A8FE
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjETQKA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETQJ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 12:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8813910A
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 09:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2498F61407
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 16:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B395EC433D2;
        Sat, 20 May 2023 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684598996;
        bh=6SduxYq3leWLgk/lwpxj0MdJXYctx0a/bLG7iTW+1oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=czd/f7hZNy/sE7s3eWG+Ce2ifld4Q5uaXZlEexFyx4xndXcaoCp79hRdpH2R2dhiA
         CUFd6/0QP3UMDRq6scm+bZ0UmDYCdEFw5UwL3E2rWjMmhoHhrlLJ4OqV+e2H9woaMv
         powO9bng8qroUMfZr3HqYSD0IQqWL/YYRwqKTEIWgkSVkcPTbacSqkiG1/mZaRGq6B
         V/y7C/YlUR4eZODalUu8kpnsbWkL8HRI2R3zCw9aZKWIWF7PteXENcgkO1YQFuBCq3
         WvR1FikH5Jx6zrvu3G+tzwgZQDujf2XHcEk+4bf28n6V0s6vpoF11dGNc9p12ZpELl
         bswCD65ph9jjA==
Date:   Sat, 20 May 2023 17:26:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: avoid frequent timestamp
 jitter
Message-ID: <20230520172606.3ecffe45@jic23-huawei>
In-Reply-To: <20230515100645.61172-1-inv.git-commit@tdk.com>
References: <20230515100645.61172-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 May 2023 10:06:45 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> We are currently synchronizing every time the data timestamp with
> the IT timestamp, leading to system jitter jamming timestamps.
> To fix that and keep it simple, let's just synchronize when the
> delta is bigger than the acceptable jitter, and keep
> synchronization at the jitter value.
> 
> The result is much stable timestamps reflecting better the real
> physical value. Example @50Hz delta timestamp,
> * before: 20.123ms, 19.721ms, 20.023ms, 20.353ms, 19.821ms, ...
> * after: 20.173ms, 20.173ms, 20.173ms, 20.40ms, 20.173ms, ...
> 
> Refactorize code and delete the unnecessary handling of multiple
> FIFO data.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0day
to poke at it.

Jonathan

> ---
>  .../imu/inv_icm42600/inv_icm42600_timestamp.c | 49 ++++++++++---------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> index 7f2dc41f807b..af2e59fb7258 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> @@ -93,8 +93,8 @@ static bool inv_validate_period(uint32_t period, uint32_t mult)
>  		return false;
>  }
>  
> -static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
> -				    uint32_t mult, uint32_t period)
> +static bool inv_update_chip_period(struct inv_icm42600_timestamp *ts,
> +				   uint32_t mult, uint32_t period)
>  {
>  	uint32_t new_chip_period;
>  
> @@ -104,10 +104,31 @@ static bool inv_compute_chip_period(struct inv_icm42600_timestamp *ts,
>  	/* update chip internal period estimation */
>  	new_chip_period = period / mult;
>  	inv_update_acc(&ts->chip_period, new_chip_period);
> +	ts->period = ts->mult * ts->chip_period.val;
>  
>  	return true;
>  }
>  
> +static void inv_align_timestamp_it(struct inv_icm42600_timestamp *ts)
> +{
> +	int64_t delta, jitter;
> +	int64_t adjust;
> +
> +	/* delta time between last sample and last interrupt */
> +	delta = ts->it.lo - ts->timestamp;
> +
> +	/* adjust timestamp while respecting jitter */
> +	jitter = ((int64_t)ts->period * INV_ICM42600_TIMESTAMP_JITTER) / 100;
> +	if (delta > jitter)
> +		adjust = jitter;
> +	else if (delta < -jitter)
> +		adjust = -jitter;
> +	else
> +		adjust = 0;
> +
> +	ts->timestamp += adjust;
> +}
> +
>  void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
>  				      uint32_t fifo_period, size_t fifo_nb,
>  				      size_t sensor_nb, int64_t timestamp)
> @@ -116,7 +137,6 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
>  	int64_t delta, interval;
>  	const uint32_t fifo_mult = fifo_period / INV_ICM42600_TIMESTAMP_PERIOD;
>  	uint32_t period = ts->period;
> -	int32_t m;
>  	bool valid = false;
>  
>  	if (fifo_nb == 0)
> @@ -130,10 +150,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
>  	if (it->lo != 0) {
>  		/* compute period: delta time divided by number of samples */
>  		period = div_s64(delta, fifo_nb);
> -		valid = inv_compute_chip_period(ts, fifo_mult, period);
> -		/* update sensor period if chip internal period is updated */
> -		if (valid)
> -			ts->period = ts->mult * ts->chip_period.val;
> +		valid = inv_update_chip_period(ts, fifo_mult, period);
>  	}
>  
>  	/* no previous data, compute theoritical value from interrupt */
> @@ -145,22 +162,8 @@ void inv_icm42600_timestamp_interrupt(struct inv_icm42600_timestamp *ts,
>  	}
>  
>  	/* if interrupt interval is valid, sync with interrupt timestamp */
> -	if (valid) {
> -		/* compute measured fifo_period */
> -		fifo_period = fifo_mult * ts->chip_period.val;
> -		/* delta time between last sample and last interrupt */
> -		delta = it->lo - ts->timestamp;
> -		/* if there are multiple samples, go back to first one */
> -		while (delta >= (fifo_period * 3 / 2))
> -			delta -= fifo_period;
> -		/* compute maximal adjustment value */
> -		m = INV_ICM42600_TIMESTAMP_MAX_PERIOD(ts->period) - ts->period;
> -		if (delta > m)
> -			delta = m;
> -		else if (delta < -m)
> -			delta = -m;
> -		ts->timestamp += delta;
> -	}
> +	if (valid)
> +		inv_align_timestamp_it(ts);
>  }
>  
>  void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timestamp *ts,

