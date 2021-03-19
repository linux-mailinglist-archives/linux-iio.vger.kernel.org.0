Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46CF341315
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCSCgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 22:36:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60849 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233519AbhCSCge (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 22:36:34 -0400
X-UUID: ad556cbf6671480cbcb92e4fc5808076-20210319
X-UUID: ad556cbf6671480cbcb92e4fc5808076-20210319
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 90673346; Fri, 19 Mar 2021 10:36:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Mar 2021 10:36:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Mar 2021 10:36:22 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v2 6/8] dt-bindings: arm: Add compatible for Mediatek MT8195
Date:   Fri, 19 Mar 2021 10:34:25 +0800
Message-ID: <20210319023427.16711-8-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210319023427.16711-1-seiya.wang@mediatek.com>
References: <20210319023427.16711-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds dt-binding documentation for the Mediatek MT8195
reference board.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 93b3bdf6eaeb..a95224fcff9f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -118,6 +118,10 @@ properties:
           - enum:
               - mediatek,mt8183-evb
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8195-evb
+          - const: mediatek,mt8195
       - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
         items:
           - enum:
-- 
2.14.1

