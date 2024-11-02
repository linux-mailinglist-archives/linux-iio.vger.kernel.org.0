Return-Path: <linux-iio+bounces-11859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525109BA24C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840991C21E75
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F01AB6CD;
	Sat,  2 Nov 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="iKg1Bs5e"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF731A4E9E;
	Sat,  2 Nov 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577386; cv=none; b=K4STmQCORW3blaF2Ckb3SV4BL17atjcBRvrYKGOFAGDBrzmEGKNI9lIHcaJ4badL84m3ON9ry2dohgBUTqbxhimmiExnTFEz3RL4VE7wbd9Az/PyS+Ua0cgBAEf0dKJiXmqm6ET8F6XIiWnIYo9VWd1hM1xHrXLmjPos2dvSNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577386; c=relaxed/simple;
	bh=4eVyemtYA34bmRuiZAcr9XBoupD7yQ73G+EnUW2d1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyD2G8OX8BHThGn9gLQJha320Bdgpwt+x+45dkolbB8xDORMYQOdUlmPn3+scwYXzjcuE5wfcStobOniUOOhngVXwDqv+Bva+99rT20CnFZIaPlo8sww2vTOS68uJfEerAYpi0pR4glVfOkKuGJgVjHod7gyMeVsittiQlCc2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=iKg1Bs5e; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 69A2B4C84C;
	Sat,  2 Nov 2024 19:56:21 +0000 (UTC)
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
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v4 5/6] iio: light: stk3310: log error if reading the chip id fails
Date: Sat,  2 Nov 2024 15:50:43 -0400
Message-ID: <20241102195037.3013934-13-aren@peacevolution.org>
In-Reply-To: <20241102195037.3013934-3-aren@peacevolution.org>
References: <20241102195037.3013934-3-aren@peacevolution.org>
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
	s=dkim; t=1730577382;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=uvvNhj8Jh93zpagJdBLhHBNGJCsGSzK4C5YOxnQO53E=;
	b=iKg1Bs5ez3k57s5TX8B2KsJGqvkshKKwCERTQrh5gkSzMVC+c1ahFcgX9DDVEtcz8uswXR
	CQ73g9pKzfXbtlIPoTpg53k6VMYFigxLTGRewaGMfCZfXj+vXRY4NBSDCmwxoZkJtUhqZr
	u3lpZEO0IZNZsuJa/CQw3I5UB/Jg0VY=

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
index c9a3f02bdd80..becd6901dfef 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -509,7 +509,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to read chip id\n");
 
 	ret = stk3310_check_chip_id(chipid);
 	if (ret < 0)
-- 
2.47.0


