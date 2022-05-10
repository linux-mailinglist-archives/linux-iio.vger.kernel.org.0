Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63863520D78
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 08:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiEJGEw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 02:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEJGEp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 02:04:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31564CC;
        Mon,  9 May 2022 23:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URG4ZPFzDooaAw00doRNrZsjX472z+KuAmyRtlmGutuuhfQQKarDvtu4RmHc07NyBF5lbRe6L23W1TIRYs1vCeIYHSCSpWwdzr44YdCYBbGmyMog7C0psGHQKIeK+jstZU9u+p1w+lwSJIGg8dNpEcCAeeUwomjFWEoOYBjxzugbbKaP7aZ5OKWd/Fmo2ZEfUNcpaO1BdM82QzdvOyuQ2We+44hqKtwrANDsyzZE1a3UfiODgNfud3wB8rlAn1rqv4iDcpnETcp1tfqfkQ6vo5xEWbyUoN8Y5nOd05Ju7CYhSCvuu0QLNfz8YyfK80xfc2dkQiPzEZoY7l5vcP5ZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqJeLU8oaVjwIeS+2f+/BIsy0vKi5EAJYjZf0vIriZY=;
 b=AzWe730ywl4urjktAk9ve4FRUJunVqIXjvJ3bLWgqE275VzPgqBnjap86SEd/w8nMsFxThVFPK4wqPMCeDf4/KFETRUNzzuf6e0ssNa0Vt1HfE1zYS+uJ1NsQqT34HjVClrbJ7TiVuSYlWQnSV6fxvZw5pUK9HOawgsSSEPQOIX5KzW7RQf/VkkzLGl13hTllSAewYykU9Jq4NEUyhSbHBQrzkxJluGe7MH5uxMAWIZvwK9NrS5xRcrvDlaNo3p/4pw2OUIkdIuoWnFwW7QXMGDJJmtfLaBrSBMGpw6/nqLrtUD6ix+Z1sN3tTm9lZ1vERMxT2IczQoC3sa3Z/KYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqJeLU8oaVjwIeS+2f+/BIsy0vKi5EAJYjZf0vIriZY=;
 b=lScjMadVlPDnZqQth74NEySVl7zM9IA4UXj2SxYmLDNg4ETmYn4d15sFoljHpGWyF3zM6cVoEc1G6g5I6uNSUUktTXrRm2a/Jt/QJEs+KdaCUQUTBicrtxi8i/GzxTAs9V19l462diC4qtUXOZ2VXnM/OfGGf4M8zQUIdh6O00c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB1681.jpnprd01.prod.outlook.com (2603:1096:603:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 06:00:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 06:00:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYYK+lDsvUpPE0qE2rS+QRz8CKdq0TfLcAgAQoB8A=
Date:   Tue, 10 May 2022 06:00:44 +0000
Message-ID: <OS0PR01MB592227236B38E5DAB426F60486C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
        <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <20220507153048.38fd0b67@jic23-huawei>
In-Reply-To: <20220507153048.38fd0b67@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed184335-b4fb-42f6-5411-08da324a6ba1
x-ms-traffictypediagnostic: OSAPR01MB1681:EE_
x-microsoft-antispam-prvs: <OSAPR01MB168141CC8E653C3D1DBC0D6586C99@OSAPR01MB1681.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3oyeiTM4b3eH3GkpkxVwlKtjO/TIK13y/RC/4ZE77kegGtyxJazAajoSPY7I6lsZfZm+ll8/8M5VXN1sZjnkhMtgZKxxkEw2yV7BCziEfKvDofSty6JKpnbBa+Vva5ZGXp2X6KkGYCgAq6qI/6YkiwfdmWy9eoeEKKZKJLAbjH59W+az2sjCt2uwmOP7/9JEQTpZDBEfR9uEpScYnqsHS2qT7tUArfKH2w8IVrdZsDXyxEDVcop/IC65gYlkB9FoiHei3x8e3ZMNJnl1idJDYTq+vM9fYjSDo2V8qU1ekVYdbUpUaag8gznoo14xKsM5IodHATQ5s1BQZQxzUXor3sLjZYl323tUrvQ6hFDiKDssfG+GqF/S1CuNWshkEtbQmRWTU3qdUl4Xyvbu3fuAKCzP5RiEXKRROBRpviA4rlGK0Nl9gelRRVhy48md4xBExXysDaNM9Ioe9WkWY3VpLYP2xsyz3xfz8SBK+sFs9sSj63/2oExgyz5Kk4xO1+HBYPO4OsWUtLAofFo6jAXQJP4AwaEsu/N0WoPdsk+kjp0z5GJJqoiDhryfu7Mr2gSDA4s3ec91+Zqr8RjQZSZ1h3WlVA8/1aRkqRA23k9sCF0HVipnjLVISlvOlIyulsifAMEZBPZtnROlOjwVnLOhGsPYd7vCXDEq/JqatDPYBNOq9RWgPh+nbmmvpCXXbH2RW1KBn65CMhi8bVuoVMciRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(83380400001)(33656002)(52536014)(71200400001)(508600001)(5660300002)(6506007)(107886003)(86362001)(9686003)(26005)(7696005)(38100700002)(186003)(2906002)(6916009)(55016003)(122000001)(316002)(54906003)(66946007)(76116006)(4326008)(8676002)(66476007)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kh27i/7LwBuklXJRvLK5NldRHWF2vWluWQD7FV6S1noEfFFrY43Zc0p6/AWf?=
 =?us-ascii?Q?b20tsu5wGPSpX/hBF6TU/7qdJ6+vBRJVeykIZZ2zcI3cPfQR12CFELX5Oqp2?=
 =?us-ascii?Q?wnXtysEQTH3s8IPcFNq941ukLwD7YytME6gb5ryK/S+VR7aG4ngjtHKf9cTt?=
 =?us-ascii?Q?2dPBAw/ALAyJSOCtqGvLDjBen6pnpAVIWVG3IhIAsB2waV9ty1DOsbenx2Ul?=
 =?us-ascii?Q?FbTS87DaL8BPXMRFrfp44rDm7btZotQBasNAoZ2l3FpHP7QS3eAYYZXj4amY?=
 =?us-ascii?Q?4i5EuNSh62I+vHaLA9fUcNgdEVAWETh+q/FxM4WcUjVg1PWc7ZVMARSf/iOK?=
 =?us-ascii?Q?rkU7MeY+a4Bym/LS+W+LXG5miCKXHLTg0s8d7XDhkUEONvfL8H5dEe8ZqibV?=
 =?us-ascii?Q?/QgOVxWAfK7nG4dctPDjfj434r2sbFVLL/TwaXZoRXhcg4Ri4OMh5E/6YMcj?=
 =?us-ascii?Q?+8I7rKORAvqUzbBHV0EVoUhCYYIpLUMMBnzTzdJjHH0PECG6bDmaWnOlp2VS?=
 =?us-ascii?Q?IWPv/DbXQd2mq+JqcCupr1JsD30Jm5+BP61qn1eF93BkukSrRJofGvLoOjBB?=
 =?us-ascii?Q?Frf+uAVyxTnnZThKMlJLKTU77jyzt+yFHf3COoQdlom7Di1z7yBj41gNAzLp?=
 =?us-ascii?Q?b1fGa5td7C4MmJqdiQM7B90BeIoxW9yEaAaR2IRGF2iHICRmoI0dA/u3lha3?=
 =?us-ascii?Q?D+wxQo6XCZAfUyojokKkozC5rXHIH/vQ3K5qeUGMRGeVHFRtsm5opMvAiIXY?=
 =?us-ascii?Q?kLCG4EmaZePaDsgsADdcX5NnonCyFqiDpQOpvZeDkt8XTCCSfph/VzHyADIP?=
 =?us-ascii?Q?2y8lDcC4eONntrqtvGGfUX0hZwjgTm5RgAMrWcELn8q416p0VsAh2jL7YmQs?=
 =?us-ascii?Q?Xh8rd23KkAKGcNFGLhPe+1zfgx92cIEje7BteXgyynreAxrD3gA1zqKp4wMx?=
 =?us-ascii?Q?ZuuJXiSgngXRETFIKb+LEWiDoKD58eq1qetv1HgJMSCR5AcbdF26euI2safp?=
 =?us-ascii?Q?M2COfBloXAC+0AiFcn9RrXyhBXhjX3HrwDVP9vOwcrlH0VFDCugKbF62UNkq?=
 =?us-ascii?Q?w8PyLlWoZP9pv92QmcptcH3nsYOqWAIhB1Dm32UIocvjuXPjqll7XDmnVthN?=
 =?us-ascii?Q?qeecPfEqt2131r1qsOU6rgFvvWH9RehelP9H9vhOw6MPuj85ELlpxVVjNCrD?=
 =?us-ascii?Q?jVQ8JlqTk2jSXqEvG+SzLlSMUBcimXf/EKvg00UxWVz1t/kNkq1LUxmwZ0JU?=
 =?us-ascii?Q?cfqE9bwr29KWedX0EvtD22crVIkGoujXiPY9fTHyaZd9bfQZY5m/49VYXcI7?=
 =?us-ascii?Q?iZHmDofBpcj+jyDTtN4wpE2MRAGwBLFUt1Wt9w8zwSb7LMjtmOoStWQ3HUsz?=
 =?us-ascii?Q?UF1fBPth5IwYqy1xMRFN6cWSB2GyHIsytEKz7CMyLgdHz6tW88mUmkxEU3Eg?=
 =?us-ascii?Q?BQyyQYycq7wOI5UtWKlCHAYrTAgUosMe4RJ6NwJ1d20EcoGli9jD9knZLK+h?=
 =?us-ascii?Q?jltQ4lFjUfj5wqSp1y5qLRdrPIRoY2GsWXdfLai59XGhexTG0cjZc2GGPSTG?=
 =?us-ascii?Q?P1rzJpRsH6w+Vtm8Ao+7axiAWlF3m7izidg6p2ks//RyE7f5Wq464VxOUr+s?=
 =?us-ascii?Q?59UOPav0Obq6pLJf6UJUj7+4+/JncnKUUFs9dqsRtnnqdcIBDPz6quUcozLY?=
 =?us-ascii?Q?6qLkoqooqY6n2t9ZorEcI0jDmbn813vRoJW+s4qKlKUoSuSz9tBjWbBAVkWe?=
 =?us-ascii?Q?x23urhQV6JJO4v5OH8PutkpYV+FBIz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed184335-b4fb-42f6-5411-08da324a6ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 06:00:44.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcDCyExL1RP2+flj/Usn/xio9SI7E8YEV3YKVZpqeXs8U3N4bs8ap2oASdD0R3dW+/AU2rxcDgWwpQOQ0pH2WVFdyvSsMbPrWyBhY7XK1Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1681
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2=
UL
> ADC
>=20
> On Thu,  5 May 2022 19:40:36 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> > to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> > on the RZ/G2L.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Started using generic compatible for RZ/G2UL and added SoC specific
> validation
> >    for channels.
> > ---
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 45 ++++++++++++++++---
> >  1 file changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > index d66c24cae1e1..2da3538a3543 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > @@ -19,6 +19,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - renesas,r9a07g043-adc   # RZ/G2UL
> >            - renesas,r9a07g044-adc   # RZ/G2L
> >            - renesas,r9a07g054-adc   # RZ/V2L
> >        - const: renesas,rzg2l-adc
> > @@ -74,18 +75,48 @@ patternProperties:
> >        Represents the external channels which are connected to the ADC.
> >
> >      properties:
> > -      reg:
> > -        description: |
> > -          The channel number. It can have up to 8 channels numbered fr=
om
> 0 to 7.
> Leave
> 	   description: |
> 	     The channel number.
> here.  The rest of this description is obvious from the below schema so
> doesn't need to also be in the descriptions.

OK will do the changes in next revision.

Cheers,
Biju

>=20
> > -        items:
> > -          - minimum: 0
> > -            maximum: 7
> > -
> > +      reg: true
> >      required:
> >        - reg
> >
> >      additionalProperties: false
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a07g043-adc
> > +    then:
> > +      patternProperties:
> > +        "^channel@[0-7]$":
> > +          type: object
> > +          properties:
> > +            reg:
> > +              description: |
> > +                The channel number. It can have up to 2 channels
> numbered from 0 to 1.
> > +              items:
> > +                - minimum: 0
> > +                  maximum: 1
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,r9a07g044-adc
> > +              - renesas,r9a07g054-adc
> > +    then:
> > +      patternProperties:
> > +        "^channel@[0-7]$":
> > +          type: object
> > +          properties:
> > +            reg:
> > +              description: |
> > +                The channel number. It can have up to 8 channels
> numbered from 0 to 7.
> > +              items:
> > +                - minimum: 0
> > +                  maximum: 7
> > +
> >  additionalProperties: false
> >
> >  examples:

