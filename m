Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302952240A
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348885AbiEJSbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349017AbiEJSbJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 14:31:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62A32064;
        Tue, 10 May 2022 11:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS1FH6dxcx3Kr+T7uPvPU+TWPi6JZhZpf1MzDUNAHEqxmAM0ETXOCWJaWhGovmwTIWp/qq14n7K0RdtJoRZmb1/ohRMQPdGjiarkdLZQ2CKAENVN3FtcX7el2EscFpnJ8P6yC4vy3mo4Is/Yb5RZxwIZkUb6tF7YGmyB18CqkXLBNffKpaQBJ+DD49w48Q6Zu4gW34ibYzR+DZK2ioVADbwp2eCi67vRgzdmRe2aLzA7o5w3jgc7E41jgxQt3drN3QbuvPh1oz6u/uqCyziQib92NFx1k3a1NCtHnwBBL0IUpSHy8uLFcJNxOnz0RmVhMV5NrXHCzZe6+O+yVQVewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKs0yxWZ2ORZYhLtTqaFrT5oEXAS8UZclmqMjuQquu4=;
 b=nKJKlATpMDz2vnY4ZeUIofRziljUkbnMSUi6UbMLhTGwfzgkIvEh51G0lADnrtT7g2aQueVN1OXUTba4YGoEZz1MM4RrkSn3ZbV330Fm8/NWnJuQRayAM5sdezm4PP3DxXY7ewqX6Yzrdi0T51XJdlwXA/7BixKpaq01T3Fj1BDfjFWGBnQwlZlyniVVR8aYRcvQBH8V+rArb7UfK+I882ftxDyWEqMGbOmm1R0FYEnxY1/JzU3KF4FE88+KdnGzhdOeN5zwjWbU3JZS22ySfhZi4dGM+v4AyEeng+r9gJx1RS41MhG+zl7wPSoBkVVMDyFihj3wqhrgNXRlQTyhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKs0yxWZ2ORZYhLtTqaFrT5oEXAS8UZclmqMjuQquu4=;
 b=PYD7ABkPMsveMs47IjQ0cpfXGhIlXmtCOo90UXYFJgVYWqG7t30xvhsfX3TijV8JJP+VnnkZUSQfPu89XnwpzbHLv75PGtT/f1/iyOHpa3W+c+xxBEDvKkNWzymAzYoz4j/V38YVJ7/7/lfxsYDjNiuDlk8pG7ekLEwHVAl9+Hc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB7666.jpnprd01.prod.outlook.com (2603:1096:604:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 18:31:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 18:31:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYYK+lDsvUpPE0qE2rS+QRz8CKdq0RcTaAgAASxFCABQDbAIABHEGggACve4CAACORYA==
Date:   Tue, 10 May 2022 18:31:02 +0000
Message-ID: <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YnqPTQVUNADk/YO4@robh.at.kernel.org>
In-Reply-To: <YnqPTQVUNADk/YO4@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb0c2b86-64bd-4cb1-8f48-08da32b33ce5
x-ms-traffictypediagnostic: OS3PR01MB7666:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7666E09A68BAA6536A74A89386C99@OS3PR01MB7666.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2J8D9yTLSEunwRHGYC/XDXSvdZRppvi62XDwzMKmdxYdtAN/DoyoMOXuf64rv3SsomicNBlBuiACZHjZlDDDA+o6Y9q9bb2G4z5Tk5nTwOEKgc+YnYmbgr1bLvC9y9PzGk1oG5wrjwOhFaa5oJEuEIjDNy8DdaIGXMlpI60PEuCGQ2GchW6WUI4MIp1d8xuzbvICe8GLY6xL8Hn9B+feSthhg/g+SHo8crGfeFTEEl9aJUs3cX7TRwyC9sw1oplPjTN+sIADU1iqjW94vicGCn3aiZWriHgWnFHCQ8AdOycr03obiMxebog2gZc0ALQBF6heCD06FB0OF75i2baoyxTsceqHbo3WwzHrW35iEaMZOoupP9J0/RfC6tRMBaUo0RC4/DgufN7/Sv8Ihp8VpnYzgvKKEmPg6BG7LDk5BEK4fvMj3/rUZibIm0LkZV+8dEkSbdMWsmcqaLkDr7tNQqSyrIdTn+dDlLRA0zCKPmAmX9LkvP/ux7awv1kLNqJcHlS4AFi8+iA6PzsqMMnqwRQKuNusepYo2TJX7SNmbJIW3kwKqn8y43QgpQlzteUtS14pl6uexZzelyg6TdzUW51VZT3FGpI2RKlApV8Fi+jSNSmkyASZcKrezI4JWk5Gahyc5mgwpe/fdbbdRMTwTBxvxZCa06L4CVQBdUgFHl5ai8w04fikMd7lmUuhIDTbkd3B9JRIGZQK8F41+Gm5aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(53546011)(86362001)(71200400001)(7696005)(8936002)(33656002)(508600001)(5660300002)(38100700002)(55016003)(83380400001)(38070700005)(26005)(9686003)(107886003)(6506007)(2906002)(122000001)(186003)(6916009)(316002)(66556008)(64756008)(66946007)(8676002)(4326008)(76116006)(54906003)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CRzzr0+AKH8Blyns+YDyWD2D5C5V0F2fFdHjF3ccr+zrYJl7pF1kBm8NU/uj?=
 =?us-ascii?Q?gjOZhnIT7wlDuNSlePJpyDgtESrRSKsvAy5ic7uNJ7wZC1SUFJeZ5z09ZONI?=
 =?us-ascii?Q?HpOPMu6oxMmUw4fMDV/ufhzysqh+2u4uJY7VS16+/Np7jKuibWRl01HlxdVH?=
 =?us-ascii?Q?Cx/RWLgy/aeFJSTz9EAWnLvfmToSIWLIk8x7A3c3w9aLLvaJBfOJLBBi83Fx?=
 =?us-ascii?Q?kJ4ZQhgvCwFDwYpNej+RjxthVrBmlp+ij9s2mblVPzxA/pAc/4wT8KqfaB2d?=
 =?us-ascii?Q?2U+i7s+h2Hn7j2sdejfyfuG24B10vl95Xb/wRbI7FLKIUguc/YTcAaZuxDsV?=
 =?us-ascii?Q?XlsC0OIk8T9Hw2Wa/q95KjI2fZUcmWpy1HC9ervbnpHWf7A/uSSRs2YAPrnN?=
 =?us-ascii?Q?iJFqrWIquV4ndvF4V/R51sm4DKuduVHDAOVkSyQ/6DJ7dFZwjQ6XVPBxRyCg?=
 =?us-ascii?Q?qMeoA5rCR5KECpPypEGEf8vlLib/aP2KapTzFr1ZdbM+EhNODdfgEdhcP1kC?=
 =?us-ascii?Q?qCOSRPUO5A0FER1ZgQRv5CogD7RBI+gjU7FBdLR7pk9VqM8UMSrRIkZfRfrJ?=
 =?us-ascii?Q?aq/zMlVqJE/Sskrw9UiJdVIb3k1PycpmXHZ857h9kyMzZ061/s3UcKaQO8iL?=
 =?us-ascii?Q?lnPk6DDh9Ciqc4wyjZ9p07MMR9rAwj0JY4nAuc8ypFXv5JIHzIyuGm4xy8mO?=
 =?us-ascii?Q?pdbfDnQ1Iq6sLEVETTx8a0N4x1COa3tkfGLAqjWzJLEsr9JHMLUwD2WWqfLo?=
 =?us-ascii?Q?PGr16qBKGBqFFk4GDA2rxpeWFxJ2ObrTVD4oGpZLDGa04Xjc+zPZBqVA7XgU?=
 =?us-ascii?Q?ynF6JSAGv+txmG/QKbKNwUZkJ5nJT+VcTYDNvKd43ufooSmj6TQYFdBMnEF2?=
 =?us-ascii?Q?f+psZgiARIedjTVH6j2l5ndynZZF5L+unk04V2a9EZqCrGt9Rlpoo0fhR1ce?=
 =?us-ascii?Q?wx8UYMCeP5YuBc0D35GPcC0NpCZxlC+SM8StdmgDAFqw7d38Q9X1sqehQ/o1?=
 =?us-ascii?Q?j38Xwv7iSju4zmOe5kLHDTC8B9Z3AhF10FQAIndfb1BrKdH3a6XBn9ROOB4f?=
 =?us-ascii?Q?edWTYlqVtEzXzNJHoBlc0ePuFRuWnmhNsKCxgIkntbHdh0vhDm7Crh6nHrhA?=
 =?us-ascii?Q?JKo676ICU3krJQzIBDVslU7bIIkl57rzp3quzf/Vc4pKjsclVZM4PCvDSMp7?=
 =?us-ascii?Q?nSPKhg+d/9YYVCfqwT0dJHmKQNMdmwiwdA/+01TUFyPqmOkjD4Eyu7IpXV7m?=
 =?us-ascii?Q?cIE5Yr3/e6C64iDh2i2JDdRzndprggqWIVMvl4iP6PdJDLz9Vkf6H0/nF/9i?=
 =?us-ascii?Q?puk28m7uHqCvHuBojYHx2otzW0pOFUYP+5vqDaQFa39U4YFNq6peW6Vic7xT?=
 =?us-ascii?Q?Rql9Ja+afZRlRq3/OPTO5Ph20AVBofMS6ySE2OvLoguP7+sy46bVkZEihS4R?=
 =?us-ascii?Q?otnCP/Ck/VwgPZ0wKZmO/6apNH9BFGcCct8ylx1NSqbRleWpslCXwyE+U2v0?=
 =?us-ascii?Q?FgtcVr6rkdGn4BH+3xI77kVPw//onKuu1kZS9yHBA9FdX7/AwI2yZn+n4mM9?=
 =?us-ascii?Q?sM9diw7O6K2pz3vg4LFBIYSz5hv21lyZVZ+oTuOZlnK4XuE6L9rK/j9MjMvP?=
 =?us-ascii?Q?+qYtqtKgMRH+oVYdeLNHXsYEN4lq8/3RXrBGBV8EjiTGwq2z1e/PXDbq2FGL?=
 =?us-ascii?Q?8Bs7xADHLtjlL3YtoOAO9GJng9PKFuhwnKlbCYDx2boejDOiBCHakOUdYuqK?=
 =?us-ascii?Q?odRCAVYOT1g7c+nj4BTvMB8n2UpYlG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c2b86-64bd-4cb1-8f48-08da32b33ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 18:31:02.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIcEO5+miMcsIe6yBWdR2gT5Kf6REMvfOKPl/IsM9bisOD9sGwC/PkfKuyAoS5KvZqqBZr7umi9U21uR4KB27h2jdTNPz8YxBh4XtDuwtbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7666
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2=
UL
> ADC
>=20
> On Tue, May 10, 2022 at 05:54:59AM +0000, Biju Das wrote:
> > Hi Geert,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas
> > > RZ/G2UL ADC
> > >
> > > Hi Biju,
> > >
> > > On Fri, May 6, 2022 at 10:40 AM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document
> > > > > Renesas RZ/G2UL On Thu, May 5, 2022 at 8:40 PM Biju Das
> > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost
> > > > > > identical to RZ/G2L, but it has 2 analog input channels
> > > > > > compared to 8 channels on the RZ/G2L.
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.
> > > > > > yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-
> adc.
> > > > > > +++ yaml
> > > > > > @@ -74,18 +75,48 @@ patternProperties:
> > > > > >        Represents the external channels which are connected to
> > > > > > the
> > > ADC.
> > > > > >
> > > > > >      properties:
> > > > > > -      reg:
> > > > > > -        description: |
> > > > > > -          The channel number. It can have up to 8 channels
> numbered
> > > from
> > > > > 0 to 7.
> > > > > > -        items:
> > > > > > -          - minimum: 0
> > > > > > -            maximum: 7
> > > > > > -
> > > > > > +      reg: true
> > > > > >      required:
> > > > > >        - reg
> > > > > >
> > > > > >      additionalProperties: false
> > > > > >
> > > > > > +allOf:
> > > > > > +  - if:
> > > > > > +      properties:
> > > > > > +        compatible:
> > > > > > +          contains:
> > > > > > +            const: renesas,r9a07g043-adc
> > > > > > +    then:
> > > > > > +      patternProperties:
> > > > > > +        "^channel@[0-7]$":
> > > > >
> > > > > [0-1]
> > > >
> > > > Looks like with this change, validation doesn't work as expected.
> > >
> > > OK, keep it at [0-7].
> >
> > OK.
> >
> > >
> > > > > > +          type: object
> > > > > > +          properties:
> > > > > > +            reg:
> > > > > > +              description: |
> > > > > > +                The channel number. It can have up to 2
> > > > > > + channels
> > > > > numbered from 0 to 1.
> > > > > > +              items:
> > > > > > +                - minimum: 0
> > > > > > +                  maximum: 1
> > > > > > +  - if:
> > > > > > +      properties:
> > > > > > +        compatible:
> > > > > > +          contains:
> > > > > > +            enum:
> > > > > > +              - renesas,r9a07g044-adc
> > > > > > +              - renesas,r9a07g054-adc
> > > > > > +    then:
> > > > > > +      patternProperties:
> > > > > > +        "^channel@[0-7]$":
> > > > > > +          type: object
> > > > > > +          properties:
> > > > > > +            reg:
> > > > > > +              description: |
> > > > > > +                The channel number. It can have up to 8
> > > > > > + channels
> > > > > numbered from 0 to 7.
> > > > > > +              items:
> > > > > > +                - minimum: 0
> > > > > > +                  maximum: 7
> > > > > > +
> > > > > >  additionalProperties: false
> > > > > >
> > > > > >  examples:
> > > > >
> > > > > The rest LGTM, but I'm wondering if more of the channel subnodes
> > > > > description can be factored out to the common part?
> > > >
> > > > You mean above reg: true?? ie, add as part of the below description=
??
> > > >
> > > > type: object
> > > >     description: |
> > > >       Represents the external channels which are connected to the
> ADC.
> > >
> > > I think I've found a solution while converting the R-Car Gen2 USB
> > > PHY bindings.  You can mark channels 3-7 false on RZ/G2UL, cfr. the
> > > second channel on RZ/G1C in "[PATCH] dt-bindings:
> >
> > I just added similar check for RZ/G2UL by making channel@2-7 false and
> > But dt-binding checks is passing with channel@2-7 present in the exampl=
e.
> Validation should fail, but it is passing. I will go with current
> implementation, as it does proper validation.
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: renesas,r9a07g043-adc
> > +  then:
> > +    properties:
> > +      channel@2: false
> > +      channel@3: false
> > +      channel@4: false
> > +      channel@5: false
> > +      channel@6: false
> > +      channel@7: false
>=20
> patternProperties:
>   '^channel@[2-7]$': false

This fixes the validation for channels. But how do we restrict reg index be=
tween 0-1 ?
The below example is passing instead of failing.
      channel@0 {
        reg =3D <5>;
      };
=20
The Current implementation restricts both channel and reg to [0-1] for RZ/G=
2UL.

Regards,
BIju
