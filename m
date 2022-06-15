Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194854D561
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 01:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbiFOXeS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 19:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiFOXeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 19:34:18 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404819028;
        Wed, 15 Jun 2022 16:34:16 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.net.upcbroadband.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 37B5C81E79;
        Thu, 16 Jun 2022 01:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1655336054;
        bh=eQwhtZdEgXrxVgj+pvKbmaSJLyk3a8se7w6o4IqaPEE=;
        h=From:To:Cc:Subject:Date:From;
        b=u2Chqc7JyP98w9aWx5ZCBZJTS4KwaH6IKhNS21xws4kAFheHlHWzSe5eHmPg1yqvf
         owlxDybDKCYMA+xAFOwJ0QlcWXwpAhbBfJL6mRwhdJc4oe6plrPv7dr2kEwvXEaSVc
         6f+rz0Xs3MnnbC7ekwvfXqp6gokFI8SPC7P7Izc1P66zHpewylNnikFDSptkhKBjwG
         rWq6FIGdlUNcYUx0PvfdOwv23V7LwScQinh/eqAhdmwKe3rjn6HxM7igEc7dd9WybE
         EElY6la7K2msUBUSr+etNbf86pgh5zq/TgBWlzzAOSeEycWDvp6PHbO2T5tOPOB4VI
         m9TAvU4S42RwQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/accel: Fix adi,adxl345/6 example I2C address
Date:   Thu, 16 Jun 2022 01:34:11 +0200
Message-Id: <20220615233411.90621-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Align the example node address and reg content to be 0x2a for both.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 11d32a2885352..9bb039e2f5331 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -55,7 +55,7 @@ examples:
         /* Example for a I2C device node */
         accelerometer@2a {
             compatible = "adi,adxl345";
-            reg = <0x53>;
+            reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
         };
-- 
2.35.1

