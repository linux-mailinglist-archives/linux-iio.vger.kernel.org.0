Return-Path: <linux-iio+bounces-15186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52DA2D8E0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA343A4471
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD0244199;
	Sat,  8 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="PvowEm3K"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0A259495;
	Sat,  8 Feb 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049409; cv=none; b=P5vJZul0pyMonAFzrMgemJ2SEg9h6NYkE1Gq5QuBVJgsME3Kk9W8Nb9Ugt8KsPR5moxaSHyP8xuCIg+5qn5t7Clv1rksLkgOKbOL5iJvsr4V3TU3Q8FFR0bFR2UE/vdGz9Hi8DmO1yB0aNroDCppUbdcVI/r3lSLN9zqc9WXsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049409; c=relaxed/simple;
	bh=1DwIyy54oq3GtrslZGG67YWoUVERHo+OBWEqaKgfwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3H48VruyKseMLdSrDZaxCnVlE/FTNy+8NRIOXVdHpUo0znyuki8qGRHa4HqBrboa4StZjnMChdtCrObMv3tYhhqPeeSF4na6Ctm+vkmSbhkMFtBzSCjY/shY/PIQcGFG+M87XNag2Hg7A8PFVVBsTXUdW2k4H6xx1B1WYN5YUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=PvowEm3K; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 41DA541B6C;
	Sat,  8 Feb 2025 21:16:46 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v5 7/8] iio: light: stk3310: log error if reading the chip id fails
Date: Sat,  8 Feb 2025 16:13:25 -0500
Message-ID: <20250208211325.992280-9-aren@peacevolution.org>
In-Reply-To: <20250208211325.992280-2-aren@peacevolution.org>
References: <20250208211325.992280-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049407;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=45gtTJDlNvmrcpI0uTOgi/HT7BpeWEr5O9jUnaiYis4=;
	b=PvowEm3KOzHYGeXxZ6TEv1hgvVo7/DZGuF81b1qlWtKuhbR6twW2IE1oZFpkLIpFA2cDND
	t5f1OOGcLx33hz5tshto7afJxdWsUZzSmGfd6HfMDN2W96YVOqDdXQ1MedZA71+a6M6umR
	hRSwSZQmo9f1vJxcqXr8Bi0c6t+hHXs=

If the chip isn't powered, this call is likely to return an error.
Without a log here the driver will silently fail to probe. Potential
errors include ENXIO (when the chip isn't powered) and ETIMEDOUT (when
the i2c bus isn't powered).

This function is only called from stk3310_probe, and this condition
should return an error, which fits what dev_err_probe is designed for.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v4:
     - get a struct device ahead of time so it can be passed as "dev"
       instead of "&client->dev"
    
    Changes in v2:
     - use dev_err_probe

 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 9d517d51f6bae..3a06852cb0ab4 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -496,7 +496,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to read chip id\n");
 
 	ret = stk3310_check_chip_id(chipid);
 	if (ret < 0)
-- 
2.48.1


