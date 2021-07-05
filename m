Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C968F3BBB1C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGEKVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 06:21:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:60906 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEKVc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 06:21:32 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165AEPFo002720;
        Mon, 5 Jul 2021 06:18:53 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 39jmh8w06v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 06:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMR+QjXRadvsw8gYnzgYp0l0f+sUycb0WDCJMSAABjLAMb+AjxnbqJ78OTVJ2QkH/+c2gl35xLdECnsnrYnmsaCgFP02dxAogYyshW1mB101JbzR8wj9LqHRXndrA5tB4saCwop262w3Cf8f4zGfiEu0b+3dV0EHzSLFSv6D7ymHWmSF5AL2ZwZBc43NUeMWnjZWqNNpsLpq8H95TMfaVMJ2xWrxiLsMIGxU/e5qc5yJgJSdjcWCTrC/aPXcAcXQZnadMBZ49dabiLvuAj44iEJtDv5czrt3/063eunAXoL5OD5H+za+QV5bt4rqhVpFpMcKiRfQ3jhmtAeEkiSgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+52l7k1mlXy7bj+5mziIkUKiLW4iSdO7rjr0SEt+1g=;
 b=ath/MsvwcFKv4n3VYUjHWhiLjUrsqAVz6FgozUP8aZXhgJEs40+9Rmxt4bdnDyoVbr42sS+ZWMLpZaZ6oHaFKfJ4If4g8YQBeSj76WEJkqILD9mcLw86JIsG47aaO1R3q6xcbUWwJqh8xatPpsZ+WXrBg5Q3dmI1zWO2liBtLwp93ycVx7SALGH69ezKVLnCAIay1RyebBFssRreUyCKOaNSQzliN92r9mEQ91e/1Q8Dtawkg//rafforYnf/UVjNE3lOKLBSnMCp4H1B4dYlU60L88aRYAR3oPdpQ3xl7hhi4NueHIxIx9gyZxOSYR8thwndk9GSG430l8MyZxQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+52l7k1mlXy7bj+5mziIkUKiLW4iSdO7rjr0SEt+1g=;
 b=4/F2jZz+Bc7MffoIWwfi0R6C0ewWsEd8tYIjHgZqYpBQ39xtU/nES7t0puPf41D/vGzlKE+YtSZpHma5G1KkG5J6QuIICDwYySm19tDwtEMCJh7bN0EwCvl9zKyVMtjiQOOgBlvdZsopKua2VVEkMmJdZ/bzE3y4Wxi0/xOSBfk=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6297.namprd03.prod.outlook.com (2603:10b6:510:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 10:18:52 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Mon, 5 Jul 2021
 10:18:52 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXbzN7IY9R84leFkqsPFMOIAAoUasxeo0AgAKyeUA=
Date:   Mon, 5 Jul 2021 10:18:51 +0000
Message-ID: <PH0PR03MB63667CCA2691D4A43F28041E991C9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
 <20210703175716.7864358a@jic23-huawei>
In-Reply-To: <20210703175716.7864358a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjJlZjkxNjEtZGQ3YS0xMWViLThiNmQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDYyZWY5MTYyLWRkN2EtMTFlYi04YjZkLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTA5OTEiIHQ9IjEzMjY5OTUzOT?=
 =?iso-8859-1?Q?I5MTkxODQzNCIgaD0iMmxYT3V6VmFvM3VvY3l6MUlsWVFIaU5mVTVVPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFCaVVGb2xoM0hYQVhtL0pldHdIbUJsZWI4bDYzQWVZR1VGQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQVdBd0FBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUVBQVFBQkFBQUFCT1lHY2dBQUFBQUFBQUFBQUFBQUFK?=
 =?iso-8859-1?Q?NEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYW?=
 =?iso-8859-1?Q?dCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBB?=
 =?iso-8859-1?Q?R2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRU?=
 =?iso-8859-1?Q?FaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?iso-8859-1?Q?MEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FY?=
 =?iso-8859-1?Q?d0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3dCZk?=
 =?iso-8859-1?Q?FIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmhBSElBYVFCaEFGOEFaQU?=
 =?iso-8859-1?Q?JwQUdNQWRBQnBBRzhBYmdCaEFISUFlUUJmQUhRQWFRQmxBSElBTVFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQWNnQnBBR0VBWHdCa0FHa0FZd0Iw?=
 =?iso-8859-1?Q?QUdrQWJ3QnVBR0VBY2dCNUFGOEFkQUJwQUdVQWNnQXlBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:244d:c801:d491:832c:9161:fce1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b130e441-a345-4a17-4441-08d93f9e49ab
x-ms-traffictypediagnostic: PH0PR03MB6297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB629707A5FD665C9CB93DA1EB991C9@PH0PR03MB6297.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7VMohADnfXYMDckZ/xfmVwcDM91wtx0UalhS1/nQJY1GvkIivmaGb/tDLMRN1g7zbi9wz8XevxM7+Y/0x2E0UaAx755s/KTZCjf9eRmpQcuw3kqJBsJIraJh5Tv00MCgOcfdKd8VcasgDAbaFHkq2YYtPJfigTdjPa9usSM6rW2nEwVnkbBL4dqQVrNDC+Kz7zjPvh1gOoLluLQM0yMRTCqYUwVSfs1Dc+9l4p+xt0Q+qxbHzRmrZxE2PoYP/KXlipfl9cv4V+2YP3+UrmGR0t14jBow5rGd/6vHdyo5py86qkTeIbqmkeSpzA2/oseHhGDjd2wGJfxgC2guaxtiaj8Bf2JfGowdnkmEsO6nCvv7aijZSJvkioEm21FUFvsOtsegkBQeAaB0KGWKibNJP3i15kwA45HYOrcqvejv4a+NLbTcvYFyV0MVBwPf15Mjnwa/3qAQrhQtS/ih7zW45C9z6koIbO+aiX6zZggeWgbzHfxMX722QUWTbVD4Sh2cKlwO9loMDFUqgwBMMFCnJryzNg+XEpP1X5VhUmFPWvP9mTrryQcB05Mo3nvNs4t6VnQymdao7azpXs6NQcthsMmop1werZ8Xp/ZIVjfT813v3siKEDAVjdU0EkjsB1bm9Fe+EePFJLMO9bXzw6nvWOalXPDMrx5llk1lGHRvE4ImV/l/ucKBa/2Q65lMtT2ND96yuw3KWy24aYKskLvo9JjTmw9l6NOc2uALMrCoBRo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(6636002)(2906002)(316002)(966005)(54906003)(64756008)(66476007)(66946007)(8676002)(53546011)(6506007)(52536014)(186003)(55016002)(66446008)(9686003)(110136005)(66556008)(7696005)(5660300002)(71200400001)(478600001)(8936002)(4326008)(122000001)(38100700002)(83380400001)(76116006)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TavNmH/HWHaHy+wPhfuKYhI5J3fFNz7vPv7I8APBi7V45MaZkY2hS2A69G?=
 =?iso-8859-1?Q?p07dWVFg353YhxBzkl3ytOFmA7TrSBh0a+m2OqYvGyC78pbRC3opMZUVCQ?=
 =?iso-8859-1?Q?1CYFyeUBqnU6j8i5t9ZZopIFRBlKf2Kq35Fg56rXO1X4cEKGuV0RFEwfpx?=
 =?iso-8859-1?Q?0LRQdt/0LuXGfbDOMf14d2ucEihJmSb2qqiu2xuG0OWd8YPFbe52xpg6M/?=
 =?iso-8859-1?Q?y/y6T1ut+sxREgcbkpFwul+LCjvr85XjXa7rLI65O+z+tVsWKdD1pw+INY?=
 =?iso-8859-1?Q?Ni8Ku655MOubVbC60n5kb9teh0FmxV0RFNL4me8xZCx2bs4MCPBQKXD332?=
 =?iso-8859-1?Q?J65HJjSjc6YDalkyALDD4SZruP52LmphnTX/MwmhUBp3poBjmKeOyFb5/m?=
 =?iso-8859-1?Q?9vBEgyDVLVzZGYRailPCQoW9+lho9YxFhBnqEjNgAQNsYqxIPyyQJOBHxs?=
 =?iso-8859-1?Q?bMjX1REeMrA7E4n+tepW/aUG+aLop7VKQWPDc7x1EtviPCO4XPHwQs1V5H?=
 =?iso-8859-1?Q?MvOAaFSGzMz7BXVskHGKJbmmjYi4qgzJi3A/4hcQuo2Tmr7yofsnzEh0Qg?=
 =?iso-8859-1?Q?pTfKH3EskBS0GOeURYzF2fjUaRS/gSzJ2kq2UmdLhfmGMhxt/CvnPI50+X?=
 =?iso-8859-1?Q?5c8nflOJU8ekFQe02wyHTfZGAyRgjvSinJto+LkN1AoixwNorXrnGnFgTx?=
 =?iso-8859-1?Q?rBVRxuQjt3jamPyTcjTMtsd8PaD+b8N0x96Qgaob9BjCNTBMEyaBFl6Clz?=
 =?iso-8859-1?Q?1UJmakQ+5c8PEWaBYhIAlP+M+N46NTbq/lXvlQxgxyJL1tZWRoZ+dcme9l?=
 =?iso-8859-1?Q?+W1XdBJeoIbxSt6Sqdw1cxNIFCbZ6JhCRUemvJT4nSL9pHCFh+h75XtSyB?=
 =?iso-8859-1?Q?GSv6+WFSUdYxOTmFYzcFMrVdsD0iKVT2ZpUsRXFvsJGZCYWUsET9FSr4Of?=
 =?iso-8859-1?Q?CTL98z5EmVfEQzCxJqDIC2E1naf5pOZW0ahytzBEUUG6oNBvtrC/J5Tg7l?=
 =?iso-8859-1?Q?XpsmJCzqJte+hBBOYz+ttu0P6C4wKAKjqi3JebD2guZ9d6JqO1VQrX0tAL?=
 =?iso-8859-1?Q?lGuP9OzlXnqIwMwHsQLarCKXhiQex1rcWX2DaqELrugvh/u2oC/h7bGBwt?=
 =?iso-8859-1?Q?pcC+8IeIpTLdi/+YxR6+2hEDtse4y4GANIYc973PPXUlPvfsIPG1vbjffk?=
 =?iso-8859-1?Q?Co7XvJCfkDXuSIjvnlBcHYWcKTe4QbT0SEeiWFW1Am/400fFUPR4WaeG1x?=
 =?iso-8859-1?Q?lU7ZOblGDcF9mf6SkY8TJ7CH6C5bf02jTSOOrP959i0wSymHM8HuS9Mr8O?=
 =?iso-8859-1?Q?+VTnW1q1/6MSQ+BCQXUCx3gyzT9mXBnOrXwVsExiIhmetwF3IDJWSx8WSn?=
 =?iso-8859-1?Q?XknozeDh3c6kD8qwWiOh4p3pNB7yUZE7E0dNh/US2M82ota7cgwgxYBExT?=
 =?iso-8859-1?Q?LtGPPqcSciyKLT73?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b130e441-a345-4a17-4441-08d93f9e49ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 10:18:52.1177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uvs+w3OBhjthAnAgXyYzdA72/qOjDpPd2UTeBbLMx4GPzfX+4oETCOMEtEunyy3H/q7gsmJ2s1Z7iAOP1kphrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6297
X-Proofpoint-ORIG-GUID: ukXMDt9aPmuyL5OT3stPlALYHqS1tLPi
X-Proofpoint-GUID: ukXMDt9aPmuyL5OT3stPlALYHqS1tLPi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_05:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107050055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 3, 2021 6:57 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> On Fri, 2 Jul 2021 14:12:38 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > microwave upconverter optimized for point to point microwave
> > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > range.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADRF6780.pdf
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Hi Antoniu,
>=20
> Frequency drivers are fairly unusual so if you could add a listing of
> the attributes in sysfs that would be great (it's nice practice anyway bu=
t
> I don't insist on it!)
>=20
> Various fairly minor comments inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> >  changes in v4:
> >   - change license to: GPL-2.0-only
> >  drivers/iio/frequency/Kconfig    |  13 +
> >  drivers/iio/frequency/Makefile   |   1 +
> >  drivers/iio/frequency/adrf6780.c | 498
> +++++++++++++++++++++++++++++++
> >  3 files changed, 512 insertions(+)
> >  create mode 100644 drivers/iio/frequency/adrf6780.c
> >
> > diff --git a/drivers/iio/frequency/Kconfig
> b/drivers/iio/frequency/Kconfig
> > index 240b81502512..fc9751c48f59 100644
> > --- a/drivers/iio/frequency/Kconfig
> > +++ b/drivers/iio/frequency/Kconfig
> > @@ -49,5 +49,18 @@ config ADF4371
> >
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called adf4371.
> > +
> > +config ADRF6780
> > +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> > +        depends on SPI
> > +        depends on COMMON_CLK
> > +        depends on OF
>=20
> Why?  Pretty much everything seems to have defaults if not provided
> via OF.
> I've asked for the generic firmware functions anyway, so you can drop
> this
> for that reason if nothing else!
>=20
> > +        help
> > +          Say yes here to build support for Analog Devices ADRF6780
> > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > +
> > +          To compile this driver as a module, choose M here: the
> > +          module will be called adrf6780.
> > +
> >  endmenu
> >  endmenu
> > diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> > index 518b1e50caef..ae3136c79202 100644
> > --- a/drivers/iio/frequency/Makefile
> > +++ b/drivers/iio/frequency/Makefile
> > @@ -7,3 +7,4 @@
> >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > diff --git a/drivers/iio/frequency/adrf6780.c
> b/drivers/iio/frequency/adrf6780.c
> > new file mode 100644
> > index 000000000000..472a66f90c7f
> > --- /dev/null
> > +++ b/drivers/iio/frequency/adrf6780.c
> > @@ -0,0 +1,498 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADRF6780 driver
> > + *
> > + * Copyright 2021 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
>=20
> #include <linux/mod_devicetable.h>
>=20
> > +#include <linux/spi/spi.h>
> > +
> > +/* ADRF6780 Register Map */
> > +#define ADRF6780_REG_CONTROL			0x00
> > +#define ADRF6780_REG_ALARM_READBACK		0x01
> > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > +#define ADRF6780_REG_ENABLE			0x03
> > +#define ADRF6780_REG_LINEARIZE			0x04
> > +#define ADRF6780_REG_LO_PATH			0x05
> > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > +#define ADRF6780_REG_ADC_OUTPUT			0x0C
> > +
> > +/* ADRF6780_REG_CONTROL Map */
> > +#define ADRF6780_PARITY_EN_MSK			BIT(15)
> > +#define ADRF6780_PARITY_EN(x)
> 	FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)
> > +#define ADRF6780_SOFT_RESET_MSK			BIT(14)
> > +#define ADRF6780_SOFT_RESET(x)
> 	FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)
> > +#define ADRF6780_CHIP_ID_MSK			GENMASK(11, 4)
> > +#define ADRF6780_CHIP_ID			0xA
> > +#define ADRF6780_CHIP_REVISION_MSK		GENMASK(3, 0)
> > +#define ADRF6780_CHIP_REVISION(x)
> 	FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)
> > +
> > +/* ADRF6780_REG_ALARM_READBACK Map */
> > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > +#define ADRF6780_PARITY_ERROR(x)
> 	FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)
> > +#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
> > +#define ADRF6780_TOO_FEW_ERRORS(x)
> 	FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)
> > +#define ADRF6780_TOO_MANY_ERRORS_MSK		BIT(13)
> > +#define ADRF6780_TOO_MANY_ERRORS(x)
> 	FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)
> > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)
> 	FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)
> > +
> > +/* ADRF6780_REG_ENABLE Map */
> > +#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
> > +#define ADRF6780_VGA_BUFFER_EN(x)
> 	FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)
> > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > +#define ADRF6780_DETECTOR_EN(x)
> 	FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)
> > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > +#define ADRF6780_LO_BUFFER_EN(x)
> 	FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)
> > +#define ADRF6780_IF_MODE_EN_MSK			BIT(5)
> > +#define ADRF6780_IF_MODE_EN(x)
> 	FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)
> > +#define ADRF6780_IQ_MODE_EN_MSK			BIT(4)
> > +#define ADRF6780_IQ_MODE_EN(x)
> 	FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)
> > +#define ADRF6780_LO_X2_EN_MSK			BIT(3)
> > +#define ADRF6780_LO_X2_EN(x)
> 	FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)
> > +#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
> > +#define ADRF6780_LO_PPF_EN(x)
> 	FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)
> > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > +#define ADRF6780_LO_EN(x)
> 	FIELD_PREP(ADRF6780_LO_EN_MSK, x)
> > +#define ADRF6780_UC_BIAS_EN_MSK			BIT(0)
> > +#define ADRF6780_UC_BIAS_EN(x)
> 	FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)
> > +
> > +/* ADRF6780_REG_LINEARIZE Map */
> > +#define ADRF6780_RDAC_LINEARIZE_MSK		GENMASK(7, 0)
> > +#define ADRF6780_RDAC_LINEARIZE(x)
> 	FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)
> > +
> > +/* ADRF6780_REG_LO_PATH Map */
> > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > +#define ADRF6780_LO_SIDEBAND(x)
> 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)
> > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK
> 	GENMASK(7, 4)
> > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)
> 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)
> > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK
> 	GENMASK(3, 0)
> > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)
> 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)
> > +
> > +/* ADRF6780_REG_ADC_CONTROL Map */
> > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK		BIT(3)
> > +#define ADRF6780_VDET_OUTPUT_SELECT(x)
> 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)
> > +#define ADRF6780_ADC_START_MSK			BIT(2)
> > +#define ADRF6780_ADC_START(x)
> 	FIELD_PREP(ADRF6780_ADC_START_MSK, x)
> > +#define ADRF6780_ADC_EN_MSK			BIT(1)
> > +#define ADRF6780_ADC_EN(x)
> 	FIELD_PREP(ADRF6780_ADC_EN_MSK, x)
> > +#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
> > +#define ADRF6780_ADC_CLOCK_EN(x)
> 	FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)
> > +
> > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > +#define ADRF6780_ADC_STATUS_MSK			BIT(8)
> > +#define ADRF6780_ADC_STATUS(x)
> 	FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)
> > +#define ADRF6780_ADC_VALUE_MSK
> 	GENMASK(7, 0)
> > +#define ADRF6780_ADC_VALUE(x)
> 	FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
>=20
> Not used.  In general, just use FIELD_PREP / FIELD_GET inline rather
> than having extra
> macros like these. That approach is simpler for reviewers to follow.
>=20
> > +
> > +struct adrf6780_dev {
> > +	struct spi_device	*spi;
> > +	struct clk		*clkin;
> > +	/* Protect against concurrent accesses to the device */
> > +	struct mutex		lock;
> > +	bool			vga_buff_en;
> > +	bool			lo_buff_en;
> > +	bool			if_mode_en;
> > +	bool			iq_mode_en;
> > +	bool			lo_x2_en;
> > +	bool			lo_ppf_en;
> > +	bool			lo_en;
> > +	bool			uc_bias_en;
> > +	bool			lo_sideband;
> > +	bool			vdet_out_en;
> > +};
> > +
> > +static int adrf6780_spi_read(struct adrf6780_dev *dev, unsigned int
> reg,
> > +			      unsigned int *val)
> > +{
> > +	int ret;
> > +	unsigned int temp;
> > +	struct spi_transfer t =3D {0};
> > +	u8 data[3];
> > +
> > +	data[0] =3D 0x80 | (reg << 1);
> > +	data[1] =3D 0x0;
> > +	data[2] =3D 0x0;
> > +
> > +	t.rx_buf =3D &data[0];
> > +	t.tx_buf =3D &data[0];
> > +	t.len =3D 3;
> > +
> > +	ret =3D spi_sync_transfer(dev->spi, &t, 1);
>=20
> data needs to be dma safe.
>=20
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	temp =3D ((data[0] | 0x80 | (reg << 1)) << 16) |
> > +		(data[1] << 8) | data[2];
>=20
> Ouch. That's a bit nasty, but why are you writing the reg into
> it?  Looks like a get_unaligned_be24() >> 1 and a 16bit mask.
> (use GENMASK(15, 0) for that to make it apparent what is happening.
>=20
> > +
> > +	*val =3D (temp >> 1) & 0xFFFF;
> > +
> > +	return ret;
> > +}
> > +
> > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > +				      unsigned int reg,
> > +				      unsigned int val)
> > +{
> > +	u8 data[3];
> > +
> > +	val =3D (val << 1);
> > +
> > +	data[0] =3D (reg << 1) | (val >> 16);
> > +	data[1] =3D val >> 8;
> > +	data[2] =3D val;
>=20
> An opportunity for
> put_unaligned_be24() with a value of (I think)
>=20
> (val << 1) | (reg << 17)
>=20
>=20
> > +
> > +	return spi_write(dev->spi, &data[0], 3);
>=20
> Needs a dma safe buffer, which basically means it can't be on the
> stack.
> Lots of ways of handling that, but look for __cacheline_aligned in IIO
> drivers
> to see the one we probably use mostly commonly in IIO drivers.

Hi Jonathan,

This is something I wanted to ask for some time so I will take the opportun=
ity here :).
Is this something you prefer just not to risk at all and make it an hard re=
quirement
(which is fair)? ...

I'm asking this because, tbh, I would be very surprised if any spi/i2c cont=
roller out there
is using dma for a 3byte transfer. I guess the overhead of setting it up is=
 probably not
worth it...

For instance, in i2c [1], the "educated guess" is around 8byte (to start us=
ing dma safe buffers).

[1]: https://elixir.bootlin.com/linux/latest/source/Documentation/i2c/dma-c=
onsiderations.rst#L15

- Nuno S=E1

