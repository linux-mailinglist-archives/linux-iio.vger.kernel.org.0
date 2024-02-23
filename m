Return-Path: <linux-iio+bounces-2964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B28617AA
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED601F221DE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AF84A57;
	Fri, 23 Feb 2024 16:20:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B985265
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705257; cv=none; b=BbRBDpYHd0aoguU1d01SAc0maBY/p48wLa42n8H+EhCHeAbEa2qeVtqVV/sEoSXEa+kmHzxpDENHbIAGJJj6ObiWyR7gfXrWwsNUDqXLmKC1oFZt3jnqDMsv3D6IAcDZFAwzbLmpDMkOL2MfD9MT8l4dLRtWxBeic/o8tF52bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705257; c=relaxed/simple;
	bh=+7BZA6LTHUprC7I7wLeww4jU28nvNwV5QLi3TTys4vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+In2bX2dy5lYD+HOOABqO3plh4pOfFJj2uTGgmnHTYlWNF83RnRiY79AzECJcSFMSfoz22VJJxzsLaL9Vs5GZIrm0NTgsJxst/7l+H11XXQbXmMjk06BYSlTB3GW79XOEBvjfte3DCxCIykK8XIzRx2sO9t09PAna5+CdS6m9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rdYI1-0007El-0r; Fri, 23 Feb 2024 17:20:45 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: ti,tmp117: add optional label binding
Date: Fri, 23 Feb 2024 17:20:42 +0100
Message-Id: <20240223162042.2658620-1-m.felsch@pengutronix.de>
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

Add the support to provide an optional label like we do for ADC
channels to identify the device more easily.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Hi,

patchset [1] should be applied first to avoid merge conflicts.

[1] https://lore.kernel.org/all/20240219131114.134607-1-m.felsch@pengutronix.de/#t

Regards,
  Marco

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 33f2e9c5bd81..f00c1cb89acd 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -27,6 +27,10 @@ properties:
   vcc-supply:
     description: provide VCC power to the sensor.
 
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Unique name to identify which device this is.
+
 required:
   - compatible
   - reg
-- 
2.39.2


