Return-Path: <linux-iio+bounces-23569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B9B3DB7C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DC17C301
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105E52F067E;
	Mon,  1 Sep 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MRPqy7dq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EE2EFD8E
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712984; cv=none; b=nQuZRXVbnV6AIAb6sbVxqh6ODbcBlwyXval1rqo7KJ/9JFRYslOJjkDEfOPmdYqNM9A2vuyU+V0um//CmxK3guu3LtnNNgvhKIK+c4AlYuYBpdo8i6OjQ4sS/KLiCuBRT5D6Zm39E6TiEz6BZ6oLMZxYj7wD/9vN3tQN0W7h07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712984; c=relaxed/simple;
	bh=r9nUuwoD87Rj7kZagZ8izL76U2V+u1v93bacmflcxCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC5QvKJkCSlfrbMBVdctbKfFNRd+6odQC8sB6Vr5aVPdSN+a5HofCKk3bX1ULN8rTSrNSPTQzSvCUDEbGP+VxtlM1R5uehBk1tf69wTAK8heNJ+7e+9hlgHVzwBtsflsX+6B12TFfS0vYkLKaJajWlYBFREVvZlxL3608UNOcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MRPqy7dq; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1756712975; x=1756972175;
	bh=sJIvh1vBl0u9m0tMjb9AY4bqs0pUmjpLM1koudDIegA=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MRPqy7dqWi9pAmW58CWkkZLal/H5XZaGzNSZSUP2pXcINutTuTS4z9i/TmOv6/a9x
	 xdUJw20dYA6PsVAMEMMTwG55fpeI78pyjpaWqwPfv/u4BSzV5txmNsYwwDvcF17FZy
	 ENycMlwlfKFLsIeI8jbEgE3gc+Yp7b7pKWoZTGrc3KFwZXeNGGXqHXlVb1c0TDLhHn
	 qaTKLkD+W6UiYSuSJpFq4I8jiKi/4A9LdwVRzb2VmhbjPHWtYlII+snAjW8RxqGUk4
	 tORjJqkHUAem5gAsYY9B6pFLPDjRRG2Zw8jtTz4L6B42A6qfNh4IXjnMc0EB5SBxFd
	 vM0z8w+NcWi/Q==
X-Pm-Submission-Id: 4cFgxp0vc6z1DDC8
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 01 Sep 2025 09:49:16 +0200
Subject: [PATCH v3 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
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
index ee780f530dc8612cd25dc2216b153ef4e8c32b7b..4bf436c46f1cfd7e7e1bb911d94a0a566d63e791 100644
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
@@ -765,23 +754,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
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


