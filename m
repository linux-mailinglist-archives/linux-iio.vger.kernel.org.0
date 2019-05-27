Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A812B5E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0M5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 08:57:06 -0400
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:63619
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbfE0M5G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 May 2019 08:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OavO0l4QQ6a4xYYvixsRMyasdEvhVKAMwFQyBlLvSdI=;
 b=A2ogXoyQ5caLp5uol6OHy5u0lmBZNvpWNt7rYMC6XUy5Ljg5wDP4uBU51B42JYBHCr/YRfO9X0TJVae/d1ITV0JY6iDYxIO1/kpOrG79A9M5pvBvoUhMdTr0/EsB516n02UztGiXRFU7vDd/VMcpwbJv0G9ktuvoceEn25ef21o=
Received: from DM6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:40::28) by
 BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.20; Mon, 27 May
 2019 12:57:01 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM6PR03CA0015.outlook.office365.com
 (2603:10b6:5:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.17 via Frontend
 Transport; Mon, 27 May 2019 12:56:18 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 12:56:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4RCuImH022560
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 27 May 2019 05:56:18 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.100) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 27 May 2019 08:56:17 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/4] iio: adc: ad7606: Move oversampling and scale options to chip info
Date:   Mon, 27 May 2019 15:56:47 +0300
Message-ID: <20190527125650.2405-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(8936002)(44832011)(2616005)(476003)(126002)(486006)(7696005)(426003)(4326008)(316002)(50466002)(77096007)(336012)(5660300002)(48376002)(72206003)(26005)(186003)(107886003)(16586007)(53416004)(2351001)(6666004)(50226002)(2906002)(8676002)(51416003)(86362001)(47776003)(106002)(1076003)(7416002)(246002)(305945005)(7636002)(356004)(54906003)(70206006)(70586007)(478600001)(6916009)(36756003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05158781-8d64-4092-9f77-08d6e2a2b630
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR03MB553;
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Antispam-PRVS: <BY2PR03MB553B1A3E39B4FA194630406F01D0@BY2PR03MB553.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8n7KSbTunAolb4ePbY8cEakNkcah7PFpra6ZNd0Y0EVLwSdEP/XvpLUcXPTtLlaWV4mQiRddt6Hw46wKAOeUz9y/rQYVqc5ybOJJUzgu8J2nZM1Px8bha0s+k+yUbZxvrrpGhOTA9gfWv12MM8QzQClc4Os8QbqCDHn3glNEI6gxyuUjHXWUrbV/AD5yldiKuZzx+phtBQkHZ/baQHS6QEWAFyWV45JA5PPdtbVpxiw+Tqq81eZSjRstQo4Cw4RlPHG6x7onB6N9dWjc2928oOaYu1Q1hxlZdPFW6MrAXrJEthR/Nejquq6wZ9MUYa6del3G5JMYktaaeccVovvuDF0huM0QwjSdz3wIzB5jMv1gJ4Yh+BSdG1uKGSF0B4HcKzIDdl8CRTL2KNHTJSp3FMEHvsKjnZG9z4JdLXnhDJg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 12:56:18.7732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05158781-8d64-4092-9f77-08d6e2a2b630
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The device dependent options which are going to be different for devices
which will be supported  in the future by this driver,
were moved in chip info for a more generic driver. This patch allows
supporting more devices by the driver. Also, it is an intermediate
step of adding support for ad7616 in software mode.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

 drivers/iio/adc/ad7606.c | 61 +++++++++++++++++++++++++++++-----------
 drivers/iio/adc/ad7606.h | 15 +++++++++-
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 24c70c3cefb4..c66ff22f32d2 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -158,7 +158,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = st->scale_avail[st->range];
+		*val2 = st->scale_avail[st->range[0]];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -194,6 +194,32 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
 
+static int ad7606_write_scale_hw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	gpiod_set_value(st->gpio_range, val);
+
+	return 0;
+}
+
+static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	DECLARE_BITMAP(values, 3);
+
+	values[0] = val;
+
+	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+			      st->gpio_os->info, values);
+
+	/* AD7616 requires a reset to update value */
+	if (st->chip_info->os_req_reset)
+		ad7606_reset(st);
+
+	return 0;
+}
+
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -201,15 +227,18 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	DECLARE_BITMAP(values, 3);
-	int i;
+	int i, ret, ch = 0;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&st->lock);
 		i = find_closest(val2, st->scale_avail, st->num_scales);
-		gpiod_set_value(st->gpio_range, i);
-		st->range = i;
+		ret = st->write_scale(indio_dev, chan->address, i);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		st->range[ch] = i;
 		mutex_unlock(&st->lock);
 
 		return 0;
@@ -218,17 +247,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
-
-		values[0] = i;
-
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
-				      st->gpio_os->info, values);
-
-		/* AD7616 requires a reset to update value */
-		if (st->chip_info->os_req_reset)
-			ad7606_reset(st);
-
+		ret = st->write_os(indio_dev, i);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
 		st->oversampling = st->oversampling_avail[i];
 		mutex_unlock(&st->lock);
 
@@ -536,7 +560,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->bops = bops;
 	st->base_address = base_address;
 	/* tied to logic low, analog input range is +/- 5V */
-	st->range = 0;
+	st->range[0] = 0;
 	st->oversampling = 1;
 	st->scale_avail = ad7606_scale_avail;
 	st->num_scales = ARRAY_SIZE(ad7606_scale_avail);
@@ -589,6 +613,9 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
+	st->write_scale = ad7606_write_scale_hw;
+	st->write_os = ad7606_write_os_hw;
+
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name, indio_dev->id);
 	if (!st->trig)
@@ -643,7 +670,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range);
+		gpiod_set_value(st->gpio_range, st->range[0]);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f9ef52131e74..143c30163df9 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -16,6 +16,12 @@
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
  * @os_req_reset	some devices require a reset to update oversampling
+ * @write_scale_sw	pointer to the function which writes the scale via spi
+			in software mode
+ * @write_os_sw		pointer to the function which writes the os via spi
+			in software mode
+ * @sw_mode_config:	pointer to a function which configured the device
+ *			for software mode
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
@@ -23,6 +29,9 @@ struct ad7606_chip_info {
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
+	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
+	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
+	int (*sw_mode_config)(struct iio_dev *indio_dev);
 };
 
 /**
@@ -39,6 +48,8 @@ struct ad7606_chip_info {
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @num_os_ratios	number of elements stored in oversampling_avail array
+ * @write_scale		pointer to the function which writes the scale
+ * @write_os		pointer to the function which writes the os
  * @lock		protect sensor state from concurrent accesses to GPIOs
  * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
  * @gpio_reset		GPIO descriptor for device hard-reset
@@ -57,13 +68,15 @@ struct ad7606_state {
 	const struct ad7606_chip_info	*chip_info;
 	struct regulator		*reg;
 	const struct ad7606_bus_ops	*bops;
-	unsigned int			range;
+	unsigned int			range[16];
 	unsigned int			oversampling;
 	void __iomem			*base_address;
 	const unsigned int		*scale_avail;
 	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
+	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
+	int (*write_os)(struct iio_dev *indio_dev, int val);
 
 	struct mutex			lock; /* protect sensor state */
 	struct gpio_desc		*gpio_convst;
-- 
2.17.1

