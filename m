Return-Path: <linux-iio+bounces-14136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560AA0A5CD
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A1F1888BD3
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 20:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA71B85D2;
	Sat, 11 Jan 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxZ+DqVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FC17C68;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626269; cv=none; b=eFpfyUeyhFCpmze+qvtiGgdlmfO7gC+EDx6VXtFaCohDQsk9eVmKlmKaguCi9XmN6G7r8YIa7kmKI3RHsJT4caGHGwxOQgHByqmnRVEQol0tR8qfndfPkXsUPSnyzSA5cuyEeYrwyJv3cu1tJNAaAKRKgmTHgJPqOc7gLdi6WHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626269; c=relaxed/simple;
	bh=5ckJwbgDkVzT0dqCQsFQCmmS29DfhOI72BOq4ZYsdFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoGcUCwIyUdUQ6yQej8uQd165hOSP4TnCUNAMtwNdUD8EwSBSBM4ZX4+bxQCr/AXFvni0KS8NZWZJYTs2JZfzE4VrxfmFoJa82uyiRyb76x9KS08qlizuU+kPyzuPEafTftMXcJ7ftS1jMCcxtPOoPhilgzhrzO9WnHC7RqZsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxZ+DqVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DF2FC4CEE2;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736626269;
	bh=5ckJwbgDkVzT0dqCQsFQCmmS29DfhOI72BOq4ZYsdFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WxZ+DqVOkdn0NNomRCrUyRQ1TgVJ2m/YwmKyzNJNuBnB51XC01/B966jTqBh/FMO/
	 ZphAuN6MJ9dMRdchUOV3qVP5O8tgaYVWEqDbyT5uNWhcPTLPbsvMQOUAPVwQi26Kdq
	 cdGGfZUAaBtMsl/+42TK95yVPEKqv0mqmBwsXcts2/o9aQzMLjArUcdm4TSxs29IDK
	 x8kgJph0g2TJ8g+FardVeQTc+qriY5paSmUale6Y8D19oH3aIzPtIFSh+4e62MqcWs
	 VIVIVu82ACWTtbnIkWsinpWUYV4XnWTlcLILL5T32B9X3pUrFMIFBl4WtxX8vMheJt
	 YJgi/aowc0eoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FFE7719E;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sat, 11 Jan 2025 23:11:07 +0300
Subject: [PATCH 2/4] iio: accel: mc3230: add OF match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=7FltGDA7Coxid4ukNBq4MOgPx0ilGEOInxc3SWRtDZo=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbLkQXqk604ZqZ3uD3w+n9O5OpE+e7r5Y7UG8U2vfKb
 NGhgqRVHaUsDGJcDLJiiiw2Gz1mi+WHS06a9lQBZg4rE8gQBi5OAZgI7wFGhs+ZeXaLuH+/9zb+
 9jhy6Y16dv6WzU6hE/at1V/V+uX5Q19Ghovsls9ktq6dIb/xb/R2jfRGqxlSwpN0GF1Pybbe3r+
 PnxEA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This will make the driver probe-able via device-tree.
While the I2C match table may be sufficient, this should extend the cover
of this driver being probed by other methods.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 48787c0494ae6f0ef1d4d22bc5a4608035cbe123..3cad6f2d7a2a79df38f90e5656763f6ed019a920 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -205,10 +205,17 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
+static const struct of_device_id mc3230_of_match[] = {
+	{ .compatible = "mcube,mc3230" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mc3230_of_match);
+
 static struct i2c_driver mc3230_driver = {
 	.driver = {
 		.name = "mc3230",
 		.pm = pm_sleep_ptr(&mc3230_pm_ops),
+		.of_match_table = mc3230_of_match,
 	},
 	.probe		= mc3230_probe,
 	.remove		= mc3230_remove,

-- 
2.47.1



