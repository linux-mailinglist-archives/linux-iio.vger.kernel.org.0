Return-Path: <linux-iio+bounces-24539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B10BA7575
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005B07A6C66
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271B238C36;
	Sun, 28 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="E/rY4kUI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF922538F
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759080939; cv=none; b=kwgr/je+LoJuhCxkHeGpQMc1h/wIPQU0HjM1BMdgEXNH7W1KI6ZR5x/y9OhCLZYEsbo3pwgilVhoxyFyIdFKtsAvM/diCn23SR9SgbHtAiSnIEnWFKO+9FkHaVkufvt0XyKXvVZJRH9G/a1eNXAj/ukatuDsnt462dVI1b74uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759080939; c=relaxed/simple;
	bh=Ht5SyqCV5h+ZFJ7EoAf0iNfdKg/MVrsDgz9zUPELKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRCa0ItWEo68xPuUiJtoULBZmYGt4KQOT+03nq4+r6UWzenscfdIm15WkMNWEqdcQ6sZco88M7PYBGrsDfkZxwJBw8H47x1+HHQ8B1Hg5bqQTr+QWPSMaes3S9Yhcdva+bocudUKC1USCr2ewv5ldZqigdRWSebXJ/gGht6ST+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=E/rY4kUI; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id E6753240834;
	Sun, 28 Sep 2025 19:27:20 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 5364B240518;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1759080439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dP9UQhsnoga4GjBwoF8bFsDJ58TkJyIH+2s7xYNRbTI=;
	b=E/rY4kUIrhme+Zi4guE5xUAmP7StUpRV46gvXkT9MUNWaZ1adeUFXPKdFts1sD8/QJl6I7
	buxMiBLMrblOcRAoQszTc8VIAMvZbTUWoNV3CsU6RUZ25XG11hI+PxTF8yoLxWmVn8wl5j
	PCVHLOLxseOq3VP4n3W01A8VpVupSGVnIv3N00cxo05kUaqMIcQX8SJvNMLr7pAcY8qEqg
	JpwFRlVv8PLANtTf9bmBsKFGYKmXHs/Q+lVlK9mW7t/Xs3ftHhWBO9YrrzCcrmZEJTRoO6
	+c2BmVIkB0+a/UESfr51G9/QSur3oHl1h4ZKBFpUSZlKXGEclv6aocPTDSvacw==
Received: from Gerda.fritz.box (p5b2f36f7.dip0.t-ipconnect.de [91.47.54.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 0BA7E240456;
	Sun, 28 Sep 2025 19:27:19 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v3 1/1] iio: pressure: bmp280: test longer autosuspend (WIP)
Date: Sun, 28 Sep 2025 19:26:29 +0200
Message-ID: <20250928172637.37138-3-Achim.Gratz@Stromeko.DE>
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
X-Rspamd-UID: ccae10
X-Rspamd-UID: f22f7d

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


