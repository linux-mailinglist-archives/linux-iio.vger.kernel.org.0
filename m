Return-Path: <linux-iio+bounces-25549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F0C12FE7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 06:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7103C4E92B0
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 05:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EF7285CBC;
	Tue, 28 Oct 2025 05:41:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B371662E7;
	Tue, 28 Oct 2025 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630066; cv=none; b=BjUhXZcGIv2c48TJjPuFAea3LRqR383LyR7UqSuDZzk/oka1HUI0iqsSZ3jBGFhAn4oWTl/xYrCWHEfGQWKvMWAwaSAzQg3k5Gb2DvAP4Oe7akr/qm2q/7NgzcML8us1LLpg29r3YL8mYNG1l3B7Ctr6Ep5rYjtH/5AJKjj2ByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630066; c=relaxed/simple;
	bh=QYotWJVt+7ynm3WMxYnAaBR+x5jfqq0Nt6GKAa1llbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLjyWYJlmA86TjufJi03rzwgWkTRoIiD4lZaIvh1PWOQiA07pP64kElCGW87MXEw2IT+d3laEFUbyZMyGz23IwApNQ9LiTUUpi8Q32lN4fkX8/UDigby3OtQ0S7HVbOvpGe4iedBe0NqBG6/pBUMRQYfqnxD1r0RYNcuG2HWrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 13:41:02 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 13:41:02 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: aspeed: clear reference voltage bits before configuring vref
Date: Tue, 28 Oct 2025 13:41:02 +0800
Message-ID: <20251028054102.1954503-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Ensures the reference voltage bits are cleared in the ADC engine
control register before configuring the voltage reference. This
avoids potential misconfigurations caused by residual bits.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 1d5fd5f534b8..8ab29948214a 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
 
 	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
-- 
2.25.1


