Return-Path: <linux-iio+bounces-16457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5FA5433C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C2918945DC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375A1DC9B1;
	Thu,  6 Mar 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LngcmC5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42121DB375;
	Thu,  6 Mar 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244756; cv=none; b=sU/ILHgstT/F2YyoiAzXYk9I5wLuVAh5ujSCvabOXAa+LNY5nJT13akC2eVJocs4qJ//95aHkvGrruWOv7AamXFxMydn5qNCsuutbCnqQdX4pz2lRicXZ1trqcSKUddrs5A62rbN20PlihuZ/2kVbJvusTVTMa+PJpqgAymv8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244756; c=relaxed/simple;
	bh=0pW/AzRF/RuX+cwE3R6LyUhFONr4bslHUHFeHtCPcU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFAQ3H5yTGeQohiYdOF8bIvHS8iFgO+WO3Jt6+G+fiZwfNMYvjrsQmC6qYb22ittcN7bAaT1T1qIR/rghT1hHRrURTOdJ8JdLEfj2vR/wh1SXKpZETN9V6gRjI9mlpfi8nh9fWAU7HoHxeEKZHLV+XqrVIZ9Puybgmblxkmngmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LngcmC5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D99C4CEED;
	Thu,  6 Mar 2025 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741244756;
	bh=0pW/AzRF/RuX+cwE3R6LyUhFONr4bslHUHFeHtCPcU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LngcmC5hlaMxZxKui39ZWm3OV7a8sOWHNSWyRPVrCBcU5tgJpETNKoILjc2V0v7Ft
	 B5ARU6Mq3XMQhSytdSe/GTY7/AAgHbFJ9ThhpJwws0kVBImfTYqL54bS6ZnEx2lAPs
	 NmYMDhSZmJFHtwbXfZo6DxyEvK/qeaJuJb2YQcjR2kTnIKSghdhUU3r0atc8q4c0Ju
	 D6QVS5goosTY45uzv0oW6QxlCxRCvWKSDbe2uJ5aWBTxHDeYbzeFbcAJz19OC6hvlo
	 bxz461xpxbEzGUNO+1/VgJe6qo7QTawxnlj/If1wFr9RTY3CW2eZ4cSlv+qkGhxyVy
	 Ouoyas0f4ld1w==
From: William Breathitt Gray <wbg@kernel.org>
Date: Thu, 06 Mar 2025 16:05:44 +0900
Subject: [PATCH 2/2] counter: microchip-tcb-capture: Add support for RC
 Compare
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-introduce-compare-component-v1-2-93993b3dca9c@kernel.org>
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
In-Reply-To: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
To: csokas.bence@prolan.hu, Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 William Breathitt Gray <wbg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155; i=wbg@kernel.org;
 h=from:subject:message-id; bh=0pW/AzRF/RuX+cwE3R6LyUhFONr4bslHUHFeHtCPcU8=;
 b=owGbwMvMwCW21SPs1D4hZW3G02pJDOknPQN+hHXN4+LN2LD/lehFfe9NrXdmsbyaqhYsbN4xL
 90pVNC6o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZiIvhDDH449rk1dhyMEJCZL
 Wz9msHgacf+Mt/CddxPzrnw//7RUNJnhf6Fr2Ra7ySGTe6PP/C6+9vOr06yGC2cSWqSZdBeVqnJ
 4MgMA
X-Developer-Key: i=wbg@kernel.org; a=openpgp;
 fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B

In Capture mode, the RC register serves as a compare register for the
Timer Counter Channel. When a the Counter Value reaches the RC value, a
RC Compare event occurs (COUNTER_EVENT_THRESHOLD). This patch exposes
the RC register to userspace as the 'compare' Count extension, thus
allowing users to configure the threshold condition for these events.

Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 drivers/counter/microchip-tcb-capture.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 2f096a5b973d18edf5de5a2b33f2f72571deefb7..e32f8d324cb373909e0a093b14d742fa0a93e07e 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -247,6 +247,37 @@ static int mchp_tc_count_read(struct counter_device *counter,
 	return 0;
 }
 
+static int mchp_tc_count_compare_read(struct counter_device *counter, struct counter_count *count,
+				      u64 *val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	u32 cnt;
+	int ret;
+
+	ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), &cnt);
+	if (ret < 0)
+		return ret;
+
+	*val = cnt;
+
+	return 0;
+}
+
+static int mchp_tc_count_compare_write(struct counter_device *counter, struct counter_count *count,
+				       u64 val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	return regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), val);
+}
+
+static struct counter_comp mchp_tc_count_ext[] = {
+	COUNTER_COMP_COMPARE(mchp_tc_count_compare_read, mchp_tc_count_compare_write),
+};
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -255,6 +286,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 

-- 
2.48.1


