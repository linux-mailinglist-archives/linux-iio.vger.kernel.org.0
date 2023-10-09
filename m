Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2F7BD3D2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjJIGyW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 02:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbjJIGyW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 02:54:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10DA4;
        Sun,  8 Oct 2023 23:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfkzCIXxEdv5+P06kzJzEec9HwiM3LO0GN5aceaQ9Q1K7FKLDtPZhkuxqDi9Rn7Eex4Vh8rGAh+T/5zZXp9drt9sqOk2n5DM+LpueqOwUoYz7bA7VmEoE5+4D2X1V/8O65TsQG2fI55bJHjBzCoxpizVVp9LN6zDYHFJrc553b4tWIPasdqRPdS1YhRwi8PMrGCxoeDqEz3/J6y48uOluVuoWr5Ytgvk5vakyvi0veTmhhYEOeV2G3Gb5ke2w5gOT2/hXPxKRMPF/odTKvwyJFqLuSP6AdAGVAHj0Hmr8xER7eZ7HzY8EFKr2vxXMHdaWdvSLRktDMpLBkttzLQzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVblxFsy2u2qc8GiTrkrEwyLK59HxPoB8fIIUE0n1yg=;
 b=Tf9GA8ic+DD8dZ6PTshGJQl8nejuUrCDWsA61z3VQRCvuj3iEpMqZgyOYuHw52H70zDMRdGyzocDc9UPakYdoxeiZZ+LqnDwldcznwz1RBC8it3b43o/L2PZVjg3T0R+WWPfo4jKmPr4VYJ2FzXiqyFhaivWDHEtjtG0KEsJMzBkd4z/4Eq/fZi32Nv334R0pVrRRKvFdmF2qXPRvpPv5QZpI7ZmpNdk4Xq22/C8omYIblDmbGm108LpIXLiQYvUKHqT2LyhWq00GzoL2lJE5EMZ5LPxHk3JiF+NGHUnpYexiCqEN2RTMW7LhSkXvkZyJvC3ggcQhcrbukMZtAG4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVblxFsy2u2qc8GiTrkrEwyLK59HxPoB8fIIUE0n1yg=;
 b=ktTZSXo8DAb2M48xWrqcvPXZLQe/DEmoJMkCAv/2H/UbOkyOSjM3koLH6wRhGithcaOadN2SoSSYXueXfaJz+I4NlzhjGIjke1AhI3WlFWJye3wSB13KPTIfytAERFDg4Eq8zviG3INaeujhTFPrYl4nyh6zc8kQ5y51VX4BZgc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY1PR01MB10819.jpnprd01.prod.outlook.com
 (2603:1096:400:327::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:54:15 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::db75:e192:bbfa:78a2%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 06:54:15 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor@kernel.org>
Subject: RE: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Thread-Topic: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Thread-Index: AQHZwGL9ceemCZ2jGkW1QY8DTieJS7AEyheAgBvCJQCAIOwA8A==
Date:   Mon, 9 Oct 2023 06:54:15 +0000
Message-ID: <TYCPR01MB112697D67514D2E6FC690B9F886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
 <20230831-iphone-muscular-7442cda2c39e@spud>
 <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY1PR01MB10819:EE_
x-ms-office365-filtering-correlation-id: de7a98a0-84c3-4697-f5ad-08dbc8948d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbfiatMLwzJrQT8EYdeTVXlTqIGuGw1+2jx1/mKvIh2tjPzbMhS/OlxQnqNxtvlWI5YpTOz5Bd6FfaAqfDsccZ8Gt1syjQjbjXADZOuXpgO2TnI3ExquDZ87ITcvRy6RQtKlGTXZWcCVhaIFlvQIN5FI3w60WjragfIl3KwX7/K7YjE82icPATq3RUvkNUs9fRzyxpmm2gTXw+BsPzy28sp8kClbvJtTFMU2b4RdHkLQYnxdL6pC8bK6zdn+abb98tfHIxpMfA2+XlXCrcklTvxHmqrmgkviETqDsYP3rERCwqm2eaIy6E/poYsmwYYZuHInuvfePIxn/6CUS+9bOui3dR5bqQmvFoyY4IkuAD5k3ohtCHxXvovByBqabau3HFXyO4QdwETpT/cUvTeLzUBy361v0fnlwu7kcIA7ONolitB60BjY9uORHNkXNyjDdIi8PUWEEKc94uat1FoEYH3Zq9fpxqWW+GAinW+AyYxRZOJKm8CNNV/aeSRJhKT1/YHqhCmQLpP+CttPfO1l33rTMM6fwG+zYdaRr9SMfcWUv9bO7Fy62t8G1lbE5X9prA7sArvgFHn1UfQLcQ6ZkRJXzaE0oPx7SSzBip8JLrPI5lx4qlLF13vEJifqk6PReK3AjQznns2s3dxBuBm/6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(76116006)(110136005)(8676002)(8936002)(5660300002)(4326008)(66556008)(66946007)(54906003)(66476007)(66446008)(64756008)(316002)(52536014)(41300700001)(7416002)(2906002)(38100700002)(38070700005)(122000001)(83380400001)(55016003)(9686003)(86362001)(26005)(33656002)(478600001)(7696005)(71200400001)(6506007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OrRCJ4/2RYDWpwW+ZCaLs5dzydccwYRWcbeNHuA5JwKdDN2B8U0NlPOZrG3T?=
 =?us-ascii?Q?mhPlKL55tjYGAISMkmLfK/1SYIOOFX6No12K3Fy2Ng3Wp4cbIwHYU8/boR2w?=
 =?us-ascii?Q?lzAKcaMGFzWl+wsnXgucJDaDw0cyH/AHDkWaAgfaJlaq8E4TnVLmwJYB5R1u?=
 =?us-ascii?Q?4bknFR6pqXGZ2/9ZmEed7DyxNz/wuOvG7k0QxQ8fdo0MDcTe7rDOkaYr7tn/?=
 =?us-ascii?Q?QMB+lBxC1ncN/ARvcrHbsRQCQZU6lUN/ggBbWUJ2k/gUy47cFj/+eU7ecBkh?=
 =?us-ascii?Q?MIj47UQWhlecPoAtNSan6SnLPZNYldjTKgMKiNcudLIju9zI2W8KMm+Z8NGo?=
 =?us-ascii?Q?8AyfTGkpRreX3c0obPQEeoR/yO5bDG7xM8EJ91426S20aNhEJa/uEx+jqX/w?=
 =?us-ascii?Q?vSy5bfflEae0Ttfdc6WckFHktIplmXar+FAytUug3o2JJiuvlPsSxmLW8CT8?=
 =?us-ascii?Q?hpcPhA1QdJUSdJ6KK686Pzm0mmjW3amkipNp9F2aqKUTtmb7Oti4JRHCR6tQ?=
 =?us-ascii?Q?aQUCgko1szVZD7wj8rbc4bvdWvXm8LmrCjlhVjCtckqmo/8V4K622xE05+y2?=
 =?us-ascii?Q?0L560k7xbLPR5C/Tj1sttJg3KRRp9fJX1vrjjpkdbQrKvMiriNk+Kx52RqYy?=
 =?us-ascii?Q?5nhVzrwF97VmQfmkBVtPN/GaZbpLP3MGboAgU3UBJyF7DHb5J1tneyI0+rJ5?=
 =?us-ascii?Q?a1tqCpupcOCaEfpCLTbFSQJjcZtwtAX9ewWb7aPMsZjbMQFm5TujcAxLpSvW?=
 =?us-ascii?Q?UBakgV7YSWx0ESMCv/DmsyMTl032AYfrJyRsfOvDBQ4aiU8uBLgSajpyv7K/?=
 =?us-ascii?Q?V3iC3I0Ih2cW2TbCT/8JM85Vopp2mW5bBgvPG1ruL4vvAXpQk5IKFIvV310R?=
 =?us-ascii?Q?jrjjRGAbP4AVgSdKN2MzIn+R3ChsFshbEIU2sURszCgZwJNLuqjGwpFI6AxP?=
 =?us-ascii?Q?pNvS1CuYHDEIeQjj7OXPhlL3DErSsGR1q7hczLI6lCoi5V3mF0dyugYhka1j?=
 =?us-ascii?Q?lGZTJdCEGD6PNGKl3h6EtoW4+I+o6RMDHU6C5ej8ZRtMAEPPZPI1RupZdFkf?=
 =?us-ascii?Q?Y45JTfuneG7iV3TwrQ1pIetzjAqESRy//b3Q6hkd1WQW6UTYTK3shYod3Wke?=
 =?us-ascii?Q?N/lPXAPNgTivREMEHxpbFHa+K7ymuXmfWKaW+BzQ4faq9MkKR/E/+VMpGxvE?=
 =?us-ascii?Q?ILV4vgY8rJ+FcnygLGagzU0/rTdi1pEbHVWMiy3wOC9wdUsnG9gl/93pSJhf?=
 =?us-ascii?Q?uX0Bkuqs40wSy5Q8q+J+CtwfuhnHsxvRUSP0HyraAbzubBsB6Uk5emvAj9dV?=
 =?us-ascii?Q?uFuwz8XqmwY0oH7LpjU0hV7PaQxBeobFc3M0OqI+8+i3ziyBzEZ9Ull3RhUC?=
 =?us-ascii?Q?UuVaZY0vyWLBl443MRAwOP/ICBpsTsjx/i8weEx+VYF55BUw5NeZ2+XyQNBp?=
 =?us-ascii?Q?DDQijLhrgderfQDD+leXe0p6cnLwe55T2XQR7mf659f4bKyajlY3LpnAgM0p?=
 =?us-ascii?Q?1VE/gHz11y5a5nU4OPABUzSSQr2TlWwWSNDzyEx4pD3XqNOcr71Ee95pcno8?=
 =?us-ascii?Q?SEd9RcHzttQImIxLH0KVFsRoOZuob0qNpDaZTXibW6a5r38DXBVt2GmvCnls?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7a98a0-84c3-4697-f5ad-08dbc8948d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 06:54:15.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNVVwdEc7iOUUI3F63R57fUrJE7fXiW0kYtDxunqvCWOwVu1aSuwcA4PcNskW6kaComMmYZ2tPEM8NQJusS10/V5e04f9fw0R4ptHKRV6Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10819
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

Gentle ping. This patch is in the patch work for a while.
It is acked/reviewed by Conor Dooley and Geert Uytterhoeven.

Can we apply to mainline if you are happy? Or do you want me
to RESEND the patches? Please let me know.

Cheers,
Biju
>=20
> > On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
> > > This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
> > > Also it fixes overflow/underflow interrupt names.
> > >
> > > v2->v3:
> > >  * Dropped patch#4, as it accepted for 6.5 fixes.
> > >  * Moved patch#2 to patch#1 as it is fixes patch.
> > >  * Added Rb tag from Geert for patch#1 and patch#3.
> > >  * Updated the link to lore for Closes tag for patch#2.
> > >  * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
> > >
> > > v1->v2:
> > >  * Added Ack tags from Conor Dooley for binding patches
> > >  * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
> > >  * Fixed build error reported by kernel test robot by replacing
> > >    GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
> > >
> > > Biju Das (5):
> > >   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interru=
pt
> > >     names
> > >   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
> > >   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
> > >   arm64: dts: renesas: r9a07g043: Add MTU3a node
> > >   arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3

