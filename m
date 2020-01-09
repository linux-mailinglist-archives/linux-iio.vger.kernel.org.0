Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EA13547B
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgAIIjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 03:39:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIjp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 03:39:45 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiJhQ-1jIUeF1KUA-00fSwb; Thu, 09 Jan 2020 09:39:29 +0100
Date:   Thu, 9 Jan 2020 09:39:28 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: srf04: add power management feature
Message-ID: <20200109083926.GA5377@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:yBiiUwUGN3ApV4YkGYD/EEsfayjGqNXcHywcz30qGlw2duOpSUd
 I2It6Zu08kcsTg0fjQEwoo5weYeaLy4Q8E5GLEZuBks4CvXmJQcdcCiTPEZBJGFyR0zVrcU
 dwgKfuU0ytJBges0CqmmcTU5oyTyixtXbZchWpD2481iFPx1hMNCFAxd44vobxmKq9+lETD
 mQLrc6+Pf8vsTNyYJvN6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLw1qeEs4ms=:tESwxL1oUYSqHCaeoKvp+B
 z8Pd/BtbzFGG5zaUk3x5hIbkJbJIeSJ35gG0KtJFt1utnke8BknWvoNAnQi+FOlO1C88x7XxK
 a30Zn5ylquEHHfIg9JP5v+biicVamLGeVUKj599n8JKbQ8Fkan1B63CsGJ3L5gSAKj9J4JfD4
 3JzjZyT7ZYyiemdgLKs+ExRyBdtsR2/1gV/FkpzG6zsiBTX4ZWy9+RU9vx0FsA0Vg/iYrlbDo
 AGw76EKnOk1R9sDID0V8Bw5QuAEb+lIekHcNBbc6emJLdus/wqcmwcW65vAkzBs+dySp2+s0o
 nMq8SgEJRCOgAPtEfpFhK1NsJgC0pZNOAsR/1OqKKMC4ep3m05UjYbUIZxjXpda3Sul/CC4x9
 cEPYyCQGRkXQeS0XjEvCvdq6q/M4FPeaxO4VrQGWJrG+pWg/TpCEMFVAU74jm8xoScJVUmHP0
 Uf7s8t70lOzWLVxKrJaNGVoNhFoOvhAbJJ/7Tj8LiJ+WFmqKp71GEdcaFXRgXB5jYdNhFTOyy
 gyDH4Nwx/hXDOdKyqRRxAXglcBx6fhDE+fx2ez2CSdjpN8mfRPtIzDv+ZMj9xXxDWatNAYj8V
 uRqZZ1twfPyfIhxfVyAETRcYHZ9NKvNBITWNBRGhV0yBg+uQurghr0+olcWKa/UsA2KDqR8ug
 wM9q07GlZbiEEwbDpmxL9r8Mcc6cQSQvPIBCyG04hCTh4d8obrf7dNbbCG/2v4JUb4MRlHpWv
 UKo94wBHPmF9aX3RG6X55rqg/py+4pf0waqmZIZsOVUtcOPpmseQXV5ebQ6XF1Sh2xMNM0IZO
 12RmkhcsSelPn4XMq1+J3wvM3bEYTRuV3Z9RJwIbF/MkEvPwkkTBQjO4IcbyefMRLZXuuW2ZT
 cz6kml8AQYNFrrR/cr1g==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add suspend and resume operations for being used by optional power
management.

The suspend function is switching off an GPIO which can be used by the
hardware to switch power off. The resume function is switching the GPIO
on and sleeps an adjustable time to give the device a chance to be up
and running.

If activated the driver gets into autosuspend after some time of
inactivity.

Suggested-by: Franz Parzer <rpi-receiver@htl-steyr.ac.at>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 104 +++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 01eb8cc63076..b19d910298d6 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -45,6 +45,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -56,6 +57,7 @@ struct srf04_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_trig;
 	struct gpio_desc	*gpiod_echo;
+	struct gpio_desc	*gpiod_power;
 	struct mutex		lock;
 	int			irqnr;
 	ktime_t			ts_rising;
@@ -63,6 +65,7 @@ struct srf04_data {
 	struct completion	rising;
 	struct completion	falling;
 	const struct srf04_cfg	*cfg;
+	int			startup_time_ms;
 };
 
 static const struct srf04_cfg srf04_cfg = {
@@ -97,6 +100,9 @@ static int srf04_read(struct srf04_data *data)
 	u64 dt_ns;
 	u32 time_ns, distance_mm;
 
+	if (data->gpiod_power)
+		pm_runtime_get_sync(data->dev);
+
 	/*
 	 * just one read-echo-cycle can take place at a time
 	 * ==> lock against concurrent reading calls
@@ -110,6 +116,11 @@ static int srf04_read(struct srf04_data *data)
 	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
+	if (data->gpiod_power) {
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+	}
+
 	/* it should not take more than 20 ms until echo is rising */
 	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
 	if (ret < 0) {
@@ -268,6 +279,26 @@ static int srf04_probe(struct platform_device *pdev)
 		return PTR_ERR(data->gpiod_echo);
 	}
 
+#ifdef CONFIG_PM
+	data->gpiod_power = devm_gpiod_get_optional(dev, "power",
+								GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_power)) {
+		dev_err(dev, "failed to get power-gpios: err=%ld\n",
+						PTR_ERR(data->gpiod_power));
+		return PTR_ERR(data->gpiod_power);
+	}
+	if (data->gpiod_power) {
+
+		if (of_property_read_u32(dev->of_node, "startup-time-ms",
+						&data->startup_time_ms))
+			data->startup_time_ms = 100;
+		dev_dbg(dev, "using power gpio: startup-time-ms=%d\n",
+							data->startup_time_ms);
+	}
+#else
+	data->gpiod_power = NULL;
+#endif
+
 	if (gpiod_cansleep(data->gpiod_echo)) {
 		dev_err(data->dev, "cansleep-GPIOs not supported\n");
 		return -ENODEV;
@@ -296,14 +327,85 @@ static int srf04_probe(struct platform_device *pdev)
 	indio_dev->channels = srf04_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(srf04_chan_spec);
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(data->dev, "iio_device_register: %d\n", ret);
+		return ret;
+	}
+
+	if (data->gpiod_power) {
+		pm_runtime_set_autosuspend_delay(data->dev, 1000);
+		pm_runtime_use_autosuspend(data->dev);
+
+		ret = pm_runtime_set_active(data->dev);
+		if (ret) {
+			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
+			iio_device_unregister(indio_dev);
+		}
+
+		pm_runtime_enable(data->dev);
+		pm_runtime_idle(data->dev);
+	}
+
+	return ret;
 }
 
+static int srf04_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct srf04_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	if (data->gpiod_power) {
+		pm_runtime_disable(data->dev);
+		pm_runtime_set_suspended(data->dev);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int srf04_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+						struct platform_device, dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct srf04_data *data = iio_priv(indio_dev);
+
+	gpiod_set_value(data->gpiod_power, 0);
+
+	return 0;
+}
+
+static int srf04_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev,
+						struct platform_device, dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct srf04_data *data = iio_priv(indio_dev);
+
+	gpiod_set_value(data->gpiod_power, 1);
+	msleep(data->startup_time_ms);
+
+	return 0;
+}
+
+static const struct dev_pm_ops srf04_pm_ops = {
+	SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
+				srf04_pm_runtime_resume, NULL)
+};
+#endif
+
 static struct platform_driver srf04_driver = {
 	.probe		= srf04_probe,
+	.remove		= srf04_remove,
 	.driver		= {
 		.name		= "srf04-gpio",
 		.of_match_table	= of_srf04_match,
+#ifdef CONFIG_PM
+		.pm		= &srf04_pm_ops,
+#endif
 	},
 };
 
-- 
2.20.1
