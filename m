Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390442C8042
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 09:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgK3Ise (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 03:48:34 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:1248
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbgK3Isd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 03:48:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im7fg8/yYquMS8OTDEes3Wsr8MB1i5KFuP4I8VuS/wYkK9xP2lHuD6NzKRchFAX6q5Vb3aNlZfjEe32gGMu/lkHPGde3lhKXG0LyFN6lExPP01mEW7qHdQQzhFpSFBi98TNdiRDX/U5g1kiXYngEx+4u154wZkx9CJ6ohWr6SJXfLW8AW48BqRbIMYysvOD54jy6qm7fmteXIwxlKO6g0IvXcIbBcnFQMy+thTtQUt20onDEZWJuy3GuA1ZUVbyQXI8ecHe1ReLyJoo55hWZIjv3lqwthZzEJ7FDYcvfzeJksBxl5vVywLsdCb9mJ2cibnglHnFCSMAn6BMqIT4MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4gVradx2uDTAt1dj8NvqzWyGTDlwthRlbEU2HuGR1Q=;
 b=Y9Jp7pOANvfTqihhSkIQ/lglb7uF+VJaPJDUHLOzeoNRD+VolMh7ZJYd1C1ehkyGjMvHdmyw1ZzQ1302Jsu5iUZkeBcbxxDNeiIUIQIT8Wi+hZUvUdPHESJgL94XtrFK03FiCW5kAv2tZmbMFYv8JwfNQI/qMEzyaNbg4XJQ8qC4bO6SBxYU2W7J2RoBCDZQNDY1Zbm5Z4mWvy+L+AQfkUTsubD3pcknvcOgRHdfsHQRnzvL191dShM+zs8AqCXKgEjdj5HaHPls+2kE07wOyGR1HerposFlQ0UlnCj45wLnCTjJ5EoSWJ5Tg3hJrfengmB3FkICwVH7m2lsCQkJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4gVradx2uDTAt1dj8NvqzWyGTDlwthRlbEU2HuGR1Q=;
 b=ZCa6QdJ/3Nw5mGnTpjcBJwqIQ8C5ysYrsryM8v97k3Bfp+C0pG3u4I4MatnErzc6xU8c3WnxpBEMXZYGsju60MNTCfQ2eq1nIAdLB6/4Wx5g+OTP/uMCYShw75FlXR7ZhTj44potsW9GkegjbzpyRePnlSaWOcOI/SurlbRC88M=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB5365.namprd02.prod.outlook.com (2603:10b6:a03:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 08:47:40 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4%5]) with mapi id 15.20.3611.022; Mon, 30 Nov 2020
 08:47:40 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
Thread-Topic: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
Thread-Index: AQHWkjkgUmywto2PT064yPbffUlezKnffr+AgAFHawA=
Date:   Mon, 30 Nov 2020 08:47:40 +0000
Message-ID: <BY5PR02MB69164146A1D1DCCC84D0902CA9F50@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20200922134624.13191-1-lars@metafoo.de>
        <20200922134624.13191-2-lars@metafoo.de>        <20200923214728.6e0c07b0@archlinux>
        <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
 <20201129131441.3e9d83f8@archlinux>
In-Reply-To: <20201129131441.3e9d83f8@archlinux>
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
x-ms-office365-filtering-correlation-id: eed1d453-529d-49e0-663e-08d8950c9877
x-ms-traffictypediagnostic: BYAPR02MB5365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5365120993B2F0FEFD56A3E5A9F50@BYAPR02MB5365.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOKcYRU8sVzex66mlvZGckvYmdoj9jm8mNEK7M00d2+lJh3zzW0YeqA/6a5cnOjPpXkJNqgyN47UzUnnotJLvYJVGTUNwl/teV6IYbhWr4+ky18z7Q9o8iXunCGH8VUwRsWY+Kpu3YlG9roaeMtSxjozZRh1/86HVtY7WxDZcBnEb5qXRM8F6Z+iA6ULVzjYXgR5qziIUINJTcWkgBC/KZ6Nf8Bd/A4NleBXbOODy3j6ERHPgA7HqXk3Vpe2tG3CHKXPqfX7PeNqFvuQssSwo4iL20loWI9Q//45+Up0/q9PWTkjFxn1se5kNFPZxjSQ7+rOIgk07SsAH23x/+pA6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39850400004)(316002)(83380400001)(55016002)(110136005)(26005)(54906003)(7696005)(53546011)(6506007)(186003)(6636002)(9686003)(4326008)(8676002)(2906002)(66446008)(8936002)(52536014)(71200400001)(66476007)(5660300002)(64756008)(33656002)(66556008)(76116006)(66946007)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dku0HnodR2jmfIQVc7DTSf0KOPm9LnrkKUjaIkrJvdSqUc8nWrDbiCByp2yX?=
 =?us-ascii?Q?mvE6a2c9U2Ec3KtOxx57fBsJJyZ9RqYHNVWUIW6NCrKVFRa12UoVZrCp9IZU?=
 =?us-ascii?Q?nIgjnDsyomATLgU/ddKA4/zQ2EkobJ3sfGHHud+QU6nLOOzzwfnv/NJAAc/T?=
 =?us-ascii?Q?SwjTTBEY4wTNUrF7aAbUABBkucFXX++seOex/K9sgLMK8isfkKGc+j/C2PY4?=
 =?us-ascii?Q?Kv1E3fK3UOqS9siOSUavsORPAW/Xw9HbIbPJo0pcujhbKIgKCKhrz3wYGCoO?=
 =?us-ascii?Q?4c1fVBBj1d0WWE2yTnS9BgddPRKuBDTENgcMtxtD6KVO2CYFpKtA0pNj5GgR?=
 =?us-ascii?Q?hbxpJzwro+fVCRv6h+S5eBNIXPOoh9LHRdI4Za4un4PxERpmz2uaq4iY+HY4?=
 =?us-ascii?Q?R43kFu2Rv/q8b73jh199y5Wa3SwbJ1Yyu0TJT3mIAUT2OmbPpZUeq/uJ0Mm5?=
 =?us-ascii?Q?Nrnx7ynFTV/WHcVGIVDQ3koFIihUkYGjmMGD62mRfNfpKuSRrGB8+1vZH7tH?=
 =?us-ascii?Q?yAR8X+s0txzHJ10irNPOhosCe1tkOCUTDHrFo+jpW1a/v4kIWp72EGHwMDKE?=
 =?us-ascii?Q?Oa+0f1hrxjP3krkK72q22MvAyELYSFDrg5MHopY75nOvcBarBpUmKzuPK/S7?=
 =?us-ascii?Q?A8h2umaush0+AlnuenQ5c+a6yr5mllR+RSkUOgzyXYw7bFE3btUgfLUsQDmb?=
 =?us-ascii?Q?zMXpN0WpK7G0OcEjxbZpVTy5l3aF19pZngbft7hBjXnFRj25NhrmCjtY4aSW?=
 =?us-ascii?Q?M+grXswTVzQe8qLDjykdnnc6uQVVr6LtFG3Y5y/7Rr4ubK3tzzufaeZ5i/5S?=
 =?us-ascii?Q?vy6Al9g7QsNVj4kyPFhGljfhk2T8qEEhBy+k/w1wcP9RdUw1LCDLLLI65R6T?=
 =?us-ascii?Q?HbekMliwxzpW29J9ZsJJLNExTtgrHegjF9aVUPn5zjB8rsJCfhXEmnlSJBZk?=
 =?us-ascii?Q?efc7MfWG9I3umKHyfBJuZisY8ypU7O+sRClXDIZ9akQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed1d453-529d-49e0-663e-08d8950c9877
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 08:47:40.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sH9Y+nwDi6vYc5VIRTTNhKyCuAvYbva1UfXKbKQwPy6Jtz2N3ZA2i/Z854jFuIscPuKH4bUo2e/4wXFi+7WJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5365
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday 29 November 2020 1:15 PM
> To: Michal Simek <michals@xilinx.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org; Anand Ashok Dumbre
> <ANANDASH@xilinx.com>
> Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrasca=
le
> System Monitor
>=20
> On Thu, 24 Sep 2020 08:08:31 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
>=20
> > Hi, +Anand,
> >
> > On 23. 09. 20 22:47, Jonathan Cameron wrote:
> > > On Tue, 22 Sep 2020 15:46:24 +0200
> > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > >
> > >> The xilinx-xadc IIO driver currently has support for the XADC in
> > >> the Xilinx
> > >> 7 series FPGAs. The system-monitor is the equivalent to the XADC in
> > >> the Xilinx UltraScale and UltraScale+ FPGAs.
> > >>
> > >> The IP designers did a good job at maintaining backwards
> > >> compatibility and only minor changes are required to add basic
> > >> support for the system-monitor core.
> > >>
> > >> The non backwards compatible changes are:
> > >>   * Register map offset was moved from 0x200 to 0x400
> > >>   * Only one ADC compared to two in the XADC
> > >>   * 10 bit ADC instead of 12 bit ADC
> > >>   * Two of the channels monitor different supplies
> > >>
> > >> Add the necessary logic to accommodate these changes to support the
> > >> system-monitor in the XADC driver.
> > >>
> > >> Note that this patch does not include support for some new features
> > >> found in the system-monitor like additional alarms, user supply
> > >> monitoring and secondary system-monitor access. This might be added
> at a later time.
> > >>
> > >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > >
> > > Very nice.  Will let this sit on the mailing list a bit longer but
> > > looks good to me.
> >
> > FYI: I have asked Anand to take a look at it and retest.
> >
> > Thanks,
> > Michal
> >
> Hi Michal / Anand,
>=20
> Any feedback on this one?
>=20
> Thanks
>=20
> Jonathan
>=20
> p.s. I'm just ploughing through my older emails and had this one marked a=
s
> waiting for a reply.
>=20

I have planned it for this week. I will have some comments in a couple of d=
ays.

Thanks,
Anand

