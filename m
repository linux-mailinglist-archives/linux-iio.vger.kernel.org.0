Return-Path: <linux-iio+bounces-13774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5E9FBB5D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10121885973
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5B1AF4E9;
	Tue, 24 Dec 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SIs43kcI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m127100.qiye.163.com (mail-m127100.qiye.163.com [115.236.127.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B391EC0;
	Tue, 24 Dec 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033257; cv=none; b=H9kNlam18OljOENL1tyAliyR01DlvbV8x8edB896eHWmsaE66fEyLdR/8hpvxWGmRXPpoGws+Ip/8IXufjPpmAuScYjnEUWq1c8bGDPnmAWbzMLSbWCXgMsaRe7Bw8jT03QVHFfOYjF21vEZM5oNp2GypxpdlsGhqm/D1PdFkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033257; c=relaxed/simple;
	bh=D4H5ioGi8SvHHqPHO3sUY5c4YpfW/IZ/TXfcp5B9zwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkK6TqZEeVCs9k+07Hepb6TRwQcr6kyVsZuvzRh2HAnOSy17N8l/U8B30ahPqsphBfYePgJwGRkj3XgSBhenzaVRF4CPtBCOPcBYvarZePpvjW2RI9PGoMaE7TbB9UfQBVBW8x1KJbb5iA0bsf3LRCXMB1QrGn4V3MYltCZppsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SIs43kcI; arc=none smtp.client-ip=115.236.127.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aa905c9;
	Tue, 24 Dec 2024 17:40:45 +0800 (GMT+08:00)
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
Subject: [PATCH 2/2] iio: adc: rockchip_saradc: add rk3562
Date: Tue, 24 Dec 2024 17:40:42 +0800
Message-Id: <20241224094042.3816483-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094042.3816483-1-kever.yang@rock-chips.com>
References: <20241224094042.3816483-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpCSlZMQ04dSRoaGBkdQklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f80a4f9d03afkunm6aa905c9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6SAw6MDIPDEo9LDosMQxD
	SwkKCxVVSlVKTEhOS0hISU9NTUlNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0NLNwY+
DKIM-Signature:a=rsa-sha256;
	b=SIs43kcIBQ30JV3HyXMPTAWyOMs6KfJjb+mkdOCVarF0/E8XQiVPn6gccY36DEBc+mLUjzEqQP6U+A5yZfWXJwj7iPh8TzLlX8kvcg6XYYO3yMX8Bnlsh/mUlAtqO8osdzALlliB1jwaMoY/0Dgv8atw0OMs1DQZCcq575C5hsU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PWTpV5unBG06xQWRz5c8PNc7qqWDa9gYmL9khDtzsDU=;
	h=date:mime-version:subject:message-id:from;

From: Simon Xue <xxm@rock-chips.com>

rk3562 is using v2 saradc with 8 channels.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/iio/adc/rockchip_saradc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 240cfa391674..7c8a9d37d245 100644
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


