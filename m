Return-Path: <linux-iio+bounces-17779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8152A7E9AE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D3E1885CF7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BAF25484D;
	Mon,  7 Apr 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ5rDa+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F723253F39;
	Mon,  7 Apr 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049477; cv=none; b=Jquv3oVMB9bf45OJPB3kUEOkqMfDfMca+23vHNcYyCoNs7wOLPbsLaCLeeuOU6hP+8brrCjbFY/kQa4zQyM34Vzm7tKdqWy1OYiijQz4RTFh3nhOQjmFc6+coSb9FDXevGgcz/7F1s4JMwoiyMKLtbf+1DN8i0QJbifWcb+9TnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049477; c=relaxed/simple;
	bh=FISAyBR5YvzGFK2R7eKxbUgEIuJ2Z8jtRUE0UFX7vLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAws1pE3g6eV+xEYewVi/A2bZ71ORiAXvTJ72kfH7c9T/5gFENhviQcPTCzTlkQXSNcJkA7jW+u4bfoDOKGj8NvTma8zzi2mZgmqmXcijunBgyQYVbrO5vykYgge9un+R0vNQ5ogsuds3EQme7bE1lzrRTM1m6sUU4gJjwbpaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ5rDa+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F81C4CEDD;
	Mon,  7 Apr 2025 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049476;
	bh=FISAyBR5YvzGFK2R7eKxbUgEIuJ2Z8jtRUE0UFX7vLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZ5rDa+BlxdtXNXwFPddUwMkerJ9GI2QA5ujvYb2pboEOTZdmE6t91hG/VkDrNEv5
	 YnJDfDOeTY8yKMELYxpLA8qv8LmLEbCzCIWKbJ38PM+M75ryeCWSDNyZhM0nKXhY7n
	 oj5BZVxBvTT/zXXKQoL4+vyHRIQ0Ib3HacdYq7FA1HyBZWNFNg5PcyIFAaLCk2Zjj7
	 14vHenmzB/fN9vr/p3WFLlrk/UZ8BS4t5voJmhY6xYRl4o2+nLtRidUE+ZMLtXmPPi
	 twkhWPAVaBMIRCQtfqPL0YiUy9ByjBra6+bFUYyqVjkW0ptbVQs7PbJTav4grTgxoh
	 8kfxlydtElU9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 05/31] iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
Date: Mon,  7 Apr 2025 14:10:21 -0400
Message-Id: <20250407181054.3177479-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Trevor Gamblin <tgamblin@baylibre.com>

[ Upstream commit 998d20e4e99d909f14d96fdf0bdcf860f7efe3ef ]

Ensure that conversion mode is successfully exited when the command is
issued by adding an extra transfer beforehand, matching the minimum CNV
high and low times from the AD4695 datasheet. The AD4695 has a quirk
where the exit command only works during a conversion, so guarantee this
happens by triggering a conversion in ad4695_exit_conversion_mode().
Then make this even more robust by ensuring that the exit command is run
at AD4695_REG_ACCESS_SCLK_HZ rather than the bus maximum.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20241113-tgamblin-ad4695_improvements-v2-2-b6bb7c758fc4@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad4695.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index b79d135a54718..22fdc454b0cea 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -92,6 +92,8 @@
 #define AD4695_T_REFBUF_MS		100
 #define AD4695_T_REGCONFIG_NS		20
 #define AD4695_T_SCK_CNV_DELAY_NS	80
+#define AD4695_T_CNVL_NS		80
+#define AD4695_T_CNVH_NS		10
 #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
 
 /* Max number of voltage input channels. */
@@ -364,11 +366,31 @@ static int ad4695_enter_advanced_sequencer_mode(struct ad4695_state *st, u32 n)
  */
 static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 {
-	struct spi_transfer xfer = {
-		.tx_buf = &st->cnv_cmd2,
-		.len = 1,
-		.delay.value = AD4695_T_REGCONFIG_NS,
-		.delay.unit = SPI_DELAY_UNIT_NSECS,
+	/*
+	 * An extra transfer is needed to trigger a conversion here so
+	 * that we can be 100% sure the command will be processed by the
+	 * ADC, rather than relying on it to be in the correct state
+	 * when this function is called (this chip has a quirk where the
+	 * command only works when reading a conversion, and if the
+	 * previous conversion was already read then it won't work). The
+	 * actual conversion command is then run at the slower
+	 * AD4695_REG_ACCESS_SCLK_HZ speed to guarantee this works.
+	 */
+	struct spi_transfer xfers[] = {
+		{
+			.delay.value = AD4695_T_CNVL_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+			.cs_change = 1,
+			.cs_change_delay.value = AD4695_T_CNVH_NS,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.tx_buf = &st->cnv_cmd2,
+			.len = 1,
+			.delay.value = AD4695_T_REGCONFIG_NS,
+			.delay.unit = SPI_DELAY_UNIT_NSECS,
+		},
 	};
 
 	/*
@@ -377,7 +399,7 @@ static int ad4695_exit_conversion_mode(struct ad4695_state *st)
 	 */
 	st->cnv_cmd2 = AD4695_CMD_EXIT_CNV_MODE << 3;
 
-	return spi_sync_transfer(st->spi, &xfer, 1);
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
-- 
2.39.5


