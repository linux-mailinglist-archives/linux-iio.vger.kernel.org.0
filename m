Return-Path: <linux-iio+bounces-24078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D69B561FF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872743BB1FC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1E2F7464;
	Sat, 13 Sep 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="CjESK+K5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90262F39B0;
	Sat, 13 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778019; cv=none; b=JX3n2ztzCEMRR0T9hltIwR4bDHj3Ta8eYlswHww3kSpTS63XuJwPJE2w7nEYI2vqc05LN9rqmB9jQnSXPfh6jCddt9zdG5pqSUsqe+KtPQPv3GtpwJUJTiFij1Em3jm6Rm+iPHwU8edCTsxLGwqlYx9YxpgczPGYqkAMb4VGwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778019; c=relaxed/simple;
	bh=nCc8MNKloJcbCVKHZATuu0OA29poSt0/TFh53Xn0qjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVZWKAbTWebV503XSXfOqgqDKLvpu2+0jSO/sBx4W5cNYle7V/1pFDhQVfAJPXvQgbyp18hu9/z13yJOJ+NglIppXMxBC1B1ojzrBii32ir2OsRPBxd2s5AMc/Xskgp92QKWtZIxWgKXApkwbHto1hCOzMoZwviWHfqNaTrYYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=CjESK+K5; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 54C43173BED;
	Sat, 13 Sep 2025 18:40:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDV/VkkSOJlx5K7LDWqnUBUmGxPYTj9kpe7L4hyFO90=;
	b=CjESK+K5gTI4cVEZ7OIASyYkVtJxnL+JJtXPqYMmNy6CFmka4tTF47nJGow3ETMp3p7C0P
	6qlpQZUnkT/hEqa25fc7prX5UzRhLufkPOVJFMBVso51Un/K8lPY9XDVEhbPdbObIWf5AO
	QBPGHVquHCi2tq8I1yMRQK2rpL8Pk1uuG0/yy9N66Ui/97Mg/12QStlCIJTuhkpfgGoLvX
	PGq1ExPeCQY3A/gDnRU/pgdjW6SEFUVsKIrWgik5q6b49YLFTTpK6Cs1R4/W3GC9B6Z40i
	BbJgELjcdy3OQh6AL/M6jc5aO3QoJyXgUFoR/+wn7+ZXj5Lqu9WEKWPRlbeLSA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:26 +0300
Subject: [PATCH v3 05/18] iio: accel: bma220: add open firmware table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-5-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=nCc8MNKloJcbCVKHZATuu0OA29poSt0/TFh53Xn0qjA=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRJBGy8Ffjhli2pPgncJq5uVOL43w6iN7w7
 65BuEsRbh2JAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MPl7D/9QtKOo0xL/AXcShe+H62h7TedQK3XvFZIsYpD8q+rlV0JUBLmmu6keowB68XSxdiNZtpz
 DaIrYxHOttSOVeK6bS1ra2+8g05UjrABjY0xB0a9Dt8tqwL3VrHZT1JKlISpOGm49/+BNTAYhN/
 cv/i4utzb7qoXUlRfD+R123t/KM0KY0lQsU7a30+XJPbrowuQzRJCqiaO22SbdUCSGzijuKDvI+
 M/vQGFaU+mbIp3YPi9oiNFy/2QaTrM+VPujyFnENQI0diyBcX4YiVYRhRECSRClcxE/igwStA5H
 Jh3D39yrog9puPc2/gXHIY/8rgcW4y8ymSywdKrAvilpjzcDfLF0+KUfZyR4hBo2tnA42YsYQQo
 y2vRdiJgWq5r1/oIyKaF9CfN7mabvCFbBXVc+50FgULs01jSOIIDxS2V5VkvIEjtRPNi9eqgwtE
 TyHigyhB4g9MsABV8DvVRo84Rk/WKwEWyIz+AQujMEN/L9I8z+W2E+Wdrewszys+J5/bX2sttnr
 VgwAV+eoqUZAFBWiUPekr+SBIEA5w0ka92PEu/DXEfyxxz1FLEpVGPstSyPFs4Vz9u6oxBFrnXV
 UyvDk51gdq4uFZyqjZaok8B9uAt7hF9gPll/iCa7AaJhcps4AEoxSVW4XaGzBOG/M7UVoM5FVma
 Q7KsGV4LheI2wCA==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add open firmware entry to the spi driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split from larger patch (Jonathan)
v2->v3 no change
---
 drivers/iio/accel/bma220_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3ad5e43aae496d265a8cf198595bf824f8e73692..78820d90e39119d9755b6266a8329e11ffd55723 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -32,10 +32,17 @@ static const struct acpi_device_id bma220_acpi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
+static const struct of_device_id bma220_of_spi_match[] = {
+	{ .compatible = "bosch,bma220" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma220_of_spi_match);
+
 static struct spi_driver bma220_spi_driver = {
 	.driver = {
 		.name = "bma220_spi",
 		.pm = pm_sleep_ptr(&bma220_pm_ops),
+		.of_match_table = bma220_of_spi_match,
 		.acpi_match_table = bma220_acpi_id,
 	},
 	.probe =            bma220_spi_probe,

-- 
2.49.1


