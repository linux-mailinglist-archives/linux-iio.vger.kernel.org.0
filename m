Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC77CCB0A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfJEQQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfJEQQm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:16:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2CA222C8;
        Sat,  5 Oct 2019 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570292200;
        bh=zFFS8k2lbRbcQL+fckDvfr83fOZaAsE77ehiJSvGoLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sFVmkPU1iJtcsIMCEg1XhfX97MYXdl/3W1U8c2/DzfBYJkvFL7S/KUeweKYAedHu1
         N6Kb9WRIhRVNz5l5jTUTVvNP/7sbZfqfZt0HVhgH2Z5bTB5yHwYXuE8a8DT1ZnqL2/
         jtQO1ncSt3wYG9iSGbxRtlBecy33qwyfoKD5g8/A=
Date:   Sat, 5 Oct 2019 17:16:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/13] platform: chrome: sensorhub: Add code to spread
 timestmap
Message-ID: <20191005171635.6bbc8bbf@archlinux>
In-Reply-To: <20190922175021.53449-9-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-9-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:16 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> EC FIFO can send sensor events in batch. Spread them based on
> previous (TSa) and currnet timestamp (TSb)
> 
>   EC FIFO                             iio events
> +-----------+
> | TSa       |
> +-----------+             +---------------------------------------+
> | event 1   |             | event 1 | TSb - (TSb - TSa)/n * (n-1) |
> +-----------+             +---------------------------------------+
> | event 2   |             | event 2 | TSb - (TSb - TSa)/n * (n-2) |
> +-----------+             +---------------------------------------+
> |  ...      |  ------>    |  ....   |                             |
> +-----------+             +---------------------------------------+
> | event n-1 |             | event 2 | TSb - (TSb - TSa)/n         |
> +-----------+             +---------------------------------------+
> | event n   |             | event 2 | TSb                         |
> +-----------+             +---------------------------------------+
> | TSb       |
> +-----------+
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Looks fine to me and the docs are nice :)
Timestamps for batches are always a pita.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 99 ++++++++++++++++++-
>  1 file changed, 96 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index 8cd533d5542e..48327e80a5a3 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -160,6 +160,97 @@ static bool cros_ec_ring_process_event(
>  	return true;
>  }
>  
> +/*
> + * cros_ec_ring_spread_add: Calculate proper timestamps then
> + * add to ringbuffer (legacy).
> + *
> + * If there is a sample with a proper timestamp
> + *                        timestamp | count
> + * older_unprocess_out --> TS1      | 1
> + *                         TS1      | 2
> + * out -->                 TS1      | 3
> + * next_out -->            TS2      |
> + * We spread time for the samples [older_unprocess_out .. out]
> + * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
> + *
> + * If we reach the end of the samples, we compare with the
> + * current timestamp:
> + *
> + * older_unprocess_out --> TS1      | 1
> + *                         TS1      | 2
> + * out -->                 TS1      | 3
> + * We know have [TS1+1/3, TS1+2/3, current timestamp]
> + */
> +static void cros_ec_ring_spread_add(
> +				struct cros_ec_sensorhub *sensorhub,
> +				unsigned long sensor_mask,
> +				s64 current_timestamp,
> +				struct cros_ec_sensors_ring_sample *last_out)
> +{
> +	struct cros_ec_sensors_ring_sample *out;
> +	int i;
> +
> +	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
> +		s64 older_timestamp;
> +		s64 timestamp;
> +		struct cros_ec_sensors_ring_sample *older_unprocess_out =
> +			sensorhub->ring;
> +		struct cros_ec_sensors_ring_sample *next_out;
> +		int count = 1;
> +
> +		for (out = sensorhub->ring; out < last_out; out = next_out) {
> +			s64 time_period;
> +
> +			next_out = out + 1;
> +			if (out->sensor_id != i)
> +				continue;
> +
> +			/* Timestamp to start with */
> +			older_timestamp = out->timestamp;
> +
> +			/* find next sample */
> +			while (next_out < last_out && next_out->sensor_id != i)
> +				next_out++;
> +
> +			if (next_out >= last_out) {
> +				timestamp = current_timestamp;
> +			} else {
> +				timestamp = next_out->timestamp;
> +				if (timestamp == older_timestamp) {
> +					count++;
> +					continue;
> +				}
> +			}
> +
> +			/*
> +			 * The next sample has a new timestamp,
> +			 * spread the unprocessed samples.
> +			 */
> +			if (next_out < last_out)
> +				count++;
> +			time_period = div_s64(timestamp - older_timestamp,
> +					      count);
> +
> +			for (; older_unprocess_out <= out;
> +					older_unprocess_out++) {
> +				if (older_unprocess_out->sensor_id != i)
> +					continue;
> +				older_timestamp += time_period;
> +				older_unprocess_out->timestamp =
> +					older_timestamp;
> +			}
> +			count = 1;
> +			/* The next_out sample has a valid timestamp, skip. */
> +			next_out++;
> +			older_unprocess_out = next_out;
> +		}
> +	}
> +
> +	/* push the event into the kfifo */
> +	for (out = sensorhub->ring; out < last_out; out++)
> +		cros_sensorhub_send_sample(sensorhub, out);
> +}
> +
>  /*
>   * cros_ec_sensorhub_ring_handler - the trigger handler function
>   *
> @@ -280,9 +371,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  		}
>  	}
>  
> -	/* push the event into the kfifo */
> -	for (out = sensorhub->ring; out < last_out; out++)
> -		cros_sensorhub_send_sample(sensorhub, out);
> +	/*
> +	 * Spread samples in case of batching, then add them to the ringbuffer.
> +	 */
> +	cros_ec_ring_spread_add(sensorhub, sensor_mask,
> +			current_timestamp, last_out);
>  
>  ring_handler_end:
>  	sensorhub->fifo_timestamp[LAST_TS] = current_timestamp;

