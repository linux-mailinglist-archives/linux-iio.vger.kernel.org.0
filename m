Return-Path: <linux-iio+bounces-23919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE3B5102E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD084612A7
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91F3101B1;
	Wed, 10 Sep 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="qyfHtlEn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B430F553;
	Wed, 10 Sep 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491094; cv=none; b=u2dKa3T7/K81R753shvcP5qSV9ZTN+fXjVIfpet5xj/eqzyV/VycClUuyawOtim80Udsj3dgWDynIWXycbD8uQuWNB3VI/wVp776Qjdog2pt55nx2Fl6UE5XypGGr83EHHmB2REHxZdZgQxzthqRmDxYE6eSxVWZ0UnxmeYw68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491094; c=relaxed/simple;
	bh=vzXTIDrjP1pDfPjNNfkDoU+3wjCvrQSDby46AFhOTpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyvRnmgplEfYHV0TPy5a1wlI9vKd37v5xH/x2MfN3Sh0QSFxBn5r0U0IWUs7zG/MHyRhOicYrpckg16DnKVkHLVMI6MxOcz/MXMF1Prv2gthl3FjurT4cFiWC6squIuOLUPWt91NAgFBzN3BUZslbgG+14GPYiHDfzU4bLSS0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=qyfHtlEn; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8E8BC173BEE;
	Wed, 10 Sep 2025 10:58:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEL+OzR1QaU/yG1ohZ4kzH9gvKvOjMioR2BOf3PWHus=;
	b=qyfHtlEnYKRM58LxUXFz/hssQV7J/rsaf785S+TbUWCVnryC8HjxwmMqNzNa3Bf4fmbhxx
	hhgPbkBxDwb+5zXYlcryt+Np/R/dcuxdM+tUkk6S9YEYMjWDDpbN7j6x7Y9MZbbDwFqbf/
	oA7TTI0jKcfxzD2jgAfMyTEp1dvCV6pQsV4RR1l6u9LrF0ndhfAnYs3Amsjz2daIzuSwva
	gkbpotLfsIuEjRhww3UffkdjQVIolADbAJkURqtiPikVAu9YDPMdt3DPeCJlOjEYXF1IwW
	IiLZwkpVZkAqYXoc5WdpNidlbJc81xlx9iFJy+5Pk0K2UInC6ipx1RWjs1jRgQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:11 +0300
Subject: [PATCH v2 06/14] iio: accel: bma220: add get regulator check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-6-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=vzXTIDrjP1pDfPjNNfkDoU+3wjCvrQSDby46AFhOTpE=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+HIkEtplNguP0cs+7NUwQ/s8QaDD85D7f71
 s21yAp0yViJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MPB2D/9x2hhIOMVOkim1y506YGuFDA36eipT+uit2oQPkXqh08TGKoVZISlbEDSK659iLkkmNKH
 6CH7tMFMNtqNsCgUvvvxyP4n06dkC/thDW+aSUgQVJLMTzrPTiqym8Xcf27pVqYj0cGDWayJdNY
 b0U5Wz+/GLHw8f7aRU8U/ttLIgk0rVdYySp+8tZn6qrkDr8e5SEr08GTTgUoquH5LSt+kpmFmYZ
 xnHKQIRtjqaShK0fKQUMSlNlBFb1N36EAbBOGykoLNJphwbwsrDKkZVa8g4755B4sH2hJ441UMC
 w6ZHNG0bqSRr1k8SPS/+uoepv7lBesQ7DSl5hjBRVNFeJE63GCFeNzKyby3w3aw6AlEkkuOnXPG
 NskdxCsdTTiJVdJWInWyarNkb6WdwJqfSFHe3fly42OXVOsUPCYI9RErghUPV5zhtuXwXojlaho
 vlxjXf3osz2pwnV/lvgPUqCMmxjyZ3EXKDgedCqDymKIfqYjnYm4iK5NpXGfu3BSm0iaq75Q1W3
 /5A2ewtQnKp1szGT1MUxG5G1Czvy/fyMfRQ9Nw2l+xF6Kwu4/Cz/aQfmVeb8+7ioGYLx/ID5YBa
 N8VPR4VLVpwi+WbIQcV8oaFpSdHfyjxoXimufOz1Okqaf7zqyHGUffF5FgB5A8tQprrplH4OX5S
 dBUT2ZGB+nu76Dw==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add devm_regulator_bulk_get_enable() to device probe().

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change
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


