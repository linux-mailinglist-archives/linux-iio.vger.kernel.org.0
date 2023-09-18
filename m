Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEF87A43DE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjIRIF4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Sep 2023 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbjIRIFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2023 04:05:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5913BCC1;
        Mon, 18 Sep 2023 01:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3SEHBCTG/OOkSX60XDkkFC8Ou5/+1O0gXdmgMGFjDa9K+KzSkuPjTxSnMszQHPUUN59/OpZOibT9IATJoPRaRaZIMJ7feTo50faRtkiXldhHajMvPv+/HCP0Fpd8+FOPAAtxSRJ86tMsQyOp0qwqfLegQs+CWKOx02wlMywLRcTGQbjd+FHz+xW5KF7EbLM4xq9JXP5xxT7hgpFHto3r5zaylvgTMBFckmVay+29emN2m/FE0Hl7iotdwjsn5GxDoh4IRWlRylXOpnjGPd9Sflw0l77Yk68FMVtVk3+1kHO0/XVTl1l7ZwBTXfBZrqH8zicsEUiTM+1CY1ETSfqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx/obpn3REsMTntLL6VASLqFAq1bXrebuVA1Hwya1ZM=;
 b=T2zMGOcrBFA11aOndd8aa+hrgMxtcVjLecqFAaevS5wESnCmpb1BoMcfk/2zIjpSnDsdnZU+4t/vOtKelRW+QUQTRcV1VSA4z8hpX7LCQJY5tSzizNprtSXik72ISmx+ZItRIuaKGDPFksUtbdO/zF5YvExrabAgdkpJJkXmldr7X1KGtK2e/YdlKrdzTU+ljCmn4ViAMDfItyXnTZcPGgYZRd5ZB2phbySm24LerCXkuAYC7lWUXxwO/Vd8NA3jP0P8RQdR2juJtQNhzngh2xCiuLcDVVqFvR93wPyp/HcxHn0qA/R7+85ASX4y5NtVzIb0HEV2YRcz+fPkcTuyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx/obpn3REsMTntLL6VASLqFAq1bXrebuVA1Hwya1ZM=;
 b=U/nj3ZFmw9yPmwCwxo+JC2/Zcgca4MqEppldQC8CWkhZz//1ujZNzE6xd8H/tfu+eYYfFF4xH8Az9a1u7a6IuSgiP8WUS97G/Ee3YoRmLk3VvgH1VKsLb00sQrS9aFoU9pHZbS8Enuzgn4DMjiPbgJfoCSb56i0Qh0BongyRqHw=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by OS0PR01MB5826.jpnprd01.prod.outlook.com (2603:1096:604:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:04:52 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::8e13:cc46:2137:9b03%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:04:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Thread-Index: AQHZwGL9ceemCZ2jGkW1QY8DTieJS7AEyheAgBvCJQA=
Date:   Mon, 18 Sep 2023 08:04:50 +0000
Message-ID: <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
 <20230831-iphone-muscular-7442cda2c39e@spud>
In-Reply-To: <20230831-iphone-muscular-7442cda2c39e@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|OS0PR01MB5826:EE_
x-ms-office365-filtering-correlation-id: 1d0f9eb6-35fe-4c8f-ec8a-08dbb81deef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtTSk8ONDmdN5E6DQg0QLJYrNgqKi/wFnXWJI+sQgRoga4l5FN5yqluGSwdO9jWWaJDA8/ZqvK8nDm9SGnd1vKFpgeT5bd2lUiXU7bR/AarpmwoGVcqep4VNcWYNZUqjSKQUwftxI1rJqNyuHssDnT5qMQHVVBf1RI1iP7KVD69OAohO86TTChew0UG2GFEKCzzAlsX1uVQXhxt6CH8MwtUVjpiCh9N9vsEWnexyVuHnsFME7tx5/qZuDlGFMWLX+r2qNjg0vZLSO+5GUz+mO8DTFkznZubrm4dIHvfWipGRbpJPFHbpP7DRffvynYgHPrqve4e6p0Ag/6XUVB5U3hU4PCQ0A1TfQ/srkTO4PoFZlY/DkfZYiIe/zo+qD1r/zuEBa0NqcPpGPdpVj4BlNKIi9DS0qICCyxBZKQLAsAMB2fkuMR+qXOkuUJPGA5IA1yVcKuFmbJELRz62SwcsL3nDLK1UKLliRhXbAxn/sdThMmg9N/xON1XGF9rS1G1jlKZevPIlglMmMkmD6jHvjU3pHSeIkbprYzzdEUDX3nY/EFfI2LpOC280dl2+bRN1HSqCrtLyp2jfUz+48ivhD6GijrmrLM8FpSll2StiEfpQNq/sWsABnbNka0fKA+MBdU1yfPoBXgSDf58BbzDMhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(1800799009)(451199024)(186009)(76116006)(54906003)(66446008)(66476007)(64756008)(66946007)(122000001)(316002)(8676002)(8936002)(41300700001)(52536014)(6506007)(7696005)(9686003)(478600001)(71200400001)(110136005)(83380400001)(4326008)(26005)(7416002)(86362001)(33656002)(2906002)(38070700005)(38100700002)(5660300002)(55016003)(66556008)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xz3a1YAkpmW8fdzA+GGOJpjeZOkMlAUK8DIIeBICaynMRHWUeloENa1zsC0v?=
 =?us-ascii?Q?j7HsssIzNBQqltiYa01mHPCe5rXCfUhUuGSXvv+ZM4v3BW7U5KPWbK/wd+jh?=
 =?us-ascii?Q?xTHpHToY92bFfP7phFD9o4AqJagMpuqxq+IpnBHYSaY6nwmd+EeKuS4392HU?=
 =?us-ascii?Q?AgAlJVTau7bOcoCqhoB+mVcGY4C7PTGPMSRPW1QHXOP1c07J3FRW3c5a7qpp?=
 =?us-ascii?Q?o3c5WAyjY5nO8kqEcn+sU34sdFi/xfvszNRMVVpX+KiB8iorNxwvya3bUj7H?=
 =?us-ascii?Q?beAT6RChJFLib7uTpDJes87vXR0GMccQDya3kmnRPL3tg/aU9D7kNjOBc/Kq?=
 =?us-ascii?Q?lO+oE81IqGl0yDRSyc5C2wZ3DkCEJIX3V99TO2jGovzeJbXuees/Rzjm6hp7?=
 =?us-ascii?Q?g+T6bZ+9gsTjhEkKNEI8QY1SKVC26FBLyFlXOLLVAlHj0ety/BFkyKYLHEXh?=
 =?us-ascii?Q?yjtpPjUk1ccbNf8qnl3Zo56A+Ht1UQP1YlmcpVwGMdyS1U2HAgLzpvYxStLB?=
 =?us-ascii?Q?5QTpi3jG1A4kfiDF1nG4x84THl1CVvLAmZNjuuj03wzVDPZmg+xI3AU+hf84?=
 =?us-ascii?Q?8bcT7PV81s20yAlRDwOYYk3Ux6ldFg4nULm76il1K2gh4ncai26Qjw5LpjsZ?=
 =?us-ascii?Q?zSvYIqLAAVDbzOG6PtKZCs8OXFI1VQ4Qbys6Sn8t8Q1lIe0hNuSohNi9uQMW?=
 =?us-ascii?Q?RRUg3hoQ7vLoPnjgZGPnQeEHMHYCEY9dHkY/3uFOqbs6S3Er4FQfUfXgNVmT?=
 =?us-ascii?Q?c/bsGDANze6kCQQi4Z4p46jLV8V5GI5ikZFn+f6u1dkDd6Bujx77ifL1VlvU?=
 =?us-ascii?Q?mxY1oqj8In2S4dD+aHkvxCgyvAOEABNgJvjTmssShzEuhCJGIKlvX8v7A2bl?=
 =?us-ascii?Q?+z2CCicr7JjSzE8sCicXFBe15zG+CJPaJujCGGTpIJZFyjCxuUoPA590ZLO7?=
 =?us-ascii?Q?aUSJhGYC7idvUUMxKKdHmmdZylEwL5f0loxbhsdXHvjip/L5mKReN7tsM7bK?=
 =?us-ascii?Q?adBue6UfPbj3cR6ZIt8241GPaZCBPAVndbAG3ijdxBisBJKZEmE7TPEo6w5J?=
 =?us-ascii?Q?Fw3LO//2ziOe7v2YRAnYU+HF/PCcdZFUMGjm3hFjm7fzhMOghgwjCxNxwcOv?=
 =?us-ascii?Q?cElnZNKO+ZgA6OaAGN6XD+yBjr1haEETd9DaYQB4fnD3OnNiqzmsVafeCc6g?=
 =?us-ascii?Q?biSXcentX+rUISnisdQMXNB9XUki+Nah9ZNCOkKDE1x/alzBHv9yziRjMUr4?=
 =?us-ascii?Q?IB3Yrunsuyc2zBybvNzy8U5w/N0VMOLJB96xL/acmjrlbsqf7Fdf221+KESu?=
 =?us-ascii?Q?gbll0a1bHkYWgvq6YKeJxlESM4tm1Vb9Wfi3cqflIKUIadPBqIBE+1gRcc5X?=
 =?us-ascii?Q?BVZ0as4bYX9BieHDRIiSUhrpQyTANspCe1aojv24Zde0yx8Y+Qa56CXdkR78?=
 =?us-ascii?Q?HzcS3DxhkoulC/Hk70niC4I9RrEfEDMYa/lcNb9m+o2hX8NG3Cp2XKnOlNuF?=
 =?us-ascii?Q?vWC4FTxKpGyxlNvpUByy6opcIXJK3TkwtiUCN7++6/S4kdC/I0ruSN2mlMDl?=
 =?us-ascii?Q?3P0kimqqZs+nm6cMc79S0rx+I6/Jk3yP1aBoCIf9lOvVEEZEQm7Z4usdckwb?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f9eb6-35fe-4c8f-ec8a-08dbb81deef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 08:04:50.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWshb+Us5C3UsYQgETMapYiZzOpKwfR/TqU2mjZ10bAjlu0O5ZdNxYR1fkqXCBaujnlsdGFc8dOH9iVd6M5LJDOgacU2BV5NWVS9chtAsRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5826
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Gentle ping. Are we happy with timer documentation patches
as dts patches hit on 6.6-rc1?

Cheers,
Biju
=20
> On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
> > This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
> > Also it fixes overflow/underflow interrupt names.
> >
> > v2->v3:
> >  * Dropped patch#4, as it accepted for 6.5 fixes.
> >  * Moved patch#2 to patch#1 as it is fixes patch.
> >  * Added Rb tag from Geert for patch#1 and patch#3.
> >  * Updated the link to lore for Closes tag for patch#2.
> >  * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
> >
> > v1->v2:
> >  * Added Ack tags from Conor Dooley for binding patches
> >  * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
> >  * Fixed build error reported by kernel test robot by replacing
> >    GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
> >
> > Biju Das (5):
> >   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
> >     names
> >   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
> >   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
> >   arm64: dts: renesas: r9a07g043: Add MTU3a node
> >   arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3
>=20
> I'm seeing dtbs_check issues in next & Linus' tree as the binding patches
> for this don't seem to have landed.
> What's the craic with getting them applied?
>=20
> Thanks,
> Conor.
