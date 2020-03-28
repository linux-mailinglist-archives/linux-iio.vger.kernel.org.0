Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5C1964D6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgC1JoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 05:44:22 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:60282 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgC1JoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 05:44:22 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02S9eR4F017561;
        Sat, 28 Mar 2020 05:44:01 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 3020bb0dhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Mar 2020 05:44:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmJFh1Ibe3y5sJ4MptfA2WoluwlDuf8bkokHDhjraJVpthDsvyx+mDHyJpVhiiro/bkSpqI8YoC/CHTXDBQnRRPNawt6vCRZcAUiv0lAX3kbQ7e27aSxOafcXBe9p4DJ0M5VS9yl2Agew++z7ZjoSDubta2/kE3Jjpq3Z/hBCRclbwAz5IVVGTiUYxEJLz1xaFjJPYvAqi3fEldKe0vN0hdvoiOYyDVjd2AKEr4uVQ4hiZftU/PCclB8mGvIHJss6FaafvodFdN2r38EPq24qt7voq9FZ8DX3vRHXTWEXc8oaTRAQyhd8XvCxnd1QjUx78Zg73vhnXqxoVp6cLzonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DQIKB2Im3lWQH9mJwKlFBioE0uPLOSfrIBMQbHRXRI=;
 b=ITUUD9EFvK25VCJpfQt9tXPF2MzhhSct/8Y2o8TSdXPnOU6rqLfSP70MUG+Bw7aSVg18XxEADWZpMZwTbCKCxtkbPmq5PKe08Qe55LTIkdNxLyZKi/cK5wdNLtSw+uI3BHtTUbEezrY2WJ7D9BPvYM5mSJ0pbT4TXKMAdarANNZWIlwuPKSAOdP4vXDU4BvLTzGqs2ogi+gsHKXoo5tY0QAURJ4HVb3V8zNzPZUXrV6PAj4PR1daRY4cyatd5xGFiOciIB/e9D0ZRf7UCFSvLltBc3IKB2QqvqMJ9/EIJwkGsBzyrNWgCa6jos1FaoVxmaOQRjQGoT8+mPUOCr8BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DQIKB2Im3lWQH9mJwKlFBioE0uPLOSfrIBMQbHRXRI=;
 b=X2lfpk2dX3RO/Es/xoaNcNN7l5k6XrhVT1VyxStpozHwWdSK3p+dZVb1O+PA2r9KHpwmjk09KjMmAr18LTBcfWvJbEcBFl5CBtxI4ceEuln6gx6RPKx1y3Ywb+dcqFwzJZkwzQBRkSpgxxAbPgSnl5tQEch2I1BNl6KaZOaNc+I=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3250.namprd03.prod.outlook.com (2603:10b6:405:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sat, 28 Mar
 2020 09:43:59 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 09:43:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH] iio: temperature: ltc2983: remove redundant comparison to
 bool
Thread-Topic: [PATCH] iio: temperature: ltc2983: remove redundant comparison
 to bool
Thread-Index: AQHWBM2PtVEh+oC/9Uy2VzpjHg8Q66hdwQlg
Date:   Sat, 28 Mar 2020 09:43:58 +0000
Message-ID: <BN6PR03MB3347A202426BE1F409B3A68599CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <5e7ef454.1c69fb81.56770.82c7@mx.google.com>
In-Reply-To: <5e7ef454.1c69fb81.56770.82c7@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTRhZTI0NWItNzBkOC0xMWVhLThhMmQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGE0YWUyNDVkLTcwZDgtMTFlYS04YTJkLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTkzNSIgdD0iMTMyMjk4NjIyMz?=
 =?iso-8859-1?Q?c2NzEyODg2IiBoPSIwR0UyaWdDMWFoM2VzK21BclFBbWU3TjQvMkE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUMybWdsbjVRVFdBU0JqOWFHSEJ2RFlJR1Axb1ljRzhOZ0RBQUFB?=
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
x-originating-ip: [2001:a61:255c:3401:d8fe:91cd:c864:1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b9b9798-8ecb-4c0b-57b3-08d7d2fc8a45
x-ms-traffictypediagnostic: BN6PR03MB3250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB32508D47070EC2EF779AE4A099CD0@BN6PR03MB3250.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39850400004)(376002)(396003)(346002)(366004)(66476007)(5660300002)(53546011)(6506007)(33656002)(64756008)(86362001)(107886003)(66574012)(110136005)(54906003)(66946007)(316002)(55016002)(66556008)(186003)(81156014)(4326008)(8936002)(66446008)(9686003)(7696005)(81166006)(8676002)(478600001)(52536014)(2906002)(71200400001)(76116006);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRYARX4WOZQ3I6RepqOlfaUvTweTEoy/tSzey5sFPn8iqbq3LMxtTkzsLsO9g/nlyY2sCLLsh2ZHcTJhZpWtUQPbEvOzpAPCI7lI0npFyy8Ki/XSHm1Ya7kKO5XoMMthG1xNyInzfiz/17nUR6Ve4HUItsc1gUY7dFUE6GxtDfYhxju50qOqFiizyN0ux4Qob8a1IL7OFjyXRtp/2PQYHwBVn448Wtq8IMl29Nh81a3lBSQ4gikxKCAePxWU8zouv+iEABKJPRGMUJ9SDf370oNFFZKkLYL4PnHKM5Y0v/OgLhkhHhipNebyafQ6GICsFnUy2eHR/zlU5xVFjYroh6dPbvvdkUfcRSlr/a6l3oMt0+VhAYvMClpmMCb+TBuN3XjAB0LjeNApFdRdwz2fUHlVl/36Ta/GFkAA1RK63KNDyfUUPArWgCB319MxS8Na
x-ms-exchange-antispam-messagedata: BX/zQDxsB73vb7rWQt/f3Ykid0NZdl3+LZueF6F77yxw2NwLlzx+kNf9xgj7svVrBHwWG64aVCtEKpBs61jabTemXhpXP4MBB2o12NoMWhHUOjxzEvdAswowii2Gna2686MycvNWBytHU+NEgwH8oLTnFgCarpWg/O6X+CjTawabQFJRlOtLuDqBr3CH4HVxvjM0r/k29HO7hiT2lRji8w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9b9798-8ecb-4c0b-57b3-08d7d2fc8a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 09:43:58.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWMougPtKdIHEdgSxIG+zMxH4EJDn7J20un4T6kNRI/AkLFWmhN2DBgWRHJMlZ6LfPPP9r4OkUb4aqh7RNRRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3250
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-28_03:2020-03-27,2020-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003280091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Rohit Sarkar <rohitsarkar5398@gmail.com>
> Sent: Samstag, 28. M=E4rz 2020 07:53
> To: linux-iio@vger.kernel.org
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; rohitsarkar5398@gmail.com;
> jic23@kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>
> Subject: [PATCH] iio: temperature: ltc2983: remove redundant comparison t=
o
> bool
>=20
>=20
> Remove redundant comparison to a boolean variable.
>=20
> Fixes coccinelle warning:
> drivers/iio/temperature//ltc2983.c:393:20-32: WARNING: Comparison to
> bool
> drivers/iio/temperature//ltc2983.c:394:20-32: WARNING: Comparison to
> bool
>=20
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c
> b/drivers/iio/temperature/ltc2983.c
> index d39c0d6b77f1..8976e8d59826 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -390,8 +390,8 @@ static struct ltc2983_custom_sensor
> *__ltc2983_custom_sensor_new(
>  	 * For custom steinhart, the full u32 is taken. For all the others
>  	 * the MSB is discarded.
>  	 */
> -	const u8 n_size =3D (is_steinhart =3D=3D true) ? 4 : 3;
> -	const u8 e_size =3D (is_steinhart =3D=3D true) ? sizeof(u32) : sizeof(u=
64);
> +	const u8 n_size =3D is_steinhart ? 4 : 3;
> +	const u8 e_size =3D is_steinhart ? sizeof(u32) : sizeof(u64);
>=20
>  	n_entries =3D of_property_count_elems_of_size(np, propname, e_size);
>  	/* n_entries must be an even number */
> --

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

Thanks,
Nuno S=E1

