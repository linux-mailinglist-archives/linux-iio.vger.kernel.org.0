Return-Path: <linux-iio+bounces-17616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C992A7C0F5
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EA17BAD9
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BF1F583A;
	Fri,  4 Apr 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZajGI8Af"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EB1DF962;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781930; cv=none; b=uvVhlLyBljaENYrc9I8DHH1fK6Ksv5bQhpvKROVxJ9oW3kQTv6fefO2ESpWbvQQBRqYX8b8YwUM7CoqMl9FcYc8YqPJcXw1u1Fi9u6fp1pYzZiQezXfGOW7q3svpvua68hdcniBQQu/UfiAOicd61UYkuI0D/tNesuRyNmjahvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781930; c=relaxed/simple;
	bh=sKfM3/qWS66bwPhUL7IpTrHtoJB9p8ob07Z9FKjYph8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrfo8W+ZZ62+qZ4atCTqNnNll0klvS4FrPHOf7YEdL6bEYi0q0d1DGKdI93dJrhZXlOX2NsJqD9E+xHDtLUXlorXm/LCdKd//SMDDqawpLdV4AfXxKXTNDSc/aQdFosj8CbHVI41vamHoLR32TsEedgqfkw8dcypIAosFTgciYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZajGI8Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB283C4CEE9;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743781929;
	bh=sKfM3/qWS66bwPhUL7IpTrHtoJB9p8ob07Z9FKjYph8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZajGI8AfJ+OTEapXryO3n/CqNq75szJwqcRBo+M5qCTsGZMB5/EwkhRaXBoOkYEP6
	 O1fSOLsZ1+vLsWQmCt3fB2ZkK79jB75b++tMXUssPScKBghBUR2Zgi1sKMcm9SsbQR
	 Lnr5A9VZ3UIJFXQPq24R+Tx1gGTHdknmUxt+sTxO+/6s1bH6Li9NZvZmk+cUYnK62p
	 Rp/Nj15Jsto1lnYHY2sAJ81YeP/sW6nK5rs8BFGvfyjgiHGkJlUu/+XTmnThsYMjW6
	 um8U0OdxzfRFMpFm0tRt47YieTADfZ1BCKyjR6SSCWBB/knMQUw7J9DKEYhS3PvpA0
	 H6ykI01MLc2WQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9145DC369A1;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 04 Apr 2025 17:52:02 +0200
Subject: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add interrupt naming
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-1-72ed5100da14@tdk.com>
References: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
In-Reply-To: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743781928; l=1440;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=X6P4YWLOlhlgH2oiySbrJcpFo5s9IL+DV66p+lLJcwY=;
 b=66OyozigM0/WCOaWLAve7lw3hDs54rZl+Te4eTcUVidKMgfkDjV+WDram63arJQQnyEL+RYWZ
 kdsrqtTRJJBBjPKfGcFfT3NRzUt4UiFuzvdV4AZqkptjHcxOFVBkmme
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add interrupt-names field for specifying interrupt used.
Only INT1 is supported by the driver currently.
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 7e4492bbd0278a336587dc5ac04da7153453da29..f19cdfd7450e04e7c984dc987f3c23f5ad89a248 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -41,6 +41,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    enum:
+      - INT1
+    description: |
+      set to "INT1" the only supported interrupts pin
+
   drive-open-drain:
     type: boolean
 
@@ -76,6 +82,7 @@ examples:
             reg = <0x68>;
             interrupt-parent = <&gpio2>;
             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };
@@ -95,6 +102,7 @@ examples:
             spi-cpol;
             interrupt-parent = <&gpio1>;
             interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
             vdd-supply = <&vdd>;
             vddio-supply = <&vddio>;
         };

-- 
2.49.0



