Return-Path: <linux-iio+bounces-27542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260BD038C2
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D86431BB494
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D84A5729;
	Thu,  8 Jan 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBiiHRm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3548707A;
	Thu,  8 Jan 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874517; cv=none; b=Liy2sA8OXLx2QJewagyvNM4LJA1NRhFxFxCRVdN2sHh81vBGnhPQmLbjw0bOxImaOxAtPmzpEwoUUy2kAtMVywGUW2SSm0On8tGRTT34NTrfy8s6vfle9QuoDCATC0QOmCYpI2MNkLmMAZrHwDhYpNy8GfLU3AmHXiI+wkviBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874517; c=relaxed/simple;
	bh=FRu8BScto0P3wia7SaGcoWc/g7iS2VAzdGOucLD61BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8cG6aGUhJNIwB+fQ/q/qbq2bxEQcibMwuKKJUWSQb0adQmsrZuxFYY3RnmwhTQYZhQ/cwHu2f9CLuxn8Vjysr7dIBGV1fr3TrVbkDv7a9cYK7cAXMx/kkTGW1hiuZotyJkJjUtxyxPFlN23e7RLCsLTKYzLxkiXfuPiqxoBZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBiiHRm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6129CC2BCB0;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874515;
	bh=FRu8BScto0P3wia7SaGcoWc/g7iS2VAzdGOucLD61BU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FBiiHRm/M0Mc2Q37rSeZTCzGzTUlzLv3oiX30ULw2B15qFJQ5QxOtrROfn7tVFdbb
	 hW+8rzRnFojgYyPrcW1BCDZ2GKHgWahkxnGmoDFdQcYWAXikEh/DOFlsrYX7U4v706
	 jt7dsVYeHBAAeUj7q/S6IGbylZBfVIe4ji/GwxXs6bg+juVw7g0j6OutRwvDVd2DUf
	 KlOnyR29ZbQBz+aUZ2z5DicfAG2QlZWC01HEGLcHXfUYIUh0Gj2UFA1ZTq4ttAbU4P
	 G1xnXlBBQLVRKGOWkMYdpCZAN8ReA+hGdSaUL1/i1jPLaGApZLw3WSd33M2YrSTnyz
	 NOeH5HZtWTIpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFAD185EB;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 08 Jan 2026 12:14:53 +0000
Subject: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
In-Reply-To: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767874513; l=5432;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=UMWuvBM+9pvQjYkP22YDroVjp7uL8qCp5KLHrroiJPQ=;
 b=h0iUgA5GW8Vpok1nte3674p/djQLTuAGgF1KCsEysE8rQXnUFOIImprsLQG4FAWdKG74OTVYc
 96DjNK0sjjlB0gst6kXE6/KNbp8UWEZnL7eZLXMJ+wJp0ea47CVWaNH
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
 drivers/iio/frequency/adf41513.c | 99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 0cdf24989c93..c838e219ca22 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -211,6 +211,7 @@ struct adf41513_chip_info {
 struct adf41513_data {
 	u64 power_up_frequency_hz;
 	u64 freq_resolution_uhz;
+	u32 phase_resync_period_ns;
 	u32 charge_pump_voltage_mv;
 	u32 lock_detect_count;
 
@@ -275,6 +276,16 @@ struct adf41513_state {
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
 static const char * const adf41513_power_supplies[] = {
 	"avdd1", "avdd2", "avdd3", "avdd4", "avdd5", "vp"
 };
@@ -641,9 +652,82 @@ static int adf41513_calc_pll_settings(struct adf41513_state *st,
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
+	FIELD_MODIFY(ADF41513_REG6_BLEED_CURRENT_MSK, &st->regs[ADF41513_REG6],
+		     bleed_value);
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
+	FIELD_MODIFY(ADF41513_REG6_LDP_MSK, &st->regs[ADF41513_REG6], ldp);
+	FIELD_MODIFY(ADF41513_REG9_LD_BIAS_MSK, &st->regs[ADF41513_REG9], ld_bias);
+}
+
+static void adf41513_set_phase_resync(struct adf41513_state *st)
+{
+	u32 total_div, clk1_div, clk2_div;
+
+	if (!st->data.phase_resync_period_ns)
+		return;
+
+	/* assuming both clock dividers hold similar values */
+	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
+					st->data.phase_resync_period_ns,
+					1ULL * MICRO * NANO);
+	clk1_div = clamp(int_sqrt(total_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+	clk2_div = clamp(DIV_ROUND_CLOSEST(total_div, clk1_div), 1,
+			 ADF41513_MAX_CLK_DIVIDER);
+
+	FIELD_MODIFY(ADF41513_REG5_CLK1_DIV_MSK, &st->regs[ADF41513_REG5],
+		     clk1_div);
+	FIELD_MODIFY(ADF41513_REG7_CLK2_DIV_MSK, &st->regs[ADF41513_REG7],
+		     clk2_div);
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
 
 	ret = adf41513_calc_pll_settings(st, &result, freq_uhz);
@@ -651,6 +735,8 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 		return ret;
 
 	/* apply computed results to pll settings */
+	pfd_change = st->settings.pfd_frequency_uhz != result.pfd_frequency_uhz;
+	mode_change = st->settings.mode != result.mode;
 	memcpy(&st->settings, &result, sizeof(st->settings));
 
 	dev_dbg(&st->spi->dev,
@@ -692,6 +778,14 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
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
 
@@ -995,6 +1089,11 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 	st->data.phase_detector_polarity =
 		device_property_read_bool(dev, "adi,phase-detector-polarity-positive-enable");
 
+	st->data.phase_resync_period_ns = 0;
+	ret = device_property_read_u32(dev, "adi,phase-resync-period-ns", &tmp);
+	if (!ret)
+		st->data.phase_resync_period_ns = tmp;
+
 	st->data.logic_lvl_1v8_en = device_property_read_bool(dev, "adi,logic-level-1v8-enable");
 
 	st->data.lock_detect_count = ADF41513_LD_COUNT_MIN;

-- 
2.43.0



