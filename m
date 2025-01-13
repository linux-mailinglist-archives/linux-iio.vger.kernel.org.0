Return-Path: <linux-iio+bounces-14287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DFA0B8F9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C108E7A0F76
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8523DE94;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqBAsdB7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8423A565;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=HB1Ydw0lWs8Fs7Ll4zXCob1dzY4EJkNQga9IKP+E4O2FXdJhxUXUqkM5NtTq3G2I56LDipEl5PHVIW8OFh8TX3sdsb11WWar77rAb8vo/DO6uO2gVHSb4CpjBnkCIsQ7wo8RMbrAtpIPlXL5io5Mi8+pV7vNyd8tfITmLx5YQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=KZRoP5Cjgcq1f45YrvRYeCZ9m1rJx7lSPGLRnbbpDFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nviTFgp0vw5O/ck5EuA2Qcx+9IK3BzQV7y0yMl0bz5+4wDyjAT4eGW5I+pfwSrr4nixu/88EJKs8/pokeWCQ+m5rbO9mR1wVUz9ODq8Uk2iJQFEQ8uyeoN+XsnLMnxbyOIwpHY9rkRTmaboCh6PKCs+qXJQvcAD1yGmMMQjLb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqBAsdB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB54C4CEEF;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776923;
	bh=KZRoP5Cjgcq1f45YrvRYeCZ9m1rJx7lSPGLRnbbpDFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dqBAsdB799qMb/aGV7yniTEJfR5vfHk5bhyJUwOQr9TXU1RyKqJzykHbj38lx64KO
	 58yzqD7LwMDoqVn/eEnPPASL7UEoC2vVNhmsmN7PDxEnXYnGwzE1B2fe5lt5uCYNOw
	 ulR2KdxGbs5AoQ1keS1js+hXBi2e18uvl3NkguR8sfh+v+vhOf2kY3pBdxy6QY9Rwt
	 Re30/RQplCeng5xwf24APcuENmfzrX1jgKi97IxPakTE2IP9TeM9hsMouik2LrdC/z
	 nG/tBNIoxuE6/ZCxAJ3T3BfEyn8CKBk+E5bMq6ysOWM1rEWavqamDfsJH1onBRoT4N
	 2NtqFt7BrAHJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE6C02185;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Mon, 13 Jan 2025 17:02:04 +0300
Subject: [PATCH v4 5/5] iio: accel: mc3230: add mc3510c support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mainlining-mc3510c-v4-5-4118411ef569@gmail.com>
References: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
In-Reply-To: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW62HspgljvdcPioaZXF+7O2v5NFLJ+2pYjsyVtX6
 /HEzMSro5SFQYyLQVZMkcVmo8dssfxwyUnTnirAzGFlAhnCwMUpABPhO83IcOnLNvlDb4qNpiuw
 b9hS8vMv7/umBsWDt/LOb1GxY9StfcTIcGZ67jmB2PWHj8/9+9h/97kV65Z4Prs75e/VQ2XdB0M
 qNrAAAA==
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



