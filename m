Return-Path: <linux-iio+bounces-27687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE4D1CF76
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39427300A37A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67537BE90;
	Wed, 14 Jan 2026 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="K9sjVyWX"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CD30DD1E;
	Wed, 14 Jan 2026 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377328; cv=none; b=Hnhll0bjFU/eNNpIWUpxUPwD56fyI/7sOEgDudgFoiSBOqQluHbBV/wm+u0IgTpvbcw7qisurd4tTcfiBDkCgosJJS5rAxLo7RZEz0pYmqS0xlM0Q0iCl7cWfa1EJ6b1vwVxeRBnQEzXYm16Y5ovs/Xb0WvFQuV6NWQ4AT1G+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377328; c=relaxed/simple;
	bh=AZq7oNElee3+dHm3HFYYjL1IVmte+AzZRaoG8qc487Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZA3K43X70CHq4jhSezOLaLuiFH4WSIXaKKdbRSNOAcgOJo6Hxkrao2SNWWaJ0DvuLUPGuwU135xggJJTAKVIz/FYXi+/biKDoKYFdlQIk0p+svQ9yQ2fCpsiAt45JJ9TsiCQqCMi+1rmF/VxMNDYrs90CgmI93QNwLdqVHvNuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=K9sjVyWX; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id 9510516020A;
	Wed, 14 Jan 2026 09:51:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768377119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkJBCVYbrm+BsSSvXw1wgGZDaL/i8IisseqJZwxqn4w=;
	b=K9sjVyWXM0/UN4tD4Qa5bm7NJmInWm3+ArvLMp1T+jEYtivRjyErek8wKG26hMZxABz2Ar
	5yc7rIGqixAy5Txi86DJyifYGRno+D3pQjZDo7ggl/1cg/DXZgk1aYWQORyv5IL1rO5EzI
	ruYVcKJ5SHXHtND7+zJpK7uaMo1PJ1HX4h8oR/ThXXuOZW9h6pAfhAPjl42zTH4ALwaycV
	hr+dXWQM+CPitEdOlcyUur4zI3+Q7KDR2oqOlF8mQ7OYhYDMwVnsBKsggb6zULpKs1vlXC
	ybUmvdP71lANXqWo4OSgBp0L15Y/V0gU5g8tK73/SXcsuHU/fSjyh3TPhbhEFw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 09:51:37 +0200
Subject: [PATCH v6 1/2] iio: pressure: abp2030pa: fix typo in Kconfig
 description
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-honeywell_abp2_driver-v6-1-231c3a8c222b@subdimension.ro>
References: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
In-Reply-To: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=AZq7oNElee3+dHm3HFYYjL1IVmte+AzZRaoG8qc487Q=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xuU3h2RHFHNTRSQURmSnFJRHBKd3FnTkVQClczV3pXcCtnRVZtbEpvUkRz
 RDk1RW9rQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFowc2J
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWXpSVQ
 pEL29EMU5paDJOZW5tbTRGRnVjSGJoa3c3bVpNL1B3MEdVbUFMdzh0OXRNcTN1aVplNktNTDhQe
 U0rOVkzWFFNCndwMVlhNFJzVy9PbXFSbHhOeENRWFRLUDJKNDBwcm1TWnBCZGNId2QwaUFIMGV5
 S0RkTlZFR2VTY1pxUXFZNlMKNkxNdDdiSmY2RzM3K3ZQbHovS2UzMXR3RjVrdUpvRXlpNXpBSVV
 IUFYvSWtFZmsxNVE1SHpjbTdPcytkRzN0UwpzV3VhOUxabi84K0F6U0xoT1lMZmttZ21oZ0MwaG
 1xUkwwU1gwZ1VTT2lxR3RRMklaWk5yMFFiYkIyR1MxeHFQCk1Yd3g4OGJZcUhrQUxkTVJacXhUb
 054TkFtSUY4NDhHcERveHlWOGh1dURoam1RQklkTXNJWWtMcEN4ajI1MnoKNUZ3ZWIvNGxxYzRZ
 ZkdzUTU5em1lSzBhWEh1YitFdi9Sb21vWWI5OTJMRi9uVWNCVFROMHNocXhEOEJhVG45OApwMU5
 mYjlqTFAvVG5wTHh6SHZJbHFsZlBvUVByTnVOQVVqN2ppY1pCeUxLc0t2ZnN1UjJnSDY3TTdrSG
 JXbUVhClF4cGNKTFN6WnZHMm5zMFVwQmpvb1NwVXMrbDJ3dGxVeTgzWHRKRHNDU3k0a2gzYTBMT
 0tjNkJOb2V4c2FWVXIKTmVqVWYzdEl3MEhCUVpoQTUyU2lLZGtlU2R4anAyVExMME5SZG5xUDN0
 Tm9CSjR1ZFhSR250UjBXai9BT09BTwp2V25wVDRwbGpFcEwrdjl5TkR6OVMzMVk1ampRaWdFTGp
 rRHZoY1RIOU1EcVh1WnhGOTltWXdIbEZ3aEVsczlpCk5ycU81UXdSWTAvOXFTMmYyTFJqM3RXVE
 MydzR5SEtrYXdqVDQrWEFXSWVvaVZrcUt2QT0KPVNZelMKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Replace "I2C" with "SPI" in the SPI module description.

Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 0d25842aa414..838a8340c4c0 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -38,7 +38,7 @@ config ABP2030PA_SPI
 	depends on SPI_MASTER
 	select ABP2030PA
 	help
-	  Say Y here to build I2C bus support for the Honeywell ABP2
+	  Say Y here to build SPI bus support for the Honeywell ABP2
 	  series pressure and temperature digital sensor.
 
 	  To compile this driver as a module, choose M here: the module

-- 
2.52.0


