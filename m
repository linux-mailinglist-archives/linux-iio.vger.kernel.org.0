Return-Path: <linux-iio+bounces-23568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66383B3DB7A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850857AD1FA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8C2EDD4C;
	Mon,  1 Sep 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="f3Xf3wie"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBB2ED868;
	Mon,  1 Sep 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712983; cv=none; b=If70MXvMQ1TlkRoRDVd1VaoofwSSApR08LBExbDA4wSEtg1W7LNKiv60boxD2ifbedyWTBoqmsaeexBj0KuA6WFup+mjXktzRSNjidwTxyYmNTfQRTKIcS3D9LA1p4d972mK6ldQVSiowqf4CrgPrFcz9oQw3z5xCZbSo2igp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712983; c=relaxed/simple;
	bh=OL3zTc++fWocVV76N9Qrx3mPmqq+2NTo3NP+aQUzDpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jt+/LmvGxeGMfXFaaNKReyEAnZXr9gFAFJZqQTIfVM/USNZ9PhK4rMumUEE3mXVBxtqQPiWJ8sROXeiMatS3WxxWWi4ruV/XLZknrTBS25qLC0xOZwFAtLnucfXIbZfNqPAcV5bd+SukS2sn2zmLeYPW2oHaXhQVJVRiLSivhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=f3Xf3wie; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756712974; x=1756972174;
	bh=tceitGNVxLxyezCWiChxK4zQKtJl6rtYJ4s3FymhP8g=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=f3Xf3wieYY+nAxMJE1Bg84DezJ4Yqe456toof07af/tkFVlHVuDyXDbkgepJdIJyh
	 DdzjKnUSfjdf1Zwuyix3Jk6zHlmLcIfL2NZGAEQOy+zb5NeJDr8Yn06s3DqPsQks5w
	 hr8HILHr470gIL6fRmZrZKyzRGVgHzHcubug/2F26i3xQm08V4W84TjDdDJDV2cpet
	 5u5XVwhfmNJkiywPd611R7cBq+L9+rINAtSIxVYy1gBpbLGppPnOTDPko7u0bFxJWE
	 mxHZDuIWnmsQ8Rp4k8Ox0fESGw8EtAG3Zfod9kfL1lqISSpt7J90TgRst8SXidQSeF
	 GQJmNLiubORXA==
X-Pm-Submission-Id: 4cFgxm4355z1DDBx
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 01 Sep 2025 09:49:15 +0200
Subject: [PATCH v3 3/5] iio: imu: inv_icm42600: Avoid configuring if
 already pm_runtime suspended
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-icm42pmreg-v3-3-ef1336246960@geanix.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
In-Reply-To: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
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
index 41b275ecc7e25ea0b8cdf59be514cdf8a4957ab4..ee780f530dc8612cd25dc2216b153ef4e8c32b7b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -837,17 +837,15 @@ static int inv_icm42600_suspend(struct device *dev)
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
@@ -900,10 +898,13 @@ static int inv_icm42600_resume(struct device *dev)
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


