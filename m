Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0287C36D330
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhD1HdH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhD1HdF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 03:33:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02068C06175F
        for <linux-iio@vger.kernel.org>; Wed, 28 Apr 2021 00:32:21 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lbeg7-00034J-1j; Wed, 28 Apr 2021 09:32:11 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lbeg5-00056h-CU; Wed, 28 Apr 2021 09:32:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v6 1/3] dt-bindings:iio:adc: add generic settling-time-us and oversampling-ratio channel properties
Date:   Wed, 28 Apr 2021 09:32:06 +0200
Message-Id: <20210428073208.19570-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210428073208.19570-1-o.rempel@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Settling time and over sampling is a typical challenge for different IIO ADC
devices. So, introduce channel specific settling-time-us and oversampling-ratio
properties to cover this use case.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 912a7635edc4..db348fcbb52c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -39,4 +39,16 @@ properties:
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
 
+  settling-time-us:
+    description:
+      Time between enabling the channel and first stable readings.
+
+  oversampling-ratio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Oversampling is used as replacement of or addition to the low-pass filter.
+      In some cases, the desired filtering characteristics are a function the
+      device design and can interact with other characteristics such as
+      settling time.
+
 additionalProperties: true
-- 
2.29.2

