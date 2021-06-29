Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD83B73EB
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhF2OKz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 10:10:55 -0400
Received: from mail-db8eur05on2092.outbound.protection.outlook.com ([40.107.20.92]:1058
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234309AbhF2OKw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Jun 2021 10:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG+hc1cL3/eOcfT2KUszAVBZfO6+bBWIKY/uYo8Mn+thGnb13AWsFt4BwZSGhLcfP2Q6nm//M9yT5X7e3AXvI0bnBDl5iO74lVeU7FNq0a6DQTsDr6ArjNCZY2GC1YMHDl+YA43duJQLjfc0GginPtdFo3giwzDM40EF02MxtBYLTR5MINihfnJXaXwkAGDiJHRps3ML1FYaGTBkKpLICppSGlHrmFROGMttKU3udFjZo86x28HEqOgQy/BTbTXaqTd2jx3wP8ViK71mRqMSRTwwT451rq7x4QB1/upLI8lqBvvlwMnPwS2tgndUxtVr9kw5j9BKNJ3fRPguLL+05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCH3ng6zvJFDMwvaoggxq+SQ4UeOZpoVwTKzgQSbfbM=;
 b=hmACxAlncOxHyvkHjhXNlRCxqvNUY6I4kWFi4FzVPiDa9VdW63AXTav1rCJnve4xmnjYAThkMyKc0bMLgCdQgDvz/Qxu+0usWwvmyLH6nvzA52sUbZl22wdgUACDwoWa9NchTIkDt5BJTlerXy+W7vhz0Zl9UhY7Yq/m/mIJ5uPlWVVgEb4hKbokv6kHs6nVf+BJhUZ4lws8UGwnEqgl7n6qxec603XU9Kp+k12dVzJIyp1Jqn4PArSPAHM52KxIsaVBO3i/+Nr8yfZGx5XXznXKPXyEMzcmqGtVt6BFohCH1ILb015kWmCWPTenWUHO5r8Q+n+7yMgo566wgSL66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=non.se.com; dmarc=pass action=none header.from=non.se.com;
 dkim=pass header.d=non.se.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=non.se.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCH3ng6zvJFDMwvaoggxq+SQ4UeOZpoVwTKzgQSbfbM=;
 b=MKB9WlZmLJG/qBCk0y2Pl0HXUhtXrUiSPc20nbnymxnRF8suk9igyZE1cKQ0znUV9v1IfCyFbuP4kjfHVH3KRmPtboIX75mp37XO03xZHVqu5shTqPi4RBWMiI/vrIHS/ksgqFB9FsVAtlqw9pn9qPAYGcPOV6sb0bWniZks7OUb6SVN6W4thjpcXgEP6/KELq4SdBKSV6TCzqtI1NE52d08ZDaWkFd+tOIZfV14zGGkeDVhHnVd0ifP+H7yHAnv0gvzibAHNSyMa/IbfHQx10SSbbWzaOtg2ohzb5LVIUU1zNpDbQ1FxCM1ibcT2qEP+pi75Uv2Uqfv7ml/CdZCSQ==
Received: from DB6PR04MB2967.eurprd04.prod.outlook.com (2603:10a6:6:a::10) by
 DB7PR04MB4524.eurprd04.prod.outlook.com (2603:10a6:5:3b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Tue, 29 Jun 2021 14:08:19 +0000
Received: from DB6PR04MB2967.eurprd04.prod.outlook.com
 ([fe80::bd7b:73a0:7819:6152]) by DB6PR04MB2967.eurprd04.prod.outlook.com
 ([fe80::bd7b:73a0:7819:6152%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 14:08:19 +0000
From:   Pierre CASTELLAN <pierre.castellan@non.se.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Milan Stevanovic <milan.o.stevanovic@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Tomasz Motyl <tomasz.motyl@se.com>,
        FREDERIC LOREAUD <frederic.loreaud@se.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio:adc: Add RZ/N1D ADC driver
Thread-Topic: [PATCH v2] iio:adc: Add RZ/N1D ADC driver
Thread-Index: Adds74qZWK7TAdIbQAy+IJqbSSmyaA==
Date:   Tue, 29 Jun 2021 14:08:19 +0000
Message-ID: <DB6PR04MB29674E865CD47B1D0D60D936BA029@DB6PR04MB2967.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_Enabled=true;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_SetDate=2021-06-29T14:08:17Z;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_Method=Standard;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_Name=SE Internal;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_SiteId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_ActionId=b0294f6d-2ece-45c2-9fae-316971dccd29;
 MSIP_Label_23f93e5f-d3c2-49a7-ba94-15405423c204_ContentBits=2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=non.se.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7882d3ad-d30e-4cf5-134e-08d93b075946
x-ms-traffictypediagnostic: DB7PR04MB4524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4524A83C195463EA193BFEF0BA029@DB7PR04MB4524.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0WxLrc3g2OApFaHr4q4XmI4tdst9COw5mbe17KheTyQ82JVNE9MF6d04LsFxsRNW3ro+JGoJ4prXynGR7hF5aD9DyqAmDrJZHGq25L/U7CCFXUIr6xPdu+RJgIueG36io8RO0CbQYuDgXbFd32OaACbyw1O9B3sSkjda+EpYLbaBFcnZpxeP3FrAIC9A/nAP+1Zk4hszMVwI3wZmpL4Fopc7ASk4GAzZeuzxSbC0sCc1qVVPWad7mNVF6pibBIhB0p+76v6YzBRw43ah5U8Fkp7f9mqgtd7dCODtRr6oICoh34J/IW6tZhuQOr6eLV473MfSciLMOhIQkjTR2rCHJEFM18LIVbz/GQZzHWxfzJd5ZozL0LczvVhJ7Z3MV6PphVtqrlrxvdBIQWz5d96P2fbxKbriPptQhWH6asL5FPTETuOWtAoWYUwxWUTLJmaxqdzWsslX9ehRVdeqq849CW2CWRgZBvpwLPIicUR5B0OSAhvgBqzt3EfsXewGMu9bvxQGb65HMxaCryTyiQO7VM4ohUyzBGUn/+T38yOuuxFwivUYlSJ/fcPAkeav3AwcF+xXiPPsg2MUu+g+UwGSyNHANffRZIQNzdHItei3dSF1PJiQbUBi3XlfXYT+4+Wg/OuM1ceMyWqpGS0jn/2xV4e489NpxF4UPirxAxDOUnFOyNehEi4ebK1VT/rz3JcTTEOjwjCBCXiqVn8Eoh6KBp9RTddyoyP4tUyr8L2QxLWGty9zyklIlPjARl4g5OkVslCFd1V1nlPSOudkVeITg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB2967.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(66446008)(66476007)(55016002)(64756008)(66556008)(2906002)(54906003)(66946007)(9686003)(86362001)(966005)(76116006)(71200400001)(7696005)(55236004)(8676002)(6506007)(5660300002)(26005)(66574015)(52536014)(122000001)(45080400002)(38100700002)(186003)(33656002)(30864003)(83380400001)(316002)(110136005)(4326008)(8936002)(478600001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0fyMlV2C9Zhk0gWyJzh9PibZG3P6WQWh5fKizyX8/VcWw7OlhfM2XJl4gd?=
 =?iso-8859-1?Q?Y+GWFyco+Pf0PiaWJj0lNykmGVKnFbmRakSYk9KuFuRBltf6vAN3dynQpN?=
 =?iso-8859-1?Q?k1tBtL2/1Zl92jaXcfUKRcwMVV4WHv0HF9Yy35Al+ulV+aEjrTR+qRcLGZ?=
 =?iso-8859-1?Q?wvaoSndcUOKOCcQvquOE5eNT6uN57uLUXqlS0YO4/4lu9eDhCSCQ3PRH04?=
 =?iso-8859-1?Q?YzQlY9eiNQdI8G6mBT64xHHlrnXJcBbbHF/+iLjUleNJctXyTsNMvOQEEr?=
 =?iso-8859-1?Q?NE2ufSsKf05BedOQ8YDrC/qeLwekdWSA0ZAtAVeHfvMiUO88Uo59g5AGbH?=
 =?iso-8859-1?Q?Ht9DI5ieuCfH+FN9gPyn9rJvuhedoXnuSa6AJUolbQsFFErO2/mAAwoElP?=
 =?iso-8859-1?Q?+rseVsPDc07fT2Ha0J5/7HO6mWwf2wgg09vrTK7IZefrz5xN78l4gPcNLa?=
 =?iso-8859-1?Q?q/z9J4+8BkkGM12I8dhUbhC0eYISw3SRf9mOzTCSseaLBxHNGwV9abpyRA?=
 =?iso-8859-1?Q?BJm1RKEpn4A7avgNysLwEtAHyisw4+USatEUh44UpnGfpCIr6M7f7dWNV5?=
 =?iso-8859-1?Q?jvYnFyQbWE8FID2brl9T6PPBNttohYCJnpGG/NbnUqbOpH+vYOGHwW/k+I?=
 =?iso-8859-1?Q?agScAMVhSROzqXEghWQbyVXktNsq1oHzO+jXDiUF105QGBMYuV4NgsQ4vS?=
 =?iso-8859-1?Q?4q72LTtSB8RBzdSjUKaSBIPbEdLPaiyiAVTs8hap1bsJ9clID8lYcwjwpj?=
 =?iso-8859-1?Q?DjNvWKVmaJFLS0WYjXRZYrWs54Ks1R+aRdUT/YXnR/+SF8GTMX+d2h9z13?=
 =?iso-8859-1?Q?KNfHC4naGOuPG/GBNFTMl7wy+j8pU1uRNkkXpX2HnDd3WbkQz52Siu+W3H?=
 =?iso-8859-1?Q?PKWu6mHu7Aaautr0E5THUvvI98VyR+r6wy5QxbB8gsg1tW9Sk/YCr6yN6a?=
 =?iso-8859-1?Q?NqBPkRVWEZuoyjj1bfi9UzF6KdOcg+AAomeYmSoKqUouS0Y4NzBS3FB9Ik?=
 =?iso-8859-1?Q?AkPCMZZNkyhjWPpRn3yxltJ9yz2csBcLor1ujtHywkhoK8ysIESBVR7/Sg?=
 =?iso-8859-1?Q?s+EbXQheW3XoloqEUk2s4/fiQ8f6cKxnQ46I2xmI/Wl2MLH2LyecaGHK+A?=
 =?iso-8859-1?Q?stLclTmYJacS+hXeTTU1QCrEv5eyRxsbZTchCZi9Io3riDAPaYDgvUXaCW?=
 =?iso-8859-1?Q?37sOzeABPZuboQBEY/kKHMKZ1nYSJe3MF5xWYwfHHbIe1QejFFOnyIv6tP?=
 =?iso-8859-1?Q?HLCTF1ZOGd+ubBfZ12KfdZbsqSDNbH76WBDogBzgcARk5QojjeLDhsjhHz?=
 =?iso-8859-1?Q?5oPPADwJb5ZfZpGHgFhEtLTfa2jqwH3tEQfrj1ndTlHpa1LUHPikbimInq?=
 =?iso-8859-1?Q?xNtFkPBSIa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: non.se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB2967.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7882d3ad-d30e-4cf5-134e-08d93b075946
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 14:08:19.6761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN4hdEn+7nNiy+9u24PiQAHaCn0h3L6oiCHLKmvdSGp37wbGt89kw/QRkB8tPq+0gYr28Vx40CrxkqjTbzAQ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4524
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

  This is ADC driver that can be found in the Renesas  RZ/N1D SoC
  https://www.renesas.com/us/en/document/man/rzn1d-group-rzn1s-group-rzn1l-=
group-users-manual-peripherals-0?language=3Den&r=3D1054561

  ADC Core Features
  - Up to 2 units
  - Resolution 12-bit
  - Sampling rate from 0.0625 MSPS to 1 MSPS
  - Successive approximation
  - Maximal conversion time 21 ADC_CLK
  - Analog inputs 8 channels per core
  (5 standard channels + 3 channels with sample/hold)
  - Each channel has his own input trigger to start the conversion,
  the triggers are managed by the ADC Controller
  - Power down mode
  - ADC clock frequency from 4 MHz to 20 MHz

Signed-off-by: Tomasz Kazimierz Motyl <tomasz.motyl@se.com>
Signed-off-by: Frederic Loreaud <frederic.loreaud@se.com>
Signed-off-by: Pierre Castellan <pierre.castellan@non.se.com>
---
 drivers/iio/adc/Kconfig         |  10 +
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/r9a06g032-adc.c | 352 ++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/iio/adc/r9a06g032-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f0af3a42f53c..c6ab22aa2000 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -746,6 +746,16 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
=20
+config R9A06G032_ADC
+	depends on  ARCH_R9A06G032 || COMPILE_TEST
+	tristate "Renesas ADC driver"
+	help
+	  Say yes here to build support for the ADCs found in SoCs from
+	  Renesas.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzn1_adc.
+
 config SC27XX_ADC
 	tristate "Spreadtrum SC27xx series PMICs ADC"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ef9cc485fb67..84c2ccae4317 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
+obj-$(CONFIG_R9A06G032_ADC) +=3D r9a06g032-adc.o
 obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) +=3D spear_adc.o
 obj-$(CONFIG_STX104) +=3D stx104.o
diff --git a/drivers/iio/adc/r9a06g032-adc.c b/drivers/iio/adc/r9a06g032-ad=
c.c
new file mode 100644
index 000000000000..6c41ad74c868
--- /dev/null
+++ b/drivers/iio/adc/r9a06g032-adc.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Driver for Renesas R9A06G032 SoC built-in ADC
+ *
+ * Authors:
+ *  Tomasz Kazimierz Motyl
+ *  Fr=E9d=E9ric Loreaud
+ *  Pierre Castellan
+ *
+ * Copyright (C) 2021 Schneider-Electric
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/firmware/lces_monitor.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <asm/div64.h>
+
+/* force conversion register */
+#define R9A06G032_ADC_SET_FORCE_REG_OFFSET  (13 * sizeof(u32))
+/* configuration register */
+#define R9A06G032_ADC_CONFIG_REG_OFFSET		(16 * sizeof(u32))
+/* configuration register's power down bit */
+#define R9A06G032_ADC_CONFIG_POWER_DOWN_BIT	BIT(3)
+
+/* virtual channels 0..8 control registers */
+#define R9A06G032_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET  (48 * sizeof(u32))
+/* control registers' virtual channels' bits */
+#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK  GENMASK(2, 0)
+/* control registers' enable bit */
+#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT  BIT(15)
+/* ADC 1 virtual channels conversion data register */
+#define R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET  (6=
4 * sizeof(u32))
+/* read data register's bits */
+#define R9A06G032_ADC_READ_DATA_VALUE_MASK  GENMASK(11, 0)
+/* read data register's update bit */
+#define R9A06G032_ADC_READ_DATA_UPDATE_BIT  BIT(31)
+
+#define R9A06G032_ADC_CHANNEL(index) {  \
+	.type =3D IIO_VOLTAGE,                                  \
+	.indexed =3D 1,                                         \
+	.channel =3D (index),                                     \
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),            \
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_type =3D {          \
+		.sign =3D 'u',          \
+		.realbits =3D 12,   \
+		.storagebits =3D 16,    \
+		.shift =3D 0,    \
+		.endianness =3D IIO_BE, \
+	},                      \
+	.extend_name =3D NULL,    \
+}
+
+/* R9A06G032 ADC has 8 channels */
+#define R9A06G032_ADC_NUM_CHANNELS 8
+
+static struct iio_chan_spec r9a06g032_adc_channels[R9A06G032_ADC_NUM_CHANN=
ELS] =3D {
+	R9A06G032_ADC_CHANNEL(0),
+	R9A06G032_ADC_CHANNEL(1),
+	R9A06G032_ADC_CHANNEL(2),
+	R9A06G032_ADC_CHANNEL(3),
+	R9A06G032_ADC_CHANNEL(4),
+	R9A06G032_ADC_CHANNEL(5),
+	R9A06G032_ADC_CHANNEL(6),
+	R9A06G032_ADC_CHANNEL(7),
+};
+
+/* Device's private data */
+struct r9a06g032_adc {
+	struct device *dev;
+
+	struct mutex lock; /* channels readings must be done sequentially */
+	struct completion complete;
+	void __iomem *registers;
+	resource_size_t phys_base;
+	struct clk *clk;
+	uint64_t conv_delay;
+};
+
+static inline uint32_t r9a06g032_adc_read32(struct r9a06g032_adc *const ad=
c,
+					     const uint32_t reg_off)
+{
+	void __iomem *addr =3D adc->registers + reg_off;
+
+	return ioread32(addr);
+}
+
+static inline void r9a06g032_adc_write32(struct r9a06g032_adc *const adc,
+					  const uint32_t reg_off,
+					  const uint32_t val)
+{
+	iowrite32(val, adc->registers + reg_off);
+}
+
+static bool r9a06g032_adc_interrupt_status(struct r9a06g032_adc *const adc=
,
+					    const int virtual_channel)
+{
+	bool ret;
+	/* interrupt 0 status register has a 0 offset in register table */
+	uint32_t status =3D r9a06g032_adc_read32(adc, 0);
+
+	ret =3D status & BIT(virtual_channel);
+
+	return ret;
+}
+
+static int r9a06g032_adc_read_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2, long mask)
+{
+	struct r9a06g032_adc *adc =3D iio_priv(indio_dev);
+	int virtual_channel =3D chan->channel;
+	uint32_t virtual_channel_control_offset =3D R9A06G032_ADC_VIRTUAL_CHANNNE=
LS_REGS_OFFSET + 4 * virtual_channel;
+	uint32_t virtual_channel_control =3D R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_E=
NABLE_BIT | (R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK & virtual_ch=
annel);
+	uint32_t read_data =3D 0;
+	int ret =3D 0;
+
+	if ((virtual_channel < 0)
+	    || (virtual_channel > R9A06G032_ADC_NUM_CHANNELS)) {
+		dev_err(adc->dev,
+			"Invalid channel index (%i)\n", virtual_channel);
+		return  -EINVAL;
+	}
+	mutex_lock(&adc->lock);
+
+	/*  disable power down mode, disable DMA and Sample & Hold mode */
+	r9a06g032_adc_write32(adc, R9A06G032_ADC_CONFIG_REG_OFFSET,
+			       0x00000000);
+
+	/* map virtual to physical channels 1:1 */
+	r9a06g032_adc_write32(adc, virtual_channel_control_offset,
+			       virtual_channel_control);
+
+	/* force conversion on vc[chan_idx] channel */
+	r9a06g032_adc_write32(adc, R9A06G032_ADC_SET_FORCE_REG_OFFSET,
+			       BIT(virtual_channel));
+
+	/*  Wait for maximum conversion duration of 21 ADC clock periods */
+	ndelay(adc->conv_delay);
+
+	read_data =3D r9a06g032_adc_read32(adc,
+					  (R9A06G032_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET
+					  + 4 * virtual_channel));
+
+	if ((read_data & R9A06G032_ADC_READ_DATA_UPDATE_BIT) =3D=3D 0
+		|| (r9a06g032_adc_interrupt_status(adc,
+						virtual_channel) =3D=3D false)) {
+		ret =3D -EINVAL;	/* error reading input value */
+		goto exit_point;
+	}
+
+	*val =3D read_data & R9A06G032_ADC_READ_DATA_VALUE_MASK;
+
+	/* enable power down mode, keep DMA and Sample & Hold mode disabled */
+	r9a06g032_adc_write32(adc, R9A06G032_ADC_CONFIG_REG_OFFSET,
+			      R9A06G032_ADC_CONFIG_POWER_DOWN_BIT);
+	ret =3D IIO_VAL_INT;
+
+exit_point:
+	mutex_unlock(&adc->lock);
+	return ret;
+}
+static int r9a06g032_adc_read_label(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     char *label)
+{
+	strcpy(label, indio_dev->channels->extend_name);
+	return 0;
+}
+
+static const struct iio_info r9a06g032_adc_info =3D {
+	.read_raw =3D &r9a06g032_adc_read_raw,
+	.read_label =3D &r9a06g032_adc_read_label,
+};
+
+static int r9a06g032_adc_parse_channels_of(struct r9a06g032_adc *adc,
+					    struct device_node *dn,
+					    const int num_channels)
+{
+	int ret;
+	struct device_node *channels;
+	struct device_node *channel;
+	struct iio_chan_spec *chanp;
+
+	channels =3D of_get_child_by_name(dn, "channels");
+
+	if (channels =3D=3D NULL)
+		return  -EINVAL;
+
+	for_each_available_child_of_node(channels, channel) {
+
+		uint32_t reg =3D 0;
+
+		ret =3D of_property_read_u32(channel, "reg", &reg);
+
+		if (ret !=3D 0)
+			return ret;
+
+		if (reg >=3D num_channels) {
+			dev_err(adc->dev, "wrong reg child node value %i\n",
+				reg);
+			return -EINVAL;
+		}
+		chanp =3D &r9a06g032_adc_channels[reg];
+		chanp->extend_name =3D of_get_property(channel, "label", NULL);
+	}
+	return 0;
+}
+
+static int r9a06g032_adc_setup_channel_names(struct r9a06g032_adc *adc,
+					      struct iio_dev *const indio_dev)
+{
+	struct device_node *dn =3D indio_dev->dev.of_node;
+	int ret =3D r9a06g032_adc_parse_channels_of(adc, dn,
+						   indio_dev->num_channels);
+
+	if (ret < 0)
+		dev_warn(adc->dev, "unable to parse channels!\n");
+
+	return ret;
+}
+
+static int r9a06g032_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct r9a06g032_adc *adc;
+	struct resource *res;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
+
+	if (indio_dev =3D=3D NULL) {
+		dev_err(&pdev->dev, "Failed to allocate memory for an IIO device!\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	adc =3D iio_priv(indio_dev);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/*
+	 * Initialize private physical address for
+	 * R9A06G032 secure monitor calls
+	 */
+	adc->phys_base =3D res->start;
+	adc->registers =3D devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(adc->registers)) {
+		dev_err(dev, "Unable to acquire memory mapping for the registers!\n");
+		return  PTR_ERR(adc->registers);
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	adc->dev =3D dev;
+
+	/* Enabling clock for the ADC */
+	adc->clk =3D devm_clk_get(&pdev->dev, "r9a06g032_adc_clk");
+
+	if (IS_ERR(adc->clk)) {
+		dev_err(dev, "Failed to get the clock!\n");
+		ret =3D PTR_ERR(adc->clk);
+	}
+	ret =3D clk_prepare_enable(adc->clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable the clock!\n");
+		return ret;
+	}
+	dev_info(dev, "ADC clock rate: %lu Hz\n", clk_get_rate(adc->clk));
+
+	/*
+	 * Estimate the max delay in ns,
+	 * 20 clock tics + 1 clock tic for safety
+	 */
+	adc->conv_delay =3D div_u64(21000000000, clk_get_rate(adc->clk));
+	dev_info(dev, "ADC conversion delay : %llu ns\n", adc->conv_delay);
+
+	mutex_init(&adc->lock);
+	init_completion(&adc->complete);
+
+	indio_dev->name =3D dev_name(dev);
+	indio_dev->dev.parent =3D dev;
+	indio_dev->dev.of_node =3D pdev->dev.of_node;
+	indio_dev->info =3D &r9a06g032_adc_info;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->channels =3D r9a06g032_adc_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(r9a06g032_adc_channels);
+
+	if (r9a06g032_adc_setup_channel_names(adc, indio_dev) < 0)
+		dev_warn(dev,
+			 "Invalid channels information - using defaults.\n");
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret) {
+		clk_disable(adc->clk);
+		dev_err(dev, "Failed to register IIO device %s': %d\n",
+			indio_dev->name, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int r9a06g032_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
+
+	iio_device_unregister(indio_dev);
+	iio_map_array_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct platform_device_id r9a06g032_adc_ids[] =3D {
+	{ .name =3D "r9a06g032-adc", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(platform, r9a06g032_adc_ids);
+
+static const struct of_device_id r9a06g032_adc_dt_ids[] =3D {
+	{ .compatible =3D "r9a06g032-adc", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, r9a06g032_adc_dt_ids);
+
+static struct platform_driver r9a06g032_adc_driver =3D {
+	.driver =3D {
+		   .name =3D "r9a06g032-adc",
+		   .of_match_table =3D of_match_ptr(r9a06g032_adc_dt_ids),
+		    },
+	.probe =3D r9a06g032_adc_probe,
+	.remove =3D r9a06g032_adc_remove,
+	.id_table =3D r9a06g032_adc_ids,
+};
+
+module_platform_driver(r9a06g032_adc_driver);
+
+MODULE_DESCRIPTION("R9A06G032 ADC Driver for LCES2");
+MODULE_AUTHOR("Tomasz Kazimierz Motyl <Tomasz.Motyl@schneider-electric.com=
>");
+MODULE_LICENSE("GPL");
--=20
2.25.1


Internal

-----Message d'origine-----
De=A0: Jonathan Cameron <jic23@kernel.org>=20
Envoy=E9=A0: samedi 6 mars 2021 16:33
=C0=A0: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc=A0: Milan Stevanovic <milan.o.stevanovic@gmail.com>; linux-iio@vger.kern=
el.org; Tomasz Motyl <tomasz.motyl@se.com>; FREDERIC LOREAUD <frederic.lore=
aud@se.com>; Pierre CASTELLAN <pierre.castellan@non.se.com>
Objet=A0: Re: [PATCH] iio:adc: Add RZ/N1D ADC driver

[External email: Use caution with links and attachments]

________________________________



On Fri, 5 Mar 2021 12:35:52 +0100 (CET)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> >   This is ADC driver that can be found in the Renesas  RZ/N1D SoC
> >  =20
> > https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> > w.renesas.com%2Fus%2Fen%2Fdocument%2Fman%2Frzn1d-group-rzn1s-group-r
> > zn1l-group-users-manual-peripherals-0%3Flanguage%3Den%26r%3D1054561&
> > amp;data=3D04%7C01%7Cpierre.castellan%40non.se.com%7Cee924b6c387446980
> > b4a08d8e0b52d60%7C6e51e1adc54b4b39b5980ffe9ae68fef%7C0%7C0%7C6375064
> > 16060866030%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DtpS8Cj559utCRyvV
> > p17y7yviZnHTvBjEZ4gUd4c4PaI%3D&amp;reserved=3D0
> >
> some comments below; some are purely matter-of-taste and can be=20
> ignored :)
Thanks Peter.

I'll review on top of yours so hopefully no overlap.

Jonathan


>
> >   ADC Core Features
> >   - Up to 2 units
> >   - Resolution 12-bit
> >   - Sampling rate from 0.0625 MSPS to 1 MSPS
> >   - Successive approximation
> >   - Maximal conversion time 21 ADC_CLK
> >   - Analog inputs 8 channels per core
> >   (5 standard channels + 3 channels with sample/hold)
> >   - Each channel has his own input trigger to start the conversion,
> >   the triggers are managed by the ADC Controller
> >   - Power down mode
> >   - ADC clock frequency from 4 MHz to 20 MHz
> >
> > Signed-off-by: Tomasz Kazimierz Motyl <tomasz.motyl@se.com>
> > Signed-off-by: Frederic Loreaud <frederic.loreaud@se.com>
> > Signed-off-by: Pierre Castellan <pierre.castellan@non.se.com>
> > ---
> >  .../devicetree/bindings/iio/adc/rzn1-adc.txt  |  64 ++++
> >  drivers/iio/adc/Kconfig                       |   9 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/rzn1-adc.c                    | 325 ++++++++++++++++++
> >  4 files changed, 399 insertions(+)
> >  create mode 100644=20
> > Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
> >  create mode 100644 drivers/iio/adc/rzn1-adc.c
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt=20
> > b/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
> > new file mode 100644
> > index 000000000000..ff5b277fb470
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
yaml

No new bindings accepted in txt (certainly for IIO, but probably more gener=
al by now).

Binding also needs to be in a separate patch and cc'd to device tree mainta=
iners and list.

> > @@ -0,0 +1,64 @@
> > +ADC for the Renesas RZ/N1D (R9A06G032).
> > +Specifications on the converters can be found at:
> > +https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw
> > +ww.renesas.com%2Fus%2Fen%2Fdocument%2Fman%2Frzn1d-group-rzn1s-group
> > +-rzn1l-group-users-manual-peripherals-0%3Flanguage%3Den%26r%3D10545
> > +61&amp;data=3D04%7C01%7Cpierre.castellan%40non.se.com%7Cee924b6c38744
> > +6980b4a08d8e0b52d60%7C6e51e1adc54b4b39b5980ffe9ae68fef%7C0%7C0%7C63
> > +7506416060866030%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> > +oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DtpS8Cj559
> > +utCRyvVp17y7yviZnHTvBjEZ4gUd4c4PaI%3D&amp;reserved=3D0
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "iio,rzn1-adc", "rzn1-adc"
> > +- reg: Offset and length of the register set for the device
> > +- clocks: phandle to the master clock (all_adc)
> > +   see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +- clock-names: Must be "rzn1_adc_clk".
> > +
> > +Optional properties:

If optional, you shouldn't print a message if it is not there.

> > +channels:
> > +label: A channel label that is used as channel's extended name part i.=
e.:
> > +       A label =3D "temp1"  for channel1@1 results in a following entr=
y in the sysfs:
> > +       /sys/bus/iio/devices/iio:device0/in_voltage1_temp1_raw .
> > +       If the label would not be specified the resulting sysfs entry w=
ould be as follows:
>
> maybe: If the label is not specified, the results sysfs entry will be as =
follows:

given we now have
in_voltage1_label well defined via the read_label() callback and that deals=
 with the mess around extend_name and having to dynamically generate the ch=
an_spec array, just use that instead.
It's a standard binding in Documentation/devicetree/bindings/iio/adc/adc.ya=
ml

As a side note, bindings don't describe linux behaviour (used across lots o=
f different software even if they do still hid in the kernel tree) so drop =
all this description anyway.


>
> > +       /sys/bus/iio/devices/iio:device0/in_voltage1_raw .
> > +
> > +
> > +Whenever specified incorrectly or unspecified an entry gets skipped an=
d driver falls back to hard-coded defaults.
>
> maybe comma after 'unspecified'
>
> > +
> > +Example:
> > +
> > +  rzn1_adc: rzn1-adc@0x40065000 {
> > +    #address-cells =3D <1>;
> > +    #size-cells =3D <1>;
> > +    compatible =3D "renesas,r9a06g032-adc", "iio,rzn1-adc", "rzn1-adc"=
;
> > +    reg =3D  <0x40065000 0x1000>;
> > +    clocks =3D <&sysctrl R9A06G032_CLK_ADC>;
> > +    clock-names =3D "rzn1_adc_clk";
> > +    status =3D "okay";
> > +
> > +       channels {
> > +         #address-cells =3D <1>;
> > +         #size-cells    =3D <0>;
> > +
> > +         chan0@0 { /* Channel 0 placeholder */
> > +           reg =3D <0>;
> > +           label =3D "adc1_in0";
> > +         };
> > +
> > +         chan1@1 { /* Channel 1 placeholder */
> > +           reg   =3D <1>;
> > +           label =3D "adc1_in1";
> > +         };
> > +
> > +         chan2@2 { /* Channel 2 placeholder */
> > +           reg =3D <2>;
> > +           label =3D "adc1_in2";
> > +         };
> > +
> > +         chan3@3 { /* Channel 3 placeholder */
> > +           reg   =3D <3>;
> > +           label =3D "adc1_in3";
> > +         };
> > +
> > +         chan4@4 { /* Channel 4 placeholder */
> > +           reg =3D <4>;
> > +           label =3D "adc1_in4";
> > +         };
> > +      }; /* channels */
> > +    }; /* rzn1-adc */
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index=20
> > f0af3a42f53c..d4d1af3e6ba2 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -746,6 +746,15 @@ config ROCKCHIP_SARADC
> >       To compile this driver as a module, choose M here: the
> >       module will be called rockchip_saradc.
> >
> > +config RZN1_ADC
> > +   tristate "Renesas ADC driver"

Depends on SOMETHING_RENESAS || COMILE_TEST would normally be the case to a=
void this accidentally turning up in the distro on my x86 laptop.

> > +   help
> > +     Say yes here to build support for the ADCs found in SoCs from
> > +     Renesas.
> > +
> > +     To compile this driver as a module, choose M here: the
> > +     module will be called rzn1_adc.
> > +
> >  config SC27XX_ADC
> >     tristate "Spreadtrum SC27xx series PMICs ADC"
> >     depends on MFD_SC27XX_PMIC || COMPILE_TEST diff --git=20
> > a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile index=20
> > ef9cc485fb67..562d3ac3c7be 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
> >  obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoadc.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> > +obj-$(CONFIG_RZN1_ADC) +=3D rzn1-adc.o
> >  obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) +=3D spear_adc.o
> >  obj-$(CONFIG_STX104) +=3D stx104.o
> > diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c=20
> > new file mode 100644 index 000000000000..3f5fbb1fd9aa
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzn1-adc.c
> > @@ -0,0 +1,325 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for Renesas RZN1 SoC built-in ADC
> > + *
> > + * Authors:
> > + *  Tomasz Kazimierz Motyl
> > + *  Fr=E9d=E9ric Loreaud
> > + *  Pierre Castellan
> > + *
> > + * Copyright (C) 2021 Schneider-Electric  */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mutex.h>
> > +#include <linux/completion.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/iio/driver.h>
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <linux/firmware/lces_monitor.h> #include <linux/delay.h>=20
> > +#include <linux/bits.h>
> > +
> > +static const uint32_t RZN1_ADC_SET_FORCE_REG_OFFSET =3D 13 * sizeof(ui=
nt32_t);       // force conversion register
Very long lines so think about how to reduce these.
Also, why not just use defines?

> > +
> > +static const uint32_t RZN1_ADC_CONFIG_REG_OFFSET =3D 16 * sizeof(uint3=
2_t);  // configuration register
> > +static const uint32_t RZN1_ADC_CONFIG_POWER_DOWN_BIT =3D BIT(3);     /=
/ configuration register's power down bit
> > +
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET =3D 48 * =
sizeof(uint32_t);      // virtual channels 0..15 control registers
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK =3D=
 GENMASK(2, 0);        // control registers' virtual channels' bits
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT =3D=20
> > +BIT(15);  // control registers' enable bit
> > +
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_RE=
GS_OFFSET =3D 64 * sizeof(uint32_t);   // ADC 1 virtual channels conversion=
 data register
> > +
> > +static const uint32_t RZN1_ADC_READ_DATA_VALUE_MASK =3D GENMASK(11, 0)=
;      // read data register's bits
> > +static const uint32_t RZN1_ADC_READ_DATA_UPDATE_BIT =3D BIT(31);     /=
/ read data register's update bit
> > +
> > +#define RZN1_ADC_CHANNEL(index, bits, _shift, _info_mask_sep, name) { =
 \
> > +   .type =3D IIO_VOLTAGE,                                  \
> > +   .indexed =3D 1,                                         \
> > +   .channel =3D index,                                     \
>
> maybe also parenthesis, (index)
>
> > +   .info_mask_separate =3D _info_mask_sep,                 \
> > +   .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> > +   .scan_type =3D {          \
> > +           .sign =3D 'u',          \
> > +           .realbits =3D (bits),   \
> > +           .storagebits =3D 16,    \
> > +           .shift =3D (_shift),    \
> > +           .endianness =3D IIO_BE, \
> > +   },                      \
> > +   .extend_name =3D name,    \
> > +}
> > +
> > +#define RZN1_ADC_NUM_CHANNELS 8    // RZN1 ADC has 8 channels
> > +
> > +static struct iio_chan_spec=20
> > +rzn1_adc_channels[RZN1_ADC_NUM_CHANNELS] =3D {
const

If you use the label stuff I mention below then driver won't be modifying t=
hese.

> > +   RZN1_ADC_CHANNEL(0, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),

Odd to have a parameter then set it to same value in all cases.
RZN1_ADC_CHANNEL(0) looks like enough to me.


> > +   RZN1_ADC_CHANNEL(1, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(2, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(3, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(4, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(5, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(6, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +   RZN1_ADC_CHANNEL(7, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL) };
> > +
> > +// Device's private data
> > +struct rzn1_adc {
> > +   struct device *dev;
> > +
> > +   struct mutex lock;

Locks should have a comment defining exactly what they are protecting.
Here I think it is serializing reads...

> > +   struct completion complete;
> > +   void __iomem *registers;
> > +   resource_size_t phys_base;
> > +   struct clk *clk;
> > +};
> > +
> > +static inline uint32_t rzn1_adc_read32(struct rzn1_adc *const adc,=20
> > +const uint32_t reg_off) { #if defined(CONFIG_LCES_SECURE_MONITOR)
> > +   return __monitor_readl(adc->phys_base + reg_off); #else
> > +   void __iomem *addr =3D adc->registers + reg_off;
> > +
> > +   return ioread32(addr);
> > +#endif
> > +}
> > +
> > +static inline void rzn1_adc_write32(struct rzn1_adc *const adc,=20
> > +const uint32_t reg_off, const uint32_t val) { #if=20
> > +defined(CONFIG_LCES_SECURE_MONITOR)

Is this upstream?  It sounds like an odd thing to do via a define rather th=
an some sort of runtime switch.


> > +   __monitor_masked_writel(val, adc->phys_base + reg_off, ~0UL);=20
> > +#else
> > +   iowrite32(val, adc->registers + reg_off); #endif }
> > +
> > +static bool interrupt_status(struct rzn1_adc *const adc, const int=20
> > +virtual_channel)
>
> rzn1_adc_ prefix for consistency please
>
> > +{
> > +   bool ret =3D false;
> > +
> > +   if ((virtual_channel >=3D 0) && (virtual_channel <=20
> > + RZN1_ADC_NUM_CHANNELS)) {

I think you've already checked this in the caller. No point in doing it aga=
in.


> > +           // interrupt 0 status register has a 0 offset in register t=
able
> > +           uint32_t status =3D rzn1_adc_read32(adc, 0);
> > +
> > +           if (status & BIT(virtual_channel))
> > +                   ret =3D true;

return true;

or

return status & BIT(virtual_channel);

> > +   }
> > +
> > +   return ret;
return false;

> > +}
> > +
> > +static int rzn1_adc_read_raw(struct iio_dev *indio_dev, struct=20
> > +iio_chan_spec const *chan, int *val, int *val2, long mask) {
> > +   int ret =3D IIO_VAL_INT;
> > +
> > +   struct rzn1_adc *adc =3D iio_priv(indio_dev);
> > +   int virtual_channel =3D chan->channel;
> > +   uint32_t virtual_channel_control_offset =3D=20
> > + RZN1_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET + 4 * virtual_channel;
Rethink naming to reduce length of these lines to manageable level.  Kernel=
 uses
u32 and similar types for internal stuff.
        u32 virt_chan_ctl_off =3D RZN1_ADC_VIRT_CHAN_REG_OFF + 4 * virt_cha=
n; for example

> > +   uint32_t virtual_channel_control =3D RZN1_ADC_VIRTUAL_CHANNEL_ADC1_=
ENABLE_BIT | (RZN1_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK & virtual_channe=
l);
> > +   uint32_t read_data =3D 0;
> > +
> > +   (void)mask;

?  Kernel doesn't care about unused variables in callback functions.

> > +   (void)val2;
> > +
> > +   if ((virtual_channel >=3D 0) && (virtual_channel <=20
> > + RZN1_ADC_NUM_CHANNELS)) {
>
> not sure if the channel number can be invalid, maybe the IIO framework=20
> guarantees it is in range

It does though not uncommon to exercise a bit of paranoia and check it so I=
 don't mind if this stays

>
> I think it is generally more readable to check for error condition and=20
> error out, like so:
> if (sth_wrong) {
>   return -EINVAL;
> }
> sth_right;

Definitely (I'm reviewing backwards so a many comments on this below :)

If you have a mutex held, use a goto unlock; and appropriate label.


>
> > +           mutex_lock(&adc->lock);
> > +
> > +           // disable power down mode, disable DMA and Sample & Hold m=
ode
> > +           rzn1_adc_write32(adc, RZN1_ADC_CONFIG_REG_OFFSET,=20
> > + 0x00000000);
> > +
> > +           // map virtual to physical channels 1:1
> > +           rzn1_adc_write32(adc, virtual_channel_control_offset,=20
> > + virtual_channel_control);
> > +
> > +           // force conversion on vc[chan_idx] channel
> > +           rzn1_adc_write32(adc, RZN1_ADC_SET_FORCE_REG_OFFSET,=20
> > + BIT(virtual_channel));
> > +
> > +           //  Wait for maximum conversion duration of 21 ADC clock pe=
riods
> > +           //  ADC clock frequency is 20 MHz hence period is 50 ns
> > +           //  Add one more period for safety
> > +           ndelay(22 * 50);
> > +
> > +           read_data =3D rzn1_adc_read32(adc,=20
> > + RZN1_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET + 4 *=20
> > + virtual_channel);
> > +
> > +           if ((read_data & RZN1_ADC_READ_DATA_UPDATE_BIT)
> > +               && (interrupt_status(adc, virtual_channel) =3D=3D true)=
)
> > +                   *val =3D read_data & RZN1_ADC_READ_DATA_VALUE_MASK;
> > +           else
> > +                   ret =3D -EINVAL;  // error reading input value
> > +
> > +           // enable power down mode, keep DMA and Sample & Hold mode =
disabled
> > +           rzn1_adc_write32(adc, RZN1_ADC_CONFIG_REG_OFFSET,=20
> > + RZN1_ADC_CONFIG_POWER_DOWN_BIT);
> > +
> > +           mutex_unlock(&adc->lock);
> > +   } else {
> > +           dev_err(adc->dev, "virtual channel index (%i) is greater=20
> > + than 16\n", virtual_channel);
>
> why 16? _NUM_CHANNELS is 8?
>
> > +   }
> > +
> > +   return ret;
> > +}
> > +
> > +static const struct iio_info rzn1_adc_info =3D {
> > +   .read_raw =3D &rzn1_adc_read_raw
> > +};
> > +
> > +static int rzn1_adc_parse_channels_of(struct rzn1_adc *adc, struct=20
> > +device_node *dn, const int num_channels)

Very long lines.  Keep to 80 chars max unless there is a good reason and a =
very very good reason is needed to go beyond 100 chars (usually something l=
ike not splitting a string up someone might want to grep for)

> > +{
> > +   int ret =3D 0;
> > +

No blank lines in variable declarations unless they add something.

> > +   struct device_node *channels =3D NULL;
>
> no need to initialize
>
> > +   struct device_node *channel =3D NULL;
>
> put in local scope?
>
> > +
> > +   channels =3D of_get_child_by_name(dn, "channels");
> > +   if (channels =3D=3D NULL) {
> > +           dev_err(adc->dev, "no channels child node found\n");
> > +           ret =3D -EINVAL;
>
> maybe just return -EINVAL here?

As below, definitely so as to allow dropping indentation of following code.

>
> > +   } else {
> > +           for_each_available_child_of_node(channels, channel) {
> > +                   // Stop parsing channels if any error occured
> > +                   if (!ret) {

Just return where you get the error rather than this odd carry on of the lo=
op whilst not doing anything.

> > +                           uint32_t reg =3D 0;
> > +
> > +                           ret =3D of_property_read_u32(channel, "reg"=
, &reg);
> > +                           if (ret) {
> > +                                   dev_err(adc->dev, "no reg child=20
> > + node found\n");

return ret;

> > +                           } else {
> > +                                   if (reg >=3D num_channels) {
> > +                                           dev_err(adc->dev, "wrong re=
g child node value %i\n", reg);
> > +                                           ret =3D -EINVAL;

return -EINVAL;

> > +                                   } else {
> > +                                           struct iio_chan_spec *chanp=
 =3D &rzn1_adc_channels[reg];
> > +                                           chanp->extend_name =3D=20
> > + of_get_property(channel, "label", NULL);

We now have a core support for a _label attribute for channels.  That's a m=
uch nicer interface than extend_name ever was so please switch over to that=
.  It uses the read_label() callback.

> > +                                   }
> > +                           }
> > +                   }
> > +           }
> > +   }
> > +
> > +   return ret;
> > +}
> > +
> > +static int setup_channel_names(struct rzn1_adc *adc, struct iio_dev=20
> > +*const indio_dev)

This wrapper doesn't do much, so I'd just call the parse_channels_of() dire=
ctly at the call site.

>
> rzn1_adc_ prefix?
>
> > +{
> > +   //struct iio_chan_spec rzn1_adc_channels
>
> drop comment
>
> > +   struct device_node *dn =3D indio_dev->dev.of_node;
> > +   int err =3D rzn1_adc_parse_channels_of(adc, dn,=20
> > + indio_dev->num_channels);
>
> maybe err -> ret?
>
> > +
> > +   if (err < 0)
> > +           dev_warn(adc->dev, "unable to parse channels!\n");

Not fatal?  Sounds like it probably should be, or we shouldn't be warning.

> > +
> > +   return err;
> > +}
> > +
> > +static int rzn1_adc_probe(struct platform_device *pdev) {
> > +   struct device *dev =3D &pdev->dev;
> > +   struct iio_dev *indio_dev =3D NULL;
>
> no need to initialize
>
> > +   struct rzn1_adc *adc =3D NULL;
> > +   struct resource *res =3D NULL;
>
> put in local scope, init needed?
>
> > +   int ret =3D 0;
> > +
> > +   indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> > +
> > +   if (indio_dev =3D=3D NULL) {
> > +           dev_err(&pdev->dev, "Failed to allocate memory for an IIO d=
evice!\n");
> > +           ret =3D -ENOMEM;
>
> just return -ENOMEM?

Absolutely.

>
> > +   } else {

returning above also means you can drop indentation here.
If you do the devm_ stuff I've commented on in remove I suspect
platform_set_drvdata() isn't needed any more.

> > +           platform_set_drvdata(pdev, indio_dev);
> > +
> > +           adc =3D iio_priv(indio_dev);
> > +
> > +           res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +           // initilize private physical address for RZN1 secure=20
> > + monitor calls

In  IIO, all comments use /* */ syntax.

> > +           adc->phys_base =3D res->start;
> > +           adc->registers =3D devm_ioremap_resource(dev, res);
> > +
> > +           if (IS_ERR(adc->registers)) {
> > +                   dev_err(dev, "Unable to acquire memory mapping for =
the registers!\n");
> > +                   ret =3D PTR_ERR(adc->registers);

return PTR_ERR(adc->registers);

> > +           } else {

Having returned above can drop indent.

> > +                   platform_set_drvdata(pdev, indio_dev);
> > +                   adc->dev =3D dev;
> > +
> > +                   // Enabling clock for the ADC
> > +                   adc->clk =3D devm_clk_get(&pdev->dev,=20
> > + "rzn1_adc_clk");
> > +
> > +                   if (IS_ERR(adc->clk)) {
> > +                           dev_err(dev, "Failed to get the clock!\n");
> > +                           ret =3D PTR_ERR(adc->clk);

return PTR_ERR() etc

> > +                   } else {
> > +                           ret =3D clk_prepare_enable(adc->clk);

Use devm_add_action_or_reset() to ensure this is disable on error or remove=
.
Lots of examples of this in other drivers.

> > +                           if (ret) {
> > +                                   dev_err(dev, "Could not prepare=20
> > + or enable the clock!\n");

That's a failure case if it happens (I would imagine) so why not error out =
here.
If it's optional then make that clear with a comment or similar.

> > +                           } else {
> > +                                   dev_info(dev, "ADC clock rate:=20
> > + %lu Hz\n", clk_get_rate(adc->clk));

Is that interesting to a normal user?  If not, dev_dbg()

> > +
> > +                                   mutex_init(&adc->lock);
> > +                                   init_completion(&adc->complete);
> > +
> > +                                   indio_dev->name =3D dev_name(dev);

I'm lazy - what does that end up as?  This should be a part number or simil=
ar.

> > +                                   indio_dev->dev.parent =3D dev;
> > +                                   indio_dev->dev.of_node =3D pdev->de=
v.of_node;
> > +                                   indio_dev->info =3D &rzn1_adc_info;
> > +                                   indio_dev->modes =3D INDIO_DIRECT_M=
ODE;
> > +                                   indio_dev->channels =3D rzn1_adc_ch=
annels;
> > +                                   indio_dev->num_channels =3D=20
> > + ARRAY_SIZE(rzn1_adc_channels);
> > +
> > +                                   if (setup_channel_names(adc, indio_=
dev) < 0)
> > +                                           dev_warn(dev, "Invalid=20
> > + channels information - using defaults.\n");
> > +
> > +                                   ret =3D iio_device_register(indio_d=
ev);
> > +                                   if (ret) {
> > +                                           dev_err(dev, "Failed to reg=
ister IIO device %s': %d\n", indio_dev->name, ret);
> > +                                   }
>
> avoid nested blocks
> shouldn't the clock be disabled on failure?
>
> > +                           }
> > +                   }
> > +           }
> > +   }
> > +
> > +   return ret;
> > +}
> > +
> > +static int rzn1_adc_remove(struct platform_device *pdev) {
> > +   struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +
> > +   iio_device_unregister(indio_dev);
> > +   iio_map_array_unregister(indio_dev);

Hmm.. We still don't have devm_iio_map_array_register and probably should b=
y now. In meantime (if you don't want to add it) you can use
devm_add_action_or_reset() to register automated unwinding of this and then=
 use devm_iio_device_register() and get rid of _remove() entirely.


> > +
> > +   return 0;
> > +}
> > +
> > +static const struct platform_device_id rzn1_adc_ids[] =3D {
> > +   { .name =3D "rzn1-adc", },

Do we actually need this?  I'm guessing all modern platforms are DT based a=
nd won't use this?

> > +   { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(platform, rzn1_adc_ids);
> > +
> > +static const struct of_device_id rzn1_adc_dt_ids[] =3D {
> > +   { .compatible =3D "rzn1-adc", },

Vendor prefix

> > +   { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, rzn1_adc_dt_ids);
> > +
> > +static struct platform_driver rzn1_adc_driver =3D {
> > +   .driver =3D {
> > +              .name =3D "rzn1-adc",
> > +              .of_match_table =3D of_match_ptr(rzn1_adc_dt_ids),

Whilst I guess we can be fairly sure this driver will only ever be used wit=
h DT, our preference in IIO is to not use the of_match_ptr protection and j=
ust potentially waste a tiny bit of storage if the driver is built for a no=
n DT system.

Main reason for this is to reduce places it can be cut and paste from where=
 other firmware options are common (this blocks use of ACPI PRP0001 based b=
indings for example)

> > +               },

Indent of that bracket is unusual.  Normally aligns with .

> > +   .probe =3D rzn1_adc_probe,
> > +   .remove =3D rzn1_adc_remove,
> > +   .id_table =3D rzn1_adc_ids,
> > +};
> > +
> > +module_platform_driver(rzn1_adc_driver);
> > +
> > +MODULE_DESCRIPTION("RZN1 ADC Driver for LCES2");=20
> > +MODULE_AUTHOR("Tomasz Kazimierz Motyl=20
> > +<Tomasz.Motyl@schneider-electric.com>");
> > +MODULE_LICENSE("GPL");
> >
>

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
______________________________________________________________________
