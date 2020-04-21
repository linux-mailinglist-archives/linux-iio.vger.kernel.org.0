Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445001B1EEC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgDUGly (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 02:41:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6612 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgDUGly (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 02:41:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6WjEA032205;
        Tue, 21 Apr 2020 02:41:36 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf60cj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 02:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO+TygMyhlzZA8szZNJCZ0sKpcYwK2I0V4/BZfF3ARXuWqgmQlsLlndj//t7HYl3cOnZVzaNZWOHZbfX7UCDORDj9ib6jUI7St4OapiDokiBnAs5NPYqlLNAs+C0qwq19gZSGofgrsSeNQOF8uqukmLGZsRjCLXxZVOZh0iNYyPLQiGBF+e3eujf76CBmhj2ADFxCBHJgp4S7yVYZ4jFBMRZXCwf92JmLXxuOw04I+1okYUtnSkRORlkS/wV4oQNEK7FEu+0b5x8LSsvGhH8oDF5Y9TrDU9ra4SksbrdfFUU9CeTil410xQ78igy5OYgPVSWyiDTcu+BEOZOHbRW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nPwW0VDkaZLZotFmXQhMHG3iS6HO6VcGEnT5zF37F8=;
 b=hBDpwYSSz5UPih8SMBgHoxrF2+8w/PZZ94GR1L2pOCxUX5hl0ocI8LmoEpPTqhbby+44ks1WpB/Cr66vFbOenLFrE8KKdqLEUbbk5c0gJKLbrNS7v9+3Z/XQ3GNgwox0kg6gqxKryIvbCiaos4vf3lGX6pnczk4b4tEyhjbA3Y4a5wQBXlmyMHTd2QNuAdNfpAdZRyzYd5xDNV/0KPYzgKzhPaOHdzpc6MheXuy8Lmn0hBtNfa7OgKIIKNTzUKgX9g46y81M99DhE8ereZA9/y0Kat3e2g7Q23esK+HZCkR64vhOh3NBbVan+FqUxzj66RSmxTBJ1lUu6LpwAb6btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nPwW0VDkaZLZotFmXQhMHG3iS6HO6VcGEnT5zF37F8=;
 b=OfyjJrSAgeXITh905oPlzacI1mfgArHV6pDlzPEjFdog4cAM8MxVFJAZxLs0P+rtmTP+dd7XoA7vZMH5CJQOx5X0NePdQuUn8/sk54ew+UWC3r9/k7W6x9IfkKCijspUssNo1tLteCPRzHvBCBYj+PyVnXBDe2D5T7jXs5dHAVA=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2594.namprd03.prod.outlook.com (2603:10b6:404:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 06:41:33 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 06:41:33 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use
 {get,put}_unaligned_be24()
Thread-Topic: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use
 {get,put}_unaligned_be24()
Thread-Index: AQHWF3REQhKKrBkDL0aK0jGkwrtiMaiDIKkQ
Date:   Tue, 21 Apr 2020 06:41:32 +0000
Message-ID: <BN6PR03MB3347CE880B5792D1C8BEE40999D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMjI3NTE1Y2MtODM5Yi0xMWVhLThhNGYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDIyNzUxNWNlLTgzOWItMTFlYS04YTRmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTAwNiIgdD0iMTMyMzE5MjQ4OT?=
 =?iso-8859-1?Q?E5NjQ1ODMwIiBoPSJ2WUV6ZnhsZm96TGJxKzY5ZGwrWkgxbmgwcmc9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNHVHMza3B4ZldBZFRrUE1CajBSRUIxT1E4d0dQUkVRRURBQUFB?=
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
x-originating-ip: [2001:a61:2420:e701:28a3:c430:6480:d41c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 760147a5-7fac-421c-dcc5-08d7e5bf0852
x-ms-traffictypediagnostic: BN6PR03MB2594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB25943D21C35DE289C7CF4BF399D50@BN6PR03MB2594.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(2906002)(71200400001)(4744005)(5660300002)(86362001)(9686003)(55016002)(8936002)(8676002)(4326008)(316002)(107886003)(478600001)(186003)(33656002)(7696005)(76116006)(52536014)(110136005)(66446008)(66556008)(66946007)(66476007)(64756008)(53546011)(6506007)(54906003)(81156014)(142933001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+77YuPUyW9Q5vmSArqUIhyCtfiblC2rsC5hQGi2hbXOCSyQ+hrWaAq8kwNeHNS15K75WeUiFC0AJUZ5IuHOj6NMkiY/WyAu5F7uQ5rb7AVmcIJBnS11pGH0Hnz+mhDimdMKI2q7Os/KXN9Emu3CjmV3JSRvHJFAAhl6E/Nd8M8lBRXs88Ze0oqST1n7Fdn1aLae8DDECeAZAPKZsMKOy560aUrD7+FdcEtRD9Psnat3ckQgJOkkqL3OOLTMY/n/e9UltSM/JZRgHGmLA7oE+h6QdIHuMepRBa3KPPBKd+W2LkIeBZHuQK2BO22y/oXCcThhs2IpYFArOuh7Mtwd3KaeztwUuBOYULLanCg3X4i/pSOK1Krpn1kozjbiwPdw+z2cvBJKmZ0hMSGoaOv5rpqONYRaEkoaPbn+yhyHDy69/zzfob+Vd2bGLQPaE34o/5FR61tnz30lUhkQkIvNIg+veeqCB8PrdCEJERFT+RIgowkXrucOCzSQH00pyEDm
x-ms-exchange-antispam-messagedata: /ZPms5qiTlJCdScPeAzEEw58zunY3JWveUs66q3S3fTASo+fqqJ09dnuJsfkCPVN5kUdxjEH8ig7OIjxo9gyummmGSEubM+ILqP6PTJUe5I05W4gljLB0VvTAo9miM+BfnhJq7v2KRVTC3vIM73rv5YyQZvHtXxDjxCBITgUyi1//AKkTlEbHa4NPMWkdAfF0n1NK8bCpbfAM8XduvJDJg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760147a5-7fac-421c-dcc5-08d7e5bf0852
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 06:41:33.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmOmSlK74ZrNddYvhhbMH5o+QWkrZAjSEg6EQZKunhUh0hsp/Mzm+j/l6QbWhXSn8TOt1mgZD8ymVNbpo4spmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_02:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=975 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> On Behalf Of Andy Shevchenko
> Sent: Dienstag, 21. April 2020 02:31
> To: Jonathan Cameron <jic23@kernel.org>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Lars-Peter
> Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use
> {get,put}_unaligned_be24()
>=20
>=20
> This makes the driver code slightly easier to read.
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
