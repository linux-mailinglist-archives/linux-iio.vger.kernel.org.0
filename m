Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B451613C5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2020 14:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgBQNoy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Feb 2020 08:44:54 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:39776 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBQNoy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Feb 2020 08:44:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id BBD2FFB02;
        Mon, 17 Feb 2020 14:44:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SfnLh7PdL-LR; Mon, 17 Feb 2020 14:44:49 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 64E4940FE8; Mon, 17 Feb 2020 14:44:48 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: light: vcnl4000: Add near-level
Date:   Mon, 17 Feb 2020 14:44:48 +0100
Message-Id: <ec3a79378e6fdaa8ed0430622d70a717d08022bd.1581947007.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581947007.git.agx@sigxcpu.org>
References: <cover.1581947007.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This value indicates when userspace should consider an object
near to the sensor/device.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 Documentation/devicetree/bindings/iio/light/vcnl4000.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
index 955af4555c90..6f7dfe470553 100644
--- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
@@ -16,9 +16,15 @@ Required properties:
         0x51
         0x60
 
+Optional properties:
+
+	- near-level: Raw proximity values above this level should be
+	  considered 'near' to the device (an object is near to the sensor).
+
 Example:
 
 light-sensor@51 {
 	compatible = "vishay,vcnl4200";
 	reg = <0x51>;
+	nearl-leval = <200>;
 };
-- 
2.23.0

