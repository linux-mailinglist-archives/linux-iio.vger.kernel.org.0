Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0A9DC22
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 05:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH0DxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 23:53:22 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:43830 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfH0DxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2019 23:53:22 -0400
Received: (qmail 16245 invoked by uid 5089); 27 Aug 2019 03:53:20 -0000
Received: by simscan 1.2.0 ppid: 16184, pid: 16187, t: 0.0333s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 27 Aug 2019 03:53:19 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id D04832021C4D0; Tue, 27 Aug 2019 11:35:28 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH 2/2] iio: core: Add optional symbolic label to device attributes
Date:   Tue, 27 Aug 2019 11:35:24 +0800
Message-Id: <1566876924-63608-3-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined in the device tree for this device add that
to the device specific attributes. This is useful for userspace to
be able to identify an individual device when multiple identical
chips are present in the system.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/industrialio-core.c | 17 +++++++++++++++++
 include/linux/iio/iio.h         |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8303639963d7..2d7fb7629095 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1300,6 +1300,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
 
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
@@ -1416,6 +1426,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 
 	if (indio_dev->name)
 		attrcount++;
+	if (indio_dev->label)
+		attrcount++;
 	if (clk)
 		attrcount++;
 
@@ -1438,6 +1450,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
 	if (indio_dev->name)
 		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+	if (indio_dev->label)
+		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
 	if (clk)
 		indio_dev->chan_attr_group.attrs[attrn++] = clk;
 
@@ -1709,6 +1723,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
 
+	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
+					   NULL);
+
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a74cb177dc6f..3f89db50d3f6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -556,6 +556,7 @@ struct iio_dev {
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
 	const char			*name;
+	const char			*label;
 	const struct iio_info		*info;
 	clockid_t			clock_id;
 	struct mutex			info_exist_lock;
-- 
1.8.3.1

