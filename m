Return-Path: <linux-iio+bounces-23893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58361B4A321
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CC117B884
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F43081C0;
	Tue,  9 Sep 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aJI/skLO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A730505E;
	Tue,  9 Sep 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401898; cv=none; b=VvDyedqciBxSpgL1PEAnoIwKLq9diZxKsH/96jBY7H2Az+DycwXaR24DiO4NBpWMmEhndGk+8V6Q24bucGmJ5OwPphFqebf4aEvirzS7Gnymp6E4AqcAyJV3NIN/7Y08xd7JvCZNHMlnLmwfSu3PZ4DIGe+yOla2WvI1wRK9FBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401898; c=relaxed/simple;
	bh=k5EcpY+/DFBwpLrWYB9YJb0ZadsqeSt/t/hsL/nFUQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXCcITCHnpXMZ0OOpTsWlgZ0nlfvJYqv7a5nmQskzK6U6MaYJXDBigBp17tqU6CEHBswL2l6zek6c0j9si68S5HB421fD1tudn2W5lYDwbaaAHCjQTQaEwBVu0krvqkABh4eePzyR07Pby0NoC1AiyCeRlmhNct17BLXYFHcxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aJI/skLO; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1757401888; x=1757661088;
	bh=xYd9qNsZ4IIvksv/lLIifpsYugqw4UBhFpRtcHQXVY0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aJI/skLO3BcYBxWUSeNwpQXxvYVk3KauAeZ+GynyGb1A+fbcs3dphXM/WyQrG3Y27
	 jPftyb6CZFRsnZJsaAR2uSOaUyOc1gDxD2x0we9xZLuI12l1FnHMURNx6uXi69/S3q
	 PSew3fn/pVuEqUgY8k35/KOqMzPwIeS1CkY3LEYyPjdkx4EVl2dWKlDp805tS+ypdy
	 yxTgjZxw/+mBr356yj1CCz92dy54EQVwIKC6+1Y241Lbot9NmTiczo3boLDxkEPv/v
	 OOOf4ZwaCRmne8V72qUJMYYr+2HTD2ZE8qgzkdBCH0bhthnE7TrBItSMa0e0eTPWTe
	 /0BIx5NgL5TCg==
X-Pm-Submission-Id: 4cLZk71ZMNz1DF4G
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 09 Sep 2025 09:11:08 +0200
Subject: [PATCH v4 2/5] iio: imu: inv_icm42600: Drop redundant pm_runtime
 reinitialization in resume
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-icm42pmreg-v4-2-2bf763662c5c@geanix.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
In-Reply-To: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
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

Remove unnecessary calls to pm_runtime_disable(), pm_runtime_set_active(),
and pm_runtime_enable() from the resume path. These operations are not
required here and can interfere with proper pm_runtime state handling,
especially when resuming from a pm_runtime suspended state.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76d8e4f14d87a552a35d7a9e0cb3305781d85ca9..41b275ecc7e25ea0b8cdf59be514cdf8a4957ab4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -917,10 +917,6 @@ static int inv_icm42600_resume(struct device *dev)
 			goto out_unlock;
 	}
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* restore sensors state */
 	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,

-- 
2.50.1


