Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC44A26CC7D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgIPUnn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 16:43:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15518 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbgIPRD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:03:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GD9Md5010152;
        Wed, 16 Sep 2020 09:21:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33k5p62hn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 09:21:21 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08GDLKNh029875
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 16 Sep 2020 09:21:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 16 Sep 2020 09:21:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 16 Sep 2020 09:21:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 16 Sep 2020 09:21:27 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08GDLGMe026529;
        Wed, 16 Sep 2020 09:21:17 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v4 1/3] iio: core: Add optional symbolic label to a device channel
Date:   Wed, 16 Sep 2020 16:21:15 +0300
Message-ID: <20200916132115.81795-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_07:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this channel add that
to the channel specific attributes. This is useful for userspace to
be able to identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Change in V4:
	- Check for callback before generating file system for label
	- Add documentation in: Documentation/ABI/testing/sysfs-bus-iio
	- Add example of usage for channel label attribute
 drivers/iio/industrialio-core.c | 41 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  6 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1527f01a44f1..49868e080840 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -643,6 +643,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 }
 EXPORT_SYMBOL_GPL(iio_format_value);
 
+static ssize_t iio_read_channel_label(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (indio_dev->info->read_label)
+		return indio_dev->info->read_label(indio_dev,
+							this_attr->c,
+							buf);
+	else
+		return -EINVAL;
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1111,6 +1126,25 @@ int __iio_add_chan_devattr(const char *postfix,
 	return ret;
 }
 
+static int iio_device_add_channel_label(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	ret = __iio_add_chan_devattr("label",
+					chan,
+					&iio_read_channel_label,
+					NULL,
+					0,
+					IIO_SEPARATE,
+					&indio_dev->dev,
+					&indio_dev->channel_attr_list);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1241,6 +1275,13 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	if (indio_dev->info->read_label) {
+		ret = iio_device_add_channel_label(indio_dev, chan);
+		if (ret < 0)
+			return ret;
+		attrcount += ret;
+	}
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..58b151f5321d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -362,6 +362,8 @@ struct iio_trigger; /* forward declaration */
  *			and max. For lists, all possible values are enumerated.
  * @write_raw:		function to write a value to the device.
  *			Parameters are the same as for read_raw.
+ * @read_label:		function to request label name for a specified label,
+ *			for better channel identification.
  * @write_raw_get_fmt:	callback function to query the expected
  *			format/precision. If not set by the driver, write_raw
  *			returns IIO_VAL_INT_PLUS_MICRO.
@@ -420,6 +422,10 @@ struct iio_info {
 			 int val2,
 			 long mask);
 
+	int (*read_label)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 char *label);
+
 	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 long mask);
-- 
2.17.1


From 1e6dc76e6574c5b74e0ce22ba0e91d2e47aa8699 Mon Sep 17 00:00:00 2001
From: Cristian Pop <cristian.pop@analog.com>
Date: Wed, 16 Sep 2020 14:35:59 +0000
Subject: [PATCH v4 2/3] iio:Documentation: Add documentation for label channel
 attribute

If a label is defined in the device tree for this channel add that to the
channel specific attributes. This is useful for userspace to be able to
identify an individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331..f2a9a03b8af9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1697,6 +1697,15 @@ Description:
 
 		Raw counter device counters direction for channel Y.
 
+What:		/sys/bus/iio/devices/iio:deviceX/channel_label
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label to a device channel.
+		If a label is defined in the device tree for this channel add
+		that to the channel specific attributes. This is useful for
+		userspace to be able to identify an individual channel.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
-- 
2.17.1


From c6cf59857fb3001ad831bc49ab7fce6c7a9e48ff Mon Sep 17 00:00:00 2001
From: Cristian Pop <cristian.pop@analog.com>
Date: Wed, 16 Sep 2020 15:19:57 +0000
Subject: [PATCH v4 3/3] iio: adc: ad7768-1: Add channel label example

This is a demo usage of new "label" attribute for channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
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

