Return-Path: <linux-iio+bounces-27452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C317CEC8F9
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0FF300C6D4
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC23043BE;
	Wed, 31 Dec 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ZXpBYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF142F1FD5;
	Wed, 31 Dec 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215666; cv=none; b=tDVAiDnWdx94KHTB3ozgdKhWBMBub6WyKPgqAl+cxbLlsDox4GDZkCwrAmRBdiisewqUYE7I8Y0hIQWfmKYOGURUCXz9COPohNsbIwbBQ99L/CmSibva6Ois9SYtYtO91m4fvNnGc61eQYujgYMzROoVbhCKSuSJHCo672WANeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215666; c=relaxed/simple;
	bh=xHto84en/EpD6//k9zvS6nVYcDGIzO5ea3fCpM6w0qY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BCn+ELwwQAVgf7lc6NJf4+Bh5Ax+UuZxcznJZYDYu/RKaO9xQkrQyLZH0T80kGyT1uuxk42io1b13DG4JnW8VgRUfLj390bbQSsnTlt/Iho5chz2cArNPEraaPYb776WrWmN6z2jvtksYxLIUvj7nNj9ft2lhqvb4ta2y89b5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ZXpBYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A3BC113D0;
	Wed, 31 Dec 2025 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215666;
	bh=xHto84en/EpD6//k9zvS6nVYcDGIzO5ea3fCpM6w0qY=;
	h=From:Subject:Date:To:Cc:From;
	b=G9ZXpBYkWbssgqzpZfWl+4b//qwKGIiQzo3Ee0edj3xRKiktG4N82TQUPqovn6IGr
	 17QK/2nzxz7LLauxRhfQdv5H8LAIF8U16GahCTyaTG4/FnoH31OhwdTAu6XWYjK82B
	 0oPz4LL3ylsWdnchiW+yTKs+je4IMwMFUbhZ0lqBQL13by763RuEDEv3kAJ2+nE827
	 jTsTDFOaTBtdxituRt+Tvlmb5Uvh7K+HIN/JfhFOTQre61qlcp12gT5QoRjYWT4o69
	 rpYpxSzSg5DYznMZfQJkqYPi/2oBSclzcs547xwG3dPqjFuSXFs4E2JNPsTJeK5jxB
	 m7a8rQgNXZttw==
From: akemnade@kernel.org
Subject: [PATCH 0/2] iio: imu: inv-mpu9150: fix interrupts for MPU9150
Date: Wed, 31 Dec 2025 22:14:15 +0100
Message-Id: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeSVWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2ND3dyCUktDUwNdgzQjM0MTS4MUQ/NUJaDqgqLUtMwKsEnRsbW1AM3
 fM/9ZAAAA
X-Change-ID: 20251231-mpu9150-0f261490d17e
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=xHto84en/EpD6//k9zvS6nVYcDGIzO5ea3fCpM6w0qY=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJmhk7T/iD522B4n3xO1IXVxY2Yk45UmmUVNz1YFeRoEN
 5/epNLeUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwER2qTEyXNQ59vhVUVpThffF
 XNaUyeq2RW2M3Yk3k41nxzEpN33XZvjvkfeJdWOW5xWV50euZf3MzWzwfKeX+5vhzMEZOq6TWoq
 5AQ==
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The Epson Moverio BT200 has MPU9150 chips. The devicetree has a simple
typo regarding the interrupt of that chip. Simply fixing it unweils
problems in the driver causing IRQ storms by calling
iio_readdev -T 0 iio:deviceX 

With the fix applied one IRQ comes per sampling when calling
iio_readdev -T 0 iio:deviceX which looks like sane behaviour.
Probably applying this series has to be split between different kernel
releases to avoid having fixed devicetree with broken driver.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
---
Andreas Kemnade (2):
      iio: imu: inv-mpu9150: fix irq ack preventing irq storms
      ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in iio device property

 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c        | 8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h         | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c     | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)
---
base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
change-id: 20251231-mpu9150-0f261490d17e

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>


