Return-Path: <linux-iio+bounces-17951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2CA85EED
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455107B3592
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239A1DDC28;
	Fri, 11 Apr 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgJvMBCj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1E1D619D;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=qg5Q1RV1z0s3rGYQfgeFPt6HxwIDN/PNCwOYCuoWp8azOQ3gOSBKqLyyUj+eR5Jp/1m2EV8r/Bgf3lnM4OPcS6FSzscw0zmjyZI6aI1TDN4k9TUQvqWeo7OXZwpQTrf8KWdUWTrxdoq4j66paiEmyvVxbeNVDnU+WeE+mXD0nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=TpzgJyJ4WTRHf6o2yGhmsml0lRhJS4SJG/+gmJU5g/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O13fce/tTALGkXVz44YoUek9LtqYboySsXg3sE1YgqGjn5ArJQlxQguEzRkO+SEzYKOb+FUCzzYK0ow7bSPGtvoORUjydxwTP+mxV4rwvARc0AEp/dqd2LAYdHEPrtu7T+2qSafljPMIibJKZ0QQI/uoU8gWr33lf+luR3RfPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgJvMBCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C22C4CEFE;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378122;
	bh=TpzgJyJ4WTRHf6o2yGhmsml0lRhJS4SJG/+gmJU5g/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FgJvMBCj1wptdBewuoIqalYSa+l25zAazIgnnD26vd9xp5U22rfVHLSxNAz3ju1fm
	 caHaKl2vgqKs9U5Vaa6kHx/tCuqgGRvvcAche5YupaF/6fApa+SYjXvjbUYFekQ/nC
	 CH6/4IBxGzdUf1Rq0lOgHaakKYq95ou794nhXSljEgXLMeih/job8Yl5Z5LZm6ewgG
	 eepDQVEXS/X7uUqHJPcJFSvJDfQh37zHyfDPbEp8PAyTnrhaeziS0YYx9oRsg67nKD
	 eaNaKlsQQO/6p4DWUVWQw6Rx2yRydM36UG05wICk+2Jn7ZfBEbmw0jYKNnn0zvbQvP
	 mAzpWP5f3ujAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120BC36010;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:40 +0000
Subject: [PATCH 8/8] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-8-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=1004;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=kZKXeMI2KjRSPBEamKTN7FTc+Klt4KAQtMhrcXfCwTE=;
 b=IfheCnRVke3TO/1sC7BKOQBfcx8MRmhZxO40Wzel1Rw8pIIhLmJ1HRv8hMIwimGglnkaWY+U1
 JjDeXdxmdAPA25jU8DvmoGjUiUNRWSsy5wi78s0uiFc9TQ1aEevNdBl
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add MAINTAINERS entry for InvenSense ICM-456xx IMU device.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 030d90d383411bbfe949cfff4f5bce27e3dd37c4..2d4b6755a9e240432ec1abfb131358ae4df48362 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12397,6 +12397,15 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
 F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
 F:	drivers/iio/imu/inv_icm42600/
 
+INVENSENSE ICM-456xx IMU DRIVER
+M:	Remi Buisson <remi.buisson@tdk.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://invensense.tdk.com/
+F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
+F:	Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
+F:	drivers/iio/imu/inv_icm45600/
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1



