Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0C6F934E
	for <lists+linux-iio@lfdr.de>; Sat,  6 May 2023 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEFRUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 May 2023 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEFRUP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2023 13:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C2156B9;
        Sat,  6 May 2023 10:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE9960C50;
        Sat,  6 May 2023 17:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C399C433D2;
        Sat,  6 May 2023 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683393613;
        bh=TocNMBoVPd5mzixqLQ2QSNI5gRdva0u3FRF11G5kA6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LBnpUsHB+5nqY5BX4+/6tIZe6HpK8eM7DfD8RIsy9fboJP8VEf71Z47Zc7UlI+2QE
         aWPkb3O3bcrVm0jC6CZDhYG/k7FIy/lVV+FNMadCkRsQNpeocOjyJa0SdCktB/CYGI
         NlG5Ac9PDNkhO3nhoMqMvyeRm7VttuO0QWlFEzvbL6tkeqCH+RiEQnm6p8MF3LepkJ
         ByGjLslw+qBtFS86jweoA217gaQNft5tC+7ANmMmTXLn2di+6BnkZxnt6+057qjDeY
         gwyex+8ioH4tQ77c75qJ/TSBlMYtAvjdKVvYnjSMrSp1FLDZeZA0dune6NL1prBqAO
         1CIBUjEt4kwXg==
Date:   Sat, 6 May 2023 18:36:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix too big timestamp jitter
Message-ID: <20230506183606.2674c7d5@jic23-huawei>
In-Reply-To: <20230504095204.172715-1-inv.git-commit@tdk.com>
References: <20230504095204.172715-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 May 2023 09:52:04 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> We are adjusting timestamp with interrupt every time, leading to
> a lot of jitter in timestamp values. Now the adjustment is done
> only when the delta is bigger than the jitter.
> 
> Refactorize code and delete the unnecessary handling of multiple
> FIFO data.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Signed-off-by: <inv.git-commit@tdk.com>
> Cc: <stable@vger.kernel.org>

Hmm. Whilst this may be an improvement, I'm not totally convinced it's
something we should backport.

Also, there are a lot of possible solutions to this and I'm not sure why
or if this is the best option.

Perhaps a simple filter on the jitter adjustment to smooth it out?
Something as simple as adjusting by only 10% of the measured difference
if it is small might work for example.  Or carry a moving window of
recently measured jitter and apply some sort of filtering to that.
Perhaps that would incorporate a 'reset' approach if the measurement is
way off to allow faster correction if something has gone wrong.

Hence, I'd like more discussion of why this solution in the patch description.

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

