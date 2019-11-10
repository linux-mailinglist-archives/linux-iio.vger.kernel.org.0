Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78074F68FF
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 13:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfKJM55 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 07:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfKJM55 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 07:57:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AC420818;
        Sun, 10 Nov 2019 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573390675;
        bh=sOPEmD8R4x2wPmv5cSoOOLhR3OGYT3d5fyNhtMD6hrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wnzPJ1C2neHoSZmm7sUxXNpHlRtWbClsudNlugGO4SiFCRgJPLKtCAY/9CM8xjkcV
         wV1N8HcD9jbCNqFY17HEwO22AjTkYdjdTi4ZHFFyRgRyP50WtcKZNsUy+Cp5ocKkNb
         JM+YjfuAC9RJv2mqKvN+0IEjA4TlXo4HG7jdRLsY=
Date:   Sun, 10 Nov 2019 12:57:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 10/17] platform: chrome: sensorhub: Add code to
 spread timestmap
Message-ID: <20191110125749.1b5b1451@archlinux>
In-Reply-To: <20191105222652.70226-11-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-11-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:45 -0800
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
Looks fine to me but I haven't been through this all that closely..
I'm just assuming the maths is right ;)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v4:
> - Check patch with --strict option
>     Alignement
> No changes in v3.
> Changes in v2:
> - Use CROS_EC_SENSOR_LAST_TS instead of LAST_TS to avoid name colisions.
> 
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 98 ++++++++++++++++++-
>  1 file changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index f091f2a4ccfe..b22a71406742 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -187,6 +187,96 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
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
> +static void cros_ec_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
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
> @@ -322,9 +412,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
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
> +	cros_ec_ring_spread_add(sensorhub, sensor_mask,	current_timestamp, last_out);

>  
>  ring_handler_end:
>  	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;

