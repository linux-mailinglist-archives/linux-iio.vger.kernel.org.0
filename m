Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812CD643F33
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 09:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiLFI71 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 03:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiLFI7Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 03:59:25 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB56FD2A;
        Tue,  6 Dec 2022 00:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4wJFTUQkuEQbyEBYvTb2HUkcKlwYwXR0ZAmatR5HpOvgCoNASMhj/4m44cItoXddDQtnPi9NiM6aDCCFseNKVr95pIK24l27ONwt2lxodfhbWqUefJ1MSuski+SyRS+GpROY/CsC7yVeAydAkehuDV4JsjLxfUTP7pagSaIMFXB5AcTOSx2GeZw94R0w5Oy35q+N5Y0SBpCeZZYkZ6y95n7E4n7GbnK3P8rle++4v0c+LdAS5SxVZ0hv2nHxmlbOesXLlPGXWfZIVSd67Oq8Ocgxme/YYq3VIcb7itmXeJR7+uVnksed2KSUu5SbOVp/BGo9wEGPEg0dDpK+zfZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1FsumKjxG9rS8mvzphUdD9oYtNykrYIMkSDcOZes4U=;
 b=IN5fOyItfQgzW76NJaTA6quTnbaMY9+GXpcqE4H8T/SICIJDIO7ItCCLPrT2XmKzQpom5rpZ/p9pP21M0DXVyXdSgCL17KcTsDhVmOg9mvEI4eYfNqyhQiFLGKIgT6CPb+SaWgfKpqum5ZVMI6TXe3oL7UFyQF9+HzLvUCm2NhaXvilcSFFHKu8Mk/HGSreqJ9XIbVy6Qx45LwcVDEZr/1+KhhN6aXt271McU2Dbk+6cCGXUWRSG3Amw16oQthghAWYKs5o9LgxXGqV1H1RnasWzCj5alVxamAw44vP+Qd2pSC14+BoiIBtRbRgsvCtHdsFC/tpTX7lb5BZ2qRHu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1FsumKjxG9rS8mvzphUdD9oYtNykrYIMkSDcOZes4U=;
 b=sMSgIJgLqrCyQeACfWWihqaaetY6TA8fflXs5bDLqCOtAYBU+ctiQ9dr4UuTTesxy0rgt0OEuDZh8NsJGU84EgDB0USOwdQGot9odquLFQVicEt1IY59ujONPr7l5H+MHi+O2f4t6YVk5psqt4fJatukE6D7+BoltNySJS7+268=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10306.jpnprd01.prod.outlook.com (2603:1096:400:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 6 Dec
 2022 08:59:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 08:59:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Topic: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uCAAAzJgIAAAKdQ
Date:   Tue, 6 Dec 2022 08:59:21 +0000
Message-ID: <OS0PR01MB59222E0540F9A813B55C1905861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
In-Reply-To: <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10306:EE_
x-ms-office365-filtering-correlation-id: 8e26ee49-bb72-4c91-9e05-08dad7682a45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm30yMMkMMISl3UlwvpezVDznlHu2W/NlnwhBpVORpXWn9K8LLVRJosdKRLnfvfF4UQHgvRva1X1z7ZtLDdWdbW9uQJZjfuCjqVYVQqTp+TCpgpGIxg2SOwXeCawsc+VTjdYSI90TJMgx0RezSorrdeCdkeCywL8iAfP1dfXvWF/OVNkeH3EyZWaqr1gY3p48dxrrTWbEvqI/grScsuKxKZm5DTx0YBX2QygGE1Pdc2o9IKBlvs9LgxSK6S/V9jLIDwQipmCnpTURZniYmtcsIwv+rX6bPqln/LJi5sY1xaqoDK7uW3wF6TPypCdMUm5ZIMuTws5hHGnn1D5vgG79u4CNM7gVLSzNS0G4kcgvf0QSdZEV3KsT99nwPOc9I3CMwhTOeRT83ICgahSxNvHbA1dVRB3zBMl/3zvPWAHANvbt0eScZQQZwl4j8ap+TS8F6etYgU7YAL+Rf1AoLuya9jDl4aKaV+eCQM92CtGADEPLARkzrOYbwWt2ibY1U9Uk/BgjIFUL7LW918UbIvSzkzRrLYdk7+01F+rUwZycS9k1IPgWYlGBnBIOIfpvauLjWps9KCfK0iw3BNIoNPL02LL6veOLJm1OtDEFWD/SFF2oxtcILHp4bj7TXUtpFaVNhep31mD5QXDxC4Bf7edjYiPs8dZSFbHlVcRkYz0ILX2PzPXwE+gg4Q5zzsDTmeJdap/att5EWEldHAlItZg8ZPS0AY70ZDsHP55SXjUrzc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(9686003)(54906003)(7696005)(53546011)(38070700005)(26005)(6506007)(107886003)(478600001)(186003)(71200400001)(966005)(7416002)(122000001)(33656002)(38100700002)(86362001)(83380400001)(55016003)(6916009)(5660300002)(66556008)(64756008)(76116006)(66946007)(41300700001)(66476007)(66446008)(8676002)(4326008)(52536014)(8936002)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXBJaHU2eXJwbVMvR0V0TnRGaUVOWStRU1plc1lPZ1VUVVMyWFExa3NYZFJm?=
 =?utf-8?B?SDJQSnExUkNRbEw2RjZ6MFpQdmRTRS96V2Y1SG9PY2Nvak5VZ0xoWUsyN0hz?=
 =?utf-8?B?WmhvUXlaUXFIcTR1ZnJzdnkxUS9hUWFHMGRTSTROL0VLWGViN2N0V0dJaWls?=
 =?utf-8?B?Zi9aTGFiT2h0ZUZDL2p6SU9XaUgvYVlkakJNVnRtNHYrdTljdFNTMkg1Nlg0?=
 =?utf-8?B?N0N4VVJCSHNUWE9ZWXcvL1MxaXNrZmhrTGFDa21HeHNUYXlWZHRvb05SbklL?=
 =?utf-8?B?VFUvSGY2MU5kL0N6UWduS1p1TjN4WnRnZGZKVE13TDRFcEdvdi9jVHB5V3VY?=
 =?utf-8?B?ZkNxTFI4QlBUVHhIcG5qZUJqM21JVkcrR2RmNDRzU2RjMGV3MzNSV1JvSDZn?=
 =?utf-8?B?aG16SVloMFdMOHE5TjRJaWZ6eURwdGFjcCs2UjZNRkczUGJ3azh4UzNzWXZL?=
 =?utf-8?B?YzAyYUp0TXUyVkVua1RCUzNSck5Wc0cwTWNWb2VaNVdKZHBJT0YwQ09iaXFE?=
 =?utf-8?B?aXFMd1pjQVphK0lydEtUNElicWE5UzBhdnZLSGUzWjYrS3pzUTZYU0xsZHVD?=
 =?utf-8?B?akxJRDgrMmMrNEhtUXhWSU02UjlMZ3JQb3IwWmR2K3NFazNYR3g0dHZzMGMz?=
 =?utf-8?B?NXNWeWd4NGt6bWlKdHRnYzVWMHBmQnZTM3lobUk3d3B5OHVlZnNlUWc4NHhY?=
 =?utf-8?B?dDlCOUVEa2d6endNMXp1Z05BanB4bHkwdVgrSngwRXkxWXhjU21GcDZPQTdp?=
 =?utf-8?B?OU9XenNZQTdtTThGenE1V01HaUFUMnFuc2xQT0tRd3VOQnJqMG1CK21UdlVx?=
 =?utf-8?B?OFdaNTFjQVU3L0R2TmNjWENhcFNtSTFuU25YNHE5TmpjVitpV3Uyc0cyTENL?=
 =?utf-8?B?bW5seEZSK05XUE4vdDMvZjRvSVJQK3g3UXlBR2xodkMzNTFCZHpGNDhKSHRG?=
 =?utf-8?B?ZmVURUJ5RVBzR0tlYlpWaGpDQnlORCtNRFlkZ0tLZVgvUEVUeEJUc0RwYUVj?=
 =?utf-8?B?UG9sSVdNWjZGOUgvU0V1QldDUUx1NDdIcEhxSHlkUERsMmtIYm5Ca3VBL05F?=
 =?utf-8?B?dzQ3Q2pzeEpsTnVxMlo3MW9jOENsYTN5MytNQVA0TGhSSTFiOTVpc1pIMUwx?=
 =?utf-8?B?ZUVPVjA4TjZqdHczMnk4N1F0eVJKSlhxSVVBemM4eUV5bkU3a3FOT25INDRO?=
 =?utf-8?B?NTRNT0dJRS9rek4xRmhHandJNkdCcnhzQytVWlFvVEUzTXl4Vk5zZWJlRjU2?=
 =?utf-8?B?OTg0ZDMwNEk3TEJocFF4SkExQmhFQlA0d00vMTViVTRJU1Myd09nWk9MTUlD?=
 =?utf-8?B?dHVXZTJ2ell5RDAxd0xIblFmN0I0NUJCMW1Dc1hNWXdWSUxocU1ybzZvV2ox?=
 =?utf-8?B?Z1p3M1U3U0RiRDRkN0xtYlZNUUV5RHVRVzBkUTl6L3RpSzd3NDNPN0FSNm5l?=
 =?utf-8?B?VnFDb1c2QjZDakNDZ0ozNUpHN2J1ckcrQnhUQ3laSUNSNHc3aithLzVIZlpR?=
 =?utf-8?B?cW1pS2hZb3pwSmN6eHdrdWtnUHdNS0tEZWI0Y3lqZWZ4QXBEUW9yK25MUFdh?=
 =?utf-8?B?L3JWaGJPTG9ja2lQbk1iZXlaNXUwNlpIUG9ab0VldzhWTjdGcEl0T2NXMUE3?=
 =?utf-8?B?bTVSeEFDVGhNM0dZbzQvY3FiR3dNVkFKZW03OHpRZ2h4QUxtcWpMWDNhd0RT?=
 =?utf-8?B?VGFiZGt1K21sUloyUG5rbEZFT0lvS0VaU0J2WktmUEg0U3dKMVlDV1VpUWw4?=
 =?utf-8?B?NGlTQWxOcFhyUktxbkxMU01qLzlzdHJCTzMxaVdZSk5Qb0Y1clFNenRPdkQ3?=
 =?utf-8?B?V2xySVQzWXNJcGovUnJab0NZU0lUQ044QVdXRU5yMVp4Y1Q2TEdFVlZCNnhl?=
 =?utf-8?B?RkJIRGcrcFJmVVdweXFWd0RrZnZOVk5FOHd4SnRuNURCWUx4NHhMditoMjdS?=
 =?utf-8?B?bXcwbkNaUU10VnVIWGVTMEtNeXV5WkNONWxJQzUwSDZZRS9pdndpWExJbGkv?=
 =?utf-8?B?dmlPM3Fpc2VtcVhrU1EyWEFRWXVJeDNKZFJWK1BZRi9OZFM4eDN1TXQzN1ht?=
 =?utf-8?B?L1JTUFBhcnVWUmVkWUU1aitqdGpYOFg1YUoxZjJSdlNQVVBIbGg5UFQwdGR0?=
 =?utf-8?B?eDZwcGdjWDNabEtmT0c0Y3YxT2MvL0xlekR5VkVDQVcrTFNZaVNMbFErOW81?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e26ee49-bb72-4c91-9e05-08dad7682a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 08:59:21.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTmVeakD+uObgeJxTHjaGBzy1ggKMTy8h6OINWElS0QL/81gQjGO6ZJY85m28+nacCbeLhrv+phBlwP3br3FoNoFfr845XJACxq8gSsiCQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10306
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMC82XSBBZGQgUlovVjJNIENvbXBhcmUtTWF0Y2ggVGltZXIgKFRJTSkgc3VwcG9ydA0K
PiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFR1ZSwgRGVjIDYsIDIwMjIgYXQgOToxMyBBTSBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCAwLzZdIEFkZCBSWi9WMk0gQ29tcGFyZS1NYXRjaCBUaW1lciAoVElNKQ0K
PiA+ID4gc3VwcG9ydCBPbiBNb24sIERlYyAwNSwgMjAyMiBhdCAwMjo1OTo0OVBNICswMDAwLCBC
aWp1IERhcyB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWltcyB0byBhZGQgc3Vw
cG9ydCBmb3IgQ29tcGFyZS1NYXRjaCBUaW1lcg0KPiA+ID4gPiAoVElNKSBtb2R1bGUgZm91bmQg
b24gUlovVjJNIFNvQy4NCj4gPiA+ID4NCj4gPiA+ID4gaXQgaXMgY29tcG9zZWQgb2YgMzIgY2hh
bm5lbHMgYW5kIGNoYW5uZWxzIDAtNyBhbmQgMjQtMzIgYXJlDQo+ID4gPiA+IHJlc2VydmVkIGZv
ciBJU1AgdXNhZ2UuDQo+ID4gPiA+DQo+ID4gPiA+IENoYW5uZWwgMjIgaXMgbW9kZWxsZWQgYXMg
Y2xvY2sgc291cmNlIGFuZCBDaGFubmVsIDIzIGlzIG1vZGVsbGVkDQo+ID4gPiA+IGFzIGNsb2Nr
IGV2ZW50IGRyaXZlciBhbmQgdGhlIHJlc3Qgb2YgdGhlIGNoYW5uZWxzIGFyZSBtb2RlbGxlZCBh
cw0KPiA+ID4gPiBjb3VudGVyIGRyaXZlciBhcyBpdCBwcm92aWRlcw0KPiA+ID4NCj4gPiA+IFdo
eSBkaWQgeW91IHBpY2sgdGhvc2UgMiBjb3VudGVycyBmb3IgdGhvc2UgZnVuY3Rpb25zPw0KPiA+
DQo+ID4gQ3VycmVudGx5IGl0IHVzZXMgYXJjaGl0ZWN0dXJlIHRpbWVyIGZvciBicm9hZGNhc3Qg
dGltZXIsIHNvIEkgdGhvdWdodA0KPiA+IFNpbmNlIFRJTSBoYXMgMjQgY2hhbm5lbHMsIHVzZSAx
IGNoYW5uZWwgZm9yIGJyb2FkY2FzdCB0aW1lciBhbmQgMQ0KPiA+IENoYW5uZWwgZm9yIGNsb2Nr
IHNvdXJjZS4gQnV0IGhhdmluZyBzYWlkIHRoYXQgU29DIGhhcyBhbiBhYXJjaDY0DQo+ID4gYXJj
aGl0ZWN0dXJlIGNsb2NrIHNvdXJjZSBzdHJpY3RseSBzcGVha2luZyB3ZSBkb24ndCBuZWVkIHRo
aXMuDQo+ID4NCj4gPiA+IFVubGVzcyB0aGUgaC93IGJsb2NrcyBhcmUgZGlmZmVyZW50LCB0aGlz
IGlzIGFuIGFidXNlIG9mIGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZ3MuIFdoYXQncyB0aGUgaC93
IGRpZmZlcmVuY2UgdGhhdCBtYWtlcyB5b3UgY2FyZSB3aGljaCBjb3VudGVyDQo+ID4gPiB0aGUg
T1MgcGlja3M/IFRoYXQncyB3aGF0IHRoZSBEVCBzaG91bGQgZGVzY3JpYmUuIElmIGFueSB0aW1l
ciB3aWxsDQo+ID4gPiBkbywganVzdCBsZXQgdGhlIE9TIHBpY2suDQo+ID4NCj4gPiBUaGVyZSBp
cyBubyBIVyBkaWZmZXJlbmNlLiBTYW1lIEhXIGJsb2NrIGNhbiBiZSB1c2VkIGZvciBtdXR1YWxs
eQ0KPiA+IGV4Y2x1c2l2ZSBmdW5jdGlvbmFsaXR5Lg0KPiA+DQo+ID4gT25lIGlzIGZvciBMaW51
eCBDbG9jayBzb3VyY2UvZXZlbnQgZnVuY3Rpb25hbGl0eSgoc2NoZWR1bGVyDQo+ID4gdGljay9i
cm9hZGNhc3QgdGljayBldGMpIGFuZA0KPiA+DQo+ID4gdGhlIG90aGVyIHB1cnBvc2UgaXMgdG8g
ZXhwb3NlIGNvdW50IGFuZCBldmVudCB0aWNrcyBmcm9tIHRoaXMgbW9kdWxlDQo+ID4gdG8gdXNl
ciBzcGFjZSwgc28gdGhhdCB3aWRlIHJhbmdlIG9mIGFwcGxpY2F0aW9ucyBjYW4gbWFrZSB1c2Ug
b2YgaXQuDQo+ID4NCj4gPiBJZiBpdCBpcyBhbiBhYnVzZSBvZiBjb21wYXRpYmxlIHN0cmluZ3Mg
Zm9yIG11dHVhbGx5IGV4Y2x1c2l2ZQ0KPiA+IGZ1bmN0aW9uYWxpdHkgLCB0aGVuIEkgd291bGQg
bGlrZSB0byBkcm9wIGNsb2NrIHNvdXJjZSBhbmQgdXNlIGFsbCB0aGUNCj4gPiBjaGFubmVscyBh
cyBFaXRoZXIgY2xvY2sgZXZlbnRzKGZvciBicm9hZGNhc3QgdGlja3MgYW5kIHJlYWwgdGltZQ0K
PiB1c2FnZT8/KSBvciBhcyBjb3VudGVycy4NCj4gPg0KPiA+IElmIHRoaXMgaXMgbm90IE9LLCB0
aGVuIEkgbmVlZCB0byBwaWNrIG9uZS4gSSB3aWxsIGdvIHdpdGggY291bnRlcnMuDQo+ID4NCj4g
PiBQbGVhc2Ugc2hhcmUgeW91ciB0aG91Z2h0cy4NCj4gDQo+IENhbid0IHlvdSBoYW5kbGUgdGhp
cyBsaWtlIHNoX2NtdC5jIGRvZXM6DQo+IA0KPiAgICAgICAgIC8qDQo+ICAgICAgICAgICogVXNl
IHRoZSBmaXJzdCBjaGFubmVsIGFzIGEgY2xvY2sgZXZlbnQgZGV2aWNlIGFuZCB0aGUgc2Vjb25k
DQo+IGNoYW5uZWwNCj4gICAgICAgICAgKiBhcyBhIGNsb2NrIHNvdXJjZS4gSWYgb25seSBvbmUg
Y2hhbm5lbCBpcyBhdmFpbGFibGUgdXNlIGl0IGZvcg0KPiBib3RoLg0KPiAgICAgICAgICAqLw0K
DQpDdXJyZW50bHkgaXQgaXMgaGFuZGxlZCBsaWtlIGFib3ZlIGV4Y2VwdCBmb3IgdGhlIGNhc2Ug
IiBJZiBvbmx5IG9uZSBjaGFubmVsIGlzIGF2YWlsYWJsZSB1c2UgaXQgZm9yDQpCb3RoIiwgc2Vl
IHBhdGNoIzMgWzFdIHByb2JlIGZ1bmN0aW9uLg0KVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBoZXJl
IHdlIGhhdmUgc2VwYXJhdGUgYWRkcmVzcyBzcGFjZSwgY2xvY2tzLCBhbmQgaW50ZXJydXB0cyBm
b3IgZWFjaCBjaGFubmVsLg0KWzFdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvbGludXgtcmVuZXNhcy1zb2MvcGF0Y2gvMjAyMjEyMDUxNDU5NTUuMzkxNTI2LTQtYmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20vDQoNCk91ciBjdXN0b21lciBCU1AsIHVzZXMgdGhpcyBodyBt
b2R1bGUgZm9yIGV4cG9zaW5nIHRpbWVyIGludGVycnVwdCBldmVudCB0byB1c2VyIHNwYWNlDQpi
eSB1c2luZyBjdXN0b20gZHJpdmVyLiBUaGUgc2FtZSBmdW5jdGlvbmFsaXR5IGNhbiBiZSBhY2hp
ZXZlZCB0aHJvdWdoIGNvdW50ZXIgZHJpdmVyLg0KVGhhdCBpcyB0aGUgcmVhc29uLCBJIGhhdmUg
YWRkZWQgY291bnRlciBkcml2ZXIgdG8gZXhwb3NlIHRoaXMgZnVuY3Rpb25hbGl0eSBhcyB3ZWxs
Lg0KDQo+IA0KPiA+ID4gPiAxKSBjb3VudGVyIGZvciBjb3VudGluZw0KPiA+ID4gPiAyKSBjb25m
aWd1cmFibGUgY291bnRlciB2YWx1ZSBmb3IgZ2VuZXJhdGluZyB0aW1lciBpbnRlcnJ1cHQNCj4g
PiA+ID4gMykgdXNlcnNwYWNlIGV2ZW50IGZvciBlYWNoIGludGVycnVwdC4NCj4gPiA+ID4NCj4g
PiA+ID4gbG9nczotDQo+ID4gPiA+IENvdW50ZXIgZHJpdmVyOg0KPiA+ID4gPiBDb3VudGVyIGRy
aXZlciBpcyB0ZXN0ZWQgYnkgcmVhZGluZyBjb3VudHMgYW5kIGludGVycnVwdHMgdGVzdGVkDQo+
ID4gPiA+IGJ5IGNvdW50ZXItZXhhbXBsZSBpbiB0b29scy9jb3VudGVyL2NvdW50ZXJfZXhhbXBs
ZS5jDQo+ID4gPiA+DQo+ID4gPiA+IENvdW50IHNuYXBzaG90IHZhbHVlOg0KPiA+ID4gPiAzMTE0
DQo+ID4gPiA+IE91dHB1dCBmcm9tIGNvdW50ZXJfZXhhbXBsZSB3aGVuIGl0IHRyaWdnZXJzIGlu
dGVycnVwdHM6DQo+ID4gPiA+IFRpbWVzdGFtcCAwOiAyNDE0MjE1Mjk2OSAgICAgICAgQ291bnQg
MDogNQ0KPiA+ID4gPiBFcnJvciBNZXNzYWdlIDA6IFN1Y2Nlc3MNCj4gPiA+ID4NCj4gPiA+ID4g
Q2xvY2sgc291cmNlOg0KPiA+ID4gPiBDbG9jayBzb3VyY2UgZHJpdmVyIGlzIHRlc3RlZCBieSBj
bG9jay1zb3VyY2Utc3dpdGNoIGFwcC4NCj4gPiA+ID4gWyAxMjc1LjcwMzU2N10gY2xvY2tzb3Vy
Y2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlDQo+ID4gPiA+IGFyY2hfc3lzX2NvdW50ZXIgWyAx
Mjc1LjcxMDE4OV0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvDQo+ID4gPiA+IGNsb2Nrc291cmNl
IGE0MDAwYjAwLnRpbWVyDQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUgYW55IHVzZSBjYXNlIHRv
IHJlYWxseSBzd2l0Y2guIERvaW5nIHNvIGRpc2FibGVzIHRoZQ0KPiA+ID4gdkRTTyBhY2Nlc3Mg
dG8gdGhlIGNsb2Nrc291cmNlLg0KPiA+DQo+ID4gTm90IHJlYWxseS4gQXJjaGl0ZWN0dXJlIHRp
bWVyIHNob3VsZCBiZSBzdWZmaWNpZW50IGZvciBjbG9ja3NvdXJjZS4NCj4gDQo+IFdoZW4gbXVs
dGlwbGUgY2xvY2tzb3VyY2VzIGFyZSByZWdpc3RlcmVkLCB0aGUgY2xvY2tzb3VyY2Ugc3Vic3lz
dGVtcw0KPiBwaWNrcyB0aGUgYmVzdCBvbmUgYW55d2F5LCByaWdodD8NCg0KWWVzLCBpdCBwaWNr
cyBiYXNlZCBvbiB0aGUgcmF0aW5nLg0KDQpDaGVlcnMsDQpCaWp1DQo=
