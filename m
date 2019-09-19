Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA6B7CF8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfISOgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 10:36:18 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:53892 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732581AbfISOgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 10:36:18 -0400
Received: (qmail 13298 invoked by uid 5089); 19 Sep 2019 14:36:16 -0000
Received: by simscan 1.2.0 ppid: 13273, pid: 13274, t: 0.0366s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@118.208.174.34)
  by anchovy2.45ru.net.au with ESMTPA; 19 Sep 2019 14:36:16 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id D6BD2201AF903; Thu, 19 Sep 2019 22:36:11 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH v2 2/2] iio: core: Add optional symbolic label to device attributes
Date:   Thu, 19 Sep 2019 22:36:08 +0800
Message-Id: <1568903768-65998-3-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this device add that
to the device specific attributes. This is useful for userspace to
be able to identify an individual device when multiple identical
chips are present in the system.

Tested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/industrialio-core.c | 17 +++++++++++++++++
 include/linux/iio/iio.h         |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 524a686077ca..f72c2dc5f703 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1238,6 +1238,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
 
+static ssize_t iio_show_dev_label(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->label);
+}
+
+static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
+
 static ssize_t iio_show_timestamp_clock(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -1354,6 +1364,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 
 	if (indio_dev->name)
 		attrcount++;
+	if (indio_dev->label)
+		attrcount++;
 	if (clk)
 		attrcount++;
 
@@ -1376,6 +1388,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
 	if (indio_dev->name)
 		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+	if (indio_dev->label)
+		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
 	if (clk)
 		indio_dev->chan_attr_group.attrs[attrn++] = clk;
 
@@ -1647,6 +1661,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
 
+	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
+					   NULL);
+
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8e132cf819e4..a2527c7ab934 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -553,6 +553,7 @@ struct iio_dev {
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
 	const char			*name;
+	const char			*label;
 	const struct iio_info		*info;
 	clockid_t			clock_id;
 	struct mutex			info_exist_lock;
-- 
1.8.3.1

