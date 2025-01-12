Return-Path: <linux-iio+bounces-14191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18CA0A91A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FFD3A5D56
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DCD1B4127;
	Sun, 12 Jan 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJVPgy29"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AA1B0F3C;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684780; cv=none; b=fTLdyDsLfdHJkjMVqjKnp4bFzOQMISaDflvPhTjCPYrDC3TADipuE0NDIiUsMRYKGSKJr5qj8mfwcexIJo9N12Dre323MXBAj5mXfUupSexiYqH3ypLT8UXGiZgCCqdX24TaVkHPqHCaIK3eL5R3wEhBooT8LcDMgl60n7OgmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684780; c=relaxed/simple;
	bh=HRChpib1kiNQdmhKWJNL1bCldJ1FJminyluLN/esqpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K56KK+KoGItZqTW/C+6HRlJxj8wjcXPYCtapyLg5SJdYsa6Dx14m0THdPLVZyKInGp900QVYHYLDPBwmfLiR175hOSOE02QnlYCVXidVRddZkuLSCIlap5wScpo2lezT9h655qanR/FF7RWKr9zLpT2IrAc65dLgdnYX6j0kTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJVPgy29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 568FDC4CEE4;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684780;
	bh=HRChpib1kiNQdmhKWJNL1bCldJ1FJminyluLN/esqpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YJVPgy29QPcTKqxGnj4mfdBs4jfhZLc3/JYLeVVAtTfGjnNKPfPXrM7x858p4QdMI
	 9IettcqqE6km3Xpqu+AqSoJ5mJawqJli5Fv3utCC6JS4WbzJO8DRmOGgtlyKW3ltmm
	 RsBJ6sYWtOG8Rxprs/Wc1Qt53bQDkZss1fGsJBMl7/53/29pjYx15NfG6y0VAmuMR6
	 IcB9i6kI8lvL64kGFX6roc0KSoubyzCOYSyb1yW8YPsTFue1XJjGj5EXMgaVuQNZ+/
	 3iUEwQFJIoxEqJqSEnoCNlTZftFMF1DY47+V8L1xQrMovgFhjUvmm+H6Og/wBiBk9a
	 3YhmPZVt+jRMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD9E7719F;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:25:37 +0300
Subject: [PATCH v3 3/5] iio: accel: mc3230: add OF match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v3-3-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=CXzfdvJmi3hz61iMY9QNCk/KSoxBmTl8+cAWMbpfFFg=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbt7y6x7/qffH/JYs9JHu/B3S5CZk2Pzf8uMrvC1s49
 0Gn8y89OkpZGMS4GGTFFFlsNnrMFssPl5w07akCzBxWJpAhDFycAjCRS/8YGTozdjL070rM1Vba
 NXtOxewrPh6bYm0fbbw3TybTbP9CaTVGhj1Ht2TeemwR+Njw6LPqIy/TJ0bfKvBdsnG7tteW3c+
 61nADAA==
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
index a153a3f715ed7f2f1417618715767f265b49191d..ba30c904d3f67002deeb3ca5a7e12bfae312e05f 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -205,9 +205,16 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
+static const struct of_device_id mc3230_of_match[] = {
+	{ .compatible = "mcube,mc3230" },
+	{}
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



