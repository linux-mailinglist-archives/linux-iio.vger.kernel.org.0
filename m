Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEDC75E010
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGWGM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 02:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWGM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 02:12:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6B10D5;
        Sat, 22 Jul 2023 23:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcOz2lSboYKkYwE9RN1+3QRetGR5APbggvGMFPIDc9MJRPPMBh1CL/ryaWszdDG/1rgY1IVBHUP4OtYxZu8znaaPL6llPBtS6HAuSDqREY2+1WQrBESbTlEN7NIQu6pCq9kJCKF8/z9FIw1Pypdw3gi7A8biAgJGu8U+ulA8hsY7dyf71bNZ51KaR7s3M2/mgZu20C8syWRxkGza9qm7aICheeLxrKIF5+GJCn91EOe3aQ9IwRz1BZkMNjX4aw4Q0RnUUzGA4pFC1wki8Q6SvwNWxQTcJRe7f5M5Y6jLNvM1XSt3hY2ujb42PnHvcnUdl3nS0zFbD1irZlAxMUWYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7NwRtrmXpI7NocvSEZ1JDnqaVcETslASrteFLlpHus=;
 b=c/wI5bkSr2k2UTQ+zvkCBegm5Q0vAuTLwKOx8P2HiBKl7eOTvw9vpiEIRodydQmWKzAy+AsD6vPMhkC4hUnEqUondH1GYxRn4Tv34PMboCBwwu/QthoqB6bxZkX9+5UuUUSestkGacBV+ZVAZh6BU7w/SwcvNzZ8AykJDJcpy45KyMHcQPjaUQwa66NALInUGWOY672UR93SIspNL1CquOVDQMDpJopUVwbGdcmgnfPnvV8AG6eeCCIujem9Lpi9f8n2Rlw6zpilRKbedtVEsDSF56inbOVLkBdmaHWm1H6lswa9EYAXBPu0VCmuYpgFyojksdZjKpFdS5upuNA7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7NwRtrmXpI7NocvSEZ1JDnqaVcETslASrteFLlpHus=;
 b=G+KMl4I5E3kUAdqhDgY/UqJiFx3alDoJiE01EKisazxttL1jjabP9FZuBXB8+hNViaiPZCwjq2PvyDDNIslQnt4AJVJY+2XXNLiYFxVou/Fw9ZnFwGgThzmwHbqBJGyGhx2JoUOvkXDT1+Vwa1O9D6OHB7iM6Gp8YJGhkBBSDOw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11973.jpnprd01.prod.outlook.com (2603:1096:400:38c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 06:12:21 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 06:12:20 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Thread-Topic: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Thread-Index: AQHZu6M6IkY4v2bEb06FbMft+4E5nK/GUriAgACNW+A=
Date:   Sun, 23 Jul 2023 06:12:20 +0000
Message-ID: <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
 <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
In-Reply-To: <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11973:EE_
x-ms-office365-filtering-correlation-id: aa2d92c1-dd3d-4116-96d4-08db8b43c651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSL7BZuKvsZiRWWMD4sEDO1fV7kwxJ1qShCGviO0n3tW2m0JLBsnrmJxEr4n4Vs9TwJvJnessYGq6wIiBeJntElrGRla1H7W0jvEgCITHjkOapM4rksugfz7eRi2g+3fHmyNFVsDLIwUlwaN1tr0fR5KF2wPQ++C+9igonlzg2bEApskQttTZhg9W4/mGMLn0rs1zDMdHIy1qZ9lIl7zxrwpjZv1Xux8pjdB8cULQ0ffelI3jbkHEt7rGWKJ9usR2GIYJeAOG6A1O3lPssYgITv1gC/PBI4XPU4q7+Ovc9gZlQjn7YleDAlAWzZOOK6oSn4p/f3oHAebSEBXdRCgC5qaDAYbRj2gs8Rplm4jWhbK0EuipJgKZDcf0XIdOv8FZrQe+gq/YO3YLGzwo6Bpi641cLn6FnHWetdWPX3OJEatJFwlB8o3voOaFxRpBG1EhHeNumguk8dGQlNcXL2ouzaD8lVwxlVyn8DTY/s5EFiL+ObzN6gu52eLYNn2rgBIVf2vh+SV5GPK2XMMvJ+LKZzaH25dzUiPm1c/Pw4jubvMt39Hd124FMzRPAL86aI0dwmVyjtD74DaYxFi50f2GTdDlB93RRcM46pUjpVh5aD+7kB1OTzEIhfHy7uM2idUDzU708jXzbHDOPnZqecYjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(122000001)(55016003)(83380400001)(8936002)(8676002)(5660300002)(52536014)(110136005)(478600001)(54906003)(66556008)(66476007)(66446008)(64756008)(4326008)(316002)(76116006)(66946007)(41300700001)(26005)(186003)(6506007)(71200400001)(966005)(7696005)(9686003)(2906002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVUzUUJ1STN1NFUrUHRrV2ptclRlUGdKdDRFTmJtUGlVYmVlVEtDMEJQZ2Rl?=
 =?utf-8?B?VUJ2WDBPVlhBUmVHcUIzcG5YcTRHeEZnQW5MUVgrRElNRCtIR0hPZGZvb1N4?=
 =?utf-8?B?WW9wZUJYNE1BL1E2dUZ4YVYvaXVaMEQxazl2U2ZMOHdMaW9mMUY4NDhNa3VS?=
 =?utf-8?B?YmxvR0VJN01qQlYwdENmNzhMTkIrUmovcEZ4Yzk2UHR3QmJXV2hEMmU5ZHdH?=
 =?utf-8?B?VFNjRjdKcHp5K1BQWFkrelFZdEJpWjZmbG9FckV5WXpMakZTRjFBR01xdkxE?=
 =?utf-8?B?VW1NelBVNkVhV00rLy9KYkdWazdiclF3RzVSYVVsdmVTOXBnYlNORjVCSVhR?=
 =?utf-8?B?ejAwclprTU5CdTlCT2VWOTVEZ2dOei8xemZZZGJwWVJXOVhiemhmQm55Ulgw?=
 =?utf-8?B?cnVlclVCUVlJMENzdHc1OUE3UXU5V01PcTlOQzU5L3M0ZHEwUm5EQ1J5VHhI?=
 =?utf-8?B?K1ExbXoxNm5jQUFNZURPbXcwUlZqek5qMzZ6WWpQOU12bnptNEs0ZmpJdUVZ?=
 =?utf-8?B?amNqUDUvdE5SVWpaOTdjbFJpZmNHYUZJNDJNNEhIamc4QUtjQnVLbXJlTkc5?=
 =?utf-8?B?WGZ6TCtUMkRJOVVhanZocUowL2F3UmxFVG9LU05SUWJZblpKYXgzM0t6WHhj?=
 =?utf-8?B?OVpINndhRGFZZzlIcWNaQlUzdmJDOEhFZHhDOVVickhHcWU4S2xNTHpmenpZ?=
 =?utf-8?B?aSthQU1iZER2VWRzdDkzVzRndHR2UHl3S0M4NzBpalV6bkJUTXp6YnZ4a1pn?=
 =?utf-8?B?WW94aGp2OW1SdG1PaThoT0QvM3ZER0ZNY3QwNHhGK1B0VndURGl3ekRCS1Nj?=
 =?utf-8?B?ajExZmJMb3NKMmxqTnlqTC9KckE0N2xLZDhNYnduRSt2UVZLUGIzWlpjSzdK?=
 =?utf-8?B?UnA5RnFsVW9GYk1SWjNqaEQvQi9kMGs0ODlYNUNPQUlvYktqQ0FpRy84T2k1?=
 =?utf-8?B?dTlrMmlaWW9uZnlSRGNPanpIcXc1TXlaTVRaY2VzMktPdjMzaisrb1NKNmlx?=
 =?utf-8?B?cXFtOEQxNHphSTZ4ZldPTzdVOHRzbTY0WEZsRmJiOXBDL0FkbXJlQ3QzcXA5?=
 =?utf-8?B?WGY3RWFycHZnTmxkaS8vR2YzaVBQRjEzZ2hnaC9uTER1eVBKU0RXWElmUUhV?=
 =?utf-8?B?UnBLSFlNQVhndHBFbFdTRU5OYTRHQ1Q2MVRmOVdNeUgyNVd3b01MS3E3VnhO?=
 =?utf-8?B?Wk50a2dQMGRQWmY3N3J4RmJCQmd3UkdZQ0dOWWtJQ1FlZ2hNbE1IRzdtRU5H?=
 =?utf-8?B?Tk1wSDhlUHZieTJXaVFBclpsL05vTVE4d3dsZmt2Nzg4SC8xNnBqM2tKcnJy?=
 =?utf-8?B?ZWVGSFU1S3NqMUpaV3FPalFxeHVoZ0N0Uk5JWlkreGRUWTl1emcyYlc5MDdB?=
 =?utf-8?B?YWw5YzR6ZTI5SmZTU1VjZUNEeDlqNEx6QUdMa29JUVEvQ2dOYURmVGRaWmE1?=
 =?utf-8?B?LzYrTGNhOVIxKzdudXVGMjBiK1kyUUs5eGMyT3BMSDJXSGFKUmpiR1BlaFJK?=
 =?utf-8?B?a0x5STZZcFJoR0hMVUZhSkF4N1pXTFFxN0U4ZytSN3p4MW1zdnVXUzRkK1NK?=
 =?utf-8?B?bGREMGxJeUpkaTk4MnZqZk1sYmliTG02WGl6ajJtU1BqcEJMYWtydWN5OVZa?=
 =?utf-8?B?ajd0SGxodTNZcHI0YXpxc3ozSllVQW5zSndFYnpKaGx6L3ZHUmdDSDYyeTNN?=
 =?utf-8?B?ajA4ODhLb2RpaFYwSS9wS2I2em8rNkJnQUhrMEIzNEF1aUxvdThUQ2lrZWJG?=
 =?utf-8?B?WFY0MnVscVJSQ1RuNDhPQy9NQ09xbXlzM1FUZ3Y0a2FCTmFreUlSajh3ZWQ4?=
 =?utf-8?B?MG5wUVV0ZlFHTUdwSUJudlVQa0JtYVh6WUc1OXZkSnZiZlpBZFRiemZqVzFk?=
 =?utf-8?B?NTBhaCtCeUhiT2dPY0szU0VMOE1uNWE1WHQ5OTUwa1h4MEU1MzZLbmtJVkdV?=
 =?utf-8?B?NUMrL0NUUndVaXRueC8xcU95Z0trMjJFNUNHVU96Wm9MRHBCT0c0Ykxaalo1?=
 =?utf-8?B?NE8zSFRiTkJsODFoa2I5U0hyeXVxbGcxRUJ3ZlZIMlZsUDdXeERDWDM0UjJK?=
 =?utf-8?B?UnFPZXhwVkgvdktPTDBONDRFVERQL2pxa0RqM3N6eTFxVzFJam0rQ1hkallz?=
 =?utf-8?Q?a7rW9NWWzCg3fpKA/hXf9mJuq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2d92c1-dd3d-4116-96d4-08db8b43c651
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 06:12:20.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DmphS4L9o0SJAMhMPgg+tYp09KNXzeJ3A8y95DaWT5RToQnHjMr0xLg1dKwqWMon3Tg+oMlOTepXaWPMI4lKfAbZOg8qEg537OHDRhR0rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11973
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUGV0ZXIgUm9zaW4sDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjJdIGlpbzogcG90ZW50aW9tZXRlcjogbWNwNDAxODogVXNlDQo+IGkyY19n
ZXRfbWF0Y2hfZGF0YSgpDQo+IA0KPiBIaSENCj4gDQo+IDIwMjMtMDctMjEgYXQgMDk6MTYsIEJp
anUgRGFzIHdyb3RlOg0KPiA+IFJlcGxhY2Ugb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgYW5k
IGkyY19tYXRjaF9pZCgpIGJ5IGkyY19nZXRfbWF0Y2gNCj4gPiBfZGF0YSgpIGJ5IG1ha2luZyBz
aW1pbGFyIEkyQyBhbmQgRFQtYmFzZWQgbWF0Y2hpbmcgdGFibGUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+
ID4gdjEtPnYyOg0KPiA+ICAqIEFkZGVkIHNpbWlsYXIgc2ltaWxhciBJMkMgYW5kIERULWJhc2Vk
IG1hdGNoaW5nIHRhYmxlLg0KPiA+ICAqIEZpeGVkIHR5cG8gaTJjX2dldF9tYXRjaF9kYXRhKGRl
diktPmkyY19nZXRfbWF0Y2hfZGF0YShjbGllbnQpLg0KPiA+ICAqIERyb3BwZWQgZXJyb3IgY2hl
Y2sgYXMgYWxsIHRhYmxlcyBoYXZlIGRhdGEgcG9pbnRlcnMuDQo+ID4NCj4gPiBOb3RlOg0KPiA+
ICBUaGlzIHBhdGNoIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQuDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaWlvL3BvdGVudGlvbWV0ZXIvbWNwNDAxOC5jIHwgMzQNCj4gPiArKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTYg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vcG90ZW50aW9t
ZXRlci9tY3A0MDE4LmMNCj4gPiBiL2RyaXZlcnMvaWlvL3BvdGVudGlvbWV0ZXIvbWNwNDAxOC5j
DQo+ID4gaW5kZXggODlkYWVjYzkwMzA1Li5iMDY0ZTg2ZWNjZTggMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9paW8vcG90ZW50aW9tZXRlci9tY3A0MDE4LmMNCj4gPiArKysgYi9kcml2ZXJzL2lp
by9wb3RlbnRpb21ldGVyL21jcDQwMTguYw0KPiA+IEBAIC05OSwyMCArOTksMjQgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBpaW9faW5mbyBtY3A0MDE4X2luZm8gPSB7DQo+ID4gIAkud3JpdGVfcmF3
ID0gbWNwNDAxOF93cml0ZV9yYXcsDQo+ID4gIH07DQo+ID4NCj4gPiArI2RlZmluZSBNQ1A0MDE4
X0lEX1RBQkxFKG5hbWUsIGNmZykgewkJCQlcDQo+ID4gKwluYW1lLCAuZHJpdmVyX2RhdGEgPSAo
a2VybmVsX3Vsb25nX3QpJm1jcDQwMThfY2ZnW2NmZ10sCVwNCj4gPiArfQ0KPiANCj4gSXQgaXMg
aW5jb25zaXN0ZW50IHRvIGhhdmUgYSBuYW1lZCBmaWVsZCBmb3IgLmRyaXZlcl9kYXRhIGJ1dCBu
b3QgZm9yDQo+IC5uYW1lLiBBbHNvLCBJIGRpc2xpa2UgdGhlIGNhc3QgYW5kIHdvbmRlciBpZiB0
aGUgdHJpdmlhbCBzaW1wbGlmaWNhdGlvbg0KPiBpbiBwcm9iZSgpIGlzIHJlYWxseSB3b3J0aCB0
aGlzIGNodXJuIHdoZW4gdGhhdCB1Z2x5IGNhc3QgaXMgbmVlZGVkPyANCg0KSXQgc2F2aW5nIGxp
bmVzIG9mIGNvZGUgYW5kIGJldHRlciB0aGFuLCAmbWNwNDAxOF9jZmdbaTJjX21hdGNoX2lkKG1j
cDQwMThfaWQsIGNsaWVudCk+ZHJpdmVyX2RhdGFdOyByaWdodD8/DQoNCg0KPlRoZQ0KPiByZWFz
b24gdGhlIHR3byB0YWJsZXMgZGlmZmVyIGFuZCBkbyBub3QgYm90aCBoYXZlIHBvaW50ZXJzIGFs
cmVhZHkgaXMNCj4gcHJlY2lzZWx5IG15IGRpc2xpa2UgZm9yIHRoYXQgY2FzdC4NCg0KPiANCj4g
QW55d2F5LCBzb21ldGhpbmcgbGlrZSB0aGlzIGluc3RlYWQ/IE9yIF9uYW1lIGluc3RlYWQgb2Yg
aWQ/DQo+IFdoYXRldmVyLi4uDQoNCk9LLCB3aWxsIHVzZSBfbmFtZS4NCg0KPiANCj4gI2RlZmlu
ZSBNQ1A0MDE4X0lEX1RBQkxFKGlkLCBjZmcpIHsJCQkJXA0KPiAJLm5hbWUgPSBpZCwJCQkJCQlc
DQo+IAkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpJm1jcDQwMThfY2ZnW2NmZ10sCVwN
Cj4gfQ0KPiANCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBt
Y3A0MDE4X2lkW10gPSB7DQo+ID4gLQl7ICJtY3A0MDE3LTUwMiIsIE1DUDQwMThfNTAyIH0sDQo+
ID4gLQl7ICJtY3A0MDE3LTEwMyIsIE1DUDQwMThfMTAzIH0sDQo+ID4gLQl7ICJtY3A0MDE3LTUw
MyIsIE1DUDQwMThfNTAzIH0sDQo+ID4gLQl7ICJtY3A0MDE3LTEwNCIsIE1DUDQwMThfMTA0IH0s
DQo+ID4gLQl7ICJtY3A0MDE4LTUwMiIsIE1DUDQwMThfNTAyIH0sDQo+ID4gLQl7ICJtY3A0MDE4
LTEwMyIsIE1DUDQwMThfMTAzIH0sDQo+ID4gLQl7ICJtY3A0MDE4LTUwMyIsIE1DUDQwMThfNTAz
IH0sDQo+ID4gLQl7ICJtY3A0MDE4LTEwNCIsIE1DUDQwMThfMTA0IH0sDQo+ID4gLQl7ICJtY3A0
MDE5LTUwMiIsIE1DUDQwMThfNTAyIH0sDQo+ID4gLQl7ICJtY3A0MDE5LTEwMyIsIE1DUDQwMThf
MTAzIH0sDQo+ID4gLQl7ICJtY3A0MDE5LTUwMyIsIE1DUDQwMThfNTAzIH0sDQo+ID4gLQl7ICJt
Y3A0MDE5LTEwNCIsIE1DUDQwMThfMTA0IH0sDQo+ID4gLQl7fQ0KPiA+ICsJTUNQNDAxOF9JRF9U
QUJMRSgibWNwNDAxNy01MDIiLCBNQ1A0MDE4XzUwMiksDQo+ID4gKwlNQ1A0MDE4X0lEX1RBQkxF
KCJtY3A0MDE3LTEwMyIsIE1DUDQwMThfMTAzKSwNCj4gPiArCU1DUDQwMThfSURfVEFCTEUoIm1j
cDQwMTctNTAzIiwgTUNQNDAxOF81MDMpLA0KPiA+ICsJTUNQNDAxOF9JRF9UQUJMRSgibWNwNDAx
Ny0xMDQiLCBNQ1A0MDE4XzEwNCksDQo+ID4gKwlNQ1A0MDE4X0lEX1RBQkxFKCJtY3A0MDE4LTUw
MiIsIE1DUDQwMThfNTAyKSwNCj4gPiArCU1DUDQwMThfSURfVEFCTEUoIm1jcDQwMTgtMTAzIiwg
TUNQNDAxOF8xMDMpLA0KPiA+ICsJTUNQNDAxOF9JRF9UQUJMRSgibWNwNDAxOC01MDMiLCBNQ1A0
MDE4XzUwMyksDQo+ID4gKwlNQ1A0MDE4X0lEX1RBQkxFKCJtY3A0MDE4LTEwNCIsIE1DUDQwMThf
MTA0KSwNCj4gPiArCU1DUDQwMThfSURfVEFCTEUoIm1jcDQwMTktNTAyIiwgTUNQNDAxOF81MDIp
LA0KPiA+ICsJTUNQNDAxOF9JRF9UQUJMRSgibWNwNDAxOS0xMDMiLCBNQ1A0MDE4XzEwMyksDQo+
ID4gKwlNQ1A0MDE4X0lEX1RBQkxFKCJtY3A0MDE5LTUwMyIsIE1DUDQwMThfNTAzKSwNCj4gPiAr
CU1DUDQwMThfSURfVEFCTEUoIm1jcDQwMTktMTA0IiwgTUNQNDAxOF8xMDQpLA0KPiA+ICsJeyAv
KiBzZW50aW5lbCAqLyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCBt
Y3A0MDE4X2lkKTsNCj4gPg0KPiA+IEBAIC0xNTcsOSArMTYxLDcgQEAgc3RhdGljIGludCBtY3A0
MDE4X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50DQo+ICpjbGllbnQpDQo+ID4gIAlpMmNfc2V0X2Ns
aWVudGRhdGEoY2xpZW50LCBpbmRpb19kZXYpOw0KPiA+ICAJZGF0YS0+Y2xpZW50ID0gY2xpZW50
Ow0KPiA+DQo+ID4gLQlkYXRhLT5jZmcgPSBkZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4g
PiAtCWlmICghZGF0YS0+Y2ZnKQ0KPiA+IC0JCWRhdGEtPmNmZyA9ICZtY3A0MDE4X2NmZ1tpMmNf
bWF0Y2hfaWQobWNwNDAxOF9pZCwgY2xpZW50KS0NCj4gPmRyaXZlcl9kYXRhXTsNCj4gPiArCWRh
dGEtPmNmZyA9IGkyY19nZXRfbWF0Y2hfZGF0YShjbGllbnQpOw0KPiANCj4gTlVMTC1jaGVjayBo
ZXJlPyBJIGtub3cgdGhlIG9yaWdpbmFsIGkyY19tYXRjaF9pZCBjYWxsIGlzIG5vdCBjaGVja2Vk
DQo+IGZvciBub24tbWF0Y2hlcywgYnV0IHRoYXQgZmVlbHMgbGlrZSBhIHNpbXBsZXIgZnVuY3Rp
b24gdGhhbg0KPiBpMmNfZ2V0X21hdGNoX2RhdGEuIEFuZCBsZXNzIHByb25lIHRvIGNoYW5nZXMu
DQo+IA0KPiBTYW1lIGNvbW1lbnRzIG9mIGNvdXJzZSBhcHBsaWVzIHRvIHRoZSBtY3A0NTMxIHBh
dGNoIGFzIHdlbGwuDQoNClNvbWUgc3Vic3lzdGVtIHBlb3BsZSBkb2Vzbid0IHdhbnQgZXJyb3Ig
Y2hlY2sgYXMgYWxsIHRhYmxlcyBoYXZlIGRhdGEgcG9pbnRlcnMuIFNlZSBbMV0NCg0KWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbmVzYXMtc29jLzIwMjMwNzE3MTQ1NjIzLjQ3
M2NmZmNhQGJvb3R5Lw0KDQpJIGFtIGxlYXZpbmcgc3Vic3lzdGVtIG1haW50YWluZXIgdG8gdGFr
ZSBmaW5hbCB3b3JkIG9uIHRoaXMuDQoNClRoZSBuZXcgQVBJIGlzIHZlcnkgc2ltcGxlIFsyXQ0K
WzJdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUtcmMyL3NvdXJjZS9kcml2
ZXJzL2kyYy9pMmMtY29yZS1iYXNlLmMjTDEyNA0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gPg0KPiA+
ICAJaW5kaW9fZGV2LT5pbmZvID0gJm1jcDQwMThfaW5mbzsNCj4gPiAgCWluZGlvX2Rldi0+Y2hh
bm5lbHMgPSAmbWNwNDAxOF9jaGFubmVsOw0K
