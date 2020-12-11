Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3E2D7338
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393988AbgLKJ6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 04:58:55 -0500
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com ([40.107.102.58]:12544
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390706AbgLKJ6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Dec 2020 04:58:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0tKepTaXAt/+uwgu5ZGL1AeMAWER/ayPsEbqb+gw0FZiCIX9j8tfOPFbp3G4moCO0PMtVDYOuoWaqDxp0AqabUw0BUK+aVjjxXYjR3S6hBQhycRA4XmFngxIrjVchpxLpbX7su+F6V/IPL1evsuHYdS2QzzV6f0GLGL8+XAJHHiH6GSSC5FKVs8+x0OK1Y2bcJGC2kXoAoDkSyUGng3dA20XtQ/70/yvDyG0f8d7FyhXscaU311GbUEVpF89/Ej+hGg6wd5m2Nm9f0qplyPM9w3usl5jUB9gVpVg5qrABqrWlyOHsw/huGpD5Eu1vMQYjE7+Gya5hKi0snAD+YqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtyeSvVjYWGiWPAdb//yuj6L22iks5Ge2k+c9bkXFNo=;
 b=eM6FwAGOzuzyKlJxF7r2NiHVVpsHZon14sqG71LRycp6r4NLiEjx80QnBP/kcNjMVdzRB134siDGXyaM/a36wopXWJ8/wwO5u4mbjUXc5uwNzLxLndSkIAGontirK7Hjb9MDJW7rymqe1u5mKJZlbw6ecV0REELKAHL4HMiYjJu9cIOHffCPLur9oPCYVx3bxWGJihQiIoD9VT9rzv4r3hoso4lK/Kx4zLiNG3UdTBQUnf+K85YhPfYc/j+WZoKVDKI+QWQhUppY8QTpt+mQ9UqteLvrvM0r2z68Zc+PqinzMBhnHH/yZjCrzphtJ+dAW1gRgnDuYijPofhVY4Ydmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtyeSvVjYWGiWPAdb//yuj6L22iks5Ge2k+c9bkXFNo=;
 b=BwMvKo4TfBPC1kQjPOGEsxgSVmaJWAmHr7pMG7ma0sIpe//Rof3ESSRElyuBtq30QXcXavWkkoGYyQpI2v/lgKRHsEMyFIaeGLfBNXCTts8qTqY+619K7FEOowS0D2mNNdTJq/ciEq8YDnbFkZg2DXjdVzUb7I9P6TAgHXCa9Go=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6485.namprd02.prod.outlook.com (2603:10b6:a03:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 11 Dec
 2020 09:57:30 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::309b:7e5a:bf9b:1ef4%6]) with mapi id 15.20.3654.019; Fri, 11 Dec 2020
 09:57:30 +0000
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
Thread-Index: AQHWkjkgUmywto2PT064yPbffUlezKnffr+AgA+7PjA=
Date:   Fri, 11 Dec 2020 09:57:30 +0000
Message-ID: <BY5PR02MB6916F923D93341D41BA08E8AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f80c5450-f30d-4270-52f4-08d89dbb2c88
x-ms-traffictypediagnostic: BY5PR02MB6485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB64859F7E5A32D81E14027BC3A9CA0@BY5PR02MB6485.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ql3QrQUfxu1RQPZKDCkCGbYLxgGmLM54y4Z+ojllqsh305XrdVc/nuKP2JRNQguzkNbW0SH/5kFFrqYN4ox4eIh6HMPxPPzSG0HumdvIGlKmCOhAMxl5IxVbEvhhkOYzYv0IOLQeD1t3moxN9YxQNYfGpgaC3nIOEReuRyXsj/VPbGqIrEsp6CG6nN6I5AYaTXdgrplBViHmec0NZx4D9X0RWbH7Tl3CMaD8Vxm9Rzl5TqGaTtHuESbKxl4lS1LRvGorL2H0Ij/1TqUllkjw72ggc4FvxmTh2rwyKhctwbjr4iqRfITdu4V6XtvbDpQoFB3flP5XYnaRxrdHiUYy9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(86362001)(6506007)(8936002)(33656002)(26005)(54906003)(55016002)(508600001)(76116006)(186003)(66476007)(64756008)(9686003)(4326008)(66446008)(66946007)(66556008)(110136005)(2906002)(5660300002)(71200400001)(53546011)(83380400001)(7696005)(6636002)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i77FaP4UTIy6JGowoXqxfAUajKf8oGDdGLe8hnxZoWi8Hsf96ryP3mW3O6JY?=
 =?us-ascii?Q?YJYISTFqNh65Cjhzh299aJq7gtOFTiYTPFJOr/qiUJthhKVCimT16typ57GU?=
 =?us-ascii?Q?mzupy676E3Hiolg2BeMuBt2KGhJqsvG3mAI4E8fwgReECDcyLFSNWckxe2Qs?=
 =?us-ascii?Q?ljJs1DaQKlvUWsPT01ahzvAXbMFvkOPWvw/WkKL2UQMF7Ze4/OW1d1P1xwtY?=
 =?us-ascii?Q?FI4nyGAcamAY81/HGKwiSCN/l+wNvYpNoqPHsTV/jXzsuomr2GCH+Lpt3Ggx?=
 =?us-ascii?Q?qx9Sd3pmGtDxB0f1T37+fMi4JY+1aGmaxnCn7H7LOCSkr+Yiqa1cgJOOi30b?=
 =?us-ascii?Q?tsXi8tx/C1SDXKP4wh/WtODjFHzSkt1dLWNqyyKYwnGxuk4aTDsH55HzG2OE?=
 =?us-ascii?Q?pPB8+ROKCvfxZ8sSrDHTAmk7tQhW53i/92g1PX8EB+dffkZRIuXTM27mIKHU?=
 =?us-ascii?Q?YB/pXFqAhmpTBzIlCyyn+zwwx/LZe0UmbEDn1dQpnFDukIN/A5FutoKKGP3O?=
 =?us-ascii?Q?S7q8W7Dr3AuSD+sh1laTyyZPnVq3OvOgTMwccaxFscRkq5OOo2IlE3a7a28d?=
 =?us-ascii?Q?/P2Xq/iOONcnIsTpajoZWfN7FKT10xHxk1WfyN865UIQEq5oiTwi0z1QxqUM?=
 =?us-ascii?Q?/N6vMBhN3iM8glQNyBrTuZOQckA2isq2h7aTwKdRMXxQPg9/QsNn2o/Qg0aA?=
 =?us-ascii?Q?4MhzBF13v8RyNzkt+ImVSf1+uJ7P2Gj5Nr5iDRPtZx4PmRCp6cPqpAiGcqth?=
 =?us-ascii?Q?z4l69+BQ4H2asSvo2pKRnCNCjJG9xG+PoQCjT9L+kAyB3I1Mm/ERhOZGaeqs?=
 =?us-ascii?Q?1sZKVFto8HihQYhRl53OvQOfxPGXG/uyTksHWLFp1qp8VRKgq1eBPHPAa/uo?=
 =?us-ascii?Q?HhCCPaDIGujGN/hZ91r39O06bwRJQPL64u9+5xZAhhVcJhJxajxzvikZAL0N?=
 =?us-ascii?Q?UTmJaYS68rvLASGfG1Ue7DnxzVp9yfp+a1ldM0jci0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80c5450-f30d-4270-52f4-08d89dbb2c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 09:57:30.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsB568JPG3a4qF/d8UWGv3lvhu4mQXcqZHAtmbl3S7CICS8dAoft9tEOL9kxA4AEyhcRF55MCvCT0xV0wmKE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6485
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



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
Hi Jonathan,

Thanks for waiting.
The patch looks good.

Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>

