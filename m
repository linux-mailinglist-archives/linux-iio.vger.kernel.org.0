Return-Path: <linux-iio+bounces-27857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31ED32A8A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DF2307A815
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A13939A4;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFbQOKcs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEED392C43;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573959; cv=none; b=XJSSfbTIyNODHdnXerCsEcHjFAxhryJRxEZ7DM3gfaTFTiU7a+rgJjmK+Z73084zoaHYRsoKWpYROsgoSK5ne0BycRloZUf04zCzv8tA8/dS3B3iCuuIVwcjVtNZUA2UjiF/M3IQSKz+NnLNhxRK8DRDWsmwlrnZygRBZD3djuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573959; c=relaxed/simple;
	bh=cydN38l100wMdf4/ArcxvU5f/tYHQl/0FrnHEEJfGEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPBKTWn7Bgbvz7APnAgMJc82BVeERJvjI/q9piTIjNjectzLITyDd+7QyLWRb2fAewEn/Fk2fAROtB1rfL97euxZyYlmKKXDR9dH/LEpJMNPbRDHe2TKk/elF+gdpG/W431KDzNPAZOm1SOi+DOpgu+SIbJw1UW9T9Zuw8gygjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFbQOKcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BED07C19423;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573958;
	bh=cydN38l100wMdf4/ArcxvU5f/tYHQl/0FrnHEEJfGEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EFbQOKcsnXeczKY4TGv5SJjluWiowx1tVcMG3rRLwJ4IWsa/0CjUI1LDv7xjctCTG
	 bZXvnKopsvGDvAoURiDxOEqE76ajG3wK+UhkS0BmJ9zF5qUycpVD/0xw/SdjHrBb1i
	 Fy22QWOFG4lKM+dIapFbOc/kURge7Hwj8to6xyeQXJS5Xsn6md8W1CIAH2UAQf4ILx
	 dtLDIfFmZDW42v2eG/MdoRjpcvgqKJ8ooSwlGg6ZNvUrovZrtCzgF6k1mmW9dbJRsw
	 HCyn6s9bxYUkKSHkThD4vMYux+dfZHIpQr4DjucZ/CV7r7IRDCZorI8HJd5RPKwbsk
	 BPHEC92snBNkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FBC982C5;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 16 Jan 2026 14:32:23 +0000
Subject: [PATCH v4 4/7] iio: frequency: adf41513: handle LE synchronization
 feature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-adf41513-iio-driver-v4-4-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
In-Reply-To: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=3002;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=aTmu0dNsrjGGz+g8LnBK4RH9b4yL9PK+xZvKjCBO1KI=;
 b=Zcv4qybX05ubOQ1hkxkENmnYLJJiaW0tQBuKw6cJ1hptgbrVBJtzznFWXpJOoCJ5C+O87l+hk
 tiK+FyeSbz/DoToEX/0grQJBnj0NrOcPYqAOn+H2w5dvA4oOQWoRae1
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
 drivers/iio/frequency/adf41513.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf41513.c
index 9068c427d8e9..dfbe55bb6973 100644
--- a/drivers/iio/frequency/adf41513.c
+++ b/drivers/iio/frequency/adf41513.c
@@ -220,6 +220,7 @@ struct adf41513_data {
 	bool phase_detector_polarity;
 
 	bool logic_lvl_1v8_en;
+	bool le_sync_en;
 };
 
 struct adf41513_pll_settings {
@@ -698,13 +699,27 @@ static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uhz, u16 s
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
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 
 static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
@@ -989,6 +1004,8 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 				     "invalid lock detect count: %u\n", tmp);
 	st->data.lock_detect_count = tmp;
 
+	/* load enable sync */
+	st->data.le_sync_en = device_property_read_bool(dev, "adi,le-sync-enable");
 	st->data.freq_resolution_uhz = MICROHZ_PER_HZ;
 
 	return 0;
@@ -996,6 +1013,7 @@ static int adf41513_parse_fw(struct adf41513_state *st)
 
 static int adf41513_setup(struct adf41513_state *st)
 {
+	int ret;
 	u32 tmp;
 
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
@@ -1029,8 +1047,19 @@ static int adf41513_setup(struct adf41513_state *st)
 					      st->data.logic_lvl_1v8_en ? 0 : 1);
 
 	/* perform initialization sequence with power-up frequency */
-	return adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICRO,
-				      ADF41513_SYNC_ALL);
+	ret = adf41513_set_frequency(st, st->data.power_up_frequency_hz * MICRO,
+				     ADF41513_SYNC_ALL);
+	if (ret)
+		return ret;
+
+	if (st->data.le_sync_en) {
+		st->regs[ADF41513_REG12] |= ADF41513_REG12_LE_SELECT_MSK;
+		ret = adf41513_sync_config(st, ADF41513_SYNC_DIFF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static void adf41513_power_down(void *data)

-- 
2.43.0



