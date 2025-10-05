Return-Path: <linux-iio+bounces-24744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4ABB96AC
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8833BA3D0
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F6289358;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Z26lJTRy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9133F6;
	Sun,  5 Oct 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=mNa/R2xx5WEqDmo3tt/D3xSBUINt5QARFhOVoeZaDRnC+gc3PGBH5beWui3fyIozcMLPJ8UEEuL15BKVZ8A7JaWRfiQ+Rtj/ybZzu6unr0MdXhUrKuKJzuS7dxpbyWZ9zH7N/Wj2jVEVo0Z+VsRqSR9EGpzf81TdjWw2ebPCfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=5/XfvJp4Y6Yq/N8C+B/o3JZ8g5dHnkgbBjHiVhe9JUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFsWdDykp9b7JnuEnnKSEGtqCUuCo81dZ5HKm/1AzTeKWkpmtrgBLkdiBYefZkDWukg3I+BuJ5FiJskDrGDMwSjjvD3IHt4kvStAb8w5BIEZ/IebdXkkI/yLEqUTNa6/p4gQlYk8431cJ/inx6UkgydQ+WVNNH6tyTsORx+M7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Z26lJTRy; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0053C173BF0;
	Sun, 05 Oct 2025 16:13:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxiCY43M3Gj57Duou16z3WaMK3SnqKfSKKYcNrmg2+s=;
	b=Z26lJTRyGrcL0oSf+du+hc+hlT0/Ktin1Y/HCGBvR9La30xDztVRiBpR2dT8yQz2h68HVr
	DYYKYEobep454p0DLUSJ8W9p6N7RtMPzc0NS7BM3cHsaLU9S8U7z8AWcQ8FNSov7mOBet6
	Ibe2XYl+SDvF/EbfWyGdeWph1yFh2z/MIisBx7kbc+utVpWt6GTfUevt0PHX0Ub7UVU4N4
	DUYJROJc5Hpcc6GP6C/HaYD8YKZFLP7cp3NQRB4E6dmxM3jqIsgDVXXThty3t+V8/j46Du
	NUlhF+/goYoa0UHfwxawEc6Q3SiI9bECdHgje+tBKx5nAmlRNgY4mzbX4aq9+w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:17 +0300
Subject: [PATCH v4 08/19] iio: accel: bma220: add open firmware table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-8-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=5/XfvJp4Y6Yq/N8C+B/o3JZ8g5dHnkgbBjHiVhe9JUM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnIvRmZDVjh3VWI1UGJaWWswSnRKYm02CkdOZUF5a3RiZVJuMkZIL3cz
 Vnd4Y1lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNi9
 BQW9KRUhRcko2ZGpPa2xqb2JZUC8ydk5oT29PT2wyQlBCN0ZZVzJaeUhibkdBU2N3NzFQSTZRbQ
 psbFhzVTFvdTFhUVBndTVkaVd2OXpIWnZkdWU2ZUt6Sm1LQ2ZDWFNyY3ZjUmQvbk9PVWVrTXF2O
 Vg2NURuRVQvCmRoOUtBaUo0UFVadVlOQzZIQjVrd3VvNk95VFFwOXRYc3RNMnFab3Zvai9MSlEx
 VkJIajNsYmNncUdjd3lUZFMKWHpPQ09PUXNtL3JDcVQxTkdzcTZoeDdRck9uR2tZa0JVdklxZU0
 1Z2FVd1Y5V0IwYW1uVmJQUjIzbklhS1ZZbgoyekR2aEhuT0VDWGxkeXB0QkNKSkFCYVJHckc0eG
 tEeTJZaVFWK3llV2R0cVRha2MyRUg0UlhhVUkrOGQ5UDZWCnVsRmJnNjcyaTRDcExvNGh5Y2dsW
 kxBTnY3d0NQN1ZIT0picU9ISTM2MVBGcEJ1dlVSaUVXNlZKMVRCcnJLbXIKcWlIY0FZemdsbXVL
 amREQzFoUEVQNE5TaStZODVML0xraUtzNllwejNVM0lreVNpNzVlYnE4djAwaVFmY0JYZApabk5
 pQTE5cDdxOHV0WkpmY3c3U0VoWXB5STlwNkI2NjBnWlRoZGlmRGEvTUk3bzk1bGVoK0krTHNMV0
 95VUlYCkFXMU01Z0FkYzU3eDdmSFk5d05nRFV5d0FnU1Q3ek9OdjVxWUdka25RUS8yNmY3NTdVS
 FVucWtYb3ZhVVgwVFEKcmNZMnNjZ2FTSFpaQ2MyakRYNjE5UFRRZTBaVitlbHNXUTlIWmxEWTNZ
 WDVPVXBpWkxBQnMvbU1YYzF0R3lpTgpaV2FxSlFBYm9WQkpYYXNEN3pMUzE2VVhOVVQrZ2dCY09
 WbUFRMnZMZ2pKdFBJVXR5clMxUmV2ZFFQRlNWWVpjCldaMEo3bFFLSWtzbEtBPT0KPW9RZzAKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add open firmware entry to the spi driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 split from bigger patch
v3->v4 no change
---
 drivers/iio/accel/bma220_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 70b8bd94895e95936c7294271b5d46d9ec9903c6..b27592591d2817e2c3f3780f4307e3a76c7e06cb 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -29,10 +29,17 @@ static const struct acpi_device_id bma220_acpi_id[] = {
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


