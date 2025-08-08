Return-Path: <linux-iio+bounces-22475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0BB1ECA4
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FC5175AAE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCA286888;
	Fri,  8 Aug 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tD+Lnr9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE3286D5E;
	Fri,  8 Aug 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668685; cv=none; b=WSdyHhRjiCikXDvneY8m0MwTZNUUVIexKWBwP4uipScu3JcDkPHNuFr8whlrs5D+Fy2Zv5I139tHL9RhoI5Vaz9a8dzUSqj8jB95tNeENLIw7ZD4RJwO/n1DxNepEv62oVhSX5srgLnKAveWTiyZhTgPAZYAfhWdSzRcWmcCsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668685; c=relaxed/simple;
	bh=Nw1uGgXeW4j1JkUEG3B8v+vzkkHUpPSC9zUmgMbsLS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fp2R0NecOkFWKcz7JHPsUCXGF2jY1JQNbFKvW/4okTQItMHl34FDuIMYyHbnGjsNfhLKOiv+OShfuyFlHq99zPzcb1B35vKOGGINxlF48PGWSFmi4Ck8UcVBzcr0XwQ4N1f+YJsPcqvkOit2VgGPnlKSxozV3DEdTSY4UmS1bnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tD+Lnr9a; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1754668675; x=1754927875;
	bh=3gIzQL82i1incBkOlRsS99CnvUyVAey9nSxJMAxkUmE=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tD+Lnr9a51YR32puwjvntLmyz5ZzWCL1oltCjtk3SoJlVrstpF3cRROT9rEyJVHxZ
	 cDssiOdCNOblQsOXI00TcAyK/2E7DT5T9Re2MKJzZYM1CQ79+0KEdLSRtrMkJoGyNo
	 qI8c+rNuBQZBAS84fH0mgc2prvkcId2A3jc2TQKawGluoWQaTtQvNvyAtOKYplaP6x
	 jKPLVRiOqWiov4qedEeq/Fb45MbjrH9t++5CrA0o58CfQZ105t6VUpIiwbWztvSHgp
	 aAWraELFdYPxXgVIt+8jSKbsGBtJ15oMNgdrIrDgMs9cVdHDS+EjKwybwsxQPWmiP4
	 5MQ+C/iBj6+dg==
X-Pm-Submission-Id: 4bz7wK2lFQz1DDBv
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 08 Aug 2025 17:57:44 +0200
Subject: [PATCH v2 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-icm42pmreg-v2-4-a480279e7721@geanix.com>
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

The vdd regulator is not used for runtime power management, so it does
not need explicit enable/disable handling.
Use devm_regulator_get_enable() to let the regulator be managed
automatically by devm.

This simplifies the code by removing the manual enable and cleanup
logic.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 29 +++++-------------------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 1430ab4f1dea5d5ba6277d74275fc44a6cd30eb8..c8b48a5c5ed0677bb35201d32934936faaf7a1a6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -167,7 +167,6 @@ struct inv_icm42600_state {
 	enum inv_icm42600_chip chip;
 	const char *name;
 	struct regmap *map;
-	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	int irq;
 	struct iio_mount_matrix orientation;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 39ba94e2e473abe7af64c655f0399bd756ddfe11..52f61e90fec3e08effc1d398293bece5413406d1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -697,17 +697,6 @@ static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 	return 0;
 }
 
-static void inv_icm42600_disable_vdd_reg(void *_data)
-{
-	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vdd_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vdd error %d\n", ret);
-}
-
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
@@ -763,23 +752,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return ret;
 	}
 
-	st->vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(st->vdd_supply))
-		return PTR_ERR(st->vdd_supply);
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get vdd regulator\n");
+
+	msleep(INV_ICM42600_POWER_UP_TIME_MS);
 
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(st->vddio_supply))
 		return PTR_ERR(st->vddio_supply);
 
-	ret = regulator_enable(st->vdd_supply);
-	if (ret)
-		return ret;
-	msleep(INV_ICM42600_POWER_UP_TIME_MS);
-
-	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vdd_reg, st);
-	if (ret)
-		return ret;
-
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		return ret;

-- 
2.50.1


