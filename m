Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9B564D44
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 07:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGDFlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 01:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiGDFkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 01:40:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8309FCD;
        Sun,  3 Jul 2022 22:40:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so7657615plh.4;
        Sun, 03 Jul 2022 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmbAcE8ucNCYLt4ga1wuXkXkTF22YmYu3x2174DL3Do=;
        b=jLkYWdBVz3tIB3P/NacM3FLEuOh8IbEQ0/L3ShYszKHPYy25I4ZnRb1dKJrxihsPe7
         TDTWlUh5fBpnJvFXPKhCmCE6amtPSUXeU2ItzkoXjwO9ckVXj6yOhm1mHua2Ybqs1j2v
         YkkQ8fJ7dS6ekn9twk6PMF6RLe9ttQSfhKn0LtsXW2reogGALSsorq0e1HH1wHvSGCLL
         kCr65QQrlAxOuSq1iLcEqVyjrKXJ9eJrAgxKUsx1FDSH2c2LRyPh3MOmx/EsMDTrEqEl
         qlMZE/1Ds1DbfyOIbvmIm7cYYstszdTTWfrsAdR4Z9ksosQUHweyBpCXRsTW7ou7xUMY
         CAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmbAcE8ucNCYLt4ga1wuXkXkTF22YmYu3x2174DL3Do=;
        b=oN+ybvPBZeMmoKPwfd6oYAmdU5OwW+rNsxfYQB5hLU00Bkh8T36DCy0bM2ceJHO0fD
         UmAWc93fcMmstvZD0Qc6hvZpn/N5tuaJSV+7lJcmAYrOV++bp3vl1lZu2RrF7KSdPk2A
         meQdHyaYpfrwPDZboau+N0xhLoCntn3sbK238fzQMJ7fU9VkpmQDNUAG35H9XF3Wzc8q
         s8ayus2EHrVBrw9mOjgxKJo8djcc3ACL1ZhhbnaVp/MWx1UUrURKTDK7+5skUhKZvNz5
         3Cq//OdNgE0gBkm/12RhFni1XV/c87wLVjgC5xnISKklQ9FN7q3A8I+/pJgRZZc8s3AO
         yK8A==
X-Gm-Message-State: AJIora+E5ghxRxN+Z++tDB4AE103GPYT3xcOPBM9zR+6kLZcfnbmUbSJ
        YObkXnKUv78szsoOSo6q7d0=
X-Google-Smtp-Source: AGRyM1tjpfQMU6NpRx+ZLLTKVALvOT82SVBvOEBrGDuMkRBOrlTQUDeFwFE3UVeLgEVZpcIbyYYL6Q==
X-Received: by 2002:a17:90b:508f:b0:1ec:a212:1e41 with SMTP id rt15-20020a17090b508f00b001eca2121e41mr33351934pjb.226.1656913216604;
        Sun, 03 Jul 2022 22:40:16 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-4-255.emome-ip.hinet.net. [42.72.4.255])
        by smtp.gmail.com with ESMTPSA id h24-20020a635318000000b0040dffa7e3d7sm13904507pgb.16.2022.07.03.22.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 22:40:16 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v4 08/13] usb: typec: tcpci_mt6370: Add Mediatek MT6370 tcpci driver
Date:   Mon,  4 Jul 2022 13:38:56 +0800
Message-Id: <20220704053901.728-9-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704053901.728-1-peterwu.pub@gmail.com>
References: <20220704053901.728-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add chip level mt6370 tcpci driver.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---

v4:
- Replace text "Mediatek" with "MediaTek" in Kconfig
- Replace "first ret=regulator_(dis/en)able and then return"
  with "return directly" in "mt6370_tcpc_set_vbus()"
- Replace header file <linux/of.h> with <linux/mod_devicetable.h>
- Add Copyright in the source code
- Add module name related description in Kconfig helptext
- Remove header file <linux/of.h>
- Refine all probe error by using dev_err_probe()
---
 drivers/usb/typec/tcpm/Kconfig        |  11 ++
 drivers/usb/typec/tcpm/Makefile       |   1 +
 drivers/usb/typec/tcpm/tcpci_mt6370.c | 207 ++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6370.c

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 073fd2e..ccdd791 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -35,6 +35,17 @@ config TYPEC_MT6360
 	  USB Type-C. It works with Type-C Port Controller Manager
 	  to provide USB PD and USB Type-C functionalities.
 
+config TYPEC_TCPCI_MT6370
+	tristate "MediaTek MT6370 Type-C driver"
+	depends on MFD_MT6370
+	help
+	  MediaTek MT6370 is a multi-functional IC that includes
+	  USB Type-C. It works with Type-C Port Controller Manager
+	  to provide USB PD and USB Type-C functionalities.
+
+	  This driver can also be built as a module. If so the module
+	  will be called "tcpci_mt6370.ko".
+
 config TYPEC_TCPCI_MAXIM
 	tristate "Maxim TCPCI based Type-C chip driver"
 	help
diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
index 7d499f3..906d9dc 100644
--- a/drivers/usb/typec/tcpm/Makefile
+++ b/drivers/usb/typec/tcpm/Makefile
@@ -6,4 +6,5 @@ typec_wcove-y				:= wcove.o
 obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
 obj-$(CONFIG_TYPEC_RT1711H)		+= tcpci_rt1711h.o
 obj-$(CONFIG_TYPEC_MT6360)		+= tcpci_mt6360.o
+obj-$(CONFIG_TYPEC_TCPCI_MT6370)	+= tcpci_mt6370.o
 obj-$(CONFIG_TYPEC_TCPCI_MAXIM)		+= tcpci_maxim.o
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c b/drivers/usb/typec/tcpm/tcpci_mt6370.c
new file mode 100644
index 0000000..12336ca
--- /dev/null
+++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeup.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/usb/tcpm.h>
+#include "tcpci.h"
+
+#define MT6370_REG_SYSCTRL8	0x9B
+
+#define MT6370_AUTOIDLE_MASK	BIT(3)
+
+#define MT6370_VENDOR_ID	0x29CF
+#define MT6370_TCPC_DID_A	0x2170
+
+struct mt6370_priv {
+	struct device *dev;
+	struct regulator *vbus;
+	struct tcpci *tcpci;
+	struct tcpci_data tcpci_data;
+	int irq;
+};
+
+static const struct reg_sequence mt6370_reg_init[] = {
+	REG_SEQ(0xA0, 0x1, 1000),
+	REG_SEQ(0x81, 0x38, 0),
+	REG_SEQ(0x82, 0x82, 0),
+	REG_SEQ(0xBA, 0xFC, 0),
+	REG_SEQ(0xBB, 0x50, 0),
+	REG_SEQ(0x9E, 0x8F, 0),
+	REG_SEQ(0xA1, 0x5, 0),
+	REG_SEQ(0xA2, 0x4, 0),
+	REG_SEQ(0xA3, 0x4A, 0),
+	REG_SEQ(0xA4, 0x01, 0),
+	REG_SEQ(0x95, 0x01, 0),
+	REG_SEQ(0x80, 0x71, 0),
+	REG_SEQ(0x9B, 0x3A, 1000)
+};
+
+static int mt6370_tcpc_init(struct tcpci *tcpci, struct tcpci_data *data)
+{
+	u16 did;
+	int ret;
+
+	ret = regmap_register_patch(data->regmap, mt6370_reg_init,
+				    ARRAY_SIZE(mt6370_reg_init));
+	if (ret)
+		return ret;
+
+	ret = regmap_raw_read(data->regmap, TCPC_BCD_DEV, &did, sizeof(u16));
+	if (ret)
+		return ret;
+
+	if (did == MT6370_TCPC_DID_A)
+		return regmap_write(data->regmap, TCPC_FAULT_CTRL, 0x80);
+
+	return 0;
+}
+
+static int mt6370_tcpc_set_vconn(struct tcpci *tcpci, struct tcpci_data *data,
+				 bool enable)
+{
+	return regmap_update_bits(data->regmap, MT6370_REG_SYSCTRL8,
+				  MT6370_AUTOIDLE_MASK,
+				  !enable ? MT6370_AUTOIDLE_MASK : 0);
+}
+
+static int mt6370_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_data *data,
+				bool source, bool sink)
+{
+	struct mt6370_priv *priv = container_of(data, struct mt6370_priv,
+						tcpci_data);
+	int ret;
+
+	ret = regulator_is_enabled(priv->vbus);
+	if (ret < 0)
+		return ret;
+
+	if (ret && !source)
+		return regulator_disable(priv->vbus);
+	else if (!ret && source)
+		return regulator_enable(priv->vbus);
+	else
+		return 0;
+}
+
+static irqreturn_t mt6370_irq_handler(int irq, void *dev_id)
+{
+	struct mt6370_priv *priv = dev_id;
+
+	return tcpci_irq(priv->tcpci);
+}
+
+static int mt6370_check_vendor_info(struct mt6370_priv *priv)
+{
+	struct regmap *regmap = priv->tcpci_data.regmap;
+	u16 vid;
+	int ret;
+
+	ret = regmap_raw_read(regmap, TCPC_VENDOR_ID, &vid, sizeof(u16));
+	if (ret)
+		return ret;
+
+	if (vid != MT6370_VENDOR_ID) {
+		dev_err(priv->dev, "Vendor ID not correct 0x%02x\n", vid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int mt6370_tcpc_probe(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	priv->tcpci_data.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->tcpci_data.regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Failed to init regmap\n");
+
+	ret = mt6370_check_vendor_info(priv);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to check vendor info\n");
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	/* Assign TCPCI feature and ops */
+	priv->tcpci_data.auto_discharge_disconnect = 1;
+	priv->tcpci_data.init = mt6370_tcpc_init;
+	priv->tcpci_data.set_vconn = mt6370_tcpc_set_vconn;
+
+	priv->vbus = devm_regulator_get_optional(&pdev->dev, "vbus");
+	if (!IS_ERR(priv->vbus))
+		priv->tcpci_data.set_vbus = mt6370_tcpc_set_vbus;
+
+	priv->tcpci = tcpci_register_port(&pdev->dev, &priv->tcpci_data);
+	if (IS_ERR(priv->tcpci))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->tcpci),
+				     "Failed to register tcpci port\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, priv->irq, NULL,
+					mt6370_irq_handler, IRQF_ONESHOT,
+					dev_name(&pdev->dev), priv);
+	if (ret) {
+		tcpci_unregister_port(priv->tcpci);
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to allocate irq\n");
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+	dev_pm_set_wake_irq(&pdev->dev, priv->irq);
+	return 0;
+}
+
+static int mt6370_tcpc_remove(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv = platform_get_drvdata(pdev);
+
+	disable_irq(priv->irq);
+	tcpci_unregister_port(priv->tcpci);
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+	return 0;
+}
+
+static const struct of_device_id mt6370_tcpc_devid_table[] = {
+	{ .compatible = "mediatek,mt6370-tcpc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_tcpc_devid_table);
+
+static struct platform_driver mt6370_tcpc_driver = {
+	.driver = {
+		.name = "mt6370-tcpc",
+		.of_match_table = mt6370_tcpc_devid_table,
+	},
+	.probe = mt6370_tcpc_probe,
+	.remove = mt6370_tcpc_remove,
+};
+module_platform_driver(mt6370_tcpc_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("MT6370 USB Type-C Port Controller Interface Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

