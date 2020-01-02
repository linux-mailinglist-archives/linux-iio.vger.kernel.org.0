Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E287F12E966
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgABR3B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 12:29:01 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:54221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgABR3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jan 2020 12:29:00 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsSj-1j1huT06wf-00LJ2m; Thu, 02 Jan 2020 18:28:44 +0100
Date:   Thu, 2 Jan 2020 18:28:43 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: srf04: add power management feature
Message-ID: <20200102172841.iv2ej5gtnufkqmll@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:kpxqvnxU/14xcISH9Vs4iYpjFPgF+e9DupLuJTMB0sPPmTuFfud
 S2LZ5n1tFEL4LNDrnQGsnwWfvD1DTBBTHAFY4jzWpNEZgi7RGMExP4uWPF1R5edYZFUgY1I
 zMoTuZHxzLMrJEgBaH8ucLa+YbFz1sdexbtBlGslHM5d/6Jk8cYU96QI+tlL3vRBAxhfiHL
 QbAU13R5vtI94dXfD8urQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HWY5LQvu8DU=:1ozE28T7Iwzi4a3NmLbjh2
 PFOus3z0uNkvKELjeyyQhBgBjDebgZNUsr80G+IYss1EUb1ZPeJ5qt8VCIWVa7MJgIsmt5OwO
 e/H/VJoX0kx+QFbRxup1BAiFKcfwqg8zpS6C1N7tZl0aIqHpSoCyOfM1i5c1teIRsBkpnesmP
 q1WhrP8UIY0v2b4/90+KvDMusmByRBSiB4gPPv494hoRLek0Pmb15iZ1N/EY96eZlPO63BoBs
 XcwAdixWdsyntr1lp+FoWjMS8FIjctm5QjdE6yVyvTzzLu0bJqEfjlbiJ8XTD/DFmruX7EtwI
 o+pPsYHuR61NQbeutVHPmc658Gjbsp30JKCk6pIwsCv0lIOaNU6HF8VWllz4kt7DKs8/RUoJe
 vQrTfogUZQjpEUDXVSu7Mntxh3uOU60VIcb/u4uLh0VsozcvUc8/MaVqk4izsUVaTYteZFpmP
 So40h6UwKr9ropaiBJasLm7/PawRSleyIRL7pBUnRjiB3RrXJ953D5yTnaSxs/4MDFbtmEebD
 /0GCZHrT2i7ZSQKQ4wFbiWECCl3dUEhfytdfYK90CgbcIol3QRjj9u+DdjqwJ7vp4U03R76UU
 Sx8AJ4aRUkFBmu03qdAt4fvixrMNtlZ1RTR+wswHf6aI4pqiVjk+y2VnbPXPvLsHo+HWkAPZ/
 cY6oZ1R09MrI800KjDJCStTpp3ABX4/Vr745AZeV+6MU0lWne+MmudfYRpNeHpOTxdro1+cRe
 SPrk3rFQgNFuhawm+JtNuiw913tnMR7/J0H4sDnJk3svuO9l1D/Wlbh3U5vQAV7oaDRA2fV4Y
 bhhkKcjYOZzkPR3Kcv1xIleYZalVfHnmb9mJXjOvc3/c4F4TNSiF00O0uA0jSZ2+bI2eoejqq
 Iwhh19GB/BOijlT5HTAA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add suspend and resume operations for being used by optional power
management.

The suspend function is switching off an GPIO which can be used by the
hardware to switch power off. The resume function is switching the GPIO on
and sleeps an adjustable time to give the device a chance to be up and
running.

If activated the driver gets into autosuspend after some time of
inactivity.

Suggested-by: Franz Parzer <rpi-receiver@htl-steyr.ac.at>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 104 +++++++++++++++++++++++++++++++++++++++++-
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
2.11.0
