Return-Path: <linux-iio+bounces-20963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D037AE8B41
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00883B94A1
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7A273D74;
	Wed, 25 Jun 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QYYsoD6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E08824A3;
	Wed, 25 Jun 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871366; cv=none; b=uO0fWoSn3SbghpzcbP36d0gV3U71BxOmqFlxPK0QGVG5gnqHdL9nkbANXnyRaDodWBAXbQSP13rBWWjkEDUpJZm9LtiRrH467cetw/lMgnyw4U9zqb7Mp+0GpdXyirgcuAszpeWtDYi3cknJ+DTLeJKzQhT9YKv85EakPDViiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871366; c=relaxed/simple;
	bh=mOUyii4I9lrSkNP9KAS0/Fo4HRjD6JuuBO3Yq3cQtu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/7/Su2iRgARXt2MjmBtRTYpaRh4DIvpYhc0qRp8QHm6/VXavo+ecdWhU0kUN2UAk2graW3M3uP0n12WMrXdNiMpHtp3rWTj96/eptxR8nOX70PnASFbs0Cjo+iOx+cDvc1CWOe7DHap7Z9KXOzih1p8pJCtLNcq9UxVzd70WXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=QYYsoD6D; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1750871355; x=1751130555;
	bh=mOUyii4I9lrSkNP9KAS0/Fo4HRjD6JuuBO3Yq3cQtu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QYYsoD6DiOvasJLEoZJLo8VlnWESYPZJgj9k3hVfyposf/xMKpJfcb0ay/kZ0cb9c
	 /IlFc0LNesFMKQIe49DUMpPKI5wy/V09d17stzZd5m9hM8prjjrA4L+Fyw3evbeQP6
	 +Hh3CrjT9XChSZ3FcEtAinYGvkJSRqViXwhmPYVBDBOILf8UgHdYcXCDTmgkoHsiGm
	 i9pyB7ouQVvydkUSFOd0/LLDElZCKpePsQUBJpHLVFDK69ghryjV63RlnAuOGCJ9uC
	 HtEafLuWbbSK0ww1Dr3yuIX7LD0rhhpnlGt0zYsOuXyz2LOsP50ezgic0UzhxOapfQ
	 Otx7AgUMsc5sw==
Date: Wed, 25 Jun 2025 17:09:10 +0000
To: Luca Weiss <luca@lucaweiss.eu>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Message-ID: <WHAT3OVKsj4znTv7P1Y3TGotHKfpY-MGDDVHuZyL-vp5iU7mU353Nf9expuvrTv5uaQ772ybJuTKEiy0WR3lcM4xRRSummPjrVcrPfq-JkQ=@protonmail.com>
In-Reply-To: <ea183f5a-b4c8-4dc0-960f-dba0db5a5abb@lucaweiss.eu>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-4-y.oudjana@protonmail.com> <ea183f5a-b4c8-4dc0-960f-dba0db5a5abb@lucaweiss.eu>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 5603c40deb6696a70588c6d5989d7521b94b5071
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Wednesday, June 18th, 2025 at 8:19 PM, Luca Weiss <luca@lucaweiss.eu> wr=
ote:

> Hi Yassine!
>=20
> On 06-04-2025 4:08 p.m., Yassine Oudjana wrote:
>=20
> > Add drivers for sensors exposed by the Qualcomm Sensor Manager service,
> > which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> > include accelerometers, gyroscopes, pressure sensors, proximity sensors
> > and magnetometers.
> >=20
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
>=20
>=20
> <snip>
>=20
> > +static const char *const qcom_smgr_sensor_type_platform_names[] =3D {
> > + [SNS_SMGR_SENSOR_TYPE_ACCEL] =3D "qcom-smgr-accel",
> > + [SNS_SMGR_SENSOR_TYPE_GYRO] =3D "qcom-smgr-gyro",
> > + [SNS_SMGR_SENSOR_TYPE_MAG] =3D "qcom-smgr-mag",
> > + [SNS_SMGR_SENSOR_TYPE_PROX_LIGHT] =3D "qcom-smgr-prox-light",
> > + [SNS_SMGR_SENSOR_TYPE_PRESSURE] =3D "qcom-smgr-pressure",
> > + [SNS_SMGR_SENSOR_TYPE_HALL_EFFECT] =3D "qcom-smgr-hall-effect"
> > +};
> > +
> > +static void qcom_smgr_unregister_sensor(void *data)
> > +{
> > + struct platform_device *pdev =3D data;
> > +
> > + platform_device_unregister(pdev);
> > +}
> > +
> > +static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
> > + struct qcom_smgr_sensor *sensor)
> > +{
> > + struct platform_device *pdev;
> > + const char *name =3D qcom_smgr_sensor_type_platform_names[sensor->typ=
e];
>=20
>=20
> On msm8226 lg-lenok I get NULL here leading to a crash with the next call=
.
>=20
> I get sensor->type=3D0 for some heart rate sensor on that watch. I've
>=20
> added this patch on top to fix that (excuse the formatting):

I don't see your patch, but I already have a fix and will include it in the=
 next
iteration.

>=20
> <snip>
>=20
> > diff --git a/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h b/drivers/iio/=
common/qcom_smgr/qmi/sns_smgr.h
> > new file mode 100644
> > index 000000000000..a741dfd87452
> > --- /dev/null
> > +++ b/drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
> > @@ -0,0 +1,163 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only /
> > +
> > +#ifndef SSC_SNS_SMGR_H
> > +#define SSC_SNS_SMGR_H
> > +
> > +#include <linux/iio/common/qcom_smgr.h>
> > +#include <linux/soc/qcom/qmi.h>
> > +#include <linux/types.h>
> > +
> > +/
> > + * The structures of QMI messages used by the service were determined
> > + * purely by watching transactions between proprietary Android userspa=
ce
> > + * components and SSC. along with comparing values reported by Android=
 APIs
> > + * to values received in response messages. Due to that, the purpose o=
r
> > + * meaning of many fields remains unknown. Such fields are named "val*=
",
> > + * "data*" or similar. Furthermore, the true maximum sizes of some mes=
sages
> > + * with unknown array fields may be different than defined here.
> > + */
> > +
> > +#define SNS_SMGR_QMI_SVC_ID 0x0100
> > +#define SNS_SMGR_QMI_SVC_V1 1
> > +#define SNS_SMGR_QMI_INS_ID 50
>=20
> This instance ID needs to be 0 on msm8974 and msm8226, so I assume we
> don't want to make this a define but just add the 50 and the 0 as-is to
> the match table?

Yes that is a better idea.


