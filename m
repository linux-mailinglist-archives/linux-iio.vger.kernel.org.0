Return-Path: <linux-iio+bounces-27186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF069CCF880
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188F4304DEB3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0D3064A2;
	Fri, 19 Dec 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="horS8V6v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11A4502F;
	Fri, 19 Dec 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142384; cv=none; b=myODqq93xn+2PUetAUt5DDO0BYVc3m/FI/SvN5VmilaX9Lf3i+l2Gdz3ea2ejuRv5TsukJdASlAZk+/bduds/xiKqeP6yLkOrgXwTxa7+G9NwYUsVUct2q5UNlhgY0SOZrfEiVQXXCgCYXsA6DKFGWJVtJRkedOr/IiRvM7met4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142384; c=relaxed/simple;
	bh=PAXIyJUlggXI8zQiq+IY019DDPUmBWYVgy8mHm7Ahv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxvQF6FcLMgJN5TFvU79au2q6vfyu4L+sBck3tfw6jvWnObXc7WVjEv0czny8hzk0UZrq52pjb2xDCEjDiHgVYQ1DcIp+Xgt/zfM74y0smj69po2TUYzYEexseGmDp0g0cXe9FhzaGnVwaX+LLKtMGAo8580Tq2nKiYvr9TLxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=horS8V6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B60DC4CEF1;
	Fri, 19 Dec 2025 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766142383;
	bh=PAXIyJUlggXI8zQiq+IY019DDPUmBWYVgy8mHm7Ahv8=;
	h=From:To:Cc:Subject:Date:From;
	b=horS8V6vzZBmuilXir9AMb9W+hAxzzx3eBcXtZh9AQXsxPM6m+KPGmzJolp+JbFv6
	 3HIKHuXHNY23fVHcQUlMFy5fA2ptftuNORxxMmlOIvTu3cQQXvRSIk9+UHbtpuZhsD
	 C4jwunNGZDSzYRaF0PJikX3B9GGfyyN28J6c+d9gu7mj11LD1OJCYdVlMGacYsrT8R
	 qEmZuaZOTCL4s02Oo3zdYXmNiTzTBht5NFPp/KdCPRUirvrIpNT3U6Ga+W245v/9Cj
	 G88i5UgsnvTehmoyIN7CIwDuXUKcQcXNPc/N/QuOkWW3s0VJUs1fHuFULE8gBeZT9H
	 XqUq2n3i0U4BA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWYJR-000000006CZ-3cAk;
	Fri, 19 Dec 2025 12:06:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: exynos_adc: fix OF populate on driver rebind
Date: Fri, 19 Dec 2025 12:05:45 +0100
Message-ID: <20251219110545.23813-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 1484adff00df..f2400897818c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -540,15 +540,6 @@ static const struct iio_chan_spec exynos_adc_iio_channels[] = {
 	ADC_CHANNEL(9, "adc9"),
 };
 
-static int exynos_adc_remove_devices(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
-
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
@@ -660,8 +651,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	return 0;
 
 err_of_populate:
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 err_irq:
 	free_irq(info->irq, info);
@@ -681,8 +671,7 @@ static void exynos_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
 
-	device_for_each_child(&indio_dev->dev, NULL,
-				exynos_adc_remove_devices);
+	of_platform_depopulate(&indio_dev->dev);
 	iio_device_unregister(indio_dev);
 	free_irq(info->irq, info);
 	if (info->data->exit_hw)
-- 
2.51.2


