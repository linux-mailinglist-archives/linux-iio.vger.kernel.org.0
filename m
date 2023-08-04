Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9620770391
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjHDOv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjHDOvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 10:51:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06649C3
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 07:51:21 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 374Cdd0E028523;
        Fri, 4 Aug 2023 10:51:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8qabv3v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 10:51:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 374EpG1F038424
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 10:51:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Aug 2023
 10:51:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 10:51:15 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 374Ep87h010508;
        Fri, 4 Aug 2023 10:51:13 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 1/3] iio: addac: add new converter framework
Date:   Fri, 4 Aug 2023 16:53:39 +0200
Message-ID: <20230804145342.1600136-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804145342.1600136-1-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: lc8RRxQGhuYJdQz71zuK7JcRfNbby4ZK
X-Proofpoint-GUID: lc8RRxQGhuYJdQz71zuK7JcRfNbby4ZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/addac/converter.c       | 547 ++++++++++++++++++++++++++++
 include/linux/iio/addac/converter.h | 485 ++++++++++++++++++++++++
 2 files changed, 1032 insertions(+)
 create mode 100644 drivers/iio/addac/converter.c
 create mode 100644 include/linux/iio/addac/converter.h

diff --git a/drivers/iio/addac/converter.c b/drivers/iio/addac/converter.c
new file mode 100644
index 000000000000..31ac704255ad
--- /dev/null
+++ b/drivers/iio/addac/converter.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Framework to handle complex IIO aggregate devices
+ *
+ * A note on some of the design expectations with regards to lifetimes and
+ * devices bringup/removal.
+ *
+ * The Framework is using, under the wood, the component API which makes it to
+ * easy treat a bunch of devices as one aggregate device. This means that the
+ * complete thing is only brought to live when all the deviced are probed. To do
+ * this, two callbacks are used that should in fact completely replace .probe()
+ * and .remove(). The formers should only be used the minimum needed. Ideally,
+ * only to call the functions to add and remove frontend annd backend devices.
+ *
+ * It is advised for frontend and backend drivers to use their .remove()
+ * callbacks (to use devres API during the frontend and backends initialization).
+ * See the comment in @converter_frontend_bind().
+ *
+ * It is also assumed that converter objects cannot be accessed once one of the
+ * devices of the aggregate device is removed (effectively bringing the all the
+ * devices down). Based on that assumption, these objects are not refcount which
+ * means accessing them will likely fail miserably.
+ *
+ * Copyright (C) 2023 Analog Devices Inc.
+ */
+
+#define dev_fmt(fmt) "Converter - " fmt
+
+#include <linux/component.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/addc/converter.h>
+#include <linux/iio/iio.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+struct converter_backend {
+	struct list_head entry;
+	struct device *dev;
+	const struct converter_ops *ops;
+	const char *name;
+	void *drvdata;
+
+	struct regmap *regmap;
+	unsigned int cached_reg_addr;
+};
+
+struct converter_frontend {
+	struct list_head list;
+	const struct frontend_ops *ops;
+	struct device *dev;
+};
+
+static ssize_t converter_debugfs_read_reg(struct file *file,
+					  char __user *userbuf,
+					  size_t count, loff_t *ppos)
+{
+	struct converter_backend *conv = file->private_data;
+	unsigned int val = 0;
+	char read_buf[20];
+	int ret, len;
+
+	ret = regmap_read(conv->regmap, conv->cached_reg_addr, &val);
+	if (ret) {
+		dev_err(conv->dev, "%s: read failed\n", __func__);
+		return ret;
+	}
+
+	len = scnprintf(read_buf, sizeof(read_buf), "0x%X\n", val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, read_buf, len);
+}
+
+static ssize_t converter_debugfs_write_reg(struct file *file,
+					   const char __user *userbuf,
+					   size_t count, loff_t *ppos)
+{
+	struct converter_backend *conv = file->private_data;
+	unsigned int val;
+	char buf[80];
+	ssize_t rc;
+	int ret;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
+	if (rc < 0)
+		return rc;
+
+	ret = sscanf(buf, "%i %i", &conv->cached_reg_addr, &val);
+
+	switch (ret) {
+	case 1:
+		break;
+	case 2:
+		ret = regmap_write(conv->regmap, conv->cached_reg_addr, val);
+		if (ret) {
+			dev_err(conv->dev, "%s: write failed\n", __func__);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations converter_debugfs_reg_fops = {
+	.open = simple_open,
+	.read = converter_debugfs_read_reg,
+	.write = converter_debugfs_write_reg,
+};
+
+static void __converter_add_direct_reg_access(struct converter_backend *conv,
+					      struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	const char *name = conv->name;
+	char file_name[64];
+
+	if (!conv->regmap)
+		return;
+	if (!d)
+		return;
+
+	if (!conv->name)
+		name = "converter";
+
+	snprintf(file_name, sizeof(file_name), "%s_direct_reg_access", name);
+
+	debugfs_create_file(file_name, 0644, d, conv,
+			    &converter_debugfs_reg_fops);
+}
+
+void converter_add_direct_reg_access(struct converter_backend *conv,
+				     struct iio_dev *indio_dev)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		__converter_add_direct_reg_access(conv, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(converter_add_direct_reg_access, IIO_CONVERTER);
+
+static int converter_bind(struct device *dev, struct device *aggregate,
+			  void *data)
+{
+	struct converter_frontend *frontend = dev_get_drvdata(aggregate);
+	struct converter_backend *conv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = conv->ops->backend_init(conv, dev);
+	if (ret)
+		return ret;
+
+	list_add_tail(&conv->entry, &frontend->list);
+
+	return 0;
+}
+
+static void converter_unbind(struct device *dev, struct device *aggregate,
+			     void *data)
+{
+	struct converter_backend *conv = dev_get_drvdata(dev);
+
+	if (conv->ops->backend_close)
+		conv->ops->backend_close(conv);
+
+	/* after this point the converter should not be used anymore */
+	converter_set_drvdata(conv, NULL);
+}
+
+static const struct component_ops converter_component_ops = {
+	.bind = converter_bind,
+	.unbind = converter_unbind,
+};
+
+static int converter_frontend_bind(struct device *dev)
+{
+	struct converter_frontend *frontend = dev_get_drvdata(dev);
+	int ret;
+
+	ret = component_bind_all(dev, NULL);
+	if (ret)
+		return ret;
+	/*
+	 * We open a new group so that we can control when resources are
+	 * released and still use device managed (devm_) calls. The expectations
+	 * are that on probe, backend resources are allocated first followed by
+	 * the frontend resources (where registering the IIO device must happen)
+	 * Naturally we want the reverse order on the unbind path and that would
+	 * not be possible without opening our own devres group.
+
+	 * Note that the component API also opens it's own devres group when
+	 * calling the .bind() callbacks for both the aggregate device
+	 * (our frontend) and each of the components (our backends). On the
+	 * unbind path, the aggregate .unbind() function is called
+	 * (@converter_frontend_unbind()) which should be responsible to tear
+	 * down all the components (effectively releasing all the resources
+	 * allocated on each component devres group) and only then the aggregate
+	 * devres group is released. Hence, the order we want to maintain for
+	 * releasing resources would not be satisfied because backend resources
+	 * would be freed first. With our own group, we can control when
+	 * releasing the resources and we do it before @component_unbind_all().
+	 *
+	 * This also relies that internally the component API is releasing each
+	 * of the component's devres group. That is likely not to change, but
+	 * maybe we should not trust it and also open our own groups for backend
+	 * devices?!
+	 *
+	 * Another very important thing to keep in mind is that this is only
+	 * valid if frontend and backend driver's are implementing their
+	 * .remove() callback to call @converter_frontend_del() and
+	 * @converter_backend_del(). Calling those functions from
+	 * devm_add_action* and use devm APIs in .frontend_init() and
+	 * .backend_init() is not going to work. Not perfect but still better
+	 * than having to tear everything down in .frontend_close() and
+	 * .backend_close()
+	 */
+	if (!devres_open_group(dev, frontend, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = frontend->ops->frontend_init(frontend, dev);
+	if (ret) {
+		devres_release_group(dev, frontend);
+		return ret;
+	}
+
+	devres_close_group(dev, NULL);
+	return 0;
+}
+
+static void converter_frontend_unbind(struct device *dev)
+{
+	struct converter_frontend *frontend = dev_get_drvdata(dev);
+
+	if (frontend->ops->frontend_close)
+		frontend->ops->frontend_close(frontend);
+
+	devres_release_group(dev, frontend);
+	component_unbind_all(dev, NULL);
+	list_del_init(&frontend->list);
+}
+
+static const struct component_master_ops frontend_component_ops = {
+	.bind = converter_frontend_bind,
+	.unbind = converter_frontend_unbind,
+};
+
+struct converter_backend *converter_get(const struct converter_frontend *frontend,
+					const char *name)
+{
+	struct converter_backend *iter, *conv = NULL;
+	struct device *dev = frontend->dev;
+	struct fwnode_handle *fwnode;
+	int index = 0;
+
+	if (list_empty(&frontend->list)) {
+		dev_err(dev, "Backend list is empty...\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	/* if no name given, we assume only one converter_backend exists */
+	if (!name)
+		return list_first_entry(&frontend->list,
+					struct converter_backend, entry);
+
+	index = device_property_match_string(frontend->dev, "converter-names",
+					     name);
+	if (index < 0)
+		return ERR_PTR(index);
+
+	fwnode = fwnode_find_reference(dev_fwnode(dev), "converters", index);
+	if (IS_ERR(fwnode))
+		return ERR_CAST(fwnode);
+
+	list_for_each_entry(iter, &frontend->list, entry) {
+		if (device_match_fwnode(iter->dev, fwnode)) {
+			conv = iter;
+			break;
+		}
+	}
+
+	fwnode_handle_put(fwnode);
+
+	if (!conv) {
+		dev_err(dev, "Converter (%s) not found in the list\n", name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	/* See if we can add device_property_string_read_index() */
+	conv->name = kstrdup_const(name, GFP_KERNEL);
+	if (!conv->name)
+		return ERR_PTR(-ENOMEM);
+
+	return conv;
+}
+EXPORT_SYMBOL_NS_GPL(converter_get, IIO_CONVERTER);
+
+static int converter_frontend_add_matches(struct converter_frontend *frontend,
+					  struct component_match **match)
+{
+	struct device *dev = frontend->dev;
+	struct fwnode_handle *fwnode;
+	int index = 0;
+
+	do {
+		fwnode = fwnode_find_reference(dev_fwnode(dev), "converters",
+					       index);
+		if (IS_ERR(fwnode))
+			break;
+
+		component_match_add_release(dev, match,
+					    component_release_fwnode,
+					    component_compare_fwnode, fwnode);
+		index++;
+	} while (true);
+
+	/* no devices?! */
+	if (!index) {
+		dev_err(dev, "No converters. Make sure the \"converters\" property is given!\n");
+		return -ENODEV;
+	}
+
+	if (PTR_ERR(fwnode) != -ENOENT)
+		return PTR_ERR(fwnode);
+
+	return 0;
+}
+
+int converter_test_pattern_set(struct converter_backend *conv,
+			       unsigned int chan,
+			       enum converter_test_pattern pattern)
+{
+	if (pattern >= CONVERTER_TEST_PATTERN_MAX)
+		return -EINVAL;
+	if (!conv->ops->test_pattern_set)
+		return -ENOTSUPP;
+
+	return conv->ops->test_pattern_set(conv, chan, pattern);
+}
+EXPORT_SYMBOL_NS_GPL(converter_test_pattern_set, IIO_CONVERTER);
+
+int converter_chan_status_get(struct converter_backend *conv,
+			      unsigned int chan,
+			      struct converter_chan_status *status)
+{
+	if (!conv->ops->chan_status)
+		return -ENOTSUPP;
+
+	return conv->ops->chan_status(conv, chan, status);
+}
+EXPORT_SYMBOL_NS_GPL(converter_chan_status_get, IIO_CONVERTER);
+
+int converter_iodelay_set(struct converter_backend *conv,
+			  unsigned int num_lanes, unsigned int delay)
+{
+	if (!num_lanes)
+		return -EINVAL;
+	if (!conv->ops->iodelay_set)
+		return -ENOTSUPP;
+
+	return conv->ops->iodelay_set(conv, num_lanes, delay);
+}
+EXPORT_SYMBOL_NS_GPL(converter_iodelay_set, IIO_CONVERTER);
+
+int converter_data_format_set(struct converter_backend *conv,
+			      unsigned int chan,
+			      const struct converter_data_fmt *data)
+{
+	if (data->type >= CONVERTER_DATA_TYPE_MAX)
+		return -EINVAL;
+	if (!conv->ops->data_format_set)
+		return -ENOTSUPP;
+
+	return conv->ops->data_format_set(conv, chan, data);
+}
+EXPORT_SYMBOL_NS_GPL(converter_data_format_set, IIO_CONVERTER);
+
+int converter_sample_edge_select(struct converter_backend *conv,
+				 enum converter_edge edge)
+{
+	if (edge >= CONVERTER_EDGE_MAX)
+		return -EINVAL;
+	if (conv->ops->sample_edge_select)
+		return -ENOTSUPP;
+
+	return conv->ops->sample_edge_select(conv, edge);
+}
+EXPORT_SYMBOL_NS_GPL(converter_sample_edge_select, IIO_CONVERTER);
+
+int converter_chan_enable(struct converter_backend *conv, unsigned int chan)
+{
+	if (!conv->ops->chan_enable)
+		return -ENOTSUPP;
+
+	return conv->ops->chan_enable(conv, chan);
+}
+EXPORT_SYMBOL_NS_GPL(converter_chan_enable, IIO_CONVERTER);
+
+int converter_chan_disable(struct converter_backend *conv, unsigned int chan)
+{
+	if (!conv->ops->disable)
+		return -ENOTSUPP;
+
+	return conv->ops->chan_disable(conv, chan);
+}
+EXPORT_SYMBOL_NS_GPL(converter_chan_disable, IIO_CONVERTER);
+
+int converter_enable(struct converter_backend *conv)
+{
+	if (!conv->ops->enable)
+		return -ENOTSUPP;
+
+	return conv->ops->enable(conv);
+}
+EXPORT_SYMBOL_NS_GPL(converter_enable, IIO_CONVERTER);
+
+void converter_disable(struct converter_backend *conv)
+{
+	if (!conv->ops->disable)
+		return;
+
+	conv->ops->disable(conv);
+}
+EXPORT_SYMBOL_NS_GPL(converter_disable, IIO_CONVERTER);
+
+int __converter_test_pattern_xlate(unsigned int pattern,
+				   const struct converter_test_pattern_xlate *xlate,
+				   int n_matches)
+{
+	unsigned int p = n_matches;
+
+	while (p--) {
+		if (pattern == xlate[p].pattern)
+			return xlate[p].reg_val;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(__converter_test_pattern_xlate, IIO_CONVERTER);
+
+void converter_set_regmap(struct converter_backend *conv,
+			  struct regmap *regmap)
+{
+	conv->regmap = regmap;
+}
+EXPORT_SYMBOL_NS_GPL(converter_set_regmap, IIO_CONVERTER);
+
+void converter_set_drvdata(struct converter_backend *conv, void *drvdata)
+{
+	conv->drvdata = drvdata;
+}
+EXPORT_SYMBOL_NS_GPL(converter_set_drvdata, IIO_CONVERTER);
+
+void *converter_get_drvdata(const struct converter_backend *conv)
+{
+	WARN_ON(!conv->drvdata);
+	return conv->drvdata;
+}
+EXPORT_SYMBOL_NS_GPL(converter_get_drvdata, IIO_CONVERTER);
+
+void converter_del(struct device *dev)
+{
+	component_del(dev, &converter_component_ops);
+}
+EXPORT_SYMBOL_NS_GPL(converter_del, IIO_CONVERTER);
+
+static void converter_free(void *conv)
+{
+	struct converter_backend *__conv = conv;
+
+	if (__conv->name)
+		kfree_const(__conv->name);
+
+	kfree(__conv);
+}
+
+int converter_add(struct device *dev, const struct converter_ops *ops)
+{
+	struct converter_backend *conv;
+	int ret;
+
+	if (!ops || !ops->backend_init)
+		return -EINVAL;
+
+	conv = kzalloc(sizeof(*conv), GFP_KERNEL);
+	if (!conv)
+		return -ENOMEM;
+
+	/*
+	 * The expectation is that everything goes up and down in
+	 * .converter_bind() and .converter_unbind() respectively. Hence, it's
+	 * not expected for converter objects to be accessed after unbind(). As
+	 * soon as that does not stand anymore, we need to
+	 * drop devm_add_action_or_reset() and properly refcount the objects.
+	 */
+	ret = devm_add_action_or_reset(dev, converter_free, conv);
+	if (ret)
+		return ret;
+
+	conv->ops = ops;
+	dev_set_drvdata(dev, conv);
+	conv->dev = dev;
+
+	return component_add(dev, &converter_component_ops);
+}
+EXPORT_SYMBOL_NS_GPL(converter_add, IIO_CONVERTER);
+
+void converter_frontend_del(struct device *dev)
+{
+	component_master_del(dev, &frontend_component_ops);
+}
+EXPORT_SYMBOL_NS_GPL(converter_frontend_del, IIO_CONVERTER);
+
+int converter_frontend_add(struct device *dev, const struct frontend_ops *ops)
+{
+	struct converter_frontend *frontend;
+	struct component_match *match;
+	int ret;
+
+	if (!ops || !ops->frontend_init) {
+		dev_err(dev, "Mandatory ops missing\n");
+		return -EINVAL;
+	}
+
+	frontend = devm_kzalloc(dev, sizeof(*frontend), GFP_KERNEL);
+	if (!frontend)
+		return -ENOMEM;
+
+	frontend->ops = ops;
+	frontend->dev = dev;
+	INIT_LIST_HEAD(&frontend->list);
+	dev_set_drvdata(dev, frontend);
+
+	ret = converter_frontend_add_matches(frontend, &match);
+	if (ret)
+		return ret;
+
+	return component_master_add_with_match(dev, &frontend_component_ops,
+					       match);
+}
+EXPORT_SYMBOL_NS_GPL(converter_frontend_add, IIO_CONVERTER);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/addac/converter.h b/include/linux/iio/addac/converter.h
new file mode 100644
index 000000000000..09d9d491b2b8
--- /dev/null
+++ b/include/linux/iio/addac/converter.h
@@ -0,0 +1,485 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _CONVERTER_H
+#define _CONVERTER_H
+
+struct converter_frontend;
+struct converter_backend;
+struct iio_dev;
+struct device;
+struct regmap;
+
+enum converter_test_pattern {
+	CONVERTER_PRBS_7,
+	CONVERTER_PRBS_15,
+	CONVERTER_PRBS_23,
+	CONVERTER_PRBS_31,
+	CONVERTER_RAMP_NIBBLE,
+	CONVERTER_RAMP_16,
+	/* vendor specific from 32 */
+	CONVERTER_ADI_PRBS_9A = 32,
+	CONVERTER_ADI_PRBS_23A,
+	CONVERTER_ADI_PRBS_X,
+	CONVERTER_TEST_PATTERN_MAX
+};
+
+enum converter_data_type {
+	CONVERTER_TWOS_COMPLEMENT,
+	CONVERTER_OFFSET_BINARY,
+	CONVERTER_DATA_TYPE_MAX
+};
+
+enum converter_edge {
+	CONVERTER_RISING_EDGE_SAMPLE,
+	CONVERTER_FALLING_EDGE_SAMPLE,
+	CONVERTER_EDGE_MAX
+};
+
+struct converter_chan_status {
+	bool errors;
+};
+
+/**
+ * struct converter_data_fmt - Backend data format
+ * @type:		Data type.
+ * @sign_extend:	Bool to tell if the data is sign extended.
+ * @enable:		Enable/Disable the data format module. If disabled,
+ *			not formatting will happen.
+ */
+struct converter_data_fmt {
+	enum converter_data_type type;
+	bool sign_extend;
+	bool enable;
+};
+
+/**
+ * struct converter_test_pattern_xlate - Helper struct for test pattern handling
+ * @pattern:	Pattern to configure.
+ * @reg_val:	Register value for the pattern to configure.
+ */
+struct converter_test_pattern_xlate {
+	enum converter_test_pattern pattern;
+	unsigned int reg_val;
+};
+
+/**
+ * struct converter_ops - Backend supported operations
+ * @backend_init:	Mandatory function to initialize the backend device. It
+ *			should be a replacement for .probe() where the latest
+ *			should only have to care about doing @converter_add().
+ * @backend_close:	Optional function to tear down the device.
+ * @enable:		Enable the backend device.
+ * @disable:		Disable the backend device.
+ * @data_format_set:	Configure the data format for a specific channel.
+ * @chan_enable:	Enable one channel.
+ * @chan_disable:	Disable one channel.
+ * @iodelay_set:	Controls the IO delay for all the lanes at the interface
+ *			(where data is actually transferred between frontend and
+			backend) level.
+ * @test_pattern_set:	Set's a test pattern to be transmitted/received by the
+ *			backend. Typically useful for debug or interface
+ *			purposes calibration.
+ */
+struct converter_ops {
+	int (*backend_init)(struct converter_backend *conv, struct device *dev);
+	void (*backend_close)(struct converter_backend *conv);
+	int (*enable)(struct converter_backend *conv);
+	void (*disable)(struct converter_backend *conv);
+	int (*data_format_set)(struct converter_backend *conv,
+			       unsigned int chan,
+			       const struct converter_data_fmt *data);
+	int (*chan_enable)(struct converter_backend *conv, unsigned int chan);
+	int (*chan_disable)(struct converter_backend *conv, unsigned int chan);
+	int (*iodelay_set)(struct converter_backend *conv,
+			   unsigned int num_lanes, unsigned int delay);
+	int (*test_pattern_set)(struct converter_backend *conv,
+				unsigned int chan,
+				enum converter_test_pattern pattern);
+	int (*chan_status)(struct converter_backend *conv, unsigned int chan,
+			   struct converter_chan_status *status);
+	int (*sample_edge_select)(struct converter_backend *conv,
+				  enum converter_edge edge);
+};
+
+/**
+ * struct frontend_ops - Frontend supported operations
+ * @frontend_init:	Mandatory function to initialize the frontend device. It
+ *			should be a replacement for .probe() where the latest
+ *			should only have to care about doing @frontend_add().
+ * @frontend_close:	Optional function to tear down the device.
+ */
+struct frontend_ops {
+	int (*frontend_init)(struct converter_frontend *frontend,
+			     struct device *dev);
+	void (*frontend_close)(struct converter_frontend *frontend);
+};
+
+/**
+ * converter_test_pattern_xlate() - Helper macro for translatting test patterns
+ * @pattern:	Pattern to translate.
+ * @xlate:	List of @struct converter_test_pattern_xlate pairs.
+ *
+ * Simple helper to match a supported pattern and get the register value. Should
+ * only be called by backend devices. Automatically computes the number of
+ * @xlate entries.
+ */
+#define converter_test_pattern_xlate(pattern, xlate)	\
+	__converter_test_pattern_xlate(pattern, xlate, ARRAY_SIZE(xlate));
+
+#if IS_ENABLED(CONFIG_IIO_CONVERTER)
+
+/**
+ * converter_get_drvdata - Get driver private data
+ * @conv:	Converter device.
+ */
+void *converter_get_drvdata(const struct converter_backend *conv);
+
+/**
+ * converter_set_drvdata - Set driver private data
+ * @conv:	Converter device.
+ * @drvdata:	Driver private data.
+ */
+void converter_set_drvdata(struct converter_backend *conv, void *drvdata);
+
+/**
+ * converter_set_regmap - Add a regmap object to a converter
+ * @conv:	Converter device.
+ * @regmap:	Regmap object.
+ */
+void converter_set_regmap(struct converter_backend *conv,
+			  struct regmap *regmap);
+
+/**
+ * __converter_test_pattern_xlate - Helper macro for translatting test patterns
+ * @pattern:	Pattern to translate.
+ * @xlate:	List of @struct converter_test_pattern_xlate pairs.
+ * @n_matches:	Number of entries in @xlate.
+ *
+ * Simple helper to match a supported pattern and get the register value. Should
+ * only be called by backend devices.
+ */
+int __converter_test_pattern_xlate(unsigned int pattern,
+				   const struct converter_test_pattern_xlate *xlate,
+				   int n_matches);
+
+/**
+ *
+ */
+int converter_add(struct device *dev, const struct converter_ops *ops);
+
+/**
+ * converter_del - Remove the converter device
+ * @dev:	device to remove from the aggregate
+ *
+ * Removes the converter from the aggregate device. This tears down the frontend
+ * and all the converters.
+ *
+ * Ideally, this should be called from the backend driver .remove() callback.
+ * This means that all the converters (and the frontend) will be tear down before
+ * running any specific devres cleanup (at the driver core level). What this all
+ * means is that we can use devm_ apis in @backend_init() and being sure those
+ * resources will be released after the backend resources and before any devm_*
+ * used in @probe(). If that is not the case, one should likely not use any
+ * devm_ API in @backend_init(). That means .backend_close() should be
+ * provided to do all the necessary cleanups.
+ */
+void converter_del(struct device *dev);
+
+/**
+ * converter_enable - Enable the device
+ * @conv:	Converter device.
+ *
+ * Enables the backend device.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_enable(struct converter_backend *conv);
+
+/**
+ * converter_disable - Disable the device
+ * @conv:	Converter device.
+ *
+ * Disables the backend device.
+ */
+void converter_disable(struct converter_backend *conv);
+
+/**
+ * converter_test_pattern_set - Set a test pattern
+ * @conv:	Converter device.
+ * @chan:	Channel number.
+ * @pattern:	Pattern to set.
+ *
+ * Set's a test pattern to be transmitted/received by the backend. Typically
+ * useful for debug or interface calibration purposes. A backend driver can
+ * call the @converter_test_pattern_xlate() helper to validate the pattern
+ * (given an array of @struct converter_test_pattern_xlate).
+ *
+ * Note that some patterns might be frontend specific. I.e, as far as the
+ * backend is concerned the pattern is valid (from a register point of view) but
+ * the actual support for the pattern is not implemented in the device for this
+ * specific frontend. It's up to the frontend to ask for a proper pattern
+ * (as it should know better).
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_test_pattern_set(struct converter_backend *conv,
+			       unsigned int chan,
+			       enum converter_test_pattern pattern);
+
+int converter_chan_status_get(struct converter_backend *conv,
+			      unsigned int chan,
+			      struct converter_chan_status *status);
+
+/**
+ * converter_data_format_set - Configure the data format
+ * @conv:	Converter device.
+ * @chan:	Channel number.
+ * @data:	Data format.
+ *
+ * Properly configure a channel with respect to the expected data format. A
+ * @struct converter_data_fmt must be passed with the settings.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_data_format_set(struct converter_backend *conv,
+			      unsigned int chan,
+			      const struct converter_data_fmt *data);
+
+int converter_sample_edge_select(struct converter_backend *conv,
+				 enum converter_edge edge);
+
+static inline int
+converter_sample_on_falling_edge(struct converter_backend *conv)
+{
+	return converter_sample_edge_select(conv, CONVERTER_RISING_EDGE_SAMPLE);
+}
+
+static inline int
+converter_sample_on_rising_edge(struct converter_backend *conv)
+{
+	return converter_sample_edge_select(conv, CONVERTER_FALLING_EDGE_SAMPLE);
+}
+
+/**
+ * converter_chan_enable - Enable a backend channel
+ * @conv:	Converter device.
+ * @chan:	Channel number.
+ *
+ * Enables a channel on the backend device.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_chan_enable(struct converter_backend *conv, unsigned int chan);
+
+/**
+ * converter_chan_disable - Disable a backend channel
+ * @conv:	Converter device.
+ * @chan:	Channel number.
+ *
+ * Disables a channel on the backend device.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_chan_disable(struct converter_backend *conv, unsigned int chan);
+
+/**
+ * converter_iodelay_set - Set's the backend data interface IO delay
+ * @conv:	Converter device.
+ * @num_lanes:	Number of lanes in the data interface.
+ * @delay:	Delay to set.
+ *
+ * Controls the IO delay for all the lanes at the data interface (where data is
+ * actually transferred between frontend and backend) level.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_iodelay_set(struct converter_backend *conv,
+			  unsigned int num_lanes, unsigned int delay);
+
+/**
+ * converter_frontend_del - Remove the frontend device
+ * @dev:	Device to remove from the aggregate
+ *
+ * Removes the frontend from the aggregate device. This tears down the frontend
+ * and all the converters.
+ *
+ * Ideally, this should be called from the frontend driver .remove() callback.
+ * This means that all the converters (and the frontend) will be tear down
+ * before running any specific devres cleanup (at the driver core level). What
+ * this all means is that we can use devm_ apis in .frontend_init() and being
+ * sure those resources will be released after the backend resources and before
+ * any devm_* used in .probe(). If that is not the case, one should likely not
+ * use any devm_ API in .frontend_init(). That means .frontend_close() should be
+ * provided to do all the necessary cleanups.
+ */
+void converter_frontend_del(struct device *dev);
+
+/**
+ * converter_frontend_add - Allocate and add a frontend device
+ * @dev:	Device to allocate frontend for.
+ * @ops:	Frontend callbacks.
+ *
+ * This allocates the frontend device and looks for all converters needed
+ * so that, when they are available, all of the devices in the aggregate can be
+ * initialized.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int converter_frontend_add(struct device *dev, const struct frontend_ops *ops);
+
+/**
+ * converter_get - Get a converter object
+ * @frontend:	Frontend device.
+ * @name:	Converter name.
+ *
+ * Get's a pointer to a converter device. If name is NULL, then it is assumed
+ * that only one backend device is bond with the frontend and the first element
+ * in the list is retrieved. Should only be called from the .frontend_init()
+ * callback.
+ *
+ * RETURNS:
+ * A converter pointer, negative error pointer otherwise.
+ */
+struct converter_backend *__must_check
+converter_get(const struct converter_frontend *frontend, const char *name);
+
+/**
+ * converter_add_direct_reg_access - Add debugfs direct register access
+ * @conv: Coverter device
+ * @indio_dev: IIO device
+ *
+ * This is analogous to the typical IIO direct register access in debugfs. The
+ * extra converter file will be added in the same debugs dir as @indio_dev.
+ * Moreover, if @conv->name is NULL, the file will be called
+ * converter_direct_reg_access. Otherwise, will be
+ * @conv->name_converter_direct_reg_access.
+ */
+void converter_add_direct_reg_access(struct converter_backend *conv,
+				     struct iio_dev *indio_dev);
+
+#else
+
+static inline void *converter_get_drvdata(const struct converter_backend *conv)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return NULL;
+}
+
+static inline void converter_set_drvdata(struct converter_backend *conv,
+					 void *drvdata)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+static inline void converter_set_regmap(struct converter_backend *conv,
+					struct regmap *regmap)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+static inline int
+__converter_test_pattern_xlate(unsigned int pattern,
+			       const struct converter_test_pattern_xlate *xlate,
+			       int n_matches)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline struct converter_backend *__must_check
+converter_get(const struct converter_frontend *frontend, const char *name)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline int converter_add(struct device *dev,
+				const struct converter_ops *ops)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline void converter_del(struct device *dev)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+static inline int converter_enable(struct converter_backend *conv)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline void converter_disable(struct converter_backend *conv)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+static inline int
+converter_test_pattern_set(struct converter_backend *conv,
+			   unsigned int chan,
+			   enum converter_test_pattern pattern)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline int
+converter_data_format_set(struct converter_backend *conv,
+			  unsigned int chan,
+			  const struct converter_data_fmt *data)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline int converter_chan_enable(struct converter_backend *conv,
+					unsigned int chan)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline int converter_chan_disable(struct converter_backend *conv,
+					 unsigned int chan)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline int converter_iodelay_set(struct converter_backend *conv,
+					unsigned int num_lanes,
+					unsigned int val)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline void
+converter_add_direct_reg_access(struct converter_backend *conv,
+				struct iio_dev *indio_dev)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+static inline int converter_frontend_add(struct device *dev,
+					 const struct frontend_ops *ops)
+{
+	WARN_ONCE(1, "converter API is disabled");
+	return -ENOTSUPP;
+}
+
+static inline void converter_frontend_del(struct device *dev)
+{
+	WARN_ONCE(1, "converter API is disabled");
+}
+
+#endif
+#endif
-- 
2.41.0

