Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE5124D4E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLRQYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:06 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12945 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRQYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:05 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: jCu5830BU85l0txbOUKxGhxBNJ5v409VpwPrcLZMUmKL9ZGMbHpZtIlKFTbBLZ6arVgBOVQBYa
 rB/Hu+4i5s34uRq8Wr0VQlUB6lSaQqzi3Kxa0uTBnV5l7BVAOG/5tzgSiYzc/Q6mnYIX4pKjqz
 6DB+7stPADCrjMSZwXbhk+6O29wgUiI6iJ6IyeaNYYCeuDuWekRt1Dkyy/rme463DBxChbtGcX
 N0Drc4FUpBGcnrI25QBplXcemwCOn0SQuEKyO//mnhGwdCraRnTlN5UAnmT9bJpop3fvPoHJkW
 e+Q=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="60223160"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGRG/YknDNBY6wd6eXAlyYPTWPAv2jvsWSX3idgET0OHhLYkC4qGezb87zYL1rNhE54g2h+ArHmOl314813tfWrww2XAo/K5pu7RARHzHaa6rp5X2qIs53pABAyUYJdC6Fs3I/CKODFMFXFsALcp7qh+QY64tDQI97JR0lKV7asEkrZR8syPD67JKyq9C96NH+jUK4TidaB794Ijc+EjYN/cPD8LMKj4e3FXKvNYJYN+nlUqdtSfUaF4lf8LT4pR36/r8kfvlmihHt9lJjvcd6t2RlNKWQH2tb984Cim33gw7ijLnMUS2zkN+g3gM5KZ+wjuYZgB5jWMsVk3+USPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT+kt38DogHrZxEsh9bAfRdM7ydty5Uf6V/qtCsHzhA=;
 b=T+TjhJJ2DTZSWPWYin0Fmz4wuVr2gisLHx6R8gTIqbwD62ncIrujiKnwwaOlDDglTaM5aRTNIEoGN2O46RBM5g9Wz/SEphMkBr1gp7i4HT93SrRBXhBD8GTLS1TjoJYdn3jQb7Gmk6k/sh5CJgbFVM9LGsfgo+clGdXj8dEOHF0is90kkb6rUlQ1RYZoaNVu5VNNGePxTYOFLYhNfIsp1M4CdidkEf+K5yVnOow4/U4JNdRzgf4B9+c8k55B//nT1/dbUrMB4DMr18UUNWqGSfusfftlFntncNUU8U7FpvZ5P9OUvrjIHrWnolhoHrJaw/zWTcc4OMWotFLtmgSlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT+kt38DogHrZxEsh9bAfRdM7ydty5Uf6V/qtCsHzhA=;
 b=UwWYIs4NwC2PboSJtdOgW4az5L87Cwv0KqMFMfRlms1hW0WgahfHQ/RQ3Ki4AjDhPm4HbwL4Du18O0j9AkmZQTjGRIC+iWxCSYw0btxI/hC3KWduMpIouws5dn2kq1t+jAhWMujEVE5rYVOIT6zXkHnH2Hyx4aVgwO9/asJYnWo=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:02 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:02 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 05/10] iio: trigger: at91-rtc-trigger: introduce at91 rtc adc
 trigger driver
Thread-Topic: [PATCH 05/10] iio: trigger: at91-rtc-trigger: introduce at91 rtc
 adc trigger driver
Thread-Index: AQHVtb+OYkdaymH01keAcIhHVKgeHg==
Date:   Wed, 18 Dec 2019 16:24:01 +0000
Message-ID: <1576686157-11939-6-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5b69d9-fa62-48e4-266c-08d783d6b1b6
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB176927868032C5BE8C20611AE8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4326008)(6506007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZ1G1LkCJGpuNnFsHW7ezN1lfihGNyoYJw32x80ojQ91MrmM3uRXzY5yxtb2ONDQZipi/BODCM488V7fwfJBgq+J6BPI+t9wgbvqud3xW/no9NF9AXxCOpwURqP+xipNxZfa+KfXu0QOhGOkCroo5fzxIc+tmRiA1GFGUdskA1He4SchDdX9N+sxFU/izfPmd2qW0MCJlJdZV/KBHBGlE5mPQ7HcfGysrxnvASDpRgQg1gCCn9ROpioH6GrrshZL7LclzDOjP2YcSlrJttbHTSzJvRZAYijdkFh5nU5a7SRa/kQCl2RkqOvZLdBn7A6HGA4r9ptcBwZmQXUFFJOfKWo+DqnrE2CwSUU9VhfXCCGCuCOWsAtA3TltwEqBLe8BcQPXKdM80XjmH8M1jlC2GgRAkmhYU6hAi5OXZfGFR01joe3TKY16GqmyFgusxKGg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b69d9-fa62-48e4-266c-08d783d6b1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:01.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGHdOPoSlT6zVruqW1mA1Xi2pkee4tZY+MMHb2zCiVnn7px7XkHlDXlYhZXC6GoqtEejn2uiAqvgeaKN6ce0AoHTL8/oWZmwBzbgpwyBZBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The AT91 RTC ADC trigger driver registers a trigger into the iio subsystem,
which can be associated with at91_sama5d2-adc compatible drivers.
The SAMA5D2 SoC contains a hardware link between the RTC block and the ADC
block that will allow the RTC to trigger the ADC to perform conversions.
The at91-rtc-trigger will allow the customisation of the trigger frequency
from sysfs:
trigger_frequency_hz_available will display possible frequencies in Hz
trigger_frequency_hz will allow configuring this frequency.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/trigger/Kconfig            |  10 ++
 drivers/iio/trigger/Makefile           |   1 +
 drivers/iio/trigger/at91-rtc-trigger.c | 213 +++++++++++++++++++++++++++++=
++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/iio/trigger/at91-rtc-trigger.c

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 8cef2f7..dc7e6f4 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -68,4 +68,14 @@ config IIO_SYSFS_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-sysfs.
=20
+config IIO_AT91_RTC_TRIGGER
+	tristate "AT91 RTC trigger"
+	help
+	  Provides support for using AT91 RTC IP block to generate trigger
+	  events for ADC devices.
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called at91-rtc-trigger.
+
 endmenu
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index f3d11ac..6512436 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_IIO_STM32_LPTIMER_TRIGGER) +=3D stm32-lptime=
r-trigger.o
 obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) +=3D stm32-timer-trigger.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) +=3D iio-trig-sysfs.o
 obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) +=3D iio-trig-loop.o
+obj-$(CONFIG_IIO_AT91_RTC_TRIGGER) +=3D at91-rtc-trigger.o
diff --git a/drivers/iio/trigger/at91-rtc-trigger.c b/drivers/iio/trigger/a=
t91-rtc-trigger.c
new file mode 100644
index 0000000..8cdcfeb
--- /dev/null
+++ b/drivers/iio/trigger/at91-rtc-trigger.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/irq_work.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+
+#define at91_adc_readl(t, reg)		readl_relaxed((t)->base + (reg))
+#define at91_adc_writel(t, reg, val)	writel_relaxed(val, (t)->base + (reg)=
)
+
+#define AT91_RTC_MR		0x4
+#define AT91_RTC_OUT0_MASK	GENMASK(18, 16)
+#define AT91_RTC_OUT0_NO_WAVE	(0x0 << 16)
+#define AT91_RTC_OUT0_1HZ	(0x1 << 16)
+#define AT91_RTC_OUT0_32HZ	(0x2 << 16)
+#define AT91_RTC_OUT0_64HZ	(0x3 << 16)
+#define AT91_RTC_OUT0_512HZ	(0x4 << 16)
+
+/* attribute pack list */
+#define AT91_RTC_1HZ		1
+#define AT91_RTC_32HZ		32
+#define AT91_RTC_64HZ		64
+#define AT91_RTC_512HZ		512
+
+struct at91_rtc_adc_trig {
+	struct iio_trigger	*trig;
+	void __iomem		*base;
+	unsigned int		hz_config;
+};
+
+static int at91_hz_config_sysfs_to_reg(unsigned int hz_config)
+{
+	switch (hz_config) {
+	case AT91_RTC_1HZ:
+		return AT91_RTC_OUT0_1HZ;
+	case AT91_RTC_32HZ:
+		return AT91_RTC_OUT0_32HZ;
+	case AT91_RTC_64HZ:
+		return AT91_RTC_OUT0_64HZ;
+	case AT91_RTC_512HZ:
+		return AT91_RTC_OUT0_512HZ;
+	}
+	return AT91_RTC_OUT0_1HZ;
+}
+
+static int at91_configure_trigger(struct iio_trigger *trig, bool state)
+{
+	struct at91_rtc_adc_trig *t =3D iio_trigger_get_drvdata(trig);
+	u32 mr =3D at91_adc_readl(t, AT91_RTC_MR);
+
+	mr &=3D ~AT91_RTC_OUT0_MASK;
+
+	if (state)
+		mr |=3D at91_hz_config_sysfs_to_reg(t->hz_config);
+
+	at91_adc_writel(t, AT91_RTC_MR, mr);
+
+	return 0;
+}
+
+static const struct iio_trigger_ops at91_rtc_adc_trigger_ops =3D {
+	.set_trigger_state =3D &at91_configure_trigger,
+};
+
+static ssize_t at91_rtc_trigger_frequency_get(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_trigger *trig =3D to_iio_trigger(dev);
+	struct at91_rtc_adc_trig *t =3D iio_trigger_get_drvdata(trig);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", t->hz_config);
+}
+
+static ssize_t at91_rtc_trigger_frequency_set(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct iio_trigger *trig =3D to_iio_trigger(dev);
+	struct at91_rtc_adc_trig *t =3D iio_trigger_get_drvdata(trig);
+	int ret;
+	unsigned int val;
+
+	ret =3D kstrtou32(buf, 10, &val);
+
+	if (ret)
+		return ret;
+
+	if (val !=3D AT91_RTC_1HZ && val !=3D AT91_RTC_32HZ &&
+	    val !=3D AT91_RTC_64HZ && val !=3D AT91_RTC_512HZ)
+		return -EINVAL;
+
+	t->hz_config =3D val;
+
+	return count;
+}
+
+static IIO_DEVICE_ATTR(trigger_frequency_hz, 0644,
+		       at91_rtc_trigger_frequency_get,
+		       at91_rtc_trigger_frequency_set, 0);
+
+static IIO_CONST_ATTR(trigger_frequency_hz_available,
+		      __stringify(AT91_RTC_1HZ) " "
+		      __stringify(AT91_RTC_32HZ) " "
+		      __stringify(AT91_RTC_64HZ) " "
+		      __stringify(AT91_RTC_512HZ));
+
+static struct attribute *at91_rtc_adc_trigger_attributes[] =3D {
+	&iio_const_attr_trigger_frequency_hz_available.dev_attr.attr,
+	&iio_dev_attr_trigger_frequency_hz.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group at91_rtc_adc_trigger_attribute_group =
=3D {
+	.attrs =3D at91_rtc_adc_trigger_attributes,
+};
+
+static const struct attribute_group *at91_rtc_adc_trigger_attr_groups[] =
=3D {
+	&at91_rtc_adc_trigger_attribute_group,
+	NULL
+};
+
+static void at91_rtc_adc_trigger_remove(void *priv)
+{
+	struct at91_rtc_adc_trig *t =3D priv;
+
+	iio_trigger_unregister(t->trig);
+	iio_trigger_free(t->trig);
+}
+
+static int at91_rtc_adc_trigger_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct resource	*res;
+	struct at91_rtc_adc_trig *t;
+	int ret =3D 0;
+
+	t =3D devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	t->base =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(t->base))
+		return PTR_ERR(t->base);
+
+	t->trig =3D iio_trigger_alloc("%x.at91_rtc_adc", res->start);
+	if (!t->trig) {
+		ret =3D -ENOMEM;
+		return ret;
+	}
+
+	t->hz_config =3D AT91_RTC_1HZ;
+
+	t->trig->ops =3D &at91_rtc_adc_trigger_ops;
+	t->trig->dev.parent =3D dev;
+	t->trig->dev.groups =3D at91_rtc_adc_trigger_attr_groups;
+
+	iio_trigger_set_drvdata(t->trig, t);
+
+	ret =3D iio_trigger_register(t->trig);
+	if (ret) {
+		dev_err(dev, "failed to register trigger.\n");
+		goto at91_rtc_adc_trigger_probe_fail_register;
+	}
+
+	ret =3D devm_add_action_or_reset(dev, at91_rtc_adc_trigger_remove, t);
+	if (ret) {
+		dev_err(dev, "failed to add disable action.\n");
+		goto at91_rtc_adc_trigger_probe_fail_add_action;
+	}
+
+	return 0;
+
+at91_rtc_adc_trigger_probe_fail_add_action:
+	iio_trigger_unregister(t->trig);
+at91_rtc_adc_trigger_probe_fail_register:
+	iio_trigger_free(t->trig);
+	return ret;
+}
+
+static const struct of_device_id at91_rtc_adc_trigger_of_match[] =3D {
+	{
+		.compatible =3D "microchip,rtc-adc-trigger",
+	},
+	{ /* end node */ },
+};
+MODULE_DEVICE_TABLE(of, at91_rtc_adc_trigger_of_match);
+
+static struct platform_driver at91_rtc_adc_trigger_driver =3D {
+	.probe =3D at91_rtc_adc_trigger_probe,
+	.driver =3D {
+		.name =3D "at91-rtc-adc-trigger",
+		.of_match_table =3D at91_rtc_adc_trigger_of_match,
+	},
+};
+module_platform_driver(at91_rtc_adc_trigger_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
+MODULE_DESCRIPTION("AT91 RTC ADC trigger driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:iio-at91-rtc-trigger");
--=20
2.7.4
