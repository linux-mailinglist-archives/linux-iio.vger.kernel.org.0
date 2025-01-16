Return-Path: <linux-iio+bounces-14397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D23A13B52
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFA83A3D3D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10722B5AD;
	Thu, 16 Jan 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mblRpUOY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1022AE75;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035613; cv=none; b=ApY3HhK6jIfWTcM2zi0gQMLnD1IsdQrCVbTJPomPZC4Jr5snERwjJHw3TLHeGUJjOWcvIwPOGFGMHwjFbbC5ne4J7qotVNMKL3oYh3hIPYHejS0p7UX8muMHtIPRH7bFAOlU9ZU20fZL9f4hCd8IJD2eO7BDSVE0Rr1u0WIFibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035613; c=relaxed/simple;
	bh=KZRoP5Cjgcq1f45YrvRYeCZ9m1rJx7lSPGLRnbbpDFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uun6Pn4ZTJdoT++lM605mjsAVRTCXTQCc5yR7/fvJumMkmE0kNyFfobUzONEhAZ7ZP/qRVnA5Vo/P0yMub0JQV7A2BJOPFsjSbjfaRw3usQG43cUafMN9Ox3s1z80ZwvjwGKUPLYamBAJfeQs82uRxeC4XANfyWsHUzB4J49bWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mblRpUOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DFBBC4CEE7;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035613;
	bh=KZRoP5Cjgcq1f45YrvRYeCZ9m1rJx7lSPGLRnbbpDFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mblRpUOYEOqWYOSnuITNcxI4gut+S4GMtEBPsXPnnfU7UszxI0gowclFRYMXzgknm
	 HXVy3pOaT0OZtr66SLZ5DUnupSVd5SeMouLxhd6GP6crmzHwppONRCK78WPRVi40OV
	 UBOSow2mDH++s3WMM5w1mvkd1w+gsAuC9BzV6HU2moxPI5cWCjB6/u/38cnLK+zkPa
	 eyvq+D5a9F0K2knvmWjEktkfnNF7ZkSlSypJlOJ1o4CtXtFOMtFOubXyPXquRSuU4o
	 BaLCfjCcN3STT2FN5vUpgz4qF8247NRjMIGdqenzDTo6bTb8+YESnboViY1f+wHOE+
	 tS7i9oTRnwQ7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36004C02183;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 16:52:46 +0300
Subject: [PATCH RESEND v4 5/5] iio: accel: mc3230: add mc3510c support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-mainlining-mc3510c-v4-5-a41308b85ec2@gmail.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
In-Reply-To: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=9Z3q0OsDzL5ZwgOvYT7Efze32gsUcd3XbTfzqI4bFbA=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNI7+aOn5M9Vtetu2X/nb0/DoXDuDWe/3jxhnbnT3ODbK
 mOu+qupHaUsDGJcDLJiiiw2Gz1mi+WHS06a9lQBZg4rE8gQBi5OAZiIRinDH/6Q44tOh6uIhUkt
 f3//fn/Mc5tXJTbxkkXBf25F+B/SMWb476qVyJ6RcI8r68E9qY9tDJeire4d8/He2Hmo+O8z383
 +jAA=
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This change integrates mc3510c support into the mc3230 driver.
MC3510C uses the same registers as MC3230, but a different value scale.

Tested on Huawei MediaPad T3 10 (huawei-agassi)

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index c8d394c3ecf08fad60f0f2ae7be6fd992327d843..e2853090fa6e15f4dd74e996fae8520b30471d3b 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -46,6 +46,14 @@ static const struct mc3230_chip_info mc3230_chip_info = {
 	.scale = 115411765,
 };
 
+static const struct mc3230_chip_info mc3510c_chip_info = {
+	.name = "mc3510c",
+	.chip_id = 0x23,
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
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
 static const struct of_device_id mc3230_of_match[] = {
 	{ .compatible = "mcube,mc3230", &mc3230_chip_info },
+	{ .compatible = "mcube,mc3510c", &mc3510c_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



