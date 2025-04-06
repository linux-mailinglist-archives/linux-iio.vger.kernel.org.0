Return-Path: <linux-iio+bounces-17674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06146A7CE58
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5527A60EB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC7F219303;
	Sun,  6 Apr 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="d9VCVvJv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6F20E6FD;
	Sun,  6 Apr 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948482; cv=none; b=VwlkrorqHZbwwPJUgZuivB3wV72tScojugPajqbP1YyNuGjI1wOLXYo+mu82sZtQmJNiH35b5kA+4a3uEWE7hXWL5AHHhZD8C5/I935MF8i8C+fcDFO6n+hjvUp/P5GH4RiQbGWJKlGTGh2OPuQ2CuvRQC7kgHDq3o9pJv5x8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948482; c=relaxed/simple;
	bh=BZKeyrZhHfer0bUunPuTV2gSjqkkwoFBzm3mDXtLan0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmQeT/juwit+WEwAuUEn4zCzUZ+2jZbdYO9c6wn9ty2fsTOLGvIvr/hjB9xn5rGA/Sokkn3ZwU2djn5Ee7ZgBFhEF24SpwACGDjYSJGxegpi3mektyOc4xEZ+pY3OMxDQ7WPN03xjrlH9O6KIiIn968hlNNP+Oi6IDADTvdjMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=d9VCVvJv; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1743948468; x=1744207668;
	bh=VKQi9ZnlidFJxDYyqZZXk2qy3j2rvi+xkHmDyCJGZ1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=d9VCVvJv7faSmw3Kr9HP7+Dyzv76BkeKIdQsgTxG9CJR1c3yjKnMe6IHt+iInP5IV
	 n6abqfNlrzGWyv+1XgCt7s6w+IXeQbpcSWB0rUHaCCxYgCSMkkLFMCtt1gZ22vLAX+
	 n0g6JUPwLCCI4NAsQOC7K1Mn7bpmlBiU1pmTXXxz7SBlq/TEKOJFANuUmd74/y1VJ+
	 qbwFRey7EgRKNE3FLqZXXIQiD0IV2J3U1u++PBOJV8cEr7YIBX7E4EFJZDBSb9HIHQ
	 4J8+yd6RozCUVFidIEpQh/vl57aFqy0geYIz1wOCmpxAoTMPwZRqfQ4aWJ2BFjbKNO
	 +VYAqYNj/vvag==
Date: Sun, 06 Apr 2025 14:07:43 +0000
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 1/3] net: qrtr: Turn QRTR into a bus
Message-ID: <20250406140706.812425-2-y.oudjana@protonmail.com>
In-Reply-To: <20250406140706.812425-1-y.oudjana@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 58a8057d9a40f4e4fff8b1b26bd1012914d77e31
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Implement a QRTR bus to allow for creating drivers for individual QRTR
services. With this in place, devices are dynamically registered for QRTR
services as they become available, and drivers for these devices are
matched using service and instance IDs.

In smd.c, replace all current occurences of qdev with qsdev in order to
distinguish between the newly added QRTR device which represents a QRTR
service with the existing QRTR SMD device which represents the endpoint
through which services are provided.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 include/linux/mod_devicetable.h   |   9 ++
 include/linux/soc/qcom/qrtr.h     |  34 ++++
 net/qrtr/af_qrtr.c                |  23 ++-
 net/qrtr/qrtr.h                   |   3 +
 net/qrtr/smd.c                    | 250 ++++++++++++++++++++++++++++--
 scripts/mod/devicetable-offsets.c |   4 +
 scripts/mod/file2alias.c          |  10 ++
 7 files changed, 311 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/soc/qcom/qrtr.h

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetabl=
e.h
index bd7e60c0b72f..e2204344e7c4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -549,6 +549,15 @@ struct spmi_device_id {
 =09kernel_ulong_t driver_data;=09/* Data private to the driver */
 };
=20
+#define QRTR_NAME_SIZE=0932
+#define QRTR_MODULE_PREFIX "qrtr:"
+
+struct qrtr_device_id {
+=09__u16 service;
+=09__u16 instance;
+=09kernel_ulong_t driver_data;=09/* Data private to the driver */
+};
+
 /* dmi */
 enum dmi_field {
 =09DMI_NONE,
diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrtr.h
new file mode 100644
index 000000000000..4d7f25c64c56
--- /dev/null
+++ b/include/linux/soc/qcom/qrtr.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __QCOM_QRTR_H__
+#define __QCOM_QRTR_H__
+
+struct qrtr_device {
+=09struct device dev;
+=09unsigned int node;
+=09unsigned int port;
+=09u16 service;
+=09u16 instance;
+};
+
+#define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
+
+struct qrtr_driver {
+=09int (*probe)(struct qrtr_device *qdev);
+=09void (*remove)(struct qrtr_device *qdev);
+=09const struct qrtr_device_id *id_table;
+=09struct device_driver driver;
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
+=09module_driver(__qrtr_driver, qrtr_driver_register, \
+=09=09=09qrtr_driver_unregister)
+
+#endif /* __QCOM_QRTR_H__ */
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 00c51cf693f3..e11682fd7960 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -435,6 +435,7 @@ static void qrtr_node_assign(struct qrtr_node *node, un=
signed int nid)
 int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t =
len)
 {
 =09struct qrtr_node *node =3D ep->node;
+=09const struct qrtr_ctrl_pkt *pkt;
 =09const struct qrtr_hdr_v1 *v1;
 =09const struct qrtr_hdr_v2 *v2;
 =09struct qrtr_sock *ipc;
@@ -443,6 +444,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const =
void *data, size_t len)
 =09size_t size;
 =09unsigned int ver;
 =09size_t hdrlen;
+=09int ret =3D 0;
=20
 =09if (len =3D=3D 0 || len & 3)
 =09=09return -EINVAL;
@@ -516,12 +518,24 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, cons=
t void *data, size_t len)
=20
 =09qrtr_node_assign(node, cb->src_node);
=20
+=09pkt =3D data + hdrlen;
+
 =09if (cb->type =3D=3D QRTR_TYPE_NEW_SERVER) {
 =09=09/* Remote node endpoint can bridge other distant nodes */
-=09=09const struct qrtr_ctrl_pkt *pkt;
-
-=09=09pkt =3D data + hdrlen;
 =09=09qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
+
+=09=09/* Create a QRTR device */
+=09=09ret =3D ep->add_device(ep, le32_to_cpu(pkt->server.node),
+=09=09=09=09=09       le32_to_cpu(pkt->server.port),
+=09=09=09=09=09       le32_to_cpu(pkt->server.service),
+=09=09=09=09=09       le32_to_cpu(pkt->server.instance));
+=09=09if (ret)
+=09=09=09goto err;
+=09} else if (cb->type =3D=3D QRTR_TYPE_DEL_SERVER) {
+=09=09/* Remove QRTR device corresponding to service */
+=09=09ret =3D ep->del_device(ep, le32_to_cpu(pkt->server.port));
+=09=09if (ret)
+=09=09=09goto err;
 =09}
=20
 =09if (cb->type =3D=3D QRTR_TYPE_RESUME_TX) {
@@ -543,8 +557,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const =
void *data, size_t len)
=20
 err:
 =09kfree_skb(skb);
-=09return -EINVAL;
-
+=09return ret ? ret : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_post);
=20
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index 3f2d28696062..659048336730 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -19,6 +19,9 @@ struct sk_buff;
  */
 struct qrtr_endpoint {
 =09int (*xmit)(struct qrtr_endpoint *ep, struct sk_buff *skb);
+=09int (*add_device)(struct qrtr_endpoint *parent, unsigned int node, unsi=
gned int port,
+=09=09=09  u16 service, u16 instance);
+=09int (*del_device)(struct qrtr_endpoint *parent, unsigned int port);
 =09/* private: not for endpoint use */
 =09struct qrtr_node *node;
 };
diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
index c91bf030fbc7..fd5ad6a8d1c3 100644
--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/rpmsg.h>
+#include <linux/soc/qcom/qrtr.h>
=20
 #include "qrtr.h"
=20
@@ -16,19 +17,210 @@ struct qrtr_smd_dev {
 =09struct device *dev;
 };
=20
+struct qrtr_new_server {
+=09struct qrtr_smd_dev *parent;
+=09unsigned int node;
+=09unsigned int port;
+=09u16 service;
+=09u16 instance;
+
+=09struct work_struct work;
+};
+
+struct qrtr_del_server {
+=09struct qrtr_smd_dev *parent;
+=09unsigned int port;
+
+=09struct work_struct work;
+};
+
+static int qcom_smd_qrtr_device_match(struct device *dev, const struct dev=
ice_driver *drv)
+{
+=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
+=09struct qrtr_driver *qdrv =3D to_qrtr_driver(drv);
+=09const struct qrtr_device_id *id =3D qdrv->id_table;
+
+=09if (!id)
+=09=09return 0;
+
+=09while (id->service !=3D 0) {
+=09=09if (id->service =3D=3D qdev->service && id->instance =3D=3D qdev->in=
stance)
+=09=09=09return 1;
+=09=09id++;
+=09}
+
+=09return 0;
+}
+
+static int qcom_smd_qrtr_uevent(const struct device *dev, struct kobj_ueve=
nt_env *env)
+{
+=09const struct qrtr_device *qdev =3D to_qrtr_device(dev);
+
+=09return add_uevent_var(env, "MODALIAS=3D%s%x:%x", QRTR_MODULE_PREFIX, qd=
ev->service,
+=09=09=09      qdev->instance);
+}
+
+static int qcom_smd_qrtr_device_probe(struct device *dev)
+{
+=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
+=09struct qrtr_driver *qdrv =3D to_qrtr_driver(dev->driver);
+
+=09return qdrv->probe(qdev);
+}
+
+static void qcom_smd_qrtr_device_remove(struct device *dev)
+{
+=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
+=09struct qrtr_driver *qdrv =3D to_qrtr_driver(dev->driver);
+
+=09if (qdrv->remove)
+=09=09qdrv->remove(qdev);
+}
+
+const struct bus_type qrtr_bus =3D {
+=09.name=09=09=3D "qrtr",
+=09.match=09=09=3D qcom_smd_qrtr_device_match,
+=09.uevent=09=09=3D qcom_smd_qrtr_uevent,
+=09.probe=09=09=3D qcom_smd_qrtr_device_probe,
+=09.remove=09=09=3D qcom_smd_qrtr_device_remove,
+};
+EXPORT_SYMBOL_GPL(qrtr_bus);
+
+int __qrtr_driver_register(struct qrtr_driver *drv, struct module *owner)
+{
+=09drv->driver.bus =3D &qrtr_bus;
+=09drv->driver.owner =3D owner;
+
+=09return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__qrtr_driver_register);
+
+void qrtr_driver_unregister(struct qrtr_driver *drv)
+{
+=09driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(qrtr_driver_unregister);
+
+static void qcom_smd_qrtr_dev_release(struct device *dev)
+{
+=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
+
+=09kfree(qdev);
+}
+
+static int qcom_smd_qrtr_match_device_by_port(struct device *dev, const vo=
id *data)
+{
+=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
+=09unsigned int port =3D *(unsigned int *)data;
+
+=09return qdev->port =3D=3D port;
+}
+
+static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
+{
+=09struct qrtr_new_server *new_server =3D container_of(work, struct qrtr_n=
ew_server, work);
+=09struct qrtr_smd_dev *qsdev =3D new_server->parent;
+=09struct qrtr_device *qdev;
+=09int ret;
+
+=09qdev =3D kzalloc(sizeof(*qdev), GFP_KERNEL);
+=09if (!qdev)
+=09=09return;
+
+=09qdev->node =3D new_server->node;
+=09qdev->port =3D new_server->port;
+=09qdev->service =3D new_server->service;
+=09qdev->instance =3D new_server->instance;
+
+=09devm_kfree(qsdev->dev, new_server);
+
+=09dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);
+
+=09qdev->dev.bus =3D &qrtr_bus;
+=09qdev->dev.parent =3D qsdev->dev;
+=09qdev->dev.release =3D qcom_smd_qrtr_dev_release;
+=09qdev->dev.driver =3D NULL;
+
+=09ret =3D device_register(&qdev->dev);
+=09if (ret) {
+=09=09dev_err(qsdev->dev, "Failed to register QRTR device: %pe\n", ERR_PTR=
(ret));
+=09=09put_device(&qdev->dev);
+=09}
+}
+
+static void qcom_smd_qrtr_del_device_worker(struct work_struct *work)
+{
+=09struct qrtr_del_server *del_server =3D container_of(work, struct qrtr_d=
el_server, work);
+=09struct qrtr_smd_dev *qsdev =3D del_server->parent;
+=09struct device *dev =3D device_find_child(qsdev->dev, &del_server->port,
+=09=09=09=09=09       qcom_smd_qrtr_match_device_by_port);
+
+=09devm_kfree(qsdev->dev, del_server);
+
+=09if (dev)
+=09=09device_unregister(dev);
+}
+
+static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsigned=
 int node,
+=09=09=09=09    unsigned int port, u16 service, u16 instance)
+{
+=09struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_dev=
, ep);
+=09struct qrtr_new_server *new_server;
+
+=09new_server =3D devm_kzalloc(qsdev->dev, sizeof(struct qrtr_new_server),=
 GFP_KERNEL);
+=09if (!new_server)
+=09=09return -ENOMEM;
+
+=09new_server->parent =3D qsdev;
+=09new_server->node =3D node;
+=09new_server->port =3D port;
+=09new_server->service =3D service;
+=09new_server->instance =3D instance;
+
+=09INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
+=09schedule_work(&new_server->work);
+
+=09return 0;
+}
+
+static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsigned=
 int port)
+{
+=09struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_dev=
, ep);
+=09struct qrtr_del_server *del_server;
+
+=09del_server =3D devm_kzalloc(qsdev->dev, sizeof(struct qrtr_del_server),=
 GFP_KERNEL);
+=09if (!del_server)
+=09=09return -ENOMEM;
+
+=09del_server->parent =3D qsdev;
+=09del_server->port =3D port;
+
+=09INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
+=09schedule_work(&del_server->work);
+
+=09return 0;
+}
+
+static int qcom_smd_qrtr_device_unregister(struct device *dev, void *data)
+{
+=09device_unregister(dev);
+
+=09return 0;
+}
+
 /* from smd to qrtr */
 static int qcom_smd_qrtr_callback(struct rpmsg_device *rpdev,
 =09=09=09=09  void *data, int len, void *priv, u32 addr)
 {
-=09struct qrtr_smd_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
+=09struct qrtr_smd_dev *qsdev =3D dev_get_drvdata(&rpdev->dev);
 =09int rc;
=20
-=09if (!qdev)
+=09if (!qsdev)
 =09=09return -EAGAIN;
=20
-=09rc =3D qrtr_endpoint_post(&qdev->ep, data, len);
+=09rc =3D qrtr_endpoint_post(&qsdev->ep, data, len);
 =09if (rc =3D=3D -EINVAL) {
-=09=09dev_err(qdev->dev, "invalid ipcrouter packet\n");
+=09=09dev_err(qsdev->dev, "invalid ipcrouter packet\n");
 =09=09/* return 0 to let smd drop the packet */
 =09=09rc =3D 0;
 =09}
@@ -39,14 +231,14 @@ static int qcom_smd_qrtr_callback(struct rpmsg_device =
*rpdev,
 /* from qrtr to smd */
 static int qcom_smd_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *sk=
b)
 {
-=09struct qrtr_smd_dev *qdev =3D container_of(ep, struct qrtr_smd_dev, ep)=
;
+=09struct qrtr_smd_dev *qsdev =3D container_of(ep, struct qrtr_smd_dev, ep=
);
 =09int rc;
=20
 =09rc =3D skb_linearize(skb);
 =09if (rc)
 =09=09goto out;
=20
-=09rc =3D rpmsg_send(qdev->channel, skb->data, skb->len);
+=09rc =3D rpmsg_send(qsdev->channel, skb->data, skb->len);
=20
 out:
 =09if (rc)
@@ -58,22 +250,24 @@ static int qcom_smd_qrtr_send(struct qrtr_endpoint *ep=
, struct sk_buff *skb)
=20
 static int qcom_smd_qrtr_probe(struct rpmsg_device *rpdev)
 {
-=09struct qrtr_smd_dev *qdev;
+=09struct qrtr_smd_dev *qsdev;
 =09int rc;
=20
-=09qdev =3D devm_kzalloc(&rpdev->dev, sizeof(*qdev), GFP_KERNEL);
-=09if (!qdev)
+=09qsdev =3D devm_kzalloc(&rpdev->dev, sizeof(*qsdev), GFP_KERNEL);
+=09if (!qsdev)
 =09=09return -ENOMEM;
=20
-=09qdev->channel =3D rpdev->ept;
-=09qdev->dev =3D &rpdev->dev;
-=09qdev->ep.xmit =3D qcom_smd_qrtr_send;
+=09qsdev->channel =3D rpdev->ept;
+=09qsdev->dev =3D &rpdev->dev;
+=09qsdev->ep.xmit =3D qcom_smd_qrtr_send;
+=09qsdev->ep.add_device =3D qcom_smd_qrtr_add_device;
+=09qsdev->ep.del_device =3D qcom_smd_qrtr_del_device;
=20
-=09rc =3D qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
+=09rc =3D qrtr_endpoint_register(&qsdev->ep, QRTR_EP_NID_AUTO);
 =09if (rc)
 =09=09return rc;
=20
-=09dev_set_drvdata(&rpdev->dev, qdev);
+=09dev_set_drvdata(&rpdev->dev, qsdev);
=20
 =09dev_dbg(&rpdev->dev, "Qualcomm SMD QRTR driver probed\n");
=20
@@ -82,9 +276,11 @@ static int qcom_smd_qrtr_probe(struct rpmsg_device *rpd=
ev)
=20
 static void qcom_smd_qrtr_remove(struct rpmsg_device *rpdev)
 {
-=09struct qrtr_smd_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
+=09struct qrtr_smd_dev *qsdev =3D dev_get_drvdata(&rpdev->dev);
+
+=09device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unregister=
);
=20
-=09qrtr_endpoint_unregister(&qdev->ep);
+=09qrtr_endpoint_unregister(&qsdev->ep);
=20
 =09dev_set_drvdata(&rpdev->dev, NULL);
 }
@@ -104,7 +300,27 @@ static struct rpmsg_driver qcom_smd_qrtr_driver =3D {
 =09},
 };
=20
-module_rpmsg_driver(qcom_smd_qrtr_driver);
+static int __init qcom_smd_qrtr_init(void)
+{
+=09int ret;
+
+=09ret =3D bus_register(&qrtr_bus);
+=09if (!ret)
+=09=09ret =3D register_rpmsg_driver(&qcom_smd_qrtr_driver);
+=09else
+=09=09bus_unregister(&qrtr_bus);
+
+=09return ret;
+}
+
+static void __exit qcom_smd_qrtr_exit(void)
+{
+=09bus_unregister(&qrtr_bus);
+=09unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
+}
+
+subsys_initcall(qcom_smd_qrtr_init);
+module_exit(qcom_smd_qrtr_exit);
=20
 MODULE_ALIAS("rpmsg:IPCRTR");
 MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-of=
fsets.c
index d3d00e85edf7..0a90323c35d3 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -280,5 +280,9 @@ int main(void)
 =09DEVID(coreboot_device_id);
 =09DEVID_FIELD(coreboot_device_id, tag);
=20
+=09DEVID(qrtr_device_id);
+=09DEVID_FIELD(qrtr_device_id, service);
+=09DEVID_FIELD(qrtr_device_id, instance);
+
 =09return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 00586119a25b..fef69db4d702 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1370,6 +1370,15 @@ static void do_coreboot_entry(struct module *mod, vo=
id *symval)
 =09module_alias_printf(mod, false, "coreboot:t%08X", tag);
 }
=20
+/* Looks like: qrtr:N:N */
+static void do_qrtr_entry(struct module *mod, void *symval)
+{
+=09DEF_FIELD(symval, qrtr_device_id, service);
+=09DEF_FIELD(symval, qrtr_device_id, instance);
+
+=09module_alias_printf(mod, false, "qrtr:%x:%x", service, instance);
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1466,6 +1475,7 @@ static const struct devtable devtable[] =3D {
 =09{"usb", SIZE_usb_device_id, do_usb_entry_multi},
 =09{"pnp", SIZE_pnp_device_id, do_pnp_device_entry},
 =09{"pnp_card", SIZE_pnp_card_device_id, do_pnp_card_entry},
+=09{"qrtr", SIZE_qrtr_device_id, do_qrtr_entry},
 };
=20
 /* Create MODULE_ALIAS() statements.
--=20
2.49.0



