Return-Path: <linux-iio+bounces-14183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D99A0A8F7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6498E1887519
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A61B4130;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z557wR1/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FC1B0F35;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=W77Ngv98sB55IRGHjjpiwLBo93DBvaK/5Rk/bnp/mxP3haxKcemrilwCyBUJvdcBmkfvX+xMiG8fY3VSe0gpLeAVBLDUNIHR6WbRn8GLRY7pnEZ3/1fDI2idQod3wgXjHk2PfEQ8uudu9k9ckUDxRNxb9TrVM6fbWqhFBSCoeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=HdC3tnypYV9krIVMUb6n9Me4suQ/79fxzfa7NWhVtHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCabwG1hsQTwZaZV9ScmUJLqk2IMm9M8EjCrUzFReT42I8uiOToR1lrGiAOFIz1ZqNb2sQ8Z6vXuhFe7vkdtKpe+qHr6Y04zvu1TiNFrI+jW3aF2bsb19wbw9MXOh+oCLybH7B4Lwvo6ObgSnL/PsOk96RYtico9o79YX+HGceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z557wR1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6959C4CEED;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=HdC3tnypYV9krIVMUb6n9Me4suQ/79fxzfa7NWhVtHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z557wR1/Ri0x/v7HLBEpXPfBpA0C2BU93R118SDYq2yKED0gSPRbVTLs7ra7SiXQd
	 Qu5OtGDh7pY/1I7O1udDSmt0ZqQcPVWzVdMpHnEAg13zxl8EWBY9rX6uO9S0+koVd0
	 /Ene9dN4km0xbvoex96Qi3iAUF6VJ1wuS7Z+VyR4tkXRSK88mwfFaoHEMv1PofRDci
	 LKGywhN8Itmaqnf6motxzvDN7PKvmsdGT7Mb3qiyTjGhxObJhGTRRMoRBs4s1bgLQT
	 fc4H0rkjOGhi1Hqb2A0YWvP2iJRoMoB2tP1od3/SkqrZpKf+PHfsFcPTAOKtjpn5BX
	 MvW9FyBAIN1DQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0002E7719D;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:06:06 +0300
Subject: [PATCH v2 5/5] iio: accel: mc3230: add mc3510c support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v2-5-322804a545cf@gmail.com>
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=RJjlWfFqRxjL45OPhdWltdOqM38Z7glviIeJAsj3UeE=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2gtEXm7IWXPvY7/qkmfr7n2iUWYHl2s92Z2IaNxw
 9LqAMu2jlIWBjEuBlkxRRabjR6zxfLDJSdNe6oAM4eVCWQIAxenAEzE8i8jw1b/c+4NbSWPLPjk
 vBJKuFd8TOdPXmp7qr32z8JlQexrShn+p7De0P98+0J9sr7ud4NzW7OSI1kcwjWEk6XrWMpsHGf
 wAAA=
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This commit integrates support for the mc3510c into the mc3230 driver.

Tested on Huawei MediaPad T3 10 (huawei-agassi)

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index ef9c4bcabb0b77518fe2a124e31ec5e7ca66816f..ca6f87d27b0f179ca33528b7e82471f1d13ebd5b 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -46,6 +46,14 @@ static struct mc3230_chip_info mc3230_chip_info = {
 	.scale = 115411765,
 };
 
+static struct mc3230_chip_info mc3510c_chip_info = {
+	.chip_id = 0x23,
+	.name = "mc3510c",
+	.product_code = 0x10,
+	/* Was obtained empirically */
+	.scale = 625000000,
+};
+
 #define MC3230_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
 	.address = reg,	\
@@ -225,12 +233,14 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
 	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
+	{ "mc3510c", (kernel_ulong_t)&mc3510c_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
 static const struct of_device_id mc3230_of_match[] = {
 	{ .compatible = "mcube,mc3230", &c3230_chip_info },
+	{ .compatible = "mcube,mc3510c", &mc3510c_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



