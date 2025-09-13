Return-Path: <linux-iio+bounces-24069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6BB561E5
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C3217FA27
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84D2F4A09;
	Sat, 13 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Z0XE9EXo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E52F39B3;
	Sat, 13 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778017; cv=none; b=VRvnVu5JfQt29rHseCxxnn+FHRyxmRfO72CdtgBpvrKnAK4gb0gpg2BGW0cxfF1Wlj2WerjLb5alNLNqNouxZaQtgULZIYAgNubzSHBXXwheh+cCAG6yjr7NNStn73j+nB70IN2jxzxq0a5DS6Y0SBKUIkImyFlK+v6O8glE9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778017; c=relaxed/simple;
	bh=tzHETT1LwFgmqS+/oI3LRgKCd8kuILtv5wjcUei899w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3urg3bTV05JKSYk35hDRxzJ6mInBxD4A2mf4PJaO/eZ5O9DChRrHM++4Z+OpcKbrsozb12oU5chiXEAtydeHrRRH+qeIfNHtlvoKPLJrvnj8SCpX1B6OnGz05JIOuMdEj+7ZzY/PuBOS2dr4owWMCzaS6XUFS/3jl17jIa0Owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Z0XE9EXo; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BEA38173BEE;
	Sat, 13 Sep 2025 18:40:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aaVhPu78Kszr5QVkpu5SPLz4b7Y42zZbfQEUb+cxao=;
	b=Z0XE9EXox05YNO1xKkJM8xRw6pVZ1/T6wrY9Tnt3LrV9E6eLW5tAEMqNynUi66zByCkQ+r
	nqf9L1pz1rHWpgUKg5mLF0iwDPt+VjVxNpjk86OSX3osdpFICNiBO7GouLgY5k4/wdGlnv
	YONjamBPhWBtOSIViu6Z5uDOoB8+XVrIkSL1cTqq5nzTWygJ4L50m2iWUUSDtpkv8BgZa3
	71Sr3XDlyuA2REHDUqRGp4JuZLXTRDNj1YcXHcHOb25FfkB80JgUpx+JVxab1AESv7s7C6
	RMFXPe0/eFaZh1CNIAA+Jo3bIc7iaVdA2CQBsaz9zLEK3PvA4tNGzxXyusebPw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:27 +0300
Subject: [PATCH v3 06/18] iio: accel: bma220: turn power supplies on
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-6-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=tzHETT1LwFgmqS+/oI3LRgKCd8kuILtv5wjcUei899w=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRbyClBgrVPrQASNozcvUcZTkUAgmoDEXYx
 7qRrPbMpuyJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MDZdEACX2k6uxOnQPdoJQ/E0S93/j0T7e6JHScwiVP3NroQPhrM5Cvi0ufLOVN+VXcgHQVYThxB
 l6vxs8Ih+egQV8/uS1HcVN2d9YUJHM66sszf/0kF5c8/7bYdCG4tXo7emWsDCGNGMG4lUImoJmY
 onJtDqW4o/CpNfisABVqIqw9YNlZiixmFI2IigjcKJ83/t2E5Ya2wP/9NtYviWEnVpjqDpd3z85
 maNrEBVeGLcYSDkAlsix7scILqurrWVCgWq8d6pC8oK+OZN0KU1Flh9GdpyBjK9Cp9QI0n5Ljzi
 Y3mSu+mjtAV1QhPt8QXPqwnIZJ0Up1rnmNc+lOzh7Ff0IkG9eKYpBZrWB3tfu9JzObRxNB6QLf8
 UU21JwFkQlVxCbcQInY5XdLX6jPUDl6mjhhtXOYwikPeuz0wi37685Kw2yqCeq6DoO4+j6t1rmt
 6SFSEZXR/Vso5FACgak2bokxnJAafkQog5XvqGVgBNsyfTzItdTZB5RW0sAd0vJqCuLPYL6W7ET
 RmoL0Lwz2i3tVkoB7akdvv9NKN+JO5G9qLhOJ5FIRVfzBQkeqKseti8Ft+JmCUQ3FYIm/4xQ3tD
 qOxYKuV8UzfYGMOngLjaMU9KJLCsLj41QqcmwEUXOKZ6XG26bgtFupsaa3qljiLf3/kyLIl793o
 +rKBy84wkI2nZKQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add devm_regulator_bulk_get_enable() to device probe().

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split from larger patch
v2->v3 change commit desc (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 6bc2e5c3fb6cebd50209acbcc2d5340630c27cd1..b6f1374a9cca52966c1055113710061a7284cf5a 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
@@ -205,6 +206,13 @@ static const struct iio_info bma220_info = {
 static int bma220_init(struct spi_device *spi)
 {
 	int ret;
+	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
+
+	ret = devm_regulator_bulk_get_enable(&spi->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
 
 	ret = bma220_read_reg(spi, BMA220_REG_ID);
 	if (ret != BMA220_CHIP_ID)

-- 
2.49.1


