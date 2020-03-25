Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD419229B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCYI1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 04:27:16 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27896 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgCYI1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 04:27:15 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P8PUGD013121;
        Wed, 25 Mar 2020 04:26:59 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywcp9unhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E542eqNhwxy0YlKs/OY37nG9sUpp1/1fBM7nlq9EdYOqukDgw4F01S6QscjA1rNvwKbYepXyTkonQFWuHbsXOBABzotTPK4E6v61NluawGTtHTWjn18HPXrz9vrvNH+6jQptAVvKbw/2jYfxagr4Qv20lqaVp0dwFro2hlUeE+eDkgaZxIOdRIqEGnTV9kIz4yBlaJHIPFlYqftR5tSWgJCugViRHfgoQsLXy4iG7V+Rlqu2ul3owCpxTPN+VeSj0Lh9iwvDAYYWfrDxJyfEcddOlJxc+zrOm6JxkDTSkF4gZ1jhNortXsgPWtiKvNxqcwsX/OF35L4ufztM1c3kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX2X8wmZJ8Mw/N/N2XabSdMmqavBsqcN8z0JKFu+Utc=;
 b=EdYgoem2L5fr421WupH7ngSHrx1tOD2nMi9cFCfLOnXKw/N+/R+FlIjashH9LJkNmF21d3KAJH3pVtKV5qEbXykqV+9oEOOqcqjzym1iCuR/3HSQgSIpkVOUjd4zMAQxK5Zv+DJzz8JyOtN0wHcjfEdQXk9sJo0TUjKw1hkLfnLrtYlJ5TyHHbahjefWM+3HKwq2Gr2HvKN9PReHzGtslSUp1svVPVPFSivfdGz4/qgukRvxoTcaADoL9RviyWwKR+2oCjNt86tMr8pSpWZCAgJZflm1ii+MRc9XfD5EIXqaFZHYLt761PPFHdhX0xdM9F7x0voHxcoNKOztS1gYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX2X8wmZJ8Mw/N/N2XabSdMmqavBsqcN8z0JKFu+Utc=;
 b=uAOSpuMyNizAIyUgUmXJoLKk3N9o+HuwvqtLWA9I0d6+AJbZFcJRXcH4pDNBSmbpGY02BHhLAGXG4QVOgjKoRa3eK2qUr0zt0j7Z0OInqru7pmYUWQA7Xeu2T53zr54j0OU4rkb9FWx98tRPbQwCHVFFSwjir/vJxZ7lAABiaJY=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2916.namprd03.prod.outlook.com (2603:10b6:404:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 08:26:57 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:26:57 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Thread-Topic: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Thread-Index: AQHWAebuVlEqYeDkC06bXWytoxAxxahY84hQ
Date:   Wed, 25 Mar 2020 08:26:57 +0000
Message-ID: <BN6PR03MB33471B79BA11923CE08971B199CE0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200324141624.30597-1-lars@metafoo.de>
In-Reply-To: <20200324141624.30597-1-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjBjNDIzNDgtNmU3Mi0xMWVhLThhMjktZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDYwYzQyMzQ5LTZlNzItMTFlYS04YTI5LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTYyMCIgdD0iMTMyMjk1OTg0MT?=
 =?iso-8859-1?Q?I5NTQ1Mjk2IiBoPSJReUpMVVkxS25OUSs5RTFCbkdZMEdMRVdxUVU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJRbEVBamZ3TFdBWTlGOWhMcGJTbUpqMFgyRXVsdEtZa0RBQUFB?=
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
x-originating-ip: [2001:a61:24be:d901:25e4:37d0:e498:156b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b626421-e265-43de-834e-08d7d0964899
x-ms-traffictypediagnostic: BN6PR03MB2916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2916240C4A6F22E7C3AF254599CE0@BN6PR03MB2916.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(478600001)(81156014)(66574012)(81166006)(9686003)(55016002)(8676002)(8936002)(86362001)(33656002)(4326008)(71200400001)(66946007)(186003)(66446008)(52536014)(6506007)(66476007)(66556008)(2906002)(5660300002)(53546011)(64756008)(316002)(54906003)(110136005)(7696005)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2916;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9sdd00PW+x9C2HmJavwpLclyw3pSf/PKnPhxd3LcBSckAlLS6vc/2v72WRaQh2GVBt1d+ZR4DpRSvTK2uF01/rlGc9zm0x3XtLo8IGoez+J21I/4z77OA46yWsewe0HEyEp6UUh82QXBvLQdmKIE9KUKLylVaveBM8/DO1fmhAsyEdNd+lIbeS3TvTOTxEenxiPgRFBhI+JPG6cZ17vDueaYfPbz1/zTspn/WJQM1yoi8gSyNMqhxJnjyPFtUn/lDAq1JQQYCev3bLO5BGvh6dTCmd4MXjQWfSfIYV2KqJkPKYotSS+GzZjX7dBrcGhL+TCA7E1irXXQTyA5gPpl6f3wDnxJIrNPtURTGBFSLGel32ctCs+g5jfFytQWLXu3uiGCoQw+BqGVjq1yjQlIdbQ5BrfQxLyn9JVeTqdjSq8QsBRuWUjeURTjXAOgtUp
x-ms-exchange-antispam-messagedata: WrCWqUTakAGHK+ADd3g39QXEwoK5LaUnF6Rb8sPkwJZiDQy6a75dVuZ1RlSg0uvoTHhhj+zln/+FjlNwN2CaWtZEcOfO2msp0PzsmsnSnsShZ1lGhMgAgXg0f4hcVM8SqtnhWfSBjqCZv2LC6IDN790mbghsE+E2xXKr8AWTNwiEM/ntvca0UbbdJ8PPmpNV+NE2iuCi12E7ZGA1UeB0Mw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b626421-e265-43de-834e-08d7d0964899
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:26:57.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhPxWRGJvcSpq3eP/rz+XWme0fezx4AvQan4+JngklQWnSKGPuGWJ67C61S5pg2DfFDbl5zSgicJLcTe3L5hpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2916
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_01:2020-03-23,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=624 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars,
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> O=
n
> Behalf Of Lars-Peter Clausen
> Sent: Dienstag, 24. M=E4rz 2020 15:16
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>; linux-iio@vger.kernel.org; Lars-Peter
> Clausen <lars@metafoo.de>
> Subject: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
>=20
> The IIO DMA buffer is a DMA buffer implementation. As such it should
> include buffer_impl.h rather than buffer.h.
>=20
> The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
> access to the struct iio_buffer definition. The code currently only works
> because all places that use buffer-dma.h include buffer_impl.h before it.
>=20
> The include to buffer.h in industrialio-buffer-dma.c and
> industrialio-buffer-dmaengine.c can be removed since those files don't
> reference any of buffer consumer functions.
>=20

I also came across with this in ADI internal tree. Did you considered to al=
so split buffer_dma.h into a public
and an impl header? Hence, users of buffer_dma do not get access to the int=
ernals of buffer.h? That was the
approach I suggested in our tree since the split of buffer and buffer_impl =
is exactly for users not to
know about the internals...

Or do you think that it's not worth it to go over this split in buffer_dma?

- Nuno S=E1=20



