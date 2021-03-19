Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD93412E4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 03:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCSCfT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 22:35:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59389 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231475AbhCSCeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 22:34:50 -0400
X-UUID: 1c41936701154981a2103db6bd4cb884-20210319
X-UUID: 1c41936701154981a2103db6bd4cb884-20210319
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1092837910; Fri, 19 Mar 2021 10:34:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Mar 2021 10:34:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Mar 2021 10:34:42 +0800
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
Subject: [PATCH v2 0/8] Add basic node support for Mediatek MT8195 SoC 
Date:   Fri, 19 Mar 2021 10:34:18 +0800
Message-ID: <20210319023427.16711-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 369FE48044719369D9DCA15B0B2E3408B975033CEE214468D66328468C1E5DBE2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MT8195 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA55 and 4 CA78 cores.
MT8195 share many HW IP with MT65xx series.
This patchset was tested on MT8195 evaluation board to shell.

Based on next-20210318

Changes in v2
Fix make dt_binding_check warning in mediatek,ufs-phy.yaml
Update usb phy and ufs phy nodes in mt8195.dtsi

Seiya Wang (8):
  dt-bindings: timer: Add compatible for Mediatek MT8195
  dt-bindings: serial: Add compatible for Mediatek MT8195
  dt-bindings: watchdog: Add compatible for Mediatek MT8195
  dt-bindings: mmc: Add compatible for Mediatek MT8195
  dt-bindings: iio: adc: Add compatible for Mediatek MT8195
  dt-bindings: arm: Add compatible for Mediatek MT8195
  dt-bindings: phy: fix dt_binding_check warning in
    mediatek,ufs-phy.yaml
  arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and
    Makefile

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   1 +
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |   8 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts        |  29 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           | 464 +++++++++++++++++++++
 10 files changed, 509 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

--
2.14.1

