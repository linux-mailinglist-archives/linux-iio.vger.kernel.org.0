Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92301B1EF2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUGoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 02:44:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20800 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgDUGoC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 02:44:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6glm3013820;
        Tue, 21 Apr 2020 02:43:46 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf60cqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 02:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5AC383+V4KA4AZzb0hHXg/9RvSUbeP9AZophxpF8MQ4vcJlhzkixs5WYvso0KtX7YroPo/wjPCO+kljjRmTrfi408fWoALh3GAN3BHB4RLEkRoMWHl/xpcmKEjBhQcPr3zHRGqW3wbTfo+XkKFY8oUd4VAConz/v+czNL8ef1csvpMT/yASm2q31+N8RT0upkbaPN4DV9RcWd0PhjVKgccrlBhZWgj4mVDHHj6AJsFT0O2FUnicNDZyDviohSuDQHTCo6tAYPHTC2P7trE6uOiWqdJ8atd5cVmHKxg1bLbEGjbwYupyw4gpv622vrv+eGouJc09qWOAPFsERPEeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/mw2zOpCx8qSBkaNDq2KoHM+XjeUgFdU7cm4+bDpkI=;
 b=J8RK2tAdG8z9pknZQjUg662AG8JpE+stK2XaLJFIuvkRqRH4O/7IC8DeLYyrr7NDYJZFv6l3Q80wjV+L09EHXFPfB44kkP4Wpwi5yTGjF4T557xE4ZtLDxGquQYwoIg1PEWx/KznVKHnF4ZvJILORu/7cy9zxkoyaJoryPUAeQZrkvUcwp2/TibQW8Ya8JwmvE4jmGf8+dzF09tY/GagzCBAE3nW5R5AA+aFWV6nzxP63OrpNjMjgfOXKoLRWrCPb5LZsJ+l0lULBJe0b5e0biqPoIsaSWPDZkkoXLYLfBVZo4GaLYwl9S2jlp9YDf7i6kZ2/6OjK/Q6/4WVp5ALOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/mw2zOpCx8qSBkaNDq2KoHM+XjeUgFdU7cm4+bDpkI=;
 b=Hc9A10hKh2vEOZQxNl6w4VPsIeoTQhX2DJF4a4HXP9yfhAclImoLonrOwqDT8x47KELjV9ijDnpaIdVrAwoFc8xWqy96BqD2kh/Q/7miJEPjbp/X+LtZERGMXw5BWwokvkbgL3EAVcwMb9oHL2OsZYwTH3nEt2g5V3HkYi7Q6Ac=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2594.namprd03.prod.outlook.com (2603:10b6:404:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 06:43:44 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 06:43:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use put_unaligned_be24()
Thread-Topic: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use put_unaligned_be24()
Thread-Index: AQHWF3RBnKDA7NadXE2o45HwMNy3k6iDIVyw
Date:   Tue, 21 Apr 2020 06:43:44 +0000
Message-ID: <BN6PR03MB33479ED0E14BF2341C93563A99D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
 <20200421003135.23060-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200421003135.23060-5-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNzExOTg4MzUtODM5Yi0xMWVhLThhNGYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDcxMTk4ODM3LTgzOWItMTFlYS04YTRmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTgyIiB0PSIxMzIzMTkyNTAyMz?=
 =?iso-8859-1?Q?g4ODk2NTMiIGg9IllmSVFFRGV6ZkdOQ2NVVHQxUU9jZW5vTDhKUT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQzFYbTh6cUJmV0FiaUpIVzk0MkFlR3VJa2RiM2pZQjRZREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBNXVHRFdBQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-originating-ip: [2001:a61:2420:e701:28a3:c430:6480:d41c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 370860c5-3235-445b-724e-08d7e5bf5688
x-ms-traffictypediagnostic: BN6PR03MB2594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2594B7E51DC7D82D2F00494199D50@BN6PR03MB2594.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(2906002)(71200400001)(4744005)(5660300002)(86362001)(9686003)(55016002)(8936002)(8676002)(4326008)(316002)(107886003)(478600001)(186003)(33656002)(7696005)(76116006)(52536014)(110136005)(66446008)(66556008)(66946007)(66476007)(64756008)(53546011)(6506007)(54906003)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMEmD2IOdlmBGNrxIRHLPFAbSA7DXPp6EojU7plG9oPqsvXzuWOgloyy1trExQMoYzJhOKCqU/JbkgM6WSEtqr85qqG2G6xR62E8Lybu/O0iFQF88l899fb3t2JFZyFXjxwoFshcOHk9A/ClV29UxaEFlqXxkSzNMm567LtQIt18UlbbfPCGPs9c5ekKCpeR67fwHIl4h9kiIPy2c+DJxNKt7C1Fjxpx3xMns4o3ud+KijNfMJFh5MCzdG18ocYDTX4RRC/SsaDwJw40RZuGO61VqD05QrPCPcOWTiwSBCePwaruROM0smApzfldoFwTo4CXB5xbO2hHH0ITeYJDModZ38bEDR3hD5kWtCAHy0sSBPDjy00+cMJ/62EH7NptZPBiRweCRYkv2OswIQKeyPQgbsS70QghB+COiJgQHXb42ofs39zbzhBMVrXpCeD+
x-ms-exchange-antispam-messagedata: svLaTvXGnqaDOsmYWWsqmIOhHvF+3yyu4KJ2H6No15hXwvSis5crFkNfD53Mgae389bQAegoN5fMcoZR/XIxhfLKT1bD+t9TvCnB7UJqKnXnGUN3KOv3p9t2nFtN4fqth20d1AGW58M8VfpxTgijIAc8Uon1OuSyJPQInqJX6kfiTXmZeOcMtXa4MrgoHCJt4L/YQJd4/P6D/ukImAvwIw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370860c5-3235-445b-724e-08d7e5bf5688
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 06:43:44.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wn1fKEZyMAyBNunTAOMuAPQSGJHoCgGBRmAFJj7SoXK95YKAWChCrvSlb5B1GXVdHHZLw5oNMCKnCy+uE7Q3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_02:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=747 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210055
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
> Subject: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use put_unaligned_be24()
>=20
>=20
> This makes the driver code slightly easier to read.
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/dac/ad5624r_spi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
