Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B7264950D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLKQM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKQM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 11:12:57 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AB5FF6;
        Sun, 11 Dec 2022 08:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIuzqS2wqwmcf14Se7yG/j4blOHw1DPdlAyVNUoZQarV978gyxoLPBgX6mNUGwX2rkfpzW/M67C3ZJHoEj4yD8ZnAjIETGjS2+Wp8MaglGK5VeC0OnmYqjFSJs4onErLoEN/rmZ1ScGTVgQ2Uz5nZjqVmD3ROc3UOeTFAljxY9+YX9Qdcu92AjiuE7GnBkJyxRYDlWmcF9xfPt/QgOD9Aif2IgcFw7tW8e+vgaUxzulv4HmI3H3F/UoTFeDIezqdrJaVPo2f/IIzQx8a8Fj1Dd6RqETDW471tQxQF9w8Z1xqcCpWTO99wMJR8BQ8IGj1lW5GjjmwWa++WoXytEMfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6BL7cpMOjJ319vjyq+HVHvqOoKjQMgpCWRbApkPZSA=;
 b=CjRvwGp1LCgkJZepADueBbhHcwlCmWYlgAS77jEcF5fQyKM6Fgjy950fL1l7d66rCVrUXlAmipJnMNCCBR1FO16RMHtU2L74ABZTs7xZ4ic0TFP3zlTxr95J2l30xtzKXZcAY43ZoUqrXXhIFpWGmu6jm18wCaBakWEaVZaxHyX/UV1ofE3BpLKuVqH5sCUjykIven4GvK4j9Q2za9/40ZBuFjYJhv8PGt4sEdIATVp/KbCwZ8w8wLEyjji6/zAKu/EFdo1x46jZmPY/yvrjeokak+gIFtoxbpgv06CtSjYGmPAUtMZ+HKrlWfDxdIYBLnNPnSurQ6KcH3qMF6gNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6BL7cpMOjJ319vjyq+HVHvqOoKjQMgpCWRbApkPZSA=;
 b=aew6N/O6F03eY5ScsbfJBU2IgA7Ssu5iyC8S+hBDlahmqAemWhWFIXBqPoimWiClIods9KhIeZODVDsWx7Wnq/B5nMk/k6ofDxRAzvK59r6GtaSFj1y5XpUbB7dBuvgydUQOMfD1Ph6Y011OTptApnYoPh6Im2Iacmb0wJU6umk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9863.jpnprd01.prod.outlook.com (2603:1096:400:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 16:12:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 16:12:51 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v8 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Thread-Topic: [PATCH v8 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Thread-Index: AQHZDIErlROXd2Q8a0CnEBQxi+Kh865o0w+AgAAKFgA=
Date:   Sun, 11 Dec 2022 16:12:51 +0000
Message-ID: <OS0PR01MB5922FFBE0E3FEE50AEF1A5B6861E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221210102110.443043-1-biju.das.jz@bp.renesas.com>
 <20221210102110.443043-4-biju.das.jz@bp.renesas.com>
 <Y5X4e+GVLhaTB97N@fedora>
In-Reply-To: <Y5X4e+GVLhaTB97N@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9863:EE_
x-ms-office365-filtering-correlation-id: 18672f12-1742-4b23-6c4d-08dadb928d84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6gok48et/VwBJ6x9PoLVVjxrZySaXbh0/Na44SzidWwBSB/qf0VWe0tydU2S5bewfIVT2GaDp9I1clY9/8vxhluSFmwP+9bC3YyUak+/gCY/v31VVvFZv3XyEVF9eRrZ2p6Lp+R+jdW7GvqUCjmHMvHxertZfetHcIFzc+tQkfcFVLOgo8CJpTYITrmRnJgR3lCoAyTslPsNlvZ+mlXJI5cLPw/CyVIe36OcbQ3sFT7cTJajkh5SSZlEPcouL01PCCusq15Lh78knBc/EJPMEqxeFfrlT7Kr8/mbi6tmvoCsBztxFxuh5KCpUbkHaiUyCId1N7Qjj9D++QZ4vusq2GxwTzQ49CqUACxzIb4IHrvbd7DxeSBcr3Dzc38/jEMpj6eI606rVWnWU6DqSk+TIaBsppsCE0MaoLHifkrIp2jhMN0iELktEnXDlxyXoy9shahU5rDT6hsCNQOopVKbEzpHsye+BBKEitxpkc9CBz55yah50QBDIKMnIa2yk4fVEgMsR3TsICFjOWJ6PecIlCUvOacfb2IvfVWp7eXj+cB6PoJFbvGPTnS3/KGdgEE+rlF3+1BUQnhewKm+3pZag7OZEtKcQPPyd9oCYgEYnSXmAvJNLcDh96LZcuYYvEsbQXD+0vYHpZgSY9nkoLeGwaciHR11Rvmk+VlFe9GH1KHKyNYRSdIgDqk6e5h/3loAlQjBCQKhv2g9RwOUBvVIEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(38100700002)(122000001)(5660300002)(86362001)(2906002)(38070700005)(55016003)(71200400001)(41300700001)(478600001)(66476007)(6916009)(8676002)(4326008)(76116006)(66946007)(64756008)(66446008)(54906003)(316002)(66556008)(52536014)(186003)(26005)(83380400001)(7696005)(9686003)(6506007)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mbzSpmvxLFoSm7KOXWKau3FkukaUXUY01v868gUxy2wE8dPHhFRYQnpWEgV6?=
 =?us-ascii?Q?3Sqzgok5rVgxoPL7kW/6Rq7XV4DY0FQHrF6b49gIRdnUO0D+qSVKhEMyz+eQ?=
 =?us-ascii?Q?dYVa2YLMKobwU10L3n5sc8GIH6VtUVogAlbl0XiWJ3QSFrwMHJQ85Isksrt+?=
 =?us-ascii?Q?LZns+8hE50asB7ikd03oW6i9O+FBMMh/kuU1OAjPS4Byn26Dx9xFc7bVwnEl?=
 =?us-ascii?Q?uCELMKFNRKPzNvt68dgNih+/dopEv19XaBjRNSIof5vWOEjS98ijbDJuRzwV?=
 =?us-ascii?Q?hLJjx3hLfFLysw4TTdfof4OKA6+pzvZ2eI9iXUAGx2+/fs5+/1TukUKF0pq0?=
 =?us-ascii?Q?c2e8I5UAyCFPnmuFrMIALSwk0Eg1I+I9lZvEoSNTHynxaNZvzjyNSM30Ylbe?=
 =?us-ascii?Q?IB6niKK2LO7fdTy67vvUAWk9eZ4s1fDbFXgnKbxKIFHYlWgErz+pI4nnvtUj?=
 =?us-ascii?Q?4BZMx3xwft0As/Y2Hzn8WqkrXxn4dmxVMyZ+YDgI2fXR5jt6ph1BMSIBlpTN?=
 =?us-ascii?Q?uxDrPHvEBrdUG4/Pc+neCHNIvPKjPI5klXyzOS2qOalAMhQIzZwl7nmfZ5V0?=
 =?us-ascii?Q?38lC5OT+9/OMFCR4Y9MtuTBnAGhR4zpP7njOakEXOqvU/Ij/bKM+GjquT6Wl?=
 =?us-ascii?Q?ca0oca761AfxaPJVAf+HKjw16+zmRuKbmxJzgQLz7mr4dHW1KiQDuB+uTPge?=
 =?us-ascii?Q?WzVkHgICkGCkPwE1jyaGkqn6bCTtlfT8JNWQ87Dtu9tX9a9024gmYL72DOj1?=
 =?us-ascii?Q?BrOJe+25u+HZsZ6zuwmFfgzFjZldpp0Lt8o5Ib2qqrywjGDYUoWshZ3/9Twd?=
 =?us-ascii?Q?s5nrzTZlwoBSCtSaQDWHUiLlDT/QQyycr8emugJbI71ziCqIpeM8zNotDIKY?=
 =?us-ascii?Q?ylrATgTU0QuabjV1mqwMAet4rQvyQX2hO7xKh5fLhKUQvLrxeOOtaLlWKNT8?=
 =?us-ascii?Q?FBupV6DElSkkICvWmCsUKq5QuUL4AqOOs9DzDIBPjCMKlq25cvTxGUh1CJpE?=
 =?us-ascii?Q?Qjz3TD2RIM5vdCNd4h4hK6geWsunL5/2rS0daEeHugwxpLZXIFgLMQlCNbIN?=
 =?us-ascii?Q?HaDCHrTorpC89ZKGz9TaWhNvA9yVRAF14mUXAdqFkK6St7n9vrXHDYT5fQSL?=
 =?us-ascii?Q?N+tEna51yeg8rQJQCGfYziW7lWoBNmvbbcG2PaCvsJSi3eBjtlsPUAVCTPlm?=
 =?us-ascii?Q?J7Pw6Edu/+qfJf3pFUueH7DwWvVjQD/PvUtSVq2tHMGwCCdfzr5sf8dqZ21d?=
 =?us-ascii?Q?P/xVKeZltNHGxXObkraAAI49nS9oYIfb+4p1duJor0/3xrrq5Gw0JO1d/FrI?=
 =?us-ascii?Q?0M4pEVcJQ6ym411bSvgpZsNHlBOJWekQXm4BaoHhF/pcSZher3TxrrrRG+zL?=
 =?us-ascii?Q?VMOViNbfCUtTPW+UcALgFbpH1TUcHmzUJz9F52YZyyDIoLXLJZnNuLp+fr1+?=
 =?us-ascii?Q?MXWhq3Z6NGh+2uvBQiZLrnZngOgzYEo+B04ltf/8CQxq4ZBGzkP//IfXNI5G?=
 =?us-ascii?Q?e0md4PGgVRTUfPvYQoLmQrwdKQGuSYelZ5x/RSZMjzcy+9ahZF/PNohsjJNh?=
 =?us-ascii?Q?5TsNERLp8q88TOL3Wr+yWVXUAYxjSZjztaJ7JPXllD2J3wlOVrsUAWY6TNyd?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18672f12-1742-4b23-6c4d-08dadb928d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2022 16:12:51.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt9UCa7linj0ZE4OSEqVezrHNY/PaVglxkZ7Ngl9+ZADb/IpZsITTgdh3OmJMlk83tkO8sh3z6HqglXtfj/i8ETIxuMVM14j1oEaDHYt6i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9863
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH v8 3/5] Documentation: ABI: sysfs-bus-counter: add
> cascade_counts_enable and external_input_phase_clock_select
>=20
> On Sat, Dec 10, 2022 at 10:21:08AM +0000, Biju Das wrote:
> > +What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_select
> > +KernelVersion:	6.3
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute selects the external clock pin for phase
> > +		counting mode of counter X.
>=20
> Hi Biju,
>=20
> Remove the "This attribute" from the description, and capitalize the word
> "counter": "Selects the external clock pin for phase counting mode of
> Counter X."
>=20
> > +What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_select_
> available
>=20
> At some point in the future I should combine the *_available blocks, but
> right now they're separated between Count and Signal configurations.
> This external_input_phase_clock_select_available is a device-level
> configuration so it'll need its own block as well, such as the following.

Since it is device-level configuration, I will move the below 3 blocks
to the top of file. I hope it is ok to you.

+What:          /sys/bus/counter/devices/counterX/cascade_counts_enable
+KernelVersion: 6.3
+Contact:       linux-iio@vger.kernel.org
+Description:
+               Indicates the cascading of Counts on Counter X.
+
+               Valid attribute values are boolean.
+
+What:          /sys/bus/counter/devices/counterX/external_input_phase_cloc=
k_select
+KernelVersion: 6.3
+Contact:       linux-iio@vger.kernel.org
+Description:
+               Selects the external clock pin for phase counting mode of
+               Counter X.
+
+               MTCLKA-MTCLKB:
+                       MTCLKA and MTCLKB pins are selected for the externa=
l
+                       phase clock.
+
+               MTCLKC-MTCLKD:
+                       MTCLKC and MTCLKD pins are selected for the externa=
l
+                       phase clock.
+
+What:          /sys/bus/counter/devices/counterX/external_input_phase_cloc=
k_select_available
+KernelVersion:  6.3
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Discrete set of available values for the respective device
+                configuration are listed in this file.

Cheers,
Biju
