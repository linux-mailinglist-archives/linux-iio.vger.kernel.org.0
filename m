Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA31D46D7
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgEOHNG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 03:13:06 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:30340 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgEOHNF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 03:13:05 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04F7B1BP008148;
        Fri, 15 May 2020 03:12:42 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 3100xps6tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 03:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjbSqY0i+tAn4ndpMr4Lx0w46sZL5UQD0Wkzn7OWNFOwuRnDo1/psRBlV9l+8G7FHWI13x/754jMcxtEaxRAJuuznLjTbg2qogJyArr3POCSxrvfsH8MN5NiOvrQHLjiaJlozsU3BsNtYIHB7EYhXs34ThH4QDXUOOOiqMdymNCy69izxnbkY16nKW+WpzaMRoCZGoAmYpFKwAGxkzpTa4d8onyuAW9aOiJCtsNOmfE5LV30EVsy3JVLTrnpmNwy1alyk4hYsOcdlphIjg8md33cHCbgwzmuHg93op7+VTmQBSFnPSPrzePp/HzA/TJlNU5pztyhVG3VXYnXWvE7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SH1kJ+NaKFXZcaZRwhOIYPRDGaT01Tv0WNJNqqxkkE=;
 b=baNGfSy75Lj6wgosXtrFWBk7H/upI5uNaD+wQl8PRheWUrSmvYiUO0B9RlKT8wtVjdYYuNQpcnJXBgk7xnwEsKfEoeQITGgK1Al7n8bMmpj4Hx9OJJv7TWBup+3MeKXVI6ZXSUQa7vxXZERG9Z9ZkK/uzGPdM4nl5Ep3Sik2KJJC8cqKuSQfXVXBuRbi8gX+zmCtWtg9Ji8mOUFOrNifqnSHrJ6jng3Gc0hcXQjG8uxfCZAXTKThbprj4pouV9Ow8UOG01UzlMXMqqJBCJcWi7Kg13UHShyICwoiVCCTDO0tgbl+6Am0EKx4yZLEtC0I/S6W4hEyDR/b19Wg3rwZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SH1kJ+NaKFXZcaZRwhOIYPRDGaT01Tv0WNJNqqxkkE=;
 b=okgiTiEvI7ucC0vd8SEBDeinJSTWlwMt5qH10JUBqN6iwttztisEi8D4mKaPQXoIwKQIGPVHWuL+8VfeF39OCqhRgF2ji/fE0y26c5SxOidCbSmrRYFe92yXLkBM8zHoXzsrXiVPNC8TWCFme1+kRsrkmJQk/N3O3ibZhi7xySk=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2499.namprd03.prod.outlook.com (2603:10b6:404:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 07:12:41 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 07:12:41 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Topic: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Thread-Index: AQHWKfIlEQ+thZzvFU2AhvRLBAoa1aiou+ag
Date:   Fri, 15 May 2020 07:12:40 +0000
Message-ID: <BN6PR03MB33472A1B559F98E3BDCAB40B99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
 <20200514131710.84201-8-alexandru.ardelean@analog.com>
In-Reply-To: <20200514131710.84201-8-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNzU3OGM3YzYtOTY3Yi0xMWVhLThhNjEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDc1NzhjN2M4LTk2N2ItMTFlYS04YTYxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjMwMyIgdD0iMTMyMzQwMDAzNT?=
 =?iso-8859-1?Q?k0MzcwOTk1IiBoPSJIZ2YwNnNsRHZHYXVKQThyWWNsekRLQytZd2s9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUN6LzlBM2lDcldBU3dlMEtDaGlXb3FMQjdRb0tHSmFpb0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQTBFSUdyZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24da:5501:cc3f:7631:1113:673f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cce4b2b8-2964-40f5-dc01-08d7f89f5b40
x-ms-traffictypediagnostic: BN6PR03MB2499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2499429855279CC117988B3C99BD0@BN6PR03MB2499.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkP+9WRNhkdcODYhmb7WJmaSKE10IJn+3sNpTByyuX3gvexQyaKSkSGfjjwzhRh/UKaJRyCxargbRXM70lpUofcmhRdXGqaK9g8jPWiBg+/2IhoGADlnesJKDIH4H924YfL/+/dAsw6RkiG78wo21ZDoTjwQKGNl0q7Bw98jzhDoFZDSAGdDXFNwbBbkgwDk1gFoxmcSe0gD+UcoVoQoTRDuNGM+gJSWRi+VG+/30FDm1bIYPeMQn84fNFKvDLQtq5VTKGGXoXJOc93pbxzWmnmESW1ArQNrgOwlo3i0dJWC68/rDsD7lB+tCJaAWjzHfU2WFNQYGJ17Ghw+Wnczn/1Vj8ezco5NT+aeWJZYomm0LrCjSIyg9mR/a8WRbcXw0FtiqjfJZItLFDUHVzreIN143PgqLU0QxvoHmE4QHp2NkPxqt16N7E+iZUfJJuZW+BqLUvks0ga+2fC20Uau+NmOk7BRQESF4jsQNTclcxbvgN+PeBVV0CoToJWZI8558SU46kiSpKDp5RkeX44Bcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(6506007)(53546011)(316002)(54906003)(110136005)(52536014)(66476007)(64756008)(66946007)(5660300002)(7416002)(66556008)(66446008)(2906002)(71200400001)(76116006)(55016002)(7696005)(186003)(478600001)(8676002)(8936002)(9686003)(33656002)(107886003)(4326008)(966005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dQ+R5zlb+3AQKygEkZrHCFOKtqVFEUek9DS4NqhCr1nGkMb2IkEmu7n61+klBGmPUf+QUlmIeuwG/nDBb/HDppvOuAauUQxT/gU42L8//AT6zKYupMBz91bpgII85pzoT+sPyYUPOtLhLVLu7uXfcUtmAb9AxjTiJRNZofTK1W5QVce8cW03XAmzggltFy5Zo+C89bC+DjS7BVwQOtNH7i/EGZb06Kkt6vUcrA79xbiilS6cMltkDkWTkNo3Su92H+3/WC0tNVJd6D0YxXPrf3RZHNt+Xoof8DinVsJ6xpPvLw77/683b3ksRD8QMWoBKZGG7NAHiqRJ1Qbed7z2AdNjsIKnuAiaq1Mr/CVhQ683X4WwKd/jJBL+c0J5AXkhcWNNtpWOQf/1dFtMG2n6/uV/ex3iqWVYySMBlJYZLlD1r1sGUyI2fszQ314t5CqTlE+U4jjEFfIX5XWHmnD0mUo/pcEPmnIyWJHgrzRnBuT2YPcWs/5Zzw9rD1qst5xSOT+mPFqjv7mqXo9GYm0QBxpk80hVHBXbJOx9B+5l+AyMP9BBgmF9Yr5C7nTl82fQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce4b2b8-2964-40f5-dc01-08d7f89f5b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 07:12:40.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+1D69+uux8/iwCFo3eZeQlpfTo9OZKWZGmEl0CdaO6cJA81p7w/Acs/N22BIYLOs8BIBUh1JBm/RH75V5C9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2499
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_02:2020-05-14,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Alex,

Just a small question...

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> On Behalf Of Alexandru Ardelean
> Sent: Donnerstag, 14. Mai 2020 15:17
> To: linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> stm32@st-md-mailman.stormreply.com; linux-kernel@vger.kernel.org
> Cc: ludovic.desroches@microchip.com; eugen.hristev@microchip.com;
> jic23@kernel.org; nicolas.ferre@microchip.com;
> alexandre.belloni@bootlin.com; alexandre.torgue@st.com;
> mcoquelin.stm32@gmail.com; ak@it-klinger.de; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [PATCH v2 7/8] iio: core: simplify alloc alignment code
>=20
> There was a recent discussion about this code:
>   https://urldefense.com/v3/__https://lore.kernel.org/linux-
> iio/20200322165317.0b1f0674@archlinux/__;!!A3Ni8CS0y2Y!pgdUSayJCfxMiE
> w8Fpv0LkEZurCSkX0sEcLnXeDSCLmhpu1xont6-vBQj3ZbCw$
>=20
> This looks like a good time to rework this, since any issues about it
> should pop-up under testing, because the iio_dev is having a bit of an
> overhaul and stuff being moved to iio_dev_priv.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index a1b29e0f8fd6..7671d36efae7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1514,13 +1514,9 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>  	struct iio_dev *dev;
>  	size_t alloc_size;
>=20
> -	alloc_size =3D sizeof(struct iio_dev_opaque);
> -	if (sizeof_priv) {
> -		alloc_size =3D ALIGN(alloc_size, IIO_ALIGN);
> -		alloc_size +=3D sizeof_priv;
> -	}
> -	/* ensure 32-byte alignment of whole construct ? */
> -	alloc_size +=3D IIO_ALIGN - 1;
> +	alloc_size =3D ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> +	if (sizeof_priv)
> +		alloc_size +=3D ALIGN(sizeof_priv, IIO_ALIGN);

Do we actually need to do the `ALIGN` again? It seems to me that `alloc_siz=
e +=3D sizeof_priv`
would be enough or am I missing something obvious?

- Nuno S=E1

