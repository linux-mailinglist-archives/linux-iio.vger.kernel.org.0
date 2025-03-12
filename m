Return-Path: <linux-iio+bounces-16743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785FCA5D761
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 08:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7313B91E7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4E1F03FF;
	Wed, 12 Mar 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MKjocUGQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m15586.qiye.163.com (mail-m15586.qiye.163.com [101.71.155.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477251F03C5;
	Wed, 12 Mar 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764986; cv=none; b=NI1VscJmlTjHulKn/JWZka8WO2bfTevSRJZgo7DKqDgI8tqendCAYspb1zk3ZR7FO/p7ea8O3MBiYAeeXAOzK/WetISuT1sXqgyLS8cxfOh5ILxRF12IIvaqwVIC6uwwwKGjPadUZNI7u0Euy4smB4ocZUh+VMwrbZSnpAniT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764986; c=relaxed/simple;
	bh=M4loodvw08XWExl/OO2gkZzvlW+4IBmsYNS8q1SrjGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sljQ3t4H+7le+GqfXJ2YhaNY7tGi/gxurb0IqBM90MwIUsYM748Nn+v1Wx9n6TP6MJCPhWOpUXvLGKi0vLc1F0zl6ow5zxIvR20sXhrd71ghuv0La487+jCgF4K1OKQ53M+IpR2MdtbnlRPR7qRQLHS9F6+b4HBd+i5BtW5O9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MKjocUGQ; arc=none smtp.client-ip=101.71.155.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id dfe6f8d0;
	Wed, 12 Mar 2025 14:20:38 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Xue <xxm@rock-chips.com>
Subject: [PATCH] iio: adc: rockchip: Fix clock initialization sequence
Date: Wed, 12 Mar 2025 14:20:16 +0800
Message-Id: <20250312062016.137821-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkeT1ZNS0xPTx8ZTR9PQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9589031fa403ackunmdfe6f8d0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46HSo4MTJLTR4tHRMaFxkL
	Ai0wCytVSlVKTE9KTE1LT0hCSUpOVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQUpNS043Bg++
DKIM-Signature:a=rsa-sha256;
	b=MKjocUGQwhTcya7uy6KiltggFcjzV3Phkl397oA9r3ld7SCj3DgZJUuK7XTS5OQCkfNAa472trd9GRbCX4g+Kda82/uMUT2FPz5UWNMCOpQCCB9HZGu5ExIvmYdCH/NVrm+gaIbXHAims7r/TyU4Ji/kpo3QOBlLJ3GYw+uSlpc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vy+9eAm5AK9uncKvL50rH3d9NuCi+vykIYrh7yJCQns=;
	h=date:mime-version:subject:message-id:from;

clock_set_rate should be executed after devm_clk_get_enabled.

Fixes: 97ad10bb2901 ("iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled")
Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 drivers/iio/adc/rockchip_saradc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index a29e54754c8f..ab4de67fb135 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -480,15 +480,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (info->reset)
 		rockchip_saradc_reset_controller(info->reset);
 
-	/*
-	 * Use a default value for the converter clock.
-	 * This may become user-configurable in the future.
-	 */
-	ret = clk_set_rate(info->clk, info->data->clk_rate);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set adc clk rate\n");
-
 	ret = regulator_enable(info->vref);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
@@ -515,6 +506,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
+	/*
+	 * Use a default value for the converter clock.
+	 * This may become user-configurable in the future.
+	 */
+	ret = clk_set_rate(info->clk, info->data->clk_rate);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set adc clk rate\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.34.1


