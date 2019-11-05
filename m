Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92AF0956
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfKEW1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46633 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbfKEW1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so15793671pfc.13
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOzjkgFm5cyWhORMjZFi/AfA7X27VOFSxt8OtkilbpY=;
        b=jUKvXZG3eG52bsGnsHYr3l1oMo8s5cppDvTz+/4v1We7swxg0I49LZ+RWsOcFswuXs
         grk72JwI2CyfORJXEYWcWmacRrS53y14u/bQ3k/X3DKanUW9gwNWvvn3raTzt+skJ9gZ
         sHLU9Jx4H3R4wSPzLC85B09n9AopWWW98GSJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOzjkgFm5cyWhORMjZFi/AfA7X27VOFSxt8OtkilbpY=;
        b=dUFu8+i4w8j1pu9oH4QJJR7l8EWKz8k8k0Rw9d7rTZE30Xow2DyAeUnzolOad6fd9/
         rVIuoc+uBVMsbFgqBkHD+/sHECR8AsrSrT6dm1semnKp3GSP0gl+nNNiiv7mvGicbh2P
         rh1CXbKcT68DsF3g91JbSuCG6yb2mtsvMdh1XmLnXKsMp25IhfLrmUSz+tiVbpdHh/cs
         jZ5K1S692z5WiYBGUb3NooM8MnlaaxpNynicewrcAXD/7d0/u1umyfwXEkndnYEPFdRe
         INfzy9BR2PTOMTd537mjvpgh/iHc5/CKRbJAXzSvZPhc7YgVpYVBbEa/YL5WvCkw+7Ff
         hCEA==
X-Gm-Message-State: APjAAAWAfnHevoP39xaUhUZFhKY2NfRii6RGH+fSct1L33vLC/fnDBrg
        FaHMPkF5Nb0LH4TooJq/EwGHBA==
X-Google-Smtp-Source: APXvYqzhWvjNd62/LYnFeC3qBSR238VT3nmKVqg10ldbLUwrQhxu/tgFm7q0CMZ+EJ8PRTO4c6sYAg==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr1839225pja.134.1572992834518;
        Tue, 05 Nov 2019 14:27:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id j14sm427731pje.17.2019.11.05.14.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:13 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 10/17] platform: chrome: sensorhub: Add code to spread timestmap
Date:   Tue,  5 Nov 2019 14:26:45 -0800
Message-Id: <20191105222652.70226-11-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
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

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
- Check patch with --strict option
    Alignement
No changes in v3.
Changes in v2:
- Use CROS_EC_SENSOR_LAST_TS instead of LAST_TS to avoid name colisions.

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 98 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index f091f2a4ccfe..b22a71406742 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -187,6 +187,96 @@ static bool cros_ec_ring_process_event(struct cros_ec_sensorhub *sensorhub,
 	return true;
 }
 
+/*
+ * cros_ec_ring_spread_add: Calculate proper timestamps then
+ * add to ringbuffer (legacy).
+ *
+ * If there is a sample with a proper timestamp
+ *                        timestamp | count
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ * out -->                 TS1      | 3
+ * next_out -->            TS2      |
+ * We spread time for the samples [older_unprocess_out .. out]
+ * between TS1 and TS2: [TS1+1/4, TS1+2/4, TS1+3/4, TS2].
+ *
+ * If we reach the end of the samples, we compare with the
+ * current timestamp:
+ *
+ * older_unprocess_out --> TS1      | 1
+ *                         TS1      | 2
+ * out -->                 TS1      | 3
+ * We know have [TS1+1/3, TS1+2/3, current timestamp]
+ */
+static void cros_ec_ring_spread_add(struct cros_ec_sensorhub *sensorhub,
+				unsigned long sensor_mask,
+				s64 current_timestamp,
+				struct cros_ec_sensors_ring_sample *last_out)
+{
+	struct cros_ec_sensors_ring_sample *out;
+	int i;
+
+	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
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
+			/* find next sample */
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
+			 * The next sample has a new timestamp,
+			 * spread the unprocessed samples.
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
+	/* push the event into the kfifo */
+	for (out = sensorhub->ring; out < last_out; out++)
+		cros_sensorhub_send_sample(sensorhub, out);
+}
+
 /*
  * cros_ec_sensorhub_ring_handler - the trigger handler function
  *
@@ -322,9 +412,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
 		}
 	}
 
-	/* push the event into the kfifo */
-	for (out = sensorhub->ring; out < last_out; out++)
-		cros_sensorhub_send_sample(sensorhub, out);
+	/*
+	 * Spread samples in case of batching, then add them to the ringbuffer.
+	 */
+	cros_ec_ring_spread_add(sensorhub, sensor_mask,
+			current_timestamp, last_out);
 
 ring_handler_end:
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

