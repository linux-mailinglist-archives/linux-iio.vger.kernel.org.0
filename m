Return-Path: <linux-iio+bounces-22474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B3B1ECA3
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B40624969
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E151286D6D;
	Fri,  8 Aug 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QK/HRNHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA992868B8
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668685; cv=none; b=TjsD8nBV7OpWk9OXhbRDskvAGpDD8kUH1REV/UB2Fu86mIG9svw0UpaVNpkQyLuPkfGOq7juNDM8zShgCiTtwA7u1pwNpNIP9eXe1cwmhjhdn4fnFBEWtXkA828W6Um6cwRmXKXBhNbz+MTs4KIp9/ad3vnNfy2HM0/46aDRP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668685; c=relaxed/simple;
	bh=uYqP9SSVha25TgfnfTcKOUq9hhB9ISoe8o7K384Zaus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMdFPxFYIlBjwqah8QCh2pA5DuCaSK7r7KTCkI6sUTyDSFOmSxkCoogTX98csk7+tQ1n9Y8R1aq0jFJUCdqoOBUtYfVFFd3/1fHeWqEZ7saWaiva1KZ2NT1WUxra4kziTLHEHfPXOfXAOIkurVFS+MQ3wVfJOfZKDOcRHUTfRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QK/HRNHS; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668673; x=1754927873;
	bh=2dzssqd2MPlmKUNBjcZT8UxbSJiIXNPn042fkwsXbyw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QK/HRNHSrtJOCLaafumIF/fvpz6xpUkr1c0J5xArbykXjHdFMY5nvwJGZ9E32AeMV
	 4aT6P0ztgTl/aeno6fsWAOpmlCe4MrVZEqtygmd9Z5Pz48DpsvPM9xPizoEus3lUa3
	 +Mf/WeplA+UwlJJ2qfXyzFfq9Ys2SFAxPg1ceC0NpgWEMb4yVxfy7xjoeOZ/ECFb1X
	 3nuGK61Qtxyud85wlyy4sbkNNW7/J/bCQt0u2Su70Z4RmbHwCIAUbO0/BT9249abe7
	 Cb9Hnm7wm76+HZequk6K0gOeJnkpOm15NhO7pnMMZJp3W9voz/0hnE4hsHkUqlcNtM
	 kqnWUD0p1crCw==
X-Pm-Submission-Id: 4bz7wG4xX2z1DDBg
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 08 Aug 2025 17:57:43 +0200
Subject: [PATCH v2 3/5] iio: imu: inv_icm42600: Avoid configuring if
 already pm_runtime suspended
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-icm42pmreg-v2-3-a480279e7721@geanix.com>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
In-Reply-To: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index bb0dbbb7ad03bb57ffd3180785a686f2cdb5c845..39ba94e2e473abe7af64c655f0399bd756ddfe11 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -835,17 +835,15 @@ static int inv_icm42600_suspend(struct device *dev)
 	struct device *accel_dev;
 	bool wakeup;
 	int accel_conf;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -898,10 +896,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	/* check wakeup capability */
 	accel_dev = &st->indio_accel->dev;
 	wakeup = st->apex.on && device_may_wakeup(accel_dev);

-- 
2.50.1


