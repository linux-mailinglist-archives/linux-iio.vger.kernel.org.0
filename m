Return-Path: <linux-iio+bounces-22473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36AB1ECA0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D551740BA
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA228643C;
	Fri,  8 Aug 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="omSkU17J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C8285044
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668682; cv=none; b=PY+06H96k71zDncWiCKycNhuqwRrdkW9QXyheUwVXHCW0We2H7/mhNaHVnjmg1jd+JgdsuuHSCi3KBeULAO/dwwmmAMMktrpB0YQBamUP7D8vAIcUrP/s5IYgYHCgMT1bvudC7dbGKcBFyv+aFKyuVE3d83apzRjr4TxFoeu2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668682; c=relaxed/simple;
	bh=bg72bqTzyflyJZv1HaKyzubxfUtGoxOZtzk3iL5qQQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9oSgBmW5eZ6O+dp2Iuww+Knr06jYVa7kPm4MN+cObPv3g6znflTOSnnVDJwz6Etzvb9C6N5U2bWdheOeQ3SgaJ76LNdcspQ19KVpgRT4CKmrYNWl5EiiTWGFn6CeWR4sv65FDSy6flsSAONzZpcIhD1nAymX+67sLzc/c7wTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=omSkU17J; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668670; x=1754927870;
	bh=pLNiFemUUUSl6LvDv6/uCzyLnyhH5smRs/HatvPcFaU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=omSkU17JlKI3KgwwDPzljiRVkU0J4vcBq4aFPAGP4kk18Q0YeNey0xRjUyzp78WJa
	 aVUXk/u6P0NNYM5g5BXZ/F2HYrwrZ/XFb96OCB0vR79dLBO2qY2PC6ufWoks9+FpYw
	 0X40uSA64TSfYIzVC1pceL16dcM0DDtrZ5/9SrJlgYCfOLqLr2JJvSZCVonkxYJhyX
	 97n4NEgd/L+yZTkQ4oqzi3lYNVLEKxSm2ZucSIp0SbPMPFV5l6OgTshRh3cWXfx64X
	 mGcav0TcNnWSX839e7HOxX7pvXgmPieqCI83DBMKmjnpIbrFh/JjdzIqI+5WiOMEiU
	 0Dk69srXig92g==
X-Pm-Submission-Id: 4bz7wD1hWYz1DDBr
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 08 Aug 2025 17:57:42 +0200
Subject: [PATCH v2 2/5] iio: imu: inv_icm42600: Drop redundant pm_runtime
 reinitialization in resume
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-icm42pmreg-v2-2-a480279e7721@geanix.com>
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
index c19615750c717101312f358a9160dd2c455cfb14..bb0dbbb7ad03bb57ffd3180785a686f2cdb5c845 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -915,10 +915,6 @@ static int inv_icm42600_resume(struct device *dev)
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


