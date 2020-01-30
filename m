Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F4914DB63
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2020 14:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgA3NQF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jan 2020 08:16:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38487 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3NQF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2020 08:16:05 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fp-0000WY-TJ; Thu, 30 Jan 2020 14:15:57 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ix9fo-0000Lj-8F; Thu, 30 Jan 2020 14:15:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: ltc2632: expand for ltc2636 support
Date:   Thu, 30 Jan 2020 14:15:47 +0100
Message-Id: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ltc2636 family of devices is register compatible with the ltc2636
chips, it just features 8 instead of 2 channels.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
index e0d5fea33031..9d114957a28b 100644
--- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
@@ -1,4 +1,4 @@
-Linear Technology LTC2632 DAC device driver
+Linear Technology LTC2632/2636 DAC device driver
 
 Required properties:
  - compatible: Has to contain one of the following:
@@ -8,6 +8,12 @@ Required properties:
 	lltc,ltc2632-h12
 	lltc,ltc2632-h10
 	lltc,ltc2632-h8
+	lltc,ltc2636-l12
+	lltc,ltc2636-l10
+	lltc,ltc2636-l8
+	lltc,ltc2636-h12
+	lltc,ltc2636-h10
+	lltc,ltc2636-h8
 
 Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
 apply. In particular, "reg" and "spi-max-frequency" properties must be given.
-- 
2.25.0

