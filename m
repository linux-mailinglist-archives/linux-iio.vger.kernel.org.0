Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39F1999A2
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgCaP2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 11:28:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4694 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727703AbgCaP2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 11:28:44 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VFQuk3013027;
        Tue, 31 Mar 2020 11:28:25 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g59ddd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 11:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGXxa8/oRzmKag/NTX3r8BT7khkxY9QBtzNRnpHYdn/McM3lJde5WoFo+438YWDPsiK7GfmNtCcrFE1GhsXtd6HQlMavABfvKg+kc4bt0LuSkoMMIN8o6vSs+HgHQ9FpWD/d+4lniGYBXAOhQ4yWkifbZvwG1AoMqtADxDkSK50ihNcm3vnCkKpa9lob6xohhrLBGkDWaCfF/03yHunGfYK1XRB5Ya+sPSlviB4F5jpkT+ISUP1LRmKjYDx8ProEpw6OaGrAJ6H50kyh30su21zsM2Vq5l1Lkk2+aDruDfeTqrNb01Y3esPsBO4n3Zx+KRTJ4WsZPQRVw2OsCkBK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmlqA6xbNMd/GO8Jo4fA1ZFBRm6FQtN1dLObOYPZXNE=;
 b=QBxdV4ZwCMH5ematNCfJ0AF6F0odHZ3qGUkFbrbj0B9+zF80DKeeGFj9ijXjH10CFlqKzOFN1imcLt0ADYbzqWpWEf+uhKu7y0fxk50XdLr8QXCPCuIpIXpzYLDQA00WrxGCLjrHpNHqQ11INXmEka/Z0JefYjVrb2jE3tRNHOkz09auLIz5Hxg2M+2SgQFfkInPkJ3DdDO0WZcgZkjHj9gP0Ec9orzcXK6LS+u+F8JzhIGgZXS3TLgefsKUM4BcxzD1RX3kwuUmDxlqOVDIW+KSc2+Wfn+GpLTJN8+10j4GtsRzo2BSTO7tvLyDkm6zVGqgfUaw15C3DTO1/WGaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmlqA6xbNMd/GO8Jo4fA1ZFBRm6FQtN1dLObOYPZXNE=;
 b=jxaqwfx9YC2GpPzdRGxLUyrTifYiAekIYtb3QjdwCtlWhiH/vDhJ5rcYl9UoIv7IjTPLzDEJvc1scMGjKJvraNEptSY+jtePS7Eb5XNKpsLXQj0V4Xbh3rbiAiiV9fye23UBFUpHQbSUzHTeGMaMfIHBbMYp/WRBp9g0CES2ZXU=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3044.namprd03.prod.outlook.com (2603:10b6:404:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 15:28:22 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:28:22 +0000
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
Subject: RE: [PATCH v2 2/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE
 instead of DEFINE_SIMPLE_ATTRIBUTE
Thread-Topic: [PATCH v2 2/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE
 instead of DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWB1JK8SqV+m9ll0iy5w3+icdDlKhi01KA
Date:   Tue, 31 Mar 2020 15:28:22 +0000
Message-ID: <BN6PR03MB33478A31AA2CF52CF3A81AB999C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200331114732.14739-1-rohitsarkar5398@gmail.com>
 <20200331114732.14739-3-rohitsarkar5398@gmail.com>
In-Reply-To: <20200331114732.14739-3-rohitsarkar5398@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctM2ZkYjU2MDAtNzM2NC0xMWVhLThhMzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDNmZGI1NjAyLTczNjQtMTFlYS04YTMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzUzMyIgdD0iMTMyMzAxNDIxMD?=
 =?iso-8859-1?Q?AzNzE3NjQyIiBoPSI0eVhnSHRzQXorTmNWdzNGNDhSelhWa0g3eEU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFLdkRRQ2NRZldBWWhNSUN1VHRHb1ZpRXdnSzVPMGFoVURBQUFB?=
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
x-ms-office365-filtering-correlation-id: 419f1fa2-64e7-42cf-f48d-08d7d58825bd
x-ms-traffictypediagnostic: BN6PR03MB3044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB304422E61362F0267DEE8CD599C80@BN6PR03MB3044.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(86362001)(8676002)(76116006)(81166006)(66476007)(54906003)(64756008)(110136005)(66446008)(8936002)(66556008)(4326008)(7696005)(66946007)(316002)(52536014)(81156014)(478600001)(5660300002)(55016002)(53546011)(6506007)(33656002)(71200400001)(186003)(9686003)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJ7z9AvL0AnwejElDkOc1PwXEkxfEQi4v7wimPbd25ti+w9VXrI2oyKwz3jhO5MgCezWEXnEO48gqC8vpXfwJ3z9Svlj/xVrBKaOmt+BgbH0qdyYQUsZ/Ug2LafC0IxiFnorbzvUnvu8SuRTGcNJYHYACBRqPBV3B4w9eJLQM+Ts4s3kpzI/4BL3vxGFc6fvb5aXZwh4zEeecnbLb95q3+PnHqZG+s8S0Ra+TDxvhLuBnBD4ZnAJmVYfCjQl7TYgBxUxrmAOvD7M9UqbCgldacc8sKF+IpIA+gZtWIuNb+FpfWKjy5PKRmw3ouV11bFYSU6NdUzd742ep8ZfahI5ateTRVQUIU1rqS91VnQ9yL9+SmafMmBc0oOdbeyUK9Fd7Gf9jQ9bH0p9RqVP11InOtO+nUG9RM40NIPhQXssfVh/rn4JCXtPztPa+NI2tmDi
x-ms-exchange-antispam-messagedata: zP5Up7BS2E/5Iwu7wWYYMwbK9iNtPxQoi3a5iN+p5WGY2VpJLqQjo5KwZcq8isGrT2gAKf2rHmOuM2uU78QqFwu8l5vOI3y0WfYKRMEz1aClKc3XXsWdchrKWQeUjOfQybeyPy3dHTQqfCWNqWb/pXQXmMTt8D0WQTGvX9OnUrmBL7dyWFHHPriKj1bDTVCQRgzBaP2Otx1i2+CFeTwjFg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419f1fa2-64e7-42cf-f48d-08d7d58825bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 15:28:22.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kIb64xvnWg/DbeJmc2VqxyQjjfiTDFep1NF51GcXtBl/MfAxNA/Lz0A/dSISkjHLSNfPky3H1YhpNMNDGUPXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3044
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003310140
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
> Subject: [PATCH v2 2/2] iio: imu: adis16460: use
> DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
>=20
> debugfs_create_file_unsafe does not protect the fops handed to it
> against file removal. DEFINE_DEBUGFS_ATTRIBUTE makes the fops aware of
> the file lifetime and thus protects it against removal.
>=20
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/iio/imu/adis16460.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 9539cfe4a259..f96cfd007957 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -87,8 +87,8 @@ static int adis16460_show_serial_number(void *arg,
> u64 *val)
>=20
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_serial_number_fops,
> -	adis16460_show_serial_number, NULL, "0x%.4llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_serial_number_fops,
> +		adis16460_show_serial_number, NULL, "0x%.4llx\n");
>=20
>  static int adis16460_show_product_id(void *arg, u64 *val)
>  {
> @@ -105,8 +105,8 @@ static int adis16460_show_product_id(void *arg, u64
> *val)
>=20
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_product_id_fops,
> -	adis16460_show_product_id, NULL, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_product_id_fops,
> +		adis16460_show_product_id, NULL, "%llu\n");
>=20
>  static int adis16460_show_flash_count(void *arg, u64 *val)
>  {
> @@ -123,19 +123,22 @@ static int adis16460_show_flash_count(void *arg,
> u64 *val)
>=20
>  	return 0;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(adis16460_flash_count_fops,
> -	adis16460_show_flash_count, NULL, "%lld\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(adis16460_flash_count_fops,
> +		adis16460_show_flash_count, NULL, "%lld\n");
>=20
>  static int adis16460_debugfs_init(struct iio_dev *indio_dev)
>  {
>  	struct adis16460 *adis16460 =3D iio_priv(indio_dev);
>=20
> -	debugfs_create_file("serial_number", 0400, indio_dev-
> >debugfs_dentry,
> -		adis16460, &adis16460_serial_number_fops);
> -	debugfs_create_file("product_id", 0400, indio_dev->debugfs_dentry,
> -		adis16460, &adis16460_product_id_fops);
> -	debugfs_create_file("flash_count", 0400, indio_dev->debugfs_dentry,
> -		adis16460, &adis16460_flash_count_fops);
> +	debugfs_create_file_unsafe("serial_number", 0400,
> +			indio_dev->debugfs_dentry, adis16460,
> +			&adis16460_serial_number_fops);
> +	debugfs_create_file_unsafe("product_id", 0400,
> +			indio_dev->debugfs_dentry, adis16460,
> +			&adis16460_product_id_fops);
> +	debugfs_create_file_unsafe("flash_count", 0400,
> +			indio_dev->debugfs_dentry, adis16460,
> +			&adis16460_flash_count_fops);
>=20
>  	return 0;
>  }

Tested-by Nuno S=E1 <nuno.sa@analog.com>

> --
> 2.23.0.385.gbc12974a89

