Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877B26BDDF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2019 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQOKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jul 2019 10:10:43 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:34994 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbfGQOKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2019 10:10:43 -0400
X-Greylist: delayed 1526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 10:10:42 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6HDijfg007636;
        Wed, 17 Jul 2019 06:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=thn74VFulo4p2wjCHy39udnWPeEDlXc8RPLQb5G2XqI=;
 b=JxX7zu5CKG3JmKquDURLDFOjfy5Zxot7bEgfi3WN7nLdXej6AyrBPreh9kmJfgriNpQy
 3ySdsWBI2c5H7DtC5AGgPLwJgcJgJm50Y9MJHvIDCdlrVFy0VmmrP32Qs4jUb2LDZq6t
 HhtXauAfqBEtMvdiTqKsA+McQF1WY5C8EAaHwXw8H+wrtn0V3+jRHyhMr17FLONh7Ip0
 KhBBqSp+iFHbbAr/xuW4wy8etrCllAxgZuIgmceeEHF+tMf5J9hP+/waFFxcx+ZGV0Lr
 vRh99TeeKmw3h7zRYoXuSK+DJlmUYed9aVnVh6LEgLNI7LsiXrT4iM9I2jKpMN8D1J7d Bw== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2054.outbound.protection.outlook.com [104.47.40.54])
        by mx0a-00328301.pphosted.com with ESMTP id 2tssd589fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Jul 2019 06:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktfUoPBq2iCyXFQWKhaaPlPQhWhXaSObxlLDvyMqUlzaqAIT6BFpX53aZChBpo8hj4jcBDpC8RZzqwnBbNKl4+wqqs7MVl3ELEQQ5YToWUFKFFtKTahPrgtgK38rje3InWrOyFNpIHLB82QBWHOgyVABIRqUVgi6MsAp+QIJBOwOQVMEDqNmqeKKGe80HFG0lwZ54ILVIl3gkHRC/pZwP13scLtaFEBKOfv0n1lOqxowvv/L6l5zIenClwXw0p6Ae9B1UrXa244fdNFXqqVm7/1117HA6eg/J/qTgu8IWLra4zBbezz4VOf/nf1vJH7+nlRTZ5T3+5krX6e1QN7DWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thn74VFulo4p2wjCHy39udnWPeEDlXc8RPLQb5G2XqI=;
 b=DhsdMoPtyVebQ7Xx3YovQCJrQlcPpxgMvuEmQDyje7Qx6iw0wucncPTHfE+DC1yiNdHchS2YlDspP1vLtSfyp6b3W9rM2ubPtoPMd7gbGjZmlqMJPbJjje6UPnBMUKQh/bOOyrEfWCEu4Ma+oaJds59PBrSK2Ztrwf0oePxjtWchvX8lrjVRmtRVTyaW8kb3Mz1eIYi9j1D+4/gUlXsFzFZEl0r06A0UJOB6GqY9B2unR87DbinSSNDpqvMCwrcbGM+Bc2enDu2/2isiku9Y1SCYw6wqS//qXT00t1P9jE2QgGM2AHjammdCKpa+MMEuTeq6TC300F6mjHCdWCUDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=invensense.com;dmarc=pass action=none
 header.from=invensense.com;dkim=pass header.d=invensense.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thn74VFulo4p2wjCHy39udnWPeEDlXc8RPLQb5G2XqI=;
 b=G52e4fCAHmWECR1HDncMX5qEmpGDvqaXVoobQh4Oz2WozE50PM2MuBSbTDrfRCaNpm01WC0JJ4ijicFtLivJINg2kGov7FakYNUjrYtBBA1B/e8QkrjVam3R7RJY18c3SbqzH8QLkCqjZbOoaiNiVkhIF5P1RbeJ5Ewi/6ObeGI=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3422.namprd12.prod.outlook.com (20.178.243.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 13:45:07 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::e1b5:b52f:299e:1957]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::e1b5:b52f:299e:1957%6]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 13:45:07 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: mpu6050: add missing available scan masks
Thread-Topic: [PATCH v2] iio: imu: mpu6050: add missing available scan masks
Thread-Index: AQHVLOsB+Bohq3cjZUigraO6Qp/HnKbKdwQAgAR6BSE=
Date:   Wed, 17 Jul 2019 13:45:07 +0000
Message-ID: <MN2PR12MB3373EB934E21684C64201A02C4C90@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190627131918.19619-1-jmaneyrol@invensense.com>,<20190714182026.5edebf23@archlinux>
In-Reply-To: <20190714182026.5edebf23@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e34:efb7:6020:2814:844f:dac7:e1fb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a486994-73b6-4212-38b0-08d70abcfaff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3422;
x-ms-traffictypediagnostic: MN2PR12MB3422:
x-microsoft-antispam-prvs: <MN2PR12MB3422B040C414102B473F9E16C4C90@MN2PR12MB3422.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(376002)(396003)(136003)(346002)(199004)(189003)(6916009)(5024004)(256004)(6436002)(86362001)(478600001)(2906002)(6116002)(25786009)(6246003)(4326008)(71200400001)(6506007)(33656002)(80792005)(476003)(486006)(55016002)(71190400001)(229853002)(5660300002)(76176011)(53546011)(7696005)(186003)(8676002)(46003)(11346002)(102836004)(446003)(305945005)(7736002)(99286004)(316002)(74316002)(68736007)(9686003)(91956017)(81156014)(66946007)(53936002)(8936002)(52536014)(14454004)(66446008)(76116006)(64756008)(66556008)(66476007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3422;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /V6eATHGr2jcgiQ6h8dBgjact+mFO39EJUYsWtb1zP2KH/XcT9wiVShpqLGP3vl3G0dBbdCkxpanq1rpFkEPFZAXzBgrzg5yJ1dtpXcD7Ryn3EjzEI6WUoOCNrk4wJF5WxZ8seIhzAj5DAXjJG28STIxC4qxKKElKJZE/vak7aST/Sm3Tbq7fwhGYRIICtY4qL2UT64/MjYIfq4qjUYcM79vdvi4rivwQy5VkUZHHeCvj+m2lv4xNQPZNYw4x9bqDV9sB6+samUg3cJIQzgVjxBKMyVHEELzWzlJGRanrx5K0cDFWZaJATqXAZb+3ZvsHntOEd6g9VEchDpH+YfDhgmgdio3Z7u4QyfHYxxE5m5DNqJMtWtcQAnIL3rj31nnpMvD6MZze/snLeBJVSvHAevZCp6TzGicttorus82M2w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a486994-73b6-4212-38b0-08d70abcfaff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 13:45:07.5924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3422
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-17_06:2019-07-17,2019-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1904300001 definitions=main-1907170165
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,=0A=
=0A=
I am still not seeing this patch in the fixes-togreg branch or in the testi=
ng branch. Neither in the testing-fixes branch.=0A=
=0A=
Is this expected?=0A=
=0A=
Thanks for your response.=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@jic23.retrosnub.co.uk>=0A=
=0A=
Sent: Sunday, July 14, 2019 19:20=0A=
=0A=
To: Jean-Baptiste Maneyrol=0A=
=0A=
Cc: linux-iio@vger.kernel.org; stable@vger.kernel.org=0A=
=0A=
Subject: Re: [PATCH v2] iio: imu: mpu6050: add missing available scan masks=
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
On Thu, 27 Jun 2019 13:19:53 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Driver only supports 3-axis gyro and/or 3-axis accel.=0A=
=0A=
> For icm20602, temp data is mandatory for all configurations.=0A=
=0A=
> =0A=
=0A=
> Fix all single and double axis configurations (almost never used) and mor=
e=0A=
=0A=
> importantly fix 3-axis gyro and 6-axis accel+gyro buffer on icm20602 when=
=0A=
=0A=
> temp data is not enabled.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
> Fixes: 1615fe41a195 ("iio: imu: mpu6050: Fix FIFO layout for ICM20602")=
=0A=
=0A=
Something odd happened in this email that meant my client saved it as garba=
ge.=0A=
=0A=
Oh well, cut and pasted worked ;)=0A=
=0A=
=0A=
=0A=
Applied to the fixes-togreg branch of iio.git and marked for stable.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
> Changes in v2:=0A=
=0A=
>=A0=A0 - Use more explicit scan defines for masks=0A=
=0A=
> =0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 43 ++++++++++++++++++++++=
=0A=
=0A=
>=A0 1 file changed, 43 insertions(+)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index 385f14a4d5a7..66629c3adc21 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -851,6 +851,25 @@ static const struct iio_chan_spec inv_mpu_channels[]=
 =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_S=
CAN_ACCL_Z),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +static const unsigned long inv_mpu_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis accel */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis gyro */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 6-axis accel + gyro */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
>=A0 static const struct iio_chan_spec inv_icm20602_channels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP)=
,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
=0A=
> @@ -877,6 +896,28 @@ static const struct iio_chan_spec inv_icm20602_chann=
els[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_=
SCAN_ACCL_Z),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +static const unsigned long inv_icm20602_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis accel + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis gyro + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
> +=A0=A0=A0=A0 /* 6-axis accel + gyro + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
>=A0 /*=0A=
=0A=
>=A0=A0 * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RA=
TE and=0A=
=0A=
>=A0=A0 * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched=
 by the=0A=
=0A=
> @@ -1136,9 +1177,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (chip_type =3D=3D INV_ICM20602) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
icm20602_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_icm20602_channels);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_masks =3D=
 inv_icm20602_scan_masks;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
mpu_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_mpu_channels);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_masks =3D=
 inv_mpu_scan_masks;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &mpu_info;=0A=
=0A=
=0A=
=0A=
