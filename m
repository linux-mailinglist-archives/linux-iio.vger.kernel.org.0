Return-Path: <linux-iio+bounces-25878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75CC31DBA
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC23F189BC3C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F9032C955;
	Tue,  4 Nov 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl98Pyom"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E12D73A6;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=YTn2ZLOEGYmCD8XLgGcUTrbR0JIR42DvUbKdNQZt7pp8tT+HCB++Ui5MfksCMCGcuOnnaVbU3mG68PBX/SCM54lNeQSTnNFBbsDYXHXbQXw0adClWLA9t5WveeyaRc3iGTli1X8YJf7lJNbAsL42XJktTpCIdFP/yoiIL3Dk/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=Ro9shlF7RKE0p6sKEHp8g+HSt+Tec9fyfgOrq+59wDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCJeEuDXL6EfxcM3IBU/MDYg5f/PKwg1YLpe6gc89Sw4kDwHemaf5HzFQ8bomuzq3E//4EqO3+Y4/icaY6bnug7x8HWl4D8aFHrtfL26bmkQl5cL8/3J5sWWsgNs0BTOnJ6fAUFO0D4gbbCxH5NnaRCDL5z1zxGOtlg8StUQZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl98Pyom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39E14C2BCAF;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=Ro9shlF7RKE0p6sKEHp8g+HSt+Tec9fyfgOrq+59wDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rl98PyomTz/rGN0v+TkfiD1D18+9kummtfWx/s8GQ3OvUYPsl8Ze1+Y+r8Yzmy84D
	 SPZ1pbNmOtSmyUTPUgT8YaLpnYq4kPQbQkAjKZHFR0MYYK1eJgBfWdX6yaZcx1iQqk
	 w3DPQNhbcAcMndDZxWZve4/sce7VPmOjYHlt+LShlNvHQLUvVhlhK3uvw6kgkTAY5L
	 CgEcidLOrC/XvzDLJCNiNPhvXXFa55HH1MMbJyNcWvbJQvWDN/Gg/Nud9OJglN+XK3
	 msHZfuX9KBYYw3RGnTjJlXqGNvcc4c0UPJz1Yucia6cGmvwN9nEwpFK6l/a91Kqnbf
	 J02nURdvTDWyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B0CCFA0D;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:11 +0000
Subject: [PATCH v4 06/12] iio: dac: ad5456: Add missing DT compatibles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-6-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=3339;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+u2TXIw9MQHDEuZGff76D9hZcdxsLW8+st7kGqLxaP0=;
 b=DmG8VffKrUNUx7os3JuynB9/G2nPZa44NsCQqRMCgDb4qnqQ1o4/4ZWAS4G1uw6ck3GgVCfKj
 9UgCR3z8fOeAPQ7hmXZ+F/T569WtXzJimLQJjsKCI/IOWafQRhFryWG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add missing of_device_id compatibles for the i2c and spi drivers.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 539a8fcc7078..01f934036185 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -440,6 +440,35 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
 static const struct of_device_id ad5446_of_ids[] = {
+	{ .compatible = "adi,ad5300", .data = &ad5300_chip_info },
+	{ .compatible = "adi,ad5310", .data = &ad5310_chip_info },
+	{ .compatible = "adi,ad5320", .data = &ad5320_chip_info },
+	{ .compatible = "adi,ad5444", .data = &ad5444_chip_info },
+	{ .compatible = "adi,ad5446", .data = &ad5446_chip_info },
+	{ .compatible = "adi,ad5450", .data = &ad5450_chip_info },
+	{ .compatible = "adi,ad5451", .data = &ad5451_chip_info },
+	{ .compatible = "adi,ad5452", .data = &ad5444_chip_info },
+	{ .compatible = "adi,ad5453", .data = &ad5446_chip_info },
+	{ .compatible = "adi,ad5512a", .data = &ad5512a_chip_info },
+	{ .compatible = "adi,ad5541a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5542a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5543", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5553", .data = &ad5553_chip_info },
+	{ .compatible = "adi,ad5600", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5601", .data = &ad5601_chip_info },
+	{ .compatible = "adi,ad5611", .data = &ad5611_chip_info },
+	{ .compatible = "adi,ad5621", .data = &ad5621_chip_info },
+	{ .compatible = "adi,ad5641", .data = &ad5641_chip_info },
+	{ .compatible = "adi,ad5620-2500", .data = &ad5620_2500_chip_info },
+	{ .compatible = "adi,ad5620-1250", .data = &ad5620_1250_chip_info },
+	{ .compatible = "adi,ad5640-2500", .data = &ad5640_2500_chip_info },
+	{ .compatible = "adi,ad5640-1250", .data = &ad5640_1250_chip_info },
+	{ .compatible = "adi,ad5660-2500", .data = &ad5660_2500_chip_info },
+	{ .compatible = "adi,ad5660-1250", .data = &ad5660_1250_chip_info },
+	{ .compatible = "adi,ad5662", .data = &ad5662_chip_info },
+	{ .compatible = "ti,dac081s101", .data = &ad5300_chip_info },
+	{ .compatible = "ti,dac101s101", .data = &ad5310_chip_info },
+	{ .compatible = "ti,dac121s101", .data = &ad5320_chip_info },
 	{ .compatible = "ti,dac7512" },
 	{ }
 };
@@ -546,9 +575,21 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
 
+static const struct of_device_id ad5446_i2c_of_ids[] = {
+	{ .compatible = "adi,ad5301", .data = &ad5602_chip_info },
+	{ .compatible = "adi,ad5311", .data = &ad5612_chip_info },
+	{ .compatible = "adi,ad5321", .data = &ad5622_chip_info },
+	{ .compatible = "adi,ad5602", .data = &ad5602_chip_info },
+	{ .compatible = "adi,ad5612", .data = &ad5612_chip_info },
+	{ .compatible = "adi,ad5622", .data = &ad5622_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5446_i2c_of_ids);
+
 static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
 		   .name = "ad5446",
+		   .of_match_table = ad5446_i2c_of_ids,
 	},
 	.probe = ad5446_i2c_probe,
 	.id_table = ad5446_i2c_ids,

-- 
2.51.0



