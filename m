Return-Path: <linux-iio+bounces-25875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8EC31E03
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 257224F41C7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C13233E3;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4GTq4n4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A927BF7C;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=UScdec3eRPrtM3/7v8wX91rteDaXM7O2DGbyllp59itTH0YXbYnJI5cZ0pHvw7DBZTen214BPJlunGkKWLHUWAxidUzbNlO85DJlHE/kZWZoX/BYcfsxIRfjrFOf8quJys3zJ0hbVdxdJtPUr/LuikqPMB+1WG4PFoIuwsYVyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=F6UI+eN8N6kLNATzQWjpDkJSVtUKoac0Fua7sSCUpWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZZPCeVIXu+v5B4ywqEYBpRbEgAUHyp7HxGnn8iPxpRQPgivrn3Y1jqGekbexNF6ptigCl+wyOr5FqLq77hTfUPoYNY6uet9kBkvCp+12ioHyxGfOQhj1RvPzbp9kpRP29Nj5zM4InpkJe1IYXPzn14ZGEGMci4o1GcCFzB41Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4GTq4n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FDE5C19423;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=F6UI+eN8N6kLNATzQWjpDkJSVtUKoac0Fua7sSCUpWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e4GTq4n40vqkfYmqfsl+ZQT/IRnLKivyYoKeL0wnvtjYORBKGGdji8PENqFrlED58
	 /uVVblR6Jm/jxm55o7Mx6SmpRwkDorknNpJ6kJ8+64qUrYyaJj4w5aHjunkt8hQYRY
	 f8JDEV94EvPOpuq3zB8dzLqWeeMHtZsIsXVwiA54GSnczR3id241kUrBlUA9x22hZM
	 r+DjXLhAj8Fr0oo2+e7E8uV14UhKES7TM5MH/gYOP/eZ4ptj9f+Mw4Rgksk3B7x6i0
	 SWOQ2/CoEe2jQQKsY1YwubOsB9ffSLljToqxvdinijBUGLlCTbicOKPWxpkjd2p6O0
	 NWfnNu+keDFRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A2BCCFA04;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:08 +0000
Subject: [PATCH v4 03/12] iio: dac: ad5446: Drop duplicated spi_id entry
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-3-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=1347;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mlIlN1vKecNlba8Yd4mqcS02tNFjhgmuz7OVQKG3b7Q=;
 b=rW/B7LL2sa4JZTr7uIeqW9F+scJRM8g+L6hoSs+Z5nBRP+OPbno9ZH8rmhoQhcWke4thp+yRU
 5HzXzM58tMTBDyeKe68o+AqYCJ2ugiIiwvQjLOzvnQ7ySMMYf7bcWXc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

AD5600 and AD5541A are compatible so there's no need to have a dedicated
entry for ID_AD5600.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index de5e4e0e397e..c0a38f642451 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -301,7 +301,6 @@ enum ad5446_supported_spi_device_ids {
 	ID_AD5541A,
 	ID_AD5512A,
 	ID_AD5553,
-	ID_AD5600,
 	ID_AD5601,
 	ID_AD5611,
 	ID_AD5621,
@@ -356,10 +355,6 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.write = ad5446_write,
 	},
-	[ID_AD5600] = {
-		.channel = AD5446_CHANNEL(16, 16, 0),
-		.write = ad5446_write,
-	},
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
 		.write = ad5446_write,
@@ -427,7 +422,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
-	{"ad5600", ID_AD5600},
+	{"ad5600", ID_AD5541A}, /* ad5541a and ad5600 are compatible  */
 	{"ad5601", ID_AD5601},
 	{"ad5611", ID_AD5611},
 	{"ad5621", ID_AD5621},

-- 
2.51.0



