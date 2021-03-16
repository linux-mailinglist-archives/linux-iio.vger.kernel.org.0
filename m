Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4368D33D284
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhCPLP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 07:15:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48763 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231918AbhCPLPM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 07:15:12 -0400
X-UUID: ac5815ebc7ad4d688bf8836e49b6a38d-20210316
X-UUID: ac5815ebc7ad4d688bf8836e49b6a38d-20210316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 20464300; Tue, 16 Mar 2021 19:15:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 19:15:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 19:15:04 +0800
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
        Mark Brown <broonie@kernel.org>,
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
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 00/10] Add basic node support for Mediatek MT8195 SoC
Date:   Tue, 16 Mar 2021 19:14:33 +0800
Message-ID: <20210316111443.3332-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 34B5F28517A2B2BB210610747DFA29DBD96DC8560E0C1DF5C1860E28986D62C82000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


MT8195 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA55 and 4 CA78 cores.
MT8195 share many HW IP with MT65xx series.
This patchset was tested on MT8195 evaluation board to shell.

Based on v5.12-rc2

Seiya Wang (10):
  dt-bindings: timer: Add compatible for Mediatek MT8195
  dt-bindings: serial: Add compatible for Mediatek MT8195
  dt-bindings: watchdog: Add compatible for Mediatek MT8195
  dt-bindings: mmc: Add compatible for Mediatek MT8195
  dt-bindings: spi: Add compatible for Mediatek MT8195
  dt-bindings: iio: adc: Add compatible for Mediatek MT8195
  dt-bindings: phy: Add compatible for Mediatek MT8195
  dt-bindings: phy: Add compatible for Mediatek MT8195
  dt-bindings: arm: Add compatible for Mediatek MT8195
  arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and
    Makefile

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   1 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   1 +
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 .../bindings/spi/mediatek,spi-mtk-nor.yaml         |   1 +
 .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts        |  29 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           | 477 +++++++++++++++++++++
 12 files changed, 519 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

--
2.14.1

