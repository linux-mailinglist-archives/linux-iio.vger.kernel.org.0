Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D25169BF
	for <lists+linux-iio@lfdr.de>; Mon,  2 May 2022 06:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355081AbiEBET3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 00:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380232AbiEBET2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 00:19:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6C29CA2;
        Sun,  1 May 2022 21:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBu5zBn7BJoqeF3dRpEJZHoAPGgtCJB9OuXT+SRrYmO5L8tYAl8XZuU7EyZzUXACjFq+xXr2WiW0Kdg6bzS4KddGYHaKwLXeMGihEH6B+6b6yLjpb1hujcCymDjVrzVPwW+VkuOKZqhP+NYEesLRm8n80+moO24nnX9Jg7cDUiDO+/Up2jOTSmnSXrO89Y0uaSGPkCEe8yMKDAq1EzP1K832CyQeXqbVJH2s4AAAolOmbSVqcrtyolyCRFYX0snkb+H6jpWC8oYpnxLobqZxu28GcuK0ti3p8GZQK8iat+z9IZ2mG98LSWhp72a2nx8Ir/N64x0zTVvGce0gB42+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP+dzyGD9JTg62RBSNls27mnEN60TZUWpP1NK1AEHr0=;
 b=EZxui65C1EbAZv/fXKg5Jec6HV5bdY0gXTXMwfCE3siI9KKNhAjKlerRx5eULzpxAGW8uEm9Z3dcdc1lwGrkFzGVb9ABa/Qj1O0OiQC1L1MDHmDhjJfWvRP8Q25n0epLzNS81CTqrSwFDUsfEZmZ5LS6RekgIBA8Cbf7Bju/7iCDr76zgnO3GeLOEql3vJypEj3eqWvgdBS/PqrTMaTaiOqY/0hxwdwO1lHIwXgtb2cDsaHbccYgWkYhoO4iM+VuANFHbZG6zGrN9PzXn9o5kbFinF7TtASQOXn69b+tzMv8dgo0RT7fxRNhcKY2c1WVf+9z5DfpcqEQafyS3aN0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP+dzyGD9JTg62RBSNls27mnEN60TZUWpP1NK1AEHr0=;
 b=bLAEoTZl89LLFPsF9IDlOINcw37+fCRNEGoRZ8oCOgVSIzNus+kQK7JCLIKbPoxSJpZrUgvTRLqDWXO1GXgb3WUWPqC+1HBlonRQeSSTcPC5unpwDlZVycfTwfA+PxfWAC1SzoaYtnaZzfX3UUyQOcdgXC6xWG1HPTPrp/1tHxo=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB8341.jpnprd01.prod.outlook.com (2603:1096:400:15c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 2 May
 2022 04:15:55 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5206.012; Mon, 2 May 2022
 04:15:55 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Thread-Topic: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Thread-Index: AQHYXU1lZwuz8398NE22h6tmvwpBnK0K+ugg
Date:   Mon, 2 May 2022 04:15:55 +0000
Message-ID: <OSZPR01MB701900F9A01360571A7F3FA8AAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e452ee4-9f6d-471b-84dc-08da2bf2741d
x-ms-traffictypediagnostic: TYCPR01MB8341:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8341157B4730A01F74735691AAC19@TYCPR01MB8341.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGhSIkC95OK0iLIs7GPLYBO//rnGEKGMJ9KFM6gx6CsnC2g6MVCffdvANFazQ/ij4L7QAtud+/rmmSp2fsVOINj5PrANaV7P45JPG4x8xKeJompTdUz1U4YQ5Yn0hWJBlRl3B/HFqWlDz+RrbsHW2bq3i5oB1dzsE/I0N1SIRH10txciba0+1l2vv7/JLuJReY7OGciwL7UbccBK87bifNZVYazIKCcEyZnXsjXXxJ4lEtl5+8XQeXs8DMSI19Inzk+et46jekqWEsiWulJsc4m+VTs+gMQx70olAfH7QVeRP04xa6GO7GphVnvT/0hoHP5mA+m3IPFVEHC7gTrKNIO6MR4+H21D197TDOW9wQJY3jxzAZrfz7fXndcXE3EsWvb+7wnqeZNwFGazCoCc9YTb9L0oU947YPd/1E8JLd4R6jaJQCxiACP+hU0kV+2j7ILuW5na689qYsejSV1iVUqMhV0DySYpox+KY2AHiD6iYLtStCYZeK520Nz/+pbR4QDpis5pFJpOOTUrxMEqtJ/otuoSTOLU6vLMuIWIrrHNfK/kQbUFhXQeqP4STEuvN0GeO7edCRzOqYctygh2B9kNsbiy1jcf9dB+chPIc56kBl6XYMxf6cF6afmzYEWruq91kgKBm8suIY9Irf4uJ2SH6NL6tW1AyI3b/ZSYa/OV9/LL01sU86LfIVKDHxJ3H0Bciv/wb15CHqTIKhIaZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(186003)(8676002)(9686003)(83380400001)(107886003)(55016003)(5660300002)(4326008)(52536014)(33656002)(8936002)(508600001)(71200400001)(54906003)(26005)(53546011)(6506007)(110136005)(122000001)(7696005)(38070700005)(38100700002)(2906002)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0SqU7rn7LP3jO0tOPlCLW0hoUjwaECEdMTep7u9JGb207SADLXN8ggErUPo5?=
 =?us-ascii?Q?yCh0yVQdzkPwhzxo8KP2QF60Gq5IsoStr5XVHJ3jUniS57VjE0FdBnCUZyIc?=
 =?us-ascii?Q?QqbuW6mtcWZ+pK6LYrcbGxot6QWb6PDmzAipTCXhjKTXJS9A4FMo7taDfJv3?=
 =?us-ascii?Q?OdZQTvbdfcb2jxyYP3UuurApk2nw4YeQKQBqhx2oKzMgdZvRrVVjsRmj1bTY?=
 =?us-ascii?Q?5KtAoyrSmh2hjKuT6IfAED4EGojz+4bDHSjrn7RuWsqXRGCC8lcmpjuOmhb8?=
 =?us-ascii?Q?R/MNxSKtMEXKPjqYSCBZUU4STfugJGR+cs2hdDX30xFaKON4JQUao07AyN/R?=
 =?us-ascii?Q?5Wit1u/wUqwg+8I3IDqn51QLXRe9HGZYYy6Np2+FzOS4R2Hd/ZnSk7f+C8O4?=
 =?us-ascii?Q?5SDJQKTa+kwMGvKkxrSe8lApbRrpNlnSJZDQm7c4c7mBFxmeoC1G+jjpXz8n?=
 =?us-ascii?Q?ArXaP6pjxWfa3qeN6tAdsEV4Awm69VTT7S640fVTaRBZzmrEgvh0TPJvN/If?=
 =?us-ascii?Q?IgI2IJVbmoZZluj/lOi+dcnvraS/OCgp6XuI89NqA8DzBDpF6+S4/V+il9iv?=
 =?us-ascii?Q?NnmuR/WDqSfGicYOzFe+dP5qgZzz2/59uUj4sV39v4S2ZukpqgeOeDXUf28b?=
 =?us-ascii?Q?sTLGna9crjmyHQtZV+CqY/CikPLqCXzdsOT6aWoyUZg0EE2zuLUnF/5pA5dp?=
 =?us-ascii?Q?OP7FiZDlKJv1Ic7OjBi/5vEIbaFP/7CexJM8PVhnh1hnXkpci5hAEvoKDpDS?=
 =?us-ascii?Q?Tt9FRGVQVvGiX5klW8lj+4cky7UiVUNwi6Wj0mbT0BkJRZaasom1WOoW2239?=
 =?us-ascii?Q?AdhnJDT++fUJ/QleJXPUl0iWeMduQTdorYNs0HrKoJmKqV2s3pPHXn8ubVRE?=
 =?us-ascii?Q?b8DVJ2aAYKavp3E61KxYRoUqcccZjr2HmAnrzGoaQLJEuYl5hMa3Xk/CXkyF?=
 =?us-ascii?Q?MjWut9nwc/k3zsQn/xR0CRHUhtAMby38Bex4HRNmcKluzGCqViVKUlFf6lka?=
 =?us-ascii?Q?aCF7sV4SgirEOoov63jsq5BEi6oTLXHaQ5SondW+mOEP7GmrGrNqdCifBdP1?=
 =?us-ascii?Q?705mOeVHRD1UNIaSDNnM24/I1buyioY7F6K6oyXMCpzL6SHnFL1I87g6wxfu?=
 =?us-ascii?Q?jQUP1FZ4LqVaBf+pDwzihtFIDNPnuJTTpS4HEKY1iQ8v/ojURd1BK2tRCVIA?=
 =?us-ascii?Q?/OBY5z9LW3rAvE3r1Ko9OryD+hw47FwgE4VfFWY63IyzH80TJ8uFMzAeZYYR?=
 =?us-ascii?Q?e0DK6GVs7FKJs1uLgFPH4oIIJIr7LVc7/uDo2lGBCKzWjsyYyiTpfEeXvf5T?=
 =?us-ascii?Q?bYt5gYZPuJfRIT9UUhgJ4iHTxHagtEK8dsaQShBulAF10tdG517H1Auu7bvC?=
 =?us-ascii?Q?+i6CI57JPw4jPK8gpSmGNE/yltoUqRKfG/ljloRK3jXvtIGkYtpFEjICRQ7g?=
 =?us-ascii?Q?tJbfi6jNOOA2WzsmSM9luOjpT6APUYnbNqpFXJ9UqCWB4eiKQwEDMk9glBgX?=
 =?us-ascii?Q?B9mSBG2WemdGQyegmGsp2PJwzD50qAo8rk6BMvQlYPdnjbHOf3RiieGfLYPX?=
 =?us-ascii?Q?yjl2eU0aAmmbsZqRAQh6vNWOL9mehBu2/47j62TewTct74Wb4MR+QZCqGIs/?=
 =?us-ascii?Q?VAnNjPdMPaB6CxI0LlsWL5+PsG6oaOhD4Yj8frkn8q4IJyrmeZqVxdPSZJvD?=
 =?us-ascii?Q?tMHSf57UMDp6AXkuzCuyF+xPohoDLel+bgbImkY7ey/9mDF2yymzVGSy5Re6?=
 =?us-ascii?Q?S+kRwlxvfbMuoWsUJhF/Uup/SLMfhfedun/gym/4kFdyEwiC1Oc+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e452ee4-9f6d-471b-84dc-08da2bf2741d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 04:15:55.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crqGaCVzUaWliAPF5FzEpDEWXDPg89egerJ+DgXYfz6wGVgc51uCaa93OusYDGctxjwczHDz6v1JtauKTlUy+BmjDXlT23zSavhXsPfxYcn4ztEra/JuuGI08/J6VfN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8341
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thank you for the patch.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 01 May 2022 12:20
> To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>=
;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org; devicetree@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das@bp.renesas.com>
> Subject: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
>=20
> ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
> has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
> added a new compatible to handle this difference.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Removed Items and used const for RZ/G2UL compatible
>  * Add allOf:if:then restricting available channels per SoC variant.
> ---
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 34 ++++++++++++++-----
>  1 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-
> adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-
> adc.yaml
> index d66c24cae1e1..d76c5ba3d625 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> @@ -17,11 +17,13 @@ description: |
>=20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - renesas,r9a07g044-adc   # RZ/G2L
> -          - renesas,r9a07g054-adc   # RZ/V2L
> -      - const: renesas,rzg2l-adc
> +    oneOf:
> +      - const: renesas,renesas,r9a07g043-adc  # RZ/G2UL
renesas,r9a07g043-adc  # RZ/G2UL ?

We need to decide if this needs to be separate elements or part of below en=
um depending on the driver change.

> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-adc   # RZ/G2L
> +              - renesas,r9a07g054-adc   # RZ/V2L
> +          - const: renesas,rzg2l-adc
>=20
>    reg:
>      maxItems: 1
> @@ -76,10 +78,24 @@ patternProperties:
>      properties:
>        reg:
>          description: |
> -          The channel number. It can have up to 8 channels numbered from
> 0 to 7.
> -        items:
> -          - minimum: 0
> -            maximum: 7
> +          The channel number. It can have up to 8 channels numbered from
> 0 to 7
> +          for RZ/{G2L,V2L} SoCs or 2 channels numbered from 0 to 1 for
> RZ/G2UL
> +          SoC.
This comment is not required as we already have the below hunk where it men=
tions for RZ/G2UL its two channel.
=20
> +      allOf:
> +        if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - renesas,renesas,r9a07g043-adc
renesas,r9a07g043-adc

Cheers,
Prabhakar

> +        then:
> +          items:
> +            - minimum: 0
> +              maximum: 1
> +        else:
> +          items:
> +            - minimum: 0
> +              maximum: 7
>=20
>      required:
>        - reg
> --
> 2.25.1

