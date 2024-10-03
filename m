Return-Path: <linux-iio+bounces-10019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E998EA81
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554901C215F1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C312EBE1;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjGDDYjY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AE126BFC;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941075; cv=none; b=jGtVHjEQiohhuDrR1/R7luFf27Yb3+MKZJaVPZOVPbZYtQLZ+t+eABukigkl8weZSq2j8H5EG2b3NYGWDK6D0LIzJS/XuKLvQRtqhXmKyRTBBQaOQiGV5WExhmTx5mDfK1p7A88y4ngfQWyka7f0k3oy7LUadghwdeSj9oxp+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941075; c=relaxed/simple;
	bh=uKt7BclgQxiSsV30Fyb93ZDuzo7hehHcn7YolUFZY8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Us/l9y6y73dyDkckrHVTS5qyfuP42lPe+iEKIi8OLbOfwCWzUS2nJSnpN/xas0AOd/5T+WWHoEBZzLlDxZ1OYoXtLmQdkCVgPtwEnh3T11bLVYSj0kJQDKtu1evtbCiJLedLVqtdTRFncK6v0JhGKQXEyJ7WhR2ybKCTJGhj4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjGDDYjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1F8DC4CED1;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941075;
	bh=uKt7BclgQxiSsV30Fyb93ZDuzo7hehHcn7YolUFZY8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UjGDDYjYHlXo7QyCvz6SMia/wNlgUil43avAiYbFWINxRRrGopwLWARzA/osuy1it
	 41OvhQrI66xPFhQmjJUDdiuSPLbKkF0X1UL2Tvbsnc3Gr9g3gyg63kDd9INL8Mmod8
	 9V3TCretQzPgbIGLFLPZ5S1UXmB1CTrcuvOGQOWKYeSoktx/O52++oSvdjhXPwpfTP
	 qvJRoXGItu6s+lMF3PR+fbf3Yq3Ud2DlpS4+caMf92CR5C4UHmn1ZI7xCSHgKthNqj
	 TBlmUXpS8uWj9y/UQ1oScwYEjcFE7NdW7O13GNIxHzupoFCcN6TdY0iCYLLJOnEaUo
	 yCpIku4AqkkkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEABCF855E;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 09:37:46 +0200
Subject: [PATCH 2/3] dt-bindings: iio: imu: migrate InvenSense email to TDK
 group domain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v1-2-7e4062ad68cf@tdk.com>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
In-Reply-To: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727941073; l=1790;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=F+UIybR5ZiJTmjkZOdePj24sU7xNqVC2Dhwx1qKHx3g=;
 b=5C0GyNDf7KUhOGilKnLImaSMt++8/bHgv8QBCfH9DBEPNdBtxmMc4mCdGb+moILX3pwBLjWjg
 GTsBFrxgluFDMIRtEOaATObLv/8L/fengJDhFPxGUEJbv8aF3u3nqfQ
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Migrate maintainer email to TDK domain.
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
2.34.1



