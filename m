Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33833E28F3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHFKz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 06:55:57 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:36816 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhHFKz4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 06:55:56 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 70218D6731;
        Fri,  6 Aug 2021 18:55:30 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26932T140040608929536S1628247328253895_;
        Fri, 06 Aug 2021 18:55:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6496367369d63e912f587053b5c5329c>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: jic23@kernel.org
X-RCPT-COUNT: 11
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
        linux-iio@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: [PATCH v2] iio: adc: rockchip_saradc: add voltage notifier so get referenced voltage once at probe
Date:   Fri,  6 Aug 2021 18:55:24 +0800
Message-Id: <20210806105524.231838-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: David Wu <david.wu@rock-chips.com>

Add voltage notifier, no need to query regulator voltage for
every saradc read, just get regulator voltage once at probe.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iio/adc/rockchip_saradc.c | 47 ++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index f3eb8d2e50dc..295da1ad6edb 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -49,10 +49,12 @@ struct rockchip_saradc {
 	struct clk		*clk;
 	struct completion	completion;
 	struct regulator	*vref;
+	int			uv_vref;
 	struct reset_control	*reset;
 	const struct rockchip_saradc_data *data;
 	u16			last_val;
 	const struct iio_chan_spec *last_chan;
+	struct notifier_block nb;
 };
 
 static void rockchip_saradc_power_down(struct rockchip_saradc *info)
@@ -105,13 +107,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(info->vref);
-		if (ret < 0) {
-			dev_err(&indio_dev->dev, "failed to get voltage\n");
-			return ret;
-		}
-
-		*val = ret / 1000;
+		*val = info->uv_vref / 1000;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
@@ -298,6 +294,26 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int rockchip_saradc_volt_notify(struct notifier_block *nb,
+						   unsigned long event,
+						   void *data)
+{
+	struct rockchip_saradc *info =
+			container_of(nb, struct rockchip_saradc, nb);
+
+	if (event & REGULATOR_EVENT_VOLTAGE_CHANGE)
+		info->uv_vref = (unsigned long)data;
+
+	return NOTIFY_OK;
+}
+
+static void rockchip_saradc_regulator_action(void *data)
+{
+	struct rockchip_saradc *info = data;
+
+	regulator_unregister_notifier(info->vref, &info->nb);
+}
+
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
 	struct rockchip_saradc *info = NULL;
@@ -410,6 +426,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	info->uv_vref = regulator_get_voltage(info->vref);
+	if (info->uv_vref < 0) {
+		dev_err(&pdev->dev, "failed to get voltage\n");
+		ret = info->uv_vref;
+		return ret;
+	}
+
 	ret = clk_prepare_enable(info->pclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable pclk\n");
@@ -450,6 +473,16 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	info->nb.notifier_call = rockchip_saradc_volt_notify;
+	ret = regulator_register_notifier(info->vref, &info->nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rockchip_saradc_regulator_action, info);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.25.1



