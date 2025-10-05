Return-Path: <linux-iio+bounces-24748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21429BB96C4
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA11896C7A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CB28B415;
	Sun,  5 Oct 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="pkxUFbHg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6A283686;
	Sun,  5 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=A2YejSghOOFVqFYg5tt1gZ/ydeVZ1BVJR09YPKWPIdOP4xiS2osNMSjx6XnF77IT8hMD2O615PEzOQ9aAFiHPE1xuzQGqtgQ8bACZHqqP9ehiKV7mVTdpwd4GUTqkaY+RXYCAlUSWkIvVK1tPPCCTWWhWItGg4t8QpstFR67Q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=LuCJZM/jN53ejkozJ69nN3jU/QPkJ9tObGcdGNKx6tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJ6VRWg4TqILujbMDD56R/d6orz7XwprNfV2vHEzLn73Q/qaprgoK1zsJ3oRMcrjMorU2LF04EtpdGFdUII2bIpzzwEug4EaSPxjzF/h/ozUnKtFkEvTxAoodE1z6zwy3M4BxmfTqGJ5akufGKLNke8XOtLw9wGlTP2pXGipSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=pkxUFbHg; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 61097173BF1;
	Sun, 05 Oct 2025 16:13:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtorqI5mnDoCA0h5EA2rtzMVb6sATjCW1L6xPWDz/Mw=;
	b=pkxUFbHg8KOqV1NzQG7O4IpvU3JG+C/+DAJssPlBEldfNmV7MEHt1CachGwqT5gSTVVqDn
	EvgowXY3ULQLqz4v0GOFEhYCgyRzVEMxKLZDjUoAbuNd/U9RamjqRIaCR3fdWRdC7K2HR0
	+/xaPFo9iKq5cJRotp3RRuZ9dxgsnKQeEJwfiGw7SqBRBxBp6fBxLymzJyQhVFoHLmhUqr
	7FUdF6QW+Y400hUJl0gejqt2TKINqcVWP0KPXCOJudRJlUooC1hpt6ol0gDIxSJQAJ4cXw
	q6ERVlg6aKcLmdq3bWyYIOH8ZSXHn5TMF9GEwPo6g15YIamu1tXl3pJJ3wuI4w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:18 +0300
Subject: [PATCH v4 09/19] iio: accel: bma220: turn power supplies on
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-9-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=LuCJZM/jN53ejkozJ69nN3jU/QPkJ9tObGcdGNKx6tg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnNQY0gzVDN4MUJJTGdMREZhbW1GcStqCjBUdFI0U2wzeFVnVHdPR1ow
 TUV4RG9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN0R
 BQW9KRUhRcko2ZGpPa2xqc044UC9BekJlRHhtUUljdHZzVEIyT016UElMTG9LRGFaelVBaGgvcA
 pwblp0UGJXeXpDWHlobmJITU90L0hzMzRsWlFhTVBzcURhSTZEeEJuTW5DbjBWcVpxSk0rMU5Sa
 1N6V3NzSkp3ClNNUE5TTjFYem5GVjRPYlZZdHVqZXZ0WkJnYzRJSFh0Zm1tSWdwb1laWFA2UHdH
 cGJ4WjNKRDBhaGpuRk9CMFYKMGxhK3duY1Zoc0xXMXcwdVI5MTNYRW5ISkwrVzdtZGF6U1NwUjF
 XY3c1dTdQV2taYnpxTEZQSkp5TzJ6WGs1MAppbEFzM0JIbjEyVDA0RWJieUJOaVp5MlB3aUc2a1
 RKUWIydkx3bnhhNDJveTI3NHJBNXliUWtDVG5zaDZ1ZTdECjBtaVpicWtGTTNFN2xsdWpYTGxQb
 0xmSEZZUE51S3RacVlOa1BVV3ZsQlAzZ0t4L2FMc0VDUGFIREZ1UUpxUWEKTUVWenIrMlF2dENt
 bUxFZVJUc2p2Q25KbWtsbXhXQkRhV2xqQythbDc4ZXROdEVxNnp0ZzVIYy96K1hsVEliUwpDaVR
 YWlhLcXVIMk9nMDQzZXRsYUZIT3htMFFYQlFnT3NxeHNmUzNHb1hGYnZBSjk0RXNNODJoRENHUl
 g2NGNECnhmeU5wbUVadXhIbVRoZjBnV0hVL1kzM1ZxTGdoSzNkZkRLWXBXVmxNbE5qUXJiQlVqc
 294WXFWWDZzKzcreEEKaG9NMStNT2JUQWlvdU8zemU5RGYrNzNLeTc4cSsxdjk0dkgyYk9iVGtZ
 TGU2UVlZZEtaQytNOHQxNG5wbjhjeQpvTGZnYXo1TTZaSDc0ejM4WkFBZHA2Y3hzM0FXeTcxRXN
 IN1dsL1FxWFNrc3cwcnJjUE5FN3dIMW91VnRLRGFyCitOYzd2Q3d0Sk1Zc3BBPT0KPThyY1kKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add devm_regulator_bulk_get_enable() to device probe().

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split from larger patch
v2->v3 change commit desc (Jonathan)
v4 dev ptr (Andy)
---
 drivers/iio/accel/bma220_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 00fe1064486aa469f7ad15593027c7ec86197365..319a3d6867ee5ac2da64c9baf02a760865302ee8 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
@@ -230,6 +231,12 @@ static int bma220_init(struct spi_device *spi)
 {
 	int ret;
 	struct device *dev = &spi->dev;
+	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
 
 	ret = bma220_read_reg(spi, BMA220_REG_ID);
 	if (ret < 0)

-- 
2.49.1


