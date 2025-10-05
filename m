Return-Path: <linux-iio+bounces-24755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9FBB973D
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95C334E5EE9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FC287504;
	Sun,  5 Oct 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aL2BHVkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A633F6;
	Sun,  5 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670415; cv=none; b=fkkDn9ZtSds46nePgt+wOrNvpAag6PdZuaDcz8Lrt4fh3d2YVTtsaymOfuyf6XlQTnQWrStDi/wHNPISTtipL6YyhYu/e1gHICa/oECPq4rUQ6R5zd96b1yUEkQZmDzzA88XgDvx1vA0Adw4uUePPw0eN/CKgkVTLgs+L1YtSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670415; c=relaxed/simple;
	bh=lPdxT7BEzBkZbVxtujGv7kOjBTVD+u3N8hkcIrx1tsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzhJjcid1QRp66qA8RPqKBf/vcWgrLmsjSIRLhXBnW66C6cLtdlsAIXsJlLnQmToPgTjgNs3PCRxSZcU732L82oveeZ3x2ZNjXmIl99/TcQVobHwlwOXNGv+naaFV+f08bxAxE3HNFvUVp2izvTd6k2zTCJ5UYRF/i9LiYgdCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=aL2BHVkW; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 67B1C173BEA;
	Sun, 05 Oct 2025 16:13:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU41F5YDKDkY7Pw/sw1GEykpXxg62NNVsZkcQUwVt5s=;
	b=aL2BHVkWtjNXv7TsAqTTLPk02X4jAETxgggQNvPErAO8qaz3MzGYfxQXGILIavIVSjIR8c
	ZC83aGuWy/4EMxjPaDcrtYL346UUqaoLwF6ym/JiPnQFlyDdtEJjwrxTt4FtJElS2G2B5G
	M3KZIpmaJeSbPLhTSdFaUOKevK5ap15atEhHSlZJYbHyBCmJsod1rnUyWu/WSVdjmyEPBy
	bG2CmXLQyhgKVFEeIbjkGgzzCP5TLE8eTdT/pfe7PNF9M6E/EGN+9V2zi1mVXoX2Mr21C9
	An5LpDOvjg+W76RMNH85TN8d/RfdNbuOB5oi8wu8YY5fdikK4ajQi604sRQRPA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:11 +0300
Subject: [PATCH v4 02/19] iio: accel: bma220: relax constraints during
 probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-2-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=lPdxT7BEzBkZbVxtujGv7kOjBTVD+u3N8hkcIrx1tsQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnJHVDNtVXNYMXR2eDdXbCtZOTlxVkErCk45NlN1WXpqam5lWThZZnZO
 QXR5VDRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNnh
 BQW9KRUhRcko2ZGpPa2xqV2trUC8wRDZScnhZdHFKYlZwU0pkdkRnVVRPVXJuUFNwZkl4MTZBSQ
 paYlZjbW1ab001QUx4YlhmYjl4VjlJaDV4WWtaWi80NTdLT3krWVlFakxKU3FZMm5MVkxzS01qS
 FFFNXF0ZTJzClI3d2YrVHh1NVVsWXAzc282NVNORjB2K21wZGZZcjFYMU04ZVNuQU5vUFpjekxm
 ajVZbUFMV25OVy9YcFVFR3cKUVMzTU5EWmlzY0dYcHFieUo1QVRQQmoybEZobzd2K0U3M1ZhYzU
 xWUREZWdIR1dtUkhsSS9SQ2RoM3hJRVBiaApTcC9tc2dMOW0wMkJUUFQ3U01QUUd6WDZQVzdoYm
 xHSGV4N1NtN3RZOHl6UGFOVkhPK3NOdHM4d0ZTNU9BNzFwCmdKVXdKUjVHK2lRRFZnblA3TFJKO
 DZGVjFXRzNKZzdpOGFtTEtZWm9LOHh6WUhHaVVWMXhWNkhMTlYrQ05PUEQKd1U4MFVOejErSVh1
 ekRaMzNXeWFKb05HalR4U09XanlMcGYvZk5KRTBtb0pOcTMxU1ZZdVhuQitFcGp6NzJzQwowb0V
 qZVRob0l5ZnU2TkJMK0Z6QjUybitDVktkQWEyblNucExpS080bWUydURwQXhnRVJBc3lwMVZvdk
 hqT0tRCnAvcTE3UU11S0VYMnJqTlp0bEdObmlxVERqSDU4T1FUNFQzNTJHU21PZTRIa1hHdkx3R
 TQvb0dhSzR5eFhRK3QKVXpiM0luY0c0eWliVWRUQVVEL3NERlJkcko2ak4ydnU4VFltY1NOY3Fo
 UWFqQ1ZsM1BkdFhzQlZoNXU4YjZWRwpuR21Ddk1TczVaSDBDSDZVaWpyajk5eWZ3VDZ0aUlxUFV
 NcFlsam9MYmkyQXN1Z2pKTU95NUZ0cmtBaFNIc3lPCjRReHNGM0hyZUMwcm9nPT0KPTdpcXkKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Do not return error if the chip id being read is not the expected one.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 - split from bigger patch (Jonathan)
---
 drivers/iio/accel/bma220_spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 505ad70912571ba629f91e56a92898d8320e976f..02ee6b4d51c0816a88ac258f0e5107111ec2a2bc 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -202,10 +202,15 @@ static const struct iio_info bma220_info = {
 static int bma220_init(struct spi_device *spi)
 {
 	int ret;
+	struct device *dev = &spi->dev;
 
 	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to read chip id register\n");
+
 	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
+		dev_info(dev, "Unknown chip found: 0x%02x\n", ret);
 
 	/* Make sure the chip is powered on */
 	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);

-- 
2.49.1


