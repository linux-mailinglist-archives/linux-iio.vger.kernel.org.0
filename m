Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF21B45399D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 19:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhKPS6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 13:58:14 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:46712
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239574AbhKPS6N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 13:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr/0meQPDp2aRQ2MOwBVKkKaiOm5DWDx87evyS9sX3jqwOUtWuv+GYMlZWsUOV0UomIVIJG9rkTzrr44npcr017NiN3nmzMZJLwcs2P73ga5Beo3MrkknvTQQ/Kt11I2X+oWF/5JJPTCcXWlaF0Vm+KmH+AKuRc54Ny2GSgRHF7iNBJxIIfzI7jHgF4MF1SLwzW2dpeIkG/WXSE9mnMvboAtTVS1VK1e4xzGBVqb6ajJt9WyzS+hm3YY8ucNqh/NAEiAzz2K0QGeYL1sJ8VC1cc1vOE+OjAr+wrr9dXH1mPU9HB8Rw5F8DPHRqyg+9EDb6F4g2Z+TjJvNY0aE5B2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isgp6lDFPjybiyOf+3ZgRZUQA6Ni7++Q+XYutJryGx4=;
 b=d2ee5UVNCcqaH2BGRvM7uy/IVVmIw7R3KbgTVTM9Gv/mn5e4NYElZpG0fbYNucapHOkHY0a82TRucfa4hE2Cer01qoU8McLuOaFwWxaDirY6JTg4lTLeLXzSQbPIcgbAD+MYJk7qfVYSoRlRiq0/Jlj90LlcfYrYPSdZtshW/D+RGeWZ4CAJLjLv8JkPKU8CDQz9txFopSEo0Jn8OcvY48kZui04Hgr2/kFNLLmfKi73E3xG3bBDaYlu9qGw8xQ3aT5pHRAEMsBVmsZceQ+qcV+oUzzRHlfJzLXrK5OtGgnM00tl7xMBF9zG4C2A56ugzCHpd/YbzSI1T0qxAhLp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isgp6lDFPjybiyOf+3ZgRZUQA6Ni7++Q+XYutJryGx4=;
 b=Y/9dzQINom58R87hAD6VpupWa3iLpe0kqwScobAu0+C+AdgtX+S4NodC2ajZzGjBqPde3h+ojklKaHH1OlgbUxirRB0vL2I7DJ1kuDOh+PHkpa3ziTPeS4Lt2pIv5XJusLawZLsloqxOI7YiWMfVeEdySvnLbZAR0pMp3vKBf1c=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7645.namprd02.prod.outlook.com (2603:10b6:a03:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 18:55:15 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 18:55:15 +0000
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
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v9 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Thread-Topic: [PATCH v9 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
Thread-Index: AQHX2vvgAwOlABuW1kCBnw7/IkXSLqwGa8KAgAAU+jA=
Date:   Tue, 16 Nov 2021 18:55:15 +0000
Message-ID: <BY5PR02MB6916E71B35104719B6229786A9999@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-3-anand.ashok.dumbre@xilinx.com>
 <YZPsv7FP0Rt3envh@smile.fi.intel.com>
In-Reply-To: <YZPsv7FP0Rt3envh@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c217e0-3a43-4e40-74dd-08d9a932a04f
x-ms-traffictypediagnostic: SJ0PR02MB7645:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB76454EBA537BB1E05199AB06A9999@SJ0PR02MB7645.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vS3i0PUPQ3HtmYsvqAzwlsJTtvwwj5AMxnxFbdR+h+h3hBcKauw4Lu94+Kmww0PSgpA5JMFW+rNZxyvOYZ9SogC3KWkDedW3aIw00iZtYIgcsaGKHrWLU/xfo0TPgyQ+8AjMyEXBxw0qsF7srVeKDg2dOyutxEzWXeIGnruN7UxZvFWtzt2pCbalo/HmkPvK6tOqHWamszTaIWUeUWTr2NpYrMVjnmpaln5dSay/TnzRzwZBy9dPMNFamqQ8tnyMEowYp7jDwDHX2zwuJlxG0wmYAYQfAn0c0ONG5gWaHDs/kCsEIte3CHs6Eu0sMuLh5qa8OQ1YJXDg88S7EaPDGzdH08dfJwEfw0wwm4PbZfc7QG8Z+Tun6WHAl5rDQFCq+cQ7lXn8S/wrokEWCc7OYsBqIMeLaL812oBsSHQaait+bxN90RP2YPCwgiYd7dL+KpFn1Ppwndb7VQmWQ2mV9kcUo95IMh/F6mLh7R5qTJA3e9fVSjGKC5zVffuCXLatqhx2ppYRsK6DUxZFuzUiQ3/9SneKvBb56dPJDFQzcvr6R6u2KRIaQ+j8y9+e5SJwsbyb+ovNzxhgJQkXwCBsVB/Q0fZUFdl4QYbZd6gkilhBRLpr+EXhvBxOZbPrBzkQJfzVYp/XnrgqfRxYZnyT9jfTHfyoKhWx0jvEPvp7V8C87+sSg/hFhhsTKwO+ZTyFWwgYORo823rR37v7jGLIbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(54906003)(71200400001)(2906002)(9686003)(83380400001)(122000001)(38100700002)(38070700005)(33656002)(508600001)(316002)(55016002)(7696005)(66946007)(5660300002)(107886003)(8676002)(6916009)(4326008)(76116006)(52536014)(66446008)(66556008)(64756008)(6506007)(4744005)(66476007)(86362001)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZk53JMTFVr7x0hdpi8YpNsf3LGd1EfHvyGU0CyO+PcHc+eWd5S+z0JtzFf0?=
 =?us-ascii?Q?JiYr8F8nzCpfrMz3EXci7xhosppqhkSy8BkQ1sNnjTPm4Tfnl6+WRXo5ASlS?=
 =?us-ascii?Q?FK6vyYifsBbdLKNQKaOF5Sy5Y6n9uftb0UEtg3E3ZI/rpGgk/i/npOdaiDDm?=
 =?us-ascii?Q?RvoPFRxDkmnaVYgfhV+BrW2jr+Zy4D5ZI/GjaePSK9ErhahUzzxxNcUlMXBV?=
 =?us-ascii?Q?3JcirCPWC7eULUxNSDF5uVrfyPZXF+cJ9/ZaciqyEED2m4sKJ88waUnX4Egu?=
 =?us-ascii?Q?33vfCbodWfIZ5xHypPrlBgUuirQLLZVcoXZVeQ3NCaW3CQEud8HNaCiQnCsv?=
 =?us-ascii?Q?W64GJVAmwPigcVtpf/bZowpS/ZwsRvRBpNplQp2Fk7lxNKXHQOaym0gzuE4u?=
 =?us-ascii?Q?IX0lezt/EOVlyNXqEtYo2cUe40jo0qlwMqXPGYhU5kX0oUd/hX67UJ/fVF3Z?=
 =?us-ascii?Q?Wl8We9zaiVwTde7jxiT1dLIVqkwEDdttWu1pUNCbTzvcPRgRuCcY77y3jMxi?=
 =?us-ascii?Q?SIcdUcP1cSXsJrcQ72KQVSzbE7lUGCc2c7Q1PZhCHG53MDxIsrySajtakE/v?=
 =?us-ascii?Q?2y6FW2mZinAZPQmB3hiiMDuNcvKAZRHMp2WdvHhB38NrBCM0GW9AMIUZZEf+?=
 =?us-ascii?Q?MMH7xL9JehL+8UEilcOCORmerSpJcTer+XTMbsLHEYPc0zn2rxfb1gTb4KQE?=
 =?us-ascii?Q?drchSI2TWwicubvpnEaxB7RAqm8XgLHcB/Z8lVVqU4LFAbgZGo2G2VvWiWe+?=
 =?us-ascii?Q?eSY3Mjlse9J03RiAlQSlE9L2WQXvrlExkak3UC2VB47ui5ZajeexT4rmnnOs?=
 =?us-ascii?Q?TwG5WRCVeBTjVOCiTpewdv9A/HkyF8yIJNWaqqJ/UQock+J72ACUbQ5aPzqK?=
 =?us-ascii?Q?sqlIErTc82a0pkufknqHU4KfkMMKC0p+V3duRB8VpwVhyLvf3PSQPHc+WsTr?=
 =?us-ascii?Q?/Xa4GHNI4CdoScuPvR78ZKVUEkPil1R0Hv5CyeQ6zTIyofkSPFtLVtq3lrMX?=
 =?us-ascii?Q?NKEZsKVeGwH/6kvfnQQlBuWFDs3mwhr5Wl4WtIlgN+jNn/uiAyB0hlwXDfou?=
 =?us-ascii?Q?zkwn/lIlIJ6BSxy0rh1MxtFoPbR2uoi63UXa69pJroxsnxBuMY8b+mlgPIPF?=
 =?us-ascii?Q?NLArfL+1gFRnsAT/sFvS5GBc6d9Hk0zZQgePgbsVjNQBKKR2K2kyCVHnJJjV?=
 =?us-ascii?Q?nfwarlZ0FrUgWcFvFXOUl348MaLXpch/1+pZcYr/kFP6iDCeswFD35COuPga?=
 =?us-ascii?Q?tT96EpjB7nkiW7EWcIgnuFKrRshZ2yL6cdQWfhSu/iu/ImtLvHoH89wQwQiD?=
 =?us-ascii?Q?NW+J3hmPXVEMS0rySwJDWKLPr4BESoJeYBKeayHa+Ndbei9OJhq66CWuCLAX?=
 =?us-ascii?Q?GQkdhTmGNkMl/c6RXyo+CuhOViz0fnhvLaN0/5TyrKHpQCWfNPlfVVqI27BU?=
 =?us-ascii?Q?Dq0zsA+2uZ3szI8iBxBAGAtylkU2Fj062Kb0QnZxfvOcyrpSmvMn/ragh5NR?=
 =?us-ascii?Q?PnZqV99wGUr72ndo/kYuAZDLHwE/p0jk5XPjhegW6x50JONM1x9IIaj5pshp?=
 =?us-ascii?Q?xjvUUNBG+1qrdYqv4w6W1lqFr47TzQFUuhPiIr780iloI0XYneHlnJDCS1cr?=
 =?us-ascii?Q?c6NPdmPQvNEF6MDvk6FhDiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c217e0-3a43-4e40-74dd-08d9a932a04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 18:55:15.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo2eKFJQhjdHlEjaw+6nGJYZvOIcLzXWm4eTeYjwvxJ2LYZ88e0KVtkEKzK8r4X0fZjYL12uWbCHJoMpYH5NrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7645
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for the  review.

> Subject: Re: [PATCH v9 2/5] arm64: zynqmp: DT: Add Xilinx AMS node
>=20
> On Tue, Nov 16, 2021 at 03:08:39PM +0000, Anand Ashok Dumbre wrote:
> > The Xilinx AMS includes an ADC as well as on-chip sensors that can be
> > used to sample external and monitor on-die operating conditions, such
> > as temperature and supply voltage levels.
>=20
> > -// SPDX-License-Identifier: GPL-2.0+
> > +// SPDX-License-Identifier: GPL-2.0
>=20
> This is not described in the commit message.

Sorry this driver is old. The older license got copied. Will fix it.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
Thanks,
Anand
