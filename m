Return-Path: <linux-iio+bounces-17880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51269A82A1B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E183C9A1638
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F8266F09;
	Wed,  9 Apr 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb4o8ncz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFB1482F5;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211688; cv=none; b=KMBUDdWwpwEgido5u2scZmmXWwcMwdNsQdB2vDQTtTw9tgXAJ0EU3F5zHnis67kYRPne4EVPCB3BVZJgd1gTCFLgmoZASSjTpOGD01xV/rYuh3T+uwvVZL8BMxCb5owzjIiw2knMEnoNL5Rmo10zj+yWUrOpYnxnGuBSB/O0WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211688; c=relaxed/simple;
	bh=vBZqC0O5tQn7yYeCKm1IWZME+A4rllBN0HVkbnJvBF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HC9o4HfDtUvoz8SEvM86ta9nDnrHmf50ZqHXnPBKcbjJUW6iscSiwAhOWdH9GSmDIASsA/34aC09K2ckxc9K60JyJDiT3wAMmECyF38bYM0zXVuz3PpmRJ9dZFG1TaagN7hPNP9MyGuQc5nhpKi2twT4pFrWVmWOvK+24sF+s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb4o8ncz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0E17C4CEE3;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211687;
	bh=vBZqC0O5tQn7yYeCKm1IWZME+A4rllBN0HVkbnJvBF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Lb4o8ncz56ZLx0hwtiCOqw7R72jHbPYErscKBcQM0+fpMeCY8ARhCaaAjrXM+YjQf
	 1KfY6iZjLkOCFgilz8NwdrI/C36LZE9rd4K/R85b+yTscvSxs3CuDOO/79jhr4OaM4
	 tBqOQrdTkdVtOOGoVEfQWi2xoH5npAvDEH0bGFib11yUqCEezDCaisQFGJFa3IGzBk
	 7Y3s+0uYwHJnaFd6wSoIfhik76rFwF8QOyi9j0vQRseI8ojiigfRnmMSoAQEU0RM1C
	 nZT6MCVQ7c0289btIVGad7iOpSF5LgtYQSqsksHUnuMP2OOzkPVon9y9sR0/L0sj83
	 CamaxYueDyriw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14ECC369A1;
	Wed,  9 Apr 2025 15:14:47 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Wed, 09 Apr 2025 17:14:31 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-1-dab85a0a7c2b@tdk.com>
References: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
In-Reply-To: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744211686; l=1618;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=NNdcFcwJ58pjm6qy/fkIfslg0RTvgS6oq+pA7j64/l4=;
 b=NpO6R5ugYbnDc9ffFmVmPd44HJgkXZQFGgP/B4nlGN2G1DADaBYr0IaFoHRwRFOBU4kto6N3S
 smhU5Kw1rEHAidgyiCglNv0gSbAyrdXoLqjmzUxRx211I7TUEwfHhOh
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add interrupt-names field for specifying interrupt pin configured.
Chips are supporting 2 interrupt pins, change interrupt to support 2
entries.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7e4492bbd0278a336587dc5ac04da7153453da29..d4d4e5c3d8562523872a737864610c26c8fccd82 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -39,7 +39,16 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
 
   drive-open-drain:
     type: boolean
@@ -76,6 +85,7 @@ examples:
             reg = <0x68>;
             interrupt-parent = <&gpio2>;
             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };
@@ -95,6 +105,7 @@ examples:
             spi-cpol;
             interrupt-parent = <&gpio1>;
             interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };

-- 
2.49.0



