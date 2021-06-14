Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EC3A5E88
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 10:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhFNIuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 04:50:13 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49420 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNIuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 04:50:12 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E7uvFB007470;
        Mon, 14 Jun 2021 04:03:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 394ppcpd5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:03:22 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E83MTm017513;
        Mon, 14 Jun 2021 04:03:22 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-00128a01.pphosted.com with ESMTP id 394ppcpd5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOSPMCXEtox8Q75LFYVeGKyZR3hzOTEXEDyLJywI7Lt8VCrLOWpr6YNZyVcwOx7/N/ifi+A+7KJLOVFXRI1scvEwllVnw6nNTa6reJFErYJ5eGf7AbxN9OsTt6oYMhue2vm2oTyhWbsUvEqxseb0gVH3150KoqmrF4MqCCOnFP8uVyofZzrjQ7JolkqCW4x+PED9EW1tIuxRYoZWLfYiCYEgNKRJF4G7T/9gqNTrBzdYTOav+B3z4YxhNedLam38vKiW6EScJOC2hNIiHq9/F5vbWTeGcCVoMdn5tHpWhX44UNsnCwDef3NQMD/bj92eKHBOLOvHDoxoCvoaJ8NXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0GGeH0vXobHY/9osOvqWmTKMuCNviU+AufwJ7lYR+E=;
 b=krMf9jnnQW93ycs0wW6z4AADJTZ7YgZ6Lr4L1MZPeNqdk9a0MBg3GPMbeyMbkJPBAP956WF/Fxniq/9rBSCboA8li9ByoWTnZ9eWjlQOxZEhKLKccyu/DjwXuIqXJmp1G5TwWGcAWBkd878J7eKfhLwD5WPvcF61do5YOVFIlRx/X1fSfOcjLoEYzpW19NwGGoSNyhXbZaRell3YMvfkub0pjUWMd1LwA6MDr7mWSaZ35BR2PqVtjJQIvCJYepRUDL88gmU1dLOOG9tf5llKCqXO9CbeebmfaIuUZihJmvpqs6oiXRvRiQwqTKyBvEPmaa9k9DVk29ptTqCBEYJ15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0GGeH0vXobHY/9osOvqWmTKMuCNviU+AufwJ7lYR+E=;
 b=eVgFID63qkmyYvOr4NgLoUHiDZNIIA+UCVd8pa0qiutf+1jTpRkWv1GpB5uG6M/NjCuOMM8C8aPer5RFh4TZv8yjP33g8LONxrdAmLPXy5ZPn2ipsCAazTBBXDpGZQJ0P709z0kNu6CY4Sf9Mn14zwIg+DDEX/4I5BQKA+km4Ks=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5894.namprd03.prod.outlook.com (2603:10b6:510:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 08:03:20 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4173.022; Mon, 14 Jun 2021
 08:03:20 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.d>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: RE: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8)
 used to ensure alignment
Thread-Topic: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8)
 used to ensure alignment
Thread-Index: AQHXYGfAOZgOqEDyQ0mScHLJePBKv6sTJihA
Date:   Mon, 14 Jun 2021 08:03:20 +0000
Message-ID: <PH0PR03MB6366479D135F6D96D3FD4F1C99319@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210613152301.571002-1-jic23@kernel.org>
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZmE4OWY2ZmYtY2NlNi0xMWViLThiNWUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGZhODlmNzAxLWNjZTYtMTFlYi04YjVlLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNDEzMyIgdD0iMTMyNjgxMzEzOT?=
 =?iso-8859-1?Q?kyOTYxMjI5IiBoPSJFNWI2dHY4ZnZ0dlcwcTlyVDBid2dnQkNPckE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQURON09HODgyRFhBV3FEQ0NBRmdKUzBhb01JSUFXQWxMUUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:255b:f101:f55e:b075:2abb:d2f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2fe9a07-a490-4b32-0820-08d92f0ae042
x-ms-traffictypediagnostic: PH0PR03MB5894:
x-microsoft-antispam-prvs: <PH0PR03MB589484F5C1930F13413A152999319@PH0PR03MB5894.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJRj7EbN/KUetPl2TJhf2jBkQPssXTDABS8L1ArX1wA4yRZ0hfHCfEY/QeF0R0H0rkXcC+AutkaJLDangMtkkJ/oSRhYshqc5QNCKehV9BQ/1PHq1U9lGoE0dyYoaBdUCVNZeiEgFeTGH8BrFkb6K1L15zeXTThkJLOmuOGpcHc8XTXfEsqU+/+vcXLLFTpaMrQAbyKjXG8MeUywStdbQyckA1Fx0xKL9qi321G5K38V8eta6sRAEfkIv6JltNKcasPMSrFQtpuqkUU6dX419bAttxxvReZW1L1vqZK7fMDeYWp3AYxo/P5X0BqeBBV7neT9GSZ0Li5ATb6KEqOZfPCjA+zVb1DHUm9cC2BJNRymbELd8xItZm7FJvVGKGVZKcEEPSzt3icpKRr+/fFJHSo39Oc0njgT56DhgyPx/s/pDznj3XD4vjE69TsSCrrFtCjmQ1YFlxL8fvdyCzmEwO0nC9+z2FS+DAAmiY9LM/9yVf002q5KJpljVPgSJiwK+/I70N7x+jb6iLX5xz0BWzZE8W02hiNX36tJ/oau4no8Jz0SoBqkJxVtjesW6kWPusaNYJei6PTvjTtAl6XWR1m68Pp2oF11BOiBYiyipz8lzQGcUjb2QNTvLsi2sqHgB+pZPt4gLqg0xvBrfayxHzpFYARFXBsAazHu3mH2ZR8Prn6UndKWyulK/n2K8hsS2IDlb9CsFTq3liWU7wg8og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(83380400001)(9686003)(64756008)(33656002)(66476007)(66556008)(66446008)(122000001)(38100700002)(55016002)(76116006)(66946007)(8936002)(316002)(966005)(478600001)(2906002)(4326008)(86362001)(53546011)(6506007)(5660300002)(8676002)(71200400001)(52536014)(7696005)(186003)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YPy0YIvnMYj3QdEqtCscC6QpY3svyJf0f07HNVgRy/IoGmDYSjAbM2qmWJ?=
 =?iso-8859-1?Q?TYZagZhk7H5I43b43U11qRMJ+3nIF1ybakoEaLKsAa/bcKmRrS8H6IGdws?=
 =?iso-8859-1?Q?Bk3HY5Ls+pSP6/EwwvKjW6aMyk5xBacgq0iXK3cBAx5WKsqR/rSstpEEYW?=
 =?iso-8859-1?Q?1pNKphCrqMgZokE0GErtBojgFKifeGFgZy7in1DoCczX3tQ6hr4Z6dI+yn?=
 =?iso-8859-1?Q?qpjp6ilSZk33vsNGw+3pL5NBwO8nNUaYoxoY0or5gAftaH56wZfNYgKA0e?=
 =?iso-8859-1?Q?xGYKqGPld1KHQsxnfadp8RsFwLQlCFl+6sa5w+cdc5Hp900h2kKp6fx7jk?=
 =?iso-8859-1?Q?u3SRYr3KdY+85xMjoXwKA2q2F4dyIItZ4FyAceL/BRt+miXYlMGJ+7wNC9?=
 =?iso-8859-1?Q?Fl970j5CbiYbPoL3/I+f2iRZXjNFzb+YF4wEBAmAiEyQE095FdEetmdFOx?=
 =?iso-8859-1?Q?+vb81O9K6r7PdcBEf53kHycVelRYAdb+dSbP+3RZU6NwHSujLSC29tLbOU?=
 =?iso-8859-1?Q?qViveTkSFuml3fvEtmX2yJC6wtt3DXbKZrzT1tmFVElMPePgc7U7Mstwvu?=
 =?iso-8859-1?Q?DgwxvELnK26LEvZVXlDG7jWOiEIy/7d80jetL1xsxklGOK1XtlViuI4QTI?=
 =?iso-8859-1?Q?0VDX2Ee8NEiF+WbiWYeL95M3rHmuSgUDmGjCKt3qwD2xriLKIKbdj7eR83?=
 =?iso-8859-1?Q?RjBSRh08yhFt0SrB1blJfkamTH5HAwhrKPh7xx+1mz3r2/VLwUYTrax8Tq?=
 =?iso-8859-1?Q?QCKAF6aUKA7k272In4EXzWjTfD8lqUnELPZMexLiTAw3j9SNJp1u0SzK4h?=
 =?iso-8859-1?Q?K1wCK+qYc/QbQoy1UUTwU8cqDOdYtyLAbC1n4Ty9J//GrrylVMA3Yk4PJ6?=
 =?iso-8859-1?Q?8u/L7xE1Mb4S6Cj9JV9UZpAQHuJudpMOrSuUcl97itJGmuXXlPJXPRVFCj?=
 =?iso-8859-1?Q?YNlnFFfDSb1IJT3Ju2rLPVqtQCQGBytiNVpQqnqDDj9WFHIBJtunLZP7GF?=
 =?iso-8859-1?Q?8xYBr5wuz5rBZkRMfOMmK3zEVF2y5lz1gnxby0PUwV1Gzo86HK5J+W3bSS?=
 =?iso-8859-1?Q?ztj/72qDaHVvXaAAmnaKGlsEsY2NUqP04897F6mr1zoJzQf4ELXhjLuhDY?=
 =?iso-8859-1?Q?DCXDrkEQ+fcobW/1rTtTs+70ka91MRNEmFdoNxdMxbBCMFfvjvByslM4Pj?=
 =?iso-8859-1?Q?jnX8xGXb9h+fi0eioQjLlEPxbk5oGERjFQrS/MEL62RGEFLXv5hCVNykeO?=
 =?iso-8859-1?Q?+2/gaFfZd+q4EmWpNYM1yzN9GKc4fdP+vPSszgSZtnrg2t6ccSHgLEfu+U?=
 =?iso-8859-1?Q?igPzyXoSJHUxBwuIKrNYIsKARZM4EHn2btDLWOc8kVZ4OyDWSbQaDra+3s?=
 =?iso-8859-1?Q?M3cPAuiWMvwoZ//d7RRveQV3TbZokQrVNbR485VhxCGPSmX/6U694=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe9a07-a490-4b32-0820-08d92f0ae042
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 08:03:20.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSYbGX9kHn+JbtZ9P+2vP9LWJTwJul4FhEjSO+ejp8RAXi4QXj1Qh9xR6ELlJLMkHq9fypLVO3d8UYlC5S6xVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5894
X-Proofpoint-ORIG-GUID: l0oS082EClkqAfs5HTNmUxB8jdYNYY1Y
X-Proofpoint-GUID: YNZc3kgY21-uerSHn6xem6pCkcvOfKsm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 13, 2021 5:23 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Eugen
> Hristev <eugen.hristev@microchip.com>; Andreas Klinger <ak@it-
> klinger.d>; Song Qiang <songqiang1304521@gmail.com>; Mathieu
> Othacehe <m.othacehe@gmail.com>; Parthiban Nallathambi
> <pn@denx.de>
> Subject: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8)
> used to ensure alignment
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Resent as none of these have had any comments since being sent out
> over
> a month ago.  Note these are very straight forward, but I've messed up
> such things in the past so really appreciate it if someone takes the time
> to do a quick sanity check.
>=20
> I have picked up those patches that did get review in first posting and
> dropped them from this posting.
>=20
> Cover letter from first posting.
>=20
> I finally got around to do a manual audit of all the calls to
> iio_push_to_buffers_with_timestamp() which has the somewhat odd
> requirements
> of:
> 1. 8 byte alignment of the provided buffer.
> 2. space for an 8 byte naturally aligned timestamp to be inserted at the
>    end.
>=20
> Unfortunately there were rather a lot of these left, but time to bite
> the bullet
> and clean them up.
>=20
> As discussed previous in
> https://urldefense.com/v3/__https://lore.kernel.org/linux-
> iio/20200920112742.170751-1-
> jic23@kernel.org/__;!!A3Ni8CS0y2Y!uCn6NSpGUvHYdcFazn7flxxjh8RA
> RqPCumitrRDDgGAjXF7crgi911KY2v_iyw$
> it is not easy to fix the alignment issue without requiring a bounce
> buffer
> (see part 4 of the alignment fixes for a proposal for that where it is
> absolutely necessary).
>=20
> Part 3 contains the cases where the struct approach in part 2 did not
> seem
> appropriate.  Normally there are two possible reasons for this.
> 1.  Would have required an additional memset operation to avoid any
>     possibility of leaking kernel data.
> 2.  The location of the timestamp may depend on the channels
> enabled.
>     This normally happens when the max sizeof channels is greater than
>     8 bytes.
>=20
> Once all cases are fixes, I'll take a look at hardening against any
> accidental reintroductions. Note that on many platforms and usecases
> the
> bug in question will never occur.
>=20
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: Andreas Klinger <ak@it-klinger.d>
> Cc: Song Qiang <songqiang1304521@gmail.com>
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: Parthiban Nallathambi <pn@denx.de>
>=20
> Jonathan Cameron (8):
>   iio: adc: at91-sama5d2: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: hx711: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: mxs-lradc: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: ti-ads8688: Fix alignment of buffer in
>     iio_push_to_buffers_with_timestamp()
>   iio: magn: rm3100: Fix alignment of buffer in
>     iio_push_to_buffers_with_timestamp()
>   iio: light: vcnl4000: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: light: vcnl4035: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: prox: isl29501: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>=20
>  drivers/iio/adc/at91-sama5d2_adc.c     | 3 ++-
>  drivers/iio/adc/hx711.c                | 4 ++--
>  drivers/iio/adc/mxs-lradc-adc.c        | 3 ++-
>  drivers/iio/adc/ti-ads8688.c           | 3 ++-
>  drivers/iio/light/vcnl4000.c           | 2 +-
>  drivers/iio/light/vcnl4035.c           | 3 ++-
>  drivers/iio/magnetometer/rm3100-core.c | 3 ++-
>  drivers/iio/proximity/isl29501.c       | 2 +-
>  8 files changed, 14 insertions(+), 9 deletions(-)
>=20
> --
> 2.32.0

LGTM. For the whole series:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

- Nuno S=E1
