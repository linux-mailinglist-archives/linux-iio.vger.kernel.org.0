Return-Path: <linux-iio+bounces-17793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F019FA7EEC8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 22:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B70420314
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7E2222D4;
	Mon,  7 Apr 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX/D3wCq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FE221D8B;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055846; cv=none; b=SzE6Qre1QpP1YPJMhotFh0TLFc+0d1Q4jMPybWzlnEovAwLHnd6HrlhvAvXCCS9MnQza539S9bUCXbv4P3AocPwi9dIuNAP68YY//rY320A3mw0rpUZZrSfw19TMhDXMjmzCxtawKYeP9Hdtu0c4LKifHJuIv4+Y9W0aT3bcy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055846; c=relaxed/simple;
	bh=v2/siHg09DAwKeiG3+f0sOCRkbEBkCscfOp3SQnO1lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moC7XmvvzlfDJFXtuo6p4QmWSqVxddW5bg5KIds3eaTvnV8fuCKNJSU4Q92e88gFqIZD09zkSy3jtbNKZ09sdanE0er9WqAnsVnx8i3sCl9jJYg8Wi8gSR2mhi8UUyAKlnPnc87T3bxviGokjlV12kAC9W2KmvMsjFrgXP5B0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX/D3wCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55824C4CEE9;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744055846;
	bh=v2/siHg09DAwKeiG3+f0sOCRkbEBkCscfOp3SQnO1lQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bX/D3wCq3syWtbi8PgRt/VPCt4EnMKJTe+WYXPsJ7kryGNQ/66c7pDWQbYcfSxfWs
	 1zg1q9pm9NmeB5/TtO77Qoa8BWZKkJpgKoC8N49JZ8GLVrQlyy7nqMvBrryKxplEPN
	 ulVOBTlaosXp1yTvCzxnm/fG4ucAWRs+SM8nen70I1g2nDdRguOtRBbkp4bVh+CqXv
	 XjoGEJ3aPpbcjA7j3zFGMtecVfNxWclQ5wGySTNg4M+K4dve4/nJprd1CWHNrifF3S
	 xXs2yUEyunWgJ+bh9sfcEfLpTpiF5Xn3E8k6ntZnStVPuO5JznjFGg6kJ853Sy769O
	 weBSHszpV0x4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4046FC36018;
	Mon,  7 Apr 2025 19:57:26 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 07 Apr 2025 21:57:16 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-1-c278acf587b2@tdk.com>
References: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
In-Reply-To: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055845; l=1747;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=1qQnOijHkXW1Hp6AoL8pvONp5bnvT1kXFXKqEP9j4Mk=;
 b=rQ4NkV5spC2UdhZNwqF+1M9qINLIg72QUnqO0x/jde1Cheat9cnvpclLdIuncJYC7fuN/SeRn
 okKLyYxUAiFAQ5dt4TUpcNTVNqGud+ERBZtpPjFEJ6I1YmCiUxXMxT8
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add interrupt-names field for specifying interrupt used. Only INT1
is supported by the driver currently.

Add minItems 1 for interrupts since interrupt is mandatory for the driver.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7e4492bbd0278a336587dc5ac04da7153453da29..707f2169ce9a3ca41d81560bed15786fe010109e 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -41,6 +41,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    minItems: 1
+    maxItems: 1
+    items:
+      enum:
+        - INT1
+        - INT2
+    description: |
+      choose chip interrupt pin to be used as interrupt input, beware that the
+      only support interrupt pin is INT1 for the moment.
+
   drive-open-drain:
     type: boolean
 
@@ -76,6 +87,7 @@ examples:
             reg = <0x68>;
             interrupt-parent = <&gpio2>;
             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };
@@ -95,6 +107,7 @@ examples:
             spi-cpol;
             interrupt-parent = <&gpio1>;
             interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };

-- 
2.49.0



