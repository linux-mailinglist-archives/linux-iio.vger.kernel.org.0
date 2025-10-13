Return-Path: <linux-iio+bounces-25026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5324BD1CDC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2A624EC635
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AB2EB87F;
	Mon, 13 Oct 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1cAWaJy5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E22EB5A3;
	Mon, 13 Oct 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340567; cv=none; b=A//0wNJejzgcddw1YzLL5NjAbTP41kGnk0Dy6EAo8Al/DwpmYvIeaJb9sZ3EpJxy98G+4eNjUA7OfyZTWsPZQ5857B5LepfidUbAC11JnuolyLReRU+gys81EOdNbauyMdCgOOzJso1NQxMDClXfYv6yOhRnTAxgI4AbrDw2QhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340567; c=relaxed/simple;
	bh=dyOykNjCpkuKNDTwkALUI9US4XThjJvrY0/a5gAPTGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fc3c53QI6ynPyYmBngnN97KoSv5evBX5bp8nCp6K3ZWeOtY8vNyqohzrHKtSk9jAG4QK57KAZQMXwLHHrD1eVMCI46BEYxpilBNLSR9W6CoZjjGdizkHJv+FTMWkXqRfz+7RjROEhkIjDN7X9Bp9gALz6NL7uK1sChO1ATJZKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1cAWaJy5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4wFos015805;
	Mon, 13 Oct 2025 03:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j8EZw
	hv5M0qbEm6QYGwoCH/56egOqqjohUInDLSxezU=; b=1cAWaJy5fjC6m/DjBkJpD
	fzuY0UNhRqJGri11zFo8bf0L7hrxxJ8qhypwyqKFhW2wNm4l2jcZcrb8HYKCCWkO
	3kJ/SOybW9WVwZ2HYIfDHyKDVJBv/rUXEErAmZGlali9i4BNN0JwI9u9yO5LH5HU
	KKDWo5TuV3Jrge5SpqI4huIVJryKmAmVufL4dTYqx+XVjmu6NJYQ55LvHKw3Qsjs
	26kyv2zdDBkIaz8fb2jz22l4lSyBVmZX15v7hjzC0VPovzOPgBRGlrUgQKkgPiCC
	ksRLSr6SuLdvVrYfHjwUF1wN/2FEb1intVwvX0vJoUyPwduuXSMeyTBn0+J1NRr4
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qh30gx0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:29:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59D7TA2H062941
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:29:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Oct
 2025 03:29:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:29:10 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZD013800;
	Mon, 13 Oct 2025 03:29:02 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:28:05 +0200
Subject: [PATCH 7/7] iio: adc: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-7-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=14047;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=dyOykNjCpkuKNDTwkALUI9US4XThjJvrY0/a5gAPTGw=;
 b=qzMT7mVJE2Nl3Vza2wNFADb9Z3YGqvT2NaF8+4q+tZaUhMdZp1iGStSSA9z9WMnB1CAvXUZ6u
 gDpujzM6dbfA/NfZT1q/dsvHs7sqFktshdNZYuXz2PE/GCEwhlh686+
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZezwGP691u-myRl1GMj4hTCZyo-L1axs
X-Proofpoint-GUID: ZezwGP691u-myRl1GMj4hTCZyo-L1axs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyOSBTYWx0ZWRfX1fRZCOAcVRGj
 LAPejQ8JPoPcL3JOuarwr/yp7yp4eP4Jk9hJ0p1ihyhfTg5b2ECzXToxN0GxPCR6l8JNXQcaca7
 ou+ySESdZPXLqZpcpGT7ptfj9H140LGqTYN6karT8sLyDKtIWX5TvcyiNLwGlQ0/y8PCG16d5nG
 PzVMyz6zLv9CtJ1D16nXxzLqi30Y0i+8MHCkNelVQkQR7fNIwTV8dH6dRDuF25KriZfrXBprlHm
 1flJIDy3Fhsj6zQJ7cqe4RoR3ieWfzORBovq/isABIuCvK6LwuUN06iySVFOPAgkco1kpWnVZmK
 Aw9uA4tliFyRMlyqelVEZ2zMh9QaC2JmBWwnE/sp7eJWeYCXElikulIMPiFm8RWi9TCjgYFMu7W
 NKdzl5RLE0lyUIOONv9iul18LPC/Aw==
X-Authority-Analysis: v=2.4 cv=YscChoYX c=1 sm=1 tr=0 ts=68ecaa48 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=vWLHQQzp_VqV2la2RWoA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110029

Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
Either signal, if not present, fallback to an I3C IBI with the same
role.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4062.c | 351 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 347 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 40b7c10b8ce7145b010bb11e8e4698baacb6b3d3..b5b12f81c71b52f244600ed23dad11253290b868 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -13,6 +13,7 @@
 #include <linux/i3c/device.h>
 #include <linux/i3c/master.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -172,6 +173,8 @@ struct ad4062_state {
 	struct i3c_device *i3cdev;
 	struct regmap *regmap;
 	u16 sampling_frequency;
+	u16 events_frequency;
+	bool wait_event;
 	int vref_uv;
 	u8 raw[4] __aligned(IIO_DMA_MINALIGN);
 };
@@ -202,6 +205,26 @@ static const struct regmap_access_table ad4062_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4062_regmap_wr_ranges),
 };
 
+static const struct iio_event_spec ad4062_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static const char *const ad4062_conversion_freqs[] = {
 	"2000000", "1000000", "300000", "100000",	/*  0 -  3 */
 	"33300", "10000", "3000", "500",		/*  4 -  7 */
@@ -263,6 +286,8 @@ AD4062_EXT_INFO(AD4062_2MSPS);
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.event_spec = ad4062_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4062_events),					\
 	.has_ext_scan_type = 1,								\
 	.ext_scan_type = ad4062_scan_type_##bits##_s,					\
 	.num_ext_scan_type = ARRAY_SIZE(ad4062_scan_type_##bits##_s),			\
@@ -285,6 +310,82 @@ static const struct ad4062_chip_info ad4062_chip_info = {
 	.grade = AD4062_2MSPS,
 };
 
+/**
+ * A register access will cause the device to drop from monitor mode
+ * into configuration mode, update the state to reflect that.
+ */
+static void ad4062_exit_monitor_mode(struct ad4062_state *st)
+{
+	if (st->wait_event) {
+		pm_runtime_mark_last_busy(&st->i3cdev->dev);
+		pm_runtime_put_autosuspend(&st->i3cdev->dev);
+		st->wait_event = 0;
+	}
+}
+
+static ssize_t ad4062_events_frequency_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%s\n", ad4062_conversion_freqs[st->events_frequency]);
+}
+
+static ssize_t ad4062_events_frequency_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
+
+	ret = __sysfs_match_string(AD4062_FS(st->chip->grade),
+				   AD4062_FS_LEN(st->chip->grade), buf);
+	if (ret < 0)
+		goto out_release;
+
+	st->events_frequency = ret;
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644, ad4062_events_frequency_show,
+		       ad4062_events_frequency_store, 0);
+
+static ssize_t sampling_frequency_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret = 0;
+
+	for (u8 i = AD4062_FS_OFFSET(st->chip->grade);
+	     i < AD4062_FS_LEN(st->chip->grade); i++)
+		ret += sysfs_emit_at(buf, ret, "%s ", ad4062_conversion_freqs[i]);
+
+	ret += sysfs_emit_at(buf, ret, "\n");
+	return ret;
+}
+
+static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
+
+static struct attribute *ad4062_event_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad4062_event_attribute_group = {
+	.attrs = ad4062_event_attributes,
+};
+
 static int ad4062_set_oversampling_ratio(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 unsigned int val)
@@ -431,6 +532,19 @@ static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 				  val);
 }
 
+static irqreturn_t ad4062_irq_handler_thresh(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ad4062_irq_handler_drdy(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -449,10 +563,18 @@ static void ad4062_ibi_handler(struct i3c_device *i3cdev,
 {
 	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
 
-	if (iio_buffer_enabled(st->indio_dev))
-		iio_trigger_poll(st->trigger);
-	else
-		complete(&st->completion);
+	if (st->wait_event) {
+		iio_push_event(st->indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(st->indio_dev));
+	} else {
+		if (iio_buffer_enabled(st->indio_dev))
+			iio_trigger_poll(st->trigger);
+		else
+			complete(&st->completion);
+	}
 }
 
 static irqreturn_t ad4062_poll_handler(int irq, void *p)
@@ -523,6 +645,24 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	struct device *dev = &st->i3cdev->dev;
 	int ret;
 
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
+	if (ret >= 0) {
+		ret = devm_request_threaded_irq(dev, ret, NULL,
+						ad4062_irq_handler_thresh,
+						IRQF_ONESHOT, indio_dev->name,
+						indio_dev);
+		if (ret)
+			return ret;
+	} else if (ret != -EPROBE_DEFER) {
+		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
+					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
+					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
+		if (ret)
+			return ret;
+	} else {
+		return ret;
+	}
+
 	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
 	if (ret >= 0) {
 		ret = devm_request_threaded_irq(dev, ret, NULL,
@@ -734,6 +874,7 @@ static int ad4062_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long info)
 {
+	struct ad4062_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (info == IIO_CHAN_INFO_SCALE)
@@ -741,6 +882,7 @@ static int ad4062_read_raw(struct iio_dev *indio_dev,
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
 
 	ret = ad4062_read_raw_dispatch(indio_dev, chan, val, val2, info);
 
@@ -768,10 +910,12 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long info)
 {
+	struct ad4062_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
 
 	ret = ad4062_write_raw_dispatch(indio_dev, chan, val, val2, info);
 
@@ -779,6 +923,196 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
+{
+	int ret = 0;
+
+	if (!enable)
+		goto out_suspend;
+
+	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
+	if (ret)
+		goto out_suspend;
+
+	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
+	if (ret)
+		goto out_suspend;
+
+	return ret;
+out_suspend:
+	pm_runtime_put_autosuspend(&st->i3cdev->dev);
+	return ret;
+}
+
+static int ad4062_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+
+	return st->wait_event;
+}
+
+static int ad4062_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event == state) {
+		ret = 0;
+		goto out_release;
+	}
+
+	ret = ad4062_monitor_mode_enable(st, state);
+	if (!ret)
+		st->wait_event = state;
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int __ad4062_read_event_info_value(struct ad4062_state *st,
+					   enum iio_event_direction dir, int *val)
+{
+	int ret;
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_LIMIT;
+	else
+		reg = AD4062_REG_MIN_LIMIT;
+
+	ret = regmap_bulk_read(st->regmap, reg, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(get_unaligned_be16(st->raw), 11);
+
+	return 0;
+}
+
+static int __ad4062_read_event_info_hysteresis(struct ad4062_state *st,
+						enum iio_event_direction dir, int *val)
+{
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_HYST;
+	else
+		reg = AD4062_REG_MIN_HYST;
+	return regmap_read(st->regmap, reg, val);
+}
+
+static int ad4062_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = __ad4062_read_event_info_value(st, dir, val);
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = __ad4062_read_event_info_hysteresis(st, dir, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : IIO_VAL_INT;
+}
+
+static int __ad4062_write_event_info_value(struct ad4062_state *st,
+					   enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val > 2047 || val < -2048)
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_LIMIT;
+	else
+		reg = AD4062_REG_MIN_LIMIT;
+	put_unaligned_be16(val, &st->raw);
+
+	return regmap_bulk_write(st->regmap, reg, &st->raw, 2);
+}
+
+static int __ad4062_write_event_info_hysteresis(struct ad4062_state *st,
+						enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val >= BIT(7))
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4062_REG_MAX_HYST;
+	else
+		reg = AD4062_REG_MIN_HYST;
+
+	return regmap_write(st->regmap, reg, val);
+}
+
+static int ad4062_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val,
+				    int val2)
+{
+	struct ad4062_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = __ad4062_write_event_info_value(st, dir, val);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = __ad4062_write_event_info_hysteresis(st, dir, val);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
 static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad4062_state *st = iio_priv(indio_dev);
@@ -788,6 +1122,7 @@ static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
 	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
 	if (ret)
 		return ret;
+	ad4062_exit_monitor_mode(st);
 
 	ret = ad4062_set_operation_mode(st, st->mode);
 	if (ret)
@@ -833,6 +1168,7 @@ static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	ad4062_exit_monitor_mode(st);
 
 	if (readval)
 		ret = regmap_read(st->regmap, reg, readval);
@@ -857,6 +1193,11 @@ static const struct iio_info ad4062_info = {
 	.read_raw = ad4062_read_raw,
 	.write_raw = ad4062_write_raw,
 	.read_avail = ad4062_read_avail,
+	.read_event_config = &ad4062_read_event_config,
+	.write_event_config = &ad4062_write_event_config,
+	.read_event_value = &ad4062_read_event_value,
+	.write_event_value = &ad4062_write_event_value,
+	.event_attrs = &ad4062_event_attribute_group,
 	.get_current_scan_type = &ad4062_get_current_scan_type,
 	.debugfs_reg_access = &ad4062_debugfs_reg_access,
 };
@@ -932,8 +1273,10 @@ static int ad4062_probe(struct i3c_device *i3cdev)
 				     "Failed to initialize regmap\n");
 
 	st->mode = AD4062_SAMPLE_MODE;
+	st->wait_event = false;
 	st->chip = chip;
 	st->sampling_frequency = AD4062_FS_OFFSET(st->chip->grade);
+	st->events_frequency = AD4062_FS_OFFSET(st->chip->grade);
 	st->indio_dev = indio_dev;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.49.0


