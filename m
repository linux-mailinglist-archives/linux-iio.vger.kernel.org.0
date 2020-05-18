Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CE1D7CEE
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgERPeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 11:34:10 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:51534 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgERPeE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 11:34:04 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IFVZBN005947;
        Mon, 18 May 2020 08:33:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=hMu5JfqS2aHBvAVwpyxgkfyyTParYFpw84es1KAjgoU=;
 b=AyowP8oM6VgcrNQAHzWCRJc+COAJAqXq0l1gJwLOFRUtt09xPbtbY74A/vUiPftMggiv
 BZixMdWASNrfD1OLmXVzkPL1KRez9KIdtAj0JDfVbZRh10R4f86zqz62SEjqWJl3bzT5
 byx0WsoPkAx6PlwNb8u82RM5Ax/DrCc3u1FpAYHlmdlfieADMFSGOcclAWILsQ9eS4cu
 EOOn681iwecnJh5624apo8yZ3jzZDhrM/zWIeWZsQ89X1MyJe6vPMZp7i8iwBYAHzU8c
 Qre9u1JEhFVj6z1X7pdYRtF8Q2yPljKPnqDNz1p8Twk+P9OX9KCeal2b5MCu11EXWEKM bA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-00328301.pphosted.com with ESMTP id 313dph8aqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 08:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcHXWsP3gGkAhHHk1OG3/QdaKK/fz8z4UxbGe79KJA9WD1Vz7AxGG0Tgz4PTEQCUXNbm82KrU6rkrwXAoNcDy9Xw5PF6U0/ILMtA5IBdz5btZMwIH+iy9ML7CxSZoWZK+EPDtVIlu7v1PwIop5/HsbSyBc/Lkoo25nw8eiVzZcEfV8kdggXr4t0KEGjxpw5kEcCw6MaMQ3nQQ1j80CLMyUz0MK2G5GzsyVvSzcqAdpU1wiY5pMr3eVd3aZNtfgFUUryqqajEaHCBHOFkjoWtNQNRYzJUnTd8exIN08L/yl+//XW2nGa59uNlNr0FGdmBmpvLArLZpXhNULDjV1znKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMu5JfqS2aHBvAVwpyxgkfyyTParYFpw84es1KAjgoU=;
 b=RISXSWivJr7CJS4FssBGjOIgey1Qu+hL2JAkGTy1+tCYFb+DsNk36H0iFTngO3Ngv6uTX3NA8/EiCaRgybC0ZoH211vMXd1g5rALSz564GfvsLdhHhUmZbaRY0R2aJhBFwMXyUJct+gM9mjsqzktuIvZ/Rj+/muFnc+/ZLTAnYB8ZDiIA8vLweXg4WhoJ6+793teXGPKwVLJVjjFiW9tb+fmqJQECRoVipY6xixim6Z2Ig8OTYEssZjUGKq48Z7V84aCgvFM5sn+sri2+bhce6sB/pHntphHb8N5ATr61NglDBru++zaa/SpyMwHyy4gP/t3bbxxP8RzStCIlWTwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMu5JfqS2aHBvAVwpyxgkfyyTParYFpw84es1KAjgoU=;
 b=B5v5opfHaIUnuubNihSXa9NeSbWkpXulCMJD4HlBXMCVkCFOjVDck8LiL3mnRF11/v3MzVDxJj2sxVI2ULBGZvK+OAkjTaIruIzLaPTkbT7EmPRPQ8lXf5a5hsFkQxAksRydy95PI/Scnhqn0gMPmPMJEXgrEKqx7i0rtanau8M=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 15:33:45 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 15:33:45 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Thread-Topic: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Thread-Index: AQHWJH3VTdruQdr81U6zFO6GVd/AHKieOT0AgA/Om3aAAAJhcw==
Date:   Mon, 18 May 2020 15:33:45 +0000
Message-ID: <MN2PR12MB44221A85B6BE6548CFE80572C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-5-jmaneyrol@invensense.com>,<20200508150104.000010c2@Huawei.com>,<MN2PR12MB4422B32CB3C4BFD0AF5FFF3CC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4422B32CB3C4BFD0AF5FFF3CC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d681a660-f114-4357-b921-08d7fb40da5e
x-ms-traffictypediagnostic: MN2PR12MB3071:
x-microsoft-antispam-prvs: <MN2PR12MB30715B59F451BC5D5AD3920AC4B80@MN2PR12MB3071.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3LoXr9nFQsliyoGajE6G0LTyQmPrzQ9U+hbi9Xh1iDa4dFWYPfToXkRf3qZ4unHO9BHFWt/84Dp8eCzWlKzeLW/Vt+YdHUGWHe1BYLm/i0y4Wp9fLLfact03yPZmp+w5vCWqlKeUdpgUSXu1R5/lP3WkPQOja/LSDv9rOC0/h5yddG096unuzx4rC3W2XLIUf+DLaY2cvuCmAfrxlsxiq7VIdsNBzJ3k/YtA2AHEW5cg2s5TyDoB1O+LtNd4HKCOQn6eZZ5nE/8UwxfTR5FfMD/2yuIq8/Ra+psDlgChVfnOQczJ3JVEtOXBrJioPVGTlsoW4Apj3lhcXa/9CBazqSV4XIEoSYzdkz+ERxNkmGFojIiVsyprEeIR4d44UPHs3iFiSlPGR+dhWgDwIZK+XodyyFzDH9hlw8jHtJ6Z1mRUXuVD99XPzLzNNOIrZZw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(39850400004)(136003)(346002)(30864003)(186003)(86362001)(2906002)(7416002)(26005)(66446008)(64756008)(66556008)(76116006)(91956017)(66946007)(66476007)(33656002)(71200400001)(52536014)(6916009)(316002)(5660300002)(53546011)(8676002)(54906003)(6506007)(4326008)(478600001)(8936002)(2940100002)(7696005)(55016002)(9686003)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HOxK3J7/mvWoC9Zmm6J0GeBg3dBXl23A/T4dST2i2ITKX1U3f7dyJp8d5VVPD4sC4sjdfUetER12Uy4Zwoth2Jpyu9yr5hOOb3WeU7EvfYyxIdq2ul0h2ip+vWJqAQx06lSnLpzZnFBOwlr95dQCZDQHNhpi1d3/ptHqV7P8nSiJKaznluie4KxNIRDOf6uCV0AWcumy4jTc4kFdNnZeEZyPTunVjtX+xxs7KvK4MxXw9mBrlUnzbp7d08Ici28DNC+g/+RzEUqQ8E6auYrC+zZGX7WVWw1pgbOF3gCZ6jbLrhMNRvInmv52iqY2jNbfk4tbmsXmBMv/J0kpPnoPZV08G0wHq1Uof4FOYy2zUOb/BM1wcwSrX0FqKvcN1BUK4uWjTGT5A12liUw0pGSigkc6pRqdQjvpo0aXWuIW4Yq9NWYQpDBczLHR7Hh7Fe8+Ml6KOfcqjRokxVnCVeTWu5IDRxAPRAw1fsFqZDlSVXQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d681a660-f114-4357-b921-08d7fb40da5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 15:33:45.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjYnm9SbdWY0gE1jWLfhs3iV54+rjUAsE7SfBUGh6yF74BBBqPnz2ZCL6t3jbTQ7WSUJEab6Ujhayg/PcaYt4juSnO2JyFcD1IfdS3sR1dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 cotscore=-2147483648 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I agree with all comments.=0A=
=0A=
For regmap_bulk_read, by looking at source code it doesn't seem to requires=
 specific alignment, except if bus read callback is expecting that. But I c=
an see numerous drivers calling regmap_bulk_read with a data buffer on the =
stack and not particularly aligned.=0A=
=0A=
And we definitely can read calibration offset registers while running, the =
lock is indeed not needed.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 16:01=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: jic23@kernel.org <jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel=
.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mcheha=
b+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@lin=
uxfoundation.org <gregkh@linuxfoundation.org>;=0A=
 linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.ker=
nel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device=
=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Thu, 7 May 2020 16:42:14 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Add IIO device for gyroscope sensor with data polling interface.=0A=
=0A=
> Attributes: raw, scale, sampling_frequency, calibbias.=0A=
=0A=
> =0A=
=0A=
> Gyroscope in low noise mode.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Few trivial things and questions inline.=0A=
=0A=
=0A=
=0A=
J=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0=A0 4 +=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0=A0 5 +=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0 | 549 ++++++++++++++++=
++=0A=
=0A=
>=A0 3 files changed, 558 insertions(+)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
=0A=
> index 8da4c8249aed..ca41a9d6404a 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> @@ -120,6 +120,7 @@ struct inv_icm42600_suspended {=0A=
=0A=
>=A0=A0 *=A0 @orientation:=A0=A0=A0 sensor chip orientation relative to mai=
n hardware.=0A=
=0A=
>=A0=A0 *=A0 @conf:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip sensors configuratio=
ns.=0A=
=0A=
>=A0=A0 *=A0 @suspended:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 suspended s=
ensors configuration.=0A=
=0A=
> + *=A0 @indio_gyro:=A0=A0=A0=A0 gyroscope IIO device.=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -131,6 +132,7 @@ struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix orientation;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_conf conf;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_suspended suspended;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
=0A=
> @@ -369,4 +371,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_de=
v, unsigned int reg,=0A=
=0A=
>=A0 int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_bus_setup bus_setup);=0A=
=0A=
>=A0 =0A=
=0A=
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
=0A=
> +=0A=
=0A=
>=A0 #endif=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> index 35bdf4f9d31e..151257652ce6 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> @@ -503,6 +503,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* create and init gyroscope iio device */=0A=
=0A=
=0A=
=0A=
'Kind' of obvious from function name?=A0=A0 Maybe drop the comment?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_init(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* setup runtime power management */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D pm_runtime_set_active(dev);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..74aa2b5fa611=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> @@ -0,0 +1,549 @@=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/mutex.h>=0A=
=0A=
> +#include <linux/interrupt.h>=0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/delay.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=A0=
=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_ANGL_VEL,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .modified =3D 1,=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .channel2 =3D _modifier,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_RAW) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_CALIBBIAS),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_type =3D=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SCALE),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_type_available=
 =3D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SCALE),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_all =3D=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SAMP_FREQ),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_shared_by_all_available =
=3D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHA=
N_INFO_SAMP_FREQ),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D '=
s',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits =
=3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storagebit=
s =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .shift =3D =
0,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
Shift has the 'obviously' default of 0, so normally we don't bother explici=
tly=0A=
=0A=
setting it to 0 like this.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .endianness=
 =3D IIO_BE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ext_info =3D _ext_info,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +enum inv_icm42600_gyro_scan {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_X,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Y,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Z,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[]=
 =3D {=0A=
=0A=
> +=A0=A0=A0=A0 IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_=
matrix),=0A=
=0A=
> +=A0=A0=A0=A0 {},=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static const struct iio_chan_spec inv_icm42600_gyro_channels[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM42600_GYRO_SCAN_X,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM42600_GYRO_SCAN_Y,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int reg;=0A=
=0A=
> +=A0=A0=A0=A0 __be16 data;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
X;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
Y;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_=
Z;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* enable gyro sensor */=0A=
=0A=
> +=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* read gyro register data */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, reg, &data, sizeof(data))=
;=0A=
=0A=
=0A=
=0A=
IIRC bulk reads need to be to dma safe buffers.=A0 So typically on the stac=
k and=0A=
=0A=
in appropriately aligned location in any containing structure.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 *val =3D (int16_t)be16_to_cpu(data);=0A=
=0A=
> +=A0=A0=A0=A0 if (*val =3D=3D INV_ICM42600_DATA_INVALID)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
> +exit:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/* IIO format int + nano */=0A=
=0A=
> +static const int inv_icm42600_gyro_scale[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 2000dps =3D> 0.001065264 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS + 1] =3D 1065264,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 1000dps =3D> 0.000532632 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS + 1] =3D 532632,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 500dps =3D> 0.000266316 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_500DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_500DPS + 1] =3D 266316,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 250dps =3D> 0.000133158 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_250DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_250DPS + 1] =3D 133158,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 125dps =3D> 0.000066579 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_125DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_125DPS + 1] =3D 66579,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 62.5dps =3D> 0.000033290 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] =3D 33290,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 31.25dps =3D> 0.000016645 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] =3D 16645,=0A=
=0A=
> +=A0=A0=A0=A0 /* +/- 15.625dps =3D> 0.000008322 rad/s */=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS] =3D 0,=0A=
=0A=
> +=A0=A0=A0=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] =3D 8322,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 idx =3D st->conf.gyro.fs;=0A=
=0A=
=0A=
=0A=
Seems like we shouldn't need the lock to retrieve a single value.=0A=
=0A=
Is there some odd intermediate state somewhere I'm missing?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 *val =3D inv_icm42600_gyro_scale[2 * idx];=0A=
=0A=
> +=A0=A0=A0=A0 *val2 =3D inv_icm42600_gyro_scale[2 * idx + 1];=0A=
=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); =
idx +=3D 2) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val =3D=3D inv_icm42600_gyro_sc=
ale[idx] &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 val2 =3D=3D inv_icm42600_gyro_scale[idx + 1])=0A=
=0A=
=0A=
=0A=
Alignment of code seems odd.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_scale))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update gyro fs */=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 conf.fs =3D idx / 2;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/* IIO format int + micro */=0A=
=0A=
> +static const int inv_icm42600_gyro_odr[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 12.5Hz */=0A=
=0A=
> +=A0=A0=A0=A0 12, 500000,=0A=
=0A=
> +=A0=A0=A0=A0 /* 25Hz */=0A=
=0A=
> +=A0=A0=A0=A0 25, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 50Hz */=0A=
=0A=
> +=A0=A0=A0=A0 50, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 100Hz */=0A=
=0A=
> +=A0=A0=A0=A0 100, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 200Hz */=0A=
=0A=
> +=A0=A0=A0=A0 200, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 1kHz */=0A=
=0A=
> +=A0=A0=A0=A0 1000, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 2kHz */=0A=
=0A=
> +=A0=A0=A0=A0 2000, 0,=0A=
=0A=
> +=A0=A0=A0=A0 /* 4kHz */=0A=
=0A=
> +=A0=A0=A0=A0 4000, 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static const int inv_icm42600_gyro_odr_conv[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_12_5HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_25HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_50HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_100HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_200HZ,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_1KHZ_LN,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_2KHZ_LN,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ODR_4KHZ_LN,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int i;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 odr =3D st->conf.gyro.odr;=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(inv_icm42600_gyro_odr_conv); +=
+i) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (inv_icm42600_gyro_odr_conv[i] =
=3D=3D odr)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 if (i >=3D ARRAY_SIZE(inv_icm42600_gyro_odr_conv))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 *val =3D inv_icm42600_gyro_odr[2 * i];=0A=
=0A=
> +=A0=A0=A0=A0 *val2 =3D inv_icm42600_gyro_odr[2 * i + 1];=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int idx;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600_gyro_odr); id=
x +=3D 2) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (val =3D=3D inv_icm42600_gyro_od=
r[idx] &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 val2 =3D=3D inv_icm42600_gyro_odr[idx + 1])=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_odr))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update gyro odr */=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 conf.odr =3D inv_icm42600_gyro_odr_conv[idx / 2];=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int reg;=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t data[2];=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R1;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R3;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* read gyro offset data */=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, reg, &data, sizeof(data))=
;=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D (int16_t)(((data[1] & 0x0F=
) << 8) | data[0]);=0A=
=0A=
=0A=
=0A=
This doesn't look right for negative values.=A0 You would be better=0A=
=0A=
off with a sign extend of the 12 bit value.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D (int16_t)(((data[0] & 0xF0=
) << 4) | data[1]);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D (int16_t)(((data[1] & 0x0F=
) << 8) | data[0]);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +exit:=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int reg, regval;=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t data[2];=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R1;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D INV_ICM42600_REG_OFFSET_USE=
R3;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* value is limited to 12 bits signed */=0A=
=0A=
> +=A0=A0=A0=A0 if (val < -2048 || val > 2047)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
=0A=
=0A=
Perhaps worth an available callback to give the range?=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (chan->channel2) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_X:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER1 register is shared =
*/=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER1,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[0] =3D val & 0xFF;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[1] =3D (regval & 0xF0) | ((val=
 & 0xF00) >> 8);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Y:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER1 register is shared =
*/=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER1,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[0] =3D ((val & 0xF00) >> 4) | =
(regval & 0x0F);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[1] =3D val & 0xFF;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MOD_Z:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* OFFSET_USER4 register is shared =
*/=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_IC=
M42600_REG_OFFSET_USER4,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &regval);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[0] =3D val & 0xFF;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[1] =3D (regval & 0xF0) | ((val=
 & 0xF00) >> 8);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_write(st->map, reg, data, sizeof(data))=
;=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2, long mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int16_t data;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_RAW:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_read_sens=
or(st, chan, &data);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D data;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_read_scale=
(st, val, val2);=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_read_odr(s=
t, val, val2);=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
=0A=
=0A=
I'm curious.=A0 Why can't we read back a calibration offset whilst doing=0A=
=0A=
buffered capture?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_read_offs=
et(st, chan, &data);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D data;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const int **vals,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *type, int *length, long mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *vals =3D inv_icm42600_gyro_scale;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *type =3D IIO_VAL_INT_PLUS_NANO;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *length =3D ARRAY_SIZE(inv_icm42600=
_gyro_scale);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_AVAIL_LIST;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *vals =3D inv_icm42600_gyro_odr;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *type =3D IIO_VAL_INT_PLUS_MICRO;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *length =3D ARRAY_SIZE(inv_icm42600=
_gyro_odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_AVAIL_LIST;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val, int val2, long mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_write_sca=
le(st, val, val2);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_icm42600_gyro_write_odr(=
st, val, val2);=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_write_off=
set(st, chan, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_s=
pec const *chan,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 long mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type !=3D IIO_ANGL_VEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (mask) {=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_NANO;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SAMP_FREQ:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_CALIBBIAS:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static const struct iio_info inv_icm42600_gyro_info =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .read_raw =3D inv_icm42600_gyro_read_raw,=0A=
=0A=
> +=A0=A0=A0=A0 .read_avail =3D inv_icm42600_gyro_read_avail,=0A=
=0A=
> +=A0=A0=A0=A0 .write_raw =3D inv_icm42600_gyro_write_raw,=0A=
=0A=
> +=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_gyro_write_raw_get_fmt,=
=0A=
=0A=
> +=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_gyro_init(struct inv_icm42600_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 const char *name;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->nam=
e);=0A=
=0A=
> +=A0=A0=A0=A0 if (!name)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev =3D devm_iio_device_alloc(dev, 0);=0A=
=0A=
> +=A0=A0=A0=A0 if (!indio_dev)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 iio_device_set_drvdata(indio_dev, st);=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->dev.parent =3D dev;=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->name =3D name;=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->info =3D &inv_icm42600_gyro_info;=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_gyro_channels;=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_gyro_ch=
annels);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->indio_gyro =3D indio_dev;=0A=
=0A=
> +=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_gyro);=0A=
=0A=
> +}=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
