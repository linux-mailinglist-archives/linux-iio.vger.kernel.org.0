Return-Path: <linux-iio+bounces-25879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9347C31E0F
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7DA4F66B5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4726D32D438;
	Tue,  4 Nov 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofN2zb38"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0331B830;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=fs0NT2kQl5/6l8RUMQ/Kv66qkRH4uDwjdLUTnldg7WNjvM45/c6nnr7jyggiawchE/K8dos/FSMIXFcgUJXFiwNcCYSoDgyOjIxcDexItdTQJkFsPlYBLiT5uVAAyhFb4Mkj7JnrKCQ9auitqHPgHA4MV5nDs7gm8PGg+ctYjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=4lSbtpTtYR7HQW42Q1CD1TSmaCLPW3aGdOTuRX5z2bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB41RIUfkyXWIv5QuikuTrBW8YRDcu8boC357eescKLEkYuZEFE2wgxC8mYqukAUrK2TM5xS/2EDEnErpbnjeTHPAPkujfT3BNsRe9jVINuOr9fo30ccahnsRcPob7xtQACkjC4QjtofWuu+Zgg3X9+ot1dHpOmm6rHtsr/aAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofN2zb38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C90FC19425;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=4lSbtpTtYR7HQW42Q1CD1TSmaCLPW3aGdOTuRX5z2bU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ofN2zb38i+w4Pob4m6eFZWc+hAPj9jxOgZyy8kfWIJ3XI5PNHfGTE9oERxryjmM7R
	 kyO45Cr8LGeQFPl/VL7yR7caTCUUlb/pxrjSsTqsNG7EO6F2htAiw+qWTQR3mprLDP
	 008xtRKC702vNS+osOvq0W9+TVmJDcoW65HIcBkXRvTbku8/ucJg7UQyTldSx/c8db
	 eiZOXWPUxQhDB3D24bQss2ATxOAySEm5SC4M+NX4TsJ3A4zEus1OiA5L9gFwKN2dS+
	 q2V2GK4jIGuE4Jbz8xJ6D/5ErU0bOOu5t2il8Ft2HwL/XZ6yrvwX9JwAL2TdmWibGT
	 IkNVdRQm6cDtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A12CCFA12;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:17 +0000
Subject: [PATCH v4 12/12] iio: dac: ad5446: Add AD5542 to the spi id table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-12-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=1707;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/Mkg35Wn0UA67FMCbuwFEboIaykrODqRCUQPosEXLzA=;
 b=uCHg1Ky4g//MIgWH2Uzc67rHvTtgx7F/SFFBdgRn+O0xeJvLc8Ja4dz41O/DLKLmbspP9Ff6O
 8rJLr0kUDLUDUV6BGoyg/YJy6mvYyVkVu6Y+cn/9UFWvfg6tFPyHNRj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Michael Hennerich <michael.hennerich@analog.com>

This adds support for the AD5542 single channel Current Source and
Voltage Output DACs.

It is similar to the AD5542A model so just use the same id.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5446-spi.c b/drivers/iio/dac/ad5446-spi.c
index 1a52f6014fad..487268d52ce2 100644
--- a/drivers/iio/dac/ad5446-spi.c
+++ b/drivers/iio/dac/ad5446-spi.c
@@ -175,6 +175,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible to the ad5446 */
 	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
 	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
+	{"ad5542", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542 are compatible */
 	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
@@ -211,6 +212,7 @@ static const struct of_device_id ad5446_of_ids[] = {
 	{ .compatible = "adi,ad5453", .data = &ad5446_chip_info },
 	{ .compatible = "adi,ad5512a", .data = &ad5512a_chip_info },
 	{ .compatible = "adi,ad5541a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5542", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5542a", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5543", .data = &ad5541a_chip_info },
 	{ .compatible = "adi,ad5553", .data = &ad5553_chip_info },

-- 
2.51.0



