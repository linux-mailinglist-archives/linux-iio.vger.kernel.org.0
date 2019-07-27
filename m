Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454D177BAC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbfG0T7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 15:59:37 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38529 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbfG0T7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 15:59:37 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 444A0E0008;
        Sat, 27 Jul 2019 19:59:33 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iio/adc: Add a compatible string for JZ4770 SoC ADC
Date:   Sat, 27 Jul 2019 21:59:38 +0200
Message-Id: <20190727195940.14010-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a compatible string for the ADC controller present on
Ingenic JZ4770 SoC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:

v2: no change

 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
index f01159f20d87..cd9048cf9dcf 100644
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Should be one of:
   * ingenic,jz4725b-adc
   * ingenic,jz4740-adc
+  * ingenic,jz4770-adc
 - reg: ADC controller registers location and length.
 - clocks: phandle to the SoC's ADC clock.
 - clock-names: Must be set to "adc".
-- 
2.22.0

