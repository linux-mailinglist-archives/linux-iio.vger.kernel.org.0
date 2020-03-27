Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C711196148
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgC0Wez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36408 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgC0Wez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id j29so5270627pgl.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wk4OfBa07c7+n2kqagylrVRvlqo/PybM2dCkSYcfBq8=;
        b=leV0G+USjQT0HXpSBHnGpktUt683dFZSgdHiUQ3Ifo8ll6eCQo5eLtYuc9vsNAFcEh
         6fjoc5oWx132bvMVTmqN97KgIctISSaJ3GU33h2ASHdaQXeIB22366kV5iD6Fk0UP+Hi
         Uss2Zz9kbkL07Wtt88X3Hf9Ssprr390OAE9AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wk4OfBa07c7+n2kqagylrVRvlqo/PybM2dCkSYcfBq8=;
        b=iVMAHwqBYCydH9X7rBMIQPYniUgMeEheV+RuubfhLAu1lBKXk52FC0FEqlBI7hzhrZ
         8wqydoxz03mEr+O4PcH57h+brJOukBdfPBZqJ5tFmLGtNFPOelQArRNXL4uszCpMg9uE
         9QyKdbBh7o80hMCtgqhngd9nT6Y+M7VMNlaZhNtnNpw4eS8IDBN2WeQH37Zug1ETqFZW
         P1+2LkgrAn3cQ12/B7dzJCbh2US99Uxd125ONHLyrwHTSBvxUflvN/Gzpewqxf5dytzZ
         LfHDskprKvZI0ihTa9klVT1NxWnqv3+ZerNAwY23H+K82qqxR1c1J56MCUnRXL0siHoW
         E5kg==
X-Gm-Message-State: ANhLgQ2P0l5Ai/TVbvAFtvCm15EUbVYqi09Bo6f8mWCYB6a5T6qCEyBV
        R0Qp7KpJFF8cpV218D4B1jfDN8UlKAI=
X-Google-Smtp-Source: ADFU+vtfd/txpCVgyueTCtEQ0kXua2eIYZpl0bAgVJYjufFenrKm1tKMg4NAVIlvvK1BhYIGJVmwFg==
X-Received: by 2002:a65:5b04:: with SMTP id y4mr1588759pgq.25.1585348491545;
        Fri, 27 Mar 2020 15:34:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id l15sm4691225pgk.59.2020.03.27.15.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:51 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 04/12] platform: chrome: sensorhub: Add median filter
Date:   Fri, 27 Mar 2020 15:34:35 -0700
Message-Id: <20200327223443.6006-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Events are timestamped in EC time space, their timestamps need to be
converted in host time space.
The assumption is the time delta between when the interrupt is sent
by the EC and when it is receive by the host is a [small] constant.
This is not always true, even with hard-wired interrupt. To mitigate
worst offenders, add a median filter to weed out bigger than expected
delays.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Use the number of sensors present to create the right number of
  per sensor batch information.
Changes in v6:
- No changes.
Changes in v5:
- Enforce kernel-doc function naming.
- Added ack.
- Fix spelling
- Add ratelimiting for an error message.
- Remove unrelated code changes (line, kernel-doc)
Changes in v4:
- Keep defining cros_ec_sensorhub in kernel-doc format
- Check patch with --strict option
    Use BIT()
    Add spaces around '-'
    Alignement
Changes in v3:
- Fix doxygen code.
Changes in v2:
- Move some #define in .c to prevent name collisions.
- Add proper doxygen comments.
- Use /* instead of //

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 560 +++++++++++++++++-
 .../linux/platform_data/cros_ec_sensorhub.h   |  93 ++-
 2 files changed, 622 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 443db8277d2b9..230e6cf3da2f7 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -17,6 +17,21 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 
+/* Precision of fixed point for the m values from the filter */
+#define M_PRECISION BIT(23)
+
+/* Only activate the filter once we have at least this many elements. */
+#define TS_HISTORY_THRESHOLD 8
+
+/*
+ * If we don't have any history entries for this long, empty the filter to
+ * make sure there are no big discontinuities.
+ */
+#define TS_HISTORY_BORED_US 500000
+
+/* To measure by how much the filter is overshooting, if it happens. */
+#define FUTURE_TS_ANALYTICS_COUNT_MAX 100
+
 static inline int
 cros_sensorhub_send_sample(struct cros_ec_sensorhub *sensorhub,
 			   struct cros_ec_sensors_ring_sample *sample)
@@ -92,9 +107,13 @@ EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
 int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
 				       bool on)
 {
-	int ret;
+	int ret, i;
 
 	mutex_lock(&sensorhub->cmd_lock);
+	if (sensorhub->tight_timestamps)
+		for (i = 0; i < sensorhub->sensor_num; i++)
+			sensorhub->batch_state[i].last_len = 0;
+
 	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INT_ENABLE;
 	sensorhub->params->fifo_int_enable.enable = on;
 
@@ -111,8 +130,245 @@ int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
 	return ret;
 }
 
+static int cros_ec_sensor_ring_median_cmp(const void *pv1, const void *pv2)
+{
+	s64 v1 = *(s64 *)pv1;
+	s64 v2 = *(s64 *)pv2;
+
+	if (v1 > v2)
+		return 1;
+	else if (v1 < v2)
+		return -1;
+	else
+		return 0;
+}
+
+/*
+ * cros_ec_sensor_ring_median: Gets median of an array of numbers
+ *
+ * For now it's implemented using an inefficient > O(n) sort then return
+ * the middle element. A more optimal method would be something like
+ * quickselect, but given that n = 64 we can probably live with it in the
+ * name of clarity.
+ *
+ * Warning: the input array gets modified (sorted)!
+ */
+static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
+{
+	sort(array, length, sizeof(s64), cros_ec_sensor_ring_median_cmp, NULL);
+	return array[length / 2];
+}
+
+/*
+ * IRQ Timestamp Filtering
+ *
+ * Lower down in cros_ec_sensor_ring_process_event(), for each sensor event
+ * we have to calculate it's timestamp in the AP timebase. There are 3 time
+ * points:
+ *   a - EC timebase, sensor event
+ *   b - EC timebase, IRQ
+ *   c - AP timebase, IRQ
+ *   a' - what we want: sensor even in AP timebase
+ *
+ * While a and b are recorded at accurate times (due to the EC real time
+ * nature); c is pretty untrustworthy, even though it's recorded the
+ * first thing in ec_irq_handler(). There is a very good change we'll get
+ * added lantency due to:
+ *   other irqs
+ *   ddrfreq
+ *   cpuidle
+ *
+ * Normally a' = c - b + a, but if we do that naive math any jitter in c
+ * will get coupled in a', which we don't want. We want a function
+ * a' = cros_ec_sensor_ring_ts_filter(a) which will filter out outliers in c.
+ *
+ * Think of a graph of AP time(b) on the y axis vs EC time(c) on the x axis.
+ * The slope of the line won't be exactly 1, there will be some clock drift
+ * between the 2 chips for various reasons (mechanical stress, temperature,
+ * voltage). We need to extrapolate values for a future x, without trusting
+ * recent y values too much.
+ *
+ * We use a median filter for the slope, then another median filter for the
+ * y-intercept to calculate this function:
+ *   dx[n] = x[n-1] - x[n]
+ *   dy[n] = x[n-1] - x[n]
+ *   m[n] = dy[n] / dx[n]
+ *   median_m = median(m[n-k:n])
+ *   error[i] = y[n-i] - median_m * x[n-i]
+ *   median_error = median(error[:k])
+ *   predicted_y = median_m * x + median_error
+ *
+ * Implementation differences from above:
+ * - Redefined y to be actually c - b, this gives us a lot more precision
+ * to do the math. (c-b)/b variations are more obvious than c/b variations.
+ * - Since we don't have floating point, any operations involving slope are
+ * done using fixed point math (*M_PRECISION)
+ * - Since x and y grow with time, we keep zeroing the graph (relative to
+ * the last sample), this way math involving *x[n-i] will not overflow
+ * - EC timestamps are kept in us, it improves the slope calculation precision
+ */
+
+/**
+ * cros_ec_sensor_ring_ts_filter_update() - Update filter history.
+ *
+ * @state: Filter information.
+ * @b: IRQ timestamp, EC timebase (us)
+ * @c: IRQ timestamp, AP timebase (ns)
+ *
+ * Given a new IRQ timestamp pair (EC and AP timebases), add it to the filter
+ * history.
+ */
+static void
+cros_ec_sensor_ring_ts_filter_update(struct cros_ec_sensors_ts_filter_state
+				     *state,
+				     s64 b, s64 c)
+{
+	s64 x, y;
+	s64 dx, dy;
+	s64 m; /* stored as *M_PRECISION */
+	s64 *m_history_copy = state->temp_buf;
+	s64 *error = state->temp_buf;
+	int i;
+
+	/* we trust b the most, that'll be our independent variable */
+	x = b;
+	/* y is the offset between AP and EC times, in ns */
+	y = c - b * 1000;
+
+	dx = (state->x_history[0] + state->x_offset) - x;
+	if (dx == 0)
+		return; /* we already have this irq in the history */
+	dy = (state->y_history[0] + state->y_offset) - y;
+	m = div64_s64(dy * M_PRECISION, dx);
+
+	/* Empty filter if we haven't seen any action in a while. */
+	if (-dx > TS_HISTORY_BORED_US)
+		state->history_len = 0;
+
+	/* Move everything over, also update offset to all absolute coords .*/
+	for (i = state->history_len - 1; i >= 1; i--) {
+		state->x_history[i] = state->x_history[i - 1] + dx;
+		state->y_history[i] = state->y_history[i - 1] + dy;
+
+		state->m_history[i] = state->m_history[i - 1];
+		/*
+		 * Also use the same loop to copy m_history for future
+		 * median extraction.
+		 */
+		m_history_copy[i] = state->m_history[i - 1];
+	}
+
+	/* Store the x and y, but remember offset is actually last sample. */
+	state->x_offset = x;
+	state->y_offset = y;
+	state->x_history[0] = 0;
+	state->y_history[0] = 0;
+
+	state->m_history[0] = m;
+	m_history_copy[0] = m;
+
+	if (state->history_len < CROS_EC_SENSORHUB_TS_HISTORY_SIZE)
+		state->history_len++;
+
+	/* Precalculate things for the filter. */
+	if (state->history_len > TS_HISTORY_THRESHOLD) {
+		state->median_m =
+		    cros_ec_sensor_ring_median(m_history_copy,
+					       state->history_len - 1);
+
+		/*
+		 * Calculate y-intercepts as if m_median is the slope and
+		 * points in the history are on the line. median_error will
+		 * still be in the offset coordinate system.
+		 */
+		for (i = 0; i < state->history_len; i++)
+			error[i] = state->y_history[i] -
+				div_s64(state->median_m * state->x_history[i],
+					M_PRECISION);
+		state->median_error =
+			cros_ec_sensor_ring_median(error, state->history_len);
+	} else {
+		state->median_m = 0;
+		state->median_error = 0;
+	}
+}
+
+/**
+ * cros_ec_sensor_ring_ts_filter() - Translate EC timebase timestamp to AP
+ *                                   timebase
+ *
+ * @state: filter information.
+ * @x: any ec timestamp (us):
+ *
+ * cros_ec_sensor_ring_ts_filter(a) => a' event timestamp, AP timebase
+ * cros_ec_sensor_ring_ts_filter(b) => calculated timestamp when the EC IRQ
+ *                           should have happened on the AP, with low jitter
+ *
+ * Note: The filter will only activate once state->history_len goes
+ * over TS_HISTORY_THRESHOLD. Otherwise it'll just do the naive c - b + a
+ * transform.
+ *
+ * How to derive the formula, starting from:
+ *   f(x) = median_m * x + median_error
+ * That's the calculated AP - EC offset (at the x point in time)
+ * Undo the coordinate system transform:
+ *   f(x) = median_m * (x - x_offset) + median_error + y_offset
+ * Remember to undo the "y = c - b * 1000" modification:
+ *   f(x) = median_m * (x - x_offset) + median_error + y_offset + x * 1000
+ *
+ * Return: timestamp in AP timebase (ns)
+ */
+static s64
+cros_ec_sensor_ring_ts_filter(struct cros_ec_sensors_ts_filter_state *state,
+			      s64 x)
+{
+	return div_s64(state->median_m * (x - state->x_offset), M_PRECISION)
+	       + state->median_error + state->y_offset + x * 1000;
+}
+
+/*
+ * Since a and b were originally 32 bit values from the EC,
+ * they overflow relatively often, casting is not enough, so we need to
+ * add an offset.
+ */
+static void
+cros_ec_sensor_ring_fix_overflow(s64 *ts,
+				 const s64 overflow_period,
+				 struct cros_ec_sensors_ec_overflow_state
+				 *state)
+{
+	s64 adjust;
+
+	*ts += state->offset;
+	if (abs(state->last - *ts) > (overflow_period / 2)) {
+		adjust = state->last > *ts ? overflow_period : -overflow_period;
+		state->offset += adjust;
+		*ts += adjust;
+	}
+	state->last = *ts;
+}
+
+static void
+cros_ec_sensor_ring_check_for_past_timestamp(struct cros_ec_sensorhub
+					     *sensorhub,
+					     struct cros_ec_sensors_ring_sample
+					     *sample)
+{
+	const u8 sensor_id = sample->sensor_id;
+
+	/* If this event is earlier than one we saw before... */
+	if (sensorhub->batch_state[sensor_id].newest_sensor_event >
+	    sample->timestamp)
+		/* mark it for spreading. */
+		sample->timestamp =
+			sensorhub->batch_state[sensor_id].last_ts;
+	else
+		sensorhub->batch_state[sensor_id].newest_sensor_event =
+			sample->timestamp;
+}
+
 /**
- * cros_ec_sensor_ring_process_event() - process one EC FIFO event
+ * cros_ec_sensor_ring_process_event() - Process one EC FIFO event
  *
  * @sensorhub: Sensor Hub object.
  * @fifo_info: FIFO information from the EC (includes b point, EC timebase).
@@ -142,28 +398,57 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 		(MOTIONSENSE_SENSOR_FLAG_ODR | MOTIONSENSE_SENSOR_FLAG_FLUSH);
 
 	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP && !async_flags) {
-		s64 new_timestamp;
+		s64 a = in->timestamp;
+		s64 b = fifo_info->timestamp;
+		s64 c = fifo_timestamp;
+
+		cros_ec_sensor_ring_fix_overflow(&a, 1LL << 32,
+					  &sensorhub->overflow_a);
+		cros_ec_sensor_ring_fix_overflow(&b, 1LL << 32,
+					  &sensorhub->overflow_b);
+
+		if (sensorhub->tight_timestamps) {
+			cros_ec_sensor_ring_ts_filter_update(
+					&sensorhub->filter, b, c);
+			*current_timestamp = cros_ec_sensor_ring_ts_filter(
+					&sensorhub->filter, a);
+		} else {
+			s64 new_timestamp;
 
-		/*
-		 * Disable filtering since we might add more jitter
-		 * if b is in a random point in time.
-		 */
-		new_timestamp = fifo_timestamp -
-				fifo_info->timestamp  * 1000 +
-				in->timestamp * 1000;
+			/*
+			 * Disable filtering since we might add more jitter
+			 * if b is in a random point in time.
+			 */
+			new_timestamp = fifo_timestamp -
+					fifo_info->timestamp  * 1000 +
+					in->timestamp * 1000;
+			/*
+			 * The timestamp can be stale if we had to use the fifo
+			 * info timestamp.
+			 */
+			if (new_timestamp - *current_timestamp > 0)
+				*current_timestamp = new_timestamp;
+		}
+	}
 
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_ODR) {
+		if (sensorhub->tight_timestamps) {
+			sensorhub->batch_state[in->sensor_num].last_len = 0;
+			sensorhub->batch_state[in->sensor_num].penul_len = 0;
+		}
 		/*
-		 * The timestamp can be stale if we had to use the fifo
-		 * info timestamp.
+		 * ODR change is only useful for the sensor_ring, it does not
+		 * convey information to clients.
 		 */
-		if (new_timestamp - *current_timestamp > 0)
-			*current_timestamp = new_timestamp;
+		return false;
 	}
 
 	if (in->flags & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
 		out->sensor_id = in->sensor_num;
 		out->timestamp = *current_timestamp;
 		out->flag = in->flags;
+		if (sensorhub->tight_timestamps)
+			sensorhub->batch_state[out->sensor_id].last_len = 0;
 		/*
 		 * No other payload information provided with
 		 * flush ack.
@@ -177,22 +462,221 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 
 	/* Regular sample */
 	out->sensor_id = in->sensor_num;
-	if (*current_timestamp - now > 0)
-		/* If the timestamp is in the future. */
+	if (*current_timestamp - now > 0) {
+		/*
+		 * This fix is needed to overcome the timestamp filter putting
+		 * events in the future.
+		 */
+		sensorhub->future_timestamp_total_ns +=
+			*current_timestamp - now;
+		if (++sensorhub->future_timestamp_count ==
+				FUTURE_TS_ANALYTICS_COUNT_MAX) {
+			s64 avg = div_s64(sensorhub->future_timestamp_total_ns,
+					sensorhub->future_timestamp_count);
+			dev_warn_ratelimited(sensorhub->dev,
+					     "100 timestamps in the future, %lldns shaved on average\n",
+					     avg);
+			sensorhub->future_timestamp_count = 0;
+			sensorhub->future_timestamp_total_ns = 0;
+		}
 		out->timestamp = now;
-	else
+	} else {
 		out->timestamp = *current_timestamp;
+	}
 
 	out->flag = in->flags;
 	for (axis = 0; axis < 3; axis++)
 		out->vector[axis] = in->data[axis];
 
+	if (sensorhub->tight_timestamps)
+		cros_ec_sensor_ring_check_for_past_timestamp(sensorhub, out);
 	return true;
 }
 
 /*
  * cros_ec_sensor_ring_spread_add: Calculate proper timestamps then add to
- * ringbuffer.
+ *                                 ringbuffer.
+ *
+ * This is the new spreading code, assumes every sample's timestamp
+ * preceeds the sample. Run if tight_timestamps == true.
+ *
+ * Sometimes the EC receives only one interrupt (hence timestamp) for
+ * a batch of samples. Only the first sample will have the correct
+ * timestamp. So we must interpolate the other samples.
+ * We use the previous batch timestamp and our current batch timestamp
+ * as a way to calculate period, then spread the samples evenly.
+ *
+ * s0 int, 0ms
+ * s1 int, 10ms
+ * s2 int, 20ms
+ * 30ms point goes by, no interrupt, previous one is still asserted
+ * downloading s2 and s3
+ * s3 sample, 20ms (incorrect timestamp)
+ * s4 int, 40ms
+ *
+ * The batches are [(s0), (s1), (s2, s3), (s4)]. Since the 3rd batch
+ * has 2 samples in them, we adjust the timestamp of s3.
+ * s2 - s1 = 10ms, so s3 must be s2 + 10ms => 20ms. If s1 would have
+ * been part of a bigger batch things would have gotten a little
+ * more complicated.
+ *
+ * Note: we also assume another sensor sample doesn't break up a batch
+ * in 2 or more partitions. Example, there can't ever be a sync sensor
+ * in between S2 and S3. This simplifies the following code.
+ */
+static void
+cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
+			       unsigned long sensor_mask,
+			       struct cros_ec_sensors_ring_sample *last_out)
+{
+	struct cros_ec_sensors_ring_sample *batch_start, *next_batch_start;
+	int id;
+
+	for_each_set_bit(id, &sensor_mask, sensorhub->sensor_num) {
+		for (batch_start = sensorhub->ring; batch_start < last_out;
+		     batch_start = next_batch_start) {
+			/*
+			 * For each batch (where all samples have the same
+			 * timestamp).
+			 */
+			int batch_len, sample_idx;
+			struct cros_ec_sensors_ring_sample *batch_end =
+				batch_start;
+			struct cros_ec_sensors_ring_sample *s;
+			s64 batch_timestamp = batch_start->timestamp;
+			s64 sample_period;
+
+			/*
+			 * Skip over batches that start with the sensor types
+			 * we're not looking at right now.
+			 */
+			if (batch_start->sensor_id != id) {
+				next_batch_start = batch_start + 1;
+				continue;
+			}
+
+			/*
+			 * Do not start a batch
+			 * from a flush, as it happens asynchronously to the
+			 * regular flow of events.
+			 */
+			if (batch_start->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
+				cros_sensorhub_send_sample(sensorhub,
+							   batch_start);
+				next_batch_start = batch_start + 1;
+				continue;
+			}
+
+			if (batch_start->timestamp <=
+			    sensorhub->batch_state[id].last_ts) {
+				batch_timestamp =
+					sensorhub->batch_state[id].last_ts;
+				batch_len = sensorhub->batch_state[id].last_len;
+
+				sample_idx = batch_len;
+
+				sensorhub->batch_state[id].last_ts =
+				  sensorhub->batch_state[id].penul_ts;
+				sensorhub->batch_state[id].last_len =
+				  sensorhub->batch_state[id].penul_len;
+			} else {
+				/*
+				 * Push first sample in the batch to the,
+				 * kifo, it's guaranteed to be correct, the
+				 * rest will follow later on.
+				 */
+				sample_idx = 1;
+				batch_len = 1;
+				cros_sensorhub_send_sample(sensorhub,
+							   batch_start);
+				batch_start++;
+			}
+
+			/* Find all samples have the same timestamp. */
+			for (s = batch_start; s < last_out; s++) {
+				if (s->sensor_id != id)
+					/*
+					 * Skip over other sensor types that
+					 * are interleaved, don't count them.
+					 */
+					continue;
+				if (s->timestamp != batch_timestamp)
+					/* we discovered the next batch */
+					break;
+				if (s->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH)
+					/* break on flush packets */
+					break;
+				batch_end = s;
+				batch_len++;
+			}
+
+			if (batch_len == 1)
+				goto done_with_this_batch;
+
+			/* Can we calculate period? */
+			if (sensorhub->batch_state[id].last_len == 0) {
+				dev_warn(sensorhub->dev, "Sensor %d: lost %d samples when spreading\n",
+					 id, batch_len - 1);
+				goto done_with_this_batch;
+				/*
+				 * Note: we're dropping the rest of the samples
+				 * in this batch since we have no idea where
+				 * they're supposed to go without a period
+				 * calculation.
+				 */
+			}
+
+			sample_period = div_s64(batch_timestamp -
+				sensorhub->batch_state[id].last_ts,
+				sensorhub->batch_state[id].last_len);
+			dev_dbg(sensorhub->dev,
+				"Adjusting %d samples, sensor %d last_batch @%lld (%d samples) batch_timestamp=%lld => period=%lld\n",
+				batch_len, id,
+				sensorhub->batch_state[id].last_ts,
+				sensorhub->batch_state[id].last_len,
+				batch_timestamp,
+				sample_period);
+
+			/*
+			 * Adjust timestamps of the samples then push them to
+			 * kfifo.
+			 */
+			for (s = batch_start; s <= batch_end; s++) {
+				if (s->sensor_id != id)
+					/*
+					 * Skip over other sensor types that
+					 * are interleaved, don't change them.
+					 */
+					continue;
+
+				s->timestamp = batch_timestamp +
+					sample_period * sample_idx;
+				sample_idx++;
+
+				cros_sensorhub_send_sample(sensorhub, s);
+			}
+
+done_with_this_batch:
+			sensorhub->batch_state[id].penul_ts =
+				sensorhub->batch_state[id].last_ts;
+			sensorhub->batch_state[id].penul_len =
+				sensorhub->batch_state[id].last_len;
+
+			sensorhub->batch_state[id].last_ts =
+				batch_timestamp;
+			sensorhub->batch_state[id].last_len = batch_len;
+
+			next_batch_start = batch_end + 1;
+		}
+	}
+}
+
+/*
+ * cros_ec_sensor_ring_spread_add_legacy: Calculate proper timestamps then
+ * add to ringbuffer (legacy).
+ *
+ * Note: This assumes we're running old firmware, where every sample's timestamp
+ * is after the sample. Run if tight_timestamps == false.
  *
  * If there is a sample with a proper timestamp
  *
@@ -215,11 +699,12 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
  *
  * We know have [TS1+1/3, TS1+2/3, current timestamp]
  */
-static void cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
-					   unsigned long sensor_mask,
-					   s64 current_timestamp,
-					   struct cros_ec_sensors_ring_sample
-					   *last_out)
+static void
+cros_ec_sensor_ring_spread_add_legacy(struct cros_ec_sensorhub *sensorhub,
+				      unsigned long sensor_mask,
+				      s64 current_timestamp,
+				      struct cros_ec_sensors_ring_sample
+				      *last_out)
 {
 	struct cros_ec_sensors_ring_sample *out;
 	int i;
@@ -404,25 +889,34 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 	 * is slow to respond to the IRQ, the EC may have added new samples.
 	 * Use the FIFO info timestamp as last timestamp then.
 	 */
-	if ((last_out - 1)->timestamp == current_timestamp)
+	if (!sensorhub->tight_timestamps &&
+	    (last_out - 1)->timestamp == current_timestamp)
 		current_timestamp = fifo_timestamp;
 
 	/* Warn on lost samples. */
 	if (fifo_info->total_lost)
 		for (i = 0; i < sensorhub->sensor_num; i++) {
-			if (fifo_info->lost[i])
+			if (fifo_info->lost[i]) {
 				dev_warn_ratelimited(sensorhub->dev,
 						     "Sensor %d: lost: %d out of %d\n",
 						     i, fifo_info->lost[i],
 						     fifo_info->total_lost);
+				if (sensorhub->tight_timestamps)
+					sensorhub->batch_state[i].last_len = 0;
+			}
 		}
 
 	/*
 	 * Spread samples in case of batching, then add them to the
 	 * ringbuffer.
 	 */
-	cros_ec_sensor_ring_spread_add(sensorhub, sensor_mask,
-				       current_timestamp, last_out);
+	if (sensorhub->tight_timestamps)
+		cros_ec_sensor_ring_spread_add(sensorhub, sensor_mask,
+					       last_out);
+	else
+		cros_ec_sensor_ring_spread_add_legacy(sensorhub, sensor_mask,
+						      current_timestamp,
+						      last_out);
 
 ring_handler_end:
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
@@ -517,6 +1011,18 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
 		cros_ec_get_time_ns();
 
+	sensorhub->tight_timestamps = cros_ec_check_features(
+			ec, EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
+
+	if (sensorhub->tight_timestamps) {
+		sensorhub->batch_state = devm_kcalloc(sensorhub->dev,
+				sensorhub->sensor_num,
+				sizeof(*sensorhub->batch_state),
+				GFP_KERNEL);
+		if (!sensorhub->batch_state)
+			return -ENOMEM;
+	}
+
 	/* Register the notifier that will act as a top half interrupt. */
 	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
 	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index b0950814f820e..c588be843f61b 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -54,7 +54,64 @@ struct cros_ec_sensors_ring_sample {
 	s64 timestamp;
 } __packed;
 
+/* State used for cros_ec_ring_fix_overflow */
+struct cros_ec_sensors_ec_overflow_state {
+	s64 offset;
+	s64 last;
+};
+
+/* Length of the filter, how long to remember entries for */
+#define CROS_EC_SENSORHUB_TS_HISTORY_SIZE 64
+
 /**
+ * struct cros_ec_sensors_ts_filter_state - Timestamp filetr state.
+ *
+ * @x_offset: x is EC interrupt time. x_offset its last value.
+ * @y_offset: y is the difference between AP and EC time, y_offset its last
+ *            value.
+ * @x_history: The past history of x, relative to x_offset.
+ * @y_history: The past history of y, relative to y_offset.
+ * @m_history: rate between y and x.
+ * @history_len: Amount of valid historic data in the arrays.
+ * @temp_buf: Temporary buffer used when updating the filter.
+ * @median_m: median value of m_history
+ * @median_error: final error to apply to AP interrupt timestamp to get the
+ *                "true timestamp" the event occurred.
+ */
+struct cros_ec_sensors_ts_filter_state {
+	s64 x_offset, y_offset;
+	s64 x_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
+	s64 y_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
+	s64 m_history[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
+	int history_len;
+
+	s64 temp_buf[CROS_EC_SENSORHUB_TS_HISTORY_SIZE];
+
+	s64 median_m;
+	s64 median_error;
+};
+
+/* struct cros_ec_sensors_ts_batch_state - State of batch of a single sensor.
+ *
+ * Use to store information to batch data using median fileter information.
+ *
+ * @penul_ts: last but one batch timestamp (penultimate timestamp).
+ *	      Used for timestamp spreading calculations
+ *	      when a batch shows up.
+ * @penul_len: last but one batch length.
+ * @last_ts: Last batch timestam.
+ * @last_len: Last batch length.
+ * @newest_sensor_event: Last sensor timestamp.
+ */
+struct cros_ec_sensors_ts_batch_state {
+	s64 penul_ts;
+	int penul_len;
+	s64 last_ts;
+	int last_len;
+	s64 newest_sensor_event;
+};
+
+/*
  * struct cros_ec_sensorhub - Sensor Hub device data.
  *
  * @dev: Device object, mostly used for logging.
@@ -66,10 +123,26 @@ struct cros_ec_sensors_ring_sample {
  * @cmd_lock : Lock for sending msg.
  * @notifier: Notifier to kick the FIFO interrupt.
  * @ring: Preprocessed ring to store events.
- * @fifo_timestamp: array for event timestamp and spreading.
- * @fifo_info: copy of FIFO information coming from the EC.
- * @fifo_size: size of the ring.
- * @push_data: array of callback to send datums to iio sensor object.
+ * @fifo_timestamp: Array for event timestamp and spreading.
+ * @fifo_info: Copy of FIFO information coming from the EC.
+ * @fifo_size: Size of the ring.
+ * @batch_state: Per sensor information of the last batches received.
+ * @overflow_a: For handling timestamp overflow for a time (sensor events)
+ * @overflow_b: For handling timestamp overflow for b time (ec interrupts)
+ * @filter: Medium fileter structure.
+ * @tight_timestamps: Set to truen when EC support tight timestamping:
+ *		      The timestamps reported from the EC have low jitter.
+ *		      Timestamps also come before every sample. Set either
+ *		      by feature bits coming from the EC or userspace.
+ * @future_timestamp_count: Statistics used to compute shaved time.
+ *			    This occurs when timestamp interpolation from EC
+ *			    time to AP time accidentally puts timestamps in
+ *			    the future. These timestamps are clamped to
+ *			    `now` and these count/total_ns maintain the
+ *			    statistics for how much time was removed in a
+ *			    given period.
+ * @future_timestamp_total_ns: Total amount of time shaved.
+ * @push_data: Array of callback to send datums to iio sensor object.
  */
 struct cros_ec_sensorhub {
 	struct device *dev;
@@ -89,6 +162,18 @@ struct cros_ec_sensorhub {
 	struct ec_response_motion_sense_fifo_info *fifo_info;
 	int fifo_size;
 
+	struct cros_ec_sensors_ts_batch_state *batch_state;
+
+	struct cros_ec_sensors_ec_overflow_state overflow_a;
+	struct cros_ec_sensors_ec_overflow_state overflow_b;
+
+	struct cros_ec_sensors_ts_filter_state filter;
+
+	int tight_timestamps;
+
+	s32 future_timestamp_count;
+	s64 future_timestamp_total_ns;
+
 	struct cros_ec_sensorhub_sensor_push_data *push_data;
 };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

