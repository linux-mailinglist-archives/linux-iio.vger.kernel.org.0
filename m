Return-Path: <linux-iio+bounces-25741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1648C25056
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B0834F47E2
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7223491E9;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me4kLeb0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FC34845F
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=nOTmq8KiYAl5x41eCdKLRA5ShmLfcNAC5XyEl2EwnjlZUPf6xzbKMxBp6fmlQZDm2CGRmiwe18Hwh1C8bfppPawC7BUb40qFU8sr+ODtJ6SlxAwSgahDsG80yvvbtZp7lOmHHmr12dThOvtdjkwLGTdOGhvGcZsQpo0udsm//hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=Fj4V5MlwYCM/yLbXWL5q/O2EIeQGaYuVd5t1I/iOXag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BppkKYEG1B+qP2MA5CtFXoQeCBL11kMzdXu8mdH+Y2dTjwbFBx0gdQRZcOuwc5u7PhIV/bNo8pXcLEU4YEJ7cN4Buvti85P/5oBpEU8Zrx7PYjuPfO3zw2c4mQHgj22NEoTftfkvUuqQSUovG6XIrysjW23Nzh65wRecUXWDao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me4kLeb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0A0BC19422;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913861;
	bh=Fj4V5MlwYCM/yLbXWL5q/O2EIeQGaYuVd5t1I/iOXag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=me4kLeb0aMaRLOZUYbD48kVR87ytMgrvwBHK7ybVjmT4tjYWv5v3doeRS1nrPNUK9
	 AgNWTA96DsHF6yBPVY/GW62GkRPPdE0Day0bCN/qFCzVBiSFR4bxdDBMyqFOa2Enhv
	 P2z6fQ4YNyYHixLDIbpIqvgiDCukDMtEMg0ldWtWeaafv+q5dxu6gce6i0Y9yFP0gc
	 +LNP36mUazWnFMXDO4VQBxLRlHiLY9p97r8yruZAUvtPjpPhbLN12t/bDEui6QffT2
	 SIFi+ZqD6ZHAaNnyYtD6tNC3tI8WYIIb3K6nUn6zU9+ELJBCNIK3rdjqr0yi3Uo1S9
	 D2x2zg77aWXig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819ACCF9FA;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:26 +0000
Subject: [PATCH v3 05/10] iio: dac: ad5456: Add missing DT compatibles
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-5-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=3365;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=eqErQNP8eXWUgmVNRp4nzKzoQvA5Al3eF4hfevHcoX0=;
 b=dK/XEaxXC5OVzLU7SeRJ+yoVCkIx5NZbr/RiqoEofxpu+oODec6o9UuGitgTsegd2UHrarsGB
 Ejdvn7eqU7qBEauD2CD2c4LKG54oQrLigCT8lCyZWc0V/E69NG0yHiS
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
index 54702ba43805..0c318f23b6a4 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -445,6 +445,35 @@ static const struct spi_device_id ad5446_spi_ids[] = {
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
+	{ .compatible = "adi,ad5600", .data = &ad5600_chip_info },
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
 	{ .compatible = "ti,dac7512", .data = &ad5320_chip_info },
 	{ }
 };
@@ -551,9 +580,21 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
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
+MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
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



