Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C8614302E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATQqB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 11:46:01 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQqB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 11:46:01 -0500
Received: from localhost ([217.91.205.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZTyi-1j6BdY0P4Q-00WUV8; Mon, 20 Jan 2020 17:45:42 +0100
Date:   Mon, 20 Jan 2020 17:45:41 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: srf04: add power management feature
Message-ID: <20200120164540.GA8725@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:3hCyP3wz1c4WNIC8NGVeJsBSI1zAjBZAjz1ma3u4tSTLyexJTXg
 RLrVcj9jQSOjdNE9+ZeoZ8tOIKi2N3OoOVog1GXNx0AuH0CWIL3KQFIJMpf1AL/eSPXEuuS
 oUPOHFziMrpVaXjshUgdSfOILvbibmPRE5wVNdkIZJJzksXF6OOCFqOc2TPrD+0X918k816
 6G2IUtfOKxDmTYKaWvkpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9G8UZvti0Co=:Z5lnGF5Gj3/IXYsIy9Zo7N
 wg4VefxQVSXyNAVIlSCwmzsY87jtd+7qm/aCSV/m4qL26dQVhALVQTFhRpoEekNFUpHK8lCJz
 hAPkWE9wHoyESRdqwxIiDV4SZCIIiUAJCNYgYVjYYOUvQcYXSeVbgbsohelcyr/J74HGVdC/5
 VvGdGGJBdTFmhRDtnTOmdbjqF+u+ssDJseWlbA490Kj05JedEN8qIDjLtlAKGzpANIsaDYLTh
 X3yt/kQ7a4IjM07HqI64fXz/zu3CaAnGHLKpjqurWAWA1k5ggtn1Y9pIxfgpHF/9f8z4jQOy2
 7ENy5Usn0IoJZNfBSYVcYCdFOBm/K5K2UVCYYuyjPc14P92U4hkLC6kcywFBzT5CGUDaFedml
 fLIs0Zl7cE4Iip+3I8G21mtWzHSHxHT+zRB0PjDhEhJW+ECeqcSEjEjo7xPqFieS53v0bhxIe
 DxlnZva8t4C8NhklCTpweU5IxKHW9vnLAXoBF0nYd8E1WbPA8NbVNC88BRgTdZ3TuHT62zxRA
 K6H6bDSQfaEOGFVXIfUnJCk9bgrMLZvFNngoWP6ICHT8Q+juz/che7gCw+PHVG6HQn5OY0egw
 q8/Eprkn5sllo/0TF1/Ic0WDq9a84b81hwoLQywMthX6wPUoKfCOzmDmKohewXKik3LA2ImS/
 1bheaTtRQMb1TDlIdZ3oTcN6OMhEmED7KTcyuTVivnRj6YldrIoP9uQspA4YAkxodWKvJc4OL
 iR/gd47Y7Iiu0Fk5hw1fJ5me2qxQXJS/k7BRI0EShUZu23JCt4gYfZoHzMa5XoIaAPml2mlkz
 1hLYTtYab5hXMBCzJht6zF8lqozMrpttuk2md17WQaWh/Ubwx1tq3lO6cwRzOg9r4ecDpLfsS
 86T/RWLB/JPbZukqkbqQ==
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
 drivers/iio/proximity/srf04.c | 96 ++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 01eb8cc63076..568b76e06385 100644
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
@@ -268,6 +279,22 @@ static int srf04_probe(struct platform_device *pdev)
 		return PTR_ERR(data->gpiod_echo);
 	}
 
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
+
 	if (gpiod_cansleep(data->gpiod_echo)) {
 		dev_err(data->dev, "cansleep-GPIOs not supported\n");
 		return -ENODEV;
@@ -296,14 +323,81 @@ static int srf04_probe(struct platform_device *pdev)
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
+static int __maybe_unused srf04_pm_runtime_suspend(struct device *dev)
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
+static int __maybe_unused srf04_pm_runtime_resume(struct device *dev)
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
+
 static struct platform_driver srf04_driver = {
 	.probe		= srf04_probe,
+	.remove		= srf04_remove,
 	.driver		= {
 		.name		= "srf04-gpio",
 		.of_match_table	= of_srf04_match,
+		.pm		= &srf04_pm_ops,
 	},
 };
 
-- 
2.20.1
