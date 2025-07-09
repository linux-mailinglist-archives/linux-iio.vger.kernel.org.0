Return-Path: <linux-iio+bounces-21480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A8AFE910
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C375A57B9
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89F2D97BD;
	Wed,  9 Jul 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UVdy09uv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B562DAFD4
	for <linux-iio@vger.kernel.org>; Wed,  9 Jul 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064537; cv=none; b=dppMRK2TUn7Vqiz8AvuIz6WS4p0CdHnaT7Z0FZV0MQ4QSwQX28U7JZESy4Yw02Kcf3LL/1cgI1p4Ma237vS0AMh8t7/MsygR69UTBDIX0SOlXCG1Dxb1gTtQPhbWZiNyZIF5Ei/dSIP9NmpMyc+/33V+czCbPCxjS2V5HsuvG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064537; c=relaxed/simple;
	bh=yjCOvDJQo8WbrkYg41mWfGQdp4nrnuuGCCQs5k4wunU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTdPZWttK4fQlPGc+42fo/GRUp0N5ZkqButhGmiyNBThmUOOBg5Jvtze47TkK8jCq1Mr4ARqzI/0xSWkOaH1XFEOGOzw/8F84Ii1ofATlshHA3e38wn+yHLlCMEsSr7FSPJw/Rhfh1jgfTDmeOrIOpKyOok1veGJU040n3pjmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UVdy09uv; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064526; x=1752323726;
	bh=YD/ZORwhNcjOZSC41mRBp8SECC2d7/ep8mRwBEd2PP4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UVdy09uvthYUQlJDAP3S7+JWMfBXbtZSheVvHyd1lxzdNUcBE1SMUgAWBlGi8Sogb
	 uhwwovaqS7vRNs0F62iSdTOGFy5/TaC4IaZkOdRwUj4vlaOQQlUBpm3dkbnZ6iCuLf
	 EvLl82uEiWn5KYgewhmtR6vjSNg57QFl/++4NesoZL00hm/e2gy69RKgksA9rHBD/8
	 vlDeoKqWgVQHjdU+pKEI8tH7C3ioFMWMVhzzerPe64GG5phWRVVx9bTTMgWbdTtDxk
	 IsjDDENHgx04T9y38mEbwo4YfyQKmbijkEyufhtjHeYPeTldoSd50/UIB4AJ4dbUrC
	 gYpm5xOJedqWA==
X-Pm-Submission-Id: 4bccrY3dxpz1DDrZ
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:14 +0200
Subject: [PATCH 6/6] iio: imu: inv_icm42600: Avoid configuring if already
 pm_runtime suspended
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtimeM handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 37b3a7754da1c4e381e38c9871e55a941e19cef4..d745a40b042e1c86b232aaae0820942d11d51c79 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -824,17 +824,15 @@ static int inv_icm42600_suspend(struct device *dev)
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
@@ -887,10 +885,13 @@ static int inv_icm42600_resume(struct device *dev)
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
2.50.0


