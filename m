Return-Path: <linux-iio+bounces-11473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC29B3357
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3F71C2194B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56D1DE894;
	Mon, 28 Oct 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="FBqMepA1"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD41DE893;
	Mon, 28 Oct 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125332; cv=none; b=g9FKSugafQfeePWuIVugLi8pb9Z12njiYDxyNYopZytCiTJT205vkYsLPBhbr6XsAjTg9vIWtjpAk++Xy9s+nGnrwY+ERso0PR1kI70NtFFxLi1rLUCvBrXJVTcQ+co8ALlKm+Bv5hj6buhBSYcXPszdyNmOoz/upojj7bXeGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125332; c=relaxed/simple;
	bh=xy1888VHpVySLIXoHRU06rkgRL+BdqrF5ELLd40oswY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSEZvb68+jCMlz8adxb6XCugGrB9npKKpgtt/FC1u4pILiR0ykux/4SB1S3lDlz2lNBAOw+OgQ9wzc5exX0MrK/1ScRE7EecNw/YPvce4bMcGbnAMcBkkEIH6N1SvEADhc3c1kR+goyALWuoMgupBi2b93zqvtzchMHspzBRmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=FBqMepA1; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 8DB834C784;
	Mon, 28 Oct 2024 14:22:08 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v3 5/6] iio: light: stk3310: log error if reading the chip id fails
Date: Mon, 28 Oct 2024 10:19:59 -0400
Message-ID: <20241028142000.1058149-6-aren@peacevolution.org>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
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
	s=dkim; t=1730125329;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=i3SJsn209UDpyRULEXcIotSNd90N8HU8i+Pdz1wraJM=;
	b=FBqMepA1LEQfxSQzxA8lQ7FXfVil2UfQKoUX/doiPoLlKCQ+r0/cnJtv9A6iO7QSWOzHwa
	y3iP0aHsKbF15e8rC43zc0nB+8ka+zp6c91Z0Ch9bc38wA/iEY0MCJWqDkdU75psvUDhzO
	Woiq9EL4FydfpkCjf+85CXPyDBjKpcw=

If the chip isn't powered, this call is likely to return an error.
Without a log here the driver will silently fail to probe. Common errors
are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
isn't powered).

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v2:
     - use dev_err_probe

 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 968a2cc59d09..d314659e7dc2 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -508,7 +508,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&client->dev, ret, "failed to read chip id\n");
 
 	ret = stk3310_check_chip_id(chipid);
 	if (ret < 0)
-- 
2.47.0


