Return-Path: <linux-iio+bounces-9743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699FB97ED68
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D71F22227
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925619ABA9;
	Mon, 23 Sep 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r33j7OIw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E5823C8;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103211; cv=none; b=UFl9Yl20L9Zcy7+zJJvRA+o9riWllO852if+tlboNppkwbNIqw+rnr8vkLWT3ghCiXTw4KVZ911HR4ChKANg5cQaZv/QqjdNxbqrpBgtDl7QYY3BAUPTJkAcKRPYToL8Hcc9qtQYdvxz1x3ZQkGvQ7ATWS6torrQTDsEgXBOUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103211; c=relaxed/simple;
	bh=VuPNt5LDOWSfaq89oAC0gvvYnsAuvvma7caUqfV5UXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7k9tujvM4sCFuqyINKfPvQ83/4r6xqDwZgSdztoqCg3Sd03jevA1cnaAM15uUvPsO1syy7CFtHE0TYlZ0up4uwWfcLRftz8qAL4IF61NMwOT4su2RPoRGEC6Z1APiEqCe0qyTt2BeSFP58TAdxR17w6qDJg83FwnMBnsKNyt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r33j7OIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C52A7C4CECD;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727103210;
	bh=VuPNt5LDOWSfaq89oAC0gvvYnsAuvvma7caUqfV5UXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r33j7OIwmmAq5LOTudPUkqZFd1CpPD9njK6ufx83uapsuZghGpk7gKQ2z+bsXO2+F
	 rvIdO7Qi76vf2AAQjsHGi6qgU0pdJnOIMTgOmTO/yb4UJgvQKf7O2uuePHn8BSN991
	 p6X+vd9gPxgrjGlePCj0pG5MVqkPPyp5lgPdc7LnYxjCGc1OxR72vB8KEwNk4sobqR
	 5F4qOGU51es2f5YXvqk5zeFgei9BsZ2AuaLj/5GJQi8fFL/3N4xTTru2LBc4zkh6wX
	 BDUCXsOEgk0XlqmAeRT298chsmCgSbLANW/1rzU1x31I25GAjFv3hPPOfr9jjO2Y3G
	 lkrNdCjjdWB7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B542DCF9C72;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 23 Sep 2024 16:53:21 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-1-48290e0b9931@tdk.com>
References: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
In-Reply-To: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727103209; l=1050;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=ZthZoNTpOuOO9Sxm7Iz9x4o4wm0yXFBWMbSVi9NoBzI=;
 b=9NRRBdsm61njSLL+FGMFNqtKsoZxxk5X04Is3Rkh4MQV8Be8u58UIDow0kURXWFosWRtJJRFt
 QLNd/k7A5apBPS0F9AjdtHnr6PCd9AJArEo2khEkakFhGe/jsgo9+Z7
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.
They just have better specs, temperature range and a bigger FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 587ff2bced2ddd42e767f72b8e84c334d0e90481..a8d30ef015faaca02a11af7def6e06057bde3909 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -36,6 +36,11 @@ properties:
       - items:
           - const: invensense,icm20608d
           - const: invensense,icm20608
+      - items:
+          - enum:
+              - invensense,iam20680hp
+              - invensense,iam20680ht
+          - const: invensense,iam20680
 
   reg:
     maxItems: 1

-- 
2.34.1



