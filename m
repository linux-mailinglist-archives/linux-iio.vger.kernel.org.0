Return-Path: <linux-iio+bounces-14193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31120A0A91D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA618873E1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AF1B415A;
	Sun, 12 Jan 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6E8YAwI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072ED1B2EFB;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684781; cv=none; b=rUHCC8gHvNdsvO5h9dYzcajNYKdeoDFi9pNLWolfASWiI9xTKsjcjZwvq4TqWjR3l7pJaOv5CzNIIS3cwX/9J3G/lCTf6GUZHbrM8Ni0gcDCOwHLa1HGGJSpLjj+Qm+p1LwcDLSzZOtcB/neFhEfXYjSIl4XxsEHwITIZ+KJkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684781; c=relaxed/simple;
	bh=54TbCEVIqaLsT6+mK26KHcEnUNW3F9y6yj+SI4+oyn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6CGpBLEYcIIACNo/SCPqoI8fpdJeYhn2K4eFQ2IlzdgYDrrOki1TLoKR7ErhMn9IxrZApg16qCVDLYaMoXbZCekWHJ+NZa5apjucCMkyPW0gy3AFiZPAF7SVlv17dkvogkuZ8CNwjfpu1YCrRL8a9BRmYHDvXiKLHb0MC/qsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6E8YAwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70186C4CEED;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684780;
	bh=54TbCEVIqaLsT6+mK26KHcEnUNW3F9y6yj+SI4+oyn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O6E8YAwIxCYJuLyKUt6xhHVsxJvl8qvxn9Bso2PZ19sp4xPXtq5/KniyPSpm+S6VZ
	 PnSYxktiHRAMDpOdAZr5d0ddOWUcO2OZXIV/JeDdouBgEdxSOkQT2A7EQbsGsujRz0
	 4djdQTH33MZl0oNld3mR3UpCbt7nUzFdmq16iSqdhIS3y6CyXaUF2XGEoscBo0ztzh
	 hMp4sKCAGQLd8pNrsBupROFDK/TOjWJN7v9cQxXV5e5fI+DTxghaaTWgjwea8R9V/2
	 xgH6J6WQ72+FyHcuW/f3N2PQ0w87kSqhvDCoSXQCCgJMBozNUkCopVkg6O5o2CnAvY
	 AzaCCfb+ce3qA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B4E77188;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:25:39 +0300
Subject: [PATCH v3 5/5] iio: accel: mc3230: add mc3510c support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v3-5-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=8NnUIWTvd4feGzNACN4tIbU/CIslPoRvUoNTUHEipMg=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbt7yyUji+dZfq45fBdxmu7yhbtZv3poPu457vmyZo3
 JwTa3ltd0cpC4MYF4OsmCKLzUaP2WL54ZKTpj1VgJnDygQyhIGLUwAmsqqKkWFrmQrTofY9AXtl
 dGtmLmV10j0W1FSVsDhFtYCP+cmLE5MYGS7qntzKMV90ywX3W+8X9KwQUYisFNzyV++h05OlN6c
 02TADAA==
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
index 1b58f3ea50655b6563a78a2531b16a8088e8f8d5..92934975edc77b11ed6dc3da077a28d317314fab 100644
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
 	{ .compatible = "mcube,mc3230", &mc3230_chip_info },
+	{ .compatible = "mcube,mc3510c", &mc3510c_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



