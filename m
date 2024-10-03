Return-Path: <linux-iio+bounces-10041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761598F08F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE3B1F22617
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70319CC2A;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pcxa1Tuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC819924A;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962713; cv=none; b=sLSJwdSZGAuEM7MSXapVzXqNBOsNY+PHqu7siuFF2M55FHnC053Nq1x9oCSL9kqgGMUMmHrq/+7+LcwaHrtxvy0wrWohXtR7zmHhJeRGR2FFgNCKHfbFAh2cmNebxoNp5413hGfrcvbTlF81DKdd+uuUD4+TqPEqgPF4nlg+p5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962713; c=relaxed/simple;
	bh=Yh1+Jz+G/zOBL+JUbr6E14GtoYGYiM4uNAljwrvcXHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGaJUmDF44YeiDWew24ocxHSZf3PkV1YHimZQA2hd2IbmVci6qE109G06wLWLhNHmI2uF9uS0weBUZ6YcPSBJ3bNIqQxU3hN1neuNH+XOF6Au075z8rUEX9XgTM51jBwoZmWT3Yr68uUnMmOq8c8jIFk4I8SyRePQDgQzvYItHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pcxa1Tuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21014C4AF09;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962713;
	bh=Yh1+Jz+G/zOBL+JUbr6E14GtoYGYiM4uNAljwrvcXHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Pcxa1TujHLB5WtoGECty8BFxOcp32W8Pv9QGxvVyploEqrnrta9vu5H/IK7ZHJHnD
	 EIJuUWfZYTF5iWEmRb9NSzrLiNcg5GyvLUGHYYkCDr2Xz41M7IUE1zAGBBWs1bcwYG
	 aumMwZEyl8JjUOcgfaqmTFOFygL2PjRogGYgODngMl3xUEM3HC1vKUYeX7GjWGEcx+
	 7JBXoFsl5azwsEA/ishmck4EJw/EAcxae5Nfm0pBuz0SHJ1uTrHKkQX0DrtJ8Jjy6R
	 dMWKBPifL++5NoUKlYeMMXMvdNZ4UoxD0QTtdjLO6AiwoiTAaJf5vqFqlDUvQUhRGy
	 JUA7TxNO5du9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D804CF34B0;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 15:38:23 +0200
Subject: [PATCH v2 2/3] dt-bindings: iio: imu: migrate InvenSense email to
 TDK group domain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v2-2-ca5a4928eb22@tdk.com>
References: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
In-Reply-To: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727962711; l=1864;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=DybIVhKCi4bPulEQmXxcvm9H4ZEDHA0y5F0jLGpcXko=;
 b=sJTVx34ZVbPhBMBDh4+yZ/ghi/Z8diyRev8Gqb/xvJ81SlNJ1kMSVEBr2AGbVRgtbwzd9a4Dh
 EGQxeuXBvnxB4M1wg4kq5I7iguw3Sp/jAtyqQMoMAdcVcBKPtFnjjN1
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Migrate maintainer email to TDK domain.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 2 +-
 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 3769f8e8e98cee3db61cc0138f485c488d55a63e..7e4492bbd0278a336587dc5ac04da7153453da29 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: InvenSense ICM-426xx Inertial Measurement Unit
 
 maintainers:
-  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 
 description: |
   6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index a8d30ef015faaca02a11af7def6e06057bde3909..f91954870a44c60cadc76b5bc3917ee6f23e30a2 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
 
 maintainers:
-  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+  - Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 
 description: |
   These devices support both I2C and SPI bus interfaces.

-- 
2.46.2



