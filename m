Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33F33BB4EC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGEB2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 21:28:34 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:33422 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhGEB2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jul 2021 21:28:33 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 31B56D6110;
        Mon,  5 Jul 2021 09:25:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 0
X-SPAM-CHECKED: 5
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5174T139828564965120S1625448353496402_;
        Mon, 05 Jul 2021 09:25:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3174ba943668d90ae79123556dcfc284>
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
Subject: [PATCH v1 2/2] iio: adc: rockchip_saradc: add support for rk3568 saradc
Date:   Mon,  5 Jul 2021 09:25:52 +0800
Message-Id: <20210705012552.3781-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705012526.3731-1-xxm@rock-chips.com>
References: <20210705012526.3731-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It is similar to other devices, but with 8 channels.

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



