Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA0319D7D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhBLLkf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 06:40:35 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:60513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhBLLkM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Feb 2021 06:40:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0xMLejjDCzvSUCfnUNBTlAXxsQM9vW/I9WB4twgWA/910/XGH1YlqXaLbvnvVOlPiBksyPB7zNPvDOUBpdZnvawWaDsW/Zgsv63tEiKD467cotniTuZP2JKx7GpK/FaYEXpEmnKQ9jVE4yZ/FF7eh5rLVv3eWgOo2X8TnuFwV7/BpUiovfB9kkwofxPZREIFwHYCkgdYEZMzwzOlsVkG11LeTNmygjD2P7bh40dVcCW6xoWK0XlUe3vi8DvPI8dL4lfV9qLSx1Dy3OXcZe/9lkNf7iQRLoOP7AzRhrjoMnxLkFSPMjheB9vZ4mjimZHeQvpu1WTn1fHkv30+L6JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwumvtbWuutkXsdRWtdS1srplF8QEr46TCTO6mKkP8Q=;
 b=BErnR22cty56+CIFvJXwGYsGN2Pq23R7c9SRE8Bh4u/Ew/UCe5N0yhiJgunAYrPbqxb+nLR8LBA8T42ay7QNEalqZUTFHVVtzQCPtwEckObkCxdH+ttMNazTZjjxZrOiiYvvDA22tKKf5EXoBoxKboA5TR6NrwMluk8E/8P2omgxZ/rkELxKtC9AUBXTx65qr0cp4Ty2+luank1f+YCpoQUz6PSr7m5Cru728T15+pe500H/Snq4OkwUwNq0AS0kpBHVq2mxfQJvf6eSQ3eElafIrJ73brB93z1qCMBfL6F1Kn98J/q754hghGetsabZooXeis/t8PzIzPTl+uhxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwumvtbWuutkXsdRWtdS1srplF8QEr46TCTO6mKkP8Q=;
 b=DiXWqUiLeJ1xb/KHdW7o7yrlbY/V8TkfDjHFQZRs3Jhnib3hXbA5Q9hx37kJjrco3br6XTTU2DbF/2AlPevp9srFJl+Ti+vZN9CWi/gDYIN7ucnZDnmIV10lOqQjLhEkOU8IPtkg8HV5U3MzcCJYwshlS/hzYL9gaHaT/611OdE=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB4807.namprd02.prod.outlook.com (2603:10b6:a03:4e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Fri, 12 Feb
 2021 11:39:16 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::a0ca:5138:c5fd:8435]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::a0ca:5138:c5fd:8435%4]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 11:39:16 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Adding custom functional callbacks to IIO driver
Thread-Topic: Adding custom functional callbacks to IIO driver
Thread-Index: AdcBCXp52GXeQBuaTayGtRoeCC1D4wAKbMWAAAAfUyA=
Date:   Fri, 12 Feb 2021 11:39:16 +0000
Message-ID: <BY5PR02MB6916FC7B87BAF6C433380068A98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <BY5PR02MB69164C83B7BA664AF350D712A98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
 <b8cc5128-da41-2620-c44b-c7af28cf6980@metafoo.de>
In-Reply-To: <b8cc5128-da41-2620-c44b-c7af28cf6980@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b9f25c5-9d9c-41b8-86ae-08d8cf4ad3e0
x-ms-traffictypediagnostic: BYAPR02MB4807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4807C42BD4D09F8CF09D6FE6A98B9@BYAPR02MB4807.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTOkxqA3DDFMV9rMlSRFM/a+jHQGW83Y4Rch2D7ugLlJTfSZ0CRq3BbVVnvlRWz3Y33hP756lKevI3hXtLBHIibPWSo3W/jm+yGh5sDVZSc85jKFXcKhr7gNr2PYvTSk1dbiQ8MMNqEOvP8P41YD6hgIDy0XsPLJdO0LDcHAej2kWR1RLyT0NHOjVxrZbw92zGlzQoL1LfV7Z1kAQAeeISWx00KEjB63hvcjQWh3qk9wSy/2Hk300rK5a8hOEJDtT5n9fxw+MM+/W8gGvdoL/aUbKLAEKwzR8ZVhfOZUgYLwqdA42aobUcPmU03Ws6cWyHK9a2mzlegC0TnpqQFGXn5rlG1RBUsWWZo/EPP2pbOto5nqjses5d6BBRK82myrXaLstrzM1HorSxGPKXNztk5WMMn3W+BFd1B8umHHoeqDQk1VDx4OAVieAeqiNz67TsTN/WC306/uKuNquJ9UELrI/jptk7p8O6xkpjaWUBxfZckOiXMt1w7uCnDjB67UD9QcryCWhbLzoPaQNUOMYVps5sLrVPm4VHCBee5V3py9H1g0vuCsYKw0l+3qZBDyyf5RJI9joA8wSMXpWZSAQUJb2s59N2Yz3c/NEAit5WY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(186003)(52536014)(110136005)(966005)(6506007)(53546011)(5660300002)(8936002)(478600001)(83380400001)(316002)(8676002)(7696005)(66946007)(2906002)(71200400001)(33656002)(76116006)(64756008)(86362001)(66446008)(66556008)(66476007)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CH0/dzy+sGAzpVsMG1dg2NX4+ljPaSWuI6FA8ty593OA6RZX6AL/dzknQjaX?=
 =?us-ascii?Q?4AEnXXihdFhub72FF54S69tFCpNE9pBz0mayUvE9oqmxm/h8BqA2ZW6YL99C?=
 =?us-ascii?Q?pND5wovmhWpg2srcjwmb4MS7C6sTJo2N7GBhScuKOnTBUefZaDNVOvJ9PmkZ?=
 =?us-ascii?Q?aNca7xfWv9LWKwQuTJnRuclGBhqU1lGPaFagycgITYrY09H46OljJw7za/+v?=
 =?us-ascii?Q?6SofpNA6xExa4YHu5THfwozm6liaLaKynMaY7HDRSJcbycxJRvUgpEIvCZ4m?=
 =?us-ascii?Q?0Z30t7eD+qZFkSDEuTj8UkoIiGagAF8qlZjCYIFNAb7JZIDZwJeU5mxVlj/a?=
 =?us-ascii?Q?iXdRGaeDuWeYiHA9LsnmRG9PDlKxMASL/OpISIdAs9veoY/Yq6Pa1qdR6n8G?=
 =?us-ascii?Q?ZMAXbX76zFdnlmAVEq5GTioBi+5swGuqi0e/y1GP4LK0aBBL16//BMvyri8v?=
 =?us-ascii?Q?R/TjqPkQir2d3oM/DbmzO4jXGo+HbPbOYA/ZdyMwq0x2nxF82nejocAluKS5?=
 =?us-ascii?Q?rLvov39ZYbB2zkJQu9cyVdEnCnf9wsRVysUxFuF9Bc4XGlmQ9k2V6nhzChrv?=
 =?us-ascii?Q?36DJbfr/j2OIJ/rAzybAL498c7fMZi4w4AZREe15NKfiwMRD4iwUSphz01mK?=
 =?us-ascii?Q?jAh7vNvu/35n6LkxH9LT4GP70s/PG4stuySDolBYoAaaFwv1Xls7GslE8sti?=
 =?us-ascii?Q?hmUqJCTt3P4Tp58LqVKrP1fzY2bVwlzaN5fHHuAJCih29uN+wnmyfdPls27B?=
 =?us-ascii?Q?oaE+NLdpopyM/ybEnQzCcLZRO1no+eQDDPCnNjLcqwwWGJJK9wrk4dYI2Yle?=
 =?us-ascii?Q?FoAgpSEfKClZjqJ9TtZ9bqIWQMy3lqg28WG36cfObZfNQTcDSLVl3W6Hcanr?=
 =?us-ascii?Q?0vdtyAW4NNBUrXZ3GlG9XURAvOC3lPDZe+SMhCytv8HPNji43AwF18bg9yVC?=
 =?us-ascii?Q?HPCC9FlK5Vb0gZwl0/ltQ51a0KhQlWwMGIPo1sapLkVkK3YjpneUOesZlINh?=
 =?us-ascii?Q?Nxz6/B2uymvEWL1MsJRSqY6LPnxu+uZAgOp0uAaYWsudTyF/1ypvmId+eVlk?=
 =?us-ascii?Q?y2HtQLv9sXt4KmhcAbdcR1U5T7N4sVCr7MeGRg49xu822Gf0JSr8npepq6el?=
 =?us-ascii?Q?99eZ780UqFZqzr/APNrY89RscFZK0SZ+RGNGp2xLKHRYcVUtlSFMEsPtaDOP?=
 =?us-ascii?Q?rbdGRqMM6gg90uPvWStAwOgERuje5oQCCYKxBVvkQXMPH1tDqUWm+vjKH6fR?=
 =?us-ascii?Q?fW6JltjH1z8KqxrcDhgeUU+62pNZRvWOhXgU2KCGRnAB4Wy1FoMt1Tf/rYfu?=
 =?us-ascii?Q?ztDyWSSFY9cHBLasaLblEmgH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9f25c5-9d9c-41b8-86ae-08d8cf4ad3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 11:39:16.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJBJ3+iurUyntJCqr6FbJ8sW9AJPy1Bk63qO12zEK/Ayp2pv34PKxBSk80McRC43P9tcEgJhXEx9qY1xQZDWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4807
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks a lot I will go through it.=20

> -----Original Message-----
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Friday 12 February 2021 5:06 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>; Jonathan Cameron
> <jic23@kernel.org>; knaack.h@gmx.de; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; Michal Simek <michals@xilinx.com>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: Adding custom functional callbacks to IIO driver
>=20
> On 2/12/21 12:07 PM, Anand Ashok Dumbre wrote:
> > Hello,
> >
> > I have an IIO adc driver that measures temperatures and voltages on the
> SOC.
> > There are other kernel modules interested in the temperature and voltag=
e
> event information.
> >
> > Would using a custom callback registration mechanism be advisable?
> > Is there something similar done already in IIO that can be leveraged?
>=20
> Hi,
>=20
> Have a look at the IIO consumer API that allows other kernel modules to
> subscribe to the output of an IIO device.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclu
> de/linux/iio/consumer.h
>=20
>=20
> - Lars

