Return-Path: <linux-iio+bounces-17943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B58A85EEA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F731B824E6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512D1A08AB;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8+DQyJt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD061953A1;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=tBn+PlpornDBf2omGj9ndjD6q5uA3v0QNxVGU5OIpU7KgOH1oMThtGNOCHRylh6CymiU+FeLyKBS258lBOkdsC1oUW8TPXU26sLmvviXkTqoCk02au+NiMep2OjIvwr/Kg+u3j3Rd7LyEZa2mQKhKCRrhpmSjFzzgXFup5dyxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=JTFeAmlNUSNT8ZCwFvfBb94G9sBpagRzzlhSQPzjPuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ngA6L90pbhAI9aGjrOsfPydbmyvEthaygtYDo4inYnUeCj4CK3SMEJfdcZepakvIjwRXKRQbVI1foLqFSjvXoPVgwOSUAmblzO1hirji5w4dlaBHKJgN7LM0Slxq42yWLwl/pnKwZfLSAcFya7TIkMzfWYvm63LLGR+j/ooDOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8+DQyJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540E8C4CEE2;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=JTFeAmlNUSNT8ZCwFvfBb94G9sBpagRzzlhSQPzjPuQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C8+DQyJtRiudZWe//jrSm8rM3yGEbMdEk6EE6r/mWwM7tkH841hYl1x9RZEWfvQNP
	 uIa7TKd4Yf6sznA8DjBqJQ8J3JblH3Yx2DWtPXVwNgELLmP9zOmrYOBcNV4jI5ChkC
	 36GRqHmkoFpeXt+e1m5fzg+bgRiDlgysJDCnaXMM5CaQgT7KIGeTgo01vX00iMe+OS
	 yWXGTq12L5pirpJReRuiLkTq6frXzpNdrmkUgD5D9J41C4IXj/apw81pv6LQDcKHvr
	 gMn3T5HiUfmI6EaDmjv+PbxyS3hbNTSIpjhVdq0HvU2Or39TSuNLqWpmfhAhux/7Kc
	 YGk0eyM1YoXMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF30C36010;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Subject: [PATCH 0/8] iio: imu: new inv_icm45600 driver
Date: Fri, 11 Apr 2025 13:28:32 +0000
Message-Id: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAZ+WcC/x3MTQqAIBBA4avErBNSkn6uEiHWTDUbizEsiO6et
 PwW7z0QSZgi9MUDQokj7yFDlwXMmw8rKcZsMJWxVa218ogu0HXscjoUTiTKmm5e7NRo8i3k8BB
 a+P6nw/i+H+nmgslkAAAA
X-Change-ID: 20250411-add_newport_driver-529cf5b71ea8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=3510;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=JTFeAmlNUSNT8ZCwFvfBb94G9sBpagRzzlhSQPzjPuQ=;
 b=XoowJUulQzLBGMCFbu7uLJJggxGchQ3Sx0Ejb/SubI1Aw+8gPq5kCr2SuM4vNBpFaQJeoyTX7
 AExoWdEVozADZ3mPgpUSLrb4zbNEWD98RtwTXER1rdmZsalZKQ1TuMc
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

This series add a new driver for managing InvenSense ICM-456xx 6-axis IMUs.
This next generation of chips includes new generations of 3-axis gyroscope
and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
intelligent MotionTracking features like pedometer, tilt detection, and
tap detection.

This series is delivering a driver supporting gyroscope, accelerometer and
temperature data, with polling and buffering using hwfifo and watermark,
on I2C, SPI and I3C busses.

Gyroscope and accelerometer sensors are completely independent and can have
different ODRs. Since there is only a single FIFO a specific value is used to
mark invalid data. For keeping the device standard we are de-multiplexing data
from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer and 1
for the gyroscope. This architecture also enables to easily turn each sensor
on/off without impacting the other. The device interrupt is used to read the
FIFO and launch parsing of accelerometer and gyroscope data. This driver
relies on the common Invensense timestamping mechanism to handle correctly
FIFO watermark and dynamic changes of settings.

The structure of the driver is quite similar to the inv_icm42600 driver,
however there are significant reasons for adding a different driver for
inv_icm45600, such as:
- A completely different register map.
- Different FIFO management, based on number of samples instead of bytes.
- Different indirect register access mechanism.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Remi Buisson (8):
      iio: imu: inv_icm45600: add new inv_icm45600 driver
      iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add buffer support in iio devices
      iio: imu: add Kconfig and Makefile for inv_icm45600 driver
      dt-bindings: iio: imu: Add inv_icm45600 documentation
      MAINTAINERS: add entry for inv_icm45600 6-axis imu sensor

 .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 +
 .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++
 MAINTAINERS                                        |   9 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/inv_icm45600/Kconfig               |  70 ++
 drivers/iio/imu/inv_icm45600/Makefile              |  17 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 421 ++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 902 ++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 572 +++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 100 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 906 ++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 919 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    | 103 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  84 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 110 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c   |  82 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h   |  31 +
 18 files changed, 4501 insertions(+)
---
base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
change-id: 20250411-add_newport_driver-529cf5b71ea8

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



