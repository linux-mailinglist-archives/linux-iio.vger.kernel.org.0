Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40622F4B3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbgG0QQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:16:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17120 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731302AbgG0QQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:37 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7qlO018995;
        Mon, 27 Jul 2020 12:16:35 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5eykq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:35 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGYDd045808
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 12:16:32 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 12:16:32 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShk009603;
        Mon, 27 Jul 2020 12:16:31 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 3/9] hwmon: pmbus: adm1266: Add support for GPIOs
Date:   Mon, 27 Jul 2020 19:18:08 +0300
Message-ID: <20200727161814.14076-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727161814.14076-1-alexandru.tachici@analog.com>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Adm1266 exposes 9 GPIOs and 16 PDIOs which are currently read-only. They
are controlled by the internal sequencing engine.

This patch makes adm1266 driver expose GPIOs and PDIOs to user-space
using GPIO provider kernel api.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 204 ++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 63975eba34ad..be911de02cf6 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -6,18 +6,42 @@
  * Copyright 2020 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/crc8.h>
+#include <linux/debugfs.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include "pmbus.h"
 #include <linux/slab.h>
 
+#define ADM1266_PDIO_CONFIG	0xD4
+#define ADM1266_GPIO_CONFIG	0xE1
+#define ADM1266_PDIO_STATUS	0xE9
+#define ADM1266_GPIO_STATUS	0xEA
+
+/* ADM1266 GPIO defines */
+#define ADM1266_GPIO_NR			9
+#define ADM1266_GPIO_FUNCTIONS(x)	FIELD_GET(BIT(0), x)
+#define ADM1266_GPIO_INPUT_EN(x)	FIELD_GET(BIT(2), x)
+#define ADM1266_GPIO_OUTPUT_EN(x)	FIELD_GET(BIT(3), x)
+#define ADM1266_GPIO_OPEN_DRAIN(x)	FIELD_GET(BIT(4), x)
+
+/* ADM1266 PDIO defines */
+#define ADM1266_PDIO_NR			16
+#define ADM1266_PDIO_PIN_CFG(x)		FIELD_GET(GENMASK(15, 13), x)
+#define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
+#define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
+
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
 struct adm1266_data {
 	struct pmbus_driver_info info;
+	struct gpio_chip gc;
+	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct mutex buf_mutex;
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
@@ -88,9 +112,185 @@ static int adm1266_pmbus_block_xfer(struct adm1266_data *data, u8 cmd, u8 w_len,
 	return ret;
 }
 
+static const unsigned int adm1266_gpio_mapping[ADM1266_GPIO_NR][2] = {
+	{1, 0},
+	{2, 1},
+	{3, 2},
+	{4, 8},
+	{5, 9},
+	{6, 10},
+	{7, 11},
+	{8, 6},
+	{9, 7},
+};
+
+static const char *adm1266_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR] = {
+	"GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6", "GPIO7", "GPIO8",
+	"GPIO9", "PDIO1", "PDIO2", "PDIO3", "PDIO4", "PDIO5", "PDIO6",
+	"PDIO7", "PDIO8", "PDIO9", "PDIO10", "PDIO11", "PDIO12", "PDIO13",
+	"PDIO14", "PDIO15", "PDIO16",
+};
+
+static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[I2C_SMBUS_BLOCK_MAX + 1];
+	unsigned long pins_status;
+	unsigned int pmbus_cmd;
+	int ret;
+
+	if (offset < ADM1266_GPIO_NR)
+		pmbus_cmd = ADM1266_GPIO_STATUS;
+	else
+		pmbus_cmd = ADM1266_PDIO_STATUS;
+
+	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
+	if (ret < 0)
+		return ret;
+
+	pins_status = read_buf[0] + (read_buf[1] << 8);
+	if (offset < ADM1266_GPIO_NR)
+		return test_bit(adm1266_gpio_mapping[offset][1], &pins_status);
+
+	return test_bit(offset - ADM1266_GPIO_NR, &pins_status);
+}
+
+static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				     unsigned long *bits)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
+	unsigned long status;
+	unsigned int gpio_nr;
+	int ret;
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
+	if (ret < 0)
+		return ret;
+
+	status = read_buf[0] + (read_buf[1] << 8);
+
+	*bits = 0;
+	for_each_set_bit(gpio_nr, mask, ADM1266_GPIO_NR) {
+		if (test_bit(adm1266_gpio_mapping[gpio_nr][1], &status))
+			set_bit(gpio_nr, bits);
+	}
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_PDIO_STATUS, read_buf);
+	if (ret < 0)
+		return ret;
+
+	status = read_buf[0] + (read_buf[1] << 8);
+
+	*bits = 0;
+	for_each_set_bit_from(gpio_nr, mask, ADM1266_GPIO_NR + ADM1266_PDIO_STATUS) {
+		if (test_bit(gpio_nr - ADM1266_GPIO_NR, &status))
+			set_bit(gpio_nr, bits);
+	}
+
+	return 0;
+}
+
+static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
+{
+	struct adm1266_data *data = gpiochip_get_data(chip);
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];
+	unsigned long gpio_config;
+	unsigned long pdio_config;
+	unsigned long pin_cfg;
+	u8 write_cmd;
+	int ret;
+	int i;
+
+	for (i = 0; i < ADM1266_GPIO_NR; i++) {
+		write_cmd = adm1266_gpio_mapping[i][1];
+		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
+		if (ret != 2)
+			return;
+
+		gpio_config = read_buf[0];
+		seq_puts(s, adm1266_names[i]);
+
+		seq_puts(s, " ( ");
+		if (!ADM1266_GPIO_FUNCTIONS(gpio_config)) {
+			seq_puts(s, "high-Z )\n");
+			continue;
+		}
+		if (ADM1266_GPIO_INPUT_EN(gpio_config))
+			seq_puts(s, "input ");
+		if (ADM1266_GPIO_OUTPUT_EN(gpio_config))
+			seq_puts(s, "output ");
+		if (ADM1266_GPIO_OPEN_DRAIN(gpio_config))
+			seq_puts(s, "open-drain )\n");
+		else
+			seq_puts(s, "push-pull )\n");
+	}
+
+	write_cmd = 0xFF;
+	ret = adm1266_pmbus_block_xfer(data, ADM1266_PDIO_CONFIG, 1, &write_cmd, read_buf);
+	if (ret != 32)
+		return;
+
+	for (i = 0; i < ADM1266_PDIO_NR; i++) {
+		seq_puts(s, adm1266_names[ADM1266_GPIO_NR + i]);
+
+		pdio_config = read_buf[2 * i];
+		pdio_config += (read_buf[2 * i + 1] << 8);
+		pin_cfg = ADM1266_PDIO_PIN_CFG(pdio_config);
+
+		seq_puts(s, " ( ");
+		if (!pin_cfg || pin_cfg > 5) {
+			seq_puts(s, "high-Z )\n");
+			continue;
+		}
+
+		if (pin_cfg & BIT(0))
+			seq_puts(s, "output ");
+
+		if (pin_cfg & BIT(1))
+			seq_puts(s, "input ");
+
+		seq_puts(s, ")\n");
+	}
+}
+
+static int adm1266_config_gpio(struct adm1266_data *data)
+{
+	const char *name = dev_name(&data->client->dev);
+	char *gpio_name;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(data->gpio_names); i++) {
+		gpio_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "adm1266-%x-%s",
+					   data->client->addr, adm1266_names[i]);
+		if (!gpio_name)
+			return -ENOMEM;
+
+		data->gpio_names[i] = gpio_name;
+	}
+
+	data->gc.label = name;
+	data->gc.parent = &data->client->dev;
+	data->gc.owner = THIS_MODULE;
+	data->gc.base = -1;
+	data->gc.names = data->gpio_names;
+	data->gc.ngpio = ARRAY_SIZE(data->gpio_names);
+	data->gc.get = adm1266_gpio_get;
+	data->gc.get_multiple = adm1266_gpio_get_multiple;
+	data->gc.dbg_show = adm1266_gpio_dbg_show;
+
+	ret = devm_gpiochip_add_data(&data->client->dev, &data->gc, data);
+	if (ret)
+		dev_err(&data->client->dev, "GPIO registering failed (%d)\n", ret);
+
+	return ret;
+}
+
 static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct adm1266_data *data;
+	int ret;
 	int i;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data), GFP_KERNEL);
@@ -106,6 +306,10 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 	mutex_init(&data->buf_mutex);
 
+	ret = adm1266_config_gpio(data);
+	if (ret < 0)
+		return ret;
+
 	return pmbus_do_probe(client, id, &data->info);
 }
 
-- 
2.20.1

