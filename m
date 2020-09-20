Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7670E2717DD
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgITUjA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 16:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITUi7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 16:38:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C9D20829;
        Sun, 20 Sep 2020 20:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600634339;
        bh=fC1sv+W5Ed3knqra4W9lTcr7iyXQUNrpk/9FIh36iBQ=;
        h=From:To:Cc:Subject:Date:From;
        b=P+4ETte6CkgL5zX0Luv1tl9PPO3DTrr4CiSpOkcysTYK5/hF+VUvoQWB1EP/GIP6/
         2VOlOYgFGzMr5zSFoUEBfrukj8zoMUpL++tjl0eBNhxnyXb+4/Jo6fGtKLex9DAmTS
         2Dve0qFe2s2UGPxS41OVgxMIPfd503dKotOQnnqI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: iio: vishay,vcnl4000: add interrupts property
Date:   Sun, 20 Sep 2020 22:38:45 +0200
Message-Id: <20200920203845.17758-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The dtschema should list all properties, including the common ones like
interrupts.  This fixes dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml:
    prox@60: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 58887a4f9c15..4d1a225e8868 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -24,6 +24,10 @@ properties:
       - vishay,vcnl4020
       - vishay,vcnl4040
       - vishay,vcnl4200
+
+  interrupts:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
-- 
2.17.1

