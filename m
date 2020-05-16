Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B51D5DE6
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 04:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEPC1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 22:27:11 -0400
Received: from mail-co1nam11olkn2077.outbound.protection.outlook.com ([40.92.18.77]:9429
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgEPC1K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 May 2020 22:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C12EWM5yQBtiAg6HlPmQHq/P/xU2fJrr8midoHkKb7MM3GKmvoQ8yilvF307I6Cy1jgZ5cA0RHQ0yKUnyf2FsCXPK+F76EGi1XiRHx0kWJh231sTj50wUUUPaJCAqjxm316u8B2wL8r9sHZNh74ychCGfYVaQuPKqzCOcNAbA9yxVSdAAUvlrsz7YzEtLkzdCbuj9fLBcy1bkOcJYaL9kXicwJGOoXfkur40vE8h+WowzvXG1QKAfJWPkElSQGNbDaezDdMeeuXdHzlpOs8Cx7GeWHZbCXM6fkFOohS1v0F6n4gFMEBwHv+iIZ0jzO8UACUr+096FZp1YrPFK+MT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/DhqCz7OJAOeGl0dP8pb8Z/iPINJEvxRxvDUjiE13A=;
 b=ArYII9mzF0xCxjcuFbtDMPoBgi1do0uRDTbyrqvS1K06BegtkBVJp97pn+TStf6hGaXy+80g03veu/BkeZFY7Ovrnj0xdCojmWYfTPQ/kqrYYzaTFJFLbakz6yAK+5HLV5CYpx8b5WCzJDZ1AFPb+fEoOLzvh//M2roG9sh0ehc5KY1HO2o+8aZxr19tC886WahjxKDyCCaWhkovQNwWglPu5ONpX3lfB43OsROX8wjz+1f1LDKHn2BmHCLJSdTTK+auDckX+VFo1IqEALqauM2dZG/iNG2VayrjmdP3jfAyxOIMfFOFMYiQIm4U3TK72g3PnNCFTHeE77t9j//nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::43) by
 DM6NAM11HT006.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::175)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 02:27:08 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT026.mail.protection.outlook.com
 (2a01:111:e400:fc4d::161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 02:27:08 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:05D9524B48186AB0039D274DA0E0EB180203019630D4285059D94B4A4535455E;UpperCasedChecksum:424F667A2B4252B46929EFA1803878868DE3366D742D42A69B430CEF62925D95;SizeAsReceived:7820;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 02:27:08 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linus.walleij@linaro.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/2] iio: adc: Add current-from-voltage driver
Date:   Fri, 15 May 2020 19:26:19 -0700
Message-ID: <BN6PR04MB066086A09D671ACB0287B6BAA3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516022619.30779-1-xc-racer2@live.ca>
References: <20200516022619.30779-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200516022619.30779-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Sat, 16 May 2020 02:27:06 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516022619.30779-3-xc-racer2@live.ca>
X-TMN:  [X4nDp7Ex7Qo+lUs3wEH9RGoPPQnDOmfmSv6zlB/6fxTY0wYBFw+VlFxbmax1WwYu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 497ce8da-f2dc-44f7-f5dc-08d7f940a15d
X-MS-TrafficTypeDiagnostic: DM6NAM11HT006:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9PAz6GCbcNhoqCYx8i4nNH3J+ge4TmDpmuuHyxkc8+YiIHeL1FDfOz9Af3jSz1FpIFvC+vpYVKkK3zaqCX8nEu6JmSfrGTP4GfgMUT+nvf5SdzuJb+ILjTWWNboi6gczXR6nhzOSZydaqSuXBLgZbATRngG9WKPkV1Nz0NHc/amO3bQb9XJeAy1PoRYWP/jrqiOci+po2V+IsCR6BcUtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: KYdyFoGMgPFTcw4Y6ymb6SRSb89gl+eZKj8E6YCdQUNbEo7LElBwT9OkWMbWScg7gDeCAPTfd1BifPbbO2avbIC2A3AKrAaHRF2rJeU+ZqvPb+lLSfsxLBVqWISW7AcS7Gv48DMbhotcI2UUzRHo2QhlHvLWbAd+gv+V/zVNHNc1HTJ0Hl62yGEgTfEZQsjng2Utxe8VrXF+jODgFfacPg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ce8da-f2dc-44f7-f5dc-08d7f940a15d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 02:27:08.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT006
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices may require a current adc, but only have a voltage
ADC onboard.  In order to read the current, they have a resistor
connected to the ADC.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 MAINTAINERS                            |   8 ++
 drivers/iio/adc/Kconfig                |   9 ++
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/current-from-voltage.c | 123 +++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 drivers/iio/adc/current-from-voltage.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327e4976..094cf512b403 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4503,6 +4503,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
 F:	drivers/media/platform/sunxi/sun6i-csi/
 
+CURRENT ADC FROM VOLTAGE ADC DRIVER
+M:	Jonathan Bakker <xc-racer2@live.ca>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
+F:	Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
+F:	drivers/iio/adc/current-from-voltage.c
+
 CW1200 WLAN driver
 M:	Solomon Peachy <pizza@shaftnet.org>
 S:	Maintained
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 12bb8b7ca1ff..84e6ccb36024 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -344,6 +344,15 @@ config CPCAP_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called cpcap-adc.
 
+config CURRENT_FROM_VOLTAGE
+	tristate "Current from voltage shim driver"
+	help
+	  Say yes here to build support for a shim driver converting a voltage
+	  ADC coupled with a resistor to a current ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called current-from-voltage.
+
 config DA9150_GPADC
 	tristate "Dialog DA9150 GPADC driver support"
 	depends on MFD_DA9150
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 637807861112..d293184fc32a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
 obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
 obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
 obj-$(CONFIG_CPCAP_ADC) += cpcap-adc.o
+obj-$(CONFIG_CURRENT_FROM_VOLTAGE) += current-from-voltage.o
 obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
 obj-$(CONFIG_DLN2_ADC) += dln2-adc.o
 obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
diff --git a/drivers/iio/adc/current-from-voltage.c b/drivers/iio/adc/current-from-voltage.c
new file mode 100644
index 000000000000..69cb18e0995b
--- /dev/null
+++ b/drivers/iio/adc/current-from-voltage.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for converting a resistor and a voltage ADC to a current ADC
+ *
+ * Copyright (C) 2020 Jonathan Bakker <xc-racer2@live.ca>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct shim {
+	struct iio_channel *adc;
+	u32 resistor_value;
+};
+
+static int shim_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct shim *shim = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_read_channel_processed(shim->adc, val);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "fail reading voltage ADC\n");
+			return ret;
+		}
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = shim->resistor_value;
+
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec shim_iio_channel = {
+	.type = IIO_CURRENT,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+		| BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static const struct iio_info shim_info = {
+	.read_raw = &shim_read_raw,
+};
+
+static int shim_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct shim *shim;
+	enum iio_chan_type type;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*shim));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, indio_dev);
+	shim = iio_priv(indio_dev);
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = dev->of_node;
+	indio_dev->info = &shim_info;
+	indio_dev->channels = &shim_iio_channel;
+	indio_dev->num_channels = 1;
+
+	shim->adc = devm_iio_channel_get(dev, "adc");
+	if (IS_ERR(shim->adc)) {
+		if (PTR_ERR(shim->adc) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get adc input channel\n");
+		return PTR_ERR(shim->adc);
+	}
+
+	ret = iio_get_channel_type(shim->adc, &type);
+	if (ret < 0)
+		return ret;
+
+	if (type != IIO_VOLTAGE) {
+		dev_err(dev, "ADC is of the wrong type\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(dev, "linux,resistor-ohms",
+				      &shim->resistor_value);
+	if (ret < 0) {
+		dev_err(dev, "no resistor value found\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id shim_match[] = {
+	{ .compatible = "linux,current-from-voltage", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, shim_match);
+
+static struct platform_driver shim_driver = {
+	.probe = shim_probe,
+	.driver = {
+		.name = "current-from-voltage",
+		.of_match_table = shim_match,
+	},
+};
+module_platform_driver(shim_driver);
+
+MODULE_DESCRIPTION("Current ADC from voltage ADC and resistor");
+MODULE_AUTHOR("Jonathan Bakker <xc-racer2@live.ca>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

