Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C324E11647A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 01:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfLIAix (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Dec 2019 19:38:53 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:6163
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbfLIAix (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkedgfZwv8HYw+2gdPa1puUioQ7skThB4C0agz1/CjSfy7Y00XbxIBG0j6hg3HVZ349ygcuyFZc61pyPVKGv0j7xk3UBm1hPzfjdfq85tLuRB7r/6vSi0z7RGNw46qtLu0FiwyKBxNTjj4nR61sNmwjuEZ4soGoOOpg4op/aQREWN4SvPq18dg4AyLPKlxNAKztfqWTi6NbRsDIHeKiw0kIMZozz9dvI5zCHwQadl9rNvOTaMid7kweGBhN8DrSkLT3n95LviOOquUDLcsCmKfwrmH0LgqhgY7s4RISlzJSHQtpudHa5+Lvy1gPlwdCXnleJM6g73cOfmhKU/XQFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOkj6c6u/RdUL1PqguDcQo1awDcZvBLWeY2fVAsEY0I=;
 b=oTxsLppeqHa+KX1FYg7F6c1A2kVTH2oKlrJkeOfd8rcacEArYo7uXdvnf5Ezgwc4qAOObmWkwYCyLpuKeBjxQrqSnz/BBnT5HtklrQd2MpkFYDYXXpo9SD7oEXjbVJpi9v9QTlqkAzzeOCfouSBbUzR53mbfRtCyfydW2TUnVG88ZRm+Z4KhlG8bCctYCPW+IXx0sdyWpp2pjFxKKySukbxcCAUqDJ+LbdSOof4co6Ceoz/ma/MKi9k9wGf8s+YsqpHYwAdRFsH69GB0erazvTmAys+k2XV4llZSTTeCuPT4jZ865W2A1zvPUpnpzYBp3Xhy/9qDoAJDCocuhC3iCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOkj6c6u/RdUL1PqguDcQo1awDcZvBLWeY2fVAsEY0I=;
 b=u5T2dFsKynFvWnig+POERt5h5nj88s/zGBKyH+NJeayYBmKqRIQ6cF+N0/8JpTWJQ6hB3ZS7B947x4Y/Qyr6XXDO1XXPxSbHnFB6/UfZuIGdyUMhPaTiozWKSpFhFxJcS8RHPky55tgXJUvgXNwhGXXPGZlpFejypWTqI2/kNwA=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4402.namprd08.prod.outlook.com (52.132.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 00:38:41 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 00:38:41 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625 angle
 sensors
Thread-Topic: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Thread-Index: AQHVrikBIkVSIrZAc0Gxy9PYoURzHQ==
Date:   Mon, 9 Dec 2019 00:38:41 +0000
Message-ID: <1575851866-18919-8-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9e92cfe-17a9-4d45-d142-08d77c402363
x-ms-traffictypediagnostic: BN7PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB4402B52638FF3124F5986B07D3580@BN7PR08MB4402.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(376002)(34096005)(366004)(136003)(396003)(346002)(448600002)(199004)(189003)(99286004)(76176011)(71200400001)(52116002)(71190400001)(54906003)(4326008)(2906002)(6512007)(38610400001)(66556008)(66476007)(6486002)(66946007)(586005)(64756008)(66446008)(110136005)(107886003)(36756003)(8936002)(102836004)(50226002)(30864003)(305945005)(2616005)(7416002)(5660300002)(6506007)(81166006)(81156014)(26005)(86362001)(186003)(8676002)(102460200005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4402;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Td6Yx8py2UQRlLwJ0OV63/K3qEK/VjfoJCqX/QTewLxMW7j3jYeb56CzBUnGc6bKRkQ54+EL1B/zCKFkxh7d9LJOHxiZt2+cNZBv0uWgNMyQtXhb1LHlkZmzUt68ZkQDPRdsG4hm3UnVDvluzhOzxmXy1OZDqOpqc6yJRipRB5Een0qSD+lW/K+nc92mtcMcqeR7WG4D842Kfdq0BXVR/nFSPmqWx+iEpyfQw5iY52TNDjeHUj808N8KZQHvwkkqVxeGZr9yaYR3FHPDlHktPRyyDJXB/JvWk+eOGV1H8oJ/yAEJ0/rMQtnl9nZ3+lbESHKZ32CBxhyFlwsUAM218iXBOhpmh9D/Y6xuevk0aRvz0d2di6NX8KhtYDvnbEAYXcvogMEn8WGmCZrhoCVEC0d4CJVlmOdxHO+FjgzoYMQGguUtkIaBl+VIcY4fo9HqcLIouN+XA4ZEVL7AScVpHnFNqVkH+BzZVV2lXTJ/aSuY35V3YoDCZ882Qi1+fVIy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e92cfe-17a9-4d45-d142-08d77c402363
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 00:38:41.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyzEVIqsPFRFdgQ61SwnZVU6NooeFK0koXvfbFm/GJDwyoYopxB4NsMHAn5oaQk5DaYW5dKK+03tuTsSsQL3Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4402
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support for the Azoteq IQS624 and IQS625 angular position
sensors, capable of reporting the angle of a rotating shaft down to 1 and
10 degrees of accuracy, respectively.

This patch also introduces a home for linear and angular position sensors.
Unlike resolvers, they are typically contactless and use the Hall effect.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
Changes in v2:
  - Merged 'Copyright' and 'Author' lines into one in introductory comments
  - Replaced 'error' with 'ret' throughout
  - Added iqs624_pos_angle_en and iqs624_pos_angle_get to remove duplicate
    logic previously used throughout
  - Refactored the logic in iqs624_pos_notifier and added a lock to safely
    evaluate variables that may change in response to user action
  - Refactored the logic in iqs624_pos_read_raw
  - Added a lock to iqs624_pos_read_event_config to account for cases in wh=
ich
    the corresponding hardware state is in the process of being updated
  - Refactored the logic in iqs624_pos_write_event_config and read the init=
ial
    angle in case it changed since having first been read in iqs624_pos_ini=
t
  - Removed iqs624_pos_init as its logic has since been absorbed elsewhere
  - Removed devm_add_action_or_reset failure message
  - Eliminated tabbed alignment of platform_driver struct members
  - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST

 drivers/iio/Kconfig               |   1 +
 drivers/iio/Makefile              |   1 +
 drivers/iio/position/Kconfig      |  19 +++
 drivers/iio/position/Makefile     |   7 +
 drivers/iio/position/iqs624-pos.c | 284 ++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 312 insertions(+)
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5bd5185..d5c073a 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
+source "drivers/iio/position/Kconfig"
 source "drivers/iio/potentiometer/Kconfig"
 source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index bff682a..1712011 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -31,6 +31,7 @@ obj-y +=3D light/
 obj-y +=3D magnetometer/
 obj-y +=3D multiplexer/
 obj-y +=3D orientation/
+obj-y +=3D position/
 obj-y +=3D potentiometer/
 obj-y +=3D potentiostat/
 obj-y +=3D pressure/
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
new file mode 100644
index 0000000..eda67f0
--- /dev/null
+++ b/drivers/iio/position/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Linear and angular position sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Linear and angular position sensors"
+
+config IQS624_POS
+	tristate "Azoteq IQS624/625 angular position sensors"
+	depends on MFD_IQS62X || COMPILE_TEST
+	help
+	  Say Y here if you want to build support for the Azoteq IQS624
+	  and IQS625 angular position sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called iqs624-pos.
+
+endmenu
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
new file mode 100644
index 0000000..3cbe7a7
--- /dev/null
+++ b/drivers/iio/position/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for IIO linear and angular position sensors
+#
+
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_IQS624_POS)	+=3D iqs624-pos.o
diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs62=
4-pos.c
new file mode 100644
index 0000000..af629bf5
--- /dev/null
+++ b/drivers/iio/position/iqs624-pos.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS624/625 Angular Position Sensors
+ *
+ * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define IQS624_POS_DEG_OUT			0x16
+
+#define IQS624_POS_SCALE1			(314159 / 180)
+#define IQS624_POS_SCALE2			100000
+
+struct iqs624_pos_private {
+	struct iqs62x_core *iqs62x;
+	struct notifier_block notifier;
+	struct mutex lock;
+	bool angle_en;
+	u16 angle;
+};
+
+static int iqs624_pos_angle_en(struct iqs62x_core *iqs62x, bool angle_en)
+{
+	unsigned int event_mask =3D IQS624_HALL_UI_WHL_EVENT;
+
+	/*
+	 * The IQS625 reports angular position in the form of coarse intervals,
+	 * so only interval change events are unmasked. Conversely, the IQS624
+	 * reports angular position down to one degree of resolution, so wheel
+	 * movement events are unmasked instead.
+	 */
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		event_mask =3D IQS624_HALL_UI_INT_EVENT;
+
+	return regmap_update_bits(iqs62x->map, IQS624_HALL_UI, event_mask,
+				  angle_en ? 0 : 0xFF);
+}
+
+static int iqs624_pos_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs62x_event_data *event_data =3D context;
+	struct iqs624_pos_private *iqs624_pos;
+	struct iqs62x_core *iqs62x;
+	struct iio_dev *indio_dev;
+	u16 angle =3D event_data->ui_data;
+	s64 timestamp;
+	int ret;
+
+	iqs624_pos =3D container_of(notifier, struct iqs624_pos_private,
+				  notifier);
+	indio_dev =3D iio_priv_to_dev(iqs624_pos);
+	timestamp =3D iio_get_time_ns(indio_dev);
+
+	iqs62x =3D iqs624_pos->iqs62x;
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		angle =3D event_data->interval;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
+		ret =3D iqs624_pos_angle_en(iqs62x, iqs624_pos->angle_en);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to re-initialize device: %d\n", ret);
+			ret =3D NOTIFY_BAD;
+		} else {
+			ret =3D NOTIFY_OK;
+		}
+	} else if (iqs624_pos->angle_en && (angle !=3D iqs624_pos->angle)) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
+						    IIO_EV_TYPE_CHANGE,
+						    IIO_EV_DIR_NONE),
+			       timestamp);
+
+		iqs624_pos->angle =3D angle;
+		ret =3D NOTIFY_OK;
+	} else {
+		ret =3D NOTIFY_DONE;
+	}
+
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static void iqs624_pos_notifier_unregister(void *context)
+{
+	struct iqs624_pos_private *iqs624_pos =3D context;
+	struct iio_dev *indio_dev =3D iio_priv_to_dev(iqs624_pos);
+	int ret;
+
+	ret =3D blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
+						 &iqs624_pos->notifier);
+	if (ret)
+		dev_err(indio_dev->dev.parent,
+			"Failed to unregister notifier: %d\n", ret);
+}
+
+static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned int *=
val)
+{
+	int ret;
+	__le16 val_buf;
+
+	if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM)
+		return regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
+				   val);
+
+	ret =3D regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT, &val_buf,
+			      sizeof(val_buf));
+	if (ret)
+		return ret;
+
+	*val =3D le16_to_cpu(val_buf);
+
+	return 0;
+}
+
+static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
+	unsigned int scale =3D 1;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iqs624_pos_angle_get(iqs62x, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (iqs62x->dev_desc->prod_num =3D=3D IQS625_PROD_NUM) {
+			ret =3D regmap_read(iqs62x->map, IQS624_INTERVAL_DIV,
+					  &scale);
+			if (ret)
+				return ret;
+		}
+
+		*val =3D scale * IQS624_POS_SCALE1;
+		*val2 =3D IQS624_POS_SCALE2;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+	ret =3D iqs624_pos->angle_en;
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 int state)
+{
+	struct iqs624_pos_private *iqs624_pos =3D iio_priv(indio_dev);
+	struct iqs62x_core *iqs62x =3D iqs624_pos->iqs62x;
+	unsigned int val;
+	int ret;
+
+	mutex_lock(&iqs624_pos->lock);
+
+	ret =3D iqs624_pos_angle_get(iqs62x, &val);
+	if (ret)
+		goto err_mutex;
+
+	ret =3D iqs624_pos_angle_en(iqs62x, state);
+	if (ret)
+		goto err_mutex;
+
+	iqs624_pos->angle =3D val;
+	iqs624_pos->angle_en =3D state;
+
+err_mutex:
+	mutex_unlock(&iqs624_pos->lock);
+
+	return ret;
+}
+
+static const struct iio_info iqs624_pos_info =3D {
+	.read_raw =3D &iqs624_pos_read_raw,
+	.read_event_config =3D iqs624_pos_read_event_config,
+	.write_event_config =3D iqs624_pos_write_event_config,
+};
+
+static const struct iio_event_spec iqs624_pos_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_CHANGE,
+		.dir =3D IIO_EV_DIR_NONE,
+		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec iqs624_pos_channels[] =3D {
+	{
+		.type =3D IIO_ANGL,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec =3D iqs624_pos_events,
+		.num_event_specs =3D ARRAY_SIZE(iqs624_pos_events),
+	},
+};
+
+static int iqs624_pos_probe(struct platform_device *pdev)
+{
+	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
+	struct iqs624_pos_private *iqs624_pos;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iqs624_pos =3D iio_priv(indio_dev);
+	iqs624_pos->iqs62x =3D iqs62x;
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->dev.parent =3D &pdev->dev;
+	indio_dev->channels =3D iqs624_pos_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(iqs624_pos_channels);
+	indio_dev->name =3D iqs62x->dev_desc->dev_name;
+	indio_dev->info =3D &iqs624_pos_info;
+
+	mutex_init(&iqs624_pos->lock);
+
+	iqs624_pos->notifier.notifier_call =3D iqs624_pos_notifier;
+	ret =3D blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
+					       &iqs624_pos->notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D devm_add_action_or_reset(&pdev->dev,
+				       iqs624_pos_notifier_unregister,
+				       iqs624_pos);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver iqs624_pos_platform_driver =3D {
+	.driver =3D {
+		.name =3D IQS624_DRV_NAME_POS,
+	},
+	.probe =3D iqs624_pos_probe,
+};
+module_platform_driver(iqs624_pos_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensors");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS624_DRV_NAME_POS);
--
2.7.4

