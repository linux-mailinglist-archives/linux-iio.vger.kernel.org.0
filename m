Return-Path: <linux-iio+bounces-21481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE61AFE913
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 14:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C1C5A5ACD
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72B2DA76E;
	Wed,  9 Jul 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BjRfsRYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C12DA75A;
	Wed,  9 Jul 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064541; cv=none; b=p1nje7lkNi0tRs0QLp50mDYwEvW4VsMXqvnlEXpwoOt2r8fCB7HWAU6P045nC/1CuTxWhZ/ys9tq7WLQUeHQ2Kybx0Q4DsCdSqg5TqrkCnQGJFCX0cvD3UnjNuEeuan9GaVpmbZqFwO9Ug81MFUOnx9QeLtUuJehX9DG5zPRUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064541; c=relaxed/simple;
	bh=90nZHr68OpVkdlPt2h1quO+Nu1erql/5QFWfMFY2vgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1NMMpj7q54c40NTuSJvIqgQR+hgRLL2q76PgCwIRf8Le3Lk7HrfmqWya9UInmWmPwmryDB8a2PFyyysEWh5ueNzd68x6qF39zzj9wHi8ez5EsNbyepcNHGlPYYO4qLI6inScugStm7JFxbl4TyCfzkYCDmGNx7sxrNFGh7RTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BjRfsRYh; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064524; x=1752323724;
	bh=qrCWuverZXRvjlPMM/+qLCn8I0Wqrro+j6nIJoVg+Yk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BjRfsRYhQ1g1AYHz066B3VE6PNEb7w/Jch8sfftGlPR3gLddQzJ85tAvwn88C5V7u
	 E3OStfZ+YCSfnXiydTS4W4aUiOpJ4TxSPvNGrNbk1dnQ20dvF81oNfV+iYP1WmyO7J
	 hXVfv3Vvy59ACip3nyk8Wt4XhHZae/g8BHsVCC2lY7irnnBEMrBr0Hg/i3JOpfnjn4
	 0fxxpn0VcPrgPp7U+q+2FuLQ8i8JA91wB9SR6/FdQ+DZct8EaEpVHCPajKeCPzvUon
	 gaegpY/h7opPZESRF82vdQ1G2qEzdlV6wzwgehbRRrBER0+2wvvE5ho2Das2XraXky
	 s6hp5hrnJJamg==
X-Pm-Submission-Id: 4bccrX07mCz1DDrY
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:12 +0200
Subject: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
calls during probe. These are not required when the device is marked
active via pm_runtime_set_active() before enabling pm_runtime with
pm_runtime_enable().

Also remove the redundant pm_runtime_put_sync() call from the cleanup
path, since the core is not incrementing the usage count beforehand.

This simplifies the PM setup and avoids manipulating the usage counter
unnecessarily.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 55a29b1e2b11355598b0ede7af22857aed3ae134..1072bea11c73d09a9a0e6ea9d4a5c7a72248dca7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -708,7 +708,6 @@ static void inv_icm42600_disable_pm(void *_data)
 {
 	struct device *dev = _data;
 
-	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 }
 
@@ -806,11 +805,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_get_noresume(dev);
+
 	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_put(dev);
 
 	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
 }

-- 
2.50.0


