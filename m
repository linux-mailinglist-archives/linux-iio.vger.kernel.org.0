Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF21999A0
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgCaP2Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 11:28:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:43038 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727703AbgCaP2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 11:28:25 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VFQYqO017671;
        Tue, 31 Mar 2020 11:28:05 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 302wsq5p62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 11:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8M3h3DUYQz9LnKTfgvrB6TPzT60ULofWtyofECv9RNlwbbgCWLLcpb9SVc1RA6ujJzIST6jkSfqRFEpo6Sl8QJjpUy+DgyNzjv7S83G+F2pQcsqAv3QxuFje3Be4jK4rExpVXIOckqF3KHabIw/UsXiT+ckgHWD+9d49bGw6XZFpjUAgCW6JmpVjn7ww6GELu/aCquS7bajRqWcoTTchTG8IoYTkJLkbQsFc7Nj9Jb5qZCfTFe67UFNAk2iX8dqCBgIsAQsm4/7DxAwFL03oUhAQx7n2mo95FjkZWyNCi8XL6orgvvA8s8bQIdhTZjSK0jVVuhIxgf2+IHfWhTu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvVOqpOB1J5h3iMRzDqDHti48/3W1p8g4ncEY/F+0Ak=;
 b=P8PNmlwzmaLYdd4WztsCZZirGFiQ+mfc+CpLF7+GWzmI2YXPO7Cjr78EbEiyAz7rNSlV5zKlXN9r+fq89LFsZPa14lFuYFluXfPAp0qOJQUUU2h/hHdTTFMxKvmiBGBa2cU4jkIYaME7HE/jFjb4peIOsc174MOiJ92A4U2BeMqd3lImliyalQxaEMSU2xEneu/Ex24U4GQNmtCk3Q1DIYJ6yo53lk2BtM7XizT/jAAMcNJjyu/lrKB1ujR3nMU8/mebmrE5o373gp2yaV35Qh6C8TlratYYzuRANzpGcjO990hjPwgBbgqR+H/AUOldf7kgDarjRZcKANxUe4aVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvVOqpOB1J5h3iMRzDqDHti48/3W1p8g4ncEY/F+0Ak=;
 b=yM78CkYs67+I+UnWfd8es0uO0qHEtHMfnxT9i9XPGcWfjhKYow5S1F6t1zJ7lkULyMSCwlwt32i48d0E86M2NNkhSrNIYBAjUoJbx+NKjSQivvMfCd9Gbca6z9um+1pKY52b8S8gUjqUTrXeuLIgzZJUGyfQ3UV1Vzc2y+sNkkA=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3044.namprd03.prod.outlook.com (2603:10b6:404:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 15:28:03 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:28:03 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE
 instead of DEFINE_SIMPLE_ATTRIBUTE
Thread-Topic: [PATCH v2 1/2] iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE
 instead of DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWB1JIC039kMYQcEKrgG8zk2+hZahi0UJQ
Date:   Tue, 31 Mar 2020 15:28:03 +0000
Message-ID: <BN6PR03MB3347F052B16EDFB9BED9029D99C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200331114732.14739-1-rohitsarkar5398@gmail.com>
 <20200331114732.14739-2-rohitsarkar5398@gmail.com>
In-Reply-To: <20200331114732.14739-2-rohitsarkar5398@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMzQwZTAxNmMtNzM2NC0xMWVhLThhMzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDM0MGUwMTZkLTczNjQtMTFlYS04YTMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzEzNyIgdD0iMTMyMzAxNDIwOD?=
 =?iso-8859-1?Q?A3ODMyOTE0IiBoPSJJdGlLc0V4dEtqRHZXbTFEaTV4WXlLVDFFMkk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJTeFlmMmNBZldBVFZrQ252UlpYTGVOV1FLZTlGbGN0NERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQTV1R0RXQUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-originating-ip: [2001:a61:25e8:5601:8594:23ee:fc00:bd03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35b756d2-7442-46cc-d3d6-08d7d5881a83
x-ms-traffictypediagnostic: BN6PR03MB3044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3044F5963E9872D3C07BA32A99C80@BN6PR03MB3044.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(86362001)(8676002)(76116006)(81166006)(66476007)(54906003)(64756008)(110136005)(66446008)(8936002)(66556008)(4326008)(7696005)(66946007)(316002)(52536014)(81156014)(478600001)(5660300002)(55016002)(53546011)(6506007)(33656002)(71200400001)(186003)(9686003)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvyhGC/KhiU7fAAiAVjuvEPuVNKaab/xJVnCUufS9m4L0oq+EcWqF+e60OXFuprYGz8tocnu2neo+xnYwCSnixntju2q7xKC7p8XWaheZF7LnSsF2+zC+W8xW7W8dRirxZzclN652ESn5nTX09sGuaVEWZhPRTh3fjqfpJtHYHt+tKeGaLabMUj50rKghT/9w4psCjoiKcBy1Fwkv3BYi5zpX2/5uxmgTWiDAzbdv+7wqs3gl/jdWoCbhrX0A1j41Sh2sTRl3YmNKZN63EqyfZ+AvQmHIwja1dJW4oSPb6wjQL+PjxLnVvI34cmVZ68/GaBeKSNIyRhaqlcMF5zKdzMdX2ch/m2+aftyBcom3xDXUNcTWKyFpuLkAPvtoDKGpJl1aoMN2QdgKTImqaXL1IGlUZUflMr1+UdtLwcH+EVqYn4tvehyWU0IVJ5nz3Gp
x-ms-exchange-antispam-messagedata: VGnbI2NCmpRxNw63UN58gYxSigIWe0u8YATDHzsqvF+4yym3gRSbactGIV7aWHNebJQeJuCrVLDhHSaaE8IY5Xl/d765P5hTvjWNiWSgxwHzZtJwVJ5kcO7jzbkKwU0DzMOsb6PuZJIRarj3ejdsMeJxxKBpQ+CU3BNm7aPUv6C0e6Sk+ZP8/ozqvZ2jOLp/CaWpk5FO6+dWX/DVZoWlTw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b756d2-7442-46cc-d3d6-08d7d5881a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 15:28:03.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZLzqWApzEzGOKiaZ37NcTJ9u5EkdsOUBjKOAFdkfNIc4wFBVhpkCRauXb97PURe1VGmST9osRSM18G/RpChvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3044
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> O=
n
> Behalf Of Rohit Sarkar
> Sent: Dienstag, 31. M=E4rz 2020 13:48
> To: linux-iio@vger.kernel.org
> Cc: Bogdan, Dragos <Dragos.Bogdan@analog.com>; Rohit Sarkar
> <rohitsarkar5398@gmail.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Stefan Popa
> <stefan.popa@analog.com>; Jonathan Cameron <jic23@kernel.org>; Hartmut
> Knaack <knaack.h@gmx.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; linux-kernel@vger.kernel.org
> Subject: [PATCH v2 1/2] iio: imu: adis16400: use
> DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
>=20
> debugfs_create_file_unsafe does not protect the fops handed to it
> against file removal. DEFINE_DEBUGFS_ATTRIBUTE makes the fops aware of
> the file lifetime and thus protects it against removal.
>=20
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/iio/imu/adis16400.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index cfb1c19eb930..c8fcd40f58c0 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -258,7 +258,7 @@ static int adis16400_show_product_id(void *arg, u64
> *val)
>=20
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(adis16400_product_id_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16400_product_id_fops,
>  	adis16400_show_product_id, NULL, "%lld\n");
>=20
>  static int adis16400_show_flash_count(void *arg, u64 *val)
> @@ -275,7 +275,7 @@ static int adis16400_show_flash_count(void *arg, u64
> *val)
>=20
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(adis16400_flash_count_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16400_flash_count_fops,
>  	adis16400_show_flash_count, NULL, "%lld\n");
>=20
>  static int adis16400_debugfs_init(struct iio_dev *indio_dev)
> @@ -283,15 +283,16 @@ static int adis16400_debugfs_init(struct iio_dev
> *indio_dev)
>  	struct adis16400_state *st =3D iio_priv(indio_dev);
>=20
>  	if (st->variant->flags & ADIS16400_HAS_SERIAL_NUMBER)
> -		debugfs_create_file("serial_number", 0400,
> -			indio_dev->debugfs_dentry, st,
> -			&adis16400_serial_number_fops);
> +		debugfs_create_file_unsafe("serial_number", 0400,
> +				indio_dev->debugfs_dentry, st,
> +				&adis16400_serial_number_fops);
>  	if (st->variant->flags & ADIS16400_HAS_PROD_ID)
> -		debugfs_create_file("product_id", 0400,
> +		debugfs_create_file_unsafe("product_id", 0400,
> +				indio_dev->debugfs_dentry, st,
> +				&adis16400_product_id_fops);
> +	debugfs_create_file_unsafe("flash_count", 0400,
>  			indio_dev->debugfs_dentry, st,
> -			&adis16400_product_id_fops);
> -	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
> -		st, &adis16400_flash_count_fops);
> +			&adis16400_flash_count_fops);
>=20
>  	return 0;
>  }

Tested-by Nuno S=E1 <nuno.sa@analog.com>

> --
> 2.23.0.385.gbc12974a89

