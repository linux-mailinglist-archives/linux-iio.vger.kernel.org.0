Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B235FD44A
	for <lists+linux-iio@lfdr.de>; Thu, 13 Oct 2022 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJMFrg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Oct 2022 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMFrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2022 01:47:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36111BD9E;
        Wed, 12 Oct 2022 22:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZtzyWRJ+nguM+elJgd6bdlp48MSh9o01ND1iRc3wTlHz7lMU/15SHyukhnXvUJf1ODcvwNE1lFMvS47xmfCLjUrvjETfk3stYBA4Rsmnc1YFEHtFL3Ofl/fKr8HA4UaqgWOqxDTds6qf+NRrz5KCif3Y8XpKG7XlCWooF4aI024L9yjp5M0+CHUXgkxw2jUOmUrwypax5xmi8D7NqFjqMrFuwYYSmAxSSJZhSg+a/09FJFDmMH4UF36ucGlpiw7rQbSscn0P/RiaS4Cv4p5HgZSRiIBOV0ryp0e9EnVvmJ6B6iQDKN/uVU/7z6EBo9JWi4wbZHRXchqVL/z4hbaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmGj5OwEMhbxqiXo5Rbcr3fvqd/QFTGfCasf81ySKYI=;
 b=cbXEPQZa1cF565BaCyubKkBs2JGDc/kxsTHM98Z14CN7dpnYnfpWy95wiV1eRK3BwQNqnKTYCi0E+c/iLfkgXe1vmWsiN9bwkWoc2AVpXYvVHJEFLd+A1+WEjCxrmeE3d4/YkgG2yTWee3H89hKxaA3Xi0DHINz4q9OKpGc52E7wWQBrvqRNXTAfYTOItoV8K3ms5R86E7zpDrL+qOlxOQxpJD5YBLVjt6lUcJvSZL2byG89E0kx9tnJlOrT4wc0k+g6LYxwWiFMT0+q8qHGL+W0MaPuJNNSD7kMfmScg3Px32iTwuiyWroiObvjkdtddVw/LVL5lWQ81NFJOhCtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmGj5OwEMhbxqiXo5Rbcr3fvqd/QFTGfCasf81ySKYI=;
 b=RfuARD7X3SIgPVSMUQOHRAYShesvKShkczxkMM6L3U2b9o+CLuc55ZdBLMYqqSGZj0U8Df/oi4CUIUoJWF/jUEaK9FkufAGHG7viO8oemYgMVjpU48U9GtCpYgzdn2BLBx3yzB6VsqZsW87kRaUCq7ApsrOBPkMnPV5icMZ3o1c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10310.jpnprd01.prod.outlook.com (2603:1096:400:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 05:47:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5723.022; Thu, 13 Oct 2022
 05:47:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY2YuZOjF5ExCDW0e8KGUbGYk53a4DudqAgABULJCABSXXgIAAHhvwgAIt2gCAAFr/cA==
Date:   Thu, 13 Oct 2022 05:47:30 +0000
Message-ID: <OS0PR01MB592248805261081DCE3F4C6186259@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
 <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0VsWdrpoAhM2jK3@fedora>
 <OS0PR01MB592280D15AF243C0A5FA93CD86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0dZkOAGlVGKup1v@fedora>
In-Reply-To: <Y0dZkOAGlVGKup1v@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10310:EE_
x-ms-office365-filtering-correlation-id: 7d8f0b1a-d0f3-48f5-9ab3-08daacde6b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n162CRg1J1ue/TcRWwd/lRa/3fPX2n5/ShkGFEgYLMDflP6pLcg5en652MYslVYJHfz/cWPCUyiHWz4DbfuzIAQ/iKXZTxYhq0fH3NvosJ9/rYWq+1tt3DmdwilennrF3dBFTLVU+jSoTLFKCTLHzKOscN25+JWqyxHfq2Whq3Bn/G0/IswdEsPNCt7H9QaKCz3wQS87j/pqA4HuzoZYfkiuSFQaz3XXty2z2UpvtQDqFp2ehsM5/NT2Q0xaUH1tV7CAM97IFPGXBWNUvLFOR1qDZRlpiA8+ZE664XIYAz2tUmNrS9ksfOZnKs7tMD5d1O9eNhtYS8rxR2ZxdAY8W2DW7o0RygDkbNNuMEb2sx5EnzR1NfCsEuNuEVTfilKU2NiS28owxfjBsSONP6TZm+uYUmVY2bPV0b8O5jWhZ4rKow32vWCxcWn4j5pGXPpxkQZ8CD80JKJGR3upWVXBgMHSqti2NQ/T/z1HcmDFrO4xu77S3c3gFMQ5CpUMyAZmFF6wfI8kuDD1zNdtTDXoFK8YUdpUs8HBOSMkawb1TwFqTW2tkwY44iY065SaqxKKYPuHGf/5e1aFVfKbEKQcalHE2Jlb5iJ0FN8TfRK+ZKL3Fnqfe4BPTBfXOYibtm+zuo4AQqMXtvsa81TUeNiXY1Sn+V4ghf3l0ZLHxzAVkjlfSs5I77b92HtWrZ9UusGyO1oOwaWt03h5YsZ0ccR5nQlTs0tHrrYpUWryuFk1PYAcsVvepXyTAT+s7ujLCvP8ebytOcGZwSMWd6GaObhIJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(66446008)(66946007)(76116006)(66476007)(66556008)(38100700002)(64756008)(4326008)(8676002)(122000001)(186003)(2906002)(86362001)(7696005)(26005)(41300700001)(55016003)(6506007)(5660300002)(52536014)(9686003)(33656002)(8936002)(38070700005)(71200400001)(6916009)(54906003)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?libm4Q3MVY+uWUvazMyzE7lyYhf7XdbiUs9jN0GOCNz0k8073duNhaRDmts8?=
 =?us-ascii?Q?3FrtAdnvaNCCsvxG7TYsP1OiEKAEw8yMEB/Bzxo8+lR4RqvKM1EF84VjQhL0?=
 =?us-ascii?Q?vXLenyUAbGM4RaGjQyHN51kfLpkn9trmA8Ds8MckzxYYEceLJZiDu1/VOnWq?=
 =?us-ascii?Q?Dd3/J5lzFwqSNBvdGZPro1w6GX1IlRKb99Bw8ljdtVNCFeXrqWPry0YgplMa?=
 =?us-ascii?Q?vAkAS0FlH+/0sb06MiFN5eAfabh6vmKPr7V0SPQKJg0T4t51+Y+TGSj+4taM?=
 =?us-ascii?Q?zsdBTqDDoeaiLfr3lw0iCIjcheVK3j3qQir7IP/DTt8QNgWWAaaxUXiQ2Zo/?=
 =?us-ascii?Q?KvJQAigZYjQkV8f9/iGJMbwNy2PfDMYXFI+FAq1iFEAUQTsixPdCsiZmZQ1s?=
 =?us-ascii?Q?Yr/FezPQLMcCXSwqIZ2aKTg7QKYkz4M7boEIcaOLoNC7/iSQPCrscz1r5wV6?=
 =?us-ascii?Q?l6WcETD2omlT4wTsK9KRUxeWUas/rpt13C3H5pm1yphUolTBSpfUZhm1NjVK?=
 =?us-ascii?Q?RXoDgXrDmbZoV6I5nzFXHOCcCKW1dVS4PLL11QbJPhWQlmJZJIbOGRNKLJZQ?=
 =?us-ascii?Q?b1WMP2/+OdETzKZSHb5TVIsk+cxlqs7WWDdq0EVByLhm4x04M7Q8M+bEQxEd?=
 =?us-ascii?Q?jVV6hzrA2DdqC4k03q5VeMPUM6pahMhnWwwXivB4f43Fvol06HitLaaBwE8M?=
 =?us-ascii?Q?DwybJnNESpOszLv/nMqxwTDyVw37x9rMnmIbtsyWIO4twFwcZZLgcQI55uMp?=
 =?us-ascii?Q?UoCtXYXydF8Q2bG1dBDvtPTicvaRbRlw51G6BLSo1JLNjvt9P3HQQvWWzIjv?=
 =?us-ascii?Q?AHAOvQ/nTVAmXkBt+BfdsFz0LJiQCH1ZFwA/OlAgHOUje7KotzEYEuuA2RmW?=
 =?us-ascii?Q?QcE95RH5d89vjhfXLEzYoS0pNsa4zlvHm5YzP471nehI3sDbfDsm4FkPCmnF?=
 =?us-ascii?Q?/4j2Dq8fOWuIKuN8lPdZPOEI/3zgjS0k6WOTa3rGrFCfhrCNYTTaDirzFt2M?=
 =?us-ascii?Q?o7VVDTqwt9SHH3SMXyIGPACDTo0ZoLrNRvMVMamSUSO6QaCN808r51hA8cj/?=
 =?us-ascii?Q?8/y9qFarB3k/Athr4soUHXy6QowFpneea0n6Qu15reRlusP7xu7PAjrbvONS?=
 =?us-ascii?Q?HMW6sz9N/oC2j7LrHgLwCHbjWOppUAazhizjhHJ5SDLiGE15MxbxWcuevmAx?=
 =?us-ascii?Q?X8J6xKcXNxxMeBNwz82PnzZxqRJfVgVTGhV7ospfXXutpcFtYJdFSK8Umvjo?=
 =?us-ascii?Q?j19fhy4U7C8AnkXsbUYxw3LlUUd8oTyJu8C7OrxFdQe8PpD516qZH+YzhiK/?=
 =?us-ascii?Q?SzMvZhqjD6iSlBDQ+JZRiLuhvfzb5/4vC0ppcmBuljNB4sOLQ1e1SED83/4W?=
 =?us-ascii?Q?XvV8mCHeQH/WRSDziqEyMYXBipX4ZuXWrFrnmJGowpViVeExeRawF/Dpqkgg?=
 =?us-ascii?Q?x1gWKaX1EyvSPbKDJ1Y2O8UiGkxUdpmdwbKsw633aEtJNgXnOKsDslEFARbF?=
 =?us-ascii?Q?xK20rp2BxuXGfH4EpXEfbAmD9nem/bqwkBvg0hGCH1XJVrtWspjXPpsS2HFo?=
 =?us-ascii?Q?AbhiaYVesaVjeZLzex51nMoswP/ihjynfBv2JYmp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8f0b1a-d0f3-48f5-9ab3-08daacde6b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 05:47:30.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSoN7pnMAf13dZXQKsSoTEBDp2Oqr/kvxQ6TwulhAKG7prJY+wtgGLNGvtd3zWTqjnRFy2SyPHCuKz3yp39S3u15okII5M35HHvR3CKtum4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10310
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

> Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
>=20
> On Tue, Oct 11, 2022 at 03:50:38PM +0000, Biju Das wrote:
> > > To support the phase mode selection, implement a Counter device
> > > extension for that specific purpose. You can use
> > > DEFINE_COUNTER_ENUM() and COUNTER_COMP_DEVICE_ENUM() to create a
> > > device extension that will allow users to toggle between "16-bit"
> > > and "32-bit" phase modes. If you need help with these macros, just
> let me know.
> >
> > Yes please, that will be helpful.
> >
> > Cheers,
> > Biju
>=20
> It'll look something like this::
>=20
>     static const char *const rz_mtu3_phase_counting_modes[] =3D {
>             "16-bit",
>             "32-bit",
>     };
>=20
>     static int rz_mtu3_phase_counting_mode_get(struct counter_device
> *counter,
>                                                u32
> *phase_counting_mode);
>     static int rz_mtu3_phase_counting_mode_set(struct counter_device
> *counter,
>                                                u32
> phase_counting_mode);
>=20
>     static DEFINE_COUNTER_ENUM(rz_mtu3_phase_counting_mode_enum,
>                                rz_mtu3_phase_counting_modes);
>=20
>     static struct counter_comp rz_mtu3_device_ext[] =3D {
>             COUNTER_COMP_DEVICE_ENUM("phase_counting_mode",
>                                      rz_mtu3_phase_counting_mode_get,
>                                      rz_mtu3_phase_counting_mode_set,
>=20
> rz_mtu3_phase_counting_mode_enum),
>     };
>=20
> Using the get/set callbacks, you can get/set the index for the
> respective mode of your rz_mtu3_phase_counting_modes array.
>=20
> In rz_mtu3_cnt_probe() you could set the counter_device ext member to
> rz_mtu3_device_ext. This will make the extensions appear in the sysfs
> tree for your Counter device. You should also add a new entry in
> Documentation/ABI/testing/sysfs-bus-counter to document this new sysfs
> file.

cool, Will do it in the next version v5.

Cheers,
Biju



