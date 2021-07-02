Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F13B9AA5
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jul 2021 04:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhGBCRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 22:17:34 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:60814 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhGBCRe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 22:17:34 -0400
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id DBA96D5926;
        Fri,  2 Jul 2021 10:14:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29909T139671241504512S1625192061083745_;
        Fri, 02 Jul 2021 10:14:44 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5c407c8cfc5b8e50ab79a726144025f2>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: jic23@kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Simon Xue <xxm@rock-chips.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: rockchip-saradc: add description for rk3568
Date:   Fri,  2 Jul 2021 10:14:03 +0800
Message-Id: <20210702021403.146293-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 1bb76197787b..e512a14e41b4 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -20,6 +20,7 @@ properties:
               - rockchip,px30-saradc
               - rockchip,rk3308-saradc
               - rockchip,rk3328-saradc
+              - rockchip,rk3568-saradc
               - rockchip,rv1108-saradc
           - const: rockchip,rk3399-saradc
 
-- 
2.25.1



