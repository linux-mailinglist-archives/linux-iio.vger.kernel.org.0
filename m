Return-Path: <linux-iio+bounces-19475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEBAB414A
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CB3168033
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A3296D22;
	Mon, 12 May 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXm+8JkR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB319049B;
	Mon, 12 May 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073038; cv=none; b=dstpg1Ir6jtc+12SKrSRaAoFrvvTQYq0kcROS/VVhiZxw/IlUPXxegLqxFa/fIHwr13bqq8H3wxKYKDV8kJytVjlJFYZW7rC6FCCJZic6/bsBiudABquUHKXes1flYiAJis6FLOmUZNj5NXIV2ogujlfjNop8nYxDON2+p48wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073038; c=relaxed/simple;
	bh=XiRHC2t043NnSSGBWQQnSJasI7hGGZVVUaHhNOhQFEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aq5JDWM1k/vBtj4dazlJaus9xrcAwnA38mnixtADz/U+iY+84M12Jwl6wu4L8lDL+ck1PJYlY5e61AKy1gJtYWF4GwDcM7d1iu7s9K5qxh1kbqm6ZbdTgMKkk5CzfiC90+hWdOU3aRgPd3vc/ZZVq+bkeoDcgzzvy2JlLAqJxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXm+8JkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A95C4CEEF;
	Mon, 12 May 2025 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073038;
	bh=XiRHC2t043NnSSGBWQQnSJasI7hGGZVVUaHhNOhQFEk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZXm+8JkRbQykCAmP+VlflsFkYqkA0cQxXQvQx+yAfrVreqK/qFsH2aED27vHWKB5x
	 RJEvXBfAjnTVSwbNHu5RBck00e6fWx0O/zFYRCysSVhrAR80jmI45BruQQ0Bs8SMWN
	 umJFY9rPUOyr45udt4hQKrvug3Mt0E3DbbX2Zp/C+nCAGGOZ0vRs/jYlyreRlcUBiR
	 1rIGsJzpt7+PpTZDjH7UzyByTf8RFE6mGJrpi0ymC3u1/BvtDs+CkktcLCJydeS5Js
	 iu1FvQwYUYIfWeJ5RSlK69Pr22IGgT5pTbv5geJ8F2fiUhie4Catks8XaDmAfDaQ01
	 NGtBFeLw5OqGw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	sean@geanix.com,
	andriy.shevchenko@linux.intel.com,
	Frank.Li@nxp.com,
	nuno.sa@analog.com,
	haibo.chen@nxp.com,
	jstephan@baylibre.com,
	tgamblin@baylibre.com,
	han.xu@nxp.com,
	peterz@infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 01/15] iio: accel: fxls8962af: Fix wakeup source leaks on device unbind
Date: Mon, 12 May 2025 14:03:36 -0400
Message-Id: <20250512180352.437356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0cd34d98dfd4f2b596415b8f12faf7b946613458 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250406-b4-device-wakeup-leak-iio-v1-1-2d7d322a4a93@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 987212a7c038e..a0ae30c86687a 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1229,8 +1229,11 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(dev, "wakeup-source"))
-		device_init_wakeup(dev, true);
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to init wakeup\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.5


