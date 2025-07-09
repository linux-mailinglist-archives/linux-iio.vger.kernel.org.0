Return-Path: <linux-iio+bounces-21475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624FFAFE909
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 14:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63BE1C80288
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB882D9ED8;
	Wed,  9 Jul 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iiyrDiIu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB52D97A6
	for <linux-iio@vger.kernel.org>; Wed,  9 Jul 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064532; cv=none; b=X9VNL8tT4THY+QLCvE5DpWwEq5aB+6Oj4fSROuer4wJVw4NvEHz51Nx7yKjZG84nhoBeNkP5HFJ17vXYrsgAYh5eOr4hINjDw/Nlizl2mLUnLQ9fUe+BrysYrjpRC8g3Ekxh0r/08H/jBpLd9Dm7381BLyjjw8K5wl0f+IKZCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064532; c=relaxed/simple;
	bh=WjBv+IqC825TXVG2xRcp0WQob+tWH9klHN01U9Jgx2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LU2VhDXkq8eMMitWLlAV0qpFTzm7LajqeL5KIDJkdzJF1wvyJRMNdSUJEq1o4aOlYg2SCGa7VchRcVxN3YES3Rk0ABYHqhRF2XDm95OvXxvVEHaurLbxgBcG/DknDnwnU1y6r2L0Kx/TLp4O7KdCW843AC4SqxuwqChPThAZPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iiyrDiIu; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064522; x=1752323722;
	bh=/KotKrvzSuZ1fCGQuYNoDiGuvp6Ejyo5IuM8cm1J9bY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iiyrDiIuCApiV4JDS6itxddo6T0/8ob/xUEmMt/f9eb8OZ/Qa90FsyFHlPZXjIcVo
	 JAgCCJcGcIpFJIJu8KWuunkpWwPMn7miRj+9KyVZl6+jOa2nEhisk6OHHJuocqYqkr
	 1Oq93mY/JV65scOYWPA12LoWIuv2iFnbkkhpUwueqaqHZQawn3nhUH7mHj1Pb0tNuE
	 zJp/SQrJt95izW15GzqYNEQEa3XNTFNm9iGvQCfUG2J6c4o0VfZPUF5F9o9AENqsgj
	 Ill8ZJg3ulPseMDz1fwQUE9fv3LgGEC0QaKJKpJBYs9pUb5ohNdDhqRn55f31v/tqM
	 d4n7kVcEX9q4g==
X-Pm-Submission-Id: 4bccrT0sZYz1DDrV
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:09 +0200
Subject: [PATCH 1/6] iio: imu: inv_icm42600: Use
 inv_icm42600_disable_vddio_reg()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-1-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Replace direct calls to regulator_disable() with the existing
inv_icm42600_disable_vddio_reg() helper. This improves consistency
and ensures any future changes to the disable logic are centralized.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a4d42e7e21807f7954def431e9cf03dffaa5bd5e..69496d1c1ff73132f5e7bd076d18a62c293285a2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -892,7 +892,7 @@ static int inv_icm42600_suspend(struct device *dev)
 
 	/* disable vddio regulator if chip is sleeping */
 	if (!wakeup)
-		regulator_disable(st->vddio_supply);
+		inv_icm42600_disable_vddio_reg(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
@@ -973,7 +973,7 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
 	if (ret)
 		goto error_unlock;
 
-	regulator_disable(st->vddio_supply);
+	inv_icm42600_disable_vddio_reg(st);
 
 error_unlock:
 	mutex_unlock(&st->lock);

-- 
2.50.0


