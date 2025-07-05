Return-Path: <linux-iio+bounces-21372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C7BAFA12F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D9C487E2C
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA8217734;
	Sat,  5 Jul 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="F4Ue/HjN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842143159;
	Sat,  5 Jul 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751740205; cv=none; b=tnkJYAgZMwEvQf1UnbtRfEo1s2QatkD7a/Se7fx9pub3Qojr2+Vw1O9y5k1hs1c4v6QBAdwoTvz7Z3XI2pXSAhD8gf1JK9Rkowln+RDD+way42p3WXiqenzwcETquXXzTqBB6yOVs0J1+uLMI8DIgKBOcL8R74xGdEmKntV7D5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751740205; c=relaxed/simple;
	bh=43ZIh2ngVODPHlb6rX3nplfNz3TrbIrDcbzYwUfHGbg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXHkxL9GMlAU06SwRv5zYnAvrBTls4weOJujjg8HKl2QeXkofc9GDUzSWmDpK2jVBA/rB0Ie5DKIl46E032ChGEJhJxkuqxh3gottJ4gm6Ot6MsyGVtW+8NOgbdGAIxlAY4gGEiP7pDyZiwVXcnL07ZM7z6cpkUrzSggDL9vh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=F4Ue/HjN; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1751740187; x=1751999387;
	bh=bM2teI22G3f2cdn97WzyTkn2kGIbnba3JaKLY/RW470=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F4Ue/HjNcwpmOo8yEjoywETP8BQBZIi35mgHXIWeFwWo/GLWk2iqnfJk/VUPkOwV8
	 mlS7iwfOIxP7CrWYCy3oULdFyzpVYyO/nyfYZ0IQ8an99SZPDrBU2VAyuTdtOWf77X
	 in1NIsr1t/ncOmG1BRiVgPsLswSS+QheNZYekGIYfYk8PWKMJviHBNo9OTpbktKlkz
	 vnr7RDClHaZwuXpjANTEvnFU3GXIX40dkcpPKdyBOZNZsTzNcwXIKUayMgeda5FyFc
	 iSaQdIUGJ5a7lh7dcmWIxKWbtial5GiscwSOLYay2U+KCH6q2+nqcKUY6at5ZDElUg
	 8thH9WlCcteTw==
Date: Sat, 05 Jul 2025 18:29:39 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/3] net: qrtr: Define macro to convert QMI version and instance to QRTR instance
Message-ID: <aMbAZigHiAN2xupOYs9DodY2mOdNtw_oVjOaweflgA8IoXRQ5ctoZ8GYJ8PNAKDgL4f9N_UD7tFmkePUy9BCE8v20Mae2x-eL1ZpyJEdLZY=@protonmail.com>
In-Reply-To: <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-3-y.oudjana@protonmail.com> <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 7492d43dc5683a87898c4defdf35e51e2e20b2a5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 9th, 2025 at 3:54 PM, Konrad Dybcio <konrad.dybcio@oss.=
qualcomm.com> wrote:

> On 4/6/25 4:07 PM, Yassine Oudjana wrote:
>=20
> > Move QRTR instance conversion from qmi_interface into a new macro in or=
der
> > to reuse it in QRTR device ID tables.
> >=20
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
> > ---
> > drivers/soc/qcom/qmi_interface.c | 5 +++--
> > include/linux/soc/qcom/qrtr.h | 2 ++
> > 2 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_in=
terface.c
> > index bc6d6379d8b1..cb57b7e1f252 100644
> > --- a/drivers/soc/qcom/qmi_interface.c
> > +++ b/drivers/soc/qcom/qmi_interface.c
> > @@ -14,6 +14,7 @@
> > #include <linux/workqueue.h>
> > #include <trace/events/sock.h>
> > #include <linux/soc/qcom/qmi.h>
> > +#include <linux/soc/qcom/qrtr.h>
> >=20
> > static struct socket *qmi_sock_create(struct qmi_handle *qmi,
> > struct sockaddr_qrtr *sq);
> > @@ -173,7 +174,7 @@ static void qmi_send_new_lookup(struct qmi_handle *=
qmi, struct qmi_service *svc)
> > memset(&pkt, 0, sizeof(pkt));
> > pkt.cmd =3D cpu_to_le32(QRTR_TYPE_NEW_LOOKUP);
> > pkt.server.service =3D cpu_to_le32(svc->service);
> > - pkt.server.instance =3D cpu_to_le32(svc->version | svc->instance << 8=
);
> > + pkt.server.instance =3D cpu_to_le32(QRTR_INSTANCE(svc->version, svc->=
instance));
> >=20
> > sq.sq_family =3D qmi->sq.sq_family;
> > sq.sq_node =3D qmi->sq.sq_node;
> > @@ -236,7 +237,7 @@ static void qmi_send_new_server(struct qmi_handle *=
qmi, struct qmi_service *svc)
> > memset(&pkt, 0, sizeof(pkt));
> > pkt.cmd =3D cpu_to_le32(QRTR_TYPE_NEW_SERVER);
> > pkt.server.service =3D cpu_to_le32(svc->service);
> > - pkt.server.instance =3D cpu_to_le32(svc->version | svc->instance << 8=
);
> > + pkt.server.instance =3D cpu_to_le32(QRTR_INSTANCE(svc->version, svc->=
instance));
> > pkt.server.node =3D cpu_to_le32(qmi->sq.sq_node);
> > pkt.server.port =3D cpu_to_le32(qmi->sq.sq_port);
> >=20
> > diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom/qrt=
r.h
> > index 4d7f25c64c56..10c89a35cbb9 100644
> > --- a/include/linux/soc/qcom/qrtr.h
> > +++ b/include/linux/soc/qcom/qrtr.h
> > @@ -13,6 +13,8 @@ struct qrtr_device {
> >=20
> > #define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> >=20
> > +#define QRTR_INSTANCE(qmi_version, qmi_instance) (qmi_version | qmi_in=
stance << 8)
>=20
>=20
> Please use FIELD_PREP + GENMASK to avoid potential overflows
>=20
> Konrad

Since I'm using this macro in initializing QRTR match tables I am unable to=
 use
FIELD_PREP. When I do, I get such errors:

In file included from ../arch/arm64/include/asm/sysreg.h:1108,
                 from ../arch/arm64/include/asm/memory.h:223,
                 from ../arch/arm64/include/asm/pgtable-prot.h:8,
                 from ../arch/arm64/include/asm/sparsemem.h:8,
                 from ../include/linux/numa.h:23,
                 from ../include/linux/cpumask.h:17,
                 from ../include/linux/smp.h:13,
                 from ../include/linux/lockdep.h:14,
                 from ../include/linux/mutex.h:17,
                 from ../include/linux/kernfs.h:11,
                 from ../include/linux/sysfs.h:16,
                 from ../include/linux/iio/buffer.h:9,
                 from ../drivers/iio/common/qcom_smgr/qcom_smgr.c:8:
../include/linux/bitfield.h:114:9: error: braced-group within expression al=
lowed only inside a function
  114 |         ({                                                         =
     \
      |         ^
../include/linux/soc/qcom/qrtr.h:21:10: note: in expansion of macro 'FIELD_=
PREP'
   21 |         (FIELD_PREP(GENMASK(7, 0), qmi_version) | FIELD_PREP(GENMAS=
K(15, 8), qmi_instance))
      |          ^~~~~~~~~~
../drivers/iio/common/qcom_smgr/qcom_smgr.c:825:29: note: in expansion of m=
acro 'QRTR_INSTANCE'
  825 |                 .instance =3D QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
      |                             ^~~~~~~~~~~~~
../include/linux/bitfield.h:114:9: error: braced-group within expression al=
lowed only inside a function
  114 |         ({                                                         =
     \
      |         ^
../include/linux/soc/qcom/qrtr.h:21:51: note: in expansion of macro 'FIELD_=
PREP'
   21 |         (FIELD_PREP(GENMASK(7, 0), qmi_version) | FIELD_PREP(GENMAS=
K(15, 8), qmi_instance))
      |                                                   ^~~~~~~~~~
../drivers/iio/common/qcom_smgr/qcom_smgr.c:825:29: note: in expansion of m=
acro 'QRTR_INSTANCE'
  825 |                 .instance =3D QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
      |                             ^~~~~~~~~~~~~

