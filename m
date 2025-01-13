Return-Path: <linux-iio+bounces-14285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B4DA0B8F5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1531886AEC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6223A598;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTzqvH5g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C6482DD;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=dyffu9GN1lmFqybSO16U+WB6wU2I6ibJ6AN4Vc7sGwhvDknyDrLLZtkxLttmnQJqBmu4+qVst8zpMs6L0QzIytqolLTFtEWXLXFhILkRtKFUza1tTRVHnvE3J3ghAeGFDlQ/KBSzYPPXyAgJ9IVqII+eMqEEFRKPcIS7WL/TNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=zTv1Z1EQPs9ebNg8jRjW1X2ohO4Uqa0O6o0M3vjRIZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHOt5rIr8NNJM3zP6/2aOiyGcKt7t64O3J75qkLhXcFJAhaN3VtTVUnOSc4QqNRuBxhgn68c7i5W3P+24anMsmrh65iryFi65xYsSh24PiXbgtu/S9r8jYioEjWUuTotQ0i3sl/cH36+KhQKW9p0ebia0eSkAEh7XwUCRqo8uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTzqvH5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF017C4CEE5;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776922;
	bh=zTv1Z1EQPs9ebNg8jRjW1X2ohO4Uqa0O6o0M3vjRIZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rTzqvH5gca8c5NjGhMs1C9iC30qc9sWQBVTkGP/oHMIOLSNbYKPIZ6XD3Nzu+5A3I
	 2Oo+CbMUiJIuixYSGQoCtNF/2My+JBLm30pdAI8xJ6UPDa7j+BnDXfqkPhWtdaM9IY
	 TcKdjiACI9RbtOC7i2DgIAmYPAVV+oO6sem2fx4ML6u0935deM07MFc7t1OCta9IWp
	 D09wYZTBuPO9QEvCAMU4If2vC/4LyL3hj21BkkW7S6Kxrgxh7Q+FAKmQYYXcKGDPwj
	 WnP8MCnaJesWzH3ENLUvs6lFdmRRb+d8xcT/okGy+2Q2aALaJd4X2ueH1XhbpeIx8k
	 B3D8sPRNqRukA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA03C02180;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Mon, 13 Jan 2025 17:02:02 +0300
Subject: [PATCH v4 3/5] iio: accel: mc3230: add OF match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mainlining-mc3510c-v4-3-4118411ef569@gmail.com>
References: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
In-Reply-To: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW482/q6febp6SdK70+9n6y/fs/p0t3fi34cknhzQ
 FLu5DLJ+R2lLAxiXAyyYoosNhs9Zovlh0tOmvZUAWYOKxPIEAYuTgGYSP85hv/FV2Y6XLKZwfHq
 vW5O/a/0oCuVv1levn1gZfp+3byWdRPWM/wzdS9RTTK3iOw9zi/0N8rk+l/bHca1zrXJ/w7UxsX
 e+8EMAA==
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



