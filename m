Return-Path: <linux-iio+bounces-22533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BAB1FBD5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFD81892765
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16161FF1A0;
	Sun, 10 Aug 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="Da3o4lQw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp4.goneo.de (smtp4.goneo.de [85.220.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327781FDA82
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852373; cv=none; b=gEJHJZDRhDwv61knIH0+KXfcu5nfGWalUFORoWV6Rqh6o9F7UHV8il8kS6Q89E3WrjxNCBoyDAvlh00jFu8rEdZ9Py75m1Yu3dam+nnBOEv2tw7mTVsnrOI1OgwrpjrDMdyR4k+tnOgvL+928jIILALYXRohxLkbrk5wXlSsUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852373; c=relaxed/simple;
	bh=JtiTh7gIpgmRbrf9mbHTxlyX74No5RGkWMbhBPGjWKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkcBHgX4mw8mdGsZfv1+6+RRrh78VDaCmh7Zc/S5KiW0YwFzkSC3geOZVXBmp2PjzmMeLEOj21+i/eItb9H67wg8XTjd8ZeEAJlS9Y2Cv5QJRX5D/YJTJRHoJeQZ6Yqg5c1qneuPs3sYwe5BViH9GEsH3nEVKLtAFPm3ymf4UiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=Da3o4lQw; arc=none smtp.client-ip=85.220.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp4.goneo.de (Postfix) with ESMTPS id B232E2405BD;
	Sun, 10 Aug 2025 20:59:29 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 216C4240166;
	Sun, 10 Aug 2025 20:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754852368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6g3526ujYw3CNvmCVLFfL443TX17sZ19v8DvKWD1joE=;
	b=Da3o4lQwproTxVTSSoAMohrw2PrWitdXgipTJkMEYZgXyKWN4xYkKNNOiaKmYv6c4Ze/8B
	mS7KIKZEnIvLfLLq3MbnCcGpdOsRrkzbZv/0Z+O+dWg2Hg8XpnXdN5gUtaM9Q0DVzcioz5
	mEt/7dGbexRjznBiSqM1e8aaFdscdlMLlDpLT2bEhwXbm8vQ6HT5hXF285s/zA/glayuxp
	9LDpSIDQt88yn0xlb1vQ3V3uMKLMtuhKRTKmZCuEUCA/dv/C9FGXJk8TD5TD7tCgVK+KOD
	j6C/8CS6BNNlv5TDpB6zoXMQqhLEokAKoGzHRD8TDsLSJHFsvMRfhAqE/tRacg==
Received: from Gerda.fritz.box (p54a0c448.dip0.t-ipconnect.de [84.160.196.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id DDF2E240159;
	Sun, 10 Aug 2025 20:59:27 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [RFC PATCH v2 9/9] iio: pressure: bmp280: test longer autosuspend (WIP)
Date: Sun, 10 Aug 2025 20:58:46 +0200
Message-ID: <20250810185846.114355-10-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: df0487
X-Rspamd-UID: 5e4b8e

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
index 5c4126e4eccd..7d51ab0b92e9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3500,6 +3500,8 @@ int bmp280_common_probe(struct device *dev,
 	 * start-up time.
 	 */
 	pm_runtime_set_autosuspend_delay(dev, data->start_up_time_us / 10);
+	/* test */
+	pm_runtime_set_autosuspend_delay(dev, 2*MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-- 
2.50.1


