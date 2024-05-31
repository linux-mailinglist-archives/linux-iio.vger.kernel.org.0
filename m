Return-Path: <linux-iio+bounces-5535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40ED8D5EA1
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490F1B215E4
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB46135A65;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHgh0c1y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE11369AA
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148523; cv=none; b=AA3+YpArF30OarxyJ+q9TTVkR8LMcuDwW/CuyMehwM/a1vUhFjjh76KXzVp6dC1futbcq2BBBNdA0dOM+XGgU2U03GV+7L5HOuWV+rCdoEWAK6CkYeYnLKbUkdQjLFAJWxm41PGAqzYBQCgDSQpJZNuFZftLWPgnckEvMIfcQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148523; c=relaxed/simple;
	bh=C/EdX4Ft3xnla24lIHNLbOUhNcgFzKzKAVKBwMX2Klk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YC78/zeU08xCLVXUVaT6OzNyY5pn/ml/UwpZru7VBtf5M/D2V6qJuRdyzioiBiaG4YOEUYwzkuYCcwiclkVTo6iTy+ZjK3/BKn85t6wjncUvUKUyGZE8SD8Of7CdiDIOkXZsKEPuu+mXf748PA71dx20/his8cCLVbIpgI3zmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHgh0c1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19BF2C32789;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148523;
	bh=C/EdX4Ft3xnla24lIHNLbOUhNcgFzKzKAVKBwMX2Klk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rHgh0c1yC0fQvPX9GaHsAk4Su2vo+9yPBuQ23qk9W9Hc5ZcSvnmeX4nbdxysPyXCy
	 xlB/hWjEMbnZ+iKOfE5KaDueyQXbsg/lqUhgES/uKT6kCedSAOnu2wG3BJDpGR03j8
	 /PNnzJUq3tKurEZcVr1ON+ErGAxcWVcwPSCM4D4gSLNKcSviAqlCDG24/UV9uRi2+B
	 uYeE5QWnquGIPKG9d4YOWwLu947CUfAMD707OdecS8TlYygLXfrAip0GokmSslcll3
	 AQFBVwX5F3HlnC8GKUrnLsLMmeNL7fUE9BdRzPUXAvGuEa85nd59qhOUqq91t8aX77
	 160mCg/WQ994A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF0C27C50;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 May 2024 11:41:55 +0200
Subject: [PATCH v3 2/2] iio: adc: adi-axi-adc: make sure DRP is locked on
 enable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dev-axi-adc-drp-v3-2-e3fa79447c67@analog.com>
References: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
In-Reply-To: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717148521; l=1911;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=l64Ix/Gmc9pXNSX5ow7dG1cblWhfc28+HdYcrglxFJY=;
 b=hMCFMda3YhtZYcw2dODuRVxdHZCcUSevZtz8HNchEqf8hO1ZbxczSAuR5oKDADY3ys7mi7IUp
 ESvMtrMRFt8CxeCW7zE7yfx4yaKEBcBQAZaToXKY3qzyH+1EOXZ0ote
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

When enabling the core, make sure DRP (Dynamic Reconfiguration Port)
is locked. Most of the designs don't really use it but we still get the
lock bit set. So let's do it all the time so the code is generic.

While at it reduce the timeout time to 1 microsecond as it seems to be
enough and goes in line with what we have on the similar DAC core
(adi-axi-dac).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index bf51d619ebbc..0f8bd1d75131 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -42,6 +42,9 @@
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
+#define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
+#define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
+
 /* ADC Channel controls */
 
 #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
@@ -83,6 +86,7 @@ struct adi_axi_adc_state {
 static int axi_adc_enable(struct iio_backend *back)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int __val;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -91,7 +95,17 @@ static int axi_adc_enable(struct iio_backend *back)
 	if (ret)
 		return ret;
 
-	fsleep(10000);
+	/*
+	 * Make sure the DRP (Dynamic Reconfiguration Port) is locked. Not all
+	 * designs really use it but if they don't we still get the lock bit
+	 * set. So let's do it all the time so the code is generic.
+	 */
+	ret = regmap_read_poll_timeout(st->regmap, ADI_AXI_ADC_REG_DRP_STATUS,
+				       __val, __val & ADI_AXI_ADC_DRP_LOCKED,
+				       100, 1000);
+	if (ret)
+		return ret;
+
 	return regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
 			       ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
 }

-- 
2.45.1



