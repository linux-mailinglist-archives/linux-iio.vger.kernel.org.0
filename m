Return-Path: <linux-iio+bounces-21444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84EAFCA17
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 14:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FBC3A8C9A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096A2D97BF;
	Tue,  8 Jul 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pBMNc9/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA802550D2
	for <linux-iio@vger.kernel.org>; Tue,  8 Jul 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976577; cv=none; b=WVmNiweAz7CNWBU3dFKpD5fxGEbe+QTIzCrkrMdGHhf9s2EdV8IepOJF9HjyYWk5gR8wEjbTK4E7/XKJNNj9TxtQc84uIQ22pB5AWLuALsCkMd5yeyHKduSliInfVjF3D1W7++oE9G1xmcS1BRfs+QdQsfvY61ZUCzi0VYbuOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976577; c=relaxed/simple;
	bh=YThqgd8Hr0iqLD8U3Uf8SX7+JGexDAHHky/5vfYBvrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sGYwu08CBCsU7iau8Z6eFayzB4VzJ+XuiE1rW3x3f9nPrZKGC3zL2ElU47esZDw14njTPXnwlnfODp4TAkU2srSFadLZvtbCIxp4bYhVNL2+LnqzgZYQO40/EUzLSmd0rK+mYCw9lD0kv6zqQoazMQA3fa5FvF1L6RQbKknuhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pBMNc9/v; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751976564; x=1752235764;
	bh=rm8J5seC925zvsKJXNFZQeFgzMxHj8uQznDHJ7BLLrk=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pBMNc9/vKEzixlbA8SA2sYNlwrgCt1zuAZvhACSn3v8oEGgBiAG7LojdlYvMYAfu/
	 Ywko6ShcV9KO4MmG3TSbaqm3QFp7ZAtRiodYG/inDYxI6SoDDDsK48QCH6ZvCKvD7f
	 tGFp+ymELZHm1lGGmpaB7wyiRyjaQMx3sM+yTYZKWoc2FfNPm+nWS9y0HLNfG016s+
	 gKjGadGYXPd8FQWkpGdK0o+JW4Ybovs/T5dFn8w3+pro/xIzAKJoyxk1b8sArWEAQ7
	 6Ix/Z9bi9M2t01eFVsWZ42OG/LcSR/3SYRG1dPR+6nNmuEvZpRM0dCH8I39om3RSsK
	 XfcpEFOdIMByA==
X-Pm-Submission-Id: 4bc0Jt5sNqzB57
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 08 Jul 2025 14:09:17 +0200
Subject: [PATCH] iio: imu: inv_icm42600: fix temperature reading if
 accel/gyro is off
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-icm42temp-v1-1-81af60aab82a@geanix.com>
X-B4-Tracking: v=1; b=H4sIAGwKbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3czkXBOjktTcAl0zI0ujxKSUlCSzVDMloPqCotS0zAqwWdGxtbU
 ArqD1MVsAAAA=
X-Change-ID: 20250708-icm42temp-6292abddb6e6
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Avoid return invalid argument if one tries to read the temperature,.
if both the accelerometer and gyro are off. Power the accelerometer on
before reading the temperature.
The original state will be restored by runtine_suspend() or the next
reading of the accelerometer.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a4d42e7e21807f7954def431e9cf03dffaa5bd5e..f97376bc8bb3dd225236e3f5036fd58af4af35ac 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -399,9 +399,14 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
 int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 			       unsigned int *sleep_ms)
 {
-	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode,
-					  st->conf.accel.mode, enable,
-					  sleep_ms);
+	enum inv_icm42600_sensor_mode accel = st->conf.accel.mode;
+
+	if (st->conf.gyro.mode == INV_ICM42600_SENSOR_MODE_OFF &&
+	    st->conf.accel.mode == INV_ICM42600_SENSOR_MODE_OFF)
+		accel = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+
+	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, accel,
+					  enable, sleep_ms);
 }
 
 int inv_icm42600_enable_wom(struct inv_icm42600_state *st)

---
base-commit: 3e28fa06444e7031aba0b3552cce332b776fe267
change-id: 20250708-icm42temp-6292abddb6e6

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


