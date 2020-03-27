Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775DB19614A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgC0Wex (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgC0Wex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so3971944plt.9
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZWNb5GlJfDdryg5FVYupFGnBEQXMvS7b8srUpW/cH0=;
        b=Z/zE9kxefmzBHpVWdMRn6fk99MESTxdaeqK5ZKGZUgSJa3hSjBABe4UGGTs5UCoXG1
         xvedobvTIOCm7RwSlQeCBV6Pju20j1Yq7vLq8K8bJGXZwtmDOSfb/xLhk5CyWgndF91h
         42bpxGRPua5S5YVwgi7fAloCjvDBD1/RDCoIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZWNb5GlJfDdryg5FVYupFGnBEQXMvS7b8srUpW/cH0=;
        b=IErFArDg97m14uAfMk47O7JV+3L3ciVnb9AQfbsDk+2SikqPLwIwzPzBBk618Cv7hs
         jg7a1fWgRtVj4fAO0y+yprejMBXBeryvkcoJjDbtBQ+k5KcOmQPPn0BuRlKop3gt21mk
         b1bjgNwL93z5WCAHIpqiCxzPvouc1mTY5l4mQ3CvoKkoeBxQg8SMbR5h/k/5Q/Qp9+Oh
         ixm6ekTTJbxDcg/xit+HVXxcwRpw/yQusYgWusFjC94OIlkvjvdr/w25+xY4u1OiXu9t
         uNPiapdiwnFJeXrJrtHvAAt48mtO8q5kp9zU96yB6Yavsm4BOKvDdXuG5IHvamMz7nIG
         qkXg==
X-Gm-Message-State: ANhLgQ2zIUzvvkD4dYD3u9y+2tWztjFPhsbzJAySA9C/nMASWkNyHCR2
        mDd7j0KdOi+jsH9q0sUyv2J0NQ==
X-Google-Smtp-Source: ADFU+vsSFkBbkIqKca7DzYJmtsFC9bD4VoNS8McQ3vuQ+vdvVxyVup4IY6f8myIxhBfAj1XBZCg9Sw==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr1855081pjs.12.1585348490200;
        Fri, 27 Mar 2020 15:34:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id x15sm4827343pfq.107.2020.03.27.15.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:49 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 03/12] platform: chrome: sensorhub: Add code to spread timestmap
Date:   Fri, 27 Mar 2020 15:34:34 -0700
Message-Id: <20200327223443.6006-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

EC FIFO can send sensor events in batch. Spread them based on
previous (TSa) and currnet timestamp (TSb)

  EC FIFO                             iio events
+-----------+
| TSa       |
+-----------+             +---------------------------------------+
| event 1   |             | event 1 | TSb - (TSb - TSa)/n * (n-1) |
+-----------+             +---------------------------------------+
| event 2   |             | event 2 | TSb - (TSb - TSa)/n * (n-2) |
+-----------+             +---------------------------------------+
|  ...      |  ------>    |  ....   |                             |
+-----------+             +---------------------------------------+
| event n-1 |             | event 2 | TSb - (TSb - TSa)/n         |
+-----------+             +---------------------------------------+
| event n   |             | event 2 | TSb                         |
+-----------+             +---------------------------------------+
| TSb       |
+-----------+

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Use the number of sensors present to limit the scan of sensr mask.
  fifo_info is now a separate structure.
Changes in v6:
  Comment fixes
Changes in v5:
  Added ack.
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Use CROS_EC_SENSOR_LAST_TS instead of LAST_TS to avoid name colisions.

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 117 ++++++++++++++++--
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index da73757529ca5..443db8277d2b9 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -190,6 +190,101 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 	return true;
 }
 
+/*
+ * cros_ec_sensor_ring_spread_add: Calculate proper timestamps then add to
+ * ringbuffer.
+ *
+ * If there is a sample with a proper timestamp
+ *
+ *                        timestamp | count
+ *                        -----------------
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ *                out -->  TS1      | 3
+ *           next_out -->  TS2      |
+ *
+ * We spread time for the samples [older_unprocess_out .. out]
+ * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
+ *
+ * If we reach the end of the samples, we compare with the
+ * current timestamp:
+ *
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ *                 out --> TS1      | 3
+ *
+ * We know have [TS1+1/3, TS1+2/3, current timestamp]
+ */
+static void cros_ec_sensor_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
+					   unsigned long sensor_mask,
+					   s64 current_timestamp,
+					   struct cros_ec_sensors_ring_sample
+					   *last_out)
+{
+	struct cros_ec_sensors_ring_sample *out;
+	int i;
+
+	for_each_set_bit(i, &sensor_mask, sensorhub->sensor_num) {
+		s64 older_timestamp;
+		s64 timestamp;
+		struct cros_ec_sensors_ring_sample *older_unprocess_out =
+			sensorhub->ring;
+		struct cros_ec_sensors_ring_sample *next_out;
+		int count = 1;
+
+		for (out = sensorhub->ring; out < last_out; out = next_out) {
+			s64 time_period;
+
+			next_out = out + 1;
+			if (out->sensor_id != i)
+				continue;
+
+			/* Timestamp to start with */
+			older_timestamp = out->timestamp;
+
+			/* Find next sample. */
+			while (next_out < last_out && next_out->sensor_id != i)
+				next_out++;
+
+			if (next_out >= last_out) {
+				timestamp = current_timestamp;
+			} else {
+				timestamp = next_out->timestamp;
+				if (timestamp == older_timestamp) {
+					count++;
+					continue;
+				}
+			}
+
+			/*
+			 * The next sample has a new timestamp, spread the
+			 * unprocessed samples.
+			 */
+			if (next_out < last_out)
+				count++;
+			time_period = div_s64(timestamp - older_timestamp,
+					      count);
+
+			for (; older_unprocess_out <= out;
+					older_unprocess_out++) {
+				if (older_unprocess_out->sensor_id != i)
+					continue;
+				older_timestamp += time_period;
+				older_unprocess_out->timestamp =
+					older_timestamp;
+			}
+			count = 1;
+			/* The next_out sample has a valid timestamp, skip. */
+			next_out++;
+			older_unprocess_out = next_out;
+		}
+	}
+
+	/* Push the event into the kfifo */
+	for (out = sensorhub->ring; out < last_out; out++)
+		cros_sensorhub_send_sample(sensorhub, out);
+}
+
 /**
  * cros_ec_sensorhub_ring_handler() - The trigger handler function
  *
@@ -204,6 +299,7 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 	struct cros_ec_dev *ec = sensorhub->ec;
 	ktime_t fifo_timestamp, current_timestamp;
 	int i, j, number_data, ret;
+	unsigned long sensor_mask = 0;
 	struct ec_response_motion_sensor_data *in;
 	struct cros_ec_sensors_ring_sample *out, *last_out;
 
@@ -289,8 +385,10 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 						sensorhub, fifo_info,
 						fifo_timestamp,
 						&current_timestamp,
-						in, out))
+						in, out)) {
+				sensor_mask |= BIT(in->sensor_num);
 				out++;
+			}
 		}
 	}
 	mutex_unlock(&sensorhub->cmd_lock);
@@ -301,10 +399,10 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 		goto ring_handler_end;
 
 	/*
-	 * Check if current_timestamp is ahead of the last sample.
-	 * Normally, the EC appends a timestamp after the last sample, but if
-	 * the AP is slow to respond to the IRQ, the EC may have added new
-	 * samples. Use the FIFO info timestamp as last timestamp then.
+	 * Check if current_timestamp is ahead of the last sample. Normally,
+	 * the EC appends a timestamp after the last sample, but if the AP
+	 * is slow to respond to the IRQ, the EC may have added new samples.
+	 * Use the FIFO info timestamp as last timestamp then.
 	 */
 	if ((last_out - 1)->timestamp == current_timestamp)
 		current_timestamp = fifo_timestamp;
@@ -319,9 +417,12 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 						     fifo_info->total_lost);
 		}
 
-	/* Push the event into the FIFO. */
-	for (out = sensorhub->ring; out < last_out; out++)
-		cros_sensorhub_send_sample(sensorhub, out);
+	/*
+	 * Spread samples in case of batching, then add them to the
+	 * ringbuffer.
+	 */
+	cros_ec_sensor_ring_spread_add(sensorhub, sensor_mask,
+				       current_timestamp, last_out);
 
 ring_handler_end:
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
-- 
2.26.0.rc2.310.g2932bb562d-goog

