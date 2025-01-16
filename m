Return-Path: <linux-iio+bounces-14395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51EA13B4D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F233016320A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581F22ACFA;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4geFgHe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAE1DE8BC;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035613; cv=none; b=nNmyczaq9C+H5GtRCVECQGgxNOjTKWV0CM8twPP4WR5dtsXBqCqh0cNKlZ2k3D4Rp+kuHePj6UNeHGdqu186RAUURKE42HAyPhQ0t9UlbrO9HiywpejM1+0hWExGvvxmlGmFCBMT+MvwdA1TWScYmFRdB+3kOlUFx0++eMqgEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035613; c=relaxed/simple;
	bh=zTv1Z1EQPs9ebNg8jRjW1X2ohO4Uqa0O6o0M3vjRIZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbTm8Y4YSq2vLUszFZXfrx36oy1j1N+9tgrxEjDFn7ka3XdMyEhq2dSjlkIO+BceQBT72zHwUqS2wrOMQvauna1wOTgIalDBDF547k2xSXRmdsOXSaBTojo2fL8wmuw01IVZM+I2Y4WNIk4Szt8hhmMh7S/OIaC2kWgnvj50NGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4geFgHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F330C4CEE6;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035613;
	bh=zTv1Z1EQPs9ebNg8jRjW1X2ohO4Uqa0O6o0M3vjRIZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L4geFgHe58rK/tXhEJZEN+SH0V7eFPuMeYdsl/n495bzxey92sXuTQCmASo1Y8jBJ
	 ww67smRIHdUmvwU5/KwqsqfAOhqWIx96UlVbACVrGZtCjmj6SxyZjee4RoN6hQsm+L
	 FVwIe1KinpeS9oZFxCksN9Ft/9o3UZzKXC0hIKSOTvIFtIs/QtpMNq+p4SnefPCMSk
	 Xfc+caWREDS639vmYjAwOM420surtsw3n9c9zTVVVf5FIeVw+7OjWS16lvQqNMn5c3
	 jV1Oc6Zck0wu3pK7oNHWxfOc/JFQIvy5GtHaMgGytHtd3chs68ug7H5NWtcrgpcm6K
	 z6siVD1EQFybQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4BC02187;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 16:52:44 +0300
Subject: [PATCH RESEND v4 3/5] iio: accel: mc3230: add OF match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-mainlining-mc3510c-v4-3-a41308b85ec2@gmail.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
In-Reply-To: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=Eg7uHGOE8j/UlALdyIln75Y0DBThMlnXhDZzImwRew8=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNI7+aNrtu8PdDjAGj3vxqWZ3yKLm320nptcZHpQ8nt/O
 OMpBWaujlIWBjEuBlkxRRabjR6zxfLDJSdNe6oAM4eVCWQIAxenAEzk8lJGhncfk978aZnKN/82
 15xpP9pFNtwJm//22fezPaf2Sk1b187OyHDCZcKUOR8vX90QxlFzr1NyT6q91MKDx+3/an7gviK
 /cRkHAA==
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This will make the driver auto loaded via device-tree.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 48787c0494ae6f0ef1d4d22bc5a4608035cbe123..443b5b30c83144478c27a86dbdc12e4e944a34df 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -205,9 +205,16 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
+static const struct of_device_id mc3230_of_match[] = {
+	{ .compatible = "mcube,mc3230" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mc3230_of_match);
+
 static struct i2c_driver mc3230_driver = {
 	.driver = {
 		.name = "mc3230",
+		.of_match_table = mc3230_of_match,
 		.pm = pm_sleep_ptr(&mc3230_pm_ops),
 	},
 	.probe		= mc3230_probe,

-- 
2.47.1



