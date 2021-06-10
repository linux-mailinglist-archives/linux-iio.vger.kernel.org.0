Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF53A2BE3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFJMsU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:48:20 -0400
Received: from aposti.net ([89.234.176.197]:54540 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhFJMsS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 08:48:18 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] iio: core: Add "extended_name" attribute to all channels
Date:   Thu, 10 Jun 2021 13:45:56 +0100
Message-Id: <20210610124556.34507-3-paul@crapouillou.net>
In-Reply-To: <20210610124556.34507-1-paul@crapouillou.net>
References: <20210610124556.34507-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The point of this new attribute is to make the IIO tree actually
parsable.

Before, given this attribute as a filename:
in_voltage0_aux_sample_rate

Userspace had no way to know if the attribute name was
"aux_sample_rate" with no extended name, or "sample_rate" with "aux" as
the extended name, or just "rate" with "aux_sample" as the extended
name.

This was somewhat possible to deduce when there was more than one
attribute present for a given channel, e.g:
in_voltage0_aux_sample_rate
in_voltage0_aux_frequency

There, it was possible to deduce that "aux" was the extended name. But
even with more than one attribute, this wasn't very robust, as two
attributes starting with the same prefix (e.g. "sample_rate" and
"sample_size") would result in the first part of the prefix being
interpreted as being part of the extended name.

To address this issue, add an "extended_name" attribute to all channels
that actually do have an extended name. For this attribute, the extended
name is not present in the filename; so in this example, the file name
would be "in_voltage0_extended_name", and reading it would return "aux".

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/industrialio-core.c | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ec34d930920c..4cdf9f092d73 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -723,6 +723,16 @@ static ssize_t iio_read_channel_label(struct device *dev,
 	return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
 }
 
+static ssize_t iio_read_channel_extended_name(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	const struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	const struct iio_chan_spec *chan = this_attr->c;
+
+	return sprintf(buf, "%s\n", chan->extend_name);
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1185,6 +1195,32 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 	return 1;
 }
 
+static int
+iio_device_add_channel_extended_name(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	int ret;
+
+	if (!chan->extend_name)
+		return 0;
+
+	ret = __iio_add_chan_devattr("extended_name",
+				     chan,
+				     &iio_read_channel_extended_name,
+				     NULL,
+				     0,
+				     IIO_SEPARATE,
+				     &indio_dev->dev,
+				     NULL,
+				     &iio_dev_opaque->channel_attr_list,
+				     false);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1327,6 +1363,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_channel_extended_name(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 		for (ext_info = chan->ext_info; ext_info->name; ext_info++) {
-- 
2.30.2

