Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93EDE427
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfJUFzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 01:55:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37897 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfJUFya (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 01:54:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so7692732pfe.5
        for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2019 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP/9iLKiNwr5MLu9Z4HlI82XvD91cPcV9WXTeaSAUo0=;
        b=J69/Hg+EhtvPLU/f+pvHj6fxwllFXnCc+zZvtzYbfI6ppakwiG8QF67WpbtFPja6UG
         rL3O2cUZ+WFyV5WC6VXQAKiMD5S1pk0jMv0pxkexhaUI9QDVAYnc6echyFUMfmqXt7VH
         pjW9POED9x3YOm3oNduW1Nz4ShyLgnmJ0sofM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP/9iLKiNwr5MLu9Z4HlI82XvD91cPcV9WXTeaSAUo0=;
        b=mmolUgZZu5VYQh4jaX+Gb93zM6AjJPRPUilZTxKEPUUrCvNIfqt90O8RbSzm/Uer1U
         MqdFmWX5phz3GW/cGJcSPuAuslxau5l5kS0mdokkwwnvK9i3LYeiG1g1ipYQwuwcUb9w
         HmEI2kOS9twUAS0eEjT1aQ2z53ZGKOVFyhvvLIrD0ftkW6rfeizl1WoljOHzIgLJeFug
         AEGxW4+Ui3ae1s3pOrD2759gr9EsH49WG0or2wsPKkCmxD7veCDWY8Mnpa2nifp3dF2y
         /UhPM7DDlcDw7Mca9MlLgGHGJW8eLYloBlsezdSwDupuFiXBOsYO2c+wq4ElszQbFrfa
         dkYw==
X-Gm-Message-State: APjAAAWKrbWgen2Yt5VUfkyUwFkTjUGE6F48CuYbsSU1NfHX3+eTcE99
        p/MzFf41t1RcwKK7kcFLsGkJeQ==
X-Google-Smtp-Source: APXvYqxMhdpnivWEC0h+sdQZgH8IaEfCAZ9mMzPo0Zls/MJNxJiyPV01qSiHd9JomCl5XEoFck5+hw==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr25800971pjr.40.1571637269213;
        Sun, 20 Oct 2019 22:54:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id c7sm13029553pfr.75.2019.10.20.22.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:28 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 11/18] platform: chrome: sensorhub: Add code to spread timestmap
Date:   Sun, 20 Oct 2019 22:53:56 -0700
Message-Id: <20191021055403.67849-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
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
Changes in v2:
- Use CROS_EC_SENSOR_LAST_TS instead of LAST_TS to avoid name colisions.

 .../platform/chrome/cros_ec_sensorhub_ring.c  | 99 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index caf4b02d5e345..0b851ac7c067e 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -183,6 +183,97 @@ static bool cros_ec_ring_process_event(
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
+static void cros_ec_ring_spread_add(
+				struct cros_ec_sensorhub *sensorhub,
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
@@ -316,9 +407,11 @@ static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
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
2.23.0.866.gb869b98d4c-goog

