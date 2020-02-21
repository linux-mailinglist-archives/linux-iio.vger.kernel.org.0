Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5B167F86
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 15:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBUODq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 09:03:46 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:29898 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728732AbgBUODp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 09:03:45 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDqBb3014240;
        Fri, 21 Feb 2020 06:03:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=ZCHcat38gufF9o0J6P9JkttfQOZe9bPj5PbzC/6qYEU=;
 b=yXNhAPJPe/4bfZ2mDv8UPgi/QykQi7MWVjH3mZiueJmCNDQACIYaMoAEYoY620UKgdaS
 17kYef6QCJ9y5p6QvRLZOUc+cgoow36vAYU+sELkqgDEPe2WUhopHyu0m7s3wXdb36Xz
 VqORgT0Tj2eBesoxbL2du9ZfcN3KXW0WY/hqagwiLr4pKNqPp8XYRqSYH+HcUHOhJvIq
 pk0KpXsSrq3lFPccIkwxQUTeR6IlidGDfYth2MRJuZmXXOV201hkq1ExH30h44n3TEUd
 dsCQ+JqaWjzoIneUkAdPBAb4xww0sbSyRNQgI+GELrARqo9H0in5EBBtJXWKQ4U+WT48 8w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem9dwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 06:03:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ile3xDskEeOpfBdGVoyK3iX9v2GPjO2ZaCkEd74jF2FbSVzEaRfb/LjzUu7/ODnQ1jbcBLu0oR0hhqKxn9ztWwAQm+3k5n8zenc9SqXiz9v7z03ZFi4b1UVFqDm4faJmH5ymtm7jWvKIN+IxBzMvru2bl7+eR5vRzj5GrXMvfRqwIZZJAFInePylW8nIVq9bJ+WzunP1gHvsiP9uzXV4LX9pBTRq/lR95ayWiMuXG0QygYVan+HGwmEQxSYYzthkBWW0XIg6S85LhG6X8qfOCeaQcLsIUCNboOI8PEhZsI9FtQ98kuzhc36LxkSXcHgpBwP0Qf2Ro7MECpSc6nmuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCHcat38gufF9o0J6P9JkttfQOZe9bPj5PbzC/6qYEU=;
 b=NZ7phSPikBlEf/pdLmbiufZXR6mEuuoer2jK7MNz0LNi7CThKCCAaqF46oVScDGNzul8kVvVEJzZ4TcJKAOBTmTNRTGFoBdSkHHNzsQrjrBadgXAlx+8YYTcKWRVpmMcDX2bMZQuKFN2BztHCi2lhmiFIx57tfE7bAug/B/akNXqqidL2rSwUmghVUj+fLBuFmCN4MK/w2xReQ1WjHPnh1wqQlRUp5CNhBCm+HVm47zd6T8EWlQ6NnQkmOujTcxX072lz38akhCVrLooCBW2ORYCsQXYsxwC2F/PJeaa8t06cYCkb1oV5IeI4fC5yQc5xfS2sTYcknjDPfMa3ayb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCHcat38gufF9o0J6P9JkttfQOZe9bPj5PbzC/6qYEU=;
 b=EprfcKu1rO7wV7t3G5SQ61DGGILa8ISAOdai7WTM/7lGoG5d/hgBBpxwR5Zv40Ud2AN8ZEWNRLTiNRhz/KRdOMURHrH/WdhSpKcW+SdY7Ed773cg/mS/x35Cd7HIE5BP/brB473bF7aPEZtvF4vusBCw9C8IvAxwIK6E28es/GM=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 14:03:39 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.021; Fri, 21 Feb 2020
 14:03:39 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling
 interface
Thread-Topic: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling
 interface
Thread-Index: AQHV5zKbGdMh9j3Pg0KxFb3GPYjoLKglh3UAgAApFao=
Date:   Fri, 21 Feb 2020 14:03:39 +0000
Message-ID: <CH2PR12MB418170EDD66763FDF8A2DB65C4120@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-10-jmaneyrol@invensense.com>,<20200221113450.379fe556@archlinux>
In-Reply-To: <20200221113450.379fe556@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c679186-c19f-4fc4-b26d-08d7b6d6da31
x-ms-traffictypediagnostic: CH2PR12MB4215:
x-microsoft-antispam-prvs: <CH2PR12MB4215214D6CF40886C6F82EDAC4120@CH2PR12MB4215.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39850400004)(396003)(376002)(199004)(189003)(86362001)(81166006)(64756008)(8676002)(52536014)(66946007)(33656002)(26005)(81156014)(66446008)(91956017)(76116006)(8936002)(186003)(71200400001)(55016002)(478600001)(66556008)(53546011)(6506007)(66476007)(4326008)(9686003)(7696005)(2906002)(316002)(5660300002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4215;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e49wfOrPH05uK0AygMOGfc7MYbCvEojFUH827dsoCuhmczS1mK+WfUXPa29W7t//LrItiwR55HAddojZpEQjm7jl5pfNIc45/Tuh9uDRGd/AumP5fqWY+w929+WPhIHFSteg4ZUOlcqFZ0cx2c7RZ7ZkqVjwIM0ZNg8zAL1jPczz5wJPflk6OB/jfRCGhqD0BuhTGjdMzOR3O3AT4sDsfN3+J+B2vH3N4DTdXlLcVKLfIl3lwiCwwVSWw7r1+SpNAlOMA1nMcZhOv/vp9VBM3u2Y91whJBdVQ2AjFiKfqLt+MtUB0DY/LiV+NdtCJMigNXHzXYw/uAQRH2E4iRAUYzFFtNmFXTxfbQ4W5J7u5r5mpQQ9JypYwJqWEu695PDApNtGbcJUwAeW8ZsPNYMKowfHaq9GmduGePf+FZgJwimYGSNqxAcuNwsY37pc5RMY
x-ms-exchange-antispam-messagedata: Nj4Q1mfU8ALFk+lHRt+GjV24QS3zlUUHSdRtWRYgocVF8+1c7dF1gJnreQtv8cNBjKbImvevH3BjL3OSu5VVJ4/R1lx0Dy6cVLSZt9eXnRJQBJ9LyElquxBP4Bsu3dIe/FIUeN/Hv2JK5CUy6jpozA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c679186-c19f-4fc4-b26d-08d7b6d6da31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 14:03:39.3861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjKwxOz4orhRA+o+DYIx/So+EzeALWp2lAJlDifbjMgAZc64z4W5cIWrm0JZiVKrVsnXpBCdq7yVcheNsZ4qIZNDrTuSw3MFw0QaPIMTUtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_04:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002210106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
this is not something we want to backport. Mainly because it is heavly depe=
ndant on the rework of the power and sensor engines.=0A=
=0A=
And polling interface without pm_runtime autosuspend is not really relevent=
.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Friday, February 21, 2020 12:34=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling inter=
face=0A=
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
On Wed, 19 Feb 2020 15:39:54 +0100=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> When reading data with the polling interface, we need to wait=0A=
=0A=
> at 1 sampling period to have a sample.=0A=
=0A=
> For gyroscope and magnetometer, we need to wait for 2 periods=0A=
=0A=
> before having a correct sample.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
I should have raised this before, but is this something we might want to=0A=
=0A=
backport? I don't really want this whole cleanup series getting backported,=
=0A=
=0A=
so is there a more minimal change for older kernels? (probably just sleep t=
oo=0A=
=0A=
long in all cases!)=0A=
=0A=
=0A=
=0A=
Applied,=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 ++++++++++++++++++++--=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 21 -------------=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |=A0 3 ++=0A=
=0A=
>=A0 3 files changed, 37 insertions(+), 23 deletions(-)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index a51efc4c941b..aeee39696d3a 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -563,9 +563,14 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev)=
;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int freq_hz, period_us, min_sleep_us, max_sleep_us=
;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* compute sample period */=0A=
=0A=
> +=A0=A0=A0=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_confi=
g.divider);=0A=
=0A=
> +=A0=A0=A0=A0 period_us =3D 1000000 / freq_hz;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
> @@ -576,6 +581,10 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_GYRO);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have f=
irst valid sample */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us + p=
eriod_us / 2);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->raw_gyro,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switc=
h_engine(st, false,=0A=
=0A=
> @@ -588,6 +597,10 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_ACCL);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample a=
vailability */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + period=
_us / 2;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->raw_accl,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chan->chann=
el2, val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switc=
h_engine(st, false,=0A=
=0A=
> @@ -600,8 +613,10 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SENSOR_TEMP);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait for stablization */=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(INV_MPU6050_TEMP_UP_TIME);=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* wait 1 period for first sample a=
vailability */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D period_us + period=
_us / 2;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->temperature,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_MOD_X, =
val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switc=
h_engine(st, false,=0A=
=0A=
> @@ -610,7 +625,24 @@ static int inv_mpu6050_read_channel_data(struct iio_=
dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto=
 error_power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_MAGN:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, true,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* frequency is limited for magneto=
meter */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (freq_hz > INV_MPU_MAGN_FREQ_HZ_=
MAX) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq_hz =3D=
 INV_MPU_MAGN_FREQ_HZ_MAX;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_us =
=3D 1000000 / freq_hz;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* need to wait 2 periods to have f=
irst valid sample */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_sleep_us =3D 2 * period_us;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_sleep_us =3D 2 * (period_us + p=
eriod_us / 2);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(min_sleep_us, max_slee=
p_us);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu_magn_read(st=
, chan->channel2, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engin=
e(st, false,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_MPU6050_SENSOR_MAGN);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_=
power_off;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
> index 3f402fa56d95..f282e9cc34c5 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
> @@ -44,9 +44,6 @@=0A=
=0A=
>=A0 #define INV_MPU_MAGN_REG_ASAY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x11=0A=
=0A=
>=A0 #define INV_MPU_MAGN_REG_ASAZ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x12=0A=
=0A=
>=A0 =0A=
=0A=
> -/* Magnetometer maximum frequency */=0A=
=0A=
> -#define INV_MPU_MAGN_FREQ_HZ_MAX=A0=A0=A0=A0 50=0A=
=0A=
> -=0A=
=0A=
>=A0 static bool inv_magn_supported(const struct inv_mpu6050_state *st)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
> @@ -321,7 +318,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, i=
nt axis, int *val)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int status;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 __be16 data;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint8_t addr;=0A=
=0A=
> -=A0=A0=A0=A0 unsigned int freq_hz, period_ms;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* quit if chip is not supported */=0A=
=0A=
> @@ -344,23 +340,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st, =
int axis, int *val)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 addr +=3D INV_MPU6050_REG_EXT_SENS_DATA;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 /* compute period depending on current sampling rate */=0A=
=0A=
> -=A0=A0=A0=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_confi=
g.divider);=0A=
=0A=
> -=A0=A0=A0=A0 if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq_hz =3D INV_MPU_MAGN_FREQ_HZ_MA=
X;=0A=
=0A=
> -=A0=A0=A0=A0 period_ms =3D 1000 / freq_hz;=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_mpu6050_switch_engine(st, true, INV_MPU6050_SEN=
SOR_MAGN);=0A=
=0A=
> -=A0=A0=A0=A0 if (ret)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 /* need to wait 2 periods + half-period margin */=0A=
=0A=
> -=A0=A0=A0=A0 msleep(period_ms * 2 + period_ms / 2);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_mpu6050_switch_engine(st, false, INV_MPU6050_SE=
NSOR_MAGN);=0A=
=0A=
> -=A0=A0=A0=A0 if (ret)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> -=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* check i2c status and read raw data */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_MPU6050_REG_I2C_MST=
_STATUS, &status);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> index f7ad50ca6c1b..185c000c697c 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> @@ -10,6 +10,9 @@=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_mpu_iio.h"=0A=
=0A=
>=A0 =0A=
=0A=
> +/* Magnetometer maximum frequency */=0A=
=0A=
> +#define INV_MPU_MAGN_FREQ_HZ_MAX=A0=A0=A0=A0 50=0A=
=0A=
> +=0A=
=0A=
>=A0 int inv_mpu_magn_probe(struct inv_mpu6050_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /**=0A=
=0A=
=0A=
=0A=
