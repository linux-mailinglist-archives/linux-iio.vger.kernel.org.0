Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E770F6906
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJNH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 08:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfKJNH2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 08:07:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B282085B;
        Sun, 10 Nov 2019 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573391246;
        bh=tsUN1K+uAuSaJN0opXpOcITfYKeFqBKHhNeP3p/BNDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZoyzK2IpAni8E49DKm3xmqqH6AT1avVC8Fxl7mMVa8rf76J/m8Okb98PdhT8zJnQ
         EDoCXs3oRjwIP5Zal2hk7Luc6gsv5F+OQinnt3wZOHH5ZfHxAXBPDvct/IT3DHeqMp
         cLSKUQ9R7cDHkasamU2b1XNXbs0lz8aakDKWnnlg=
Date:   Sun, 10 Nov 2019 13:07:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 11/17] platform: chrome: sensorhub: Add median filter
Message-ID: <20191110130719.77e8457e@archlinux>
In-Reply-To: <20191105222652.70226-12-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-12-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:46 -0800
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
A few minor things inline seeing as you will be respinning.
Again, I've not checked the maths as don't have that much time available!

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v4:
> - Keep defining cros_ec_sensorhub in kernel-doc format
> - Check patch with --strict option
>     Use BIT()
>     Add spaces around '-'
>     Alignement
> Changes in v3:
> - Fix doxygen code.
> Changes in v2:
> - Move some #define in .c to prevent name collisions.
> - Add proper doxygen comments.
> - Use /* instead of //
> 
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 505 +++++++++++++++++-
>  .../linux/platform_data/cros_ec_sensorhub.h   |  75 +++
>  2 files changed, 562 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index b22a71406742..8960081caeba 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -18,6 +18,21 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  
> +/* Precision of fixed point for the m values from the filter */
> +#define M_PRECISION BIT(23)
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
> +/* To measure by how much the filter is overshooting, if it happens. */
> +#define FUTURE_TS_ANALYTICS_COUNT_MAX 100
> +
>  static inline int cros_sensorhub_send_sample(
>  		struct cros_ec_sensorhub *sensorhub,
>  		struct cros_ec_sensors_ring_sample *sample)
> @@ -91,9 +106,11 @@ EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
>  int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
>  				       bool on)
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
> @@ -110,6 +127,231 @@ int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
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
> +/**
> + * cros_ec_ring_ts_filter_update - Update filter history.
> + *
> + * @state: Filter information.
> + * @b: IRQ timestamp, EC timebase (us)
> + * @c: IRQ timestamp, AP timebase (ns)
> + *
> + * Given a new IRQ timestamp pair (EC and AP timebases), add it to the filter
> + * history.
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
> +		state->x_history[i] = state->x_history[i - 1] + dx;
> +		state->y_history[i] = state->y_history[i - 1] + dy;
> +
> +		state->m_history[i] = state->m_history[i - 1];
> +		/*
> +		 * Also use the same loop to copy m_history for future
> +		 * median extraction.
> +		 */
> +		m_history_copy[i] = state->m_history[i - 1];
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
> +	if (state->history_len < CROS_EC_SENSORHUB_TS_HISTORY_SIZE)
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
> +/**
> + * cros_ec_ring_ts_filter - Translate EC timebase timestamp to AP timebase
> + *
> + * @state: filter information.
> + * @x: any ec timestamp (us):
> + *
> + * cros_ec_ring_ts_filter(a) => a' event timestamp, AP timebase
> + * cros_ec_ring_ts_filter(b) => calculated timestamp when the EC IRQ
> + *                           should have happened on the AP, with low jitter
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
> + *
> + * Return: timestamp in AP timebase (ns)
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
> +				const s64 overflow_period,
> +				struct cros_ec_sensors_ec_overflow_state *state)
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
> +	/* If this event is earlier than one we saw before... */
> +	if (sensorhub->newest_sensor_event[sensor_id] > sample->timestamp)
> +		/* mark it for spreading. */
> +		sample->timestamp = sensorhub->last_batch_timestamp[sensor_id];
> +	else
> +		sensorhub->newest_sensor_event[sensor_id] = sample->timestamp;
> +}
> +
>  /**
>   * cros_ec_ring_process_event - process one EC FIFO event
>   *
> @@ -141,32 +383,54 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
>  		s64 a = in->timestamp;
>  		s64 b = fifo_info->info.timestamp;
>  		s64 c = fifo_timestamp;
> -		s64 new_timestamp;
>  
> -		/*
> -		 * disable filtering since we might add more jitter
> -		 * if b is in a random point in time
> -		 */
> -		new_timestamp = c - b * 1000 + a * 1000;
> +		cros_ec_ring_fix_overflow(&a, 1LL << 32,
> +					  &sensorhub->overflow_a);
> +		cros_ec_ring_fix_overflow(&b, 1LL << 32,
> +					  &sensorhub->overflow_b);
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
>  
> +	if (in->flags & MOTIONSENSE_SENSOR_FLAG_ODR) {
> +		sensorhub->last_batch_len[in->sensor_num] =
> +			sensorhub->penultimate_batch_len[in->sensor_num] = 0;
>  		/*
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
>  		 */
>  		return true;
>  	}
> +

Unrelated change.  Would rather not see those in a series doing interesting
things like this.

>  	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP)
>  		/* If we just have a timestamp, skip this entry. */
>  		return false;
> @@ -174,7 +438,22 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
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
> +				 "100 timestamps in the future, %lldns shaved on average\n",
> +				 avg);

I'll assume this actually happens from time to time given the effort you are putting
in to handle it.  If so do we want near uncontrolled spamming of the log?

> +			sensorhub->future_timestamp_count = 0;
> +			sensorhub->future_timestamp_total_ns = 0;
> +		}
>  		out->timestamp = now;
>  	} else {
>  		out->timestamp = *current_timestamp;
> @@ -184,13 +463,194 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
>  	for (axis = 0; axis < 3; axis++)
>  		out->vector[axis] = in->data[axis];
>  
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
> +			 * Do not start a batch
> +			 * from a flush, as it happens asynchronously to the
> +			 * regular flow of events.
> +			 */
> +			if (batch_start->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
> +				cros_sensorhub_send_sample(sensorhub,
> +							   batch_start);
> +				next_batch_start = batch_start + 1;
> +				continue;
> +			}
> +
> +			if (batch_start->timestamp <=
> +			    sensorhub->last_batch_timestamp[id]) {
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
> +				sample_idx = 1;
> +				batch_len = 1;
> +				cros_sensorhub_send_sample(sensorhub,
> +							   batch_start);
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
> +					 id, batch_len - 1);
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
> +				"Adjusting %d samples, sensor %d last_batch @%lld (%d samples) batch_timestamp=%lld => period=%lld\n",
> +				batch_len, id,
> +				sensorhub->last_batch_timestamp[id],
> +				sensorhub->last_batch_len[id],
> +				batch_timestamp,
> +				sample_period);
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
> @@ -208,7 +668,8 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
>   * out -->                 TS1      | 3
>   * We know have [TS1+1/3, TS1+2/3, current timestamp]
>   */
> -static void cros_ec_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
> +static void cros_ec_ring_spread_add_legacy(
> +				struct cros_ec_sensorhub *sensorhub,
>  				unsigned long sensor_mask,
>  				s64 current_timestamp,
>  				struct cros_ec_sensors_ring_sample *last_out)
> @@ -277,7 +738,7 @@ static void cros_ec_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
>  		cros_sensorhub_send_sample(sensorhub, out);
>  }
>  
> -/*
> +/**

Unrelated change in this patch.  Please break it out of here..

>   * cros_ec_sensorhub_ring_handler - the trigger handler function
>   *
>   * @sensorhub: device information.
> @@ -394,7 +855,8 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  	 * the AP is slow to respond to the IRQ, the EC may have added new
>  	 * samples. Use the FIFO info timestamp as last timestamp then.
>  	 */
> -	if ((last_out - 1)->timestamp == current_timestamp)
> +	if (!sensorhub->tight_timestamps &&
> +	    (last_out - 1)->timestamp == current_timestamp)
>  		current_timestamp = fifo_timestamp;
>  
>  	/* Warn on lost samples. */
> @@ -408,6 +870,7 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
>  				dev_warn_ratelimited(sensorhub->dev,
>  						     "Sensor %d: lost: %d out of %d\n",
>  						     i, lost, total_lost);
> +				sensorhub->last_batch_len[i] = 0;
>  			}
>  		}
>  	}
> @@ -415,8 +878,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
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
>  	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
> @@ -489,6 +955,9 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
>  	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
>  		cros_ec_get_time_ns();
>  
> +	sensorhub->tight_timestamps = cros_ec_check_features(ec,
> +				EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
> +
>  	/* register the notifier that will act as a top half interrupt. */
>  	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
>  	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
> diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
> index 8f9bf9a70701..e9da92fb0bea 100644
> --- a/include/linux/platform_data/cros_ec_sensorhub.h
> +++ b/include/linux/platform_data/cros_ec_sensorhub.h
> @@ -68,7 +68,44 @@ struct cros_ec_sensors_ring_sample {
>  	s64 timestamp;
>  } __packed;
>  
> +/* State used for cros_ec_ring_fix_overflow */
> +struct cros_ec_sensors_ec_overflow_state {
> +	s64 offset;
> +	s64 last;
> +};
> +
> +/* Length of the filter, how long to remember entries for */
> +#define CROS_EC_SENSORHUB_TS_HISTORY_SIZE 64
> +
>  /**
> + * struct cros_ec_sensors_ts_filter_state - Timestamp filetr state.
> + *
> + * @x_offset: x is EC interrupt time. x_offset its last value.
> + * @y_offset: y is the difference between AP and EC time, y_offset its last
> + *            value.
> + * @x_history: The past history of x, relative to x_offset.
> + * @y_history: The past history of y, relative to y_offset.
> + * @m_history: rate between y and x.
> + * @history_len: Amount of valid historic data in the arrays.
> + * @temp_buf: Temporary buffer used when updating the filter.
> + * @median_m: median value of m_history
> + * @median_error: final error to apply to AP interrupt timestamp to get the
> + *                "true timestamp" the event occurred.
> + */
> +struct cros_ec_sensors_ts_filter_state {
> +	s64 x_offset, y_offset;
> +	s64 x_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
> +	s64 y_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
> +	s64 m_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
> +	int history_len;
> +
> +	s64 temp_buf[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
> +
> +	s64 median_m;
> +	s64 median_error;
> +};
> +
> +/*
>   * struct cros_ec_sensorhub - Sensor Hub device data.
>   *
>   * @dev:          Device object, mostly used for logging.
> @@ -83,6 +120,28 @@ struct cros_ec_sensors_ring_sample {
>   * @timestamp: array for event timestamp and spreading.
>   * @fifo_info: copy of FIFO information coming from the EC.
>   * @fifo_size: size of the ring.
> + *
> + * @penultimate_batch_timestamp: array of last but one batch timestamps.
> + *  Used for timestamp spreading calculations when a batch shows up.
> + * @penultimate_batch_len: array of last but one batch length.
> + * @last_batch_timestamp: last batch timestamp array.
> + * @last_batch_len: last batch length array.
> + * @newest_sensor_event: last sensor timestamp.
> + * @overflow_a: for handling timestamp overflow for a time (sensor events)
> + * @overflow_b: for handling timestamp overflow for b time (ec interrutps)

interrupts

> + * @filter: medium fileter structure.
> + * @tight_timestamps: Set to truen when EC support tight timestamping:
> + *  The timestamps reported from the EC have low jitter.
> + *  Timestamps also come before every sample.
> + *  Set either by feature bits coming from the EC or userspace.
> + *
> + * @future_timestamp_count : Statistics used to compute shaved time.
> + *  This occures when timestamp interpolation from EC time to AP time
> + *  accidentally puts timestamps in the future. These timestamps are clamped
> + *  to `now` and these count/total_ns maintain the statistics for
> + *  how much time was removed in a given period.
> + * @future_timestamp_total_ns: Total amount of time shaved.
> + *
>   * @pushdata: array of callback to send datums to iio sensor object.
>   */
>  struct cros_ec_sensorhub {
> @@ -103,6 +162,22 @@ struct cros_ec_sensorhub {
>  	struct cros_ec_fifo_info fifo_info;
>  	int    fifo_size;
>  
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
> +	bool tight_timestamps;
> +
> +	s32 future_timestamp_count;
> +	s64 future_timestamp_total_ns;
> +
>  	struct cros_ec_sensorhub_sensor_push_data push_data[
>  		CROS_EC_SENSOR_PDEV_MAX];
>  };

