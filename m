Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38A780E46
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbjHROtR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbjHROsw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 10:48:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1576C13D;
        Fri, 18 Aug 2023 07:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnK9945rVecDqBY7KUYz+eSYWVq8IO/WYV+x254jaRdmQj2dFUbwEV08e2OYe+yJyQ57m7R1N0Nmcyp+Mz3PhnFVQ++70IIeD/4sJbrTd32YuFzgmciZWf6x2reqpeVz+U3z8nLtkN7NHLonmmk+gpOnET9c6bk//6AhV9UthhVU2RVLUTmqvA18LnnGQOaZs3wgjFuqs6h4HCy0TtM3TlUq3CvteLKh9Ltqa+DES99Hg9zc9GuGLMjDQ4dUtMY7mbP5NNFz4/dgxcLchFX/KAARj5IstFg/5NMkD1wyWh/sIFl1zSXbDwAh/9Z2aJo8IzxmiviacXQNnvHmIvZOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR6ZBiF8iRXW6VUphG+wUljQXICeLVS7efsgwE6jGLc=;
 b=CW+SeZwgPplq1MFp/yk0MdOEsuD0G23QH5sL17MSkj0kv3RTFBlPSykfFsU96gHapDXOeF/xzNX3ro0wdep6/czQlUYA6UKBsBYrQdGpEKctbXPvb6QwCbrgJ/bJh81e1YFx4LyR50mHmPoU5tnTOQu5ytnB+41ciHnfBFn6XFHmC8bLqUMikFGc8+2U2MAGc/TwKbOTbjGXZALhmlg9Hg6I1jx5Vc2Nwmsl9VbqU+BW4p2JOdRS18KCCHl8Vho33BMrcOKfneZ2N/qVyYJGcAaOYo1xyBZ6KovLpjzglawYdN5fhra96SPIGhfoD/Nw9OuzPcBYjnOzE5O2YRvTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR6ZBiF8iRXW6VUphG+wUljQXICeLVS7efsgwE6jGLc=;
 b=jfpWBaT8UBm+01Zw1jmDhcpwntDfD2Wa/hpoFsl9CiumwxEhUkGKPclkpFNlAwaRI1iuzRcmd3ocsNzZrt9biQbkZcoGretqOXVJUqlMLzO7TaJuRpXKVhBSaooMMarNfdYD/WArS15FCnUKlbU2AjP+HGJHhdFqVOmadKhIgKI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5394.jpnprd01.prod.outlook.com (2603:1096:604:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 14:48:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 14:48:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Thread-Index: AQHZzO4GZ7D+A2SpqUSmNVzUIWA3Ia/q9ZeAgAU0ZGA=
Date:   Fri, 18 Aug 2023 14:48:45 +0000
Message-ID: <OS0PR01MB59223B11C14FE29FEE9CF080861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
 <ZNslJ44ivDGKR6b1@smile.fi.intel.com>
In-Reply-To: <ZNslJ44ivDGKR6b1@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5394:EE_
x-ms-office365-filtering-correlation-id: b4bcc1b1-2b83-48ef-932c-08db9ffa3913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9wbxMJT0MPTNaNxwDVepss2DBknUj+F3xvDyr2cnQiy/Y4B0xDSSW2sux+Uo9KsVKXo5cukNKoEefgIz3pS38y0Gj+/fUmPD6Rf7YMBn4tny4wlia8QfzvZall9IDMKx64sLM08ALhWaXnmEXiW3y5hlI3sfNiFBMMxqMjBRUHEQYa8cgBAB1cq8MmglRRLjcPjH0cXIyfUO4TiD4w9N+OIWihofo/p92Z0KH2fn3IQ36IRdxcYiOFHcAkuhrimkpnSaaxHka+Ino+H2csmUNFWkD/DYNgxxOkeZkl0sGTTUBYz37gRIZBGzxtkbneZ4vcqKS0fUepVYR0JOEyP6rFcERLOU5RIXX+t7bAaU0tL04fu0+0ntPrN33n56UXivsgXKwmoO4+j16FgYhvPLy+IUz6j1ZxlN9sQm2v9jqUKufzn0I0Z4vADuSMaf0JAeFEkkC/XS7u7MmM/Vahl04Ls2AExr+6f3FShLvE0Pi9z/jB8QYTIrKFQzxEr7GlCqw7+Xw+HLdoDmm0CXmhVgwQMw/B2QoK1atIVRmEu1s1tmdvJ3W0Q0QBBG0Kx0VDeNjxB/z7pSl0aH9AbAWwdMVgs0pPk81Dwk3Ie7ju4JKKneObG39grHgurCLjA+N+5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(7696005)(38070700005)(38100700002)(9686003)(122000001)(86362001)(55016003)(26005)(33656002)(2906002)(54906003)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(6916009)(41300700001)(76116006)(5660300002)(52536014)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h0ZR6iPXe3pIq0oCg6dZWierqque5rIuApudcv3O3OZ5hATqw73w5xokGi?=
 =?iso-8859-1?Q?rDuQS7TMY0NO9UFDCht/bU7wrEWStI5p2y0g4beXr0dd9QWDri/C1ispi4?=
 =?iso-8859-1?Q?DXNASprCaSBIBrfk6kNZLK34agAtHAOfnXzEZ0JqZ8wJYQU93rdKdjbfFy?=
 =?iso-8859-1?Q?yalP5yRnKlzwXYYb3Ai1DyTyH+Yzobn4OayhKTojg+tcvSGI6H+mje1I5b?=
 =?iso-8859-1?Q?yIKiMnyLk9Cr0mgX/q3opr856KYK90XoueIejS8zlsB1uayjfD8o2J23oH?=
 =?iso-8859-1?Q?XoT8KzxJAC2FZOeqF2jAfncLfLypt3zW860mJ4+vr8IY1C8BSgyLizyRLK?=
 =?iso-8859-1?Q?UsUW6GrU5wTWVn9P2EyqUDgWL91bo7A/eja9g+Xu+Osy6qwFa36vxci9nS?=
 =?iso-8859-1?Q?hCVOh8fsHKMbO430SURVOeKLvA21nwx4VVtTrpJDhrk1njsVUGRZ/gKCpX?=
 =?iso-8859-1?Q?YMLmnd6N+wVbTo/yQGOD4JilSLK14n/evgBVMkTupN6FVSRUceuuy7RWdE?=
 =?iso-8859-1?Q?Lm1u+LKlIV15940SI8Tz5pU0sxnucvIF7ad8YO5Lf/KSu+GWUxpl1zOmn2?=
 =?iso-8859-1?Q?IOw4D6TJIQR+1bDENARm6RpznpSw6jZP/ed73m/051PPyxrt7oTTlgOjIQ?=
 =?iso-8859-1?Q?EO8tk5DVzQi74ow0pu5xzZuspOzxn0wH+Unwg3nIEi2sktL1Ttqf0wzL9s?=
 =?iso-8859-1?Q?nNkPF2hEil+tBom+ksBTo/4otTe9+7XVfHBDZfCPBwujmIutSD/fFXZ/KV?=
 =?iso-8859-1?Q?ASkVWG9Oxneo7pyhwDstc+U7P8SrMwgXKEeQGSqSkchepnaT34lGVMuL+o?=
 =?iso-8859-1?Q?yA5XVzS8lAYuEqnzDjA1GEDiCMbZOZG//txyMyUsEig3mCEh29iPMFwSY2?=
 =?iso-8859-1?Q?uxn6N9UU25dqopyj0Mxb4NbpA5EFFMLv6aZXlU9wqxa84ShxVH+7kzxGzs?=
 =?iso-8859-1?Q?nnIaHO7IXhYWzThvMxv17n8aFlW7NDlWXZvsZ3vGu66A7oSSShJwPAZ4/G?=
 =?iso-8859-1?Q?eqwZwEuYmLz229yN8UmclCVQh540HS0O1VNH8N/KclvF7m3UJu2guOawVR?=
 =?iso-8859-1?Q?bpMblapZvWoJf4KQZL4clCv3Hyw3cO+WwspuwH98keaX7p3vCa0PDNOzH3?=
 =?iso-8859-1?Q?TSpYXwBfytEx0AtSw3icyQ8SYLtb2CYA43nFBqDkDWp1aAma/CZbPk0kEb?=
 =?iso-8859-1?Q?V4PU60zRp4duNx5FSL9QqeweSkVBT9UoGrsvBrwTY7//n+bnNd3Od5uzzi?=
 =?iso-8859-1?Q?cHA1ZI21apncJLX15zrtFMkAHAjY3Pm5yEnGqqBmuktAiJffb0awdjLGTu?=
 =?iso-8859-1?Q?2laB+foecBjrBoNFhrMC8eU9gW/DGudrV9yQNsLHdAEXzSNysXFfwZYT2G?=
 =?iso-8859-1?Q?LkNGKuEEWCusUv6DVF54ixRzAHkWJCei3TWN3s3WSRvgnnEU8KhXHs2L7L?=
 =?iso-8859-1?Q?v8PNHifg/4FyhViyw3tsbx+5Lhnbh69y/g8rr9pGrLhQJa8Pw1wRNOF7sh?=
 =?iso-8859-1?Q?bPcM7IUoOjcbPNcg/H1YTgNRCbneVbHqEqXkYeLrSxdatdzgjAyrmRgGrr?=
 =?iso-8859-1?Q?PAA1vUpWabs/yri3ZzkKGNwqsaedCYrz8QW//2p7fZliqqa7ulOFZqoEmZ?=
 =?iso-8859-1?Q?qQ0pgIc8s0Kmtlq0USTuoOvCf8qlVa0ode?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bcc1b1-2b83-48ef-932c-08db9ffa3913
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:48:45.0731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jS1QA+4WdFvQXKkVokTB5uMlzLUx1k/4MBCWkHXrdDM+4duL9ieyRo5NIEf8VogdGuM6mmiYHcon20bpX6MtRC8Zt5bx9SQIlLBza+kYZOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5394
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
>=20
> On Sat, Aug 12, 2023 at 08:24:19AM +0100, Biju Das wrote:
> > Replace device_get_match_data() and i2c_match_id() by
> > i2c_get_match_data() by making similar I2C and DT-based matching
> > table.
>=20
> ...
>=20
> > +#define MAX1363_ID_TABLE(_name, cfg) {				\
> > +	.name =3D _name,						\
> > +	.driver_data =3D (kernel_ulong_t)&max1363_chip_info_tbl[cfg],	\
> > +}
>=20
> Just use them directly, like in 4 lines each instead of a single one.
>=20
> 	{
> 		.name =3D max1361,
> 		.driver_data =3D (kernel_ulong_t)&max1363_chip_info_tbl[max1361]
> 	},
>=20
> or this, but it's almost 100 characters.

OK, will create a separate patch for this change.

Worst case, we can drop named fields?? (.name and .driver_data)

Cheers,
Biju

>=20
> 	{ .name =3D "max1361", .driver_data =3D
> (kernel_ulong_t)&max1363_chip_info_tbl[max1361] },
>=20
>=20
> Otherwise I prefer to see something like a generic macro in i2c.h
>=20
> 	I2C_DEVICE_DATA()
>=20
> (in analogue with PCI_DEVICE_DATA).
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

