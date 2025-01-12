Return-Path: <linux-iio+bounces-14181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9126A0A8F1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD8B1679DD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D941B21BC;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0xIPcgT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6D1ACEAC;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=fzXhbLnTIoIqTBQC85peCNZvWxDaDvjc18UK0IeUT8LIWtqiw80TFUAOCB4te9XOiO0BVCZu/HH+CZF8YGY60SlM4JXmAwTkq7W8Kc8XDxKRZtao8MZ+n408Y59yDrGz69yZA3c1fsxXNSPImCTJ1Dct9nU1ajT3GhkUY7/bMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=HRChpib1kiNQdmhKWJNL1bCldJ1FJminyluLN/esqpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZasRlpZaVkHwHandi+R+WUA7A2E86COl/tQVVkxyNi+ftq9KHahrRUmfTIsstmnAGpd0xRcSSCE8npb78k/Nb938Tsns+Za7Hdz8Iq9FGZGkfhkOHdJGpf2WyeUVC8+glk7q8+NxClzOl7MdsqxnaozxBCbM/cbOzQM+LDsOypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0xIPcgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4AF5C4CEE7;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=HRChpib1kiNQdmhKWJNL1bCldJ1FJminyluLN/esqpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p0xIPcgTW1uS6ioXxaRb2rV9Fck4hDH7lbWxjtEcpQbk59QXeVVo3aOxOeakCakaQ
	 isI2gSX4tI8RmmCOcZLVPi6J6uJdfKpEXTyOY6+GG0OmPlcdPceoDg+5H0Q+e2mNH3
	 fVM2w4VpsB0ZmmR/C6r2orMuOlyWoXTS5oM2Mop2zNlWhVjz2mAttp+BJ3SEFOk0kA
	 vIXdtnZJVWNE9kJirzS3ZV7GUAZlqeLTlYCGK2HYXWSweljKKNCLmOqFsBSKzRMBwt
	 KsJ8btltfVQv0Vd8fu/MxQHJQi3APovxqnJnTo71f+iFOCRlTXa4qRbYtKoyrN3LeK
	 92tkYBeKuG+6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A53BE7719E;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:06:04 +0300
Subject: [PATCH v2 3/5] iio: accel: mc3230: add OF match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v2-3-322804a545cf@gmail.com>
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2gdmbirteXk30JTrounr71kmb+i+NyFeeaNxYrCb
 4z3BvRad5SyMIhxMciKKbLYbPSYLZYfLjlp2lMFmDmsTCBDGLg4BWAiC3IZ/lewszl6str/e2uh
 zXlMJGJDNMedSe4a/ff2xHV8c134U5CR4WBF01OPT0lbDT29Qg7uMlax0hQ4XpR//Jx02pkV/ZN
 38AMA
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



