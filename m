Return-Path: <linux-iio+bounces-27192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF7CCFE28
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95B23086EF7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BF346AFF;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BELDS1k+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D43469F8;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147694; cv=none; b=k3mx29GlS7/qXT4OEOWm8FxTHsOOEwux993ZPGIcvflORoVkrtb/7qTJcGxx5zC3bUcOzKA0mnOYRWBMXDy33VSik1KQRrWL4xbc/uDcXqWMYu11r81139eDsPKo2bmmEPQ6oVmyjulJ5UzO0Dx6GsIK0U/HKvtZfp+xNx2KF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147694; c=relaxed/simple;
	bh=044bwfkF749yFHa1PRIGicCKrFPRx+TiQlaSb9JRgGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiH4xwbcQFAnIJs5d8e86SwjsngEl5kDepCsE4QADWVdNHs/s9m+IWibxDQ+v/8dbsQs52XKaedVLZrCLAC2u6Kpl1yPPBH0ikKdVBodj8uNHJvkFabswqfrnUymHtdlJfZmeSCeLj3LzFCGYXN1qYQ5196smAAE0OkED6dggbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BELDS1k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D28CAC19424;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766147693;
	bh=044bwfkF749yFHa1PRIGicCKrFPRx+TiQlaSb9JRgGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BELDS1k+L1S6xtAHTaR6ijMwbHwbYci1tLGlsLYTOC5lrAwVyFPxTwNnRPFKG6Ljf
	 O9W4/4iwIO2peAIi5BWFRta6P7KcUL9A8Hr4Rg/H4GqJ8Aa9bmN0YWC3Y87mWWjjEV
	 0a9PEFbllNNMtpFh7ry9e35htrq5DPCP7GY1CBNlzqT89T0w9Xj+dl78MpdSxZbNRB
	 FLTV+vjGbFNdZFZ7EswTfHQvBQ0xR9i2p/8mXHfEpifjBEdBmpk24dsLD07XigQ21E
	 WtZNZvpEzFWql4vqUAJp3+o3ODC2q/jWqAPoBT4cGXATZSbxyaQ33ZFwh+XPsC16Rt
	 p1hMqHedpIvEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5859D78770;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 12:34:50 +0000
Subject: [PATCH v2 3/6] iio: frequency: adf41513: handle LE synchronization
 feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-adf41513-iio-driver-v2-3-be29a83d5793@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766147692; l=2931;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=wgMCwIQqcbvvMkSj7g6INNVLAWqZ7y9cuIbUbyJnIEY=;
 b=ir5pTrHpXGFUNzpVEkwfgvjyv7TCSP7emdwF4OFdeKHhuv5oBEA5iUGm0oGjDbRGTXrejlGHD
 qJl8dRBbgjnAPjemE9FmtjlXgXSQT9nMtRf6KRFD5Suql4h1oblOPzI
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
 drivers/iio/frequency/adf41513.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index a967dc4479e7..ecce4911b296 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -220,6 +220,7 @@ struct adf41513_data {
 
 	u8 muxout_select;
 	bool muxout_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -731,13 +732,25 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
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
@@ -1061,6 +1074,9 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 		st->data.lock_detect_count = tmp;
 	}
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
+
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -1068,6 +1084,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 
 static int adf41513_setup(struct adf41513_state *st)
 {
+	int ret;
 	u32 tmp;
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
@@ -1108,8 +1125,18 @@ static int adf41513_setup(struct adf41513_state *st)
 					       st->data.muxout_1v8_en ? 0 : 1);
 
 	/* perform initialization sequence with power-up frequency */
-	return adf41513_set_frequency(st, (u64)st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
-				      ADF41513_SYNC_ALL);
+	ret = adf41513_set_frequency(st,
+				     (u64)st->data.power_up_frequency_hz * MICROHZ_PER_HZ,
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



