Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB011EAFF1
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 13:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJaMNY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 08:13:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaMNY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Oct 2019 08:13:24 -0400
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6DrU-1iJYgB2qgi-006eja; Thu, 31 Oct 2019 13:13:19 +0100
Date:   Thu, 31 Oct 2019 13:13:19 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Subject: [RFC] iio: srf04: add parallax ping sensors
Message-ID: <20191031121317.vojiwnijmuq5jxap@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:/dek+YVNReTrl+vK+ZTQnT63YZssoCdt/xYsybAXxfuNjSr3hXC
 onAhHZTc7UsD2GMnUuMmDOwZFZ7ICuvhB687kE7ykHJRSel0nnpeboaJeSbnDn+2nWK9PTk
 iVCxTcdh9xrRwrP3W9e0MvcYPOR0vSmK1uW1EKZ9JWKhAVs+6Y1r+Go2yDGUh51qaJNOccd
 hfMcePD2r4VLSECwAIBdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zN3owq6sgi0=:oLR64eAqDOwKPBJWnPJfs2
 GU4T3zwbckCaUyTEeIWRxzUYL1F1VNL8xpunZjfC/vYRVXO8Z/arM6soGpXHm+YVsRbgzJFR4
 n3aAHcSN5ZTyuKJX+cTB+AI/tf5/e1NEOW1uBiR53sdrVyPLm5Ki6i0cs4wokxLtuKG5WBAS1
 JIKzsrF05WUijXj5Nai1Nbqej6MbXVqWewh22XI5OR9p2JYggb5Fn1CDFTPlAWD+XRzUyTEor
 +7Z0MSa5hSQ7R/XZNsVe+x5ctytM1LPeMEUQantmr8CWbwsJox7JwTvpxKqVYwFetemdNpYYA
 63KqKY4AotiY9vKS1R8c7zGpCcAr7nSptIdAcCip1pbMnxb2DEFoJc9O8292ff9p5VeSlAMpO
 EZQvsZtcGFOPMsyf3kD0IJKYF30h8OC9tAKg8cIXOn2ErKjoYXFMimeQqu+Wm9yA/+8aN/Flq
 rhle8GhTAnE5ufaHAXZV/UOFGzfnw9Ba3hKckk3eFh2N6Hq0KLndzJ6pYu0aKfO4uj5GQdgI/
 B89eC8go+PZ63wxJc88nArR5eWpjxEF8ZaXIoo7saNqdr2nkYxiIMKXEjTXw2ZzMyGhZhtb1r
 GeX4mH0sQAFyj4asXJTStY784FHE+6IbRbz3mucTBN68rZVvSdeVu9lj/txGUaUj4YsN4Ynqh
 ZjipxT0IIMOHwkSyCADp5KWvyl5Kspcjc8RWawvKSXbTxADupeiLxQ44BB03Ce9PBflFN8Tgy
 /PgQwov6/oO+sWe3+N+yL3z//pcgbJyzxPH75vxvtn/rcXyae1QfXo9ZRbVO1+RgOpwNBUvj3
 AnxhJTuy66ZoK1SdVesJ/T+5Z/pb6vyoaCtCsJEBZM0mVxfEV3qt3znUzVBzUIShtJ52Ht2FY
 Iro4zXOrb0QwCSa4ZjsA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

i added support for parallax ping and laser ping sensors with just one pin
for trigger and echo signal.

After implementing it turned out that this one pin sensor requires a lot of
conditions and special treatment. But the calculation is still the same as
for srf04.

Should it be integrated into the existing srf04 driver or should i create a
new one for those single pin us sensors? Maybe together with a C module for
the calculations they have in common.

Regards,

Andreas

---
 drivers/iio/proximity/srf04.c | 151 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 01eb8cc63076..8bcc77a45965 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -49,7 +49,12 @@
 #include <linux/iio/sysfs.h>
 
 struct srf04_cfg {
-	unsigned long trigger_pulse_us;
+	unsigned long	trigger_pulse_us;	/* length of trigger pulse */
+	int		single_pin_mode;	/* just one pin for trigger */
+						/*   and echo */
+	int		laserping_error;	/* support error code in */
+						/*   pulse width of laser */
+						/*   ping sensors */
 };
 
 struct srf04_data {
@@ -67,10 +72,26 @@ struct srf04_data {
 
 static const struct srf04_cfg srf04_cfg = {
 	.trigger_pulse_us = 10,
+	.single_pin_mode = 0,
+	.laserping_error = 0,
 };
 
 static const struct srf04_cfg mb_lv_cfg = {
 	.trigger_pulse_us = 20,
+	.single_pin_mode = 0,
+	.laserping_error = 0,
+};
+
+static const struct srf04_cfg pa_ping_cfg = {
+	.trigger_pulse_us = 5,
+	.single_pin_mode = 1,
+	.laserping_error = 0,
+};
+
+static const struct srf04_cfg pa_laser_ping_cfg = {
+	.trigger_pulse_us = 5,
+	.single_pin_mode = 1,
+	.laserping_error = 1,
 };
 
 static irqreturn_t srf04_handle_irq(int irq, void *dev_id)
@@ -96,6 +117,9 @@ static int srf04_read(struct srf04_data *data)
 	ktime_t ktime_dt;
 	u64 dt_ns;
 	u32 time_ns, distance_mm;
+	struct platform_device *pdev = container_of(data->dev,
+						struct platform_device, dev);
+	struct iio_dev *indio_dev = iio_priv_to_dev(data);
 
 	/*
 	 * just one read-echo-cycle can take place at a time
@@ -110,30 +134,58 @@ static int srf04_read(struct srf04_data *data)
 	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
+	if (data->cfg->single_pin_mode) {
+		ret = gpiod_direction_input(data->gpiod_trig);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		data->irqnr = gpiod_to_irq(data->gpiod_echo);
+		if (data->irqnr < 0) {
+			dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
+			return data->irqnr;
+		}
+
+		ret = devm_request_irq(data->dev, data->irqnr, srf04_handle_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				pdev->name, indio_dev);
+		if (ret < 0) {
+			dev_err(data->dev, "request_irq: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* it should not take more than 20 ms until echo is rising */
 	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		return ret;
-	} else if (ret == 0) {
-		mutex_unlock(&data->lock);
-		return -ETIMEDOUT;
+	if (ret < 0)
+		goto err_reset_direction;
+	else if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto err_reset_direction;
 	}
 
 	/* it cannot take more than 50 ms until echo is falling */
 	ret = wait_for_completion_killable_timeout(&data->falling, HZ/20);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		return ret;
-	} else if (ret == 0) {
-		mutex_unlock(&data->lock);
-		return -ETIMEDOUT;
+	if (ret < 0)
+		goto err_reset_direction;
+	else if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto err_reset_direction;
 	}
 
 	ktime_dt = ktime_sub(data->ts_falling, data->ts_rising);
 
 	mutex_unlock(&data->lock);
 
+	if (data->cfg->single_pin_mode) {
+		free_irq(data->irqnr, indio_dev);
+
+		ret = gpiod_direction_output(data->gpiod_trig, GPIOD_OUT_LOW);
+		if (ret < 0)
+			return ret;
+	}
+
 	dt_ns = ktime_to_ns(ktime_dt);
 	/*
 	 * measuring more than 6,45 meters is beyond the capabilities of
@@ -154,6 +206,25 @@ static int srf04_read(struct srf04_data *data)
 	time_ns = dt_ns;
 
 	/*
+	 * read error code of laser ping sensor and give users chance to
+	 * figure out error by using dynamic debuggging
+	 */
+	if (data->cfg->laserping_error) {
+		if ((time_ns >= 12500000) && (time_ns < 13500000)) {
+			dev_dbg(data->dev, "target too close or to far\n");
+			return -EIO;
+		}
+		if ((time_ns >= 13500000) && (time_ns < 14500000)) {
+			dev_dbg(data->dev, "internal sensor error\n");
+			return -EIO;
+		}
+		if ((time_ns >= 14500000) && (time_ns < 15500000)) {
+			dev_dbg(data->dev, "internal sensor timeout\n");
+			return -EIO;
+		}
+	}
+
+	/*
 	 * the speed as function of the temperature is approximately:
 	 *
 	 * speed = 331,5 + 0,6 * Temp
@@ -176,6 +247,16 @@ static int srf04_read(struct srf04_data *data)
 	distance_mm = time_ns * 106 / 617176;
 
 	return distance_mm;
+
+err_reset_direction:
+	mutex_unlock(&data->lock);
+	if (data->cfg->single_pin_mode) {
+		free_irq(data->irqnr, indio_dev);
+
+		if (gpiod_direction_output(data->gpiod_trig, GPIOD_OUT_LOW))
+			dev_dbg(data->dev, "error in gpiod_direction_output\n");
+	}
+	return ret;
 }
 
 static int srf04_read_raw(struct iio_dev *indio_dev,
@@ -228,6 +309,8 @@ static const struct of_device_id of_srf04_match[] = {
 	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
 	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
 	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
+	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
+	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
 	{},
 };
 
@@ -261,11 +344,19 @@ static int srf04_probe(struct platform_device *pdev)
 		return PTR_ERR(data->gpiod_trig);
 	}
 
-	data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
-	if (IS_ERR(data->gpiod_echo)) {
-		dev_err(dev, "failed to get echo-gpios: err=%ld\n",
+	/*
+	 * some sensors come along with just one pin for triggering and the
+	 * echo
+	 */
+	if (data->cfg->single_pin_mode)
+		data->gpiod_echo = data->gpiod_trig;
+	else {
+		data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
+		if (IS_ERR(data->gpiod_echo)) {
+			dev_err(dev, "failed to get echo-gpios: err=%ld\n",
 					PTR_ERR(data->gpiod_echo));
-		return PTR_ERR(data->gpiod_echo);
+			return PTR_ERR(data->gpiod_echo);
+		}
 	}
 
 	if (gpiod_cansleep(data->gpiod_echo)) {
@@ -273,18 +364,20 @@ static int srf04_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->irqnr = gpiod_to_irq(data->gpiod_echo);
-	if (data->irqnr < 0) {
-		dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
-		return data->irqnr;
-	}
-
-	ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			pdev->name, indio_dev);
-	if (ret < 0) {
-		dev_err(data->dev, "request_irq: %d\n", ret);
-		return ret;
+	if (!data->cfg->single_pin_mode) {
+		data->irqnr = gpiod_to_irq(data->gpiod_echo);
+		if (data->irqnr < 0) {
+			dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
+			return data->irqnr;
+		}
+
+		ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				pdev->name, indio_dev);
+		if (ret < 0) {
+			dev_err(data->dev, "request_irq: %d\n", ret);
+			return ret;
+		}
 	}
 
 	platform_set_drvdata(pdev, indio_dev);
-- 
2.11.0
