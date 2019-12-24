Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF3129FA3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2019 10:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLXJRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Dec 2019 04:17:15 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:57804 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLXJRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Dec 2019 04:17:15 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBO9G7op024570;
        Tue, 24 Dec 2019 01:17:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=mgQSlMvg34K/O5Wp7lXRzNcsg84xqCERdsE295465Y4=;
 b=OASrXruRw5mV74agIcv6YCf4+E4yAsSlEKX6YHDFVbs3d6GhAWaZLBZWvPgq7m3ghYmg
 25PYy9JH1qRxf88j1Cou0OI3mVYusMmca3LDR4omY1duijHhUr+XHdrAPSOgycCdCq10
 l82GQP4F8AN39nJeM+i2HJBiCP8YVWVQ8gYNdh4zlaLQ//IQ2YkNpqlRQfflX6Z0TU0G
 wgX/A5PD8RU1fDLzCpMKfK81zI5K22+ImgOH7Vmfiw2FnwIc8vLMysRRNiOwUuo/pFGh
 N5aatJ1x4J7rqlH0SVmgnriHMFRBmSTl4gsTdHK36V1yO3C6EFC02GMBVmd5mD4MpmZs jw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00328301.pphosted.com with ESMTP id 2x1frt94ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Dec 2019 01:17:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaxsMwkXHIe76/lYEEE50VUK9iDnNqHyyjl91yTqTbgKQXkzbCbQCwkKzHXkpqg2r7597N87fDZT7/rJzOcNu6GeX0jxX/b2wFkrj/osOxAV+0bqEDnYF8arySjYrAhI8EmAwZW49wVQJQJiyVKkQtCUYIpaW4L06ErdD5VYGDN4MvzUdiszMgncuzre2nEYJ8rfzERgFggexxUuUAl/g0B3DLRljE72AUYYW7oplSussOHIPB9L07ZVh8xtWAKmDiSxvt46Vt3D5aW5J1MK0Q5roZiKvjR4bX2iGzGhMShq78Wl5nJ3mhGMwSmfWSctpWx3nTrpoDAQcdKn+W94WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgQSlMvg34K/O5Wp7lXRzNcsg84xqCERdsE295465Y4=;
 b=SLgLm3rtMZCNLnV+0SwyQyb2mAF7S88xRLOeXsmCUhUPTSkTAgXJevJ7WKyhaB0jUCuuNgeY0DbV8kSURtlV7XXbutTtvoIioTLMXzVewx21+WDCdMmvuQdb6qRmssi5SUzpwlq99uFjqAmuBbkjwcGgqPSu7lVnKDbWsf2W1viX2B/+m/kYA/ca2Ng4TcwTeaRD0UWPI5WjKKDZjLDPZKqQOA+xigZqv2dxN3SRr+hwDWb24mDD5zokUq2fcIh4Xy9Cb9tbkOZlLwpkoyuqjRhxyEHX1RYTGQJfzUfF8ZMP635U3xSYvPz83xe9arTZUEqULmkYATsGeSvAOcyJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgQSlMvg34K/O5Wp7lXRzNcsg84xqCERdsE295465Y4=;
 b=FEqSXkSJV/NVutP4D7XblPRCqucIPH5NlSlYwM8pwm7WZmEqbSFK5TRyu0whJUYVr7vVBRXs2n3ukuBBTIGyKkulmZHB9O7WiizhtZQXpshMmESPOg9dRZ4DJTrtZTqOr7HK23g5fTH+D2DMUCJCv+MznJ+2P+akbsKniZHAxOI=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2862.namprd12.prod.outlook.com (20.179.80.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 24 Dec 2019 09:17:05 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::d8f8:bea1:1dba:a5cf%7]) with mapi id 15.20.2581.007; Tue, 24 Dec 2019
 09:17:05 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Thread-Topic: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Thread-Index: AQHVnfvN1ETmvoI+DUqfeddhP/8856eY+I8AgA36P9aAIkZwvg==
Date:   Tue, 24 Dec 2019 09:17:05 +0000
Message-ID: <MN2PR12MB3373B2617FAD6FB24EAC0787C4290@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
        <20191118103406.9353-2-jmaneyrol@invensense.com>,<20191123162256.386c085a@archlinux>,<MN2PR12MB33739BF5EA2C9E402EDF4684C4430@MN2PR12MB3373.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33739BF5EA2C9E402EDF4684C4430@MN2PR12MB3373.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0cbbba-0115-4c19-f38a-08d788520b4c
x-ms-traffictypediagnostic: MN2PR12MB2862:
x-microsoft-antispam-prvs: <MN2PR12MB286200EC120DD777E54479D3C4290@MN2PR12MB2862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(199004)(189003)(53434003)(8936002)(7696005)(8676002)(81156014)(30864003)(110136005)(5660300002)(316002)(81166006)(53546011)(6506007)(86362001)(478600001)(71200400001)(2906002)(26005)(52536014)(186003)(9686003)(64756008)(91956017)(76116006)(66476007)(66556008)(55016002)(66446008)(66946007)(33656002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2862;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j63uXk4SVicCFwABdO9UvIvy6cxDe9sQSimPBMb61PAHmlz6WeqXSDlKgSJOM03ysKcuEzGmekh0EqQykgwknbigRJDqj4/dYpJ2sOF5OWijniWwArD7k/xfPf9y1gq4Fwxdt+O/cEdzSSv5JWFFF/H+JvLuY3f9hqRmUIBMsbgM6DljwPyMyBIu5XAJDfRrcjQxMy4ixt7xAHkzJ8x6VSq7t5dnV0e8ZGbbtGPUVNv2nWpOdPeef+iClhw1XnbRm29YREk/UwMFaNnSwMtwJJWITT2biYJahZE6HUgiP7LrsWmBLbMv2kPWcrfNfreWAmau8qHcRPq9oaYRLECfsjk6YyZgKqvW1hS74RG37JNCnBvi+6AcupSgosQr+Rk4EWNRQUKMaSw08vqTokr5ySEY4ecEpJ/I0KtGBz+Zs6z2aN6x4OHKeHlxCPDM5OSUgBDrzjqAVD9nsFGBKY8pkeiDXYHhhKMhX++XeB4Quj5Gs7YmX38uzX7tl+LdeFJA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0cbbba-0115-4c19-f38a-08d788520b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 09:17:05.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkWLR7LwvYhTfqdAwlrdXut1KHoj0rT1VJ7S8ZBKEu4B0YovddEHocPdhF6ygea32moY/mXbR9fOpEYxMbhRN8aSVTUGAzE1NjAAjGKW/Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2862
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-24_01:2019-12-23,2019-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912240082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
any news about my 2nd patch ("[PATCH 2/2] iio: imu: inv_mpu6050: add fifo t=
emperature data support") now that the 1st is included inside fixes-togreg =
branch?=0A=
=0A=
The 1st one is still not yet available inside testing branch.=0A=
Should I resend it now or wait for testing to be in sync with fixes-togreg?=
=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Sent: Monday, December 2, 2019 14:50=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data s=
upport=0A=
=0A=
=A0=0A=
=0A=
=0A=
Hi Jonathan,=0A=
=0A=
=0A=
=0A=
just a reminder for not forgetting this patch now that the first is in fixe=
s-togreg branch.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
JB=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
=0A=
=0A=
Sent: Saturday, November 23, 2019 17:22=0A=
=0A=
=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
=0A=
=0A=
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data s=
upport=0A=
=0A=
=0A=
=0A=
=A0=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
On Mon, 18 Nov 2019 11:34:06 +0100=0A=
=0A=
=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
> Add support of temperature data in fifo for all chips.=0A=
=0A=
=0A=
=0A=
> Enable unification of scan elements for icm20602.=0A=
=0A=
=0A=
=0A=
> Add macros for generating scan elements with and without temp.=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
=0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
Looks fine to me. I'll pick up once we've worked out what=0A=
=0A=
=0A=
=0A=
we are doing with patch 1.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Remind me if I seem to have lost it.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 194 +++++++-----=
------=0A=
=0A=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 22 +-=0A=
=0A=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 |=A0=A0 6 +-=0A=
=0A=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0=A0 3 +=0A=
=0A=
=0A=
=0A=
>=A0 4 files changed, 84 insertions(+), 141 deletions(-)=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
=0A=
=0A=
> index 268240644adf..7c2f6951364d 100644=0A=
=0A=
=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
=0A=
=0A=
> @@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_conf=
ig_6050 =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .divider =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MP=
U6050_INIT_FIFO_RATE),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .gyro_fifo_enable =3D false,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .accl_fifo_enable =3D false,=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 .temp_fifo_enable =3D false,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .magn_fifo_enable =3D false,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .accl_fs =3D INV_MPU6050_FS_02G,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .user_ctrl =3D 0,=0A=
=0A=
=0A=
=0A=
> @@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_ext_=
info[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ext_info =3D inv_ext_info,=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_TEMP_CHAN(_index)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D '=
s',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits =
=3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storagebit=
s =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .shift =3D =
0,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .endianness=
 =3D IIO_BE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0 static const struct iio_chan_spec inv_mpu_channels[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),=
=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 /*=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled readin=
g only,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * not the final scan elements output.=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 },=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU605=
0_SCAN_GYRO_X),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU605=
0_SCAN_GYRO_Y),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU605=
0_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> @@ -878,22 +887,31 @@ static const struct iio_chan_spec inv_mpu_channels[=
] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_S=
CAN_ACCL_Z),=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 (BIT(INV_MPU6050_SCAN_ACCL_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z))=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 (BIT(INV_MPU6050_SCAN_GYRO_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z))=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_SCAN_MASK_TEMP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (BIT(IN=
V_MPU6050_SCAN_TEMP))=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +/* generate scan mask and a duplicate with temperature enabled */=0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_SCAN_MASK_DUP_TEMP(_mask)=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 (_mask),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 (_mask) | INV_MPU6050_SCAN_MASK_TEMP=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0 static const unsigned long inv_mpu_scan_masks[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
GYRO),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU60=
50_SCAN_MASK_3AXIS_GYRO),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 0,=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> @@ -917,17 +935,9 @@ static const unsigned long inv_mpu_scan_masks[] =3D =
{=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 static const struct iio_chan_spec inv_mpu9150_channels[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),=
=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 /*=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled readin=
g only,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * not the final scan elements output.=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 },=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU605=
0_SCAN_GYRO_X),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU605=
0_SCAN_GYRO_Y),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU605=
0_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> @@ -944,17 +954,9 @@ static const struct iio_chan_spec inv_mpu9150_channe=
ls[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 static const struct iio_chan_spec inv_mpu9250_channels[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),=
=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 /*=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled readin=
g only,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 * not the final scan elements output.=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0 */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 },=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU605=
0_SCAN_GYRO_X),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU605=
0_SCAN_GYRO_Y),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU605=
0_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> @@ -969,98 +971,42 @@ static const struct iio_chan_spec inv_mpu9250_chann=
els[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCA=
N_MAGN_Z),=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> +#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN=A0=A0=A0=A0 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 (BIT(INV_MPU9X50_SCAN_MAGN_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z))=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
>=A0 static const unsigned long inv_mpu9x50_scan_masks[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
GYRO),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis magn */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU9X50_SCAN_MASK_3AXIS_=
MAGN),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU60=
50_SCAN_MASK_3AXIS_GYRO),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + magn */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU9X=
50_SCAN_MASK_3AXIS_MAGN),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 6-axis gyro + magn */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
GYRO=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU9X=
50_SCAN_MASK_3AXIS_MAGN),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 9-axis accel + gyro + magn */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_=
ACCEL=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU60=
50_SCAN_MASK_3AXIS_GYRO=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU9X=
50_SCAN_MASK_3AXIS_MAGN),=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 0,=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> -static const struct iio_chan_spec inv_icm20602_channels[] =3D {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D INV_ICM20602_SCAN_T=
EMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .sign =3D 's',=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .realbits =3D 16,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .storagebits =3D 16,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .shift =3D 0,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .endianness =3D IIO_BE,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 },=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 },=0A=
=0A=
=0A=
=0A=
> -=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN=
_GYRO_X),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN=
_GYRO_Y),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN=
_GYRO_Z),=0A=
=0A=
=0A=
=0A=
> -=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_AC=
CL_Y),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_AC=
CL_X),=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_AC=
CL_Z),=0A=
=0A=
=0A=
=0A=
> -};=0A=
=0A=
=0A=
=0A=
> -=0A=
=0A=
=0A=
=0A=
>=A0 static const unsigned long inv_icm20602_scan_masks[] =3D {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel + temp (mandatory) */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_T=
EMP,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro + temp (mandatory) */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TE=
MP,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro + temp (mandatory) */=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_X)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3=
AXIS_GYRO=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU60=
50_SCAN_MASK_TEMP,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 0,=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> @@ -1363,8 +1309,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_ma=
sks =3D inv_mpu9x50_scan_masks;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm2060=
2_channels;=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_S=
IZE(inv_icm20602_channels);=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_mpu_cha=
nnels;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_S=
IZE(inv_mpu_channels);=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_ma=
sks =3D inv_icm20602_scan_masks;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
=0A=
=0A=
> index b096e010d4ee..6158fca7f70e 100644=0A=
=0A=
=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
=0A=
=0A=
> @@ -86,6 +86,7 @@ enum inv_devices {=0A=
=0A=
=0A=
=0A=
>=A0=A0 *=A0 @accl_fs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 accel f=
ull scale range.=0A=
=0A=
=0A=
=0A=
>=A0=A0 *=A0 @accl_fifo_enable:=A0=A0=A0=A0=A0=A0 enable accel data output=
=0A=
=0A=
=0A=
=0A=
>=A0=A0 *=A0 @gyro_fifo_enable:=A0=A0=A0=A0=A0=A0 enable gyro data output=
=0A=
=0A=
=0A=
=0A=
> + *=A0 @temp_fifo_enable:=A0=A0=A0=A0=A0=A0 enable temp data output=0A=
=0A=
=0A=
=0A=
>=A0=A0 *=A0 @magn_fifo_enable:=A0=A0=A0=A0=A0=A0 enable magn data output=
=0A=
=0A=
=0A=
=0A=
>=A0=A0 *=A0 @divider:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip sa=
mple rate divider (sample rate divider - 1)=0A=
=0A=
=0A=
=0A=
>=A0=A0 */=0A=
=0A=
=0A=
=0A=
> @@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int accl_fs:2;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int accl_fifo_enable:1;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int gyro_fifo_enable:1;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int temp_fifo_enable:1;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 unsigned int magn_fifo_enable:1;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 u8 divider;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 u8 user_ctrl;=0A=
=0A=
=0A=
=0A=
> @@ -184,6 +186,7 @@ struct inv_mpu6050_state {=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_BIT_SLAVE_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x=
04=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_BIT_ACCEL_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x08=
=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_BITS_GYRO_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x70=
=0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_BIT_TEMP_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x80=
=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_REG_I2C_MST_CTRL=A0=A0=A0=A0=A0=A0=A0 0x24=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D=0A=
=0A=
=0A=
=0A=
> @@ -268,8 +271,8 @@ struct inv_mpu6050_state {=0A=
=0A=
=0A=
=0A=
>=A0 /* MPU9X50 9-axis magnetometer */=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU9X50_BYTES_MAGN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 7=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> -/* ICM20602 FIFO samples include temperature readings */=0A=
=0A=
=0A=
=0A=
> -#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=A0=A0 2=0A=
=0A=
=0A=
=0A=
> +/* FIFO temperature sample size */=0A=
=0A=
=0A=
=0A=
> +#define INV_MPU6050_BYTES_PER_TEMP_SENSOR=A0=A0 2=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 /* mpu6500 registers */=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=A0=A0=A0=A0=A0 0x1D=0A=
=0A=
=0A=
=0A=
> @@ -298,7 +301,7 @@ struct inv_mpu6050_state {=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_ICM20608_TEMP_OFFSET=A0=A0=A0=A0=A0=A0=A0=A0=A0 8170=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_ICM20608_TEMP_SCALE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 3059976=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> -/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */=0A=
=0A=
=0A=
=0A=
> +/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */=0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0=A0=A0=A0=A0 32=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 #define INV_MPU6050_REG_INT_PIN_CFG=A0 0x37=0A=
=0A=
=0A=
=0A=
> @@ -344,6 +347,7 @@ enum inv_mpu6050_scan {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_X,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_Y,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_Z,=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_SCAN_TEMP,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_X,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_Y,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_Z,=0A=
=0A=
=0A=
=0A=
> @@ -355,18 +359,6 @@ enum inv_mpu6050_scan {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU9X50_SCAN_TIMESTAMP,=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> -/* scan element definition for ICM20602, which includes temperature */=
=0A=
=0A=
=0A=
=0A=
> -enum inv_icm20602_scan {=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_X,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Y,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Z,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_TEMP,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_X,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Y,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Z,=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 INV_ICM20602_SCAN_TIMESTAMP,=0A=
=0A=
=0A=
=0A=
> -};=0A=
=0A=
=0A=
=0A=
> -=0A=
=0A=
=0A=
=0A=
>=A0 enum inv_mpu6050_filter_e {=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_256HZ_NOLPF2 =3D 0,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_188HZ,=0A=
=0A=
=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
=0A=
=0A=
> index 10d16ec5104b..3755577dc449 100644=0A=
=0A=
=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
=0A=
=0A=
=0A=
> @@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BITS_GYRO=
_OUT;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.accl_fifo_enable)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_ACCEL=
_OUT;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.temp_fifo_enable)=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_TEMP_OUT;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.magn_fifo_enable)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_SLAVE=
_0;=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->fifo_en, d=
);=0A=
=0A=
=0A=
=0A=
> @@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU=
6050_BYTES_PER_3AXIS_SENSOR;=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0 if (st->chip_type =3D=3D INV_ICM20602)=0A=
=0A=
=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_ICM20602_B=
YTES_PER_TEMP_SENSOR;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (st->chip_config.temp_fifo_enable)=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU6050_BY=
TES_PER_TEMP_SENSOR;=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.magn_fifo_enable)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU=
9X50_BYTES_MAGN;=0A=
=0A=
=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
=0A=
=0A=
> index a9c75bc62f18..5199fe790c30 100644=0A=
=0A=
=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
=0A=
=0A=
=0A=
> @@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *indi=
o_dev)=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i=
ndio_dev->active_scan_mask) ||=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(INV_MPU6050_SCAN_AC=
CL_Z,=0A=
=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i=
ndio_dev->active_scan_mask);=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 st->chip_config.temp_fifo_enable =3D=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(INV_MPU6050_SCAN_TEMP, ind=
io_dev->active_scan_mask);=0A=
=0A=
=0A=
=0A=
>=A0 }=0A=
=0A=
=0A=
=0A=
>=A0 =0A=
=0A=
=0A=
=0A=
>=A0 static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
