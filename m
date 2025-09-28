Return-Path: <linux-iio+bounces-24534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224B3BA7554
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CBA16210B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F791F5820;
	Sun, 28 Sep 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="YGnS9teN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A601E1E19
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080453; cv=none; b=owYXHNgB3kvacxlfMU/UefJ1hphp/EcIMDSBqa9BD1oztzdapu/rzp0600wbmYEpyOqqNNIfFH+CmhHRPF7iwVeQyafHH+45KA5YXIsZKr6ZTdWB75U7gtNG6VhVAtjsQN8E2wzEW88+U+ymxv+OAs/GPChi7eYEn790U0gs1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080453; c=relaxed/simple;
	bh=Ht5SyqCV5h+ZFJ7EoAf0iNfdKg/MVrsDgz9zUPELKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5161JzYrWmAek4Vci5ui4IazJmKrNJ7FSa756yph+wJn30tIAAdQmeCDd+/nsyXiMZykRNCEV0CP+f3ZHKzKKDfm/J9v9nRnk2szPBAXDoa3kV4L9lVQaVo4wJNggOJ4ziTxw6h7ANxrO6tADNB9QaEPNKb1d4u2WMNa4HBxQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=YGnS9teN; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id F393C240CFE;
	Sun, 28 Sep 2025 19:27:22 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 6057224084B;
	Sun, 28 Sep 2025 19:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP9UQhsnoga4GjBwoF8bFsDJ58TkJyIH+2s7xYNRbTI=;
	b=YGnS9teN2G3r6RNpzuvVI7df8GchC6SOk2gyClC5pj/v7/knmhPADhsePlUAbkPLArRABO
	h1s9R8Lib51NC08SPUPV+yuMKujiXQNmpely9tU190Ca5uScViLVxzFBtk4396gLcc+tnQ
	hCzbep81YSuaMcqe6g9ANLY4AJWPlmy0QbpVzXaV+XrVnfBPljEJR0+auHX6pxkKs4sKoz
	CROq7qBJatHYjTGiKVEUx+o1ZQZWp2daCRJElh1TfWzqB9+8r1Q3AWedA1h31dV8B5n5aN
	8fYSNgLdWA/DWIOyGFRjFPIdafPAMqMBpP9iHqLxBvnRGr13tEQ05w5sCAcXzA==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 215FC240477;
	Sun, 28 Sep 2025 19:27:21 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 9/9] iio: pressure: bmp280: test longer autosuspend (WIP)
Date: Sun, 28 Sep 2025 19:26:37 +0200
Message-ID: <20250928172637.37138-11-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 306fff
X-Rspamd-UID: 08ba7d

Autosuspend delay should be configurable from sysfs via the power
attributes, but that is apparently not working for me.  Since the
standard value for autosuspend_delay is shorter than my typical
measurement period and a suspend/resume incurs both additional latency
and stronger tailing on the acquisition time, monkey-patch a 2s value
in until I can figure out how to do this properly.

Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
---
 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4edabdd17f57..6415ac8e2927 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3514,6 +3514,8 @@ int bmp280_common_probe(struct device *dev,
 	 * start-up time.
 	 */
 	pm_runtime_set_autosuspend_delay(dev, data->start_up_time_us / 10);
+	/* test */
+	pm_runtime_set_autosuspend_delay(dev, 2*MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-- 
2.51.0


