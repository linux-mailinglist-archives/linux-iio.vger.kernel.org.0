Return-Path: <linux-iio+bounces-7625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1B931A52
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4471AB217DF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9117173C;
	Mon, 15 Jul 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Of0mDx/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09B134AB
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068312; cv=none; b=e+KAlOluR5WSXL+8/7c6luS9Kp8l4TWM90GnTQ0kCYw7kpv1bRbAvdf25nlTSwIsOfI7CithcVeA3WxqLQxrOd7BQnG9D9ejwL3a8IHiq1nj4PvsYG6FEtoGYOEurTH0yKUWTrdy0bx5Kg0IwGRwAPk73Be6uA2nGFbt0g+VPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068312; c=relaxed/simple;
	bh=H2KB7qrkxH4w+TH5Vu4rp0MG32gfZwnVpxjixsPHa0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtCYEzwnhGecN6y8h65Z4IOwc6ri6w2TSBpzX/K5qbZxw7t29WT/9yfTVKS374Y+CzEAwNLPOSaXqmmy66rCPjfXaZRQLLRrGgXEjemgfMyd2W4XCDENqUPUhtxlR9B2zDEYLMvZvrFpeElZZX000a2avQqdla0lO4pbFXGM1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Of0mDx/P; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E7B918881F;
	Mon, 15 Jul 2024 20:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721068309;
	bh=dHL0+yBOHZLQ77Ys3+c+pJf+bqEOow2Q+dtAlch1/Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Of0mDx/PSpU+aLH/GhK4JPI0f5GWcRKF32mmZUchPV19d/kAX9ZuMzcvoSVNzxW6K
	 gHASRCQ4Sqg7Rd9h7i8t+eJfJ2e9VWjP6wv011ffN/JqAiF2l1qct7vlrzf+O6+m9s
	 kCgZXeFDX0qEOeqddlcI1w4HI2QOMpuwwF/fNgNvuygiTjFtD9tMRlxXHVZ+zIZfPP
	 tYRruhiIBM0wJY+Ha75XWVHj5EUy3s6bQOYtWHsmCsH5tm7NZ6/IDAT9yDM0RLSVFR
	 9yG1ecg/CeqIMUwZG5c09mY3+9XKpEa1SoT+6GzUUiAbWAmEvb2qQU25wpQfadCSqa
	 hzkOwccjXNPEA==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] iio: light: noa1305: Assign val in noa1305_measure()
Date: Mon, 15 Jul 2024 20:28:56 +0200
Message-ID: <20240715183120.143417-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715183120.143417-1-marex@denx.de>
References: <20240715183120.143417-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Make noa1305_measure() behave similar to noa1305_scale(), make it
assign the 'val' output variable on success and return IIO_VAL_INT.
This further simplifies noa1305_read_raw() and allows removal of
ret variable altogether.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/noa1305.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index a76f158bb50e5..a7e4c68bea09e 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -48,7 +48,7 @@ struct noa1305_priv {
 	struct regmap *regmap;
 };
 
-static int noa1305_measure(struct noa1305_priv *priv)
+static int noa1305_measure(struct noa1305_priv *priv, int *val)
 {
 	__le16 data;
 	int ret;
@@ -58,7 +58,9 @@ static int noa1305_measure(struct noa1305_priv *priv)
 	if (ret < 0)
 		return ret;
 
-	return le16_to_cpu(data);
+	*val = le16_to_cpu(data);
+
+	return IIO_VAL_INT;
 }
 
 static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
@@ -129,18 +131,13 @@ static int noa1305_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct noa1305_priv *priv = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type != IIO_LIGHT)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = noa1305_measure(priv);
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return IIO_VAL_INT;
+		return noa1305_measure(priv, val);
 	case IIO_CHAN_INFO_SCALE:
 		return noa1305_scale(priv, val, val2);
 	default:
-- 
2.43.0


