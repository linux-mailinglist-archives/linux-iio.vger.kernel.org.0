Return-Path: <linux-iio+bounces-21736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E036B08E04
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17AC1A67520
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A52E5422;
	Thu, 17 Jul 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ezoELVBS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510F29E11A;
	Thu, 17 Jul 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758515; cv=none; b=ERWlx1J+sai8gO9vhDZIzbO62RX1vu2FYdKGI2GP8fowB2wz4zeaCjeOD08AJl14vbRe2qIC62kPvLxzmGrEWAVT+dzyaw28ER349d1TaZxSfCt0aeJ8lKvF0fRu+cnmLLSxtxgw/74lgNtPxEsiu5QEBOS/u8v+Uj8caZJSGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758515; c=relaxed/simple;
	bh=qMwKtxO0rqPxrVVHeWz2itNACEBHXUU45X4KaWgadMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYErWnL4/2n9eSy740sC5OCH4oVzFz5Kvv1qxI14ydl1i2xiFLMfj+axZE9a2PnhRndEBLhh14mF0XOSGnmU1mQnMbm44BjoxdF4zo5yvBtC7+GTaZMGN9wrqfrjcKrDGQG1yp8XIxrUJnzWOoX3Ahfo81y0dOpsuOsEIovj47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ezoELVBS; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752758502; x=1753017702;
	bh=qMwKtxO0rqPxrVVHeWz2itNACEBHXUU45X4KaWgadMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ezoELVBSdahHvjickA/z4Nfu3LWhp+5nPUdKFU2vzZGEf2NwjlR4DetymmGbeB4Bt
	 cz610LY/fqi+p1HuA/mMeCSKEmo2kIY6dLYBZLg5YNB6KnbxVGpzkFoxUBd9sim3rD
	 6oECI65gIz1zoshkyPB0zG7p+6hWP4SXuWYkiGUF6Pt95K4mfaZzybKF6KYxLwfGSn
	 N2eoBSPBIS/2zdjO+5iuf7uJ55M15BUwtbACOX2A8EgS6LfckK9PT6AQHXvnos2RDu
	 O/W5U8Lzm30reW7E8oH3GishRBLVYfusX1lEEUdUG2Qjff7k5ckzZVr+yQGLmPlBoh
	 c+1e0d2ohkUeA==
Date: Thu, 17 Jul 2025 13:21:35 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] net: qrtr: Turn QRTR into a bus
Message-ID: <FDNgvJ7ZZjLaxvtcVqsbv9grSzkKe_xTylp1JWzltRetWlLycNFXOfTLz87WwRGC342HKQlohGRjy9WL3eBD3jB8F6Iuswabuq-eYkV18x4=@protonmail.com>
In-Reply-To: <CAHp75Ved4cnpmiUzidoJqRbdnz=L-0F_KdyWifOOrZHUUf2KQA@mail.gmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com> <20250710-qcom-smgr-v2-2-f6e198b7aa8e@protonmail.com> <CAHp75Ved4cnpmiUzidoJqRbdnz=L-0F_KdyWifOOrZHUUf2KQA@mail.gmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 71fdc870d65401170c48900605ea0a9b15ff1bf8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 10th, 2025 at 9:53 AM, Andy Shevchenko <andy.shevchenko@g=
mail.com> wrote:

> On Thu, Jul 10, 2025 at 11:06=E2=80=AFAM Yassine Oudjana via B4 Relay
> devnull+y.oudjana.protonmail.com@kernel.org wrote:
>=20
> > Implement a QRTR bus to allow for creating drivers for individual QRTR
> > services. With this in place, devices are dynamically registered for QR=
TR
> > services as they become available, and drivers for these devices are
> > matched using service and instance IDs.
>=20
>=20
> ...
>=20
> > +struct qrtr_device_id {
> > + __u16 service;
> > + __u16 instance;
> > + kernel_ulong_t driver_data; /* Data private to the driver */
>=20
>=20
> Can we not repeat mistakes from the past and use const void * from day 1 =
please?

I just looked at what most other *_device_id structs had and did the same. =
I guess
they were left like that for legacy reasons? Might be good to add a comment=
 next to
the kernel_ulong_t definition on why not to use it for future contributors.

>=20
> > +};
> > +
> > /* dmi */
>=20
>=20
> Wouldn't it be better to keep sections ordered alphabetically so 'q'
> will go at least after 'd'?

It didn't look ordered so I didn't pay much attention to ordering but
sure, will reorder.

>=20
> ...
>=20
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef QCOM_QRTR_H
> > +#define QCOM_QRTR_H
> > +
> > +#include <linux/mod_devicetable.h>
>=20
>=20
> Not enough. Please, follow IWYU principle and include / forward
> declare all this header uses.

So you're saying forward declare struct qrtr_device_id instead of including
mod_devicetable.h?

>=20
> > +struct qrtr_device {
> > + struct device dev;
> > + unsigned int node;
> > + unsigned int port;
> > + u16 service;
> > + u16 instance;
> > +};
> > +
> > +#define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> > +
> > +struct qrtr_driver {
> > + int (*probe)(struct qrtr_device *qdev);
> > + void (*remove)(struct qrtr_device *qdev);
> > + const struct qrtr_device_id *id_table;
> > + struct device_driver driver;
> > +};
> > +
> > +#define to_qrtr_driver(d) container_of(d, struct qrtr_driver, driver)
> > +
> > +#define qrtr_driver_register(drv) __qrtr_driver_register(drv, THIS_MOD=
ULE)
> > +
> > +int __qrtr_driver_register(struct qrtr_driver *drv, struct module *own=
er);
> > +void qrtr_driver_unregister(struct qrtr_driver drv);
> > +
> > +#define module_qrtr_driver(__qrtr_driver) \
> > + module_driver(__qrtr_driver, qrtr_driver_register, \
> > + qrtr_driver_unregister)
> > +
> > +#endif / QCOM_QRTR_H */
>=20
>=20
> ...
>=20
> > + int ret =3D 0;
>=20
>=20
> What is this assignment for? (The below is left for the context)

Yup looks unnecessary, will remove.

>=20
> > if (cb->type =3D=3D QRTR_TYPE_NEW_SERVER) {
> > /* Remote node endpoint can bridge other distant nodes /
> > qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
> > +
> > + / Create a QRTR device /
> > + ret =3D ep->add_device(ep, le32_to_cpu(pkt->server.node),
> > + le32_to_cpu(pkt->server.port),
> > + le32_to_cpu(pkt->server.service),
> > + le32_to_cpu(pkt->server.instance));
> > + if (ret)
> > + goto err;
> > + } else if (cb->type =3D=3D QRTR_TYPE_DEL_SERVER) {
> > + / Remove QRTR device corresponding to service */
> > + ret =3D ep->del_device(ep, le32_to_cpu(pkt->server.port));
> > + if (ret)
> > + goto err;
> > }
>=20
>=20
> ...
>=20
> > + return ret ? ret : -EINVAL;
>=20
>=20
> It's also possible
>=20
> return ret ?: -EINVAL;

Ack

>=20
> > }
>=20
>=20
> ...
>=20
> > +++ b/net/qrtr/smd.c
> > @@ -7,6 +7,7 @@
> > #include <linux/module.h>
> > #include <linux/skbuff.h>
> > #include <linux/rpmsg.h>
> > +#include <linux/soc/qcom/qrtr.h>
>=20
>=20
> Can we keep this more ordered?
>=20
> Also include export.h when the code uses one of the EXPORT_*() macros.

Sure thing

>=20
> ...
>=20
> > +static int qcom_smd_qrtr_device_match(struct device *dev, const struct=
 device_driver *drv)
> > +{
> > + struct qrtr_device *qdev =3D to_qrtr_device(dev);
> > + struct qrtr_driver *qdrv =3D to_qrtr_driver(drv);
> > + const struct qrtr_device_id *id =3D qdrv->id_table;
> > +
> > + if (!id)
> > + return 0;
> > +
> > + while (id->service !=3D 0) {
>=20
>=20
> ' !=3D 0' is redundant

Ack

>=20
> > + if (id->service =3D=3D qdev->service && id->instance =3D=3D qdev->ins=
tance)
> > + return 1;
> > + id++;
> > + }
> > +
> > + return 0;
> > +}
>=20
>=20
> ...
>=20
> > +static int qcom_smd_qrtr_match_device_by_port(struct device *dev, cons=
t void *data)
> > +{
> > + struct qrtr_device *qdev =3D to_qrtr_device(dev);
> > + unsigned const int *port =3D data;
>=20
>=20
> Why not
>=20
> unsigned int port =3D *((const unsigned int *)data);

What does this achieve? Isn't it fine to implicitly cast void *?

>=20
> > + return qdev->port =3D=3D *port;
> > +}
>=20
>=20
> ...
>=20
> > +static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
> > +{
> > + struct qrtr_new_server *new_server =3D container_of(work, struct qrtr=
_new_server, work);
> > + struct qrtr_smd_dev *qsdev =3D new_server->parent;
> > + struct qrtr_device *qdev;
> > + int ret;
> > +
> > + qdev =3D kzalloc(sizeof(*qdev), GFP_KERNEL);
> > + if (!qdev)
> > + return;
> > +
> > + *qdev =3D (struct qrtr_device) {
> > + .node =3D new_server->node,
> > + .port =3D new_server->port,
> > + .service =3D new_server->service,
> > + .instance =3D new_server->instance
>=20
>=20
> Leave trailing comma.

Ok

>=20
> > + };
>=20
> > + devm_kfree(qsdev->dev, new_server);
>=20
>=20
> ?!?! No, just no. Please, fix the object lifetimes and use proper
> allocators (not managed).

Missed this redundant managed kfree. See below about use of managed API

>=20
> > + dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);
>=20
>=20
> No error check?

Oops. Will add.

>=20
> > + qdev->dev.bus =3D &qrtr_bus;
> > + qdev->dev.parent =3D qsdev->dev;
> > + qdev->dev.release =3D qcom_smd_qrtr_dev_release;
> > +
> > + ret =3D device_register(&qdev->dev);
> > + if (ret) {
> > + dev_err(qsdev->dev, "Failed to register QRTR device: %pe\n", ERR_PTR(=
ret));
> > + put_device(&qdev->dev);
> > + }
> > +}
>=20
>=20
> ...
>=20
> > +static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsi=
gned int node,
> > + unsigned int port, u16 service, u16 instance)
> > +{
> > + struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_d=
ev, ep);
> > + struct qrtr_new_server *new_server;
> > +
> > + new_server =3D devm_kzalloc(qsdev->dev, sizeof(*new_server), GFP_KERN=
EL);
>=20
>=20
> Why is the managed API in use?!

When should I use or not use the managed API? I thought I was supposed to
use it whenever possible.

>=20
> > + if (!new_server)
> > + return -ENOMEM;
> > +
> > + *new_server =3D (struct qrtr_new_server) {
> > + .parent =3D qsdev,
> > + .node =3D node,
> > + .port =3D port,
> > + .service =3D service,
> > + .instance =3D instance
>=20
>=20
> Leave trailing comma.

Sure

>=20
> > + };
> > +
> > + INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
> > + schedule_work(&new_server->work);
> > +
> > + return 0;
> > +}
> > +
> > +static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsi=
gned int port)
> > +{
> > + struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_d=
ev, ep);
> > + struct qrtr_del_server *del_server;
> > +
> > + del_server =3D devm_kzalloc(qsdev->dev, sizeof(*del_server), GFP_KERN=
EL);
>=20
>=20
> Ditto.
>=20
> > + if (!del_server)
> > + return -ENOMEM;
> > +
> > + del_server->parent =3D qsdev;
> > + del_server->port =3D port;
> > +
> > + INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
> > + schedule_work(&del_server->work);
> > +
> > + return 0;
> > +}
>=20
>=20
> ...
>=20
> > +static int qcom_smd_qrtr_device_unregister(struct device *dev, void *d=
ata)
> > +{
> > + device_unregister(dev);
> > +
> > + return 0;
>=20
>=20
> Why? Can't this function be void?

Did it this way after seeing device_iter_t having int return type.

>=20
> > +}
>=20
>=20
> ...
>=20
> > {
> > struct qrtr_smd_dev *qsdev =3D dev_get_drvdata(&rpdev->dev);
> >=20
> > + device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unregist=
er);
>=20
>=20
> Perhaps _reversed() ?

What difference does the order make?

>=20
> > qrtr_endpoint_unregister(&qsdev->ep);
> >=20
> > dev_set_drvdata(&rpdev->dev, NULL);
>=20
> > };
>=20
>=20
>=20
> > +static void __exit qcom_smd_qrtr_exit(void)
> > +{
> > + unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
> > + bus_unregister(&qrtr_bus);
> > +}
> > +
> > +subsys_initcall(qcom_smd_qrtr_init);
> > +module_exit(qcom_smd_qrtr_exit);
>=20
>=20
> Move these two closer to the mentioned callbacks.

Ack


