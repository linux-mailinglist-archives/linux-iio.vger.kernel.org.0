Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9617FD740
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 08:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfKOHpn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 15 Nov 2019 02:45:43 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:53089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfKOHpm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 02:45:42 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0G5h-1hhnB22iXv-00xHNI; Fri, 15 Nov 2019 08:45:03 +0100
Date:   Fri, 15 Nov 2019 08:44:57 +0100
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
Subject: [PATCH v2 3/4] iio: ping: add parallax ping sensors
Message-ID: <20191115074456.vvjvw4you4i5mcja@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:XsHNXMNXEYzL5wpmlTkSr2yVJxyfzXvpQ5AKl2YqKeZaw4/0GHm
 kLyafurMD5/UM4unZxcvN4QSKmxM3ZkDgx/v1uLeiELGv4nkPMQp3wjgyklMlSAJf8gQYrk
 aSuwQA7KnSxvHBBiBPLMgQGq5+OBPy/bKECTG1Lb+BXdVWX+GWfefNisg7nj7rf6Iv8+Sk9
 L1+6O8Htlx0iMJNzYoMFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jscXi1l9jV0=:4IdBNsFKUpDd6FRiLgXMY2
 C21KUQroodxczXfwRuW335/PbzQkfCZ4K3H+2cD6QYXEsfRUqw81ltTubD1WSYKI3vZs7QWwb
 aakgimb8S0dRQQ1+4OCOj5xhV5BqCbdvSLdOionXxkOxwBxPvtY93cbumLjwGvR522S75cM0u
 Y5n7YKXnRPESO00QG66DnzNvJXNfPX4ckRX/2cEKzqAH7scUnbFYEGm+x9eRhmR+PgZvCwuo8
 2k2oVfDX1ED9Xw5TW85Z+3QYE4eQbXS5lZm8KoovsCMzul9BTD3KzO08K2tIXGiQKokhXQekA
 /7ENWIB6i0e06iozI3Ld63+N+wFF5jGMUVxSuC422rdZdNFbKesYvRU6m6HxCgEfkN+hN8shB
 juRMatRuJaA1mfWHgW9kctGeNctU+R4tDT2sQQSEpI6DkNrp8EzjCHIHTCohcVtPS6BqG3dnT
 5wXK5SdhKaT99AdG/S6Y60Tr96kib0SIf1YEDWCST2pnhdo4gSGyfzETXl1ePXCNneek2er9J
 EmGXnM3gKyBAn2LKjNKds7E93JjfHfQZsqYZpvgBUIsT+3W8NGj4+4IzrpL0z59ODjH6LEn8C
 PJZyfUVTfxE4EKzVznRphjTUbNkjtosbHRf4/ZykJGF2mrIOaZgECtJgZf/s1xbYbavqkE6YC
 y6ZRG1lh9Tev9/n3Q+JFSqo78O7vxgiT7OHvcr5/d8PdR4FEa7HUGdtlHWzZR+AW55I5hKPzp
 SVQlr1GcPR+EbjSj8pLr+AquMn4OtsU/8vviYcoezvxI5Vh5pFuHqleQAuDjzWmu0MCbrxz1V
 P8uVHiWSfZCWc+OqC8CPtD0WqEeR3DY8SOJ5LQM6GMDAEVsB7GoAz0ZzTF3hqqVpypcryVFkj
 5Z7A670hkxKn+7iIy/nw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for parallax ping and laser ping sensors with just one pin
for trigger and echo signal.

This driver is based on srf04. In contrast to it it's necessary to
change direction of the pin and to request the irq just for the period
when the echo is rising and falling. Because this adds a lot of cases
there is this individual driver for handling this type of sensors.

Add a new configuration variable CONFIG_PING to Kconfig and Makefile.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig  |  15 ++
 drivers/iio/proximity/Makefile |   1 +
 drivers/iio/proximity/ping.c   | 333 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 349 insertions(+)
 create mode 100644 drivers/iio/proximity/ping.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index d53601447da4..37606d400805 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -58,6 +58,21 @@ config MB1232
 	  To compile this driver as a module, choose M here: the
 	  module will be called mb1232.
 
+config PING
+	tristate "Parallax GPIO bitbanged ranger sensors"
+	depends on GPIOLIB
+	help
+	  Say Y here to build a driver for GPIO bitbanged ranger sensors
+	  with just one GPIO for the trigger and echo. This driver can be
+	  used to measure the distance of objects.
+
+	  Actually supported are:
+	  - Parallax PING))) (ultrasonic)
+	  - Parallax LaserPING (time-of-flight)
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ping.
+
 config RFD77402
 	tristate "RFD77402 ToF sensor"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 0bb5f9de13d6..c591b019304e 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
 obj-$(CONFIG_MB1232)		+= mb1232.o
+obj-$(CONFIG_PING)		+= ping.o
 obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
new file mode 100644
index 000000000000..cc4a3b546374
--- /dev/null
+++ b/drivers/iio/proximity/ping.c
@@ -0,0 +1,333 @@
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
+ * GPIO      ___              ________________________
+ * ping:  __/   \____________/                        \________________
+ *          ^   ^            ^                        ^
+ *          |<->|            interrupt                interrupt
+ *         udelay(5)         (ts_rising)              (ts_falling)
+ *                           |<---------------------->|
+ *                           .  pulse time measured   .
+ *                           .  --> one round trip of ultra sonic waves
+ * ultra                     .                        .
+ * sonic            _   _   _.                        .
+ * burst: _________/ \_/ \_/ \_________________________________________
+ *                                                    .
+ * ultra                                              .
+ * sonic                                     _   _   _.
+ * echo:  __________________________________/ \_/ \_/ \________________
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
+	.trigger_pulse_us	= 5,
+	.laserping_error	= 1,
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
+	struct platform_device *pdev = to_platform_device(data->dev);
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
+	data->cfg = of_device_get_match_data(dev);
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
