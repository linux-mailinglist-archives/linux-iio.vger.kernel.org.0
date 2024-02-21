Return-Path: <linux-iio+bounces-2874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0EE85E4C5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 18:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338261F21DBB
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 17:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67883CCC;
	Wed, 21 Feb 2024 17:43:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A181737
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537401; cv=none; b=Io1HW5djHvOEwDcBX+nqO7HR3RBJFzj6JHyaeogsEpA82/f736Rb1SwbfL3YcfTGG26OjhWsV8vc4/HH70TOsxm/QfGXLXAJBWR4/zAORj2/aJt6l6QeD3FMuKZ0Tf9NKIC/TTqwwDxQe0KK4gYUrsDTOEUwhZwgynMHjiEsw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537401; c=relaxed/simple;
	bh=x1whNrwYpej7zBfBOVkC3JBgqGT5iobnkHLXgVKm50M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQywuGal8IQYrf/qxtyH7fwtddh42x9J1mlUyJvfzBj58HGMvc/rjESskOxr3nl/zYTqpE4Wro5HfaUhrE/Li5l19THK0EIL6Y6KFqTRhBKg4xQM3lmtan1NUB6aXqsoD2TyIW+KWdI7N1mbd8DsTy9wwcFXic9tWiNsjxPD2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcqcd-0001Z2-FM; Wed, 21 Feb 2024 18:43:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	hns@goldelico.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency binding
Date: Wed, 21 Feb 2024 18:43:05 +0100
Message-Id: <20240221174305.3423039-1-m.felsch@pengutronix.de>
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

Make use of the common spi-peripheral-props.yaml to pull in the common
spi device properties and limit the spi-max-frequency to 10 MHz as this
is the max. frequency if VDDIO >= 1.62V.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 1414ba9977c1..3c6fe74af0b8 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -22,6 +22,9 @@ properties:
   vdd-supply: true
   vddio-supply: true
 
+  spi-max-frequency:
+    maximum: 10000000
+
   interrupts:
     minItems: 1
     maxItems: 2
@@ -33,7 +36,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2


