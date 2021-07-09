Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B03C209B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGIISa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 04:18:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12830 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231278AbhGIIS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 04:18:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1698A3aS029453;
        Fri, 9 Jul 2021 04:15:32 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 39pd1csnwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 04:15:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWoYdGpCBHRUpZuHFXDlU0lMal2BuWM+6jD1KXgsiKnxYaSVkfxFdLnCL8/zD9Zny5AIg1hm/0q+t8tk+GRT7XNv89E9dhK20/W20b4uJX8b7nUN2ggeb7zuLz2kKUuooXgwVWRcnLJ+XDwjtc+pn3vF9ImaQI1WeceTJrSCxjhtipcPaXJVy6zGYPkiv0Mm/l8rmkCfKRh7akL211mZ9YelpGlptIHPJM4WZW6ef2fTZ6zaFBMCI9zmsozrkMiEu1mWs8ZqC05dGw3Zhpe4hAVJr9PNhHCa0w1hSXipWoT0oVwYzJQYhkgXeOBm17LCuhPRbFrRBHDLPriIfCiS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHIMPc6cx1YU+kFeEBeS6ezAwF/nzLxss9N+r4WHuOU=;
 b=bYMphRrcqOa90icvXHpWHE51GsMSJG8q3lKnd9rbRXMEoHvbgXhrvsY85zC/uKG1i2I0uO2u/ekLxpW+glxZ7d1dlJR4QUz7YV1+cFY+jGV5qykZ5FcxwKMgSYH3CGVEdA/HJmLKAukBPpckyTl2p/ZXqgi77LPHxJ7+jRG6w52/loT3pzayUomFOtWGHtbMRPLSfrL9IeHCDS0dWR7552jwJiiCEEGrv/sXUCNZwHr5kk8InTUdYKKpCcvpbEJBmJwI4hDaD8VNnHVkYZePtGtIOFUOtT6m8JqRDHWyYH/Pm4y8UwkzMGiVtaVxcY/WCfRa5ZS7QyjZcX6cCdy2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHIMPc6cx1YU+kFeEBeS6ezAwF/nzLxss9N+r4WHuOU=;
 b=z2x7dcCfUbbktKrAG+iGjoG3n7cRymRUzwfT+KdMzvH9GUlzR6n54kvFPvGza+hhsvyFyHz2DJAcvuZV/1JlGE167libWeJ3ptR5m1EjRY4D/irjz9rD4QQQBkHRFGbrjtjjeSUz+XPQ2k7zmfOcRbzQ3zTKrN4VcTEcwaFek4Q=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5943.namprd03.prod.outlook.com (2603:10b6:510:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 08:15:30 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Fri, 9 Jul 2021
 08:15:30 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
Thread-Topic: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
Thread-Index: AQHXdFTvOSLYpfdoO0egPAoeDBe7A6s6S7CA
Date:   Fri, 9 Jul 2021 08:15:30 +0000
Message-ID: <PH0PR03MB6366E7E1CBDC15B6B43F8BC699189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-5-liambeguin@gmail.com>
In-Reply-To: <20210708235618.1541335-5-liambeguin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZDFjOWNkZmEtZTA4ZC0xMWViLThiNzEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGQxYzljZGZjLWUwOGQtMTFlYi04YjcxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjY4MyIgdD0iMTMyNzAyOTIxMj?=
 =?iso-8859-1?Q?g5NzgwOTY2IiBoPSJVMjB3RkZMVVBqZ2swT3hSa09HVGpOYlJDdnM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQURtVGlLVW1uVFhBYnk2ZXhZK3dFY012THA3Rmo3QVJ3d0ZBQUFB?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bac8b0e2-0d25-4790-09e5-08d942b1b78e
x-ms-traffictypediagnostic: PH0PR03MB5943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5943F99BB3AA9990ED6247AE99189@PH0PR03MB5943.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+93c+qIKwVoEQw0EYn2Hv8uyHO5ydx7wXiWMWqe8tXQQAtzZ5qnsw5kvqqjCgR3XtVIIFuvv1Iv9pDEfCYoqdBoXUtdPbsKG72RDg8hwO/2kpYGVEp0qocWnXzU1UZYpcrBQln6hNI5duYkwLtWONbEgBb3n2V7umwe10FY7PIMn5Y4DcjVpADJm2X0gu4VNqW7ADAMFtvNVuT91G2cJbIXVmlUJyfzVgKYZHproHa27lvWMkA7HJz2r/gYTHkoPQM5tV+j8g6c7SfUuf0ExYIHJUrnge02dXFEAB4pKzc6zreFNclQMV1LlHJWK6CCf+Wo1qR7y8vCO8Iruh4K/m7q5WOYi6kKmP7jCP8xqkJMsYr2U6AnYiWUSdhznBBayaOZuLe9GLLHnggTiVTL/U05eil7paF16+A/tCkY2ZuP2O7LKTpb/oRmaApAZacUvd9eiNNf68/mDJ2oD3xnMSPL5+SeDolSqXoKrDnA+v0U7JtYHqAEEQELvnALp/X6K7w08zsQWcVg3dJfQny+XOaQgNVUDMmMSgc91Ypk2z/MQsbpZL1wvJxAeqedODnaLiUHh2inaaPgS6MpwNAbAMVfQDlB4zj18Y5VRxS710pUtnHpvWXfjS3B/U6m2rXubb40HnthPKiuZyF0ODgnjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(110136005)(76116006)(54906003)(478600001)(66446008)(83380400001)(86362001)(66556008)(64756008)(186003)(4326008)(7696005)(66476007)(316002)(9686003)(66946007)(55016002)(5660300002)(8936002)(122000001)(52536014)(2906002)(8676002)(6506007)(33656002)(53546011)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8tiR8WLvv+tlX/BtgLQmpSmHHMnwZOceOy1cyY14gSBbwLYM5hI+2Q/mpf?=
 =?iso-8859-1?Q?HG5GWf00Kzivbd81q54wg0Pafhkf4rK8NQBhIhSTtbTcDl6vF9Yc/IFbLb?=
 =?iso-8859-1?Q?dwhNyy/u+NL7cImTUuIHM9nKIYPpYwPUg1J6OAHq6mwJqXRSfJqLfoGIGk?=
 =?iso-8859-1?Q?3PoiSzVppScicUZKtDGcjHkWSgsT1Tcz8q5E4cYFgmERgJDds63joPch0e?=
 =?iso-8859-1?Q?DWEHUbFEMBxk2LoFuD3dCQsQtO5kswxFEpfLVu0PSpwJRznB0x8sSop8uG?=
 =?iso-8859-1?Q?9y0HGaX9TBTeaVlIXQCXpmiDJiMP4wpfMjlntuzKs/OqB5rO1OFUdxGbjz?=
 =?iso-8859-1?Q?es3hG9R2gvU9yWThu89wtNTIZOe0jmHBJTW3+ArJp5NHHbcSyYCv9plD5j?=
 =?iso-8859-1?Q?YvX4u3yIBXFkLMh5pL7aiJe9zyZq5ww89MVF9grrUyQvFzFRphnkIRVRbx?=
 =?iso-8859-1?Q?3Lh+6RIGgYisXeU30oTCw6NnO2+pvSL81kfvYN/DtVtBxwva8ygySehGjI?=
 =?iso-8859-1?Q?snVXYsLKUKgc5Encl8Nq+hCGVElihu8W3mZlT3b0nv5dwTjD85qyNfDeWd?=
 =?iso-8859-1?Q?ZkClrM2q5u6B3FRap5uRUH9iN5zu1Sa8O5I+7n7Vxj42/N4CSELui2lScK?=
 =?iso-8859-1?Q?rz8iPu4+t+AfVKSAcyH2vWP13lEewmE00TcunAlGbvVMAML+aDRQhjBGcG?=
 =?iso-8859-1?Q?v+XVkMUZNNCShAhR2n8EUqnD6UcgXRUld/JWx1r2kUHdXYZFLjxMFnqphM?=
 =?iso-8859-1?Q?0lGr2iz2RjcpN8bDg55TZzG80UiRs95AdYZVcyIE1IxkWIS7VYZLQ/TJjB?=
 =?iso-8859-1?Q?f8SZfiYkqCd0C0frpFF+ZoEVL0F8HuLjJwoXZqki2GIzDHkAW3BHL/p2dH?=
 =?iso-8859-1?Q?emLGltj9VyeybTn6vl0ZmCmpcRDQTjIQEb1QYKwnZqJmBcsSXx20fKMQmf?=
 =?iso-8859-1?Q?OqUF62r8ukFR2erskg5Dtzt9AB5+SBsvbqa6q+jK5ajc5NRMrSyOyaJXi4?=
 =?iso-8859-1?Q?xl+nYbAL+pyxeqYJgCIsrNSf8MwRJn3CX2drlrq0OnVSTGk7sJBNN+JJ6n?=
 =?iso-8859-1?Q?3aLvf6FWC80IE5y0yE1mGzzVqOYVEFwYtevNIVToEVUKEJAU4hU0baUg/4?=
 =?iso-8859-1?Q?8NXr2XNz9ETMlU0DF65mnEND1vCV7mIOgVoD69cu6jTs2sRvJhZlibFALh?=
 =?iso-8859-1?Q?YznFZI9bGjaTa0VM4c1ugkoNwtQZL4cuuB/PCSNZ2+lgRoEhNESpV3kSR0?=
 =?iso-8859-1?Q?3I5C9hi1sKzODpuZddy46JKU2oNXoB2QvD+hQu5BKTTn984IDu/KG7lG+/?=
 =?iso-8859-1?Q?u4SS2rGhvzoshSK1/jDUSjLUuaX4Tu3xbFoyrnns4A5IcV9UcTdTTOPAX3?=
 =?iso-8859-1?Q?Za1NuTLkvg9F1AjIjupOZQPalwaC97nr8ucHxSE7Ln3RS01aEE4UgXdQfq?=
 =?iso-8859-1?Q?EJhE0u1XP2NSihVi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac8b0e2-0d25-4790-09e5-08d942b1b78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:15:30.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWACNG2S3AEKC+BZBer4c4AXIk7IsghDxjap20OIioGISwZTL9zMVLHc4vPJnDLCJnWR+VxRa82JlmsJfoYcSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5943
X-Proofpoint-GUID: yNTCOnadpCrhLAER8U_adBX7sb547v7t
X-Proofpoint-ORIG-GUID: yNTCOnadpCrhLAER8U_adBX7sb547v7t
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Liam Beguin <liambeguin@gmail.com>
> Sent: Friday, July 9, 2021 1:56 AM
> To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> antoine.couret@essensium.com
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: [PATCH v1 4/4] dt-bindings: iio: adc: ad7949: add
> adi,reference-source
>=20
> [External]
>=20
> From: Liam Beguin <lvb@xiphos.com>
>=20
> Add bindings documentation for the adi,reference-source property.
> This property is required to properly configure the ADC sample request
> based on which reference source should be used for the calculation.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/iio/adc/adi,ad7949.yaml          | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> index 9b56bd4d5510..3f4629281cc8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> @@ -35,6 +35,28 @@ properties:
>    "#io-channel-cells":
>      const: 1
>=20
> +  adi,reference-select:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 6, 7]
> +
> +    default: 7
> +    description: |
> +      Select the reference voltage source to use when converting
> samples.
> +      Acceptable values are:
> +      - 0: Internal reference and temperature sensor enabled.
> +           Vref=3D2.5V, buffered output
> +      - 1: Internal reference and temperature sensor enabled.
> +           Vref=3D4.096V, buffered output
> +      - 2: Use external reference, temperature sensor enabled.
> +           Internal buffer disabled
> +      - 3: Use external reference, internal buffer and temperature
> sensor
> +           enabled.
> +      - 6: Use external reference, internal buffer and temperature
> sensor
> +           disabled.
> +      - 7: Use external reference, internal buffer enabled.
> +           Internal reference and temperature sensor disabled.

I think typically the description comes first. I also don't think you
need the 'allOf'(not even sure if it will pass the binding check)...
Just have '$ref' and 'enum' on the same level.

- Nuno S=E1

>  required:
>    - compatible
>    - reg
> --
> 2.30.1.489.g328c10930387

