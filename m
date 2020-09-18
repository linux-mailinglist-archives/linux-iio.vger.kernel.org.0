Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5026FB13
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIRLCD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 07:02:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19080 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIRLCD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 07:02:03 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I9TbKn029171;
        Fri, 18 Sep 2020 05:34:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p69ws1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 05:34:05 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08I9Y4Dt051002
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Sep 2020 05:34:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 18 Sep
 2020 05:34:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 18 Sep 2020 05:34:09 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08I9Y18P024038;
        Fri, 18 Sep 2020 05:34:02 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v5] iio: adc: ad7768-1: Add channel label example
Date:   Fri, 18 Sep 2020 12:33:56 +0300
Message-ID: <20200918093356.93670-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_11:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180079
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a demo usage of new "label" attribute for channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in V5:
Create a separate patch file for this commit
 drivers/iio/adc/ad7768-1.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0d132708c429..5ca9f9febb5a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -161,6 +161,7 @@ struct ad7768_state {
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
+	const char **labels;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -407,6 +408,14 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7768_read_label(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, char *label)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return sprintf(label, "%s\n", st->labels[chan->channel]);
+}
+
 static struct attribute *ad7768_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
@@ -420,6 +429,7 @@ static const struct iio_info ad7768_info = {
 	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
 	.write_raw = &ad7768_write_raw,
+	.read_label = ad7768_read_label,
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
@@ -538,6 +548,41 @@ static void ad7768_clk_disable(void *data)
 	clk_disable_unprepare(st->mclk);
 }
 
+static int ad7768_set_channel_label(struct iio_dev *indio_dev,
+						int num_channels)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+	struct device *device = indio_dev->dev.parent;
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	const char *label;
+	int crt_ch = 0;
+
+	st->labels = devm_kcalloc(indio_dev->dev.parent,
+					num_channels,
+					sizeof(**st->labels),
+					GFP_KERNEL);
+
+	if (!st->labels)
+		return -ENOMEM;
+
+	fwnode = dev_fwnode(device);
+	fwnode_for_each_child_node(fwnode, child) {
+		if (fwnode_property_read_u32(child, "reg", &crt_ch))
+			continue;
+
+		if (crt_ch >= num_channels)
+			continue;
+
+		if (fwnode_property_read_string(child, "label", &label))
+			continue;
+
+		st->labels[crt_ch] = label;
+	}
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
@@ -611,6 +656,10 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
+	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&spi->dev, spi->irq,
 			       &ad7768_interrupt,
 			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
2.17.1

