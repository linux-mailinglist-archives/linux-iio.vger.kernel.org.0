Return-Path: <linux-iio+bounces-24075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FDB561F8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41D3172B0D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99972F6561;
	Sat, 13 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="K2J8PIzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9B2F3C21;
	Sat, 13 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778019; cv=none; b=ZHTgw7kI+BuqCg/EMLztYA4r8hWr4pu5nUl1/k05KAjPzZvvW2OrrU5y0NuCdeCGEhSavNEJ8oL4RbLiNAUkY4Hut4iG9QyKqyolWXKqkVySn2DXiufiJ4AV2NZ1CTcfQVBP6S0YaQyH4lukUDlH93yYgv21S1J6QxiHkplwPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778019; c=relaxed/simple;
	bh=XT0h1eG0JoVte3XhqwukvD5D6xWONdFL7zvC58qTBKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCHEsWAyMCwqV8+029V66RIBugfg9HHcOxWFu0PIyubgwhM7o8tRrA4YFrHTDJA4s6aILHEekX0PLrb1CIK455CMAlenMYFgoEPEYGzlf41uOVx9W4L2We1IOyaTa3ND/H5nQTfUvn1uiW642iPfYI53W98K64P8s40Z0TaoS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=K2J8PIzl; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 24EC5173BF1;
	Sat, 13 Sep 2025 18:40:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnSZKcxQSUytQ3bLkEpLGeq2LN7bT+PLhjdXkHNsggY=;
	b=K2J8PIzlK0pmziqoXWkVfnweqXcXVZHVpYP/sbGwQe+6//FHWWyTDiB6CLcvaH3sTLwrVD
	q7SFaEuldCy/6hZD6S9jz2sB1h78RM+32pBn0LdnhkZVetepJMdT3FM0gREMVE6ti1PRuD
	HARhBoVzgk2SFqc6GCmSHJW+QHj6Bebv0eVu3KJ5dl/731iZbIWUN1oGQ5SZvtQl41aQoq
	9wiq4F2NbZm3INmkYZqg9JYJZGBmUrbaWJtV3CqbWZsNE9NdlFyErjLzbL6vvhhEzPMiO6
	0tQGfAbscVClkS3eXqghpAA6Gkvynau51tyJPG9XoPZT2VGPvwr07vyYXWRzlg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:30 +0300
Subject: [PATCH v3 09/18] iio: accel: bma220: relax constraints during
 probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-9-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=XT0h1eG0JoVte3XhqwukvD5D6xWONdFL7zvC58qTBKQ=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSTqmNa1YZrLeG1upgV9nOixG5nhswuf0ts
 m4aR8ovepGJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MItcEACKKYj1vI5vnrGr/gcNSqqVTkiPQcNWpNam52eZBdzBdTek2irY3Xp5qUjifzUb69Tdhi+
 LPwVpzsCnTKksCK/G/c6RgYQXuxMCOPnQBTjMa+pWSM5g82UqHBB67BIn25v1BoJRSEZ26+kAo0
 tsXt9abfCe4cQREuvY/QLu3g8UViyPj0W8253R5zKT7isrpH5aqirt+ipy0DYQhyj0C5G886mhK
 1j4ecFwBgEEe/snqXQLCi4pkVTDKWNo/21+nLiFKqv0ju3yYmJ8x2J3+NyY/C96KwtvbgLizuYc
 /HyBLwdjWFOf8OHTGC8JH9ZemCmzG4wPf7w3k8MbG1GElTUxerxChrCySKeS2OdS/lvuQT79k4F
 8VXt1CvfryLLSA5RAQ52gjmNaSXNhAE/m7MZARrnGosvQ9zT6gIQ74HXyZbBN9X89jXOhBJqpgq
 jYa5grcU1jcCpf2bVk1NktvhuIfjfqNj9HYG0anDTtPF7OifjlrrrlfHYjJQNmGfEghPfY+qY9r
 Yvn3VMXsWhTvQWFlSXyBW9g0P0s9eFVFj0bCQZpI/WF8kiR9+l2yiGD/LAKAi2jhMERBKehY2BL
 ljngb/17Mt5HxzT9ZXMruVLFHV6ur/F7MNXiOWhK7gmGL3T3BQkI4e/ZdcP9PBJmUqACHlBTpTB
 Rsp1E0mYFxbmXjQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Allow compatible chips to work even if their identifier is different.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 replace err with dev_info() (Jonathan)
---
 drivers/iio/accel/bma220_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index fad73bf6b8f29c0a33519c64c8888a01008f7579..7fdb83cedfa1809490cfb7f89532182123d580ba 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -267,7 +267,7 @@ static int bma220_init(struct spi_device *spi)
 
 	ret = bma220_read_reg(spi, BMA220_REG_ID);
 	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
+		dev_info(&spi->dev, "Unknown chip found: 0x%02x\n", ret);
 
 	/* Make sure the chip is powered on and config registers are reset */
 	ret = bma220_power(spi, true);

-- 
2.49.1


