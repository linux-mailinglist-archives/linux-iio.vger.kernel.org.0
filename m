Return-Path: <linux-iio+bounces-14402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E82A14162
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C251889226
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11222A7E4;
	Thu, 16 Jan 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avfKKATl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADD14EC4E
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050642; cv=none; b=qFEdHEtZyT7/Ez8Y/S2Ip2nbZZR2e4rzeT6Pvakg9gpIoO5V7vMZZiMHPstuQswwRNXGtRcj1ZJDT+V64IRrMSqEdNYPFRxqr5ZJZuyO0yxbxGaj2s2opRi8jH/K+DNt0UU2Wx606nQ6bf4IzEgYF7uiFZpKyA/5fyZiPhtRpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050642; c=relaxed/simple;
	bh=GwRq+kkkV8MvTF7h5hme6wF7GfXh8COHwtUtoOZOKPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wsi93HUb4LsvQxeCqczgdbG7L9U3CnW3luXYnV5HVDkN3Zz1eliMu+543E1tSid/GBwrac5TWvF2YFOft4+yKA3/yCFiUAcrXIqhY84Zx1CocTgAtmpPO7e3FIJKlIY0vRXNDMcSAapLSo8IE+znhGHiCOAdTIo6zDMQQ9LbJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avfKKATl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436341f575fso13007515e9.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737050637; x=1737655437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P44xYIdsnKaC0FnL0MZlr1/0CS2jA87vVv89Y7kFczo=;
        b=avfKKATlW78jXqWLJr2hxucByf5CPaddMWxCfnsrwA6rS3AUmZ0hNrArDx1sTPr+xX
         M7x8zGJWE5r06joSMd421EPGbflOq2rKJ6rOy1l6k/LvZxAi8YSBiEw72BULR1njM3ZO
         oKogOFS7QpsOcTmTaWJQ88Al2DxX7e4HKAijuEfLjTTX7fG7J83XfoUd8dbC8SNEA9u3
         csEmEZRAs9jI5uUqH7VwXIBuB4sO59OOg0dOmcG2ENohKIkQobK5SZpUL2W5T4Npa2LJ
         cML2IIyFuBBKM1eDPHzfVivf9ZuVvWDr0qhDMYnrcf4OT6V6HGEX9+krOT6j76wcZy7J
         74BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737050637; x=1737655437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P44xYIdsnKaC0FnL0MZlr1/0CS2jA87vVv89Y7kFczo=;
        b=tJ6nRf7i/7RcYEE7sA8XPJdawsbSJcG46oNAeL5cPx6JWd7uHSPCaHPzWJvoTWALlg
         wXIK0jMVbqOyHMi40xqRdFF9cuvLOoWEu8pIUF/umDd/79Qiqpy4JDdt7zuu6NqWMqgJ
         SrYVGEyKfX2xwXe4chud/y2QmaggTZlxb63qRLWk9S0W+GXGbmtlG6NyfkvDRarF/Bj8
         nC7PUW/l+g2yAvoAuUg9Az1VVGM9LrGPfBfiJjIfhkRknptGDjR6zX1TJ8d68fyWqjsG
         FC1lzLeX9xx8PsgXEyxXpVOXvQKVrTh+mg9AOwnQxT36spkklFECZmAX/gmrGhopsohz
         R31Q==
X-Gm-Message-State: AOJu0YzvwVuugXrViuIn5e0FHhW/AmBCfA3yoQ82ZvPrxRR5Us7492tE
	NM/HZSu/qmepVk+eyEhqLVEaZGNzeiVfzCwt6wr4uvQJ3HOF4lLzNeDWkXiOoBA=
X-Gm-Gg: ASbGncuRM4FIep1TqNk5w4EIFbdFw61FrxORvZ1I48tNpKqamEcH+TPzf0aPtldz9Zi
	L1apjlQ7Uo5tt9tA386kwLffTeb5ilKassDLsCLe6SWtMkVW/82fdsapO1u3k9fimEENx46JBdU
	IYs4meUymLfbsu8ru9TyJaVE2+AnUOnSVKZPdhBBnPjakDehbO5XEZK5J6XmAhbqhtzSncK+Fga
	aCjRhkdzZ/qE+NHqDrgnXOA6aS2BSefSCp7OJRdPSAwknLVvKPULeLGMhaNq0ZSZc1c7tqTltuM
	07Eo1O7cethjiLwVOViV49A=
X-Google-Smtp-Source: AGHT+IE5K2A6fnsCVjxy7TzKSh8H0/POAomFCSGQovICWV7B2HCmlYooCyQjDHAtwEh4ItFJ0OS3Gg==
X-Received: by 2002:a5d:59ab:0:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-38a8730db6cmr30771581f8f.26.1737050637195;
        Thu, 16 Jan 2025 10:03:57 -0800 (PST)
Received: from localhost (p200300f65f0afb0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f0a:fb04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f1e57bsm27662766b.104.2025.01.16.10.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:03:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7124: Micro-optimize channel disabling
Date: Thu, 16 Jan 2025 19:03:41 +0100
Message-ID: <20250116180342.161323-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=GwRq+kkkV8MvTF7h5hme6wF7GfXh8COHwtUtoOZOKPk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBniUn+mk25K5P0L4+Eodthff0QCZl3G6pSYPiL7 F2BgzXMnQOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ4lJ/gAKCRCPgPtYfRL+ TjQ4B/42aDBExTlhSn2mQubQqo3uSWY9EpVbCBbl4q82ZH1ycpawXrVW8vHsM0SmUK3wXUYfLVX DatspVhS7Oo1NP3cAWwrTn+7h4+p47vO70YBavDfYnJXTtIcsrnfKd73w9jFO1YJeF6eC+NOQPU FTqBI5GqMdPr4U9pLyI4hpKRYGM/gp4H/bz/HU1v9c6mvWGL0D3dUVlj3P8enhfQLnGneGyRB64 LLjLMuZWTLorpChq1bYS1TpdszITJywQQKmPFf0DYRUZ9/BR6IPsrKk82PziIG0IT4kE4D4HxuX Le4r7GOe8LA6lMDk0NxUPH2zV/7vdQrtElGzjEXQKhe7Re9E
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The key objective in ad7124_disable_one() is clearing the
AD7124_CHANNEL_EN_MSK bit in the channel register. However there is no
advantage to keep the other bits in that register because when the
channel is used next time, all fields are rewritten anyhow. So instead
of using ad7124_spi_write_mask() (which is a register read plus a
register write) use a simple register write clearing the complete
register.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

while looking at traces I spotted this unnecessary register read. On my
machine (de10nano) this register read takes ~23 µs when doing

	cat /sys/bus/iio/devices/iio:device0/in_temp_raw

. Compared to the time the chip needs for the actual conversion (~400
ms) this is little gain, but still. And more relevant for me: It
simplifies trace studies.

To state the obvious: This is totally not urgent and merge window
material.

Best regards
Uwe

 drivers/iio/adc/ad7124.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6ae27cdd3250..73c831626bf3 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -559,7 +559,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 
-	return ad7124_spi_write_mask(st, AD7124_CHANNEL(chan), AD7124_CHANNEL_EN_MSK, 0, 2);
+	/* The relevant thing here is that AD7124_CHANNEL_EN_MSK is cleared. */
+	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
 }
 
 static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {

base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189
-- 
2.47.1


