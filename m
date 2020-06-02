Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45C1EB6DD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgFBH45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 03:56:57 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:37576 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgFBH44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 03:56:56 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527u62p015760;
        Tue, 2 Jun 2020 00:56:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=LguisFAFWr/bLYjUdsBEhwjDrM9LymWyyntbhvFGj1s=;
 b=S5kVSowv66vd5yO2Bmm8o9rmaPmUEaIgGLyU50U2OjYByb1fMpQ+bTujNsCcFBPsQgpU
 CX+OoYW/CbA86GUci1LMccE/cBa1FA2OxkU5jMr590NS2jNHU1IsBWaLaVENPM3+iGGA
 X0tD1wfDWBjVZKb3YFkDTP+DOModucg5v0X0LROu/YoNjlFQMVilicPtBLR6pSka5XRc
 qkCX9MsnauVRTjJnVkwxMkccVrkx/n5EwpfVw0FkSjftNIs3+sCkQ7x4mO6D5RDE42Kb
 3/idAg1KJ6y/NIkgVuS1Vb5Y4bmp+wn/p7i4kFC/LpWcvpnHzQWCI5g5idCjLo61nwqQ ew== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00328301.pphosted.com with ESMTP id 31c6bv8vje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk7MPINwAdBnTx9e1gCJhy0XQ/oKPQEswtHTciI0hPyBE6DKqvQoic67XER+xahxvu3ihFo9OWni2LL8P9RKXnXAs+umuc+1AONv0dEtzuogY5DlWcOkOyj7TBHmgPmUkG9OMpvOjuKYgG3eG63pvS/JFGl91GVjWcGSgaEne4kEag0ElELQ5t45hWpjLqGGX8oInVGrUik2l++Jo1v902I4HDcveI3bg72O9EPRJHuRyoYqwbfC8lhJrJBij9w+/ZNMs9k++mu2QAHBKA3WOHlsOBVtXx9dciHY2aUTZX4Amk+AfCwEDXgUrXO6rknxEySJZv1Pka9Ll6aaOaFUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LguisFAFWr/bLYjUdsBEhwjDrM9LymWyyntbhvFGj1s=;
 b=da146BtT3sjDvm5rhW73+El0dtoippyzJdFewdOVxaLElUT83aOPw8Qr7UyIl2Zr5P2pV+TPLZeIJzrJXe443w+DXX3ZUIyt7iNQrIFj7icGEHplmyuOu9bLSZzaA86Wi0tT+/lta2ll2ItLk2SVflRomF87x+56R15kr5JYWKcgvoOiWls9QRLxtdQBO+ZblB6/JyIQ2iP5DIz1hlCmSIgd5uQZomTG8RGpGT1NmXOT33cfgoKlNwGvVxSTLgP6K5NW80DbN8v6bGEZZwWvD1x4gjW/utVnGrExp3tSGK/xLOuyErFy2TpEh61tRCb2oy3LzEg6CRD/8rMSrQVkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LguisFAFWr/bLYjUdsBEhwjDrM9LymWyyntbhvFGj1s=;
 b=hTVwypkMItaAMiTz1+qy1mUvv13skKYdLhocBizJcWbIa0G9mAEO+vF+fbPiFSUTzcRz6Xg4Eq0rn8XQiqrW/yGV5EhHY09yVmsJ0xst87OEUIP1TkaauCy0ifPTRicQluleufQxrWIx0v2sTLmagxcZlsP4ABJLUz/oMjb13j4=
Received: from SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 07:56:49 +0000
Received: from SA0PR12MB4429.namprd12.prod.outlook.com
 ([fe80::ac33:2814:cdd:8b27]) by SA0PR12MB4429.namprd12.prod.outlook.com
 ([fe80::ac33:2814:cdd:8b27%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 07:56:49 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Thread-Topic: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Thread-Index: AQHWNFiy1AUblJwCrUiUeaBFQvIyCqjCFjyAgALmB2A=
Date:   Tue, 2 Jun 2020 07:56:49 +0000
Message-ID: <SA0PR12MB442938879EF3BDB4B813EC59C48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-2-jmaneyrol@invensense.com>,<20200531123437.05b3df36@archlinux>
In-Reply-To: <20200531123437.05b3df36@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec10d23-6153-4050-5b27-08d806ca817b
x-ms-traffictypediagnostic: SA0PR12MB4592:
x-microsoft-antispam-prvs: <SA0PR12MB4592B7A6D1A34AF61B40D9B9C48B0@SA0PR12MB4592.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uj88b+ntYwCR239xjxo6l1oLs5DrmHyk2a0rvpqZtA9CyyRrQ5dOcIrlZxizazHggAyTF1ajC/35360FGd19xYmEzixPzjR+5HZPWOTm3E2Uw6upZojGg+mY26obwFylcYzx1OkGLvA6il4CUKugyVGg2pun7m1UZI2IjQ1fo3L+W3x1/Au4XpRYcx4BxeiJG/vVYudeHCesgTezqN2ze3CuMjv50MeuwCduv62TIXqM/wac/dtdOIYtj9FbvgCe6mvWHXD5r8Chbqaew9cHFgTOSbLPJ/xkd4E6yVsDEvvDNmP5qnNzWufZf67HSzjXsl9mWNCqg8ado+J/rTmrug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4429.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39850400004)(136003)(376002)(396003)(366004)(186003)(2906002)(54906003)(83380400001)(9686003)(478600001)(26005)(4326008)(71200400001)(7696005)(6916009)(316002)(8676002)(8936002)(6506007)(53546011)(66556008)(86362001)(91956017)(76116006)(66476007)(66946007)(33656002)(52536014)(66446008)(64756008)(5660300002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: anPBwwRavKiG5Komimdc0vhyHDdnyL42/qV/zY/JAA+5g3T0aB6cUollkR9nax/d0QiaCnhVz6/+dwS4x2zCecazoFwLfDsF7Dt4Gij7+dP9x2fKpVRJ8BUzgMxSq++2tTJohOsLMBcu07e2xPWYIUB7TRXwyyH93zYMwg9P4oOO8t/Dkatne4ufqfPFDfYOYiJLNftqr4GLkd3t1FO4vqsYSy777ibfgIRVZMjDKEh8CVO25VIVvMmC2xbDMPDMPqR5Z6dGw4oiuaxwxCAn5LFSFXyB4gb3Bq+wt+L6m6WV6esMxLmv2wNz/h0PDFUek9Vaagsa9yppjMrvLt0uPj7ugXYrciugFmIXKr+m/QxPVJP09GIwBSY/aPjw/PgHxM+A1rIKvf0qQHtnn0OaWDCM+iap4G+/AfXVpPGmfh88wiFXKmSgkth8IQuUdghnx4u3wnKqCWBMLK35CDYTWBAE5fufxpvhRqu/CDnrhfE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec10d23-6153-4050-5b27-08d806ca817b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:56:49.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4H0Cf/es08SBCO2anPSkwHKRsWVpid5+6Vzja8oOOBmKxHMyMlnJO9xT5kDt01eQBfstnYA4L/IqakKek3rvhIH1O+WcwH3+jjPfGWoa9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 cotscore=-2147483648 suspectscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I've given my review tag for the const change of iio_device_get_drvdata(). =
Would be perfect to have this cleaned up for the v3.=0A=
=0A=
For vddio regulator you are missing something. In all suspend callbacks (sy=
stem and runtime) I am calling directly regulator_disable to shut vddio off=
 at then end. And in all resume callbacks I am calling inv_icm42600_enable_=
regulator_vddio() that is turning vddio regulator back on and is sleeping t=
o wait a little for the supply ramp.=0A=
=0A=
Indeed this doesn't look symmetric, but I was not very happy to add a inv_i=
cm42600_disable_regulator_vddio() that would just do regulator_disable, or =
copy/paste the sleeping value in all resume handlers.=0A=
=0A=
Tell me what you prefer.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, May 31, 2020 13:34=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.o=
rg>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft=
.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree=
@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new inv_i=
cm42600 driver =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Wed, 27 May 2020 20:57:00 +0200=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
> Core component of a new driver for InvenSense ICM-426xx devices.=0A=
> It includes registers definition, main probe/setup, and device=0A=
> utility functions.=0A=
> =0A=
> ICM-426xx devices are latest generation of 6-axis IMU,=0A=
> gyroscope+accelerometer and temperature sensor. This device=0A=
> includes a 2K FIFO, supports I2C/I3C/SPI, and provides=0A=
> intelligent motion features like pedometer, tilt detection,=0A=
> and tap detection.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
A few things inline.=0A=
=0A=
Either I'm missing something or I'm guessing vddio is not controllable=0A=
on your test board.=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 | 372 ++++++++++=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 | 635 ++++++++++++++++=
++=0A=
>=A0 2 files changed, 1007 insertions(+)=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> =0A=
=0A=
...=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> new file mode 100644=0A=
> index 000000000000..81b171d6782c=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> +const struct iio_mount_matrix *=0A=
> +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 const struct iio_chan_spec *chan)=0A=
> +{=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_state *st =3D=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_=
get_drvdata((struct iio_dev *)indio_dev);=0A=
=0A=
If you review my patch to the core, I can get that applied and we can drop=
=0A=
the ugly cast from here!=0A=
=0A=
Just waiting for someone to sanity check it.=0A=
> +=0A=
> +=A0=A0=A0=A0 return &st->orientation;=0A=
> +}=0A=
...=0A=
=0A=
> +/* Runtime suspend will turn off sensors that are enabled by iio devices=
. */=0A=
> +static int __maybe_unused inv_icm42600_runtime_suspend(struct device *de=
v)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* disable all sensors */=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_=
MODE_OFF,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_OFF, false=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 regulator_disable(st->vddio_supply);=0A=
=0A=
Don't seem to turn this on again in runtime_resume..=0A=
Why?=A0 Definitely needs at least a comment.=0A=
=0A=
> +=0A=
> +error_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +/* Sensors are enabled by iio devices, no need to turn them back on here=
. */=0A=
> +static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev=
)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D dev_get_drvdata(dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_enable_regulator_vddio(st);=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +const struct dev_pm_ops inv_icm42600_pm_ops =3D {=0A=
> +=A0=A0=A0=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_=
resume)=0A=
> +=A0=A0=A0=A0 SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in=
v_icm42600_runtime_resume, NULL)=0A=
> +};=0A=
> +EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);=0A=
> +=0A=
> +MODULE_AUTHOR("InvenSense, Inc.");=0A=
> +MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");=0A=
> +MODULE_LICENSE("GPL");=0A=
