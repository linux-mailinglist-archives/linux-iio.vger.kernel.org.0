Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1453E32E2C6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 08:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCEHFr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 02:05:47 -0500
Received: from mail-eopbgr130097.outbound.protection.outlook.com ([40.107.13.97]:60142
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhCEHFr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Mar 2021 02:05:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhsyyayPcUgQNvgSwbQ8xC9GdrBi+Bcykg0WNOgfPm6ipTapchh03AYx3gPT8gfN+JprsDlvf5DCEZFeuQ/+k9+qIY/6rnV3xojJDzc2JVWSKKVr0rkaWkZPbQ2TsxzafGVse7A3R9viHoGCSXvK39+INSfAE85cFqcmvXIw99iA3ykP6byDVEFDvOjOOso2CJJ+3ChZ02LuTVts2JzzhIfHzu5/igRBeXALq70dN5E6r+7eO+Jif9VCBdK2m/nTLublTmCrjayYGzENbEEZi1mCOceh6Q+/1tdp/GsuvdJDbYbKQ3UNj9NBqrec3pU5ltvj6sukZJ+DX/BLF4Swbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0G1VvOdMwaqDJaSg8BOLS6k86tMxx4SZ7lVTkDDQHQ=;
 b=QsGOYurT+dj/KcQXbq288O4gMXEg2bMCWxL8fDyLogPo8S1ZeAOxYwHWIkYJ1jPNAh6x58p406ov2c5WCOwzdp1a3X/vqAiDV9JAY4iS/x7wcyDLvz9CYYzjgQuroZkDlAtySvTgn4rdtxvHw1OY4/mWumXLvZ8JnyJUVBU+vmytMkMBK02SUWQ7677dCwprKDqxzFvekSthUPCLYisJZXzkymwO47R7XEegLr3+MA+yuw8YsSfwwU73pPIrEREiggpc1uU9FA1YkUaztm8YuMFgzrWnWbmZdkPUF36bEYRKIjXNL9pelKoe2iD9NhCaeSWnVAwYvqBZW6jtsh+mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0G1VvOdMwaqDJaSg8BOLS6k86tMxx4SZ7lVTkDDQHQ=;
 b=EjMCsCOdvEzFFkUehPhBSrpqAnWiqoRdZ1o/6KsKvwi2UGouyeG5aCoZJlX1WmTB2EMQP0/vXptn75aJi52tpWSk+GG6oDEF+EGO9VJSTRZIiKs+UTn8uTbdCsK/EtXI9TwnQl6XIjP/r5/4juu3a4a8+zjhg06Cv2pdYK4JvUc=
Received: from AS8PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:20b:127::18)
 by VI1PR06MB6637.eurprd06.prod.outlook.com (2603:10a6:800:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Fri, 5 Mar
 2021 07:05:43 +0000
Received: from HE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::64) by AS8PR04CA0133.outlook.office365.com
 (2603:10a6:20b:127::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 07:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT025.mail.protection.outlook.com (10.152.10.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 07:05:42 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH 2/2] iio:magnetometer: Support for ST magnetic sensors
Date:   Fri,  5 Mar 2021 07:05:36 +0000
Message-Id: <20210305070536.2880-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29300469-4f7d-41b7-362c-08d8dfa51794
X-MS-TrafficTypeDiagnostic: VI1PR06MB6637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB66378C53959817814BFA5CCED7969@VI1PR06MB6637.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8wa/B1iIyTuiMqMHmq+bN3pY0N/RL9tZQ4RnuEbJzqpC2/0Wci/ZNdi9Pmlwdwj0fbCEajMLooMAFzg+Zx8KYmGKFYW2x7Pwf+xcdvBGwJc+GYgi7X9zwhN56W2YDS5Xp0FxCJJbA9CCRjQkW7UqyAKrtk1c9J0TY0cPtVHOfsPh3n4O0AQQgqn5ncMIyV8nr4quQ6/8gYeMlwY6y6+kSRy+p6D+qctqUGfI4q/WAjO88IgE0L0oWGZ0nHc53ibo2DLzekIbL80gddxwqq+72jJEm8wDnAe6J5cj9ETW+opEsGK6nuHZshywlkuDoW3f+9HbcuHeRtjQbxMhTnrlKqVF3bnJ1/k03JydZm5ctwUP8TkokpthcJIT4ASfvcDspemXl3l1AVmMt3CZed7ZDXhOsUlkmkiihgOtaOha6rZtuB/G0cpK/ae3iEhVLIVRiaHTHLbPrwF+9OYRv6MgDCor+wcmjpHNNlM2BV+o726D/rjJuNByIyBKbsBphI8s9wDdcKTfEoXwY9QvPVDlAZrS6qQ5OQKoMYWFknvUGkg8VswYUop/X/y/Q5h7VPVJhQrblFMP2RmYsi0PKLQ7lHHMhD0vJoxsoS61uAlqL57dItZo0FDndAE3qjsY5CDsUkdEvv4vrU9JBEvDPeWJobzP9DUhRsHaNYjL7m8+WVeP1fa+57/eI+bzB93ZNKG
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(36840700001)(46966006)(47076005)(2906002)(6512007)(4326008)(86362001)(316002)(36736006)(956004)(118246002)(5660300002)(1076003)(6506007)(336012)(82310400003)(70206006)(70586007)(6486002)(34020700004)(26005)(82740400003)(83380400001)(81166007)(356005)(8936002)(2616005)(6666004)(478600001)(36860700001)(186003)(30864003)(36756003)(107886003)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 07:05:42.6224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29300469-4f7d-41b7-362c-08d8dfa51794
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6637
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for STMicroelectronics digital magnetic sensors,
LSM303AH,LSM303AGR,LIS2MDL,ISM303DAC,IIS2MDC.

The patch tested with IIS2MDC instrument.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/magnetometer/Kconfig           |  23 ++
 drivers/iio/magnetometer/Makefile          |   4 +
 drivers/iio/magnetometer/st_mag40_buffer.c | 191 +++++++++++
 drivers/iio/magnetometer/st_mag40_core.c   | 371 +++++++++++++++++++++
 drivers/iio/magnetometer/st_mag40_core.h   | 136 ++++++++
 drivers/iio/magnetometer/st_mag40_i2c.c    | 180 ++++++++++
 drivers/iio/magnetometer/st_mag40_spi.c    | 188 +++++++++++
 7 files changed, 1093 insertions(+)
 create mode 100644 drivers/iio/magnetometer/st_mag40_buffer.c
 create mode 100644 drivers/iio/magnetometer/st_mag40_core.c
 create mode 100644 drivers/iio/magnetometer/st_mag40_core.h
 create mode 100644 drivers/iio/magnetometer/st_mag40_i2c.c
 create mode 100644 drivers/iio/magnetometer/st_mag40_spi.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 1697a8c03506..bfd2866faa99 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -205,4 +205,27 @@ config SENSORS_RM3100_SPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called rm3100-spi.
 
+config ST_MAG40_IIO
+	tristate "STMicroelectronics LIS2MDL/LSM303AH/LSM303AGR/ISM303DAC/IIS2MDC sensor"
+	depends on (I2C || SPI) && SYSFS
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select ST_MAG40_I2C_IIO if (I2C)
+	select ST_MAG40_SPI_IIO if (SPI)
+	help
+	  Say yes here to build support for STMicroelectronics magnetometers:
+	  LIS2MDL, LSM303AH, LSM303AGR, ISM303DAC, IIS2MDC.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called st_mag40.
+
+config ST_MAG40_I2C_IIO
+	tristate
+	depends on ST_MAG40_IIO
+	depends on I2C
+
+config ST_MAG40_SPI_IIO
+	tristate
+	depends on ST_MAG40_IIO
+	depends on SPI
 endmenu
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index ba1bc34b82fa..b6b427cfc284 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -25,6 +25,10 @@ obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
 obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
 obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
 
+st_mag40-y += st_mag40_buffer.o st_mag40_core.o
+obj-$(CONFIG_ST_MAG40_IIO) += st_mag40.o
+obj-$(CONFIG_ST_MAG40_I2C_IIO) += st_mag40_i2c.o
+obj-$(CONFIG_ST_MAG40_SPI_IIO) += st_mag40_spi.o
 obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
diff --git a/drivers/iio/magnetometer/st_mag40_buffer.c b/drivers/iio/magnetometer/st_mag40_buffer.c
new file mode 100644
index 000000000000..d2a67c9dae5e
--- /dev/null
+++ b/drivers/iio/magnetometer/st_mag40_buffer.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STMicroelectronics st_mag40 driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Matteo Dameno <matteo.dameno@st.com>
+ * Armando Visconti <armando.visconti@st.com>
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "st_mag40_core.h"
+
+#define ST_MAG40_EWMA_DIV			128
+static inline s64 st_mag40_ewma(s64 old, s64 new, int weight)
+{
+	s64 diff, incr;
+
+	diff = new - old;
+	incr = div_s64((ST_MAG40_EWMA_DIV - weight) * diff,
+			ST_MAG40_EWMA_DIV);
+
+	return old + incr;
+}
+
+static irqreturn_t st_mag40_trigger_irq_handler(int irq, void *private)
+{
+	struct st_mag40_data *cdata = private;
+	s64 ts;
+	u8 weight = (cdata->odr >= 50) ? 96 : 0;
+
+	ts = st_mag40_get_timestamp();
+	cdata->delta_ts = st_mag40_ewma(cdata->delta_ts, ts - cdata->ts_irq, weight);
+	cdata->ts_irq = ts;
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t st_mag40_trigger_thread_handler(int irq, void *private)
+{
+	struct st_mag40_data *cdata = private;
+	u8 status;
+	int err;
+
+	err = cdata->tf->read(cdata, ST_MAG40_STATUS_ADDR,
+			      sizeof(status), &status);
+	if (err < 0)
+		return IRQ_HANDLED;
+
+	if (!(status & ST_MAG40_AVL_DATA_MASK))
+		return IRQ_NONE;
+
+	iio_trigger_poll_chained(cdata->iio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t st_mag40_buffer_thread_handler(int irq, void *p)
+{
+	u8 buffer[ALIGN(ST_MAG40_OUT_LEN, sizeof(s64)) + sizeof(s64)];
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio_dev = pf->indio_dev;
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+	int err;
+
+	err = cdata->tf->read(cdata, ST_MAG40_OUTX_L_ADDR,
+			      ST_MAG40_OUT_LEN, buffer);
+	if (err < 0)
+		goto out;
+
+	/* discard samples generated during the turn-on time */
+	if (cdata->samples_to_discard > 0) {
+		cdata->samples_to_discard--;
+		goto out;
+	}
+
+	iio_push_to_buffers_with_timestamp(iio_dev, buffer, cdata->ts);
+	cdata->ts += cdata->delta_ts;
+
+out:
+	iio_trigger_notify_done(cdata->iio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int st_mag40_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct st_mag40_data *cdata = iio_priv(indio_dev);
+
+	return st_mag40_set_enable(cdata, true);
+}
+
+static int st_mag40_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct st_mag40_data *cdata = iio_priv(indio_dev);
+	int err;
+
+	err = st_mag40_set_enable(cdata, false);
+
+	return err < 0 ? err : 0;
+}
+
+static const struct iio_buffer_setup_ops st_mag40_buffer_setup_ops = {
+	.preenable = st_mag40_buffer_preenable,
+	.postenable = iio_triggered_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+	.postdisable = st_mag40_buffer_postdisable,
+};
+
+int st_mag40_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct st_mag40_data *cdata = iio_priv(iio_trigger_get_drvdata(trig));
+	int err;
+
+	err = st_mag40_write_register(cdata, ST_MAG40_INT_DRDY_ADDR,
+				      ST_MAG40_INT_DRDY_MASK, state);
+
+	return err < 0 ? err : 0;
+}
+
+int st_mag40_allocate_ring(struct iio_dev *iio_dev)
+{
+	return  iio_triggered_buffer_setup(iio_dev, NULL,
+					   st_mag40_buffer_thread_handler,
+					   &st_mag40_buffer_setup_ops);
+}
+
+void st_mag40_deallocate_ring(struct iio_dev *iio_dev)
+{
+	iio_triggered_buffer_cleanup(iio_dev);
+}
+
+static const struct iio_trigger_ops st_mag40_trigger_ops = {
+	.set_trigger_state = st_mag40_trig_set_state,
+};
+
+int st_mag40_allocate_trigger(struct iio_dev *iio_dev)
+{
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+	int err;
+
+	err = devm_request_threaded_irq(cdata->dev, cdata->irq,
+					st_mag40_trigger_irq_handler,
+					st_mag40_trigger_thread_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					cdata->name, cdata);
+	if (err)
+		return err;
+
+	cdata->iio_trig = devm_iio_trigger_alloc(cdata->dev, "%s-trigger",
+						 iio_dev->name);
+	if (!cdata->iio_trig) {
+		dev_err(cdata->dev, "failed to allocate iio trigger.\n");
+		return -ENOMEM;
+	}
+	iio_trigger_set_drvdata(cdata->iio_trig, iio_dev);
+	cdata->iio_trig->ops = &st_mag40_trigger_ops;
+	cdata->iio_trig->dev.parent = cdata->dev;
+
+	err = iio_trigger_register(cdata->iio_trig);
+	if (err < 0) {
+		dev_err(cdata->dev, "failed to register iio trigger.\n");
+		return err;
+	}
+	iio_dev->trig = cdata->iio_trig;
+
+	return 0;
+}
+
+void st_mag40_deallocate_trigger(struct st_mag40_data *cdata)
+{
+	iio_trigger_unregister(cdata->iio_trig);
+}
+
+MODULE_DESCRIPTION("STMicroelectronics st_mag40 driver");
+MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_mag40_core.c b/drivers/iio/magnetometer/st_mag40_core.c
new file mode 100644
index 000000000000..3c5f2d91897b
--- /dev/null
+++ b/drivers/iio/magnetometer/st_mag40_core.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STMicroelectronics st_mag40 driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Matteo Dameno <matteo.dameno@st.com>
+ * Armando Visconti <armando.visconti@st.com>
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/delay.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <asm/unaligned.h>
+
+#include "st_mag40_core.h"
+
+struct st_mag40_odr_reg {
+	u32 hz;
+	u8 value;
+};
+
+#define ST_MAG40_ODR_TABLE_SIZE		4
+static const struct st_mag40_odr_table_t {
+	u8 addr;
+	u8 mask;
+	struct st_mag40_odr_reg odr_avl[ST_MAG40_ODR_TABLE_SIZE];
+} st_mag40_odr_table = {
+	.addr = ST_MAG40_ODR_ADDR,
+	.mask = ST_MAG40_ODR_MASK,
+	.odr_avl[0] = { .hz = 10, .value = ST_MAG40_CFG_REG_A_ODR_10Hz, },
+	.odr_avl[1] = { .hz = 20, .value = ST_MAG40_CFG_REG_A_ODR_20Hz, },
+	.odr_avl[2] = { .hz = 50, .value = ST_MAG40_CFG_REG_A_ODR_50Hz, },
+	.odr_avl[3] = { .hz = 100, .value = ST_MAG40_CFG_REG_A_ODR_100Hz, },
+};
+
+#define ST_MAG40_ADD_CHANNEL(device_type, modif, index, mod,	\
+				endian, sbits, rbits, addr, s)	\
+{								\
+	.type = device_type,					\
+	.modified = modif,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_index = index,					\
+	.channel2 = mod,					\
+	.address = addr,					\
+	.scan_type = {						\
+		.sign = s,					\
+		.realbits = rbits,				\
+		.shift = sbits - rbits,				\
+		.storagebits = sbits,				\
+		.endianness = endian,				\
+	},							\
+}
+
+static const struct iio_chan_spec st_mag40_channels[] = {
+	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 0, IIO_MOD_X, IIO_LE, 16, 16,
+				ST_MAG40_OUTX_L_ADDR, 's'),
+	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 1, IIO_MOD_Y, IIO_LE, 16, 16,
+				ST_MAG40_OUTY_L_ADDR, 's'),
+	ST_MAG40_ADD_CHANNEL(IIO_MAGN, 1, 2, IIO_MOD_Z, IIO_LE, 16, 16,
+				ST_MAG40_OUTZ_L_ADDR, 's'),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+int st_mag40_write_register(struct st_mag40_data *cdata, u8 reg_addr,
+			    u8 mask, u8 data)
+{
+	int err;
+	u8 val;
+
+	mutex_lock(&cdata->lock);
+
+	err = cdata->tf->read(cdata, reg_addr, sizeof(val), &val);
+	if (err < 0)
+		goto unlock;
+
+	val = ((val & ~mask) | ((data << __ffs(mask)) & mask));
+
+	err = cdata->tf->write(cdata, reg_addr, sizeof(val), &val);
+
+unlock:
+	mutex_unlock(&cdata->lock);
+
+	return err < 0 ? err : 0;
+}
+
+static int st_mag40_write_odr(struct st_mag40_data *cdata, uint32_t odr)
+{
+	int err, i;
+
+	for (i = 0; i < ST_MAG40_ODR_TABLE_SIZE; i++)
+		if (st_mag40_odr_table.odr_avl[i].hz >= odr)
+			break;
+
+	if (i == ST_MAG40_ODR_TABLE_SIZE)
+		return -EINVAL;
+
+	err = st_mag40_write_register(cdata, st_mag40_odr_table.addr,
+				      st_mag40_odr_table.mask,
+				      st_mag40_odr_table.odr_avl[i].value);
+	if (err < 0)
+		return err;
+
+	cdata->odr = odr;
+	cdata->samples_to_discard = ST_MAG40_TURNON_TIME_SAMPLES_NUM;
+
+	return 0;
+}
+
+int st_mag40_set_enable(struct st_mag40_data *cdata, bool state)
+{
+	u8 mode;
+
+	mode = state ? ST_MAG40_CFG_REG_A_MD_CONT : ST_MAG40_CFG_REG_A_MD_IDLE;
+
+	if (state) {
+		cdata->ts = cdata->ts_irq = st_mag40_get_timestamp();
+		cdata->delta_ts = div_s64(1000000000LL, cdata->odr);
+	}
+
+	return st_mag40_write_register(cdata, ST_MAG40_EN_ADDR,
+				       ST_MAG40_EN_MASK, mode);
+}
+
+int st_mag40_init_sensors(struct st_mag40_data *cdata)
+{
+	int err;
+
+	/*
+	 * Enable block data update feature.
+	 */
+	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_C_ADDR,
+				      ST_MAG40_CFG_REG_C_BDU_MASK, 1);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Enable the temperature compensation feature
+	 */
+	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_A_ADDR,
+				      ST_MAG40_TEMP_COMP_EN, 1);
+	if (err < 0)
+		return err;
+
+	err = st_mag40_write_register(cdata, ST_MAG40_CFG_REG_B_ADDR,
+				      ST_MAG40_CFG_REG_B_OFF_CANC_MASK, 1);
+
+	return err < 0 ? err : 0;
+}
+
+static ssize_t st_mag40_get_sampling_frequency(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct st_mag40_data *cdata = iio_priv(dev_get_drvdata(dev));
+
+	return sprintf(buf, "%d\n", cdata->odr);
+}
+
+static ssize_t st_mag40_set_sampling_frequency(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+	unsigned int odr;
+	int err;
+
+	err = kstrtoint(buf, 10, &odr);
+	if (err < 0)
+		return err;
+
+	err = st_mag40_write_odr(cdata, odr);
+
+	return err < 0 ? err : count;
+}
+
+static ssize_t
+st_mag40_get_sampling_frequency_avail(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ST_MAG40_ODR_TABLE_SIZE; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 st_mag40_odr_table.odr_avl[i].hz);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int st_mag40_read_oneshot(struct st_mag40_data *cdata,
+				 u8 addr, int *val)
+{
+	u8 data[2];
+	int err;
+
+	err = st_mag40_set_enable(cdata, true);
+	if (err < 0)
+		return err;
+
+	msleep(40);
+
+	err = cdata->tf->read(cdata, addr, sizeof(data), data);
+	if (err < 0)
+		return err;
+
+	*val = (s16)get_unaligned_le16(data);
+
+	err = st_mag40_set_enable(cdata, false);
+
+	return err < 0 ? err : IIO_VAL_INT;
+}
+
+static int st_mag40_read_raw(struct iio_dev *iio_dev,
+			     struct iio_chan_spec const *ch,
+			     int *val, int *val2, long mask)
+{
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+	int ret;
+
+	mutex_lock(&iio_dev->mlock);
+
+	if (iio_buffer_enabled(iio_dev)) {
+		mutex_unlock(&iio_dev->mlock);
+		return -EBUSY;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = st_mag40_read_oneshot(cdata, ch->address, val);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 1500;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&iio_dev->mlock);
+
+	return ret;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(0444,
+			      st_mag40_get_sampling_frequency,
+			      st_mag40_set_sampling_frequency);
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_mag40_get_sampling_frequency_avail);
+
+static struct attribute *st_mag40_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group st_mag40_attribute_group = {
+	.attrs = st_mag40_attributes,
+};
+
+static const struct iio_info st_mag40_info = {
+	.attrs = &st_mag40_attribute_group,
+	.read_raw = &st_mag40_read_raw,
+};
+
+int st_mag40_common_probe(struct iio_dev *iio_dev)
+{
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+	int32_t err;
+	u8 wai;
+
+	mutex_init(&cdata->lock);
+
+	err = cdata->tf->read(cdata, ST_MAG40_WHO_AM_I_ADDR,
+			      sizeof(wai), &wai);
+	if (err < 0) {
+		dev_err(cdata->dev, "failed to read Who-Am-I register.\n");
+
+		return err;
+	}
+
+	if (wai != ST_MAG40_WHO_AM_I_DEF) {
+		dev_err(cdata->dev, "Who-Am-I value not valid. (%02x)\n", wai);
+		return -ENODEV;
+	}
+
+	cdata->odr = st_mag40_odr_table.odr_avl[0].hz;
+
+	iio_dev->channels = st_mag40_channels;
+	iio_dev->num_channels = ARRAY_SIZE(st_mag40_channels);
+	iio_dev->info = &st_mag40_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	err = st_mag40_init_sensors(cdata);
+	if (err < 0)
+		return err;
+
+	if (cdata->irq > 0) {
+		err = st_mag40_allocate_ring(iio_dev);
+		if (err < 0)
+			return err;
+
+		err = st_mag40_allocate_trigger(iio_dev);
+		if (err < 0)
+			goto deallocate_ring;
+	}
+
+	err = devm_iio_device_register(cdata->dev, iio_dev);
+	if (err)
+		goto iio_trigger_deallocate;
+
+	return 0;
+
+iio_trigger_deallocate:
+	st_mag40_deallocate_trigger(cdata);
+
+deallocate_ring:
+	st_mag40_deallocate_ring(iio_dev);
+
+	return err;
+}
+EXPORT_SYMBOL(st_mag40_common_probe);
+
+void st_mag40_common_remove(struct iio_dev *iio_dev)
+{
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+
+	if (cdata->irq > 0) {
+		st_mag40_deallocate_trigger(cdata);
+		st_mag40_deallocate_ring(iio_dev);
+	}
+}
+EXPORT_SYMBOL(st_mag40_common_remove);
+
+#ifdef CONFIG_PM
+int st_mag40_common_suspend(struct st_mag40_data *cdata)
+{
+	return 0;
+}
+EXPORT_SYMBOL(st_mag40_common_suspend);
+
+int st_mag40_common_resume(struct st_mag40_data *cdata)
+{
+	return 0;
+}
+EXPORT_SYMBOL(st_mag40_common_resume);
+#endif /* CONFIG_PM */
+
+MODULE_DESCRIPTION("STMicroelectronics st_mag40 driver");
+MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_mag40_core.h b/drivers/iio/magnetometer/st_mag40_core.h
new file mode 100644
index 000000000000..cc8e9cbf00ce
--- /dev/null
+++ b/drivers/iio/magnetometer/st_mag40_core.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * STMicroelectronics st_mag40 driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Matteo Dameno <matteo.dameno@st.com>
+ * Armando Visconti <armando.visconti@st.com>
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ */
+
+#ifndef __ST_MAG40_H
+#define __ST_MAG40_H
+
+#include <linux/types.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#define ST_MAG40_DEV_NAME			"st_mag40"
+#define LIS2MDL_DEV_NAME			"lis2mdl_magn"
+#define LSM303AH_DEV_NAME			"lsm303ah_magn"
+#define LSM303AGR_DEV_NAME			"lsm303agr_magn"
+#define ISM303DAC_DEV_NAME			"ism303dac_magn"
+#define IIS2MDC_DEV_NAME			"iis2mdc_magn"
+
+/* Power Modes */
+enum {
+	ST_MAG40_LWC_MODE = 0,
+	ST_MAG40_NORMAL_MODE,
+	ST_MAG40_MODE_COUNT,
+};
+
+#define ST_MAG40_WHO_AM_I_ADDR				0x4f
+#define ST_MAG40_WHO_AM_I_DEF				0x40
+
+/* Magnetometer control registers */
+#define ST_MAG40_CFG_REG_A_ADDR				0x60
+#define ST_MAG40_TEMP_COMP_EN				0x80
+#define ST_MAG40_CFG_REG_A_ODR_MASK			0x0c
+#define ST_MAG40_CFG_REG_A_ODR_10Hz			0x00
+#define ST_MAG40_CFG_REG_A_ODR_20Hz			0x01
+#define ST_MAG40_CFG_REG_A_ODR_50Hz			0x02
+#define ST_MAG40_CFG_REG_A_ODR_100Hz			0x03
+#define ST_MAG40_CFG_REG_A_ODR_COUNT			4
+#define ST_MAG40_CFG_REG_A_MD_MASK			0x03
+#define ST_MAG40_CFG_REG_A_MD_CONT			0x00
+#define ST_MAG40_CFG_REG_A_MD_IDLE			0x03
+
+#define ST_MAG40_ODR_ADDR				ST_MAG40_CFG_REG_A_ADDR
+#define ST_MAG40_ODR_MASK				ST_MAG40_CFG_REG_A_ODR_MASK
+
+#define ST_MAG40_EN_ADDR				ST_MAG40_CFG_REG_A_ADDR
+#define ST_MAG40_EN_MASK				ST_MAG40_CFG_REG_A_MD_MASK
+
+#define ST_MAG40_CFG_REG_B_ADDR				0x61
+#define ST_MAG40_CFG_REG_B_OFF_CANC_MASK		0x02
+
+#define ST_MAG40_CFG_REG_C_ADDR				0x62
+#define ST_MAG40_CFG_REG_C_BDU_MASK			0x10
+#define ST_MAG40_CFG_REG_C_INT_MASK			0x01
+
+#define ST_MAG40_INT_DRDY_ADDR				ST_MAG40_CFG_REG_C_ADDR
+#define ST_MAG40_INT_DRDY_MASK				ST_MAG40_CFG_REG_C_INT_MASK
+
+#define ST_MAG40_STATUS_ADDR				0x67
+#define ST_MAG40_AVL_DATA_MASK				0x7
+
+/* Magnetometer output registers */
+#define ST_MAG40_OUTX_L_ADDR				0x68
+#define ST_MAG40_OUTY_L_ADDR				0x6A
+#define ST_MAG40_OUTZ_L_ADDR				0x6C
+
+#define ST_MAG40_BDU_ADDR				ST_MAG40_CTRL1_ADDR
+#define ST_MAG40_BDU_MASK				0x02
+
+#define ST_MAG40_TURNON_TIME_SAMPLES_NUM	2
+
+/* 3 axis of 16 bit each */
+#define ST_MAG40_OUT_LEN				6
+
+#define ST_MAG40_TX_MAX_LENGTH				16
+#define ST_MAG40_RX_MAX_LENGTH				16
+
+struct st_mag40_transfer_buffer {
+	u8 rx_buf[ST_MAG40_RX_MAX_LENGTH];
+	u8 tx_buf[ST_MAG40_TX_MAX_LENGTH] ____cacheline_aligned;
+};
+
+struct st_mag40_data;
+
+struct st_mag40_transfer_function {
+	int (*write)(struct st_mag40_data *cdata, u8 reg_addr, int len, u8 *data);
+	int (*read)(struct st_mag40_data *cdata, u8 reg_addr, int len, u8 *data);
+};
+
+struct st_mag40_data {
+	const char *name;
+	struct mutex lock;
+	u8 drdy_int_pin;
+	int irq;
+	s64 ts;
+	s64 ts_irq;
+	s64 delta_ts;
+
+	u16 odr;
+	u8 samples_to_discard;
+
+	struct device *dev;
+	struct iio_trigger *iio_trig;
+	const struct st_mag40_transfer_function *tf;
+	struct st_mag40_transfer_buffer tb;
+};
+
+static inline s64 st_mag40_get_timestamp(void)
+{
+	return ktime_get_boottime_ns();
+}
+
+int st_mag40_common_probe(struct iio_dev *iio_dev);
+void st_mag40_common_remove(struct iio_dev *iio_dev);
+
+#ifdef CONFIG_PM
+int st_mag40_common_suspend(struct st_mag40_data *cdata);
+int st_mag40_common_resume(struct st_mag40_data *cdata);
+#endif /* CONFIG_PM */
+
+int st_mag40_allocate_ring(struct iio_dev *iio_dev);
+int st_mag40_allocate_trigger(struct iio_dev *iio_dev);
+int st_mag40_trig_set_state(struct iio_trigger *trig, bool state);
+int st_mag40_set_enable(struct st_mag40_data *cdata, bool enable);
+void st_mag40_deallocate_ring(struct iio_dev *iio_dev);
+void st_mag40_deallocate_trigger(struct st_mag40_data *cdata);
+int st_mag40_write_register(struct st_mag40_data *cdata, u8 reg_addr, u8 mask, u8 data);
+
+#endif /* __ST_MAG40_H */
diff --git a/drivers/iio/magnetometer/st_mag40_i2c.c b/drivers/iio/magnetometer/st_mag40_i2c.c
new file mode 100644
index 000000000000..8980972ad65e
--- /dev/null
+++ b/drivers/iio/magnetometer/st_mag40_i2c.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STMicroelectronics st_mag40 driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Armando Visconti <armando.visconti@st.com>
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/types.h>
+
+#include "st_mag40_core.h"
+
+#define I2C_AUTO_INCREMENT	0x80
+
+static int st_mag40_i2c_read(struct st_mag40_data *cdata, u8 reg_addr,
+			     int len, u8 *data)
+{
+	struct i2c_client *client = to_i2c_client(cdata->dev);
+	struct i2c_msg msg[2];
+
+	if (len > 1)
+		reg_addr |= I2C_AUTO_INCREMENT;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags;
+	msg[0].len = 1;
+	msg[0].buf = &reg_addr;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = len;
+	msg[1].buf = data;
+
+	return i2c_transfer(client->adapter, msg, 2);
+}
+
+static int st_mag40_i2c_write(struct st_mag40_data *cdata, u8 reg_addr,
+			      int len, u8 *data)
+{
+	struct i2c_client *client = to_i2c_client(cdata->dev);
+	struct i2c_msg msg;
+	u8 send[len + 1];
+
+	send[0] = reg_addr;
+	memcpy(&send[1], data, len * sizeof(u8));
+	len++;
+
+	msg.addr = client->addr;
+	msg.flags = client->flags;
+	msg.len = len;
+	msg.buf = send;
+
+	return i2c_transfer(client->adapter, &msg, 1);
+}
+
+static const struct st_mag40_transfer_function st_mag40_tf_i2c = {
+	.write = st_mag40_i2c_write,
+	.read = st_mag40_i2c_read,
+};
+
+static int st_mag40_i2c_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
+{
+	struct st_mag40_data *cdata;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cdata));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iio_dev);
+	iio_dev->dev.parent = &client->dev;
+	iio_dev->name = client->name;
+
+	cdata = iio_priv(iio_dev);
+	cdata->dev = &client->dev;
+	cdata->name = client->name;
+	cdata->tf = &st_mag40_tf_i2c;
+	cdata->irq = client->irq;
+
+	return st_mag40_common_probe(iio_dev);
+}
+
+static int st_mag40_i2c_remove(struct i2c_client *client)
+{
+	struct iio_dev *iio_dev = i2c_get_clientdata(client);
+
+	st_mag40_common_remove(iio_dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int st_mag40_i2c_suspend(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+
+	return st_mag40_common_suspend(cdata);
+}
+
+static int st_mag40_i2c_resume(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+
+	return st_mag40_common_resume(cdata);
+}
+
+static const struct dev_pm_ops st_mag40_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(st_mag40_i2c_suspend, st_mag40_i2c_resume)
+};
+#endif /* CONFIG_PM */
+
+static const struct i2c_device_id st_mag40_ids[] = {
+	{ LSM303AH_DEV_NAME, 0 },
+	{ LSM303AGR_DEV_NAME, 0 },
+	{ LIS2MDL_DEV_NAME, 0 },
+	{ ISM303DAC_DEV_NAME, 0 },
+	{ IIS2MDC_DEV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, st_mag40_ids);
+
+#ifdef CONFIG_OF
+static const struct of_device_id st_mag40_id_table[] = {
+	{
+		.compatible = "st,lsm303ah_magn",
+		.data = LSM303AH_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303agr_magn",
+		.data = LSM303AGR_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis2mdl_magn",
+		.data = LSM303AGR_DEV_NAME,
+	},
+	{
+		.compatible = "st,ism303dac_magn",
+		.data = ISM303DAC_DEV_NAME,
+	},
+	{
+		.compatible = "st,iis2mdc_magn",
+		.data = IIS2MDC_DEV_NAME,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, st_mag40_id_table);
+#endif /* CONFIG_OF */
+
+static struct i2c_driver st_mag40_i2c_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = ST_MAG40_DEV_NAME,
+#ifdef CONFIG_PM
+		   .pm = &st_mag40_i2c_pm_ops,
+#endif
+#ifdef CONFIG_OF
+		   .of_match_table = st_mag40_id_table,
+#endif /* CONFIG_OF */
+		   },
+	.probe = st_mag40_i2c_probe,
+	.remove = st_mag40_i2c_remove,
+	.id_table = st_mag40_ids,
+};
+module_i2c_driver(st_mag40_i2c_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics st_mag40 i2c driver");
+MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_mag40_spi.c b/drivers/iio/magnetometer/st_mag40_spi.c
new file mode 100644
index 000000000000..7412dfbf7fa6
--- /dev/null
+++ b/drivers/iio/magnetometer/st_mag40_spi.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STMicroelectronics st_mag40 driver
+ *
+ * Copyright 2016 STMicroelectronics Inc.
+ *
+ * Armando Visconti <armando.visconti@st.com>
+ * Lorenzo Bianconi <lorenzo.bianconi@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "st_mag40_core.h"
+
+#define ST_SENSORS_SPI_READ	0x80
+
+static int st_mag40_spi_read(struct st_mag40_data *cdata,
+			     u8 reg_addr, int len, u8 *data)
+{
+	int err;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = cdata->tb.tx_buf,
+			.bits_per_word = 8,
+			.len = 1,
+		},
+		{
+			.rx_buf = cdata->tb.rx_buf,
+			.bits_per_word = 8,
+			.len = len,
+		}
+	};
+
+	cdata->tb.tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
+
+	err = spi_sync_transfer(to_spi_device(cdata->dev),
+						xfers, ARRAY_SIZE(xfers));
+	if (err)
+		return err;
+
+	memcpy(data, cdata->tb.rx_buf, len*sizeof(u8));
+
+	return len;
+}
+
+static int st_mag40_spi_write(struct st_mag40_data *cdata,
+			      u8 reg_addr, int len, u8 *data)
+{
+	struct spi_transfer xfers = {
+		.tx_buf = cdata->tb.tx_buf,
+		.bits_per_word = 8,
+		.len = len + 1,
+	};
+
+	if (len >= ST_MAG40_RX_MAX_LENGTH)
+		return -ENOMEM;
+
+	cdata->tb.tx_buf[0] = reg_addr;
+
+	memcpy(&cdata->tb.tx_buf[1], data, len);
+
+	return spi_sync_transfer(to_spi_device(cdata->dev), &xfers, 1);
+}
+
+static const struct st_mag40_transfer_function st_mag40_tf_spi = {
+	.write = st_mag40_spi_write,
+	.read = st_mag40_spi_read,
+};
+
+static int st_mag40_spi_probe(struct spi_device *spi)
+{
+	struct st_mag40_data *cdata;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*cdata));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, iio_dev);
+	iio_dev->dev.parent = &spi->dev;
+	iio_dev->name = spi->modalias;
+
+	cdata = iio_priv(iio_dev);
+	cdata->dev = &spi->dev;
+	cdata->name = spi->modalias;
+	cdata->tf = &st_mag40_tf_spi;
+	cdata->irq = spi->irq;
+
+	return st_mag40_common_probe(iio_dev);
+}
+
+static int st_mag40_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *iio_dev = spi_get_drvdata(spi);
+
+	st_mag40_common_remove(iio_dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int st_mag40_spi_suspend(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+
+	return st_mag40_common_suspend(cdata);
+}
+
+static int st_mag40_spi_resume(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct st_mag40_data *cdata = iio_priv(iio_dev);
+
+	return st_mag40_common_resume(cdata);
+}
+
+static const struct dev_pm_ops st_mag40_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(st_mag40_spi_suspend, st_mag40_spi_resume)
+};
+#endif /* CONFIG_PM */
+
+static const struct spi_device_id st_mag40_ids[] = {
+	{ LSM303AH_DEV_NAME, 0 },
+	{ LSM303AGR_DEV_NAME, 0 },
+	{ LIS2MDL_DEV_NAME, 0 },
+	{ ISM303DAC_DEV_NAME, 0 },
+	{ IIS2MDC_DEV_NAME, 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, st_mag40_ids);
+
+#ifdef CONFIG_OF
+static const struct of_device_id st_mag40_id_table[] = {
+	{
+		.compatible = "st,lsm303ah_magn",
+		.data = LSM303AH_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303agr_magn",
+		.data = LSM303AGR_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis2mdl_magn",
+		.data = LSM303AGR_DEV_NAME,
+	},
+	{
+		.compatible = "st,ism303dac_magn",
+		.data = ISM303DAC_DEV_NAME,
+	},
+	{
+		.compatible = "st,iis2mdc_magn",
+		.data = IIS2MDC_DEV_NAME,
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, st_mag40_id_table);
+#endif /* CONFIG_OF */
+
+static struct spi_driver st_mag40_spi_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = ST_MAG40_DEV_NAME,
+#ifdef CONFIG_PM
+		   .pm = &st_mag40_spi_pm_ops,
+#endif /* CONFIG_PM */
+#ifdef CONFIG_OF
+		   .of_match_table = st_mag40_id_table,
+#endif /* CONFIG_OF */
+		   },
+	.probe = st_mag40_spi_probe,
+	.remove = st_mag40_spi_remove,
+	.id_table = st_mag40_ids,
+};
+module_spi_driver(st_mag40_spi_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics st_mag40 spi driver");
+MODULE_AUTHOR("Armando Visconti <armando.visconti@st.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

