Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655384532B7
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhKPNTO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 08:19:14 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:25376
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232753AbhKPNTO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 08:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+cvNaNbnTFyZEIuQzKXGTSeZsNQERjREBcNQ8PUjFniUWTuzRvGGpzJPQKaCrOsB0Q1vTLFcBj4bQfxK5iO+W6byqyq8609CZZKaeRhUzOlCSAINatz6LRT9zkh9jfI9QR/aTxjBtdcrNNLldx1sibsUAavQSovOiN10wlbAsp6i3WpSJH4hL2ul6fU60GYNGmiSOxmzljjJokDjgj0w2MeMXXcnZpPl4FegL90ZqtBIokN7dfuU1bE9I8xOUl4A8OApYdQuAh3uOy6SeqtbLnlCE4Zy4DiqfMIrrqFyeLJZouuNnGp4N6wa97N0zSY/KBbwRORgjE7w4t4idD8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ZuArthhcdkq3HWFB/bMj8JUaGyfbupC+A/Rq1E4H4=;
 b=dwuSlvJQBexquDI6qMRFPTpNQbapU7KX0MkYcNbeRBDEsxWd67PmaZrWdadRdHy3oiFf9TqCRZNaisXHGeQles3sgQYeS70WAirKcwKcrmWbht5mKy5bZbi2NNZ/JhpDDcwx2cImeajTHkOnETalYnR0BuyvfYrz1AtsOSe/6aRHItI6hi33qgssCLTr6nhGVPnQ92GgZVA1ivJ9l9fcFtprsygKtILIZ6n1CeyKWdebRgUGc2KCss9veWjCBortL+a8aT8PH1JkWFs9GbslvcRWvVcLq0I0ruG44WBhLgczchmJx6VBse8EHWpOY090a82tuRt/BZ1V6bM+1PW4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ZuArthhcdkq3HWFB/bMj8JUaGyfbupC+A/Rq1E4H4=;
 b=aKx9OVewJZBudr5xIckh0oayKUSMyIQpo+6SUar+ub7wd+m6rtAXLE7suIQE3AzZi12OuQYh7cb786UJbglcfVryAeSp1j78o8i1k70hHOMPfBPnlk93vdgc8/4oGSUpNP8JuMxazauhWRMFlj8nUo0xCzq/qU/lSNLK2XDQzXg=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6211.namprd02.prod.outlook.com (2603:10b6:a03:1b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 13:16:12 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 13:16:12 +0000
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
Subject: RE: [PATCH] device property: Add fwnode_iomap()
Thread-Topic: [PATCH] device property: Add fwnode_iomap()
Thread-Index: AQHX2keckvNuyh1x3kSfGREWzahA66wF742AgAAzZFA=
Date:   Tue, 16 Nov 2021 13:16:12 +0000
Message-ID: <BY5PR02MB69162F4F53EBD872CA0AAB5DA9999@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
 <YZODX7TxrbbzWwVr@smile.fi.intel.com>
In-Reply-To: <YZODX7TxrbbzWwVr@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c80b974-113b-4232-26b2-08d9a903432b
x-ms-traffictypediagnostic: BY5PR02MB6211:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB621162EEBE65B3A9BF30E39EA9999@BY5PR02MB6211.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGFnAvqKwdhCMePkAOUuxUtFsTEPGO39YWaV4uLurVbPeGIl1uTTbYCzSKiPOQThhm7XQhaOMXfdGVeh+boYIUC2BqfCdUhiYtwj/9ivNd/IcmFXDHi72id23eCcuoGlfZMwgvpcivgGSZ2cGL2yhD361TwZdSOq3cdcbgkvT2VZQahLVxZKc4NixXQkFPiTvtgPMGi2rui9TX02pzxoMwxg7cmMi6xOO4BxBKo/mFzocAgRkSyqskISts0TRDPxHBejp3Ife+Wx4HvTwrF3fbdLuPJdNRI5w6JNpzrM6n//SX6vO6VHQ7/Bi0aIflRliODqHGc99ZUtzk2KbIK4cBNJL3XKYK6dSisOyjcKrqX+gNnFIq+O2IIYRgH/FByWlnogaC0KDXH/60d5sRcpJ5RBrOHuUBVz7euYbI1Caf+sYteucXc7LpnU4Y8sN2D6i7q3Lsxbw+4bEs6Y9sjCPJKVM69RzwxTi6SQBq3tMZ+4KYNwfsuku0UKTMdTd438xNM4rC//hNziIXk7tloJ6QLj5bAlF3IjIepinhdiMXEyNfvrrSrmV8O6MGE2aCI7RHb9DUsFg35MXBJkBOCbcceGMGc7JAmR+OYGqFSnogq6IgsWJYXhwCiSCsFn2+SI9hheoPAJG//y86VQuiWc5DBDegFkJZKwKt+twTaomMzn8msOxLASHnC6ZF5S+Ff2l/wZXP7OEEN85P9Wa321CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(7416002)(86362001)(26005)(71200400001)(52536014)(66446008)(4744005)(64756008)(66946007)(76116006)(66476007)(508600001)(55016002)(2906002)(33656002)(38100700002)(316002)(54906003)(6916009)(122000001)(8676002)(9686003)(186003)(7696005)(4326008)(8936002)(38070700005)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqUMN4/+98KHkIX/2QsLAGcDJv1KpOmXb54dSwYucrdE4G7wtOOmWi44NShy?=
 =?us-ascii?Q?4cZBM1rDqfmLaETUvSWOtjvSnAU9VgXZg2M0Neg0WF2v+7/TkTXgh/1wgjol?=
 =?us-ascii?Q?PMlDtNAB0O61zaC6350i5HCd83MHTtGurOUE55SN5UUz+HzomdiR8hA3QQbN?=
 =?us-ascii?Q?7fPbyN+8ZoLpgpZFOZct4cNlFsfl+I1mB1L/YxutAuSMJ9Uouh7OMwReO0sU?=
 =?us-ascii?Q?6lUQuGGN7hHexc+i88Et9k4aJxgFOJb1tBR83qH4UqD4NtenVMOEtnLIeuYk?=
 =?us-ascii?Q?wEUTO+Tw9g5m0driHQ7WrCZgf3tSGC2BDJeTZvQ9T6Qj+dmnjyuMLgNmraGX?=
 =?us-ascii?Q?q4GkHXjUyqLun7SNsci0cE+FIFLFQSjJ9yhViUklTo9aeOo1JFz6YYJSLzIt?=
 =?us-ascii?Q?olW84LSqdfOP9UlnY9OkFfa42D6oQbIsoMAZLldZZPByw5oqYVtAwAou6zm3?=
 =?us-ascii?Q?kyzTKrttOQP81vYeWgrc59CfCMrjLMfenVCwnUd7A75ZQ4cqqQUwx2rgz4Ox?=
 =?us-ascii?Q?+XMMmANfSJVJbIwV8yc1gKMfKxpT6nI/LN8ev5ZekvJP+/buGGED/+AvGwju?=
 =?us-ascii?Q?/aObEI1bz6sEIiBmM3CxTKpJ4VULCiPxf6//J3FsJ5HXMGu3aakFl+6vBE9J?=
 =?us-ascii?Q?4Ix7QIa/MFPPkIDZFy8SZ133Ml8usNSWGspewdbzt94+wLHT9rNgkgIRfVxp?=
 =?us-ascii?Q?1qCnnOuvOQqu1i9IMNeTgxstq2kpDQJwJXCLfvedMIsw8JSF/52asxoOLMc1?=
 =?us-ascii?Q?wpkDmZ/yNyRoraPQlUkyoJoqac3HjqkNLJ5yJgzO+xZ1FSnMZeHrOmpHI6ai?=
 =?us-ascii?Q?bz8eKbKmbwKazFuqvg5LZWhimWbwpkfFhuF6AhufANWG48abK9wdijBT4SZn?=
 =?us-ascii?Q?PnCQm94ye+PQw0O0LhK0/LtsUYsLYP9aH3iN+8n8Q2K5JsBknEUH7nGYP3Yb?=
 =?us-ascii?Q?hM36VWdXn2g5DTE2Y4b71XrjHSTLI7N6kVEPbrvcxQtP7owcZsJpiAaPKdUl?=
 =?us-ascii?Q?7+NDMre1j550YwvSek016XADctRuFP4lqsyLVukoitqmenuOCO6VEEnvs+n/?=
 =?us-ascii?Q?r0eshv5z1aZ4SReOHcFNj2eCw3g093eqoGRM6mtcR4qfPxtRUFeIEKyK8XZq?=
 =?us-ascii?Q?SV5RVkeFnv+3vONfAZikV4uW93Oq3vJmYYdqz45x1HcQ3uCv1RhobdEQuvNJ?=
 =?us-ascii?Q?UIPSA+igSrwAxyzQCaFz3gZhopQEV54iDjBmh0DZhpDcYX6XX/Md1PvgKK0t?=
 =?us-ascii?Q?WcRgcFdxqG2DiC8zjbkFuBOd/KKe+hsbo8yxTF3HUQ22+QfmJLY9+/6SfDun?=
 =?us-ascii?Q?IPcJxfr8aITLMnzYSEsYFkEoc6dSYKKCcvWGnmo199L5b7muKeMoHr+T9aU4?=
 =?us-ascii?Q?mpxaQCY457xpiOES4d2z1tMTrcK47Mpi9LlTOmmC4Ci/2hXdiG9PO1upRMrR?=
 =?us-ascii?Q?tgOIhGPQFkAeAFiRxlYvGVoK6c3rfehau1TuBnCpm0wCiizkVcUfFBh3jzxG?=
 =?us-ascii?Q?So+sOvxAow3/ZxgLS0CUbneyFrdHAx3MrKVmpj9ugt4TMfH0d6it3jsjBjRS?=
 =?us-ascii?Q?duMzjJQo+0V09mX1ZskWx8vnoV5IcLIFz2FXFKPiWGI0h0fACcsKc+3z+5zB?=
 =?us-ascii?Q?S5qk8l2jFCI7gZuQ3o7P3jk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c80b974-113b-4232-26b2-08d9a903432b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 13:16:12.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRw67O0ijTNdD+EJeY9wxhjpka38T0fslP5zCwSTw1v6TgkJDWr/vbvr9KJVmP7kEWpfpLR1mBXl4npLhKUzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6211
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

> On Mon, Nov 15, 2021 at 05:38:19PM +0000, Anand Ashok Dumbre wrote:
>=20
> Sorry that I was probably not clear about how to sent this and Greg is
> absolutely right. Make this the first patch in your series.
>=20
> > This patch introduces a new helper routine - fwnode_iomap(), which
> > allows to map the memory mapped IO for a given device node.
>=20
> This needs additional things:
>=20
> - explanation that for now it doesn't cover ACPI case and it may be expan=
ded
>   to cover it in the future, hence the main purpose is to get possible to
>   develop resource provider agnostic drivers
>=20
> - Suggested-by tag
>=20
Will add all the suggestions.

> --
> With Best Regards,
> Andy Shevchenko
>

Thanks,
Anand

