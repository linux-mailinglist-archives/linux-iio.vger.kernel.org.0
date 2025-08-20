Return-Path: <linux-iio+bounces-23063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B757B2DF4E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F34B1BA787A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688612D94AF;
	Wed, 20 Aug 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e92CilXH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B855276056;
	Wed, 20 Aug 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699886; cv=none; b=oBJKstOkjLnliY5yFEXkcM2IjaJz1z3BDX7bLW04JGq9G6PGCZR1p85mvD3WNxVJRgy0M7BpeG/2lw5A2wABsoC9SKbgGqGyXbom/3OzCQmoML8sI1a5aYwUoCSIRCs8HtBMyyUOy1aC/UUJoBo4ZMJOiHqqG1+wRBCwwCBjCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699886; c=relaxed/simple;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbJDGJC/PSDy7pnclYBWxjSHnMqYjcW3mHbgfH9kF/Jw/uXUykELvyas1IrR5R92PEsM0V6bfaTflqWPefSuf6Ugz92IS8AIxMXAzJ5UX1ykiVXOgWGmYmzWsr1nkXfQGsc3N5SYkGsW9Fhqb52Q9ixLo9NpWms5MavkGuUUzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e92CilXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D795AC4CEE7;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699885;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e92CilXH6toh7fbFiggE1hj8Fdl4chdqL5yNYouWGxX7RA/aiqrf24Us5SkBvTiBr
	 0rKYE87R5CYUbe9zcKp5G2vF0noeTQEi6vlz3cCzqd8FPAGwJ1y+a9GF7D/9QLkuzD
	 MbeVb3T37vhuINd+q2/HF9PNLJKN2AHHPDeGNYXyyd7kRwBm0S4WXhBMVWa6RrMDKa
	 3vrr5YYdWie0wuMKn1iTKXL/7WQHjHw4JRgVqxMXlqBPdTZEKdtDidk1N9pnO/sA4i
	 LbB5snMyCyd24oksQteNXfzI3sKAH7HSrbhy9qyW/Ejd3pxg9qOXnBhOLdwIThkfq7
	 rDseQs6DIK/aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3A5CA0EED;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 20 Aug 2025 14:24:27 +0000
Subject: [PATCH v5 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-add_newport_driver-v5-9-2fc9f13dddee@tdk.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
In-Reply-To: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755699883; l=945;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=8YxNmTOrgJXwqprkXECUw3/UJ3Lll4HOZd/QYkpH/Pw=;
 b=HJaXGKCqmI2IHecPQQBsr53fRhNMexXrqMf5baE5x2/kZUh5ZtPdSaUAMHY2AmZBW/4HnFnCf
 lUaHT2EoktUD1G5vNW8L4bQs43LajAA6ppEhcdCu36tduZ2Jc5d1n+/
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add MAINTAINERS entry for InvenSense ICM-45600 IMU device.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3b0109a23045926d6a7e9659afdab0a6dbf7bed..c4aa2102ef398130074d20dd5b9367ce3fa51968 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12621,6 +12621,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
 F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
 F:	drivers/iio/imu/inv_icm42600/
 
+INVENSENSE ICM-456xx IMU DRIVER
+M:	Remi Buisson <remi.buisson@tdk.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
+F:	drivers/iio/imu/inv_icm45600/
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1



