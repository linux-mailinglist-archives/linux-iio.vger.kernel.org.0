Return-Path: <linux-iio+bounces-24808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CEBC07C1
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 09:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17CA3AC4FF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B204123C38C;
	Tue,  7 Oct 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRDcznWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA6239573;
	Tue,  7 Oct 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821610; cv=none; b=Gy6rUd5RualvgC18/O/kL8r4RUIj2bXyC23iP7c0HWn8VEw12E/Aem8vxtD+FC+nCWUL0umtas21UG7/pU2+TyExihZiJJ8ZLK5VjEfP4vUnSxgM2LHtElMSnRcoTk1ZrGE3mh9oS2OkeDJc3pdQQzGY6txlB0qUe6yd1tYMHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821610; c=relaxed/simple;
	bh=FbH2PxM9Sa714CpGO8aSH1L22ExqG/uqX8DLAEhiDTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MupaGlQjkuYS9F1RAmA+dKxLmh75x1hTAZdRxK6L6QEaJNEwsDuVF7aleWHwq7UN30frzuMoD0U6Adho31CL/NPi/LTkfbTA32Z2aO0V5z+Za0ilDchIR640t7+E+M4C/r4W1UT5Au0aTHCGy06KBO3iMNp0GQEQscoqnnRbYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRDcznWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3C46C4AF0E;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759821609;
	bh=FbH2PxM9Sa714CpGO8aSH1L22ExqG/uqX8DLAEhiDTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kRDcznWrqA7HYQ3MmA2TilTWoQYsAsPjtQjs/Se9XqY+YCgJCuu/UHPehHSJ3jTA/
	 fH9nj2YXRUqEV4s5IOjKvonFFrk6SL6iVjVdcEKBVOeKPqr/UbigNAKKE2Dx2r73ZJ
	 +gIZfSztFhwmAEqgP18JwH7WEdU/eW0In63yNacbQCd4WZoMrZVY51RUteu/keZgnX
	 b8JogDI13g+jFNmDlXmrC6PrkeX9LsuJDtj6YOCWAuGarnDSiHSh0H+sorV1ZIV1l4
	 LOoKySqE/IS1knWDHXAA2kueHZ7+VCl/W3/2wAnTWW2NLNiD8lqOKBPfW900eJDuNX
	 E89ZBf7mX3+SA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF82CCD186;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Tue, 07 Oct 2025 07:20:10 +0000
Subject: [PATCH v7 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis imu
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-add_newport_driver-v7-9-137223a1f79e@tdk.com>
References: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
In-Reply-To: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759821607; l=945;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=d1EOGq7hV4R8ODh9Pkno9yFBZYn1snN6feaEcuqfxYw=;
 b=tKrTxuseMaAskCaKxAZPF8nMN0Z5k6k74/sZWArRLHJ27luTecHTDRrRn1P3eMZT8RdKsk0NM
 0pyETsL6HUZB8yE9lFbOsWrOpuwjdYm2mz5CQITKoG7ZXzem+klS6Q+
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



