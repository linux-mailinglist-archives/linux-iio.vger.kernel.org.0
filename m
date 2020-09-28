Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBC27AA5B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgI1JKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 05:10:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10432 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbgI1JKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 05:10:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S959gE023963;
        Mon, 28 Sep 2020 05:10:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg5xpq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:10:33 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08S9AWri012306
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 05:10:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 28 Sep
 2020 05:10:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 05:10:26 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08S9ANjX026287;
        Mon, 28 Sep 2020 05:10:29 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 3/5] iio: adc: ad7768-1: Add channel labels.
Date:   Mon, 28 Sep 2020 12:09:57 +0300
Message-ID: <20200928090959.88842-3-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928090959.88842-1-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_07:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=970
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For better identification of the channels.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0e93b0766eb4..5c0cbee03230 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -161,6 +161,7 @@ struct ad7768_state {
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
+	const char *labels[ARRAY_SIZE(ad7768_channels)];
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
 
@@ -532,6 +542,33 @@ static void ad7768_clk_disable(void *data)
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
@@ -604,6 +641,10 @@ static int ad7768_probe(struct spi_device *spi)
 
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

