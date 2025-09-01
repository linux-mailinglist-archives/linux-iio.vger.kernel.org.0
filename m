Return-Path: <linux-iio+bounces-23567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F10B3DB78
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30863188DCBC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF292EFD82;
	Mon,  1 Sep 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="m8Uy+0IJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBF2EE5F0;
	Mon,  1 Sep 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712982; cv=none; b=tDt9NJw1gMYlI79yjeqiw8oEO5Fv8LLEq7HXgUM1oDTrKlscSuqDtt6AiGNpr8nr/mCbb/M1O32HqlGqk9cJolyxd9ycnK+JJQi/xseUsjyCprGrunigpBV+XrzjWNGeCXqKv1WpuPZuMSfO3NNaNnMIeAzYX7AVu6dNx9BeU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712982; c=relaxed/simple;
	bh=k5EcpY+/DFBwpLrWYB9YJb0ZadsqeSt/t/hsL/nFUQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c0g8kWwUI/yhtJYD8QQoWTDkl49mdf9yWEXhQSBa0iX4/ZVj6M+vDs4UCIqM+AOO9yBsEV9DG0sEEuoQfooLBeWw0gL9tLRX9Uwl4Y82PtCpQVILWT1j6QUXl99DdKF8FXcfW19XIshGkOitOvb4BWDUreshpJyUS8OkICz/ZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=m8Uy+0IJ; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756712972; x=1756972172;
	bh=xYd9qNsZ4IIvksv/lLIifpsYugqw4UBhFpRtcHQXVY0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=m8Uy+0IJFM5eCxJ2Kpp9IWSWv2zKkg8ZOXJFjyntKr0moNVIJspOoYO5005tITCUp
	 dI5GY1O62/fK3vVdQSbAhTvxxQT2QrktlSgCZCqyYdeOjIR48UvEYVm6eSyljUUJUd
	 CweRWFF55+oeXIDdfOuqUW4bR/oFZ3hwSGPTkTnGopLFia6/qGp7LIYCX2Pj0ygP2E
	 TYQYnKZpp6TzcX7zvm9rx8I2LgljmYfuus4V4eTgi5UaDAL0OV8cghahUVFocAng9d
	 bpEbCVi0oOEsOdDqOgEIqDJ+KCX7lHrAVJQOnAfiZYdx0uaW0OfDwOi2rfv8PpiftS
	 CmesOsZQvbuuQ==
X-Pm-Submission-Id: 4cFgxk74cKz1DDC5
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 01 Sep 2025 09:49:14 +0200
Subject: [PATCH v3 2/5] iio: imu: inv_icm42600: Drop redundant pm_runtime
 reinitialization in resume
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-icm42pmreg-v3-2-ef1336246960@geanix.com>
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


