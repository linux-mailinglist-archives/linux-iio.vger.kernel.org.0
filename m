Return-Path: <linux-iio+bounces-17919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0321A8483A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A5C3B9CAA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863871EBFFC;
	Thu, 10 Apr 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOB/YXrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397951E9B38;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299635; cv=none; b=McPuRwZ7A+PqylgXrtqVKv7bCAHJwg7NKWgF8hQbfFK1fyqiZCajZiezJMi3NJJVCBEUWzckSXHo8ewXVa/ogOaqODOHTPtCtG7LwDZQLa9eYL+5X1iYnraXg4KOYeKAqS09mzZi2X6+Y0r1NCWOX0WTiUyIymm9WokFlUCdlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299635; c=relaxed/simple;
	bh=LHD9QFwvKUiXG2YJUaMmShdPpGyFLI06YGbLcTszTrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WivChigQseFSFvAwDfUf78iV5mrIsdh6rlz8dew4OXHJqCmjIK3fULip0+4nuROCFfB4+U35tm0MwVtGuugNOzai6NRPkupTwffSzkSyoNNZg5KogAin4h/8nXUF2qfa/0++0sFlASzxGcl6r9gsEN7nk9oukI3D8aP4brfgaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOB/YXrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF838C4CEE9;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299634;
	bh=LHD9QFwvKUiXG2YJUaMmShdPpGyFLI06YGbLcTszTrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vOB/YXrT5csHe46SsE1d5mK9QmyheLUuzPPSCMnfX4EF72h771+80bpYlG/BjLgL4
	 ulwgmctj6R0BtQ4Klf6q9qrgrkPJqTzgS6MmskihuSH8qL6i7BJdWj2kU7N9i04S4X
	 BBNGUv+bqsNCEbt5OmRcZEDc/4lEi9RMJhDKLs9EQF+IF5f57OPmZ6Ej1hOCWgWfjb
	 CpFcxamNa5TQD/uCcyGqZWIongCpSFOnLO3Xf1j38qOoo8yxY+kjy0hzDy3copIPxO
	 zC67DOziVSBwio3+0FDpPC7m5XUMVSTk3f7NjsLT9uEssQ0ty63JgovxJVGPaPLKvK
	 H+aFhJvVht3iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C52C369A9;
	Thu, 10 Apr 2025 15:40:34 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 10 Apr 2025 17:39:40 +0200
Subject: [PATCH v4 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-1-19e4e2f8f7eb@tdk.com>
References: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
In-Reply-To: <20250410-iio-imu-inv-icm42600-rework-interrupt-using-names-v4-0-19e4e2f8f7eb@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744299633; l=1667;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=VSawZ1o/QxRqL4fWVfjdTFoB12VpEf7tP4qn663WfY4=;
 b=gUvwd/ULfhOmpGyt3CLCntXqU0MwammUU8dArCBjf2oGClGJdG0UkKE91jcnvQCFuNMA+oEJL
 g+3L8Ye1gzzCR9FBmWseJTNowQooT6CXGFVVQwKujx36Ze02YmmyqMx
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add interrupt-names field for specifying interrupt pin configured.

Chips are supporting up to 2 interrupt pins with configurable interrupt
sources. Change interrupt to support 1 or 2 entries.

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



