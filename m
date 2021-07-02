Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D63B9AA7
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jul 2021 04:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhGBCSH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 22:18:07 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:41380 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhGBCSH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 22:18:07 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 57622FAF49;
        Fri,  2 Jul 2021 10:15:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-SPAM-CHECKED: 5
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5174T139828410701568S1625192128889748_;
        Fri, 02 Jul 2021 10:15:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <624a86349f5a32301e16e818cdfdb5b8>
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
Subject: [PATCH 2/2] iio: adc: rockchip_saradc: add support for rk3568 saradc
Date:   Fri,  2 Jul 2021 10:15:27 +0800
Message-Id: <20210702021527.146343-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210702021403.146293-1-xxm@rock-chips.com>
References: <20210702021403.146293-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 drivers/iio/adc/rockchip_saradc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 12584f1631d8..f3eb8d2e50dc 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -35,7 +35,7 @@
 #define SARADC_DLY_PU_SOC_MASK		0x3f
 
 #define SARADC_TIMEOUT			msecs_to_jiffies(100)
-#define SARADC_MAX_CHANNELS		6
+#define SARADC_MAX_CHANNELS		8
 
 struct rockchip_saradc_data {
 	const struct iio_chan_spec	*channels;
@@ -192,6 +192,23 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.clk_rate = 1000000,
 };
 
+static const struct iio_chan_spec rockchip_rk3568_saradc_iio_channels[] = {
+	SARADC_CHANNEL(0, "adc0", 10),
+	SARADC_CHANNEL(1, "adc1", 10),
+	SARADC_CHANNEL(2, "adc2", 10),
+	SARADC_CHANNEL(3, "adc3", 10),
+	SARADC_CHANNEL(4, "adc4", 10),
+	SARADC_CHANNEL(5, "adc5", 10),
+	SARADC_CHANNEL(6, "adc6", 10),
+	SARADC_CHANNEL(7, "adc7", 10),
+};
+
+static const struct rockchip_saradc_data rk3568_saradc_data = {
+	.channels = rockchip_rk3568_saradc_iio_channels,
+	.num_channels = ARRAY_SIZE(rockchip_rk3568_saradc_iio_channels),
+	.clk_rate = 1000000,
+};
+
 static const struct of_device_id rockchip_saradc_match[] = {
 	{
 		.compatible = "rockchip,saradc",
@@ -202,6 +219,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
 	}, {
 		.compatible = "rockchip,rk3399-saradc",
 		.data = &rk3399_saradc_data,
+	}, {
+		.compatible = "rockchip,rk3568-saradc",
+		.data = &rk3568_saradc_data,
 	},
 	{},
 };
-- 
2.25.1



