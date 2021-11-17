Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE34548DF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhKQOhD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 09:37:03 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:18401
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231565AbhKQOhD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Nov 2021 09:37:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVHpoSXJFS3Bvk+UoLMDCHRPnJMsOSRqjP9WKolCCIy7LuwO/4OeRfpWA7iBeq711oVVAdvM0Yzd8wYdVh6zU8Oe1CnW5TJ4mxsSzb7OvaSXvP5K2liUjkHe0ZfPpaJ1juCHuhQaZb8XU0ed/AZvyrqMezkot3TRs2w7i9Ie15Ng104y6WV7PBDnV+dWH3uFybq7Jl1adpKi3ZB7KrRywPMLd64sGmQnXgea8zc7RYfngbT6Ymy4uHc0gF83T166FJHnFP7cXnuS/La5UN9fYgXCWj2ptE6FYN3oRZB2ueKbOqTjZwYp/w1inKu7fcjI6cqyl3DbtvwvtEUHg0e6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q84bP84JFYERlbOU0RQCYKSz5rXl7bK52hpjeJOiblc=;
 b=id8JTPTXtGPoEyPMhjK5EMgMBOfxmPXN1AwuPA8REryvUwgVhPURjpbwA5ZZPgQmpXOVlJCFKBO3YOT1/7KpSLvLxwOW8xjvASW0dcyLzB43cShP9nO5zdleNMTy0SSl3ay9cLLOGXJ4BAsHIML5Zopsrd95bNK4m++1mCdpJ26DMxTZKtt8/ja+Dk2OFojDvEkWDlzRDFVDLuttdSpWcyLpnmnxj4rPvT3Oo5kl+56P7ordliTTgTlVLbMcSsEp9gn1akrVMeWmjwBBJ8iRvMhBo8RbAxaUc8n3KHT0hB/gnz5G3Ev+WqhNMkRBOKJ68xiitlIBsQIf7qvV+NO3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q84bP84JFYERlbOU0RQCYKSz5rXl7bK52hpjeJOiblc=;
 b=U+sf0phDKFZkfbk/sRQDQax4Y1P2i+ZdLxZL0DNNQUiY4lizHGeFVTyO3LfGHkpU7xPCP0WDzUCpjGcIcKpElaRY0jqRqGOnuxDtNaoDFZUL+GYGbooeKQQJKNsjf3w+DNPI8EAvlI8etYsra3nSsfDjn+SA+P/ArQoudgueoys=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB4295.namprd02.prod.outlook.com (2603:10b6:a03:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 14:34:02 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%8]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 14:34:02 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Thread-Topic: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
Thread-Index: AQHX2vvgYEKxlWeTO0uTBMdVPBYaeqwGbHyAgAFdvfA=
Date:   Wed, 17 Nov 2021 14:34:01 +0000
Message-ID: <BY5PR02MB69168A6537474DF8948C3D0BA99A9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-6-anand.ashok.dumbre@xilinx.com>
 <YZPtW5igA8RBYLWv@smile.fi.intel.com>
In-Reply-To: <YZPtW5igA8RBYLWv@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72310c20-6cd1-4594-9fcc-08d9a9d74cd6
x-ms-traffictypediagnostic: BYAPR02MB4295:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB4295C0BC2A0D43DD2C79E07FA99A9@BYAPR02MB4295.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXdZWQBuHWcr1MHNjjX4seHgvlguZUcUOMKDVPdYYVdqgSaOb1ZPsgEImOm5Tdc+mrBm8hzDMMGrvj/BMLJl64QX1kNkVcq52zSFlife10K9kLVRI7CRfLssPXAdtcFi2PoZOvPOGAvoK1lvCxyH/TK+ysyldWdXWHIWf/ABsa8BJ91kF+QT3xkCb1pBx0K5MCB63Z92imaHuTUk9zi+kdI9+43OGkzMt7T5uh8hHAQqBu3x5eX1qV7b5WxNeHT9DsslGjjmC6vu60d8fSt/0K7VEFOXSCYZ/i9Dj7iu4EpFn8caeaBAVUM6i9dJwVNF0WZO7BenYDTKAbD6QpKdpKzIPmwCvHup3Kn3DpxnmnlK8VoiX9HCZy3UlTYhCA9NjzEq6x/ykPbyNqLpC3UMV1UqwLADSK/LcvQ1p0u6yX1M75r6XqRvNkpQeLNqpiV6bCL2z5Zx05kF9U0w1Atqo0tH8jGaC6yL3q9NT6fWfJKFa4+bAA5TDIBKcFsfWOBk7qAheM97pHkHoKnZaP7wzx6YhUU5AL4x3AFkXHgDmuss84Zs6oW6PAP/SCloi/0mruxVRXrWEPJ+S5wioT4m8i2ascteah92zivRc6wazJn6GMEETqdwlMeikCOMpC4uMtepcNxyQ1I6y04PeVmhS18lYt1p8wkHu+oscvcxW7UqsqJi8+LGYfDVCuETbPQBhiF7ddcM+ukNvDHiB/jUzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(8936002)(38100700002)(508600001)(71200400001)(2906002)(33656002)(83380400001)(38070700005)(6916009)(54906003)(52536014)(316002)(5660300002)(66946007)(55016002)(53546011)(9686003)(66556008)(64756008)(6506007)(7696005)(66446008)(26005)(86362001)(66476007)(122000001)(7416002)(186003)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R7rI0hacd7gulyLAtqJ0Op1t4+rbrVpRlTThxCTY2hfXp4n1/5hC5RBoUWbm?=
 =?us-ascii?Q?lX7ynhoSqBUaUM33ZDLbnKbmXRbFCL1KE7ywDvLkNHTlDPrYulDOFjS4tePv?=
 =?us-ascii?Q?qdVybjzFdm1fnXyqtRBx1XxneGxm8N3dD0bNUWI7PDuJWVX5d9/N/DhZr+An?=
 =?us-ascii?Q?27xhuKMrmvHGejQJlnplyJoZCnBq9vV4FCYcxyD5swuxNEBlqexFLfSK7LQp?=
 =?us-ascii?Q?QSop5lp6zUHW73/co+2P5TTPZHV8nXGHfF+yTdLWNwzWRPIEQkhJpa+cTee9?=
 =?us-ascii?Q?ERcwVXb00nx3S55K6qYgtccVJoB6OIQqWlerlLbdmgvSoyUbTmRSOhIEUIqW?=
 =?us-ascii?Q?5q58VzGJwtyWK/aKOpz5KCRJ/jUZZy3jDGBTkZwdg53HMEV8gdsWp3JRqd9s?=
 =?us-ascii?Q?rVt6z4ljZVe1D28LQpYgeHB7QTpvE8+LyrqfR2KnaC9URhahgaJ6TwALZeyh?=
 =?us-ascii?Q?bwShjJGoZLuDYo0gKSVi2GCDNFw17HW2VQyfFGQVINHTC6x/ksrYLYDszs18?=
 =?us-ascii?Q?XoAOR9XIY8xd7HIhXExYH3iLYgDcOd6lmOdGIAt8WmzQiQlbGCesmvXgv5Yz?=
 =?us-ascii?Q?lun1BjvPY3cq/OOioQdj8ltSmAQSSm0q2C3fWujqbHybTLB6QDAOWc6LyjDa?=
 =?us-ascii?Q?nDEOjfGsUJa43AOEx09N9nlU4O6kIFkz/bXTHdQ/3r2L5PvvJYpTuqRqCjij?=
 =?us-ascii?Q?LLq8734JD93iPGITXTUMCuh8Ysp5GKDCmntUJMH1hJpWFm3nXJrNnHnJxuAe?=
 =?us-ascii?Q?YXxlzwk+ekx4diY3PBx4+SDVd050/oVVDPK4i7/LZgkkqkWGeYW4ylUD+Vwf?=
 =?us-ascii?Q?MEYX5lbZzLKsxrYNGKclGetL9GnBqr5OpxzGgsd5+BWJKBmTmKSP1j+HLxp+?=
 =?us-ascii?Q?PU9l+t3Kn82OK8FdxsophK8mCLgPHF8u5QAI5tmYChYJF40yyHkk/cdApaPA?=
 =?us-ascii?Q?lNYqwOUOA0Ipi91m/XSaRARypRwJqH/OihxM3u3IRsBlN6/EThUmpEUIGMD4?=
 =?us-ascii?Q?czGZsilOjpq1KXlkX7httaB5XjvOuh5HRABlgN5Kxtclufsy2g3BjwcwI7Wl?=
 =?us-ascii?Q?cN9p4cxxiznTpaltUhZXyM0bwgU+j+pUu3csxyhTjlbAqDe+slHnQ+lvQ0Wb?=
 =?us-ascii?Q?ppvZQdhHyLuDP50ivYFYKzQR4vjJUeA9UgkYGcaR1zCN/jC0ZHCp/ikMFgGg?=
 =?us-ascii?Q?36c/SOJqVkpkCHKRc0d4MPr7pB0YQc1IRVKZt+w4DycbabUDFKncdwrHBU0s?=
 =?us-ascii?Q?f9m3rhtXXF9r4paMlkvNzr0z0DYLRsw/P8+5zFZP495Yyfns5favzfWd1Mnu?=
 =?us-ascii?Q?s6b7WXsj690yeGRHeX+JyBsq7yDkguEei6K7aDfJ2tA5Kfsu+xh1UqGkzSef?=
 =?us-ascii?Q?PFpEPGqjvclFkdaj1QxV3mfbbKBoUcEUYz+eG3/3U9F1D2G9zel0fhnPg79y?=
 =?us-ascii?Q?Yj/pNFALaqnZnVsEU+n09GsNmUxvISge6E3WiN0GrZUUbl6VPnmLZNoholug?=
 =?us-ascii?Q?wLDqdjgC84udcQW6o667BrLaPispIr2HABZ4CejsydO6/lg1WICRxC07wH/n?=
 =?us-ascii?Q?fArKdN8HDPlcS2RXVwmBDxJPgIqRhDfihf6kgcoLGnMXl/nuoMXTgY3asv35?=
 =?us-ascii?Q?8K+ZIPP83XTpxka2wA/tpgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72310c20-6cd1-4594-9fcc-08d9a9d74cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 14:34:02.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfuL72SwKSyv5SWbDb9w2/GSClUi/jl/3Pk/iEmhniIBn1AHSL8NZLKOYK4M53xXpxLauAd2sLr0y6zMoER+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4295
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for the review.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday 16 November 2021 5:42 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com
> Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add maintainer for xilinx-ams
>=20
> On Tue, Nov 16, 2021 at 03:08:42PM +0000, Anand Ashok Dumbre wrote:
> > Add maintaner entry for xilinx-ams driver.
>=20
> Have you run checkpatch?

Yes I did.
I don't see any error on this.

>=20
> >  S:	Maintained
> >  F:	drivers/net/ethernet/xilinx/xilinx_axienet*
>=20
> X...
>=20
>=20
> > +XILINX AMS DRIVER
>=20
> M...
>=20
> > +M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > +F:	drivers/iio/adc/xilinx-ams.c
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks,
Anand
