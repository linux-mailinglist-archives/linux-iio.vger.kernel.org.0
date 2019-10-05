Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048D5CCB14
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEQYT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfJEQYS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:24:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78BE20862;
        Sat,  5 Oct 2019 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570292655;
        bh=w1RQZ9uAwUrnzsvjaMQ4+H5iGjs5GNKlqp+TPURqoRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mb/gyUZw21pgqPp7uYOTjX/HLci5QcdfNKbIg+A9zl9alX88V8wjTZRtD5NT3ae32
         n5Zbnc28dlIOY13qnye7wipvrstPZsjRM8wuNlMFJfIjb6R+R3+y7q5guRTI2Mev+h
         VJaRx+Z0IEK0lyNwaSWPlb1JDhEUVrI8tIxHs0ZA=
Date:   Sat, 5 Oct 2019 17:24:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/13] platform: chrome: sensorhub: Add median filter
Message-ID: <20191005172409.2ad45bd0@archlinux>
In-Reply-To: <20190922175021.53449-10-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-10-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:17 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Events are timestamped in EC time space, their timestamps need to be
> converted in host time space.
> The assumption is the time delta between when the interrupt is sent
> by the EC and when it is receive by the host is a [small] constant.
> This is not always true, even with hard-wired interrupt. To mitigate
> worst offenders, add a median filter to weed out bigger than expected
> delays.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
This stuff is always hard to get right. I'll assume you've tested
this extensively :)

I'll be honest, I'm going to assume you have this right as it would be a
while before I'd find time to go through this with a fine toothed comb
and I'd probably need right unit tests etc.  Hence my comments
are superficial + there is a worrying looking todo in there I don't
understand ;)

Thanks,

Jonathan


> ---
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 485 +++++++++++++++++-
>  .../linux/platform_data/cros_ec_sensorhub.h   |  65 +++
>  2 files changed, 533 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index 48327e80a5a3..9955c80d0907 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -69,9 +69,11 @@ int cros_ec_sensorhub_ring_fifo_toggle(
>  		struct cros_ec_sensorhub *sensorhub,
>  		bool on)
>  {
> -	int ret;
> +	int ret, i;
>  
>  	mutex_lock(&sensorhub->cmd_lock);
> +	for (i = 0; i < CROS_EC_SENSOR_MAX; i++)
> +		sensorhub->last_batch_len[i] = 0;
>  	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INT_ENABLE;
>  	sensorhub->params->fifo_int_enable.enable = on;
>  
> @@ -86,6 +88,227 @@ int cros_ec_sensorhub_ring_fifo_toggle(
>  	return ret;
>  }
>  
> +static int cros_ec_ring_median_cmp(const void *pv1, const void *pv2)
> +{
> +	s64 v1 = *(s64 *)pv1;
> +	s64 v2 = *(s64 *)pv2;
> +
> +	if (v1 > v2)
> +		return 1;
> +	else if (v1 < v2)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
> +/*
> + * cros_ec_ring_median: Gets median of an array of numbers
> + *
> + * For now it's implemented using an inefficient > O(n) sort then return
> + * the middle element. A more optimal method would be something like
> + * quickselect, but given that n = 64 we can probably live with it in the
> + * name of clarity.
> + *
> + * Warning: the input array gets modified (sorted)!
> + */
> +static s64 cros_ec_ring_median(s64 *array, size_t length)
> +{
> +	sort(array, length, sizeof(s64), cros_ec_ring_median_cmp, NULL);
> +	return array[length / 2];
> +}
> +
> +/*
> + * IRQ Timestamp Filtering
> + *
> + * Lower down in cros_ec_ring_process_event(), for each sensor event we have to
> + * calculate it's timestamp in the AP timebase. There are 3 time points:
> + *   a - EC timebase, sensor event
> + *   b - EC timebase, IRQ
> + *   c - AP timebase, IRQ
> + *   a' - what we want: sensor even in AP timebase
> + *
> + * While a and b are recorded at accurate times (due to the EC real time
> + * nature); c is pretty untrustworthy, even though it's recorded the
> + * first thing in ec_irq_handler(). There is a very good change we'll get
> + * added lantency due to:
> + *   other irqs
> + *   ddrfreq
> + *   cpuidle
> + *
> + * Normally a' = c - b + a, but if we do that naive math any jitter in c
> + * will get coupled in a', which we don't want. We want a function
> + * a' = cros_ec_ring_ts_filter(a) which will filter out outliers in c.
> + *
> + * Think of a graph of AP time(b) on the y axis vs EC time(c) on the x axis.
> + * The slope of the line won't be exactly 1, there will be some clock drift
> + * between the 2 chips for various reasons (mechanical stress, temperature,
> + * voltage). We need to extrapolate values for a future x, without trusting
> + * recent y values too much.
> + *
> + * We use a median filter for the slope, then another median filter for the
> + * y-intercept to calculate this function:
> + *   dx[n] = x[n-1] - x[n]
> + *   dy[n] = x[n-1] - x[n]
> + *   m[n] = dy[n] / dx[n]
> + *   median_m = median(m[n-k:n])
> + *   error[i] = y[n-i] - median_m * x[n-i]
> + *   median_error = median(error[:k])
> + *   predicted_y = median_m * x + median_error
> + *
> + * Implementation differences from above:
> + * - Redefined y to be actually c - b, this gives us a lot more precision
> + * to do the math. (c-b)/b variations are more obvious than c/b variations.
> + * - Since we don't have floating point, any operations involving slope are
> + * done using fixed point math (*M_PRECISION)
> + * - Since x and y grow with time, we keep zeroing the graph (relative to
> + * the last sample), this way math involving *x[n-i] will not overflow
> + * - EC timestamps are kept in us, it improves the slope calculation precision
> + */
> +
> +/*
> + * cros_ec_ring_ts_filter_update: Given a new IRQ timestamp pair (EC and
> + * AP timebases), add it to the filter history.
> + *
> + * @b IRQ timestamp, EC timebase (us)
> + * @c IRQ timestamp, AP timebase (ns)
> + */
> +static void cros_ec_ring_ts_filter_update(
> +			struct cros_ec_sensors_ts_filter_state *state,
> +			s64 b, s64 c)
> +{
> +	s64 x, y;
> +	s64 dx, dy;
> +	s64 m; /* stored as *M_PRECISION */
> +	s64 *m_history_copy = state->temp_buf;
> +	s64 *error = state->temp_buf;
> +	int i;
> +
> +	/* we trust b the most, that'll be our independent variable */
> +	x = b;
> +	/* y is the offset between AP and EC times, in ns */
> +	y = c - b * 1000;
> +
> +	dx = (state->x_history[0] + state->x_offset) - x;
> +	if (dx == 0)
> +		return; /* we already have this irq in the history */
> +	dy = (state->y_history[0] + state->y_offset) - y;
> +	m = div64_s64(dy * M_PRECISION, dx);
> +
> +	/* Empty filter if we haven't seen any action in a while. */
> +	if (-dx > TS_HISTORY_BORED_US)
> +		state->history_len = 0;
> +
> +	/* Move everything over, also update offset to all absolute coords .*/
> +	for (i = state->history_len - 1; i >= 1; i--) {
> +		state->x_history[i] = state->x_history[i-1] + dx;
> +		state->y_history[i] = state->y_history[i-1] + dy;
> +
> +		state->m_history[i] = state->m_history[i-1];
> +		/*
> +		 * Also use the same loop to copy m_history for future
> +		 * median extraction.
> +		 */
> +		m_history_copy[i] = state->m_history[i-1];
> +	}
> +
> +	/* Store the x and y, but remember offset is actually last sample. */
> +	state->x_offset = x;
> +	state->y_offset = y;
> +	state->x_history[0] = 0;
> +	state->y_history[0] = 0;
> +
> +	state->m_history[0] = m;
> +	m_history_copy[0] = m;
> +
> +	if (state->history_len < TS_HISTORY_SIZE)
> +		state->history_len++;
> +
> +	/* Precalculate things for the filter. */
> +	if (state->history_len > TS_HISTORY_THRESHOLD) {
> +		state->median_m =
> +		    cros_ec_ring_median(m_history_copy, state->history_len - 1);
> +
> +		/*
> +		 * Calculate y-intercepts as if m_median is the slope and
> +		 * points in the history are on the line. median_error will
> +		 * still be in the offset coordinate system.
> +		 */
> +		for (i = 0; i < state->history_len; i++)
> +			error[i] = state->y_history[i] -
> +				div_s64(state->median_m * state->x_history[i],
> +					M_PRECISION);
> +		state->median_error =
> +			cros_ec_ring_median(error, state->history_len);
> +	} else {
> +		state->median_m = 0;
> +		state->median_error = 0;
> +	}
> +}
> +
> +/*
> + * cros_ec_ring_ts_filter: Translate EC timebase timestamp to AP timebase
> + *
> + * @x any ec timestamp (us):
> + *
> + * cros_ec_ring_ts_filter(a) => a' event timestamp, AP timebase
> + * cros_ec_ring_ts_filter(b) => calculated timestamp when the EC IRQ
> + *                           should have happened on the AP, with low jitter
> + *
> + * @returns timestamp in AP timebase (ns)
> + *
> + * Note: The filter will only activate once state->history_len goes
> + * over TS_HISTORY_THRESHOLD. Otherwise it'll just do the naive c - b + a
> + * transform.
> + *
> + * How to derive the formula, starting from:
> + *   f(x) = median_m * x + median_error
> + * That's the calculated AP - EC offset (at the x point in time)
> + * Undo the coordinate system transform:
> + *   f(x) = median_m * (x - x_offset) + median_error + y_offset
> + * Remember to undo the "y = c - b * 1000" modification:
> + *   f(x) = median_m * (x - x_offset) + median_error + y_offset + x * 1000
> + */
> +static s64 cros_ec_ring_ts_filter(struct cros_ec_sensors_ts_filter_state *state,
> +				  s64 x)
> +{
> +	return div_s64(state->median_m * (x - state->x_offset), M_PRECISION)
> +	       + state->median_error + state->y_offset + x * 1000;
> +}
> +
> +/*
> + * Since a and b were originally 32 bit values from the EC,
> + * they overflow relatively often, casting is not enough, so we need to
> + * add an offset.
> + */
> +static void cros_ec_ring_fix_overflow(s64 *ts,
> +		const s64 overflow_period,
> +		struct cros_ec_sensors_ec_overflow_state *state)
> +{
> +	s64 adjust;
> +
> +	*ts += state->offset;
> +	if (abs(state->last - *ts) > (overflow_period / 2)) {
> +		adjust = state->last > *ts ? overflow_period : -overflow_period;
> +		state->offset += adjust;
> +		*ts += adjust;
> +	}
> +	state->last = *ts;
> +}
> +
> +static void cros_ec_ring_check_for_past_timestamp(
> +				struct cros_ec_sensorhub *sensorhub,
> +				struct cros_ec_sensors_ring_sample *sample)
> +{
> +	const u8 sensor_id = sample->sensor_id;
> +
> +	// if this event is earlier than one we saw before...
/* please :)
> +	if (sensorhub->newest_sensor_event[sensor_id] > sample->timestamp)
> +		// mark it for spreading
> +		sample->timestamp = sensorhub->last_batch_timestamp[sensor_id];
> +	else
> +		sensorhub->newest_sensor_event[sensor_id] = sample->timestamp;
> +}
> +
>  /*
>   * cros_ec_ring_process_event: process one EC FIFO event
>   *
> @@ -117,25 +340,47 @@ static bool cros_ec_ring_process_event(
>  		s64 a = in->timestamp;
>  		s64 b = fifo_info->info.timestamp;
>  		s64 c = fifo_timestamp;
> -		s64 new_timestamp;
>  
> +		cros_ec_ring_fix_overflow(&a, 1LL << 32,
> +				&sensorhub->overflow_a);
> +		cros_ec_ring_fix_overflow(&b, 1LL << 32,
> +				&sensorhub->overflow_b);
> +
> +		if (sensorhub->tight_timestamps) {
> +			cros_ec_ring_ts_filter_update(&sensorhub->filter, b, c);
> +			*current_timestamp =
> +				cros_ec_ring_ts_filter(&sensorhub->filter, a);
> +		} else {
> +			s64 new_timestamp;
> +			/*
> +			 * disable filtering since we might add more jitter
> +			 * if b is in a random point in time
> +			 */
> +			new_timestamp = c - b * 1000 + a * 1000;
> +			/*
> +			 * The timestamp can be stale if we had to use the fifo
> +			 * info timestamp.
> +			 */
> +			if (new_timestamp - *current_timestamp > 0)
> +				*current_timestamp = new_timestamp;
> +		}
> +	}
> +
> +	if (in->flags & MOTIONSENSE_SENSOR_FLAG_ODR) {
> +		sensorhub->last_batch_len[in->sensor_num] =
> +			sensorhub->penultimate_batch_len[in->sensor_num] = 0;
>  		/*
> -		 * disable filtering since we might add more jitter
> -		 * if b is in a random point in time
> -		 */
> -		new_timestamp = c - b * 1000 + a * 1000;
> -		/*
> -		 * The timestamp can be stale if we had to use the fifo
> -		 * info timestamp.
> +		 * ODR change is only useful for the sensor_ring, it does not
> +		 * convey information to clients.
>  		 */
> -		if (new_timestamp - *current_timestamp > 0)
> -			*current_timestamp = new_timestamp;
> +		return false;
>  	}
>  
>  	if (in->flags & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
>  		out->sensor_id = in->sensor_num;
>  		out->timestamp = *current_timestamp;
>  		out->flag = in->flags;
> +		sensorhub->last_batch_len[out->sensor_id] = 0;
>  		/*
>  		 * No other payload information provided with
>  		 * flush ack.
> @@ -149,7 +394,22 @@ static bool cros_ec_ring_process_event(
>  	/* Regular sample */
>  	out->sensor_id = in->sensor_num;
>  	if (*current_timestamp - now > 0) {
> -		/* If the timestamp is in the future. */
> +		/*
> +		 * This fix is needed to overcome the timestamp filter putting
> +		 * events in the future.
> +		 */
> +		sensorhub->future_timestamp_total_ns +=
> +			*current_timestamp - now;
> +		if (++sensorhub->future_timestamp_count ==
> +				FUTURE_TS_ANALYTICS_COUNT_MAX) {
> +			s64 avg = div_s64(sensorhub->future_timestamp_total_ns,
> +					sensorhub->future_timestamp_count);
> +			dev_warn(sensorhub->dev,
> +					"100 timestamps in the future, %lldns shaved on average\n",
> +					avg);
> +			sensorhub->future_timestamp_count = 0;
> +			sensorhub->future_timestamp_total_ns = 0;
> +		}
>  		out->timestamp = now;
>  	} else {
>  		out->timestamp = *current_timestamp;
> @@ -157,13 +417,195 @@ static bool cros_ec_ring_process_event(
>  	out->flag = in->flags;
>  	for (axis = 0; axis < 3; axis++)
>  		out->vector[axis] = in->data[axis];
> +	if (sensorhub->tight_timestamps)
> +		cros_ec_ring_check_for_past_timestamp(sensorhub, out);
>  	return true;
>  }
>  
>  /*
> - * cros_ec_ring_spread_add: Calculate proper timestamps then
> + * cros_ec_ring_spread_add: Calculate proper timestamps then add to ringbuffer.
> + *
> + * Note: This is the new spreading code, assumes every sample's timestamp
> + * preceeds the sample. Run if tight_timestamps == true.
> + *
> + * Sometimes the EC receives only one interrupt (hence timestamp) for
> + * a batch of samples. Only the first sample will have the correct
> + * timestamp. So we must interpolate the other samples.
> + * We use the previous batch timestamp and our current batch timestamp
> + * as a way to calculate period, then spread the samples evenly.
> + *
> + * s0 int, 0ms
> + * s1 int, 10ms
> + * s2 int, 20ms
> + * 30ms point goes by, no interrupt, previous one is still asserted
> + * downloading s2 and s3
> + * s3 sample, 20ms (incorrect timestamp)
> + * s4 int, 40ms
> + *
> + * The batches are [(s0), (s1), (s2, s3), (s4)]. Since the 3rd batch
> + * has 2 samples in them, we adjust the timestamp of s3.
> + * s2 - s1 = 10ms, so s3 must be s2 + 10ms => 20ms. If s1 would have
> + * been part of a bigger batch things would have gotten a little
> + * more complicated.
> + *
> + * Note: we also assume another sensor sample doesn't break up a batch
> + * in 2 or more partitions. Example, there can't ever be a sync sensor
> + * in between S2 and S3. This simplifies the following code.
> + */
> +static void cros_ec_ring_spread_add(
> +				struct cros_ec_sensorhub *sensorhub,
> +				unsigned long sensor_mask,
> +				struct cros_ec_sensors_ring_sample *last_out)
> +{
> +	struct cros_ec_sensors_ring_sample *batch_start, *next_batch_start;
> +	int id;
> +
> +	for_each_set_bit(id, &sensor_mask, BITS_PER_LONG) {
> +		for (batch_start = sensorhub->ring; batch_start < last_out;
> +		     batch_start = next_batch_start) {
> +			/*
> +			 * For each batch (where all samples have the same
> +			 * timestamp).
> +			 */
> +			int batch_len, sample_idx;
> +			struct cros_ec_sensors_ring_sample *batch_end =
> +				batch_start;
> +			struct cros_ec_sensors_ring_sample *s;
> +			s64 batch_timestamp = batch_start->timestamp;
> +			s64 sample_period;
> +
> +			/*
> +			 * Skip over batches that start with the sensor types
> +			 * we're not looking at right now.
> +			 */
> +			if (batch_start->sensor_id != id) {
> +				next_batch_start = batch_start + 1;
> +				continue;
> +			}
> +
> +			/*
> +			 * TODO(gwendal): can not send out flush packets
> +			 * anymore.
> +			 * Do not start a batch
> +			 * from a flush, as it happens asynchronously to the
> +			 * regular flow of events.

Slightly worrying TODO... Fixed later?

> +			 */
> +			if (batch_start->flag &
> +				MOTIONSENSE_SENSOR_FLAG_FLUSH) {
> +				next_batch_start = batch_start + 1;
> +				continue;
> +			}
> +
> +			if (batch_start->timestamp <=
> +				sensorhub->last_batch_timestamp[id]) {
> +
> +				batch_timestamp =
> +					sensorhub->last_batch_timestamp[id];
> +				batch_len = sensorhub->last_batch_len[id];
> +
> +				sample_idx = batch_len;
> +
> +				sensorhub->last_batch_timestamp[id] =
> +				  sensorhub->penultimate_batch_timestamp[id];
> +				sensorhub->last_batch_len[id] =
> +				  sensorhub->penultimate_batch_len[id];
> +			} else {
> +				/*
> +				 * Push first sample in the batch to the,
> +				 * kifo, it's guaranteed to be correct, the
> +				 * rest will follow later on.
> +				 */
> +				sample_idx = batch_len = 1;
> +				cros_sensorhub_send_sample(
> +						sensorhub, batch_start);
> +				batch_start++;
> +			}
> +
> +			/* Find all samples have the same timestamp. */
> +			for (s = batch_start; s < last_out; s++) {
> +				if (s->sensor_id != id)
> +					/*
> +					 * Skip over other sensor types that
> +					 * are interleaved, don't count them.
> +					 */
> +					continue;
> +				if (s->timestamp != batch_timestamp)
> +					/* we discovered the next batch */
> +					break;
> +				if (s->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH)
> +					/* break on flush packets */
> +					break;
> +				batch_end = s;
> +				batch_len++;
> +			}
> +
> +			if (batch_len == 1)
> +				goto done_with_this_batch;
> +
> +			/* Can we calculate period? */
> +			if (sensorhub->last_batch_len[id] == 0) {
> +				dev_warn(sensorhub->dev, "Sensor %d: lost %d samples when spreading\n",
> +						id, batch_len - 1);
> +				goto done_with_this_batch;
> +				/*
> +				 * Note: we're dropping the rest of the samples
> +				 * in this batch since we have no idea where
> +				 * they're supposed to go without a period
> +				 * calculation.
> +				 */
> +			}
> +
> +			sample_period = div_s64(batch_timestamp -
> +					sensorhub->last_batch_timestamp[id],
> +					sensorhub->last_batch_len[id]);
> +			dev_dbg(sensorhub->dev,
> +					"Adjusting %d samples, sensor %d last_batch @%lld (%d samples) batch_timestamp=%lld => period=%lld\n",
> +					batch_len, id,
> +					sensorhub->last_batch_timestamp[id],
> +					sensorhub->last_batch_len[id],
> +					batch_timestamp,
> +					sample_period);
> +
> +			/*
> +			 * Adjust timestamps of the samples then push them to
> +			 * kfifo.
> +			 */
> +			for (s = batch_start; s <= batch_end; s++) {
> +				if (s->sensor_id != id)
> +					/*
> +					 * Skip over other sensor types that
> +					 * are interleaved, don't change them.
> +					 */
> +					continue;
> +
> +				s->timestamp = batch_timestamp +
> +					sample_period * sample_idx;
> +				sample_idx++;
> +
> +				cros_sensorhub_send_sample(sensorhub, s);
> +			}
> +
> +done_with_this_batch:
> +			sensorhub->penultimate_batch_timestamp[id] =
> +				sensorhub->last_batch_timestamp[id];
> +			sensorhub->penultimate_batch_len[id] =
> +				sensorhub->last_batch_len[id];
> +
> +			sensorhub->last_batch_timestamp[id] = batch_timestamp;
> +			sensorhub->last_batch_len[id] = batch_len;
> +
> +			next_batch_start = batch_end + 1;
> +		}
> +	}
> +}
> +
> +/*
> + * cros_ec_ring_spread_add_legacy: Calculate proper timestamps then
>   * add to ringbuffer (legacy).
>   *
> + * Note: This assumes we're running old firmware, where every sample's timestamp
> + * is after the sample. Run if tight_timestamps == false.
> + *
>   * If there is a sample with a proper timestamp
>   *                        timestamp | count
>   * older_unprocess_out --> TS1      | 1
> @@ -181,7 +623,7 @@ static bool cros_ec_ring_process_event(
>   * out -->                 TS1      | 3
>   * We know have [TS1+1/3, TS1+2/3, current timestamp]
>   */
> -static void cros_ec_ring_spread_add(
> +static void cros_ec_ring_spread_add_legacy(
>  				struct cros_ec_sensorhub *sensorhub,
>  				unsigned long sensor_mask,
>  				s64 current_timestamp,
> @@ -355,7 +797,8 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  	 * the AP is slow to respond to the IRQ, the EC may have added new
>  	 * samples. Use the FIFO info timestamp as last timestamp then.
>  	 */
> -	if ((last_out-1)->timestamp == current_timestamp)
> +	if (!sensorhub->tight_timestamps &&
> +	    (last_out-1)->timestamp == current_timestamp)
>  		current_timestamp = fifo_timestamp;
>  
>  	/* Warn on lost samples. */
> @@ -367,6 +810,7 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  				dev_warn(sensorhub->dev,
>  					"Sensor %d: lost: %d out of %d\n", i,
>  					lost, fifo_info->info.total_lost);
> +				sensorhub->last_batch_len[i] = 0;
>  			}
>  		}
>  	}
> @@ -374,8 +818,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  	/*
>  	 * Spread samples in case of batching, then add them to the ringbuffer.
>  	 */
> -	cros_ec_ring_spread_add(sensorhub, sensor_mask,
> -			current_timestamp, last_out);
> +	if (sensorhub->tight_timestamps)
> +		cros_ec_ring_spread_add(sensorhub, sensor_mask, last_out);
> +	else
> +		cros_ec_ring_spread_add_legacy(sensorhub, sensor_mask,
> +					       current_timestamp, last_out);
>  
>  ring_handler_end:
>  	sensorhub->fifo_timestamp[LAST_TS] = current_timestamp;
> @@ -436,6 +883,10 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
>  
>  	sensorhub->fifo_timestamp[LAST_TS] = cros_ec_get_time_ns();
>  
> +	sensorhub->tight_timestamps = cros_ec_check_features(ec,
> +		EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
> +
> +
>  	/* register the notifier that will act as a top half interrupt. */
>  	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
>  	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index 18cda568c58a..df67f2015da9 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -53,6 +53,42 @@ struct cros_ec_sensors_ring_sample {
>  	s64      timestamp;
>  } __packed;
>  
> +/* State used for cros_ec_ring_fix_overflow */
> +struct cros_ec_sensors_ec_overflow_state {
> +	s64 offset;
> +	s64 last;
> +};
> +
> +/* Precision of fixed point for the m values from the filter */
> +#define M_PRECISION (1 << 23)

These are a bit generic names.  Prefix them so we don't get a clash
sometime in the future.

> +
> +/* Length of the filter, how long to remember entries for */
> +#define TS_HISTORY_SIZE 64
> +
> +/* Only activate the filter once we have at least this many elements. */
> +#define TS_HISTORY_THRESHOLD 8
> +
> +/*
> + * If we don't have any history entries for this long, empty the filter to
> + * make sure there are no big discontinuities.
> + */
> +#define TS_HISTORY_BORED_US 500000
> +
> +struct cros_ec_sensors_ts_filter_state {
> +	s64 x_offset, y_offset;
> +	s64 x_history[TS_HISTORY_SIZE]; /* stored relative to x_offset */
> +	s64 y_history[TS_HISTORY_SIZE]; /* stored relative to y_offset */
> +	s64 m_history[TS_HISTORY_SIZE]; /* stored as *M_PRECISION */
> +	int history_len;
> +
> +	s64 temp_buf[TS_HISTORY_SIZE];
> +
> +	s64 median_m;
> +	s64 median_error;
> +};
> +
> +#define FUTURE_TS_ANALYTICS_COUNT_MAX 100
> +
>  /**
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   */
> @@ -76,6 +112,35 @@ struct cros_ec_sensorhub {
>  	struct cros_ec_fifo_info fifo_info;
>  	int    fifo_size;
>  
> +	/* Used for timestamp spreading calculations when a batch shows up */
> +	s64 penultimate_batch_timestamp[CROS_EC_SENSOR_MAX];
> +	int penultimate_batch_len[CROS_EC_SENSOR_MAX];
> +	s64 last_batch_timestamp[CROS_EC_SENSOR_MAX];
> +	int last_batch_len[CROS_EC_SENSOR_MAX];
> +	s64 newest_sensor_event[CROS_EC_SENSOR_MAX];
> +
> +	struct cros_ec_sensors_ec_overflow_state overflow_a;
> +	struct cros_ec_sensors_ec_overflow_state overflow_b;
> +
> +	struct cros_ec_sensors_ts_filter_state filter;
> +
> +	/*
> +	 * The timestamps reported from the EC have low jitter.
> +	 * Timestamps also come before every sample.
> +	 * Set either by feature bits coming from the EC or userspace.
> +	 */
> +	bool tight_timestamps;
> +
> +	/*
> +	 * Statistics used to compute shaved time. This occures when
> +	 * timestamp interpolation from EC time to AP time accidentally
> +	 * puts timestamps in the future. These timestamps are clamped
> +	 * to `now` and these count/total_ns maintain the statistics for
> +	 * how much time was removed in a given period..
> +	 */
> +	s32 future_timestamp_count;
> +	s64 future_timestamp_total_ns;
> +
>  	/*
>  	 * Dynamic array to be able to spread datum to iio sensor objects.
>  	 */

