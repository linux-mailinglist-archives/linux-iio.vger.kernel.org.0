Return-Path: <linux-iio+bounces-16117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52EA47C60
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 12:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D7F188E241
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50C22AE7F;
	Thu, 27 Feb 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d14/TOtj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C522ACD4;
	Thu, 27 Feb 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656356; cv=none; b=Z+fWneV36CJ3AO50yCEGAutT1sP7HKkwZJwjoUf+VDia0oyaUpIE6re7cNcOFYlHrSs9oD/rEz+u5PJuiQs+JFfzSmTXLkVS75at8uHYql5Z3YJ/qNWUbXiXuko/HrfZg/KczjupyHeoxO+bFlJiGlS73Fju5alaNVoXEDPiwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656356; c=relaxed/simple;
	bh=F0Z8rEAxBeFsa2HkvMbrKUdPBypxHLSg3HJ0e7tEzLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkMAfp8r1bOkG0ATSfBYpbnQeHpf7SmubchRXcvNQB53E5g3/yYff+4eWirLlO3W2hbE/eGVaZ1Bjtdi3OglXdRsV9D6G8kJAF/KZ/IOlwQ0yg++2FZnaL/NUO/q7RK4CD9kuK1j0o3jk/LDNXzlgu6x/3Kq0uFf9307Dj34wEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d14/TOtj; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3593;
	Thu, 27 Feb 2025 19:03:45 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] iio: adc: rockchip_saradc: add rk3562
Date: Thu, 27 Feb 2025 19:03:43 +0800
Message-Id: <20250227110343.2342017-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227110343.2342017-1-kever.yang@rock-chips.com>
References: <20250227110343.2342017-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQksfGlZDSkgdHR5DHx0eGEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954713a96603afkunmc65b3593
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6Pio5SDIcEQ0hKB1KMk4U
	HTQaCTNVSlVKTE9LTU5PSUlNQ0NNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSktINwY+
DKIM-Signature:a=rsa-sha256;
	b=d14/TOtjg9Yv9IjbpxXKPiLx6J8K3jXLTfVGaC3MteGr+YUR1nakxXWmFC7YaspoSIZyajxEvl5bHRL7Dm33sLHHrc1OYfS1Z+sYcm6DqbJmhmBy05Pa3BVKUuK7DmPzkOp1MNqsg3X71TBqy1/l9tvrp21dafzoC//1S3mkqXE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=v2NdId1ozjR949P6fBcdgfhadjWxpSqZ7R8aXjvMQIE=;
	h=date:mime-version:subject:message-id:from;

From: Simon Xue <xxm@rock-chips.com>

rk3562 is using v2 saradc with 8 channels.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 drivers/iio/adc/rockchip_saradc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index a29e54754c8f..9995f95bafe0 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Rockchip Successive Approximation Register (SAR) A/D Converter
- * Copyright (C) 2014 ROCKCHIP, Inc.
+ * Copyright (C) 2014 Rockchip Electronics Co., Ltd.
  */
 
 #include <linux/bitfield.h>
@@ -275,6 +275,25 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.power_down = rockchip_saradc_power_down_v1,
 };
 
+static const struct iio_chan_spec rockchip_rk3562_saradc_iio_channels[] = {
+	SARADC_CHANNEL(0, "adc0", 10),
+	SARADC_CHANNEL(1, "adc1", 10),
+	SARADC_CHANNEL(2, "adc2", 10),
+	SARADC_CHANNEL(3, "adc3", 10),
+	SARADC_CHANNEL(4, "adc4", 10),
+	SARADC_CHANNEL(5, "adc5", 10),
+	SARADC_CHANNEL(6, "adc6", 10),
+	SARADC_CHANNEL(7, "adc7", 10),
+};
+
+static const struct rockchip_saradc_data rk3562_saradc_data = {
+	.channels = rockchip_rk3562_saradc_iio_channels,
+	.num_channels = ARRAY_SIZE(rockchip_rk3562_saradc_iio_channels),
+	.clk_rate = 1000000,
+	.start = rockchip_saradc_start_v2,
+	.read = rockchip_saradc_read_v2,
+};
+
 static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
 	SARADC_CHANNEL(0, "adc0", 10),
 	SARADC_CHANNEL(1, "adc1", 10),
@@ -324,6 +343,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
 	}, {
 		.compatible = "rockchip,rk3399-saradc",
 		.data = &rk3399_saradc_data,
+	}, {
+		.compatible = "rockchip,rk3562-saradc",
+		.data = &rk3562_saradc_data,
 	}, {
 		.compatible = "rockchip,rk3568-saradc",
 		.data = &rk3568_saradc_data,
-- 
2.25.1


