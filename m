Return-Path: <linux-iio+bounces-27540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D16D03986
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5A03257875
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D34A417F;
	Thu,  8 Jan 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkXzmfKF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FF4A1A7D;
	Thu,  8 Jan 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874517; cv=none; b=Mgv+7qT/MetqkymfCmSDQ0+2MupBeL0TX6Dn4yonNWBijphfpKtuEUD1mq363MVvC4ikhtu3nfLOCXSetLmTAjiKrUcvJaUv1GEDv/ccg6tfuFG2zgxDNxRWgnQdNtlJxbSlfXEbPMzrHzuyLpmKG/7azs8gW0EEG7xnQBFnBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874517; c=relaxed/simple;
	bh=d+AUQ+0Q0G7xnUBpM4myxGc7BPezAhRHEHHX4yBWl6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCDAREF+IdZ8zTGIgntgDCkqOdOU991rvTcjRmGn+kONZiAfTKOteECFK9wiSSKiLrCd2q6fKQHi17BrNJ1iOnPZcclAn/t63vvSzHjThIBO24iyj5qqIRVnu7F2x4dkLz+C295KsffQQLgtKYEjsgX/qTtXCFVsjpBm7O1V8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkXzmfKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5264DC19424;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874515;
	bh=d+AUQ+0Q0G7xnUBpM4myxGc7BPezAhRHEHHX4yBWl6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KkXzmfKFx0WXPrZ0YnCwyvOmjtkAZy5e84sSn6pRvt9Ewd6u0u6m3K10p+hhHOx/v
	 tT5oX64jadziVPozT2YHyTd1KJ92/KXY8SVhdP3ksKLxg6M+niwV/v4ziZOEuYNwWg
	 Gb5hROkHxjeaAj6iidLQtkq1daCq/mCY1ts+JsI2XINWH1+X4lUmq7z9142haD9mpj
	 X/s734CFsrWvXd9yhjQ9iz85EYIbJPK8rHQlKse58PAtvUQlVU888Zi1tKLjGeo5hM
	 exBbAtKxoYNXsRtLhf+8flHi8neiHS5zoHAffBTCuWHdpJCdVx+UoCUPeT6DeFxrG+
	 JjfYWsezGwAJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE5D185E7;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 08 Jan 2026 12:14:52 +0000
Subject: [PATCH v3 3/6] iio: frequency: adf41513: handle LE synchronization
 feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-adf41513-iio-driver-v3-3-23d1371aef48@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767874513; l=2933;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=X9/n4zTkaJgPCbGxxfeWNVQxYgRQ+AOLCLzn3Kd+1lY=;
 b=M9/lJEnRdexE2rLI5Z5cDbipXXX0TqcrPlQoA7EnXZJ05UYVJBYVtmi3lFqeJhmglc4JTmqKP
 TLwxh4na/e/ABporUU3NF4DSnkInPtizdOs7vh+2d8jTBFKb9zPxtjK
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

When LE sync is enabled, it is must be set after powering up and must be
disabled when powering down. It is recommended when using the PLL as
a frequency synthesizer, where reference signal will always be present
while the device is being configured.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/adf41513.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 69dcbbc1f393..0cdf24989c93 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -220,6 +220,7 @@ struct adf41513_data {
 	bool phase_detector_polarity;
 
 	bool logic_lvl_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -697,13 +698,25 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
 static int adf41513_suspend(struct adf41513_state *st)
 {
 	st->regs[ADF41513_REG6] |= FIELD_PREP(ADF41513_REG6_POWER_DOWN_MSK, 1);
+	st->regs[ADF41513_REG12] &= ~ADF41513_REG12_LE_SELECT_MSK;
 	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
 }
 
 static int adf41513_resume(struct adf41513_state *st)
 {
+	int ret;
+
 	st->regs[ADF41513_REG6] &= ~ADF41513_REG6_POWER_DOWN_MSK;
-	return adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	if (ret < 0)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	}
+
+	return ret;
 }
 
 static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
@@ -994,6 +1007,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 		st->data.lock_detect_count = tmp;
 	}
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -1001,6 +1016,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 
 static int adf41513_setup(struct adf41513_state *st)
 {
+	int ret;
 	u32 tmp;
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
@@ -1034,8 +1050,18 @@ static int adf41513_setup(struct adf41513_state *st)
 					      st->data.logic_lvl_1v8_en ? 0 : 1);
 
 	/* perform initialization sequence with power-up frequency */
-	return adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
-				      ADF41513_SYNC_ALL);
+	ret = adf41513_set_frequency(st,
+				     st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
+				     ADF41513_SYNC_ALL);
+	if (ret < 0)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+	}
+
+	return ret;
 }
 
 static void adf41513_power_down(void *data)

-- 
2.43.0



