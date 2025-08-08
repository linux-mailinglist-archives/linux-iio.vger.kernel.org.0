Return-Path: <linux-iio+bounces-22472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CEBB1ECA1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AC1745DF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4228643D;
	Fri,  8 Aug 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RKQPyx6f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558F283137
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668682; cv=none; b=E+s2ZJIfw8SSEmKVAYnsuyvb6WsYHv/lecc9jaNhMQUrUcMmfSnbZOSZgnQxkudB8Bg7hCpqGYyl7QvSrLUZgvTx6hKE2KVvO9nGosmigLKdhFpyLPUNV7v9ej6tsJZHO31l1jqriOzOCYTHr853FziD4tAOasfkls8SCtDrOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668682; c=relaxed/simple;
	bh=rvt6rM4Vqo/82nMtBHiRIxI6C70kbBNbWpNvi6u01aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEnDVE9EU2LnmY78qQdGUVvHo1hI0iKFwMUPKawjIikn5ou/3yRXb+dYgwztxWlbyhTb1iHEOp2Lu7eFU/Dah30T7q59Msf0UU3tpGMqdxhTUE9uQVke3mVrnye3mAJVv8DtzZ1Psg+U7wwY0MX+crB498Cinmfg5rcvSmmtQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=RKQPyx6f; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668668; x=1754927868;
	bh=NsrBLr1O+psgUK8h5GJ977rYQy+ePA4Gy8v6K3B17og=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RKQPyx6ffw3/KYUp2cAvczvyyjTrnjd8W/CmtxhrIg6H8sQp9waW7bfStLftEtOx2
	 z1IUgU5zwQl/GnlqmB5q2F7qcKpeQW+XYyQTWpqOUmOn2JhK7DyQornRaXhrLxf4Xe
	 /z3RPhtCVrDWJ03DfPngPQD+sOuzKFlEBkX1haWR6uTZkvHd6TFntyZpanosuGeaTi
	 ra6U+hv6z/hxbfeUXLYRaAS8jj1km5mhtjVtEBFvVYOsJpc6jmRQY7koFnlDZaBVmn
	 XdeSPXM8c+ec4HqLeATPuByx7Pj0b6+66NoEI7JjoX74LCUFDppdfZX0FRbFoiqE48
	 Ewlm3ceFMfmcw==
X-Pm-Submission-Id: 4bz7wB4jN3z1DDBp
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 08 Aug 2025 17:57:41 +0200
Subject: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com>
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

Rework the power management in inv_icm42600_core_probe() to use
devm_pm_runtime_set_active_enabled(), which simplifies the runtime PM
setup by handling activation and enabling in one step.
Remove the separate inv_icm42600_disable_pm callback, as it's no longer
needed with the devm-managed approach.
Using devm_pm_runtime_enable() also fixes the missing disable of
autosuspend.
Update inv_icm42600_disable_vddio_reg() to only disable the regulator if
the device is not suspended i.e. powered-down, preventing unbalanced
disables.
Also remove redundant error msg on regulator_disable(), the regulator
framework already emits an error message when regulator_disable() fails.

This simplifies the PM setup and avoids manipulating the usage counter
unnecessarily.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a4d42e7e21807f7954def431e9cf03dffaa5bd5e..c19615750c717101312f358a9160dd2c455cfb14 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -711,20 +711,10 @@ static void inv_icm42600_disable_vdd_reg(void *_data)
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vddio_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vddio error %d\n", ret);
-}
-
-static void inv_icm42600_disable_pm(void *_data)
-{
-	struct device *dev = _data;
+	struct device *dev = regmap_get_device(st->map);
 
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	if (!pm_runtime_status_suspended(dev))
+		regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
@@ -824,16 +814,14 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return ret;
 
 	/* setup runtime power management */
-	ret = pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
-	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_put(dev);
 
-	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_core_probe, "IIO_ICM42600");
 

-- 
2.50.1


