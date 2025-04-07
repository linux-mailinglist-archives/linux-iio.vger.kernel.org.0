Return-Path: <linux-iio+bounces-17780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B986A7E9E0
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C76A7A5B48
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1C22E40A;
	Mon,  7 Apr 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKCY3oqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2722E41C;
	Mon,  7 Apr 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049554; cv=none; b=n5cB/N8JNE8t2Q5kfOiIAyw39Shx7dZs7K8mjVHLJyfn4tdN0MNbv5fVauUMT9Ko5A853M4iJM3JRzyWNNp/eQqym5d+xmDHB67LqcsMTkXeM/2SMI4jePIhEtZw3nzzbvQeNB4/uZWN18XJm61JnrNHoAOfTmiTQoEoNrdCF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049554; c=relaxed/simple;
	bh=jFFBVRz0A+XY+Du3+QPUET8NpjZaPsb5/J4ViO+lq0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6ieNmeoV+Zh3nFn1qC3QjTeqeNq+uscWA9ppzQhwLj+QRFuL0t6OoQOKr4c+QLs/xlH/avahJhkFyOHZx76luhdnIGHDMIfQ8YWiLiFGssLPlmGqGpmCtlpOy+gQb2z3gV4lpW+mROZyUatU/D8HE9KgGsB1kXy1R67Ss6GDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKCY3oqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2719C4CEE9;
	Mon,  7 Apr 2025 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049554;
	bh=jFFBVRz0A+XY+Du3+QPUET8NpjZaPsb5/J4ViO+lq0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKCY3oqrgakN5YKDQef+P27WhnW0Gfb4XuhH0b5zm1hd3r4F0pFvesxN08NPIb+pf
	 hF9UMZsVOrDFFQDR63YlOMzVTSIrS6lv33MPdaDocbLsFbR8XJcMgqAO1R1wkhy6//
	 ovsgWalQMsew+GdIsQgf4mSZo31NzaUOoFKQnioGd8likfClGv6xKYANPJA7vsNUri
	 4ooQb2iCffhsFtCAn4bpieM24sPeo8dKnUB3oInzwZ0sid5USA+vIZ8y66rF05EoX5
	 xIQR1ZuqO1TuGkzz8aBc2AKlWhVbWcrb2aUfOKCEPi1dhtkJWZ7MFPKMoSMh7zkB9S
	 M5M7Vr+BTrzTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 03/28] iio: adc: ad4695: make ad4695_exit_conversion_mode() more robust
Date: Mon,  7 Apr 2025 14:11:53 -0400
Message-Id: <20250407181224.3180941-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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
index 0146aed9069f8..4bc800293e607 100644
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


