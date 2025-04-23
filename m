Return-Path: <linux-iio+bounces-18587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69290A99B32
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 00:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D2A5A6769
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F81E570D;
	Wed, 23 Apr 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHMATMyC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9338382
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445914; cv=none; b=dFfpnL09XKGXcH5A0/K5alNxWokaccHT6WwG4PPZM3z98FyASPQlszVLeNYWSpp89NB/+gqvpb6HwDwdbGg5w2SqQ/gQkgC9Q90hWaXOCxQFj4n5vYuKIgY10oAvSSfWz+48/AhFLxvpcWfCnUGZL9qpWT95nNqQpNgsDzES1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445914; c=relaxed/simple;
	bh=xnZKhDn7otNLXhNZbcdoZRSWnSDIyGSANSQbXEe6skw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhOBrNcIMvpsuNx5lOHmz1LzEfN7KLTevU5gJaqeeTJ1XIpIkWcZx8TvV8OZLhRTL85Ew7RUASf7CRctwS9QZjvthf8nVnY0/pYweDYeZrD2/RFlgDkHR7W7Na0fR2K6+Q5W9eQVnLPAfregXTjYHeor6PAS1MenFZq/fao7a/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JHMATMyC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736a7e126c7so247534b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745445911; x=1746050711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jffhp1hKLKw2I8ZSd4rm9aBy59gHCqNpHWIp+bmrqS8=;
        b=JHMATMyCfsJrl96TDJxww09VbW9rAH6434JaWJBU435jM/rQ6iWdk/F6OAddPe7aqy
         sOYdGYM1z5TJa9QIbl8cXg5sPXg4RZfAHnP4ZzB5cG2gDZuQSGFMAxu4oAI9HTDO+Tv2
         Jomqx0cXiCx8/cb740Ae/XXrIS6KvmneN/biw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445911; x=1746050711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jffhp1hKLKw2I8ZSd4rm9aBy59gHCqNpHWIp+bmrqS8=;
        b=t0H4kApP1tuPB3pi+GLDYhv4aGKCixJxkfNUgdw2c/S7CGr/cK7a/xjv+CmPq70E8E
         uzXrA/Ldi6C0DS5yrxpvTfPEJetiyn1dTCu5GudZ1etPzJtE0aucUOFPxUNBAD85jacz
         E4DbMO429Je9yNvuQB1ZZpKFmDvgDA8EulXZ91C1n9yha8K9y02KyNwzFkCcmYjBoqvh
         YQUU6n+7e57ATvlENJy0/8LuZBuGmitY1EI+8jHSGIKDaMbK7gHdpthd5Od971clF1L/
         G9YLRhrErz94AEftUZ6tOR7/wFDhcfgRWJqHkE5UhEJ3/Lh3WfUfW2XRUJmqZBzt9X91
         KMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhfK9NhjWhIuXiedtKHdUoEQS5rjNbkCdb14Vk324NHe/Kkp3q0GM4s0+VCdNYsZiZOoG5fn6em4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn+lOzwdhxi65PAXsIFD++aZIi9DrREA29r8BoXsBSr3wnG56
	JVUJlI/+iHLOHXHFljv74YiA4EwCjR9cUi1edIW1byGT4CVhbR4LXPY8meXlDWYB0qQGqcrOL0Q
	=
X-Gm-Gg: ASbGncvH0k0O3uxbud3J8+1X7VdS06da67x58ah6JjXr2SYth35NErgZyGuKwBVtfUf
	yiIQmgGWdt1BkPzNPMF9SdtX0rJkQeiGQa1z/KNA4Qtz3T75fC0uOvwgA7+1XUSQ0n1nsBRQ51/
	poIA8zHNgH35dbKn+lO+7qfnZh4FALUib1lNjkf05uTamRcNw84h0Ifhc93ota3Fx971aFmdxva
	H+BOfHM84BM7NodIBPyg8jQssKxwEWFbCj7n4Ba3eE1YMK4m6YFfo/mGjpt66P25xiyI9N8qiO0
	1QarqVReL+2BNyXXXBj67qZ6i/p5qfjyEZtWnoCgHi0=
X-Google-Smtp-Source: AGHT+IFTQuwm5PJqZ/wRRM668FD8oALUjvziG6gCcOfIhXnw8NcDvO/urULrUnjQLbspA5EZIgZFfA==
X-Received: by 2002:a05:6a00:1d88:b0:736:b402:533a with SMTP id d2e1a72fcca58-73e245bd3c1mr469646b3a.1.1745445910938;
        Wed, 23 Apr 2025 15:05:10 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:642:d9cc:2ed4:9b6c])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25accfc9sm66755b3a.176.2025.04.23.15.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 15:05:10 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4] iio: cros_ec_sensors: Flush when changing the FIFO timeout
Date: Wed, 23 Apr 2025 15:05:06 -0700
Message-ID: <20250423220506.2061021-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

|hwfifo_timeout| is used by the EC firmware only when new samples are
available.
When the timeout changes, espcially when the new timeout is shorter than
the current one, send the samples waiting in the FIFO to the host.
Inline the call to transmit |hwfifo_timeout| value to the firmware.

Now flush when a sensor is suspended (ODR set to 0) as well.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
- Do not drop lock between changing FIFO timeout and flush
- Remove unrelated comments
- Use local style error handling.

Changes in v3:
- Fix error detection when setting the sensor frequency

Changes in v2:
- Fix sysfs attribute in commit message
- Indicated the function to send the content of the attribute is now
  inline.
- Improve error detection when setting the sensor frequency and flusing
  the FIFO.
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b1abd6e16c4ba..639cac3b4596a 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -103,22 +103,6 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
-static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
-				      int rate)
-{
-	int ret;
-
-	if (rate > U16_MAX)
-		rate = U16_MAX;
-
-	mutex_lock(&st->cmd_lock);
-	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-	st->param.ec_rate.data = rate;
-	ret = cros_ec_motion_send_host_cmd(st, 0);
-	mutex_unlock(&st->cmd_lock);
-	return ret;
-}
-
 static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf, size_t len)
@@ -134,7 +118,25 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 
 	/* EC rate is in ms. */
 	latency = integer * 1000 + fract / 1000;
-	ret = cros_ec_sensor_set_ec_rate(st, latency);
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
+	st->param.ec_rate.data = min(U16_MAX, latency);
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	if (ret < 0) {
+		mutex_unlock(&st->cmd_lock);
+		return ret;
+	}
+
+	/*
+	 * Flush samples currently in the FIFO, especially when the new latency
+	 * is shorter than the old one: new timeout value is only considered when
+	 * there is a new sample available. It can take a while for a slow
+	 * sensor.
+	 */
+	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	mutex_unlock(&st->cmd_lock);
 	if (ret < 0)
 		return ret;
 
@@ -853,6 +855,18 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 		st->param.sensor_odr.roundup = 1;
 
 		ret = cros_ec_motion_send_host_cmd(st, 0);
+		if (ret)
+			break;
+
+		/* Flush the FIFO when a sensor is stopped.
+		 * If the FIFO has just been emptied, pending samples will be
+		 * stuck until new samples are available. It will not happen
+		 * when all the sensors are stopped.
+		 */
+		if (frequency == 0) {
+			st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+			ret = cros_ec_motion_send_host_cmd(st, 0);
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.49.0.805.g082f7c87e0-goog


