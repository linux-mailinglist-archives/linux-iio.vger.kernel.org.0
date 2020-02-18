Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60838162AF9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRQq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 11:46:29 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:48234 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgBRQq3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 11:46:29 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IGkRso032095;
        Tue, 18 Feb 2020 08:46:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=fs5UmCeenYJHD34acKcRQRLLTw/ufjfD3zTVLVIDRcI=;
 b=amGed3yxci/Ci/3cWTtkMoYy6uVagMSEIGAaqnWJKu78EBxqTDrrCG5OX3QLjaAoPtFx
 v1/rl/CNPMjoR5EU+6RZukaKFwssJmvEHyVD3c/sr3Ba2MUmJ8LgtMbzXaVIGgIQ1Wm6
 etQpXQUk7k4kdzcTXy4Azy2b0TUASUTK73uSR0Jsihmf0838dYth/uWtbMCuM0qySANu
 ujOmflbGUgjfe11lN3QWjd2zD1fLCmTSaO6zV9RgcyLJXjN219PFkdmMrwQOhs8e3QaD
 SQsXD/R6EY7gt5hrTxA++Tli4/g13zuyGTE96LDWnnXdi8TNMA6oBpQk/8Sv4r0yh+QH gA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00328301.pphosted.com with ESMTP id 2y7f8m0ugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 08:46:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7cr1DzCFepAyhk5cdaIuxR60iQFwOADoUEcBNiUTvMEMWCiwPs1EtOOP1zzWxFbPEm3OZDVhJddkiSSrA22TYasdZowwv3TcaHtkX1Tx88X3FV8WNQQJjl8k31F6WjnhauXNAw9RrJoXOrHVev0/3/PoZc4XISwa3Y8kUWN0AV+o0KspgozBdgiIezE8wEHkYbFEpuHt9hLkqyeGJFT0gqDEzv6giOGKyIqzYwKuynWXVvdEx1A6rCI4fajz7Ht14Z43j9Ao2Rw/sHTR18w8oU3H6ppVwT28BCN9hY1i41nI7d7fbqHl6FXzycU4RZb1tLGA6bYRZ39q3ZXjCxj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs5UmCeenYJHD34acKcRQRLLTw/ufjfD3zTVLVIDRcI=;
 b=R9MFValslvC2QzG9QPB5ITQJioxvoZqQ8eAX3Z8EcbfiDRonJ5ogUcydbi3pBB1PfEkMPNiyEWZ8c39f90sEP3Vx90mfnTrtJ22ZLXqScNozC5i4RClhlEAdLZRUvMCIW4uwi4EcrIUAi+S2eIRpuXkGrnZ+f+r20KfZRtWQUtv8doS+h+Om5/Fr4H7MeM/3LTpN6k6ylDmoPPMPJirLn7AA4OmLM02QD6jV2zcjZ8/YFUOo5q6uye53cUCFWhEly9HTJRcB5R48A6v52pgJZTy7Nj4vjGcaKWP+JlF8C1LjKsA3lk006NuyfqUiZ912gnec9YFPOMWpRgEv+hf+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs5UmCeenYJHD34acKcRQRLLTw/ufjfD3zTVLVIDRcI=;
 b=WYZ2d0nqmj69gQ3W45hhNwO463/NocPZzNIkgpYwPlguq5TWhAQxEV+R6fOUN89+8RznbS1zQ2LwwxPLjwBB9Ss+5txSbAanGIJLS9ud8hlxDvznMW4hWDzcVmy81DPZ8sQMI8FoagFRHhnkQPXyluDGhFZza65UYdeaIdwzkLQ=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB3703.namprd12.prod.outlook.com (52.132.246.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Tue, 18 Feb 2020 16:46:24 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:46:24 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 13/13] iio: imu: inv_mpu6050: temperature only work with
 accel/gyro
Thread-Topic: [PATCH 13/13] iio: imu: inv_mpu6050: temperature only work with
 accel/gyro
Thread-Index: AQHV4cuu7p/Nv/76mEK79hfT1L9BdKgclmMAgASbu88=
Date:   Tue, 18 Feb 2020 16:46:24 +0000
Message-ID: <CH2PR12MB41810127CE6D45D0E75811FFC4110@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-14-jmaneyrol@invensense.com>,<20200215182316.1aecb37e@archlinux>
In-Reply-To: <20200215182316.1aecb37e@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1323b2b2-2050-40a3-8b47-08d7b492172f
x-ms-traffictypediagnostic: CH2PR12MB3703:
x-microsoft-antispam-prvs: <CH2PR12MB3703686B7215F1D4D9CF25BEC4110@CH2PR12MB3703.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39850400004)(396003)(189003)(199004)(4326008)(66556008)(66476007)(66446008)(66946007)(76116006)(64756008)(86362001)(91956017)(6916009)(7696005)(26005)(9686003)(8676002)(55016002)(81166006)(81156014)(2906002)(186003)(53546011)(6506007)(8936002)(478600001)(316002)(33656002)(71200400001)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3703;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTsHMh8lIjqNmyzVJSwCyyTQf28jTrjhw5MQAm7j5sk/yIpv+JuDIq4SK4Zfc9/movWEX3DYoa+NAUwEm2PbyCX40urvJBoQVIyTqa/HFmP3iQLzNshKyu0qdwIce9iYdefpULuEUGtJK944giVyP6AWJsyBLDelDjLoXsi8fSLDYt2abOvPHrUVpv2WEnGhOK0QWb2etJGthAyU4Lq0gGrl8b1wPso0ueCmRmcaFMZczajX21UZVshKCaMHHWkqoXs9Nm5o+8sheT5LFhrdQkHmt4wuipIzweEn+ENWEALZ/z9mlIrQlH6Rzv1H83Ljin+QwE2KgLgyR3avK8O2ewRsdOuiJD4f2JqP6pTQCKnKkTqephH3gcXeIx7zr5a6QqqIKgjC4YorTakx5dwJPY7F7Kk7xyz6T+m4Ljd6wmPEuA6MxJHEETk8I+mSpt8Y
x-ms-exchange-antispam-messagedata: LUDfOUxn704hd7O1Ge0DWF0ckkpCEv5cf4gO3r/cfBM2imQCUeFyPpIZ5lxFRaoN/7SEQnRJ2ZXy94d3/cRUp5Ft0JiXbYtw0tEeo6SaIIdHZHJY3+xwAu4/L9eGAg2Hh6/ZCf3mL+Y9BOC/ifBY8w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1323b2b2-2050-40a3-8b47-08d7b492172f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:46:24.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hriMPFo79CKrfYBdh9JDaN9YNT9WiTpe14N7+guiKFyWT1LfYr+/MK7gy5RR6/Z2StfzCg/HTSrh6V1nGDe93+GJj6RkoAp/V8HU/41hlf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3703
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
OK it makes sense. I will use -EBUSY in v2=0A=
=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Saturday, February 15, 2020 19:23=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 13/13] iio: imu: inv_mpu6050: temperature only work wit=
h accel/gyro=0A=
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
On Wed, 12 Feb 2020 18:40:48 +0100=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Temperature sensor works correctly only when accel and/or gyro=0A=
=0A=
> is turned on. Prevent polling value if they are not running.=0A=
=0A=
> Anyway it doesn't make sense to use it without sensor engines=0A=
=0A=
> on.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++=0A=
=0A=
>=A0 1 file changed, 5 insertions(+)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index f698d2aa61f4..3212030cc083 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -597,6 +597,11 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* temperature sensor work only wit=
h accel and/or gyro */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.accl_en && !st=
->chip_config.gyro_en) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
-ENOTSUPP;=0A=
=0A=
=0A=
=0A=
I'd suggest -EBUSY to indicate that it might work sometime in the future.=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->chip_config.temp_en=
) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resu=
lt =3D inv_mpu6050_switch_engine(st, true,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
=0A=
=0A=
=0A=
