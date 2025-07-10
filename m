Return-Path: <linux-iio+bounces-21518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C720BAFFD4C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4D25404D9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C82951D3;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq2texk8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2ED292B44;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137883; cv=none; b=G/6Lrodpr7rC2tF+IDjVxu0rPKiMMVXy4C6ISe2lkG4CkyP5fWthAxMJ5lYtnbv4Kw9n57pSti8TNaennwBht1tTs1bXDWiHlr5RkYPqFRbHqRfyVP6amAFMjVpYtw3c2Aqk+X4jWvZX4DOfgEfF/K3CuHaQ67H6KU53b33keHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137883; c=relaxed/simple;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpegJE81H31CH/nXQfH/C0Kh7/uwTOQPR7bAr4JOqMkutEY6/0SvJFTWiPYIbsoDTvymsXiDnokgt1EAJJO0cDW5Tb3/ZSN3113hEK/OU1fJ99sT+FocqQ1pLdFfyhjaU10H9tpcJE+QrPNn3RPGadzf8EduwRk2Q1J6q8QDhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq2texk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DFE9C4CEFB;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137883;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kq2texk8gHxg/rLT8FB5qi4XlE1hTSvHSat55VirxxkN+40n4qNpfoOVPydmgzas/
	 h2nopZvW4njGS3ZSvvhsQG6hNlZQxAAMLOq7ZVWrdUmFYNeNLREFBFCeV/4ss9+TwV
	 Gr6TObihPoA9jwkdQSUFP08elZlRG1X52pYivFpxRZETH7Cw9DkQSFPcrQV3TPlNLf
	 ntuxeai6/Efaf5pBSmri7Zi9RPHyzEsnb/jicng0mFwy9M/3YLdVPMkCtZgFBkKL4m
	 Y22BFQqzsyPeuBINYxBX152ebeWWy6zGMuqPl/0X4A47JauKfQO6lyjKnaqlTYsoOJ
	 mAX/UR5ytZ7GA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344DBC83F1F;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 10 Jul 2025 08:58:03 +0000
Subject: [PATCH v2 8/8] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-add_newport_driver-v2-8-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
In-Reply-To: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137881; l=945;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=8YxNmTOrgJXwqprkXECUw3/UJ3Lll4HOZd/QYkpH/Pw=;
 b=l9dnyLhdkDbIBE9g0pBBhegUR2yle4XF5jKqvHXz8W23D53L7Ta5JiNhn5evxUXPgXEv0o1T8
 KrBw4WHxtUFAwyoXDg9rLdGVfjmGfO75B+mYTZGoA41zSRm88cnaXki
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



