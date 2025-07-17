Return-Path: <linux-iio+bounces-21744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301DB08E28
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0FC1AA4982
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE972E5B26;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIxM8KGw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653212E54BF;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758765; cv=none; b=bC6SzK9IiyeuuVIHtyQRWEXzrgq+8/0WwwKlYuWGf1hdEJSASm9bygsfPqk8B2c+2Ow0z6lW9hkoYAgbPuDLmv6WPV3Fr8VWqMyjLd0AwW69WDpe1+mXejkMkPB5gNzuvNL5JRWW9MfVCUjaiwwapJVEEvaR62hI3aJ7FhEQe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758765; c=relaxed/simple;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ+DLt8SCV6Ua8DqieG0d5X5OjgMYVWH4mUZQvxsTiw0SzsQBUq9ViRETo9shJQ3H9/Jsrr5I1NZILS57C/S5mccaqdyue0al3mfNir9QpNQv5qcfFwjVYfD8n49hrMImd9i+2LecKYLdEwdLXY5J7qdsyvK686Fs8vGJRYa1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIxM8KGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF96CC16AAE;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758764;
	bh=DSLa9aPeM077q6gvw6PURI/pH8PombVAOR3qpaCktpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KIxM8KGw/o3vWJ9ANjxrG4XGzJuQH4lvFyhbF6I+QU+uZwvA650isFQrmBA1KHkA5
	 fV4IuB9YAvsSQJh9mP00VjNch6RtMlodRxwpLsB+fpUEjX2kixzM35QlT6cwJtkt6o
	 78m8K46Ib/9KFuRaGjaT3P0RORzLzksSN4XRH3LS/cJuLgSQHMahtXXF7dRNLJy3RL
	 Ejjkoi3Pa60wkfniTI3wCSrUXrv6DWoVtv77dTJQEtWPNlKmrX+sCAM4wWAfntHFJ/
	 BqQxzRRSUI4Y6WpX8vVbDPcRjFdNQJZXqIOrtLT57M1Y8TIUUx4h7yZzPJ0p7duKKg
	 ZYjaoSI4oaKOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72CBC83F3B;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 17 Jul 2025 13:26:00 +0000
Subject: [PATCH v3 8/8] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-add_newport_driver-v3-8-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
In-Reply-To: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752758762; l=945;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=8YxNmTOrgJXwqprkXECUw3/UJ3Lll4HOZd/QYkpH/Pw=;
 b=CRISjZffD+SMhq03XiO/aPRwjozD/Iq3lIPbjJZ7AFMF16jdUTKaZhGQIW3Pr+EfbdOc5DKtJ
 aZYj2vp/2YtCuYmDqZvNODY9OgEl9hNTt0+fjTVo2H6ctP5NuqHLsrR
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



