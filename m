Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23C6485A3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Dec 2022 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLIPca (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Dec 2022 10:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLIPc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2022 10:32:27 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27C6300;
        Fri,  9 Dec 2022 07:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNNFeB4mWCClpGCaxjovcoKpcz5Lo475BGB3qSq17ED9boYIISnmy2QKVvgzN/I4yyyprfcIZVcz9lefolGeI4YuAjVaI0OGpB7wJbswp76fNn491NyQ2PY4bs9qG98LIqRqWvUYG1m4DLttcgwOxbUdm0EJODVIlh+zkGaLQ38vGf+4xI6xZKpGuzfpsO3xk1EHNIyo5gMVEx72gNzXjr4hk63t+/hWC/MO0XFcbQeJBslFuhAjxyQfi7i2tnFPKVflPZIds/OdDeVVYScD+wLXg66n8w29zMWrnaWYEFn+moUemE2T1iLfjqEw00+XuokcC6Mpb8CBtrCEuH+7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1jQpVwCyMiJesj9xkTPTiwhB4+cLhVd9h8tDkGyHAI=;
 b=a62MfL3Ek+Hw3JTaI35u5FaDpTlwgxr8RW3HUaxnttCxiFdk+d39faCtDht1hFRFqChMn8JgedeHoxzQ3l3dBworLqTJMwOcAKiLf0/Fzwr9IKp4s48liuinQXP4n3kGC/kn8vJa4lWvare6TlvBbx0GKb5ScjE38biolyxQAL3QGXoIQ00l3ybcQiM8O59V6KsFVAkDVXcxwfqHCVARv1ofF0qymecnq/TfQV3li+n0LDDxiH2zhsidaAQ8AP2Qy/0mrX6O7H9eNsvfzlOmXj2+jFioMYuUHgu4hj6UZTg8CeWN49l1FoEXQlAx+QcQoXlOIvfN6At/JYxspaIGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1jQpVwCyMiJesj9xkTPTiwhB4+cLhVd9h8tDkGyHAI=;
 b=OM+qffAjDqNo8a9Zm8IerajfjC5eV2lNDh5Tzht++PxHRKdOhD5N5ANDEpLG9BhqPvJWTPk54MSjb5HNjHhCWS4+NjHg5abbsIPSsPUpR03uCva9GWPA5+Jm1FUk9VeDOgNOfRtPR82c8MsESqmQ+DHRAXuUUrswldTaxSpmlJM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10591.jpnprd01.prod.outlook.com (2603:1096:400:303::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 15:32:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 15:32:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_enable and external_input_phase_clock_select
Thread-Topic: [PATCH v7 3/5] Documentation: ABI: sysfs-bus-counter: add
 cascade_enable and external_input_phase_clock_select
Thread-Index: AQHZACZFvJ67Pp/xj02hEgsJkmdmz65K+JMAgBrMQmA=
Date:   Fri, 9 Dec 2022 15:32:22 +0000
Message-ID: <OS0PR01MB59221885A6BBC65A4C60E5EE861C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com>
 <20221124170018.3150687-4-biju.das.jz@bp.renesas.com>
 <Y3zYxtelBVrdbQ9g@fedora>
In-Reply-To: <Y3zYxtelBVrdbQ9g@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10591:EE_
x-ms-office365-filtering-correlation-id: ec7ecb11-db4e-477c-49f8-08dad9fa912d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkoq2Q+tHwoJ5olK0V/UUu/dcF7K3skfp1++zmnKjG3pwvnJtRxhp5bbSII/wgiC9tlts3g4OoJkWZ6X+o6OubQLsp2bv3m7YNoYuhAl2/LQHxQTdio0rSpva6eFCyVkvDRViFajEfPJTJqIQolpHdo/HRhK2zrbM3wb5JQz901aXFLFbxnB5cWMhy3jIbOzkbmzMxsB1b2SGyh4Xv7fDGnRPfwWyn9+UO4IRX73qjwX/oyvCGI9YUwvy71HwNZ3OWG3pq+sZ98AIsEg9CRrRVYrYHjlVUjLC1tl2y1pQgQekwkpkd+tZBY+lgB0QjiEv1E7mUkEma022rklVHQ27l3XaTdmenuEDPpalHORwGRGl92JxDNMWR+4jXkSwyuM+WHGSR+fIjA71YTXpOkletumvcPB8xnoEHRGNZJFecnH64kX+Z5/Om51xTxtYDL6ErV9/Y+wSXZDrmEh2LGfMkh0aSZQAXFOgh8s+luQ8Ojnekv5HANGZNXiZwmgUGQGPSejq0ltTQZSgMAsR8ueHsrucw4Ve2Na/0ceI8Nti5WAmfiO3K+mFf2TgeqeQkKPqDXrkpg4M6AWVFzWrdsPgGC/MYXiDQoRqpigpd1uX/rW9AqsyzFQncr50SyK2c8FAwMrK6OPBuEA0bHL40J5l8bz44USmavjTWMfl3SFIEo0A5bucmWiKi07ti1QwVa4Vt+dasnfFfrRlAwORuSmpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(478600001)(71200400001)(6506007)(7696005)(66946007)(9686003)(122000001)(186003)(26005)(38100700002)(41300700001)(66556008)(83380400001)(6916009)(54906003)(66476007)(8676002)(66446008)(4326008)(64756008)(33656002)(316002)(76116006)(55016003)(38070700005)(5660300002)(2906002)(52536014)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B3IK0QuN+3k4+q9csGIVP4zb4u9/ZPqjH49gHgCLZcDcpUvBH6gFpU4zeEqY?=
 =?us-ascii?Q?no2o5/XLCIPPY9lKCqHXW15DIoxCFIDRNN8GeAeGLGeSIkDUdL5WEOtoiLX4?=
 =?us-ascii?Q?wmMwzQ8vBIoYcxNb5cmztgiMDBD6hHpUPPzrvY48smlBJhkGcZYA8xkfAwEY?=
 =?us-ascii?Q?+HiV80idICdsu6zNCc2gI8QX3VJ2s1HQ4CtRX/bSoEU4Mnr1j1r/8jMhyAXI?=
 =?us-ascii?Q?NWNyOLTEBSzRbp+7WfzXoSjmLhbMIcmi5vyqi41VwHz7HG9KBJ11ei/xzeWD?=
 =?us-ascii?Q?IA2plhrexUMDjGKFmFDpFLN8ra4bim+Mw8+7yTzstOn9h6/veovJ2P8NbhB7?=
 =?us-ascii?Q?NKY0zcc1d3/anycQivwmDyV7OLUo09cr6Bds0m8l1jzgjW84nLUqgEk7+Bt5?=
 =?us-ascii?Q?Tghnczs+LpfWe8Ogta+AX4S0VhF7Hg9lXRYukT5gTIQEI5tqqXNrGLw3/kXw?=
 =?us-ascii?Q?n+OBPKvT3PlpIdHvUvwd0Dm1PfKDdb5lWXU4wZg635OTyeVLv02lS6nw1QWT?=
 =?us-ascii?Q?3f2n1CZUnru/w1f3Xm166eqWpAkhvIAScHHQcPIJ7X1SUiN+EyHe1/H1QWJb?=
 =?us-ascii?Q?MBkSL5bylct5UVoipUvDNeKWPXFf1fDYTcnYi1omLu0/YbFaRpDYRDMqL99e?=
 =?us-ascii?Q?NLVoqGI+J+OHm5LzsvT1u2RaxSTT9L8fu8ITM4OzLJwLBbmMoGqfry/GZDjf?=
 =?us-ascii?Q?8/TMQeQF7ugJGQ0+ES17yr/t6nZkhfViD20c/Zk5GzrGj0aEFKYM1zeSGd+z?=
 =?us-ascii?Q?Lk9iLuNGIGaiFLW0tpV7faII4sBsgqldIrx7VvyWdZ9cn/aJktfHwU/LXjr0?=
 =?us-ascii?Q?vZ/8fJuBiFX/20MTyqDp5eTrUI5wPdoilBr7DY+RNUIQAW/LaErsIkrz5jF+?=
 =?us-ascii?Q?zF57d/GfDPsx1f3W/bcA9hAb96KRJDavQHmGnZKtYzixn73rgV1qBlX0evMm?=
 =?us-ascii?Q?Yzwdxh2zKEr9trst1vVfzBVKrOrsHSu78OuJS22DX/aeiJlLSZ4aVgfuVqL3?=
 =?us-ascii?Q?N6PxIoqjsSaz/7OI0c/qz5COS+pHGbVTFGvb4N9MKzuYklzLQUY/9OiqIPM+?=
 =?us-ascii?Q?iMXGL+B6Xhad60dkakwUnHD8rF6RzjaN06rKHvog5FwTsEFqBupNTjdTzlC6?=
 =?us-ascii?Q?AoQZ5JtYN7ZqlYj+sQ6xAuYk9xw7V+cLeg+GhiE4/DAOFs6LRV68OZlnmkkZ?=
 =?us-ascii?Q?GDRYEKLMX4ytNGJCwzr0YNm+8bx1F56fvRaam3ZzQljafqSmKaAQnp0rUkPh?=
 =?us-ascii?Q?24jq8UowvPrW4Iegqt3y614uBGk895H3iHzjyir0Fp0YUkjdk/7aciuuxXNb?=
 =?us-ascii?Q?yjT+CRGOuMn1lhiEeqyr7qY+1glvT5ur6xUCr0AG9WV/gl64odTGyjUX7Gf5?=
 =?us-ascii?Q?HmXFCJKNFMb1WINX4shyhhC83lrIG78lH8bUFCWf4XG4wG43zEgunU6Soz7Q?=
 =?us-ascii?Q?DI+GTbnjDLrYajMoYv6UYxrEh505gBpYeAKadGXE4IpgJvAW9ankRKMujMs1?=
 =?us-ascii?Q?slM9myoB5Svuq3FA1PgNRzcOQa7J+r9g6tfxuyjFqZv+D2EwaGVo3s4q5gir?=
 =?us-ascii?Q?KjdAs7+F4f7rxiRAXsJ9+dYIEPZstDWV/QtjDYyCJZwNQWLDtOhx05eO4zC9?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7ecb11-db4e-477c-49f8-08dad9fa912d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 15:32:22.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV3SS1+WFovFJGR1o+VA8AGBp+mUWtuOdnDEs2yU/h/TJAsOG+V/IgF2dFXVoDjeRwCW7jWJb/RI8Qqbf/j97canaoAZhS5gL+w81aAA0hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10591
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

> Subject: Re: [PATCH v7 3/5] Documentation: ABI: sysfs-bus-counter: add
> cascade_enable and external_input_phase_clock_select
>=20
> On Thu, Nov 24, 2022 at 05:00:16PM +0000, Biju Das wrote:
> > This commit adds cascade_enable and external_input_phase_clock_ select
> > items to counter ABI file.
> > (e.g. for Renesas MTU3 hardware used for phase counting).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I have a few comments below left for this patch. Assuming these are
> resolved, then I expect to ack this patch in the next submission.

OK.

>=20
> > ---
> > v6->v7:
> >  * Replaced long_word_access_ctrl_mode->cascade_enable
> >  * Updated Kernel version
> > v5->v6:
> >  * No change
> > v5:
> >  * New patch
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter
> > b/Documentation/ABI/testing/sysfs-bus-counter
> > index ff83320b4255..abc691b13b0f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -215,6 +215,22 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		This attribute indicates the number of overflows of count Y.
> >
> > +What:		/sys/bus/counter/devices/counterX/cascade_enable
>=20
> It's possible that in the future we might cascading other things as well,
> so let's make this name more specific: "cascade_counts_enable".

Agreed.

>=20
> > +KernelVersion:	6.3
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute indicates the cascading of counts on
> > +		counter X.
>=20
> Add a line stating this is a boolean attribute: "Valid attribute values
> are boolean."

Agreed, will add this to a new line.
+		Valid attribute values are boolean.

>=20
> > +
> > +What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_select
> > +KernelVersion:	6.3
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute selects the external clock pin for phase
> > +		counting mode of counter X.
>=20
> This is a driver-specific enum attribute so it needs a corresponding
> *_available entry. Take a look at the count_mode_available entry in this
> file and use that as a template to create a new entry block for
> external_input_phase_clock_select_available.

Thanks. Will create new entry block for external_input_phase_clock_select_a=
vailable
>=20
> > +
> > +What:		/sys/bus/counter/devices/counterX/cascade_enable
> > +What:
> 	/sys/bus/counter/devices/counterX/external_input_phase_clock_select
>=20
> These two lines are missing the '_id' suffix: "cascade_enable_id" and
> "external_input_phase_clock_select_id".

OK, will add _id suffix for both these entries.

Cheers,
Biju

>=20
> >  What:
> 	/sys/bus/counter/devices/counterX/countY/capture_component_id
> >  What:
> 	/sys/bus/counter/devices/counterX/countY/ceiling_component_id
> >  What:
> 	/sys/bus/counter/devices/counterX/countY/floor_component_id
> > --
> > 2.25.1
> >
