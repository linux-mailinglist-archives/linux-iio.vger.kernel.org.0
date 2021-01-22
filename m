Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2EC3006A8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbhAVPGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 10:06:54 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52908 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729102AbhAVPGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:06:40 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MEvCjp024039;
        Fri, 22 Jan 2021 16:05:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=DfGK4MbGjF89NcTEveRx/yqC3sgoowMDyokoNkQWT2I=;
 b=1Uv+MfS/ClVZjrvuXrJZKC8YFt5m42zrpk7SiH0ybjv7OND61xx8iT9hRcdgIh0ljf+n
 pcdrtYoLv43pP34uR8XC15JRQ4levYFX7/Sa/AGs53pfPHFuj/Je73ANWOYj+Y8NrNTF
 e+s4I78YbR1Vp4hhfikF9qLf9BPT3TffnhJq7bhF1ouf6WPvbR7AAOqhY67I0VIlyH04
 Jfpq5UxK7IKOobR1UpQXlVcB6OZrjVmI/q6MJdidQrKxohbAMsM4OgQFRWIbY9OnDehD
 eAKzT5mlnhpJGj7j+kcesBntcOoROWm7exVgwj7y/kMwe+3LdXJ3Irrl0ZRmPFjl5UHE EQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668p5afgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 16:05:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 212B210002A;
        Fri, 22 Jan 2021 16:05:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03FA225D032;
        Fri, 22 Jan 2021 16:05:21 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 16:05:19
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <jic23@kernel.org>, <vilhelm.gray@gmail.com>
CC:     <mchehab+huawei@kernel.org>, <lukas.bulwahn@gmail.com>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] counter: stm32-lptimer-cnt: remove iio counter abi
Date:   Fri, 22 Jan 2021 16:03:23 +0100
Message-ID: <1611327803-882-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, the STM32 LP Timer counter driver registers into both IIO and
counter subsystems, which is redundant.

Remove the IIO counter ABI and IIO registration from the STM32 LP Timer
counter driver since it's been superseded by the Counter subsystem
as discussed in [1].

Keep only the counter subsystem related part.
Move a part of the ABI documentation into a driver comment.

This also removes a duplicate ABI warning
$ scripts/get_abi.pl validate
...
/sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:
  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100
  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0

[1] https://lkml.org/lkml/2021/1/19/347

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  62 -----
 drivers/counter/stm32-lptimer-cnt.c                | 297 +++------------------
 2 files changed, 36 insertions(+), 323 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
deleted file mode 100644
index 73498ff..00000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
+++ /dev/null
@@ -1,62 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
-KernelVersion:	4.13
-Contact:	fabrice.gasnier@st.com
-Description:
-		Reading returns the current preset value. Writing sets the
-		preset value. Encoder counts continuously from 0 to preset
-		value, depending on direction (up/down).
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
-KernelVersion:	4.13
-Contact:	fabrice.gasnier@st.com
-Description:
-		Reading returns the list possible quadrature modes.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
-KernelVersion:	4.13
-Contact:	fabrice.gasnier@st.com
-Description:
-		Configure the device counter quadrature modes:
-
-		- non-quadrature:
-			Encoder IN1 input servers as the count input (up
-			direction).
-
-		- quadrature:
-			Encoder IN1 and IN2 inputs are mixed to get direction
-			and count.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_polarity_available
-KernelVersion:	4.13
-Contact:	fabrice.gasnier@st.com
-Description:
-		Reading returns the list possible active edges.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count0_polarity
-KernelVersion:	4.13
-Contact:	fabrice.gasnier@st.com
-Description:
-		Configure the device encoder/counter active edge:
-
-		- rising-edge
-		- falling-edge
-		- both-edges
-
-		In non-quadrature mode, device counts up on active edge.
-
-		In quadrature mode, encoder counting scenarios are as follows:
-
-		+---------+----------+--------------------+--------------------+
-		| Active  | Level on |      IN1 signal    |     IN2 signal     |
-		| edge    | opposite +----------+---------+----------+---------+
-		|         | signal   |  Rising  | Falling |  Rising  | Falling |
-		+---------+----------+----------+---------+----------+---------+
-		| Rising  | High ->  |   Down   |    -    |   Up     |    -    |
-		| edge    | Low  ->  |   Up     |    -    |   Down   |    -    |
-		+---------+----------+----------+---------+----------+---------+
-		| Falling | High ->  |    -     |   Up    |    -     |   Down  |
-		| edge    | Low  ->  |    -     |   Down  |    -     |   Up    |
-		+---------+----------+----------+---------+----------+---------+
-		| Both    | High ->  |   Down   |   Up    |   Up     |   Down  |
-		| edges   | Low  ->  |   Up     |   Down  |   Down   |   Up    |
-		+---------+----------+----------+---------+----------+---------+
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index fd6828e..9374396 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -12,8 +12,8 @@
 
 #include <linux/bitfield.h>
 #include <linux/counter.h>
-#include <linux/iio/iio.h>
 #include <linux/mfd/stm32-lptimer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -107,249 +107,27 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
 	return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
 }
 
-static int stm32_lptim_write_raw(struct iio_dev *indio_dev,
-				 struct iio_chan_spec const *chan,
-				 int val, int val2, long mask)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_ENABLE:
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		/* Check nobody uses the timer, or already disabled/enabled */
-		ret = stm32_lptim_is_enabled(priv);
-		if ((ret < 0) || (!ret && !val))
-			return ret;
-		if (val && ret)
-			return -EBUSY;
-
-		ret = stm32_lptim_setup(priv, val);
-		if (ret)
-			return ret;
-		return stm32_lptim_set_enable_state(priv, val);
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-	u32 dat;
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &dat);
-		if (ret)
-			return ret;
-		*val = dat;
-		return IIO_VAL_INT;
-
-	case IIO_CHAN_INFO_ENABLE:
-		ret = stm32_lptim_is_enabled(priv);
-		if (ret < 0)
-			return ret;
-		*val = ret;
-		return IIO_VAL_INT;
-
-	case IIO_CHAN_INFO_SCALE:
-		/* Non-quadrature mode: scale = 1 */
-		*val = 1;
-		*val2 = 0;
-		if (priv->quadrature_mode) {
-			/*
-			 * Quadrature encoder mode:
-			 * - both edges, quarter cycle, scale is 0.25
-			 * - either rising/falling edge scale is 0.5
-			 */
-			if (priv->polarity > 1)
-				*val2 = 2;
-			else
-				*val2 = 1;
-		}
-		return IIO_VAL_FRACTIONAL_LOG2;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_info stm32_lptim_cnt_iio_info = {
-	.read_raw = stm32_lptim_read_raw,
-	.write_raw = stm32_lptim_write_raw,
-};
-
-static const char *const stm32_lptim_quadrature_modes[] = {
-	"non-quadrature",
-	"quadrature",
-};
-
-static int stm32_lptim_get_quadrature_mode(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *chan)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return priv->quadrature_mode;
-}
-
-static int stm32_lptim_set_quadrature_mode(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *chan,
-					   unsigned int type)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	priv->quadrature_mode = type;
-
-	return 0;
-}
-
-static const struct iio_enum stm32_lptim_quadrature_mode_en = {
-	.items = stm32_lptim_quadrature_modes,
-	.num_items = ARRAY_SIZE(stm32_lptim_quadrature_modes),
-	.get = stm32_lptim_get_quadrature_mode,
-	.set = stm32_lptim_set_quadrature_mode,
-};
-
-static const char * const stm32_lptim_cnt_polarity[] = {
-	"rising-edge", "falling-edge", "both-edges",
-};
-
-static int stm32_lptim_cnt_get_polarity(struct iio_dev *indio_dev,
-					const struct iio_chan_spec *chan)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return priv->polarity;
-}
-
-static int stm32_lptim_cnt_set_polarity(struct iio_dev *indio_dev,
-					const struct iio_chan_spec *chan,
-					unsigned int type)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	priv->polarity = type;
-
-	return 0;
-}
-
-static const struct iio_enum stm32_lptim_cnt_polarity_en = {
-	.items = stm32_lptim_cnt_polarity,
-	.num_items = ARRAY_SIZE(stm32_lptim_cnt_polarity),
-	.get = stm32_lptim_cnt_get_polarity,
-	.set = stm32_lptim_cnt_set_polarity,
-};
-
-static ssize_t stm32_lptim_cnt_get_ceiling(struct stm32_lptim_cnt *priv,
-					   char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
-}
-
-static ssize_t stm32_lptim_cnt_set_ceiling(struct stm32_lptim_cnt *priv,
-					   const char *buf, size_t len)
-{
-	int ret;
-
-	if (stm32_lptim_is_enabled(priv))
-		return -EBUSY;
-
-	ret = kstrtouint(buf, 0, &priv->ceiling);
-	if (ret)
-		return ret;
-
-	if (priv->ceiling > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
-
-	return len;
-}
-
-static ssize_t stm32_lptim_cnt_get_preset_iio(struct iio_dev *indio_dev,
-					      uintptr_t private,
-					      const struct iio_chan_spec *chan,
-					      char *buf)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return stm32_lptim_cnt_get_ceiling(priv, buf);
-}
-
-static ssize_t stm32_lptim_cnt_set_preset_iio(struct iio_dev *indio_dev,
-					      uintptr_t private,
-					      const struct iio_chan_spec *chan,
-					      const char *buf, size_t len)
-{
-	struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
-
-	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
-}
-
-/* LP timer with encoder */
-static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset_iio,
-		.write = stm32_lptim_cnt_set_preset_iio,
-	},
-	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM("quadrature_mode", IIO_SEPARATE,
-		 &stm32_lptim_quadrature_mode_en),
-	IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_lptim_quadrature_mode_en),
-	{}
-};
-
-static const struct iio_chan_spec stm32_lptim_enc_channels = {
-	.type = IIO_COUNT,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_ENABLE) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.ext_info = stm32_lptim_enc_ext_info,
-	.indexed = 1,
-};
-
-/* LP timer without encoder (counter only) */
-static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = stm32_lptim_cnt_get_preset_iio,
-		.write = stm32_lptim_cnt_set_preset_iio,
-	},
-	IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
-	IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
-	{}
-};
-
-static const struct iio_chan_spec stm32_lptim_cnt_channels = {
-	.type = IIO_COUNT,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_ENABLE) |
-			      BIT(IIO_CHAN_INFO_SCALE),
-	.ext_info = stm32_lptim_cnt_ext_info,
-	.indexed = 1,
-};
-
 /**
  * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
  * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
  * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
+ *
+ * In non-quadrature mode, device counts up on active edge.
+ * In quadrature mode, encoder counting scenarios are as follows:
+ * +---------+----------+--------------------+--------------------+
+ * | Active  | Level on |      IN1 signal    |     IN2 signal     |
+ * | edge    | opposite +----------+---------+----------+---------+
+ * |         | signal   |  Rising  | Falling |  Rising  | Falling |
+ * +---------+----------+----------+---------+----------+---------+
+ * | Rising  | High ->  |   Down   |    -    |   Up     |    -    |
+ * | edge    | Low  ->  |   Up     |    -    |   Down   |    -    |
+ * +---------+----------+----------+---------+----------+---------+
+ * | Falling | High ->  |    -     |   Up    |    -     |   Down  |
+ * | edge    | Low  ->  |    -     |   Down  |    -     |   Up    |
+ * +---------+----------+----------+---------+----------+---------+
+ * | Both    | High ->  |   Down   |   Up    |   Up     |   Down  |
+ * | edges   | Low  ->  |   Up     |   Down  |   Down   |   Up    |
+ * +---------+----------+----------+---------+----------+---------+
  */
 enum stm32_lptim_cnt_function {
 	STM32_LPTIM_COUNTER_INCREASE,
@@ -484,7 +262,7 @@ static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
-	return stm32_lptim_cnt_get_ceiling(priv, buf);
+	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
 }
 
 static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
@@ -493,8 +271,22 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 					     const char *buf, size_t len)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
+	unsigned int ceiling;
+	int ret;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	ret = kstrtouint(buf, 0, &ceiling);
+	if (ret)
+		return ret;
+
+	if (ceiling > STM32_LPTIM_MAX_ARR)
+		return -EINVAL;
+
+	priv->ceiling = ceiling;
 
-	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
+	return len;
 }
 
 static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
@@ -630,32 +422,19 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_lptim_cnt *priv;
-	struct iio_dev *indio_dev;
-	int ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
-	if (!indio_dev)
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	priv = iio_priv(indio_dev);
 	priv->dev = &pdev->dev;
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->ceiling = STM32_LPTIM_MAX_ARR;
 
-	/* Initialize IIO device */
-	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.of_node = pdev->dev.of_node;
-	indio_dev->info = &stm32_lptim_cnt_iio_info;
-	if (ddata->has_encoder)
-		indio_dev->channels = &stm32_lptim_enc_channels;
-	else
-		indio_dev->channels = &stm32_lptim_cnt_channels;
-	indio_dev->num_channels = 1;
-
 	/* Initialize Counter device */
 	priv->counter.name = dev_name(&pdev->dev);
 	priv->counter.parent = &pdev->dev;
@@ -673,10 +452,6 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	ret = devm_iio_device_register(&pdev->dev, indio_dev);
-	if (ret)
-		return ret;
-
 	return devm_counter_register(&pdev->dev, &priv->counter);
 }
 
-- 
2.7.4

