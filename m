Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE644BDF0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 10:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhKJJmb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 04:42:31 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33056 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhKJJmb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2021 04:42:31 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AA6c6sU028593;
        Wed, 10 Nov 2021 04:39:42 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c89000gq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 04:39:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3McxjTlSutkUqUBuet1bEEkq7YEswUFf1oAwbUkOah8v6TuYHTn4O3lnHqnN74YWt1lloDSX+BU4wURYLu+eM1kRiUlDq372UjiNib4FINrPOW4cYFY/+m9eQYd28iQodvnuZ0AAvtjWGMhkn4uT/GfBH9Wmp7ZpBJ7KdShb+Un0XfdYMGvgQXK8yoYudY/S20UwfVhGeI/8QxDIEjN4A0XTdBe6Z9Olh8gewx0d1qf399kOrtJu5/m+Zc2fKfzsUhtWTgYUhe+3tcQO7iY/JABgvm2IcvbsG7V2tyo6n7mLk3kICNAxCh0mmZtZ8U5wYOya7Jko/nKQ4M7ijTKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cHQUZUS5JyH5qqimlWzsAS8WhdQhu3wcpqzx09YN5A=;
 b=P6OtmyXk647nXYL2LVkBoV92NiTtC+JKPaXLc1iID9Q9AiRjCw83DFAM/aFr/VugeFZWWHzMdLP9M0aeBNzLTCAlIuTo1j/Nv7JEScxqoC66P8Di8bEZ41CQh9l/n3jjuxUQz1QcSMOIvGoDWc2dL8wYSe2jSHUcZwB4yY47EViaB5gYhZZsB80P1jxz8vqlD5t1a7xXUnQaBAivWnWwtiTaOLdVrkcnnWaMiq2CWNrfusjzugLGfu0Mqxzx8LY0AWlCuMraiKYiKwPolSYCroCkAi9cDAC2Nwxgh0ZUdkjuMUc8NF2vP08rJB3yC1i4l5g7gu05lfUEGPBh5X2jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cHQUZUS5JyH5qqimlWzsAS8WhdQhu3wcpqzx09YN5A=;
 b=Ili0g5ulS9cK4HTIYib0AeG/BQ+wDeYQxVsB5UBkiutU6+dMNigWzETTeEoA4nCrIz0VOeqI9K9p8IUUneo4ZN21EUgAX4qtyzgnMKgIUe6BGgEMRJ9KC7PdosKTb27iT+IeA8256GBr8NEyBY7o5Xsd/j8lijMW08gi+shLZ6g=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2550.namprd03.prod.outlook.com (2603:10b6:903:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 09:39:39 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 09:39:38 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Thread-Topic: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Thread-Index: AQHX1WXROa8gBfces0OdmTnnZfx+/6v788IAgACOyBA=
Date:   Wed, 10 Nov 2021 09:39:38 +0000
Message-ID: <CY4PR03MB3399F82177CECAA5EB53F3699B939@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
 <20211109123127.96399-4-antoniu.miclaus@analog.com>
 <1636506426.248164.3016194.nullmailer@robh.at.kernel.org>
In-Reply-To: <1636506426.248164.3016194.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0xYmU5ZjJjNi00MjBhLTExZWMtYWJlYS?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcMWJlOWYyYzgtNDIwYS0xMWVjLWFi?=
 =?iso-8859-2?Q?ZWEtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyNjg2IiB0PSIxMzI4MT?=
 =?iso-8859-2?Q?AxMDc3MzczMzExNjMiIGg9IkxOK1Y0TUJmRFBtblNQdGhBV054a1ViNWNK?=
 =?iso-8859-2?Q?RT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBRGIxVVBlRnRiWEFhVkRTUmNzQkRTVHBVTkpGeXdFTkpN?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae54c5d8-b7e3-424f-c9a3-08d9a42e03d7
x-ms-traffictypediagnostic: CY4PR03MB2550:
x-microsoft-antispam-prvs: <CY4PR03MB2550F7D1B473A137840E55EA9B939@CY4PR03MB2550.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJT9E65E75eh/rEhjjvB05TXClrjIEjRvK1JSCviyj0k0WQoBbHG3L14YIGdGzD/Up0ke46p8lB374YUx0JGFHGNNlS0S+6mSO3EOafRRcDIM5clp2CNUCgKT9Ae+aqMr+E24jSplikskIE68QKzKVp87SsjYn//HFOH2oCKVRWIvV/2G7yUYRxRvVw7zrqUBvRwYSEYr/zDIKeyWC+RDuJyRzqkLEgzqPGdSQpIRRaECMJRy92y0H7KT6rmzGNjj4i13NKzZjB1/qc09dP8V8OXftefeYYE2+R4EFneCd7SIVeiE2ADPua9uAGO/bHUMx3h8fkYFem5jch26Wsu8vADcPeuZUodZHYaQOKxZ0NJHWJ7Twu2+m6VBPXCeTrsGhZQ42b2wAvWppeEYEXUuxtHKq6FjXiRndlNtVgEZKRTqZL8eaPs9asyEmKIIjSyVhtT8PCWl1uxPYosrFmkNhL5C6JkUs0fEwOX2Qlcn0EvDP0OMBcY4VfKSFmE54fdLUQXzs/OD98CRCyVV2qKCXIn7h1sGc5CNKIrWk56LPTwREZfafLiQ1RauyRxUiFVZ1HjbqnQhTMCRCaxonmI9XtfVvU5HMSUvGuUpXSN7zMbTXM3ZovoRVtP5C9VxVgYeIkFADG5oDicgXUpqKGsY2oYfe8ApSESbl27hw5tleiqMu6J5Z7CDWXrzJyXodArxcIs4A5b0dRA+S/ruQw+y9cpy+4rCW8livg3nkuuGUq2od2vBzAIzNe8vKV8v0wvqvesTqeomtfCQeyuJQFRzmrdJhXjH7PxFzuFT0vGDV8bLqpgQS8beEKE2AVWEX8fM0Q4VacxyZ/iIWdDkqhNAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(8936002)(9686003)(2906002)(38070700005)(966005)(71200400001)(33656002)(508600001)(66574015)(54906003)(52536014)(316002)(53546011)(122000001)(186003)(26005)(5660300002)(4326008)(7696005)(55016002)(6506007)(66476007)(64756008)(83380400001)(66556008)(76116006)(8676002)(66446008)(38100700002)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?0SKVLERFFzr2P/5Rk/8Zr9wdwb8jFHgapsK1lKDsqXEMmrzkvF7eXkR9yA?=
 =?iso-8859-2?Q?vIa4tVUCSGkg2hvJWD32FBVMwFhcKyyNMwretVyr2FW/Q5dkyajNhEGMQf?=
 =?iso-8859-2?Q?d2tqM42WXP9wB2lHpLH4/cWIfFItaxzC0+NU1wi5ldFhYOWrMAU4grKNlk?=
 =?iso-8859-2?Q?X8iRw4tjepNtQ0KXRS8ouwIdS8QmW34IFoaNjgEjY+bSCLdWpVRXt1TEyH?=
 =?iso-8859-2?Q?ikwZMZ3FKb6idLjzF1Qq+5hAd2H4VVlsoq5ibFZhtb/kG4X/wkvfFZjBcQ?=
 =?iso-8859-2?Q?rOOGo62FPJ7S6CJ6pq6385CcMxv3aM9CWkSgA3yIChFW3T8ff62KI0fmgP?=
 =?iso-8859-2?Q?+D/iupefYTiq5OgHFYm5yYzjLu2TciySTa3ONLZ4fqy+mrSu6mBsTU6xrW?=
 =?iso-8859-2?Q?urfn6O7Bw0rgsUzrWo+S7ZGDh6KPKozV85aHDK5hSgHTd7W96dbWDzNcle?=
 =?iso-8859-2?Q?UU1gRQEJPgpgM2mITJQQmEGIlgbX3g/xmON/WMIpsixj97B2hEScXBMfkW?=
 =?iso-8859-2?Q?87VzPRvPROTZBMtq9cumTFE4CCY6ZI7VnRiEoq0FkrhfWtSKvcGmE6eXfe?=
 =?iso-8859-2?Q?0ln6jrbWzolmqn6FnPcINOHn24jfQ0QGkhiDgfkbuZufmR2Io4k6LEDGo7?=
 =?iso-8859-2?Q?ObYMtqOX1lmcQn3bei07G7BAsPyuuSv3+UN/d6vFymYTE/f5O1zSx8wALd?=
 =?iso-8859-2?Q?y51gQmFbAe6NEV0nWss0OTnfZLb7PnGr8LNU1dTjqMs5uxLEzEUHNQDVb2?=
 =?iso-8859-2?Q?dzj7vN6ebTd0EfYic4vPiL7pZC+y3ubuiXTWHVHEkPRD6QI3qgW00/slGv?=
 =?iso-8859-2?Q?JfCTVsSEpYkgzBGYE48LP3u2lDXu5r1N1R8TFX6vSuwGpiDMT8IZ6M8fJv?=
 =?iso-8859-2?Q?G42dPbYzLq6MNDqNFsCvMZwLZb+n1BjIGt/hxQCVFXquPiSuBZ23YHgECe?=
 =?iso-8859-2?Q?kqXFgn97KFZlKmzs5agmzgm0xg1bwhSEHhBv9ON5bG4Kn6P1aCofrXLCVI?=
 =?iso-8859-2?Q?JQYbr49zyfk9Z13PmFOoXr+zVhesw4DGpci5NBx+C5L3Intaj6ca1X5ZwV?=
 =?iso-8859-2?Q?5zre3DxVkqzWox2iFeBWA2b3Ex1hDSS80Q62Ih3fuTYOMXD4LDn6G6F2Wn?=
 =?iso-8859-2?Q?xT79t0myjgtf2P1+lmW1zIhpBuokMBf4aF/U/dILNIDsT2GPzCxMyRFYTU?=
 =?iso-8859-2?Q?slq0Z4/Gvvd6wJjqOXYOiujrbtaqseSnVuICIaq1UXFtCsPii7PIoA8loo?=
 =?iso-8859-2?Q?blN1rjmxzkanzHBOhsgRMY0uZC/OYqt3vA3qmA6pQv3ZC0zjc0h3E9Jl2X?=
 =?iso-8859-2?Q?RWt6VHQ2HYvrKtJ2SvUYO0raH4bS2qOKtExOneFIdsOQxF3xwwNhenRKCz?=
 =?iso-8859-2?Q?SPCxVJFI8DUUQYT74m6mgQ5sEdgxBkXfXhYkr4y8w9H6LoM/7jkEKtDuYg?=
 =?iso-8859-2?Q?lw+Baqdjfhjl79uJodqc3u6yaOs2Xh5VPhcBH/FdDt5KnTC+UsrNeF/uRh?=
 =?iso-8859-2?Q?CRA4cnkPhVfs2UQqcj70pjNhUDv4fcdHoEQgF/v7VdTl9LMwnLn0NHKx3S?=
 =?iso-8859-2?Q?EFfkKqqbKbCXngRySyZVu4VRwif8IvgI+MowI1lfUlr+y/87VIRuyfVvcE?=
 =?iso-8859-2?Q?pSUU4wdijB64a9rmG13dwB/fi5jV7yFZ55eiXIM1FYKlYAxs9kZtZnlSzI?=
 =?iso-8859-2?Q?vYEIYFSzWGNGmKgZ7nX4exMGjWg/gKr4r0tGnynhHRN9DRzjTh8rXKuRkT?=
 =?iso-8859-2?Q?3qCg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54c5d8-b7e3-424f-c9a3-08d9a42e03d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 09:39:38.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNDo2GlnwOPxRSEM/Dk6MAi6xtnUwfwKG8owXKyKiZEMpR4jsUnXDXId8TXzc/gPMB0mLTffjkO6W/FYdH3+IMN8sS9af54c4s8/KuO4nmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2550
X-Proofpoint-ORIG-GUID: AbMfExOVfJt-MYRy84opTgIMHKD9kQEH
X-Proofpoint-GUID: AbMfExOVfJt-MYRy84opTgIMHKD9kQEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=917 phishscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, November 10, 2021 3:07 AM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: jic23@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
>=20
> [External]
>=20
> On Tue, 09 Nov 2021 14:31:26 +0200, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADMV8818 Filter.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml:
> properties:adi,bw-hz: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!tVywX0fQFR2vYZq-
> YTIJiJ0AXF2WapK4hXuLoFCYYlg19vxsZrLtIe7gWW7NfqCnlwuk$
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml:
> ignoring, error in schema: properties: adi,bw-hz
> warning: no schema found in file:
> ./Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> Documentation/devicetree/bindings/iio/filter/adi,admv8818.example.dt.ya
> ml:0:0: /example-0/spi/admv8818@0: failed to match any schema with
> compatible: ['adi,admv8818']
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1552959_
> _;!!A3Ni8CS0y2Y!tVywX0fQFR2vYZq-
> YTIJiJ0AXF2WapK4hXuLoFCYYlg19vxsZrLtIe7gWW7NfqkOdOfT$
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Thanks!
I will resubmit this patch in v2 after the driver is reviewed.

Regards,
Antoniu
=20


