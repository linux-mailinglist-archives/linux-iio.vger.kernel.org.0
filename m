Return-Path: <linux-iio+bounces-21506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D6AFFBB4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8378017700A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C728BAB3;
	Thu, 10 Jul 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj4gC0/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0828B50E;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134791; cv=none; b=LBhcv8kjV1n4k/W6qdBTbWTLRKqAILmSgfKxBZAjQb2YLP4UqCmUGA1OgzunteOJCScqVtTjR9IpL62SHPyPRAc9cn71RJHr2gKU3AtM94ByL+tS/sdzgGYMmw9KniktslN7RczwUxKDR4z6EHewkcVBqXAxzjttufBGgvQMBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134791; c=relaxed/simple;
	bh=HEhZOrDen9GDQYkFTc80pO2Gobam8W9J62fqtXHgtNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hfy0l10zDZcp/odD1f7ioSPjIEMbLb+CWOfaqjnBAOyvnrhHobfDkcUaK7O5PzOD+f9fT9EOe93uWAnGoT53KTJNBx2ea1MWVuGjYg9wt1gna7kYOBiR+PVRDmjWAjs8khz8sQUbM+J7zpipS3txfNfNd9d6B1mnmFg/vGt5Zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj4gC0/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC778C4CEFA;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134790;
	bh=HEhZOrDen9GDQYkFTc80pO2Gobam8W9J62fqtXHgtNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uj4gC0/NYXW7pDdZdsIqYwAt5c6p3O7F2CK7ODWTjn90g1Lm5fA15BDumOBoDg6Ds
	 OS3FuHXVTbQfIam/TdiFbUxcVoGaDm1E4qFK6lp++UO8zsKWHlLypzT6ZB3rWfqSz+
	 4jZh4tej13iyxGtdcEduI1aUADXTz8VvFWY89JjM/XLo6I/NZ6Qet9YTI1AzUQ3ZD0
	 pNa6Kyjjg3zx8VdT7xLQFZQ53UK/nDBAJuWyUMTQ6guaF1Y6JAzhMfIqDHCBj8XN/x
	 e4+mv2Zc4qwmUiJGiK15hF8ncNA2/2Kcju9tyIvX4k7Iuz4Npz+Qo2TWECNott0M4S
	 Y8YSJiubhSuig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0874C83F1D;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Date: Thu, 10 Jul 2025 09:06:28 +0100
Subject: [PATCH v2 2/4] net: qrtr: Turn QRTR into a bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-qcom-smgr-v2-2-f6e198b7aa8e@protonmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
In-Reply-To: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752134788; l=13409;
 i=y.oudjana@protonmail.com; s=20250710; h=from:subject:message-id;
 bh=BEz6+mix/8Ro0NQY01YjtawBe2jefM7XH43H8tm5Dq0=;
 b=ZDD7byeRJ8P7n1x5fcHYw0FIO6mXnZSRcIFKOXREqnDhvllF1YWmSobf1UgfrvgPVyLND0lZi
 bmtBMlnztH3AhJIiiI618QFd6ecKVy7Y4L+QzqeFTU1eqPRyEJcTMJD
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=kZKEHR1e5QKCbhElU9LF/T1SbfTr8xzy2cO8fN70QgY=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20250710 with
 auth_id=455
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

From: Yassine Oudjana <y.oudjana@protonmail.com>

Implement a QRTR bus to allow for creating drivers for individual QRTR
services. With this in place, devices are dynamically registered for QRTR
services as they become available, and drivers for these devices are
matched using service and instance IDs.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 include/linux/mod_devicetable.h   |   9 ++
 include/linux/soc/qcom/qrtr.h     |  36 +++++++
 net/qrtr/af_qrtr.c                |  23 +++-
 net/qrtr/qrtr.h                   |   3 +
 net/qrtr/smd.c                    | 218 +++++++++++++++++++++++++++++++++++++-
 scripts/mod/devicetable-offsets.c |   4 +
 scripts/mod/file2alias.c          |  10 ++
 7 files changed, 297 insertions(+), 6 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 6077972e8b45de3d07881c0226459d815dd1f83d..23c6a1a4bca54f871c78765f8d5401cca5c1e6eb 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -549,6 +549,15 @@ struct spmi_device_id {
 	kernel_ulong_t driver_data;	/* Data private to the driver */
 };
 
+#define QRTR_NAME_SIZE	32
+#define QRTR_MODULE_PREFIX "qrtr:"
+
+struct qrtr_device_id {
+	__u16 service;
+	__u16 instance;
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
 /* dmi */
 enum dmi_field {
 	DMI_NONE,
diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrtr.h
new file mode 100644
index 0000000000000000000000000000000000000000..e9249d9422b8ca96baa43073cf07c4a75c163219
--- /dev/null
+++ b/include/linux/soc/qcom/qrtr.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __QCOM_QRTR_H__
+#define __QCOM_QRTR_H__
+
+#include <linux/mod_devicetable.h>
+
+struct qrtr_device {
+	struct device dev;
+	unsigned int node;
+	unsigned int port;
+	u16 service;
+	u16 instance;
+};
+
+#define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
+
+struct qrtr_driver {
+	int (*probe)(struct qrtr_device *qdev);
+	void (*remove)(struct qrtr_device *qdev);
+	const struct qrtr_device_id *id_table;
+	struct device_driver driver;
+};
+
+#define to_qrtr_driver(d) container_of(d, struct qrtr_driver, driver)
+
+#define qrtr_driver_register(drv) __qrtr_driver_register(drv, THIS_MODULE)
+
+int __qrtr_driver_register(struct qrtr_driver *drv, struct module *owner);
+void qrtr_driver_unregister(struct qrtr_driver *drv);
+
+#define module_qrtr_driver(__qrtr_driver) \
+	module_driver(__qrtr_driver, qrtr_driver_register, \
+			qrtr_driver_unregister)
+
+#endif /* __QCOM_QRTR_H__ */
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00c51cf693f3d054f1771de5246498bf013775d0..e11682fd796083a9866527824faf428affba19bc 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -435,6 +435,7 @@ static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 {
 	struct qrtr_node *node = ep->node;
+	const struct qrtr_ctrl_pkt *pkt;
 	const struct qrtr_hdr_v1 *v1;
 	const struct qrtr_hdr_v2 *v2;
 	struct qrtr_sock *ipc;
@@ -443,6 +444,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	size_t size;
 	unsigned int ver;
 	size_t hdrlen;
+	int ret = 0;
 
 	if (len == 0 || len & 3)
 		return -EINVAL;
@@ -516,12 +518,24 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 	qrtr_node_assign(node, cb->src_node);
 
+	pkt = data + hdrlen;
+
 	if (cb->type == QRTR_TYPE_NEW_SERVER) {
 		/* Remote node endpoint can bridge other distant nodes */
-		const struct qrtr_ctrl_pkt *pkt;
-
-		pkt = data + hdrlen;
 		qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
+
+		/* Create a QRTR device */
+		ret = ep->add_device(ep, le32_to_cpu(pkt->server.node),
+					       le32_to_cpu(pkt->server.port),
+					       le32_to_cpu(pkt->server.service),
+					       le32_to_cpu(pkt->server.instance));
+		if (ret)
+			goto err;
+	} else if (cb->type == QRTR_TYPE_DEL_SERVER) {
+		/* Remove QRTR device corresponding to service */
+		ret = ep->del_device(ep, le32_to_cpu(pkt->server.port));
+		if (ret)
+			goto err;
 	}
 
 	if (cb->type == QRTR_TYPE_RESUME_TX) {
@@ -543,8 +557,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 err:
 	kfree_skb(skb);
-	return -EINVAL;
-
+	return ret ? ret : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_post);
 
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index 3f2d28696062a56201f8774ee50fd1c3daa50708..6590483367304b97239de939d4f0206aac52c527 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -19,6 +19,9 @@ struct sk_buff;
  */
 struct qrtr_endpoint {
 	int (*xmit)(struct qrtr_endpoint *ep, struct sk_buff *skb);
+	int (*add_device)(struct qrtr_endpoint *parent, unsigned int node, unsigned int port,
+			  u16 service, u16 instance);
+	int (*del_device)(struct qrtr_endpoint *parent, unsigned int port);
 	/* private: not for endpoint use */
 	struct qrtr_node *node;
 };
diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
index 940ee9349a9ce7438a01dd193c5c1d61c7b82ffd..40fd32fa0890799a88b947b2b7bc00c2249dea0d 100644
--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/rpmsg.h>
+#include <linux/soc/qcom/qrtr.h>
 
 #include "qrtr.h"
 
@@ -16,6 +17,197 @@ struct qrtr_smd_dev {
 	struct device *dev;
 };
 
+struct qrtr_new_server {
+	struct qrtr_smd_dev *parent;
+	unsigned int node;
+	unsigned int port;
+	u16 service;
+	u16 instance;
+
+	struct work_struct work;
+};
+
+struct qrtr_del_server {
+	struct qrtr_smd_dev *parent;
+	unsigned int port;
+
+	struct work_struct work;
+};
+
+static int qcom_smd_qrtr_device_match(struct device *dev, const struct device_driver *drv)
+{
+	struct qrtr_device *qdev = to_qrtr_device(dev);
+	struct qrtr_driver *qdrv = to_qrtr_driver(drv);
+	const struct qrtr_device_id *id = qdrv->id_table;
+
+	if (!id)
+		return 0;
+
+	while (id->service != 0) {
+		if (id->service == qdev->service && id->instance == qdev->instance)
+			return 1;
+		id++;
+	}
+
+	return 0;
+}
+
+static int qcom_smd_qrtr_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct qrtr_device *qdev = to_qrtr_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=%s%x:%x", QRTR_MODULE_PREFIX, qdev->service,
+			      qdev->instance);
+}
+
+static int qcom_smd_qrtr_device_probe(struct device *dev)
+{
+	struct qrtr_device *qdev = to_qrtr_device(dev);
+	struct qrtr_driver *qdrv = to_qrtr_driver(dev->driver);
+
+	return qdrv->probe(qdev);
+}
+
+static void qcom_smd_qrtr_device_remove(struct device *dev)
+{
+	struct qrtr_device *qdev = to_qrtr_device(dev);
+	struct qrtr_driver *qdrv = to_qrtr_driver(dev->driver);
+
+	if (qdrv->remove)
+		qdrv->remove(qdev);
+}
+
+const struct bus_type qrtr_bus = {
+	.name		= "qrtr",
+	.match		= qcom_smd_qrtr_device_match,
+	.uevent		= qcom_smd_qrtr_uevent,
+	.probe		= qcom_smd_qrtr_device_probe,
+	.remove		= qcom_smd_qrtr_device_remove,
+};
+EXPORT_SYMBOL_NS_GPL(qrtr_bus, "QRTR");
+
+int __qrtr_driver_register(struct qrtr_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &qrtr_bus;
+	drv->driver.owner = owner;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_NS_GPL(__qrtr_driver_register, "QRTR");
+
+void qrtr_driver_unregister(struct qrtr_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_NS_GPL(qrtr_driver_unregister, "QRTR");
+
+static void qcom_smd_qrtr_dev_release(struct device *dev)
+{
+	struct qrtr_device *qdev = to_qrtr_device(dev);
+
+	kfree(qdev);
+}
+
+static int qcom_smd_qrtr_match_device_by_port(struct device *dev, const void *data)
+{
+	struct qrtr_device *qdev = to_qrtr_device(dev);
+	unsigned const int *port = data;
+
+	return qdev->port == *port;
+}
+
+static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
+{
+	struct qrtr_new_server *new_server = container_of(work, struct qrtr_new_server, work);
+	struct qrtr_smd_dev *qsdev = new_server->parent;
+	struct qrtr_device *qdev;
+	int ret;
+
+	qdev = kzalloc(sizeof(*qdev), GFP_KERNEL);
+	if (!qdev)
+		return;
+
+	*qdev = (struct qrtr_device) {
+		.node = new_server->node,
+		.port = new_server->port,
+		.service = new_server->service,
+		.instance = new_server->instance
+	};
+
+	devm_kfree(qsdev->dev, new_server);
+
+	dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);
+
+	qdev->dev.bus = &qrtr_bus;
+	qdev->dev.parent = qsdev->dev;
+	qdev->dev.release = qcom_smd_qrtr_dev_release;
+
+	ret = device_register(&qdev->dev);
+	if (ret) {
+		dev_err(qsdev->dev, "Failed to register QRTR device: %pe\n", ERR_PTR(ret));
+		put_device(&qdev->dev);
+	}
+}
+
+static void qcom_smd_qrtr_del_device_worker(struct work_struct *work)
+{
+	struct qrtr_del_server *del_server = container_of(work, struct qrtr_del_server, work);
+	struct qrtr_smd_dev *qsdev = del_server->parent;
+	struct device *dev = device_find_child(qsdev->dev, &del_server->port,
+					       qcom_smd_qrtr_match_device_by_port);
+
+	device_unregister(dev);
+}
+
+static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsigned int node,
+				    unsigned int port, u16 service, u16 instance)
+{
+	struct qrtr_smd_dev *qsdev = container_of(parent, struct qrtr_smd_dev, ep);
+	struct qrtr_new_server *new_server;
+
+	new_server = devm_kzalloc(qsdev->dev, sizeof(*new_server), GFP_KERNEL);
+	if (!new_server)
+		return -ENOMEM;
+
+	*new_server = (struct qrtr_new_server) {
+		.parent = qsdev,
+		.node = node,
+		.port = port,
+		.service = service,
+		.instance = instance
+	};
+
+	INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
+	schedule_work(&new_server->work);
+
+	return 0;
+}
+
+static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsigned int port)
+{
+	struct qrtr_smd_dev *qsdev = container_of(parent, struct qrtr_smd_dev, ep);
+	struct qrtr_del_server *del_server;
+
+	del_server = devm_kzalloc(qsdev->dev, sizeof(*del_server), GFP_KERNEL);
+	if (!del_server)
+		return -ENOMEM;
+
+	del_server->parent = qsdev;
+	del_server->port = port;
+
+	INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
+	schedule_work(&del_server->work);
+
+	return 0;
+}
+
+static int qcom_smd_qrtr_device_unregister(struct device *dev, void *data)
+{
+	device_unregister(dev);
+
+	return 0;
+}
+
 /* from smd to qrtr */
 static int qcom_smd_qrtr_callback(struct rpmsg_device *rpdev,
 				  void *data, int len, void *priv, u32 addr)
@@ -86,6 +278,8 @@ static void qcom_smd_qrtr_remove(struct rpmsg_device *rpdev)
 {
 	struct qrtr_smd_dev *qsdev = dev_get_drvdata(&rpdev->dev);
 
+	device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unregister);
+
 	qrtr_endpoint_unregister(&qsdev->ep);
 
 	dev_set_drvdata(&rpdev->dev, NULL);
@@ -106,7 +300,29 @@ static struct rpmsg_driver qcom_smd_qrtr_driver = {
 	},
 };
 
-module_rpmsg_driver(qcom_smd_qrtr_driver);
+static int __init qcom_smd_qrtr_init(void)
+{
+	int ret;
+
+	ret = bus_register(&qrtr_bus);
+	if (ret)
+		return ret;
+
+	ret = register_rpmsg_driver(&qcom_smd_qrtr_driver);
+	if (ret)
+		bus_unregister(&qrtr_bus);
+
+	return ret;
+}
+
+static void __exit qcom_smd_qrtr_exit(void)
+{
+	unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
+	bus_unregister(&qrtr_bus);
+}
+
+subsys_initcall(qcom_smd_qrtr_init);
+module_exit(qcom_smd_qrtr_exit);
 
 MODULE_ALIAS("rpmsg:IPCRTR");
 MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index d3d00e85edf73553ba3d9b5f9fccf1ff61c99026..0a90323c35d330f13a151948467d72b927f474f3 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -280,5 +280,9 @@ int main(void)
 	DEVID(coreboot_device_id);
 	DEVID_FIELD(coreboot_device_id, tag);
 
+	DEVID(qrtr_device_id);
+	DEVID_FIELD(qrtr_device_id, service);
+	DEVID_FIELD(qrtr_device_id, instance);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 00586119a25b7fd399eeeef3760a26467ffbb50c..fef69db4d7023305f03fd8bf85ac60c47ae7d0ca 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1370,6 +1370,15 @@ static void do_coreboot_entry(struct module *mod, void *symval)
 	module_alias_printf(mod, false, "coreboot:t%08X", tag);
 }
 
+/* Looks like: qrtr:N:N */
+static void do_qrtr_entry(struct module *mod, void *symval)
+{
+	DEF_FIELD(symval, qrtr_device_id, service);
+	DEF_FIELD(symval, qrtr_device_id, instance);
+
+	module_alias_printf(mod, false, "qrtr:%x:%x", service, instance);
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1466,6 +1475,7 @@ static const struct devtable devtable[] = {
 	{"usb", SIZE_usb_device_id, do_usb_entry_multi},
 	{"pnp", SIZE_pnp_device_id, do_pnp_device_entry},
 	{"pnp_card", SIZE_pnp_card_device_id, do_pnp_card_entry},
+	{"qrtr", SIZE_qrtr_device_id, do_qrtr_entry},
 };
 
 /* Create MODULE_ALIAS() statements.

-- 
2.50.0



