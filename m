Return-Path: <linux-iio+bounces-1890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FE83A74D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C037BB2AEAC
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2231A286;
	Wed, 24 Jan 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2nqimaQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19783199A2;
	Wed, 24 Jan 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093569; cv=none; b=pM+LPZpyPBZ/SNi7OcqXLcZkbY9HHs7D+UDook+AA0V4rVvsZ1LxCfCxx4pkAZs+viPXYU/+QjKFkBojCxwDBmW/KK6qac0KOLsjyD//rY2aFPnCP3ZyCUTnFwsIjhxVkdEYMeGXG/idSMqFY+tG7YEv5RQVH14qKJckRTqhpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093569; c=relaxed/simple;
	bh=fvEweWhj7gZResBcZ8QEpA2Pjcf4E+Ob16+YGLRIds4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9jKYUqnd7N7vs1zWoN+PJQWJGVJRFaNxh8vBuCe75S21I2Knoc6AVp2YHjDQjuENMXAfdcjVapNAN6fnHJ2CvpUjKHL2PT7e/oQqSWrLQjzhx2HMR/qG7X/UOpZIK/+FhSgsFVijS4Cp+GBk8XRxV/uRnAtG41B0cOVZeHM49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2nqimaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4DFC43394;
	Wed, 24 Jan 2024 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093568;
	bh=fvEweWhj7gZResBcZ8QEpA2Pjcf4E+Ob16+YGLRIds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2nqimaQu3gDR5286lBuGZeuzeVZxc/sAda8GI4rE1DSeMImt18f1gDeGTk65GjBO
	 AOwsyMQbfeD7r3cVJ+VUrn7HNgTc1CLxXnPkNM5Si8VJNGYmjwe6EsdDSRY4pgeofy
	 AJUdLIlD5hCBol6dH8zB9PtnyCbteJ/xyX8Y1+wDHPRBgQSjjsHH+F88Aoy+7RA8Qv
	 JswrGNAxRoeWSvBHOz6HdRKPF/Yo3CBSyxLPcj7kys6GbBecIrvETD/SnSZzg6DYun
	 5Bw12bfHuTZsgBdAFIt0yAEMegJSmfT25VTOvvwezSrFj/i+kpoZa75oTQjV0065Lw
	 yJDGFM8AB8wkQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Date: Wed, 24 Jan 2024 11:52:34 +0100
Message-ID: <90d675537e58c9c339545a895e8164a843821682.1706093274.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706093274.git.lorenzo@kernel.org>
References: <cover.1706093274.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device bindings for asm330lhhxg1 IMU sensor.
Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
all the features currently supported by asm330lhhxg1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 28b667a9cb76..7ba3de66a2e1 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -49,6 +49,9 @@ properties:
       - items:
           - const: st,asm330lhb
           - const: st,asm330lhh
+      - items:
+          - const: st,asm330lhhxg1
+          - const: st,asm330lhhx
 
   reg:
     maxItems: 1
-- 
2.43.0


