Return-Path: <linux-iio+bounces-28024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD6D3BAAB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 23:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DD230286DE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02392FC86C;
	Mon, 19 Jan 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp+bHuQz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440128489B
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861070; cv=none; b=gSI/RLqYggCJb/pPcUgllH2k/IJgxjLpLC1NUFWEiiFilPbyfGl2JhQ6BC3Z257NyDWPzK4QsORNvzaxG1bgoJ7MzRK5yr3qmqX9T8MKVv6BgDKDS0C9FsT+fK2OtZ8Pvyt50KMNluFaS6JF3i5o5s+ty+L5IjdSltPElrUeYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861070; c=relaxed/simple;
	bh=PTuFaj+wv79sbAmBZCH9A4dSUx/6cAoSbHG5U44woFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRFEvrCIEkfdTI7je5K2Of9CxUYAV3Fv3OfGEuhVl6NoXFgle7nzubBnCm3LMEerXMbJOoa82p1kH+0sml2CUGekX0Lu/kTUz8YXCEFcAHx0ZyEnOgqyGodR+ywtNoYl2clBPd8aJD3wpwOrA7TTmxOtE2gqO5R4GECBliBerWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp+bHuQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396F7C116C6;
	Mon, 19 Jan 2026 22:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768861070;
	bh=PTuFaj+wv79sbAmBZCH9A4dSUx/6cAoSbHG5U44woFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp+bHuQzNfGHrn9uHRum0hUQ14PZWfDjq7j1qva/zob3kBgMg7CNA3Ff8r59C65MQ
	 FBY9U9SWlI+hDazu7zPRVjuNNW4xJgi0Laoh/WYp12K4Ip+bB43HlbocBD4WMQsNnj
	 AegYX7EKXM/iUmBM0gkDP2Fjabob+rPu42P6PrkPEw9e7aBbCrhf3GEQS/BYDaXJ1E
	 MEMeBArqU8d8VPTY4RThSLWoFZ8SCK+i0m7bpbUTPnVc/vpZc/PAa3Z2pZve5akwlb
	 KWrkq6LefQ4WZrclLW6VCbD+aK3pzMMuNNfHznDOs0gIwqINrfoBaCq3CClKX4bNoA
	 Qp/CpL1WdR0dA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is not.
Date: Mon, 19 Jan 2026 22:17:35 +0000
Message-ID: <20260119221736.804825-2-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119221736.804825-1-jic23@kernel.org>
References: <20260119221736.804825-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fixes the following build warning (and equivalent I2C one)
WARNING: unmet direct dependencies detected for REGMAP_I3C
  Depends on [n]: I3C [=n]
  Selected by [m]:
  - MMC5633 [=m] && IIO [=y] && (I2C [=y] || I3C [=n])

Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index cfb74a4a0836..2b81b22c9550 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -141,8 +141,8 @@ config MMC35240
 
 config MMC5633
 	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
-	select REGMAP_I2C
-	select REGMAP_I3C
+	select REGMAP_I2C if I2C
+	select REGMAP_I3C if I3C
 	depends on I2C || I3C
 	help
 	  Say yes here to build support for the MEMSIC MMC5633 3-axis
-- 
2.52.0


