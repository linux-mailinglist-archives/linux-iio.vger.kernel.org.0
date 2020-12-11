Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1272D756C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgLKMQg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 07:16:36 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:18562
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390915AbgLKMQL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Dec 2020 07:16:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwcb/4tgrWR3c91j4qHVs3K7jU0+MJT5Zxpp7AY+u3swMXnEgBCGhg4ydbX4FTL5bmQGqKrxoMk505dtAdzoELTFCvQ8FTmhOjbcHJO4qyPURgTpykwXE2aE5m1J2CZe/ylUg9HF7EsDX2JWjoheE+njzQJXwuvLEegxbOcTuiU9WUwTy75N5nPWYESRTlG1dTShF8NtHj62P7qXWT9RKyev3QRAkas5GWB6L9nBBOSqdSV9SOkUayZtEKjZlK72x/sQ197h9i/2uxPLwGsELNM1AxCke7xyerJs/SzfltHpAMs7y9URf+Nu2huj9xHMvTAiq7Q4yPTOhktxPoSR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBUltC8qdaAMRFN8nAlrHme0pLoWsGDXkkWOIiOTNAE=;
 b=kbIH10HTRKMvdizaoVNHagpzWik0IPY9QHMrv9uFPCdhUn/4Ien74NkH/8C3yYYoFH/6fcFSYu5pkwX21FmO2rlRpzQJ1MaZnnDPvgm+XKouMaUPXVLjQ0KIU1WdOndujvqH1QCQNdaZ9LAis7LX8c9bgDV/aNA0GlJIs49FgwNqrhp2X/gZ2rhE2aHmH20ZSNHG3QkRT9v8SvVH4djZ9NOoZqCXzQbJVI3iK037jLlbBlQjS/wzgn1ASf8HYmeP7q7r8FKOeFs2LLSl4CJHIj6rcX3xc0SCgiH2dWpsp8MQnFmJZOXw6d8RZ4Szyazn3pH+AohN08KLe60vFEF43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBUltC8qdaAMRFN8nAlrHme0pLoWsGDXkkWOIiOTNAE=;
 b=FBi1eMblY1JxcFrDVt11pV3GtQ4SA9w4e86XFSFvFf+PFrNO2mqScY0ppRt4b/MM7exjRDkvi5RX6ctycXhXZwtMHRJMZpbVW7CEVOwe20obGtzbKxLi3ZlzGQbQo82exKFK8GVIxxsvMvWHcRqVk2IUHI2DFH0PyLbcG6p36js=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7247.namprd02.prod.outlook.com (2603:10b6:a03:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 11 Dec
 2020 12:15:16 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4%6]) with mapi id 15.20.3654.019; Fri, 11 Dec 2020
 12:15:16 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: RE: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Thread-Topic: [PATH v3 0/3] iio: adc: xilinx: use even more devres
Thread-Index: AQHWx1Zf70/YCanXOUOBVqqdgaT4Wanx09Qg
Date:   Fri, 11 Dec 2020 12:15:15 +0000
Message-ID: <BY5PR02MB6916FD4844C5471C635DAD1AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20201130142759.28216-1-brgl@bgdev.pl>
 <20201130202110.62e7f989@archlinux>
In-Reply-To: <20201130202110.62e7f989@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d940e899-b65c-47a8-6f37-08d89dce6b3a
x-ms-traffictypediagnostic: SJ0PR02MB7247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB72471A01A9EC7179F8E805DCA9CA0@SJ0PR02MB7247.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKjTqTISBCkEKaZlxzYCdBh0iPiTnneUMGniEeI4DVojTNx/cRu7AgrUcBNRC/uP1BeTwxlaii2MFyC4Qfv9qiS1YSmut2H5f+ywxIGWwnQfpMBKbAsQES2/+hWaRkKKYp8bXMwRNggkJ0PtDYerHBoHG6PvNjL8MLyU5oRbRCoumCC7P7T9Mcq9OYYSstTyaVQTGUlgoWkcSQ/DtcL9R3+08sW3y14rbmhPM2EtVDAKdCCzuo676ubsAegdIvkTSsfnyxdCy0+YvtCxv9wxn8FUGAGUO37UQlHC6AAnLQlQMwxWi4axYfIvTo/6ovti
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(5660300002)(66556008)(66446008)(64756008)(8676002)(33656002)(76116006)(66476007)(8936002)(66946007)(52536014)(26005)(55016002)(71200400001)(110136005)(2906002)(83380400001)(186003)(54906003)(508600001)(4326008)(7696005)(9686003)(86362001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jdA3ZuRCJRk/ZsOFlbZX+pEuaR7WHs8I0QqyZTSUEPQI6zITjjK1UkUMZrdD?=
 =?us-ascii?Q?vquEMFeOcebxnXAyFYIx9taqij4k9Wyfq84+wcgwYfoa9FXP9gAJ18w0HY/V?=
 =?us-ascii?Q?xVwwK/zxPos4z+BcwWhO3JJHfxDLZKyrEPA3zccmL5gXQhjyVrAp0o5xr6pK?=
 =?us-ascii?Q?yFl1MiMRdqXwMcvV96APYCcK0f7aOJSA+/ia1Q35KN2g+aZ/Uf6KHMHfJxyc?=
 =?us-ascii?Q?QBV8MDI+apjsTzBDQ2fhGM9zJpHQAknlihqzUHjPZ7r2/JodfYgzakcNoKiA?=
 =?us-ascii?Q?4bn+4tSwLLt25G56AS2MUwpNbiLLg+O0ZfW10XWy3fapeqWAvjGKnPkIXpGs?=
 =?us-ascii?Q?9canBdk0qAsQ5J6Hbdi12ZvOrlYNhIjLetm/i22nSUTtQ7UDjYV+lpW/wcbH?=
 =?us-ascii?Q?2TUgKWIH4wg1p25p6kKlk6xc3mCTWN/ZswuU1+kqExPhNHNGybVqS4irBl1h?=
 =?us-ascii?Q?QptQaCrVPxavKLF1F5MGpnGDZe86UkLWLF0WY9Qjo99vmaUbc/LNPjjfz4HP?=
 =?us-ascii?Q?qO7sfT2fPmf19aozuSS9DThxCL/MIGvn/OiAlnu8wveDImTOHnrTa15VoJK/?=
 =?us-ascii?Q?OUnKObLdtpapJXcHScoVYqdiFp43JbPmLqGVf9sgQmF2Xws9QxP0ibgseHOM?=
 =?us-ascii?Q?tNWcyzdoFsbfd2+M7YEsUjUaETLObZu53i+v8zM4q0kNm04N7q172Ucl68Yx?=
 =?us-ascii?Q?YY+9jc5+LCZoROjTJN//aFYPiVNhJjR1P/ACEKawKqdDZfkwfK0LCkKW4iJ6?=
 =?us-ascii?Q?TJI0z6MUbOJf1P/jRSD2uGrYoDXdJoz4DCMf9EQRV5Z6sT/p8zo7gPA18YPN?=
 =?us-ascii?Q?Dj2aWL/rw9sOlJ9lAtc2MbOTP2LXCV9FvybUNUaOUcV7XU7S3eefVlbK0XXN?=
 =?us-ascii?Q?OfSgyqcUz8nI5NrAcfERN0dtEsVm+I24KvDeDIC63bR7z0sAVcqrH7CGvLI3?=
 =?us-ascii?Q?UZ6Y1CkK/NgmcJU7WYU59O/uGsOMj7+xNCmnBJg9yrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d940e899-b65c-47a8-6f37-08d89dce6b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 12:15:15.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmSVX7zEBhbcQT7FBOaSkGk/qqTMNjnV+vmLrw/zHkOyXCqgqK2rXJzouCp0L6aY3O+fMVNp7nfETzRpinSEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7247
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday 30 November 2020 8:21 PM
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; Michal Simek <michals@xilinx.com>; linux-
> iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Bartosz Golaszewski
> <bgolaszewski@baylibre.com>; Anand Ashok Dumbre
> <ANANDASH@xilinx.com>
> Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
>=20
> On Mon, 30 Nov 2020 15:27:56 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>=20
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc:
> > use devm_krealloc()"). I noticed we can use even more devres helpers
> > and entirely drop the remove() callback.
> >
> > v1 -> v2:
> > - squash three patches adding more devres calls into one for easier
> > review
> > - don't insist on the 80 characters limit
> > - add a new helper: devm_krealloc_array() and use it
> >
> > v2 -> v3:
> > - drop the devm_krealloc_array() helper
> >
> > Bartosz Golaszewski (3):
> >   iio: adc: xilinx: use helper variable for &pdev->dev
> >   iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
> >   iio: adc: xilinx: use more devres helpers and remove remove()
> >
> >  drivers/iio/adc/xilinx-xadc-core.c | 157
> > ++++++++++++++---------------
> >  1 file changed, 74 insertions(+), 83 deletions(-)
> >
>=20
> Series looks good to me but would like to leave it a little longer to let=
 others
> take a look at it. That will probably mean it falls into next cycle now.
>=20
> +CC Anand who is looking at another series touching this driver and
> +might
> give this one a spin as well.
>=20
> Thanks,
>=20
> Jonathan

Hi Jonathan, Bartosz,

I have tested and reviewed the patch and everything looks good.
I have another patch series on the same files that might cause conflicts.

Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>

Thanks,
Anand
