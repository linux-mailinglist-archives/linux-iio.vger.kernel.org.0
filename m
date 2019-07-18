Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0349C6CA88
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbfGRIBd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 04:01:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbfGRIBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 04:01:32 -0400
X-UUID: 855ee7169c24481d80ec127fe6615890-20190718
X-UUID: 855ee7169c24481d80ec127fe6615890-20190718
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1562123255; Thu, 18 Jul 2019 16:01:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 16:01:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 16:01:24 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <jg_poxu@mediatek.com>, <sj.huang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <erin.lo@mediatek.com>, <eddie.huang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v1 1/2] arm64: dts: mt8183: auxadc: add efuse information in device tree
Date:   Thu, 18 Jul 2019 16:01:18 +0800
Message-ID: <20190718080119.30707-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20190718080119.30707-1-zhiyong.tao@mediatek.com>
References: <20190718080119.30707-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The commit add add efuse information in device tree

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: jg_poxu <jg_poxu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c2749c4631bc..59b4f3d933b5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -261,6 +261,8 @@
 			clocks = <&infracfg CLK_INFRA_AUXADC>;
 			clock-names = "main";
 			#io-channel-cells = <1>;
+			nvmem-cells = <&auxadc_calibration>;
+			nvmem-cell-names = "calibration-data";
 			status = "disabled";
 		};
 
@@ -382,6 +384,9 @@
 			compatible = "mediatek,mt8183-efuse",
 				     "mediatek,efuse";
 			reg = <0 0x11f10000 0 0x1000>;
+			auxadc_calibration: auxadccali@1b4 {
+				reg = <0x1b4 0x4>;
+			};
 		};
 
 		mfgcfg: syscon@13000000 {
-- 
2.12.5

