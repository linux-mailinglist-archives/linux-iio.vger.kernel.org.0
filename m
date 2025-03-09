Return-Path: <linux-iio+bounces-16636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C27A58733
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D5F3A5AD1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917C1FF7CD;
	Sun,  9 Mar 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlyfbHg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277751F8752
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544523; cv=none; b=pJxr9fOTBN+vP4LXJTfENaMaR7dyOVV7K459Y89U939sJpcdLZTvbfafjjQYQ+BXv8sfz0iOk8q1tsXYIZhbND/eDutDfhZ01tDErYFqpB7IFhBTRyKNBUpUYbDAYCBmBeVAfrd8aOYnMM6n6erwLklcBuIFmyoKd+nkX8MdjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544523; c=relaxed/simple;
	bh=z74LzUqGPUA+MfJZNN0C1CeL3tpxxhCHIc67ouI+dqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq2vgJe/0KDrbI2t3uSrnAjX+5+VUkwIvgMkKRHP8wux3EbdxUkuP2f8kO6lf8BiDqMylxaHAtGLDep6MJYXHcygnsEzjwgwTC420HlAisbWfG3ZlYMcC9tI29Kpcwbibil5q9hlIu9gjZ33esUO08l57Aiehyl5xv7PR5b+2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlyfbHg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05912C4CEE3;
	Sun,  9 Mar 2025 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544523;
	bh=z74LzUqGPUA+MfJZNN0C1CeL3tpxxhCHIc67ouI+dqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlyfbHg6dpZMF5am03UbUqAN8Tx9LYgSHD4XE5HqzS9uto+o1Kk2+F9t+yTAH2Ilr
	 xNZRt78WIWQgSr0farqAorFp+PshNO2V50aVEDIOTMJrYPx4MKDDm747345QHcmXJg
	 BQhjWXycd+ARuwr/M59V9iLjamhUBiMFopExn7PIkTkD6Atbl4B0IdtViDzoQWc3aC
	 P9aSLgIJ3o6V73RWZqWqm0ekBsrSuafzqF+wW3+hDro6kAFRYYxKjKKy0cdVxllmSZ
	 3mxfHimyKDOm5eV0BPXEMD2CXHoduPuSx1XAxjmKqg9Kw9aITGgrll0dW5uXYlTYSL
	 16+9lqm3ynokw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/16] iio: temperature: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:54 +0000
Message-ID: <20250309182100.1351128-11-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 5 +++--
 drivers/iio/temperature/maxim_thermocouple.c     | 5 +++--
 drivers/iio/temperature/tmp006.c                 | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 692520e1c497..005106a9e03b 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -131,8 +131,9 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	if (atomic_read(&temp_st->common_attributes.data_ready))
-		iio_push_to_buffers_with_timestamp(indio_dev, &temp_st->scan,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, &temp_st->scan,
+					    sizeof(temp_st->scan),
+					    iio_get_time_ns(indio_dev));
 
 	return 0;
 }
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index db2149d5f78c..2db13d381dbd 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -168,8 +168,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 
 	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+					    sizeof(data->buffer),
+					    iio_get_time_ns(indio_dev));
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index b5c94b7492f5..29bff9d8859d 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -269,8 +269,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 		goto err;
 	scan.channels[1] = ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.48.1


