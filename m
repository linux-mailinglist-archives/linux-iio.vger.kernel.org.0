Return-Path: <linux-iio+bounces-2598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E3857A43
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17E6287BD2
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDCD28E2B;
	Fri, 16 Feb 2024 10:28:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612C24A03
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079312; cv=none; b=rIvqr8eZH4HHAv84P3KSvR4INx1hV4MI3jqPgjiObVFw5r8OsEzVcd1Xj7okoxoKLZ56CIvSMwj6onshj5Wg6D6R91FhMfFzh5+su0GqGa6TCxU0EdhkDYaq/Q8+o0sy47duL5cbdvENTWVzkGNcNNKCJqjjJICb5PcVo0MZ/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079312; c=relaxed/simple;
	bh=qKpijvoPFZ5Podu7ukUIp3Fhx6uwAlh95tWbcp2qTvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZDHsoZCYVORSAqaUswv3g846x7hZY0d8VP6TVZOWgZL7QzCKYllodmRyB+ho5jjntqxV0ackt/sDZG8GrDbSwZaeYu3HdYksdFkPx3SI2rZJaa5DljgZCZGxPriwmYLAUs3rN+zXeahPFvg7L0i/VLb1FFY5c3AaKxuQtny/q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1ravS9-0006gI-H0; Fri, 16 Feb 2024 11:28:21 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	thomas.haemmerle@leica-geosystems.com
Subject: [RESEND PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply binding
Date: Fri, 16 Feb 2024 11:28:19 +0100
Message-Id: <20240216102820.1395815-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>

Add the binding to specify the vcc supply. We can't make it required
since this would break the backward compatibility.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Resend since I forgot to add the DT maintainers

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 8c6d7735e875..cf7799c9734f 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -24,6 +24,9 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply:
+    description: provide VCC power to the sensor.
+
 required:
   - compatible
   - reg
@@ -39,5 +42,6 @@ examples:
         tmp117@48 {
              compatible = "ti,tmp117";
              reg = <0x48>;
+             vcc-supply = <&pmic_reg_3v3>;
         };
     };
-- 
2.39.2


