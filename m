Return-Path: <linux-iio+bounces-25025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C3BD1CD0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AC4EC53C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562E2EB5CD;
	Mon, 13 Oct 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ilwXTA6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898952EAB6F;
	Mon, 13 Oct 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340566; cv=none; b=cB3cDcAn5SXMgiLVc52jT0ooH+Icrhq9//D0i4AB07Qr1Imk8Cc3yu7o6K5rbSsEej0tYcXn3k8kc9HDUacXBzNeG5krdDiYZLb1/pE6hj0Jd1X7vAEHAcoAElADZ/nTgQHrQregrUO5TWIwfXg61k0sOOnU8Y16zWa/RN/dSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340566; c=relaxed/simple;
	bh=xgj0EtOdtC80DF4Ws10dApUbk6Fw8rfDPxgLygx7MjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=caxSftfwHFHnLJfTpeB4fDyhVwO38nBst9DXZa9VfyBaY3gNx6Xwxho64ch5sdEVHxZxEuxp13qsQvWTcoJyWAIGOIv6KisTeu9VPKmnyyNXgF2O9GjR4GsNoKjS4nlnPN2dlnBVZvDKJjYvyA2xo1tfGMNqfhFb6Cn5g0jkmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ilwXTA6k; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D5ZJdn015613;
	Mon, 13 Oct 2025 03:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IC62L
	DYVtx7VWM7eJNrKl5wTRKuh53qUxfCfRQdIwvo=; b=ilwXTA6kKA7dwx96+OBKT
	LzbKmIp4CeUkbWP0Wk6OyFRtNukNLynmmeifXjcLhK8r7Mosw+RvbtCVnKRWd2Aa
	HXXjHDt7pHFyPedZWITdDfEUnjqG1q5LpyaOx5Vm8sl/AdQzB+rN0seqLoLQgGEX
	9rPg9JRb5CeJGdHYuNSLmVfnRtHfqm6kN2LGkMpZe/nle6vvYZjH2Lj+j/OpI6ET
	XM7L+3+VXYzT+DdCd6vlBIG5sDHEegw+ob6Y5eRWjr0Ay4Mulg+bfoXW33liA3Jl
	Ot/A4KZ0xJbATeKoUCLHxR0nbkPTJmJvbAQyXXCI1rddJse9og5r1Zt4+39nwKGZ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qh30gx06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:29:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59D7T71Z062930
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:29:07 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:29:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:29:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:29:07 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZB013800;
	Mon, 13 Oct 2025 03:28:58 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:28:03 +0200
Subject: [PATCH 5/7] iio: adc: ad4062: Add IIO Trigger support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-5-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=6103;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=xgj0EtOdtC80DF4Ws10dApUbk6Fw8rfDPxgLygx7MjA=;
 b=1Q25hNTDmQ8cwT2iLWNpLbIITaWTjMT5dqt4ZkRb9sNc4uejj/X0PrKNkmwzEJFPhC6Zm32Ga
 wZsZKSkCPPCAYOCSijxTM/5/vW3FhCNE7y/12evEwZQWI8AifJ+pVQK
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PQU4ZzcBXJ8CuNlx1vRwAKnk0FO0FUAy
X-Proofpoint-GUID: PQU4ZzcBXJ8CuNlx1vRwAKnk0FO0FUAy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyOSBTYWx0ZWRfXyj93wL4f9jvO
 YMBrzetXOPZhRLIOKKPc2xwa0SK1O1NYg8MiNhmzl+BG4iJArjXHZy/sbm3cUmBcqvRvCFNYs/w
 iStFs3SALM2QI7oUlwyT7HAc6P4vOx0RMw87MX30vw4WC5PWB7k/LYDC4FN/Vp9jUJsfSQX3bay
 02E308tGK915W37iwDcHzt7+3Gd2mTleC1Hv/CPQBldbnIXV1hpevBA4Eyvn13xH0QQEUseykYL
 kjgwqua4MwYO6FaN7yucDU5wPfQoWU+Oj2jy2TxmeKRtlpV9iEYHdGluVNFTsRhsF35ESwrXxr7
 u+RDVIPXl2Um/z5lFbZ0McRRLT8o12ansMQceOH0ULwRIUuHOi1H1lJlBYUsI1lKeMOMHAhRju7
 TQf0z4osDZBs6xR5ks+gfRiwyR+8/Q==
X-Authority-Analysis: v=2.4 cv=YscChoYX c=1 sm=1 tr=0 ts=68ecaa44 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=oA80kLhoCsWfn7L3hZIA:9
 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110029

Adds support for IIO Trigger. Optionally, gp1 is assigned as Data Ready
signal, if not present, fallback to an I3C IBI with the same role.
The software trigger is allocated by the device, but must be attached by
the user before enabling the buffer. The purpose is to not impede
removing the driver due to the increased reference count when
iio_trigger_set_immutable or iio_trigger_get is used.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4062.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 490c01d701bdd1543809cdefad4ed5573c051c24..c7c17f7e04a2f93664ddad3d37875079a9d5ab24 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -74,6 +74,8 @@ config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
 	select REGMAP_I3C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4062 I3C analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index e55a69c62694a71a4e29f29b9a2bfeec3b16c990..40b7c10b8ce7145b010bb11e8e4698baacb6b3d3 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -12,8 +12,12 @@
 #include <linux/err.h>
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/math.h>
@@ -432,7 +436,10 @@ static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ad4062_state *st = iio_priv(indio_dev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		iio_trigger_poll_nested(st->trigger);
+	else
+		complete(&st->completion);
 
 	return IRQ_HANDLED;
 }
@@ -442,7 +449,49 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
-	complete(&st->completion);
+	if (iio_buffer_enabled(st->indio_dev))
+		iio_trigger_poll(st->trigger);
+	else
+		complete(&st->completion);
+}
+
+static irqreturn_t ad4062_poll_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4062_state *st = iio_priv(indio_dev);
+	u8 addr = AD4062_REG_CONV_TRIGGER;
+	int ret;
+
+	/* Read current and trigger next conversion */
+	struct i3c_priv_xfer t[2] = {
+		{
+			.data.in = &st->raw,
+			.len = 4,
+			.rnw = true,
+		},
+		{
+			.data.out = &addr,
+			.len = 1,
+			.rnw = false,
+		}
+	};
+
+	/* Separated transfers to not infeer repeated-start */
+	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[0], 1);
+	if (ret)
+		goto out;
+	ret = i3c_device_do_priv_xfers(st->i3cdev, &t[1], 1);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->raw,
+					   pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
 }
 
 static int ad4062_request_ibi(struct i3c_device *i3cdev)
@@ -489,6 +538,27 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static const struct iio_trigger_ops ad4062_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static int ad4062_request_trigger(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->i3cdev->dev;
+
+	st->trigger = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					     indio_dev->name,
+					     iio_device_id(indio_dev));
+	if (!st->trigger)
+		return -ENOMEM;
+
+	st->trigger->ops = &ad4062_trigger_ops;
+	iio_trigger_set_drvdata(st->trigger, indio_dev);
+
+	return devm_iio_trigger_register(dev, st->trigger);
+}
+
 static const int ad4062_oversampling_avail[] = {
 	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
 };
@@ -709,6 +779,52 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	u8 addr = AD4062_REG_CONV_TRIGGER;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4062_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_mode_error;
+
+	/* Trigger first conversion */
+	struct i3c_priv_xfer t = {
+		.data.out = &addr,
+		.len = 1,
+		.rnw = false,
+	};
+
+	ret = i3c_device_do_priv_xfers(st->i3cdev, &t, 1);
+	if (ret)
+		goto out_mode_error;
+	return 0;
+
+out_mode_error:
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+
+	return ret;
+}
+
+static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	pm_runtime_mark_last_busy(&st->i3cdev->dev);
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4062_triggered_buffer_setup_ops = {
+	.postenable = &ad4062_triggered_buffer_postenable,
+	.predisable = &ad4062_triggered_buffer_predisable,
+};
+
 static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 				     unsigned int writeval, unsigned int *readval)
 {
@@ -843,6 +959,17 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 	if (ret)
 		return ret;
 
+	ret = ad4062_request_trigger(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&i3cdev->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ad4062_poll_handler,
+					      &ad4062_triggered_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)

-- 
2.49.0


