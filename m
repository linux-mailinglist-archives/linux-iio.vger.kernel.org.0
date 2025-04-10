Return-Path: <linux-iio+bounces-17911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11FA84389
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82DB7AFCF0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E812853EE;
	Thu, 10 Apr 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LrENnOxJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986792853EA;
	Thu, 10 Apr 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289075; cv=none; b=uNv1ZjB2zSw+D9nx+sOJP2XQHhCb2OZvN/BacfNK5YxfvRNx0iPeutorVeDDGoLi6Wv2AMDxd3xXB18nc8jefy0dunch+64sRXGOaVCDXifO9DFykcwlVWlA3F/sxioa4Of4iXwmKbOiAqQzow/tACkmYg1WZjRuwdvs7Bqov54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289075; c=relaxed/simple;
	bh=DPa6Bkrl+u4okhY+O9K40WNylA/T7aJp7MY9fU7MGdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmECEW2lPj3NhgWmYw4dnZ7o5w/3i94wcUBGHVeavmdwilwiDrEyfAHuRRzPHxF1vAqeqXQQEscz4Ips90gmXO6btZUzdh0qzIulQ3LMXyJSfq6aqI2TSaI5v+2nNCov3OeX62F3PL8J8e1/mypHBqQ41kZtEzul4iv9vDoCqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=LrENnOxJ; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744289070; x=1744548270;
	bh=OmPyznTy1ji4uVfyzZ9cX07HVh6awgAfe3dadPDHDEA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LrENnOxJH0BzNnNuDRuikaSCBc56zDMzHSL8a8Ess+rDx7gdBJGL/OKZI0cY53gxk
	 mNfTCybqL2+hfm03Ch7p7KOLdgKv/0QXw33yiVcB6ggMXTIhlRr3XPfJTq4CRUEAkC
	 RDC0zJrHCbGd+oE5tMQ3UGifhAJmlTtbsyRjfHvyNQEYV6ookP1fOkZxYHCrTeUXa9
	 NmwuhCvfHPGPkebITAU5YrhaKgLcdRTfJI/Z8PonvXUjVzXNcHKmki7Ku0PjHm0Wrb
	 zf7rEzMv/35k9LYmSdoaxwg2Sxa5kUlWxDSMcB7DGu/g1sgAhypWkdflWIF540oeBB
	 QNMOc4RBrWFgA==
Date: Thu, 10 Apr 2025 12:44:25 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, Danila Tikhonov
	<danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/3] net: qrtr: Turn QRTR into a bus
Message-ID: <373f4699-4b3d-4fa4-8a75-9e71b9dccc5c@protonmail.com>
In-Reply-To: <20250406170111.7a11437a@jic23-huawei>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-2-y.oudjana@protonmail.com> <20250406170111.7a11437a@jic23-huawei>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 647f174cf082fb65ce85fc9c15b866e78ba2ed8a
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Missed one comment so sending a second reply.

On 06/04/2025 7:01 pm, Jonathan Cameron wrote:
> On Sun, 06 Apr 2025 14:07:43 +0000
> Yassine Oudjana <y.oudjana@protonmail.com> wrote:
>=20
>> Implement a QRTR bus to allow for creating drivers for individual QRTR
>> services. With this in place, devices are dynamically registered for QRT=
R
>> services as they become available, and drivers for these devices are
>> matched using service and instance IDs.
>>
>> In smd.c, replace all current occurences of qdev with qsdev in order to
>> distinguish between the newly added QRTR device which represents a QRTR
>> service with the existing QRTR SMD device which represents the endpoint
>> through which services are provided.
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Hi Yassine
>=20
> Just took a quick look through.
>=20
> It might make more sense to do this with an auxiliary_bus rather
> than defining a new bus.

I'm not familiar with auxiliary bus, but reading the documentation it=20
seems to me like it's used like MFD where there is a device that has=20
multiple functions, just without the subdevices having physical=20
addresses. QRTR is not really a device but more closely resembles=20
something like PCI or I2C as a communication interface.

>=20
> I'd also split out the renames as a precursor patch.
>=20
> Various other comments inline.
>=20
> Jonathan
>=20
>> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
>> index 00c51cf693f3..e11682fd7960 100644
>> --- a/net/qrtr/af_qrtr.c
>> +++ b/net/qrtr/af_qrtr.c
>> @@ -435,6 +435,7 @@ static void qrtr_node_assign(struct qrtr_node *node,=
 unsigned int nid)
>>   int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, siz=
e_t len)
>>   {
>>   =09struct qrtr_node *node =3D ep->node;
>> +=09const struct qrtr_ctrl_pkt *pkt;
>>   =09const struct qrtr_hdr_v1 *v1;
>>   =09const struct qrtr_hdr_v2 *v2;
>>   =09struct qrtr_sock *ipc;
>> @@ -443,6 +444,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, con=
st void *data, size_t len)
>>   =09size_t size;
>>   =09unsigned int ver;
>>   =09size_t hdrlen;
>> +=09int ret =3D 0;
>>
>>   =09if (len =3D=3D 0 || len & 3)
>>   =09=09return -EINVAL;
>> @@ -516,12 +518,24 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, c=
onst void *data, size_t len)
>>
>>   =09qrtr_node_assign(node, cb->src_node);
>>
>> +=09pkt =3D data + hdrlen;
>> +
>>   =09if (cb->type =3D=3D QRTR_TYPE_NEW_SERVER) {
>>   =09=09/* Remote node endpoint can bridge other distant nodes */
>> -=09=09const struct qrtr_ctrl_pkt *pkt;
>> -
>> -=09=09pkt =3D data + hdrlen;
>>   =09=09qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
>> +
>> +=09=09/* Create a QRTR device */
>> +=09=09ret =3D ep->add_device(ep, le32_to_cpu(pkt->server.node),
>> +=09=09=09=09=09       le32_to_cpu(pkt->server.port),
>> +=09=09=09=09=09       le32_to_cpu(pkt->server.service),
>> +=09=09=09=09=09       le32_to_cpu(pkt->server.instance));
>> +=09=09if (ret)
>> +=09=09=09goto err;
>> +=09} else if (cb->type =3D=3D QRTR_TYPE_DEL_SERVER) {
>> +=09=09/* Remove QRTR device corresponding to service */
>> +=09=09ret =3D ep->del_device(ep, le32_to_cpu(pkt->server.port));
>> +=09=09if (ret)
>> +=09=09=09goto err;
>>   =09}
>>
>>   =09if (cb->type =3D=3D QRTR_TYPE_RESUME_TX) {
>> @@ -543,8 +557,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, con=
st void *data, size_t len)
>>
>>   err:
>>   =09kfree_skb(skb);
>> -=09return -EINVAL;
>> -
>> +=09return ret ? ret : -EINVAL;
> How do we get here with non error value given we couldn't before?
>=20
>=20
>>   }
>>   EXPORT_SYMBOL_GPL(qrtr_endpoint_post);
>>
>=20
>> diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
>> index c91bf030fbc7..fd5ad6a8d1c3 100644
>> --- a/net/qrtr/smd.c
>> +++ b/net/qrtr/smd.c
>> @@ -7,6 +7,7 @@
>=20
>> +
>> +static int qcom_smd_qrtr_uevent(const struct device *dev, struct kobj_u=
event_env *env)
>> +{
>> +=09const struct qrtr_device *qdev =3D to_qrtr_device(dev);
>> +
>> +=09return add_uevent_var(env, "MODALIAS=3D%s%x:%x", QRTR_MODULE_PREFIX,=
 qdev->service,
>> +=09=09=09      qdev->instance);
>> +}
>=20
>=20
>> +void qrtr_driver_unregister(struct qrtr_driver *drv)
>> +{
>> +=09driver_unregister(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(qrtr_driver_unregister);
>=20
> Given this is a 'new thing' maybe namespace it from the start?
> EXPORT_SYMBOL_NS_GPL();
>=20
>=20
>> +
>> +static int qcom_smd_qrtr_match_device_by_port(struct device *dev, const=
 void *data)
>> +{
>> +=09struct qrtr_device *qdev =3D to_qrtr_device(dev);
>> +=09unsigned int port =3D *(unsigned int *)data;
> =09unsinged int *port =3D data;
>=20
> =09return qdev->port =3D=3D *port;
>=20
>> +
>> +=09return qdev->port =3D=3D port;
>> +}
>> +
>> +static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
>> +{
>> +=09struct qrtr_new_server *new_server =3D container_of(work, struct qrt=
r_new_server, work);
>> +=09struct qrtr_smd_dev *qsdev =3D new_server->parent;
>> +=09struct qrtr_device *qdev;
>> +=09int ret;
>> +
>> +=09qdev =3D kzalloc(sizeof(*qdev), GFP_KERNEL);
>> +=09if (!qdev)
>> +=09=09return;
>> +
> Maybe
> =09*qdev =3D (struct qrtr_device *) {
> =09};
> and free new_server after all of these are filled in.
>=20
>> +=09qdev->node =3D new_server->node;
>> +=09qdev->port =3D new_server->port;
>> +=09qdev->service =3D new_server->service;
>> +=09qdev->instance =3D new_server->instance;
>> +
>> +=09devm_kfree(qsdev->dev, new_server);
>=20
> As below.
>=20
>> +
>> +=09dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);
>> +
>> +=09qdev->dev.bus =3D &qrtr_bus;
>> +=09qdev->dev.parent =3D qsdev->dev;
>> +=09qdev->dev.release =3D qcom_smd_qrtr_dev_release;
>> +=09qdev->dev.driver =3D NULL;
>=20
> it's kzalloc'd so no need to set this.
>=20
>> +
>> +=09ret =3D device_register(&qdev->dev);
>> +=09if (ret) {
>> +=09=09dev_err(qsdev->dev, "Failed to register QRTR device: %pe\n", ERR_=
PTR(ret));
>> +=09=09put_device(&qdev->dev);
>> +=09}
>> +}
>> +
>> +static void qcom_smd_qrtr_del_device_worker(struct work_struct *work)
>> +{
>> +=09struct qrtr_del_server *del_server =3D container_of(work, struct qrt=
r_del_server, work);
>> +=09struct qrtr_smd_dev *qsdev =3D del_server->parent;
>> +=09struct device *dev =3D device_find_child(qsdev->dev, &del_server->po=
rt,
>> +=09=09=09=09=09       qcom_smd_qrtr_match_device_by_port);
>> +
>> +=09devm_kfree(qsdev->dev, del_server);
> If we are always going to free what was alocated in qcom_smd_qrtr_del_dev=
ice()
> why use devm at all?
>> +
>> +=09if (dev)
>> +=09=09device_unregister(dev);
> If this doesn't match anything I'm guessing it's a bug?   So maybe an err=
or message?
>=20
>> +}
>> +
>> +static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsig=
ned int node,
>> +=09=09=09=09    unsigned int port, u16 service, u16 instance)
>> +{
>> +=09struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_=
dev, ep);
>> +=09struct qrtr_new_server *new_server;
>> +
>> +=09new_server =3D devm_kzalloc(qsdev->dev, sizeof(struct qrtr_new_serve=
r), GFP_KERNEL);
>=20
> As below. sizeof(*new_server)
>=20
>> +=09if (!new_server)
>> +=09=09return -ENOMEM;
>> +
> =09*new_server =3D (struct qtr_new_server) {
> =09=09.parent =3D qsdev,
> =09=09.ndoe =3D node,
> ...
> =09};
>=20
> perhaps a tiny bit easier to read?
>=20
>> +=09new_server->parent =3D qsdev;
>> +=09new_server->node =3D node;
>> +=09new_server->port =3D port;
>> +=09new_server->service =3D service;
>> +=09new_server->instance =3D instance;
>> +
>> +=09INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
>> +=09schedule_work(&new_server->work);
>> +
>> +=09return 0;
>> +}
>> +
>> +static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsig=
ned int port)
>> +{
>> +=09struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_smd_=
dev, ep);
>> +=09struct qrtr_del_server *del_server;
>> +
>> +=09del_server =3D devm_kzalloc(qsdev->dev, sizeof(struct qrtr_del_serve=
r), GFP_KERNEL);
>=20
> sizeof(*del_server)
> preferred as then no one has to check types match.
>=20
>> +=09if (!del_server)
>> +=09=09return -ENOMEM;
>> +
>> +=09del_server->parent =3D qsdev;
>> +=09del_server->port =3D port;
>> +
>> +=09INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
>> +=09schedule_work(&del_server->work);
>> +
>> +=09return 0;
>> +}
>> +
>> +static int qcom_smd_qrtr_device_unregister(struct device *dev, void *da=
ta)
>> +{
>> +=09device_unregister(dev);
>=20
> One option that may simplify this is to do the device_unregister() handli=
ng
> a devm_action_or_reset() handler that is using the parent device as it's =
dev
> but unregistering the children.  That way the unregister is called in the
> reverse order of setup and you only register a handler for those devices
> registered (rather walking children).  I did this in the CXL pmu driver
> for instance.
>=20
>> +
>> +=09return 0;
>> +}
>> +
>=20
>> @@ -82,9 +276,11 @@ static int qcom_smd_qrtr_probe(struct rpmsg_device *=
rpdev)
>>
>>   static void qcom_smd_qrtr_remove(struct rpmsg_device *rpdev)
>>   {
>> -=09struct qrtr_smd_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
>> +=09struct qrtr_smd_dev *qsdev =3D dev_get_drvdata(&rpdev->dev);
>=20
> May be worth doing the rename in a precursor patch to simplify a little w=
hat is
> in this one.
>=20
>> +
>> +=09device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unregis=
ter);
>>
>> -=09qrtr_endpoint_unregister(&qdev->ep);
>> +=09qrtr_endpoint_unregister(&qsdev->ep);
>>
>>   =09dev_set_drvdata(&rpdev->dev, NULL);
>>   }
>> @@ -104,7 +300,27 @@ static struct rpmsg_driver qcom_smd_qrtr_driver =3D=
 {
>>   =09},
>>   };
>>
>> -module_rpmsg_driver(qcom_smd_qrtr_driver);
>> +static int __init qcom_smd_qrtr_init(void)
>> +{
>> +=09int ret;
>> +
>> +=09ret =3D bus_register(&qrtr_bus);
>> +=09if (!ret)
>> +=09=09ret =3D register_rpmsg_driver(&qcom_smd_qrtr_driver);
> This style tends to extend badly. Go with more conventional errors
> out of line style.
>=20
> =09if (ret)
> =09=09return ret;
>=20
> =09ret =3D register_rpmsg_driver(&qcom_smd_qrtr_driver);
> =09if (ret) {
> =09=09bus_unregister(&qtr_bus);
> =09=09return ret;
> =09}
>=20
> =09return 0;
>=20
>> +=09else
>> +=09=09bus_unregister(&qrtr_bus);
>> +
>> +=09return ret;
>> +}
>> +
>> +static void __exit qcom_smd_qrtr_exit(void)
>> +{
>> +=09bus_unregister(&qrtr_bus);
>=20
> Order should be the reverse of what happened in probe so swap these round=
.
>=20
>> +=09unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
>> +}
>> +
>> +subsys_initcall(qcom_smd_qrtr_init);
>> +module_exit(qcom_smd_qrtr_exit);
>>
>>   MODULE_ALIAS("rpmsg:IPCRTR");
>>   MODULE_DESCRIPTION("Qualcomm IPC-Router SMD interface driver");
>>



