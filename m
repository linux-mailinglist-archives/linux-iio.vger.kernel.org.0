Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30B57CF431
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbjJSJlP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345017AbjJSJlN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 05:41:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87512A;
        Thu, 19 Oct 2023 02:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h96mBg5W+v9+tSp5D9T00lzoe7HXWsNmtsq2hs7dGV7cZXAVT1yP3hBjq+lx7KBm0mii0eME0DoztVXxLn5FXMc4PkLr1VdU9tqyYQR2JEp5pugcWLeMTehdkfdvuNMIQZnF4k6tErzCVBJ14d/zbTAsjQiM+LY3ZfbQJYzI2gQXFI+KmovceC5Cb3eBsNLcLhGZfh5AOiQQQZ1MCjKpPZ1eP1WrxCF9I7amLpptDc5OZ4FUbTlgGFkKvNVUFazJteTqdYtAWbG2uZP4FCBbamar76ORhOub8yREevjxggQM1xUEf1IbWsVVFx0im9iCTiMQGBLXw8k2C1zBVhpsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji+Akl8OAS6panMWOuaNVWh3rBm0aQ5PPyll9GSPvDU=;
 b=ZwppmJZwrR2O1kLREp66CYlOvcW3F0lwipVmeN4Pv5HDLaUq/3/y7+4B3tDSqsj8bzOm1rxIAUaF/gc/Ixk5Juk8ZpulleEffMWxjccTmytWaG9/u8QJ7ODT2xMJBDy5xq8QJaOH1aoj1n8r+Ja4CfIncCrDMDRWrGLvwgay/rQzcrXLVBGY0Vmjdty2RGExLUn630t8RV0eYI2sShHwHdSathGERzg56NclwnsZJstK6+jUTvTNaiLvb1IhkviMgfyCps70rfsgsk6Qr2SQkAuA2JxrH91+4+m700T+euO+aqNrNy4ZjP3lRTfkodofv3ZRHvMcFcIl2EmyZ/lY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji+Akl8OAS6panMWOuaNVWh3rBm0aQ5PPyll9GSPvDU=;
 b=wW6YUF/oLST/oeNfJy6nhZEew2TBZtyKtYF1rRNxb1ao1wYoSOYc3SjS8Cuhsu6+He6rBIEra16Cn3L35SqHlTwavQT4y0sg5jH8KmVEWE03EToG7cbU3QTtNcvVzyroXzyd+2upeCPhQS5pcHlPSegCtmcv+mOL/D/qs6E32J4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB11737.jpnprd01.prod.outlook.com
 (2603:1096:400:3e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:41:06 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c90e:cd43:c967:5218%5]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:41:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     =?iso-8859-1?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Topic: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Index: AQHZ0al0blpUu/Wm+0SusYyQOb+0BLBO2cgAgAClowCAANSSgIAACZOAgACvvWCAAAQnMIAAJZEAgAAEsqA=
Date:   Thu, 19 Oct 2023 09:41:06 +0000
Message-ID: <TYCPR01MB11269269A3237CC119644F4D286D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
 <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
 <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
 <20231018204533.39399b0b@jic23-huawei>
 <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
 <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
In-Reply-To: <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB11737:EE_
x-ms-office365-filtering-correlation-id: dc8415a6-7f32-4673-aed7-08dbd0878489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O10AiNYLKKjPCHlOOqLI6aX0IXMoI4JAUV0bXHgxs1kcnSYAH0gqkyBc4HN0EG6ggeFLKqhUI3h4GO9mqAnZgwtTlwr1vcud+u4D/NSWR94yLPi272EvuNklA7ds3JnWonnhJNgOZ5HdEciEMXV+LsKoyjpSPr5WLJWWWLimZ4EUUkbdMdpAF4loS8W/UmsxDYPadAzREVtKqpbk4ycZLZRZNyU10sY8jf8wOsyyiVwCDWs36mFRAq+9FL933f6xOjLS/WZPZYtQNGrLMyco4iqngk8NR8b5tO1LRVNy17E/aT2E8VvduiKISvxzEnr/UgMKP9BuS8ANKMw1nvyaEoMAimfmHPDV1xemrrezFr3fNN72LrlKgQjVi2G6IwlzzOMeGxOp3UZZR7qcXJUAHCcYuimfDDKeK3SFEV9R2bAnSpAPuNJ4BtYiq25/m00gXIXyfLGPwM6SxflnMZHaDJbC0+7wSCQoJcfHrNAnpAQV/ShcdaUbh02S6w9pB6FIeL/GzfezJxXPwaJ0HZxuFfQEj6sNpulWefoAajEGPEqYFBn9ECRpsWf6hyYPfmnmrWL94kS65PD9Fz1+h2gLYSzDchp95d75uoUg+02nSDzgziw6u1/EJMaXgsWK5xnp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(38070700005)(9686003)(71200400001)(122000001)(6506007)(7696005)(478600001)(26005)(66446008)(6916009)(66476007)(8936002)(76116006)(316002)(66556008)(8676002)(54906003)(52536014)(64756008)(66946007)(4326008)(83380400001)(38100700002)(41300700001)(33656002)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cu/ecWe4gpfVL85djblvabtpFItqoPjech6HwFt1ExBG2aD/ZJHE3RG+td?=
 =?iso-8859-1?Q?sIEd7ilox3nxVw3xBSUf2y2qlxuiqt61iKgPoZN47xZoTCA/JJotOwzLVp?=
 =?iso-8859-1?Q?SLlAqHcU6aiOs9y3A13G78LRokK0sZ80s3YmE2UIUR6eC6tQOaBtXLBbb7?=
 =?iso-8859-1?Q?Pe67tpY0+fAFWoud+H7ejdC234PJ6l1WZlsWE3AOTpLkkf5nK3uMY+OFp2?=
 =?iso-8859-1?Q?6dgTTmPVU/lOEddnt26fNZ0SWT1cE+wif2jYPfLc1s3Vs6O0pfVqhbzL2E?=
 =?iso-8859-1?Q?2Qqj3QIUqBkrtu9mUPM4jCdK90f5EhG/Z+tHCir7JDGWvHArjj+tJPiR3R?=
 =?iso-8859-1?Q?ku/O/BSwA/6Y4zFQUib/8tTsJP4rJ/Hd5UK4ypPOaYRVqc5EoCjfJPYkVm?=
 =?iso-8859-1?Q?Wcjs3C30JjkXRpy9jhcRt2EUr5zIIWiKCypurHg0kBzpVhOspUvIrTQMJy?=
 =?iso-8859-1?Q?aJ738bGRWSMptGuKoznjDMFJZEJT5e6dJ5ooSXfd1hpY6IirL/7rQTZNOE?=
 =?iso-8859-1?Q?VZjxMqCguWsGEusM6EWUCV/RmIcIcnHT9r3L7/EYmSDuXBWoplGlPB3KTC?=
 =?iso-8859-1?Q?4hZRaGE7r7KVhcYcLSVYF0eXKDmKi8VMq0LWoLWDaxvn+1/TCJDiOaA1DN?=
 =?iso-8859-1?Q?61dXGxwpNfLb1HP6lSVFX3RL3GLWJXLd/RiejgqQ8L2RqlkV51lC8N+5td?=
 =?iso-8859-1?Q?JUe1+paxHOP30bpu15arHW3TtuuoE+dTQnx4TvsSMxkT0oNRDV9v6Rsg4+?=
 =?iso-8859-1?Q?xVcf1iNy9Qhplip6H92P0ZvDyetbBFvmgDqkBml/7T3ohGJJGhukNQnqVk?=
 =?iso-8859-1?Q?FYIVRFWxErQ0MCl8WxrQdME9ENLOD3gDdlZLsEqionlDDeJKazG9IgAHJU?=
 =?iso-8859-1?Q?QJB3lnf6dYVNJoIyawvGx1IDaIbAcra6ndp1m/+8nqyWrnZJ1RySfZ4DTZ?=
 =?iso-8859-1?Q?xGkRYVbChPZEV2j6mPmpgxxUezbJ0p2dFnH2uHwCL/l5VeC2txSE6B2/19?=
 =?iso-8859-1?Q?yanW8p/+jwRIdkZJRgOtrb6r2M5gFVKtZI+bdz8Ozj0R2ZxzIKc6G+zIDs?=
 =?iso-8859-1?Q?RqpspF82g2o9Picdrn7bJadK/RDCo9wwBNq57lEr3x1nNvRHlFzDbOl0bz?=
 =?iso-8859-1?Q?Zbq2zI9+8s8cf+BkXhMsKsZAnkNS2EjokZ8yeXwkCZyf7M+wwCjgsdD+HE?=
 =?iso-8859-1?Q?nry9cfjBETOBmZGa8721EjWmUIlkBoOBWjg70AwYhQUFfUh/ekDUKMGOpR?=
 =?iso-8859-1?Q?OoKLN1QBwYQze6pcpfVfjRdbu+UWlQsKIsTqCbIMPBXoYlbXCT4Bdrfhi+?=
 =?iso-8859-1?Q?llpm+E2C9mL0WdnnmEWoO/kqEadspOxPGDZKCx9Jifpp8naxpowg8QScx+?=
 =?iso-8859-1?Q?uwkibxopFj+s4YXXIhHTpBSdojIXqE6FfHXYpY2vVgktuECXq0i+pXJIF9?=
 =?iso-8859-1?Q?iyOVVh4cOzICAt8VvIR48ZvV1qxaUkRXE0WpiusMEh/eZzJR8aZ14xYl5i?=
 =?iso-8859-1?Q?nB2yGHWXo8s/YFSQoTSMnMnooA2sROqlvKU86rHvaktGabhV2mnxWWwZbc?=
 =?iso-8859-1?Q?r7xbeBFfqoD9Jzw+C7xQ6ohDZciao/2jYGm7j+f9I/YCtQrsOjXl2bu2V8?=
 =?iso-8859-1?Q?JD4BdL1wygLU2bPR4VYEFgXxBa6mstbPRWPs9tdyCd3ZlpzzjDBtPYYg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8415a6-7f32-4673-aed7-08dbd0878489
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:41:06.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQSehWXF9G8BRZOD4oKcjn8YMLMtgmHp2Ealb3DBj29xe9etMKT76jIPG5PA3nD6Vr7AoBzFj+Mj5CVpLzfVzsaJp+rGxXQzahPFtMS3XW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11737
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-
> >pointer for data in the match tables
>=20
> On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:
> > > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-
>=20
> ...
>=20
> > > As mentioned in the patch.
> > > /* If enumerated via firmware node, fix the ABI */
> > >
> > > Looks like this issue is not introduced by this patch.
> > > The previous code uses device_get_match_data() which returns a match
> > > as it uses DT node and it uses dev_name(&client->dev) instead of
> > > id->name;
> > >
> > > Am I missing anything here? If it is just a test program, can it be
> fixed??
> > >
> > > Please correct me if I am wrong.
> >
> > I just realized that there is no .data in previous code for OF tables.
> >
> > Maybe we should add a check, if it is DT node, return id->name?
> >
> > Is there any API to distinguish DT node from ACPI??
>=20
> Of course, but I discourage people to use that, you have to have a very
> good justification why you need it (and this case doesn't sound good enou=
gh
> to me, or please elaborate). Hence I leave it as a homework to find those
> APIs.

Andre, complained that his test app is broken with this patch. I am waiting=
 for his response whether he can fix his test app?=20
If not, we need to find a solution. One solution
is adding a name variable and use consistent name across
OF/ACPI/I2C tables for various devices.

Other solution is just add this check,

if (dev_fwnode(&client->dev) && !(IS_ENABLED(CONFIG_OF) && dev->of_node))
	name =3D dev_name(&client->dev);
else
	name =3D id->name;

Cheers,
Biju

