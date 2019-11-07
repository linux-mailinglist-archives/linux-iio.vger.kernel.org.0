Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262BFF2EB5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfKGNBd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 7 Nov 2019 08:01:33 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:01:32 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUGRh-1iKpTF19U3-00RKXJ; Thu, 07 Nov 2019 14:00:50 +0100
Date:   Thu, 7 Nov 2019 14:00:47 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iio: ping: add parallax ping sensors
Message-ID: <20191107130045.rt3ix2atyjd3gekr@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:nXx+Gy3UN403OOAJbCn0F13NiVlK2mTXENSbW1vuRV+JRD/RuaB
 KoI6bwjpHXI3/KuI5FDvcrNoW1VcJZ2CRg/cC0L0KUi+K/A1quCrpU4fCEd1C1IYTzywUg+
 PMMQ8QFXML2k5UbCa56fF0LuzeOYoPG10EoN0pUxD+Q4wVAl5iSfIK1rtHKjvZn5C1kxO8h
 q0DoNog0QMGUrTPyXVDNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MUQovN5zwb4=:zL8rZx0R7e2ZEWAesERG6Y
 UrMkcs8Sp3JGJw6rlZKth1GCmzVEXzExCrXLA2qRSTelwSFm5KSzW5cujKrw01fVp9uRPu3yz
 rhrD8yFB+LT1dkLhApjcTX69r4F9QOdLrhCRjyzC18rdZECu68J/Es/701geCrOiK5hiegvvE
 oLNT34QuBsSk2sUP1zk7J3X09kqa2FItcYuJikLjtSySjfSQSAmlcGRK0TkizGw5lJKLprgDU
 DaQwDvYYvsU86KqhR/MxUYh/Zgg3d57SI/sZ7E8Oytqmq0BOVKxf8fuEOj+x6qFNY3KyZo10M
 mclkhxMReomAR1Eu6Fc4vZ2R4XR0cKh/5T2pczyCRh28W1qRMfjcOKWfARNyxj58btWcnmBaa
 ZQ1oQ+FppeCSryADCOctX9Gsyd9XixATmvMsydvmV84x2gRkIjel7t2GvYSWkFMVcLZjj9pYO
 Vqgx2X5HzWsUbwACWtcwEBYp/3FzMXJHAD2UcNaPr7mmgwFSngTOROh1DeCg8ahO5T2ikHyOA
 yEgSpHxUWwuKT6eo+LgQ6+EgwtHFB3dR7luEQ1EC+AQDjwz7R0Lcc8uQ8uu43ZBLO4/TAoSq1
 8nIosf4RiX0nW5FZHVeJveggOt/RV2DfVTmds74OX+km/IOEj9fFBkOqRAxO5mCxUvC33BNpe
 EtsAdf2dQCheV/czCPiX7ob3N2Qt9SbjKcmVmrI1ggTxonl3gT9Z4gVtKLkn4qF84GWU8NrQU
 oygdUGlWkSRlh4YiNY37GwKFfQH6ogTrDTmqs1vCHyaVj87B9Fo8kiklGorvXUYvZCq05t2JD
 Ki4S1XG2je8Nn+RNWurNPnPjI8bw/+v3T3l/4KOtP2K0iuFCZlbRlpQpOPPffKGMAitPizA0A
 HL3KBZ4rHbQTdG/3ib9w==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

add support for parallax ping and laser ping sensors with just one pin
for trigger and echo signal.

This driver is based on srf04. In contrast to it it's necessary to
change direction of the pin and to request the irq just for the period
when the echo is rising and falling. Because this adds a lot of cases
there is this individual driver for handling this type of sensors.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/ping.c | 336 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)
 create mode 100644 drivers/iio/proximity/ping.c

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
new file mode 100644
index 000000000000..1a1fbb8ab0c2
--- /dev/null
+++ b/drivers/iio/proximity/ping.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PING: ultrasonic sensor for distance measuring by using only one GPIOs
+ *
+ * Copyright (c) 2019 Andreas Klinger <ak@it-klinger.de>
+ *
+ * For details about the devices see:
+ * http://parallax.com/sites/default/files/downloads/28041-LaserPING-2m-Rangefinder-Guide.pdf
+ * http://parallax.com/sites/default/files/downloads/28015-PING-Documentation-v1.6.pdf
+ *
+ * the measurement cycle as timing diagram looks like:
+ *
+ *          +---+            +------------------------+
+ * GPIO     |   |            |                        |
+ * ping:  --+   +------------+                        +----------------
+ *          ^   ^            ^                        ^
+ *          |<->|            interrupt                interrupt
+ *         udelay(5)         (ts_rising)              (ts_falling)
+ *                           |<---------------------->|
+ *                           .  pulse time measured
+ *                           .  --> one round trip of ultra sonic waves
+ *                           .                        .
+ * ultra           +-+ +-+ +-+                        .
+ * sonic           | | | | | |                        .
+ * burst: ---------+ +-+ +-+ +-----------------------------------------
+ *                                                    .
+ * ultra                                    +-+ +-+ +-+
+ * sonic                                    | | | | | |
+ * echo:  ----------------------------------+ +-+ +-+ +----------------
+ */
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+struct ping_cfg {
+	unsigned long	trigger_pulse_us;	/* length of trigger pulse */
+	int		laserping_error;	/* support error code in */
+						/*   pulse width of laser */
+						/*   ping sensors */
+	s64		timeout_ns;		/* timeout in ns */
+};
+
+struct ping_data {
+	struct device		*dev;
+	struct gpio_desc	*gpiod_ping;
+	struct mutex		lock;
+	int			irqnr;
+	ktime_t			ts_rising;
+	ktime_t			ts_falling;
+	struct completion	rising;
+	struct completion	falling;
+	const struct ping_cfg	*cfg;
+};
+
+static const struct ping_cfg pa_ping_cfg = {
+	.trigger_pulse_us	= 5,
+	.laserping_error	= 0,
+	.timeout_ns		= 18500000,	/* 3 meters */
+};
+
+static const struct ping_cfg pa_laser_ping_cfg = {
+	.trigger_pulse_us = 5,
+	.laserping_error = 1,
+	.timeout_ns		= 15500000,	/* 2 meters plus error codes */
+};
+
+static irqreturn_t ping_handle_irq(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ping_data *data = iio_priv(indio_dev);
+	ktime_t now = ktime_get();
+
+	if (gpiod_get_value(data->gpiod_ping)) {
+		data->ts_rising = now;
+		complete(&data->rising);
+	} else {
+		data->ts_falling = now;
+		complete(&data->falling);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ping_read(struct ping_data *data)
+{
+	int ret;
+	ktime_t ktime_dt;
+	s64 dt_ns;
+	u32 time_ns, distance_mm;
+	struct platform_device *pdev = container_of(data->dev,
+						struct platform_device, dev);
+	struct iio_dev *indio_dev = iio_priv_to_dev(data);
+
+	/*
+	 * just one read-echo-cycle can take place at a time
+	 * ==> lock against concurrent reading calls
+	 */
+	mutex_lock(&data->lock);
+
+	reinit_completion(&data->rising);
+	reinit_completion(&data->falling);
+
+	gpiod_set_value(data->gpiod_ping, 1);
+	udelay(data->cfg->trigger_pulse_us);
+	gpiod_set_value(data->gpiod_ping, 0);
+
+	ret = gpiod_direction_input(data->gpiod_ping);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	data->irqnr = gpiod_to_irq(data->gpiod_ping);
+	if (data->irqnr < 0) {
+		dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
+		return data->irqnr;
+	}
+
+	ret = devm_request_irq(data->dev, data->irqnr, ping_handle_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+							pdev->name, indio_dev);
+	if (ret < 0) {
+		dev_err(data->dev, "request_irq: %d\n", ret);
+		return ret;
+	}
+
+	/* it should not take more than 20 ms until echo is rising */
+	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
+	if (ret < 0)
+		goto err_reset_direction;
+	else if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto err_reset_direction;
+	}
+
+	/* it cannot take more than 50 ms until echo is falling */
+	ret = wait_for_completion_killable_timeout(&data->falling, HZ/20);
+	if (ret < 0)
+		goto err_reset_direction;
+	else if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto err_reset_direction;
+	}
+
+	ktime_dt = ktime_sub(data->ts_falling, data->ts_rising);
+
+	free_irq(data->irqnr, indio_dev);
+
+	ret = gpiod_direction_output(data->gpiod_ping, GPIOD_OUT_LOW);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	mutex_unlock(&data->lock);
+
+	dt_ns = ktime_to_ns(ktime_dt);
+	if (dt_ns > data->cfg->timeout_ns) {
+		dev_dbg(data->dev, "distance out of range: dt=%lldns\n",
+								dt_ns);
+		return -EIO;
+	}
+
+	time_ns = dt_ns;
+
+	/*
+	 * read error code of laser ping sensor and give users chance to
+	 * figure out error by using dynamic debuggging
+	 */
+	if (data->cfg->laserping_error) {
+		if ((time_ns > 12500000) && (time_ns <= 13500000)) {
+			dev_dbg(data->dev, "target too close or to far\n");
+			return -EIO;
+		}
+		if ((time_ns > 13500000) && (time_ns <= 14500000)) {
+			dev_dbg(data->dev, "internal sensor error\n");
+			return -EIO;
+		}
+		if ((time_ns > 14500000) && (time_ns <= 15500000)) {
+			dev_dbg(data->dev, "internal sensor timeout\n");
+			return -EIO;
+		}
+	}
+
+	/*
+	 * the speed as function of the temperature is approximately:
+	 *
+	 * speed = 331,5 + 0,6 * Temp
+	 *   with Temp in °C
+	 *   and speed in m/s
+	 *
+	 * use 343,5 m/s as ultrasonic speed at 20 °C here in absence of the
+	 * temperature
+	 *
+	 * therefore:
+	 *             time     343,5     time * 232
+	 * distance = ------ * ------- = ------------
+	 *             10^6         2        1350800
+	 *   with time in ns
+	 *   and distance in mm (one way)
+	 *
+	 * because we limit to 3 meters the multiplication with 232 just
+	 * fits into 32 bit
+	 */
+	distance_mm = time_ns * 232 / 1350800;
+
+	return distance_mm;
+
+err_reset_direction:
+	mutex_unlock(&data->lock);
+	free_irq(data->irqnr, indio_dev);
+
+	if (gpiod_direction_output(data->gpiod_ping, GPIOD_OUT_LOW))
+		dev_dbg(data->dev, "error in gpiod_direction_output\n");
+	return ret;
+}
+
+static int ping_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long info)
+{
+	struct ping_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (channel->type != IIO_DISTANCE)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ping_read(data);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * maximum resolution in datasheet is 1 mm
+		 * 1 LSB is 1 mm
+		 */
+		*val = 0;
+		*val2 = 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ping_iio_info = {
+	.read_raw		= ping_read_raw,
+};
+
+static const struct iio_chan_spec ping_chan_spec[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate =
+				BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct of_device_id of_ping_match[] = {
+	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
+	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_ping_match);
+
+static int ping_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ping_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct ping_data));
+	if (!indio_dev) {
+		dev_err(dev, "failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->cfg = of_match_device(of_ping_match, dev)->data;
+
+	mutex_init(&data->lock);
+	init_completion(&data->rising);
+	init_completion(&data->falling);
+
+	data->gpiod_ping = devm_gpiod_get(dev, "ping", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_ping)) {
+		dev_err(dev, "failed to get ping-gpios: err=%ld\n",
+						PTR_ERR(data->gpiod_ping));
+		return PTR_ERR(data->gpiod_ping);
+	}
+
+	if (gpiod_cansleep(data->gpiod_ping)) {
+		dev_err(data->dev, "cansleep-GPIOs not supported\n");
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = "ping";
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &ping_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ping_chan_spec;
+	indio_dev->num_channels = ARRAY_SIZE(ping_chan_spec);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver ping_driver = {
+	.probe		= ping_probe,
+	.driver		= {
+		.name		= "ping-gpio",
+		.of_match_table	= of_ping_match,
+	},
+};
+
+module_platform_driver(ping_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("PING sensors for distance measuring using one GPIOs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ping");
-- 
2.11.0
