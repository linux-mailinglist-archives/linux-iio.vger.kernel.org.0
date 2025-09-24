Return-Path: <linux-iio+bounces-24399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA543B991B5
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C20A19C72F3
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01912D97AA;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey0BczqL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FF2D8363;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705848; cv=none; b=GPZ48GNHD9opPNteqH9vVKxbn49huLur9y2xUC5fwg+PxQc4OQCPfhzIp2iOe3rRSupT65/MC08s8m/ijYdSg9+ZHeudjzxPUvoeJTMHLbGI0ytqhQejSZcMqC1TFwbvKagn5a6Lc/7hlPEP2Gj8YjPYmvygcddTfO1uPnGXnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705848; c=relaxed/simple;
	bh=FbH2PxM9Sa714CpGO8aSH1L22ExqG/uqX8DLAEhiDTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wu+nMLEIo8SX43dlwEXz6lwFxP+4lm+9yamHVMSSIJNcgG2KNx/PruyZYFN5RzGId9pU1pPBmNILsK+B1UyLpAihDn9x54f0lK+YryzXkREjsJ0xwREx0B6oUPEUl7YBzC7D65AzEu9bf4psIEHCnLJgMkBqh/zjqPgXm8cIcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey0BczqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF0ACC2BCF5;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758705847;
	bh=FbH2PxM9Sa714CpGO8aSH1L22ExqG/uqX8DLAEhiDTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ey0BczqL6dYH/unFgLtYuNlx8y2o+WJ3+f9Bl6p7cP/NiewiJxQFyhyFCWdP0IFix
	 V3OZJttFhXnN1JxrbueUP0ra2QAstZ7Kb1G59RyJLtDFKyvYcfJLbUQXkQvBidFfIt
	 JDhFdqKMKHwccninPz+v6JdvQxChTnIfUwSDzyKRkeFSZ5q2vtIWdmhA6B1+i1S1nC
	 mY4TVTmY92n6vWTsTcYFY1n37ARN5iXLY2E4aIzcmt/LxIRhNINk7epTXSgJ5XrTGt
	 CN5vmnAcgCdUs+T1/YXFfjiVPj1ERenyKobYEoc8kkSyew13jWz47Tb2IgL52ivEnp
	 i1q1SGnltRhBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6161CAC5B3;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 24 Sep 2025 09:24:02 +0000
Subject: [PATCH v6 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-add_newport_driver-v6-9-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
In-Reply-To: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758705845; l=945;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=d1EOGq7hV4R8ODh9Pkno9yFBZYn1snN6feaEcuqfxYw=;
 b=jO9aEgfgV1aFZf5kL7w+Zecte86+IBTqd9F1PyaQRwrg4psXoUeaUonoxzdArkC74MOryQilu
 brdWSBp/WhEAS0rMaT+Z5YXomtBwSGsr/tkWjOEVxBvVxHw8olnrJzT
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
index f090c2f6e63a0d255a025885cc4573f5802ef159..02d8787ab768a2d0b8b72a2c909e56a0f2010c04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12815,6 +12815,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
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



