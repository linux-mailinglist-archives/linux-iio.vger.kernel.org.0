Return-Path: <linux-iio+bounces-23363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC8B3B9E9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EB7A21AB1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0E308F1B;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVTavmo4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51E288CA3
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466721; cv=none; b=ZfxBdhl49NyLThrFm26iaPNsmq/wN77Di8RmVrQGNo5fv8haMV6EokZIIy64RZIxpwY7bUKRqOcPdBEOwXprLF6qF+dcM8LUxCrF0PtT831LQeHQe6fCdcEyUG+zGMFOGQFOn3ioWWyf7MaOJ5r8wEaiIzneRLY9V3ECSnjnJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466721; c=relaxed/simple;
	bh=XPdYg5r7Ft6i3S0kGOKRa/n0Sz74CTL7XxYiU+nvITs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSi7jszHp5k5yV975uG9CeO7Ag81lpm1XHZSoJqmhczM8fUaIxi0hSn5XkxZqBuwQRgENG1a5NusN2S49BgQyQ9b62z61H+7BqIA2/WYDhqCEP6V+cv0m2eJvH0VVcWczogAKPTrxQoGeb3YWPlurJ47G41P/nySHpiyTUtfRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVTavmo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B9FBC4CEF5;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466721;
	bh=XPdYg5r7Ft6i3S0kGOKRa/n0Sz74CTL7XxYiU+nvITs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OVTavmo4eV2PtIXCOOu3IKqgj6XZYIGzVBg+mhPRBI3zAUcZTGuUagBSCYQuEPyzz
	 N94+HenAO6BnG6gbIRc2Cm3dOu5SH5lxmmwVmpdvkyyZB3GKKBhpd/cv9yA/P4WLBC
	 bYukIrZiLD+kxiRHwcGPe2k0t1noHjQFcfDzkMluybD2SszcLfXIBs1zPHBPA6PEys
	 Sr/CL2a9oUEgKeKqr7ebhRnXWxbrVZ8XXpuqwK0IO6F2HBicSeV58+setYV/4c2iTr
	 UX786FW2rC6t/eF8466FcEw4LSI0o1l/MmYJaNfhDXuJ4NGsmOJyubJq6L0dyuC9wd
	 7haWer43YZv0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24672CA1000;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 29 Aug 2025 12:25:42 +0100
Subject: [PATCH v2 1/2] iio: frequency: adf4350: Fix prescaler usage.
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com>
References: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
In-Reply-To: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756466743; l=2195;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aMJzC/7d5wR2yx1FO++7MdGnn2KNaY1jHKU5JDOOJyE=;
 b=eRQ6Ax3bs+bUH6WMAN3JdW7NRZ8cR0ae/j1YRb1CueBtcwceeEG6olQHa29jxikxQFPzJJGZ9
 H0+rfuvlq09BH67gSRK7g8WLIAUyTP9twZi28MBRCfm6rq/GCk8xHfk
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
When set to 4/5, the maximum RF frequency allowed is 3 GHz.
Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
In this context not the RF output frequency is meant
- it's the VCO frequency.

Therefore move the prescaler selection after we derived the VCO frequency
from the desired RF output frequency.

This BUG may have caused PLL lock instabilities when operating the VCO at
the very high range close to 4.4 GHz.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---
v2:
 * Added fixes tag;
 * Added TODO (suggested by Andy).
---
 drivers/iio/frequency/adf4350.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 47f1c7e9efa9f425a4c7cf82be930234e2c18434..475a7a653bfb52174a258662dcb64c9727f0897c 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -149,6 +149,19 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
+	st->r4_rf_div_sel = 0;
+
+	/*
+	 * !\TODO: The below computation is making sure we get a power of 2
+	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
+	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
+	 * and friends.
+	 */
+	while (freq < ADF4350_MIN_VCO_FREQ) {
+		freq <<= 1;
+		st->r4_rf_div_sel++;
+	}
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
@@ -157,13 +170,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 		mdiv = 23;
 	}
 
-	st->r4_rf_div_sel = 0;
-
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
-
 	/*
 	 * Allow a predefined reference division factor
 	 * if not set, compute our own

-- 
2.51.0



