Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8775ED4C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGXIVf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGXIVc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 04:21:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97293;
        Mon, 24 Jul 2023 01:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOAYCIZLetQPLIFFG9E0/ZOHZGlKh85LbnWIEMSvT2uYYyfzUJ88pbvOdUt0iJpi2tK2mOioW8dxTLO7fPQJXR2LSq9JhAQqEj2262s8o9ZAkAz2/rOzK5NU7l94UpYkK08n8Jp0Edvt2WEEm+4zzgtR7IJI7HSXxIzUEIEQp+CngpAJxfh8L2j1z3kzg7rECu/P6x0w/114SSGVAdUoSnUHgZK989ZPfor8ZS8XyT8WhNLzrqU2xVz+cYLA0X27XPWi5CLE0FO6tN07aAGHYBiUsTeQK/AIszG3CaJavLCy7xP993nt1utcRYUOkuX/VYWOqfz8z4WGAgTMRHzR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEorKn7QV16Bjq7a3GubDiOhMewrwBLnPIw+dfAgOCs=;
 b=eOLW1SJ9hhPtr2ctjSp1Ug//n4n9r+uL2fWZYIghu0T1zFANmuKK1gBuHJus3dbM63wEOvKP7vzu4ryYeqOgnQuRS+L6OPZGuIN/BsT6QMuLtdsk6AkY1LJjJ7NAnjTPHUEGohBefNllzNaXeCAj/bLdVgaUEjOP4lyfkaJOl6Y6dKV0LbrLIORT/dOLcM/mZsINsy7rD+I9KaxgZyoqYrThc3IFuyCkipmHph9GQTM3KRWhfy0WhFhNf6RMAc6G4t8U0wqF/2jfh+YatqGXm10ilDghNooH/jUqZt97QdJi15x8aaLaAMYyOGrWvsrQZGRD9vOAxGG/tQRaPU7rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEorKn7QV16Bjq7a3GubDiOhMewrwBLnPIw+dfAgOCs=;
 b=RsYCEeXe2Mh4G+hKb2CJuCp7GLaYN0abpwgZcRgCkGCeqKojIBSsndA4U7HpmDfmDL79xeI1XW6/sG3X8NiVc4++sNZla+z3zRYb/pPV5ICfIFAHQ0USevW7241EmqJ3p5Ds/eWkYqzV41ETmjHzmnIwd5ncHUp5XoBhdWBEUh8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7745.jpnprd01.prod.outlook.com (2603:1096:604:1b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 08:21:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:21:27 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Topic: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Index: AQHZuwuSpv3gkn/1J0+wg8hRJGO8+q/C5nkAgAAItVCAAAKbgIAFop4QgAADmQCAAAFbwA==
Date:   Mon, 24 Jul 2023 08:21:27 +0000
Message-ID: <OS0PR01MB59220227EEA1951BFAD7AF658602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
 <20230720-clash-borax-b458480d1579@spud>
 <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20230720-cognitive-identity-1d132ed09d2d@spud>
 <OS0PR01MB59223400A76E7D05BE0C00088602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230724-pork-reformer-0eb65d306222@wendy>
In-Reply-To: <20230724-pork-reformer-0eb65d306222@wendy>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7745:EE_
x-ms-office365-filtering-correlation-id: 3f7a9d03-310b-4ed1-c3c8-08db8c1efa21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IFHE8IEpVuJj+BwtyQrL8/IMtoKdRjP3GX0dY/buTDVlZC/h7Xqe33mNn3hfLsN/NOk2Afo8HTpT01iAkAzuFxMaMbLoFsOANFiaDy2jngeflkFfh8atZk9HoIiy803hM/r2ZB5HB7EBLGoiqv+ZgKyzU/MmU1kpEdl4YClz6bbtB+oFDBh6khiBveRSIR2s1JBPbuZwC2GR2v044U7ivk/Zq2NObU3MOMCSMVBpfQOrZqZaGkaEp05iSucJh3RkaOQlSf2n62X+J3e6DJDO2KWa+HlzdTr/ITwIQi097QJRJBkvGyDq13ZBkXS1OyQ+XohKrH6gc7eVHXzwQViJftRpX9GAFNnkOKsSH2yuFmYfzRxK86TUny7r1l1QPVZlqcyxXXOQlBGNMj77cFnLOd9nX8kuZc45ymIDa7jGxaw9ckFSReLFzDO02wLPg3CPH1OplBytWRkWn9tg2qQ/Dn7Wh/Rz6ZH+rH6gpywWiSIisJq73D8V7KnO6kImiPMhWNGCPOp4h9bBgbEPEVejiw81cVGad5ImchnfG0JjhM8DZnq+HMHJ04eO5yg/MZAopoE4yMUEhGTawvIhIIO/D9ddiQBB7vZuFT4I1difk6//TCdOpaXNOmNd0LWxt/d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(2906002)(55016003)(478600001)(38100700002)(8676002)(122000001)(9686003)(83380400001)(186003)(6506007)(26005)(86362001)(52536014)(8936002)(5660300002)(4744005)(33656002)(7416002)(6916009)(45080400002)(71200400001)(7696005)(66446008)(76116006)(38070700005)(66556008)(66476007)(66946007)(64756008)(316002)(54906003)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZOTyudI7WOvbG67dmVFm9dqi+8CqQFazD88DpyXBaYR4BYfC9qhCXrLCaAM?=
 =?us-ascii?Q?//kXPqVdUF79HKLkgxgX3sBiElXOHgsVm7EpnuewB8Deqcrisv08ThRZWq5n?=
 =?us-ascii?Q?xj3hHK4YDmKlR+y2qOQVjjr0g1429HMy9rnjwJTJBqXiBBxZgZWalcSCMQu+?=
 =?us-ascii?Q?gGqZ+az0+E7wsv1HKr7OzorjGHoVCfv0OUA/Wud/UoK8Pf83idExuYRfATGb?=
 =?us-ascii?Q?rxegfZOe91LdwM9DdvlA+3Jlm7DtJXIkFYBj4dFaczeTrWHiw12Fhzn81JrM?=
 =?us-ascii?Q?QSL3APUFowuR1i0/1pUTjIEilpp7veBGcAAEdW2/u2A/xuMJjgkNVB5UT6my?=
 =?us-ascii?Q?Ua74bGaCj2lNBWoRMM4U1UIa8ITJgKAbPcHBAtEF3IwOGADb2bnyhCNbve9Q?=
 =?us-ascii?Q?Qzxz0X1xAuROsmRsPUht6+v9pA0iAf/G+ql28YaBuuqIujsL4SRthOgAnF2I?=
 =?us-ascii?Q?kWO48ZvRnosXcgbKeXsgs7UQwY74QTTBlTeECpCJg74V1LiS2ziV/D2WxhMw?=
 =?us-ascii?Q?Lr9RbsxfjdLChkHuphOAvFt0/vS1YX42ZTtwaokA5JC+QkhNuiWrziGHNpCA?=
 =?us-ascii?Q?+mTpV8B+VPryQsKUtz+IkDQyiLOlbFo7Q/xZVPf1sm2i9hFLwM3guQtj9761?=
 =?us-ascii?Q?vFaxxoAnL/g5y++j7nKWHBl81oNCrh3gWhvO/MyvN1xiPCXu2Ykg1Vqmfzwn?=
 =?us-ascii?Q?fJxBEvaPK9afArhjzoPXHoVXuSpXWp6/LCFyhs3wOFE2DJCwvv8ZEFyNKHqk?=
 =?us-ascii?Q?yjlhC58bIiyccU74+KXsHfBMTVrPw/sG5RqeqvfNuC5TYkLcAEzV4j+GMmAL?=
 =?us-ascii?Q?ZLD9aDf3RMVPYvJiWyDcRiE0+hRHoOn+Io24GVduzjjE4Wag5H0s0dEHn1A3?=
 =?us-ascii?Q?+WqVgvKfTeYMdpoqa2aqCp2X5s+69BwQs3A1/ETiLvGimQXzQnAHapdRMdwY?=
 =?us-ascii?Q?4A0V24/fMf+78gsRwrXqh3bbbtB28iHJxHCkK6wjBXIREOujJsZLoy9yaP4v?=
 =?us-ascii?Q?/LYHibtt6QxnxVuGd0aosdqv/1DypWKuVXfYk9w+ThdNSkaaZCyXOrttNJ7l?=
 =?us-ascii?Q?YRH5xy7dGiApv/rDUI2rrRAq2+Wvyqx75i8erTDvkHeWIwEGw5xxkTmFjDfq?=
 =?us-ascii?Q?319YaYHsn9Qtn9cAEVB0spp56/PMVXE7zwHNQ8gn87adzFUa441O6zLKs3QG?=
 =?us-ascii?Q?hQf9SMxm7IE50V76fFbheS8vceU3TmD5HceqATRI8jSnzEnjKXM2EmGcSYpx?=
 =?us-ascii?Q?mBQ93GU+nbYz+lyZVBKCou04+bGtyHOHZLnLkWtxcZDC8UStq0/khPQduW+Y?=
 =?us-ascii?Q?ug/VRrAELJfWho+Jr5OCejD/Y29slvY2Z/XVrDyb+tmYJqZSq+m1QP4hb9gw?=
 =?us-ascii?Q?f+tS6mVbf5DBJm83QYX4t3n/Rfx7cDwL44TZwpSf/Sufz5LYoRHktkmr4dVH?=
 =?us-ascii?Q?HiIqnJgytLDqlZh1YB/H5BJJ2RJJyVc0doI12JqIHeglE1DLjYw4PEYmHQkl?=
 =?us-ascii?Q?MqZRGqwY43r5YZku3NqyYDS0BzIeXkW+Di8hlQwBNc42FrlAXq4DQ8uRmkUz?=
 =?us-ascii?Q?VrCuru9JgiHUY1yuOoXcbNqmYh9VMIjLo++KQ6OK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a9d03-310b-4ed1-c3c8-08db8c1efa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:21:27.6142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T82Xt1XqKv/zejR4IKsP0O+lXI4B3ErxrmlSte69POXOppUfXtsCEFCI6LWeVjYtxSMvmGJRrPG9M3Kn8RkBo0K8CZvy/9qMDiGau7jgUM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7745
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Conor Dooley,

> On Mon, Jul 24, 2023 at 08:04:08AM +0000, Biju Das wrote:
> > Hi Conor Dooley,
> >
> > > Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> > > overflow/underflow interrupt names
> > >
> > > On Thu, Jul 20, 2023 at 05:52:00PM +0000, Biju Das wrote:
> > > > > -----Original Message-----
> > > > > From: Conor Dooley <conor@kernel.org>
> > >
> > >
> > > btw, please trim this stuff :)
> >
> > You mean trim the recipient list?
>=20
> Not the actual recipient list, this junk that outlook adds to emails :)

Ah OK got it, like above.

Cheers,
Biju
