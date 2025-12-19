Return-Path: <linux-iio+bounces-27193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667FCCFF4F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 798283062ED5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041A346E42;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXQXTqlW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F5346A06;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147694; cv=none; b=WvBpCEZDYkO6pVaYb9PzwcHL4D60mmCSB2YUkWdw3PP7N+hEij6ApcS1MoNt9raK93lSdKsI2EQimyWdMd27koOb2gthAuAiDAuRPRV8pCEfhG6vaAO7tpz8MqmnaGBrtBDYh77v6slcl72vNevdQ+SrsBzonSPlWZnP1bsDxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147694; c=relaxed/simple;
	bh=NRkbDz5jdlm/9cZwyRoTJvULQO21vWaLSeFpS9uCCws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lb4X7AXlStKYJDZC5CH3gRuiot69zPWY16s+HDCp2im9K1QMvHgfWALXRfPs6wLMksKVZfLcM+P00XmP9RFPXv3F/L1elYg2jlkgKv28UFdkLLtEDAjs5axITd0Fw2TAW7u31V51ZwG6g4Z7/WTv5m/cUSGlAtyEgE9ucRWJ6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXQXTqlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0BB0C4AF12;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766147693;
	bh=NRkbDz5jdlm/9cZwyRoTJvULQO21vWaLSeFpS9uCCws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nXQXTqlW3wVoZaXifZJJh0ccZ94CAamRgf1h9fM/uybepwLRXG35Qoxi7lompaKh7
	 r9FXkR9jmHG0GTF699PEvfQIqG1SFsEPvP1+rEPhINNWn+9NINLz6WmeogNK+cnfnj
	 5rpLbi3QsjXfV7I/pZji0PZRSYb8wsPOV3IiJf9xaONo0+ogGYYQRO+7IB86Pyp9Kp
	 0RJDQXG0+Zd0pAnbjG8IG6dk0h3Qpmpv52/lzb72dmVs1YHz1WqviZbsunhAmr3uGR
	 FqKL4bH6HOLXwuLtV4LCXiX8tYO2UKWk6FXyGZeZNjuA7z+EQzdYfD1GPMr4+raWB7
	 vn/C+muGTqmwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F8D767FF;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 12:34:51 +0000
Subject: [PATCH v2 4/6] iio: frequency: adf41513: features on frequency
 change
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-adf41513-iio-driver-v2-4-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
In-Reply-To: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766147692; l=5714;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=/iWga4dZqYjBW1aAP89h2qj+gqfSSvakkGi5qedGsM0=;
 b=84GVtoHcFrIfChlEI/GNH0N09Kintj1eQJ+HGszES2BEJBc2dRJ2E8+GPLV5ZnOcxWWBXWoX5
 13+HPZylvvXB1+j5XYGyDQUPDzY6QZVsNHUzYh5se4rvTkJL0vpPo+j
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Set Bleed current when PFD frequency changes (bleed enabled when in
fractional mode). Set lock detector window size, handling bias and
precision. Add phase resync support, setting clock dividers when
PFD frequency changes.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index ecce4911b296..91d29baec3e8 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -210,6 +210,7 @@ struct adf41513_chip_info {
 struct adf41513_data {
 	u64 power_up_frequency_hz;
 	u64 freq_resolution_uhz;
+	u32 phase_resync_period_ns;
 	u32 charge_pump_voltage_mv;
 	u32 lock_detect_count;
 
@@ -276,6 +277,16 @@ struct adf41513_state {
 	__be32 buf __aligned(IIO_DMA_MINALIGN);
 };
 
+static const u16 adf41513_ld_window_p1ns[] = {
+	9, 12, 16, 17, 21, 28, 29, 35,			/* 0 - 7 */
+	43, 47, 49, 52, 70, 79, 115			/* 8 - 14 */
+};
+
+static const u8 adf41513_ldp_bias[] = {
+	0xC, 0xD, 0xE, 0x8, 0x9, 0x4, 0xA, 0x5,		/* 0 - 7 */
+	0x0, 0x6, 0xB, 0x1, 0x2, 0x7, 0x3		/* 8 - 14 */
+};
+
 static const char * const adf41513_muxout_modes[] = {
 	[ADF41513_MUXOUT_TRISTATE] = "high_z",
 	[ADF41513_MUXOUT_DVDD] = "muxout_high",
@@ -664,9 +675,85 @@ static int adf41513_calc_pll_settings(struct adf41513_state *st,
 	return 0;
 }
 
+static void adf41513_set_bleed_val(struct adf41513_state *st)
+{
+	u32 bleed_value;
+
+	if (st->data.phase_detector_polarity)
+		bleed_value = 90;
+	else
+		bleed_value = 144;
+
+	bleed_value *= 1 + FIELD_GET(ADF41513_REG5_CP_CURRENT_MSK,
+				     st->regs[ADF41513_REG5]);
+	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
+				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);
+
+	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_BLEED_CURRENT_MSK;
+	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_BLEED_CURRENT_MSK,
+					      bleed_value);
+}
+
+static void adf41513_set_ld_window(struct adf41513_state *st)
+{
+	/*
+	 * The ideal lock detector window size is halfway between the max
+	 * window, set by the phase comparison period t_PFD = (1 / f_PFD),
+	 * and the minimum is set by (I_BLEED/I_CP) × t_PFD
+	 */
+	u16 ld_window_p1ns = div64_u64(10ULL * NANO * MICROHZ_PER_HZ,
+				       st->settings.pfd_frequency_uhz << 1);
+	u8 ld_idx, ldp, ld_bias;
+
+	if (st->settings.mode != ADF41513_MODE_INTEGER_N) {
+		/* account for bleed current (deduced from eq.6 and eq.7) */
+		if (st->data.phase_detector_polarity)
+			ld_window_p1ns += 4;
+		else
+			ld_window_p1ns += 6;
+	}
+
+	ld_idx = find_closest(ld_window_p1ns, adf41513_ld_window_p1ns,
+			      ARRAY_SIZE(adf41513_ld_window_p1ns));
+	ldp = (adf41513_ldp_bias[ld_idx] >> 2) & 0x3;
+	ld_bias = adf41513_ldp_bias[ld_idx] & 0x3;
+
+	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_LDP_MSK;
+	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_LDP_MSK, ldp);
+	st->regs[ADF41513_REG9] &= ~ADF41513_REG9_LD_BIAS_MSK;
+	st->regs[ADF41513_REG9] |= FIELD_PREP(ADF41513_REG9_LD_BIAS_MSK, ld_bias);
+}
+
+static void adf41513_set_phase_resync(struct adf41513_state *st)
+{
+	u32 total_div, clk1_div, clk2_div;
+
+	if (!st->data.phase_resync_period_ns)
+		return;
+
+	/* Assuming both clock dividers hold similar values */
+	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
+					st->data.phase_resync_period_ns,
+					1ULL * MICRO * NANO);
+	clk1_div = clamp(int_sqrt(total_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+	clk2_div = clamp(DIV_ROUND_CLOSEST(total_div, clk1_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+
+	st->regs[ADF41513_REG5] &= ~ADF41513_REG5_CLK1_DIV_MSK;
+	st->regs[ADF41513_REG5] |= FIELD_PREP(ADF41513_REG5_CLK1_DIV_MSK, clk1_div);
+	st->regs[ADF41513_REG7] &= ~ADF41513_REG7_CLK2_DIV_MSK;
+	st->regs[ADF41513_REG7] |= FIELD_PREP(ADF41513_REG7_CLK2_DIV_MSK, clk2_div);
+
+	/* enable phase resync */
+	st->regs[ADF41513_REG7] |= ADF41513_REG7_CLK_DIV_MODE_MSK;
+}
+
 static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 sync_mask)
 {
 	struct adf41513_pll_settings result;
+	bool pfd_change = false;
+	bool mode_change = false;
 	int ret;
 
 	/* calculate pll settings candidate */
@@ -675,6 +762,8 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 		return ret;
 
 	/* apply computed results to pll settings */
+	pfd_change = st->settings.pfd_frequency_uhz != result.pfd_frequency_uhz;
+	mode_change = st->settings.mode != result.mode;
 	memcpy(&st->settings, &result, sizeof(struct adf41513_pll_settings));
 
 	dev_dbg(&st->spi->dev,
@@ -726,6 +815,14 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 		st->regs[ADF41513_REG6] |= ADF41513_REG6_BLEED_ENABLE_MSK;
 	}
 
+	if (pfd_change) {
+		adf41513_set_bleed_val(st);
+		adf41513_set_phase_resync(st);
+	}
+
+	if (pfd_change || mode_change)
+		adf41513_set_ld_window(st);
+
 	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
 }
 
@@ -1061,6 +1158,11 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 						    ARRAY_SIZE(adf41513_muxout_modes));
 	st->data.muxout_select = ret >= 0 ? ret : ADF41513_MUXOUT_TRISTATE;
 
+	st->data.phase_resync_period_ns = 0;
+	ret = device_property_read_u32(dev, "adi,phase-resync-period-ns", &tmp);
+	if (!ret)
+		st->data.phase_resync_period_ns = tmp;
+
 	/* muxout logic level: default 3v3 */
 	st->data.muxout_1v8_en = device_property_read_bool(dev, "adi,muxout-level-1v8-enable");
 

-- 
2.43.0



