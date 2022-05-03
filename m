Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA348517F1E
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiECHuk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiECHuk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 03:50:40 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA78201B0;
        Tue,  3 May 2022 00:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO9geryNy4J/qnVdCvOaE3en89PNvJZAnonRD8iriyaItUE2l0bXKaFU9HIUs3Q5EdCn6z06GbDTZywajwZ8inqevt6kPdlbpL1dF2JBiwMwA/uoaT89O0B6Um7osAQj7aSXKlGPgPSb9iE2A6np8uHQnXsjaLY6tcnPdN0ZFL/GbKLgCOOs2gm1bXbTHROe7yYhiqz9Wro8HKdPQRoHvgXVb/cjMdnDkc/bk2MHQ8UheQeRNmOmXEq/WRxoeAqV61qZeTiqFjoPUDBHZ7poi7AtgMyWU2thuHKBinmlJCj8V0vmK3i6ccsIN7N8Jd3zqzMJ8lwSAUm5P0gMLAPWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSYmjJxbvHYpW4NrszJquwJwF6CYAVutD3+WlD64KFY=;
 b=VM1X34XyaSOh9KuYlut1ksXTLes2PJA2zj9DxsD1fhZBCxI++5YU4KRLHjdOoOl/evxMUy2ngU2lOjylkEbM8k435Bgnou4xOV2d40SHVdkA7VE410Wxh8H1HqQSv6/a4sph1NHn7iByWKxz9sDNK25E58uFfBtPPhoGX/ZpY+574nKFUHB6vccoXLo0Q6/pvdn9Po4YVtgYSHOo7mm7ePJ3KUQtJIHD4CmNhipOuYXMYZmDlCeVjQQlcPK0dAuwkpaH6FaBfdlPlPdM+paujjC8xJfRSooapG+D845VXMLkSznwVxGtrUBmxMLJvfRQICrGNzHMuewHtrz4qVXa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSYmjJxbvHYpW4NrszJquwJwF6CYAVutD3+WlD64KFY=;
 b=Q7GNLBnLW0Pcd8Pp5NfiwI8O0o4fuWCv7zQSNQJ3AWv8gFHSOClpmIC4GjrRfecKi1GoXnaw1NjiAtXCay2xr7kPTZIQijGbRarwnfJsbFovTcYlcEjAt/ahIj5r8pTnRzDVKeb92Vtax8IbrbTieHIBXTvn1oiHUfCdEfjM1NU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8023.jpnprd01.prod.outlook.com (2603:1096:400:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 07:47:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 07:47:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIABDTkAgAAC7gCAAArkAIAAAkrQ
Date:   Tue, 3 May 2022 07:47:04 +0000
Message-ID: <OS0PR01MB5922BCC070E328A9B5AA6AA486C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB59222A7FAB923579C21D6B6286C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
In-Reply-To: <CAMuHMdV5F9RMyKbqV=zUAhH2UZuRCoc5Y+WC_GNvG5JioMnFGA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2081bd64-2f07-4350-a819-08da2cd91dde
x-ms-traffictypediagnostic: TYYPR01MB8023:EE_
x-microsoft-antispam-prvs: <TYYPR01MB802367112CF27881C8529D9286C09@TYYPR01MB8023.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGLO/c6l5IazjMyaMEZUHSj8PRD6rqz0hvCjFBQdOtu2caGgPir6yuWZY0nDLAuntV8Q6ZJHn7f5MyPr/Is46OgjmQZGPtLSQitZZUGzbhGCaomHyJcP+VRRX9cMlUo5HeC8scqZ5x5Ela3F7qcwI0j2haFnkMQAoU4SqFFxqui0PGA/RAFPLaVCQtb5VXCcfBckkr51o3+L4P+P+rwLqmPxKZRgakyCuFIdd93NToINAgofT2gpWKRhwwQ9rWMrmPgFwbYsMGhiW3XSujXCs+VM73X2o2+GFzaB5MUv5VEw8Uaeh8kdFcd2GVrq0odzTvSuI6QCFwLf/4WdVk88R8yl6hVcTAYWDGgSHL4fpxZA6IaMHcUrALXLIswzbnLKFxJa3cPhw7NLLSvlaUdynRA7JMqOf9Shj6kDGEylxZ0zf4ufK+fiZpnyLM/0XFTqKXwjLhOK2QwqqhWnqHjZ7aSYiK/yom65/6ChPC7KG8xfPkH1G06Ua1Q/1x+gU4iKadmv6a7EVy/Ha9uK4yWco3BoHWMWkym+qKhESCLPNA3QSzTfD9+hYA93vojTqnmLlSrLpw3DUwsm4g9gH0jtJAvqvoof2UJrOsJ2vINtamHZnSpYBkXQygsqAsRU9dg11iTY5SpxzWiegXaAFdptJ15UyV5kUDi430JCKopePSiGg1U5wZbRGhg4V1E4ezLuwsaqrOfZBkU9O/oJd4mZkBy7o9hfoojmamBpgOIjhbyw1bw6qgKjO6aGLog7bst/LG4wQWNVs7VZDMEEAwtOTBbZh1D440d8VRRcNhG+bgrGUutgktbnJ/uqrzPPTOwH3BhPE7GD2uJHhiDbUZV2xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(122000001)(966005)(76116006)(55016003)(52536014)(508600001)(4326008)(6916009)(86362001)(107886003)(5660300002)(8676002)(7696005)(64756008)(66946007)(66476007)(66556008)(66446008)(71200400001)(38100700002)(316002)(38070700005)(26005)(2906002)(9686003)(6506007)(83380400001)(33656002)(53546011)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?raPINYrICpo+LT1jl61P56r3ihcKSzGYOR+LfkMww/1XZL2O2oXoapfcJ6Rc?=
 =?us-ascii?Q?MHW5CCVNLiQjvAQGm+uqYvgPAG5iBTYQWjgztFsbpPkPE89081Oq901sP67R?=
 =?us-ascii?Q?8RrfoofmkK3kM67/S2wIAqONq8nsRcp8UvZcs51NjvSvODXJiSX3vPfXA7jU?=
 =?us-ascii?Q?4E6i756ZHfyeIjVgxirqNfsGeT7uAC8j1wAf+dabhujHKeQ5Ix9pdkez/4Ug?=
 =?us-ascii?Q?oBtQfq96B1//KqaqzkZjQmHrDbWf570Y/ovBYJedD+26VUQ623WiL6Lnyzzb?=
 =?us-ascii?Q?U4lRfSpEslQy/1ZNwMJjduEd6AscBqAJs8cWSZesY9nZxcosJwxz8doDNh0Q?=
 =?us-ascii?Q?CKrKdtazMq+gQvIzEMkMVcPnBFk31gbn6mMMhHRkDcYRym2lFe4AP0VeIlAE?=
 =?us-ascii?Q?nxMUjMpREsV1glF9ujGLBOym22hwv9+hcuQFT+wPsfJakau6dG7ojoNg9o72?=
 =?us-ascii?Q?vdGzQm+fsfo6DCSA7geH734USSJotCv58R9je/rP+pNmQ9lKcnG/+nxXeoF3?=
 =?us-ascii?Q?ejVm1lzYE18CV3x4ATGhlNu63eJJJI+AOjX8WJhEq6qpZy9UOIt4gLf64Bwq?=
 =?us-ascii?Q?irkkFNtjP10LsLx6JufQK0ueOtmbrNK5nAEle8a5TT1Mh/DVvP+H1D0RP2i0?=
 =?us-ascii?Q?aGzXWJZ45exoS+OrbIjKzCd+1p1tmmsB0N5rqEq68SzVxLwOzJD8BXzW00VH?=
 =?us-ascii?Q?n0NKr8J9RB6xuECws4b3d2SlZJBtLhJ01d9UK3l4j6SYUeUsVEhFJqZJTIGR?=
 =?us-ascii?Q?hQoa0JjQTe2+QMg5hCm36k7FbrlCYd39IRCB7KdxBS4xYZ1cxpuexc6SA2U7?=
 =?us-ascii?Q?0fEKK+1hAejIAhNecpZdks8r1ApVnE7Rd//w6p5CuTHEpL/RwgTW2frT9qCK?=
 =?us-ascii?Q?reznZcpMgHnPshtWMMP+XPx8WXuhfNJ2E4N+RlYkRxY88zTHvO+gmgC4XCYc?=
 =?us-ascii?Q?ibXUwC8PDsCvHoJsiPqa4X9tMjewRh4c9+S02RyuHfPtt8XA2/VbQv+wtRAT?=
 =?us-ascii?Q?eelICit9CVfWUMUOSXmbC7k+Xaj+2DIdln2EawtFTUj+bLTksjAVz4+LlIYv?=
 =?us-ascii?Q?VldFuSvzsqC/8jJKD14R6DwfKnh6m359v/16Jq2Mcv6gK45H1Oe+4Cyuevx6?=
 =?us-ascii?Q?hdeI7SEycBVkFsKYq2HPNPkCYIEugYQNr2VLD1JxkmuEpkq+gHBHh96w9k5x?=
 =?us-ascii?Q?eY7DhaVfLRdxRNPLJxf6NLyQtro5dYmzgcaqJQmim7dsXTJsMfLYbV7EvZjM?=
 =?us-ascii?Q?uV9DxyLnaXCs0bIJtA+evplB9Pca3KWZX8FDZkxzzpMQx6OvaQiPkTVKB2N5?=
 =?us-ascii?Q?g653qvzAxgSW5+nW4WdA8gpF4sJW4YZrfEFRl06lPeW4S/R0vlMzGDEWR8S8?=
 =?us-ascii?Q?7UshbmjfvNmL9ptEj9WyHS6yDGk9i9M2fX7YW9r/yoqI2nvAiXJMcArGnUmc?=
 =?us-ascii?Q?yNOxZE0ueq31aU4jHA/5EeWburTY+JDYw3odkh49kE7xBgqG6Clk2s4VmlbG?=
 =?us-ascii?Q?tbjBiThScQf4BhmPbcNbtQoPProKAMH9vpFwdCdyQxFCYrLN75thPR2aJo0i?=
 =?us-ascii?Q?bN1oOKwFMrOEGiO+ORU4m8JcAOlAt8yNoFwYTmKVxxMNAKiJDwh96R/ahNLC?=
 =?us-ascii?Q?iaBHyc8QLRay/Ku0L8Qa0j6KlhV78dS1ERR59+LaF3/U1dWUNBy2h/BQ2Px6?=
 =?us-ascii?Q?/JFUUA0FL3nSr4PheaELphGumg1LcO4keDNBOoePZ/yOTMC3wgs+/bA1tI20?=
 =?us-ascii?Q?vr8dveoLytQNlHzei3j13Rj8QrSJrGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2081bd64-2f07-4350-a819-08da2cd91dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 07:47:04.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWWJyjjEL3r1j6AdMcOKdwAo+ZdGiIgW31Pktt6uYW0HIlAQt3Xlo6Q/Gr2Pj4XEirw6EdbnmJXRqSnHVuO0nRkpUhgqIG4LLqiimCiTDR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
>=20
> Hi Biju,
>=20
> On Tue, May 3, 2022 at 8:54 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > > Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL
> > > > ADC On Mon, May 2, 2022 at 8:18 AM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > > Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for
> > > > > > RZ/G2UL ADC
> > > > > > > Subject: [PATCH] iio: adc: rzg2l_adc: Add support for
> > > > > > > RZ/G2UL ADC
> > > > > > >
> > > > > > > ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC,
> > > > > > > but RZ/G2UL has 2 analog input channels compared to 8
> > > > > > > channels on
> > > > RZ/G2L.
> > > > > > > Therefore, added a new compatible to handle this difference.
> > > > > > >
> > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > ---
> > > > > > >  drivers/iio/adc/rzg2l_adc.c | 18 +++++++++++++-----
> > > > > > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > I wonder if this changes is really required. RZ/G2UL can still
> > > > > > use the "renesas,rzg2l-adc". As the driver populates the
> > > > > > channels depending the number of elements in the array passed
> > > > > > in the DTS and not always 8 channels. For example on Renesas
> > > > > > SMARC EVK only four channels are populated.
> > > > >
> > > > > For me that restriction is coming from board design, as SoC is
> > > > > capable of handling 8 channels, But board design allows only 4.
> > > > >
> > > > > But on RZ/G2UL SoC, it is capable of handling only 2 channels.
> > > > > Other
> > > > channels are invalid for RZ/G2UL SoC.
> > > > >
> > > > > That is the difference.
> > > > >
> > > > > > With this we don't have to differentiate RZ/G2UL SoC if just
> > > > > > add two channel entries in the SoC DTSI and the driver will
> > > > > > just create two channels.
> > > > >
> > > > > > @Geert - your thoughts on this.
> > > >
> > > > It depends on the meaning of the channel subnodes: do they
> > > > indicate
> > > > (a) the number of channels present on the SoC, or (b) the number
> > > > of channels used on the board?  The DT bindings are not clear about
> that.
> > > >
> > > > arch/arm64/boot/dts/renesas/r9a07g044.dtsi lists all channels and
> > > > doesn't keep any disabled, which suggests (a).
> > > > arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi does remove
> > > > unused channels, which suggests (b).
> > > >
> > > Yep its (b), since the SoC can support 8 channels the RZ/G2L SoC
> > > DTSI has
> > > 8 entries, If there comes a new EVK based on RZ/RZ/G2L SOC
> > > supporting all the channels so this holds good.
> > >
> > > > Is there any (perhaps performance?) reason we can't just use the
> > > > number of channels present in DT? "make dtbs_check" can still
> > > > validate this against the SoC-specific compatible value.
> > > >
> > > Nope performance issues. That is what the code does [0], It counts
> > > the number of available channels in DTS and depending on the count
> > > it populates the ADC channels. So for RZ/G2UL if we just add two
> > > channels in the SoC DTSI this holds good and the driver shall
> > > populate only two channels. And as you said the validation for the
> > > RZ/G2UL SoC for just two channels will be done by make dtbs_check
> > > and in the driver the condition still holds good 2 < 8.
> > >
> > > > Do we need to know at runtime both the number of channels
> > > > physically present and the number of channels used?  If yes, we
> > > > either need to use the SoC-specific compatible value, or add a num-
> channels property.
> > > >
> > > At runtime we just need to know the number of channels used on the
> board.
> > >
> > >
> >
> > DT describes hardware and here there is a hardware difference 2
> channels(RZ/G2UL) vs 8 channel(RZ/G2L).
>=20
> Yes, that's why there are two compatible values: the SoC-specific one, an=
d
> the family-specific one.

Agreed.

>=20
> > Krzysztof Kozlowski, wants to take care this difference in dt-bindings
> by adding some validation checks.
>=20
> The maximum number of channels is implied by the SoC-specific compatible
> value.
> Invalid channel numbers can be verified using "make dtbs_check".
>=20
> > If we all are agreeing to drop dt-binding validation for channels, I am
> ok with that.
>=20
> No, I want to keep dt-binding validation for channels.
> But I think the driver should not validate the number of channels, as thi=
s
> should have been caught at dtbs_check time (and won't work anyway).

OK.

>=20
> > But from driver point, still it need SoC-specific compatible value, or
> > add a num-channels property as there is hardware difference
> > RZG2UL_ADC_MAX_CHANNELS(2) vs RZG2L_ADC_MAX_CHANNELS(8)
>=20
> From reading the hardware manual, it only matters for channels actually
> used. Whether the other channels are unused, or non-existent, doesn't see=
m
> to matter at all?
>=20
> TBH, I think they're really the same hardware block, they just didn't wir=
e
> up channels 3-7 on RZ/G2UL (see e.g. bits 7 to 2 in the ADM2 register,
> which are not fixed to zero like the upper bits, but have an
> (undefined) initial value, which must be retained when written).
>=20
OK.

> > Currently driver validation only holds good for RZ/G2L SoC.
> >
> > See [1], [2], [3] and [4]
> >
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/iio/adc/rzg2l_adc.c?h=3Dv5.18-rc5#n324

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/iio/adc/rzg2l_adc.c?h=3Dv5.18-rc5#n340
> These can be dropped, as dtbs_check should take care of that.

OK, Will remove this.

>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/iio/adc/rzg2l_adc.c?h=3Dv5.18-rc5#n263
> Looks like this condition can never happen, so the check can be removed?

Yes, it can be removed.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/iio/adc/rzg2l_adc.c?h=3Dv5.18-rc5#n293
> That check can stay (RZG2L_ADC_MAX_CHANNELS is the maximum number of
> channels supported by the IP block),

Agreed.

Cheers,
Biju

