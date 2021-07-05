Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483173BB4ED
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 03:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhGEB25 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 21:28:57 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:34646 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhGEB24 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jul 2021 21:28:56 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 30100D5944;
        Mon,  5 Jul 2021 09:26:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30156T139873811932928S1625448376209259_;
        Mon, 05 Jul 2021 09:26:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c362687bbb3d7b6ecdde6e56187c314d>
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
Subject: [PATCH] arm64: dts: rockchip: add saradc node for rk3568.dtsi
Date:   Mon,  5 Jul 2021 09:26:10 +0800
Message-Id: <20210705012610.3831-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index d225e6a45d5c..16621ecbb876 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -525,6 +525,18 @@ uart9: serial@fe6d0000 {
 		status = "disabled";
 	};
 
+	saradc: saradc@fe720000 {
+		compatible = "rockchip,rk3568-saradc", "rockchip,rk3399-saradc";
+		reg = <0x0 0xfe720000 0x0 0x100>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_P_SARADC>;
+		reset-names = "saradc-apb";
+		#io-channel-cells = <1>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.25.1



