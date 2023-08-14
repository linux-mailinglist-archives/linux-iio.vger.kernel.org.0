Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93C77B41E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjHNI2x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Aug 2023 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjHNI2f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 04:28:35 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9A12D;
        Mon, 14 Aug 2023 01:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiVSzZf96gIm/sUIjghYoMbAHfIqS1QTGUOwjeP6FFBuFyNTJ2VB0qUfIitC7uz8H2GPlVgsoH+pIwTU2g1TMcUCPFoHuifBj4hk3kb4uR9Y/9MlTOCWTqsKbwqFNdwVH6NlX/xiVABZTAWuCVDLd952dx9cCA0FzlMganbU4TdXAkEhJu5W6u+rzF66VV6qCai6D3caThXcZWQ8oblMVKUHVbxv+e9qbyTLU9PyzPhpx95CJIGdGvK/Eq6mkHgz1H+lEzS4QK8zS3E891syw3WCN6PFGXNgd5xMaxKsRNumvFmK6n7naleZCrNuqNbywaWEi7uN5qMDPk/PvyI++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+FNds3KTMA+VS/CUqwhnlUowmkcclf92oadKQGo+og=;
 b=A3xzPNoNizAiiNU0Uam0SFKVjE2xMOzDNjA7rzsuP3ZPpeQ9VvVLVJAgWbuX0CGGtucpqT7yjvNVEwxOcD+BzNej7u9rPtUYJeIYk4BAkwyPZPQLSgYDVJ96DvKJHaN8Cjd97CiBECVB/d3COhqObHK34KyprX6xLMKZmBaGnYM5GJCyf37/4N4W61HrU7KW48/vmXQGgWRc03OenNwqBTxG+Yn3X8b42Kmd0DeQGGXK5UQfNOaHu/EVDPhQC64SpTGTZ9HWNN5f3F2YHFHYpRFSYkCnLAuyvqHU/hAaE9xrXc9xhJbKjWf3oYUrdkPakJdd5QYkddOWqpFgVeHMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+FNds3KTMA+VS/CUqwhnlUowmkcclf92oadKQGo+og=;
 b=g+VAdsqPaeHcTLw3W3tmlFSTXEqB1DN854dXTWEchTPrdOjLWFH6rLAAIKNkIoGHJIV63lyOuBmM/ehHAMoneWTlK18gickacufkSFoSzjWL7HgTwqHozbBIgwYTnMw3eATv84aGFVKekLzHClEVP5q4fwQKBJemyhAHb4sjj6U=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8308.jpnprd01.prod.outlook.com (2603:1096:604:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:28:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:28:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: mlx90614: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: mlx90614: Use i2c_get_match_data()
Thread-Index: AQHZzTkxU3tnEzpQsUChcb0A0nZmRq/o0sOAgACi2+A=
Date:   Mon, 14 Aug 2023 08:28:28 +0000
Message-ID: <OS0PR01MB592204FC9A5A054CDFC300F38617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812162222.200004-1-biju.das.jz@bp.renesas.com>
 <CAKv63uvEu3kPYF=idNyW4RkwVWFgixdstQyvuUhhHzc_rPgqqg@mail.gmail.com>
In-Reply-To: <CAKv63uvEu3kPYF=idNyW4RkwVWFgixdstQyvuUhhHzc_rPgqqg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8308:EE_
x-ms-office365-filtering-correlation-id: 49ff1cfb-b2b1-4a0b-bb5c-08db9ca06f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ES7CNCYIu5zHsmEGvfLIVc7ldqAYsgBX/W+662wuWWfuIqD7EPrGZv7PafstSSGd3S4is8mF9Ts1ghj0yBEjuML49HCZ3xEwQBe3hAIHWNvZez9PRGjDdP+8hWwHvV7z/cKkg8A9jIkYXRvSoE7SKwdPX7NeOUhyPZTJriLziRROUuPBIijkiGkpQC85WBX+5OJdL2Iv589lj4b4iX9MXkeZq4cnILoYcOv/qsZlpS0ey1lJgvThnqtfCCL6BvJgKugeG95Ba7Jz5j/FgWJWuLoAnfA9rIajpVHCoWKM8bmxYXu7hTMT1E9WQTbnkWutJzk89LgmFdJgVFUP66i/U7BIvgPH/RniJSUhA36BvD6xmR8zYkned+SdKMfgf36TR5bBlTI9BP8Mtb3CSoJnxe3VJ4VYgCLc74ltzdaggNBQqd7KGJZVB6TuIGyNc8xW9oAH/FV4+KMW3YMLn9aNxeG0rzR+WLYzW7DKpHubb4voNXnsItrSl3ltQjuWbm8yG20PfMnKx56nTotMuqCAJjRKhazWLvHnuTlmqj5QNC8lVhgVdXmUpJug6dGXcfZKne6GunBkPDBEbasvLvPWB9o2mCrMC/cm7mJUG1d81a9IzMloWjhhgMADh94QsSy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(186006)(1800799006)(9686003)(6506007)(71200400001)(7696005)(478600001)(83380400001)(2906002)(26005)(66446008)(64756008)(41300700001)(316002)(54906003)(66556008)(66476007)(76116006)(66946007)(5660300002)(110136005)(8676002)(8936002)(4326008)(52536014)(38070700005)(38100700002)(86362001)(33656002)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpFbUFPb0NPdkF4STRPZUNOS1VTUmR4KzhVNFJpNlRESE9pREE3dXRCK3dG?=
 =?utf-8?B?ZUZIcGVnYmpMZ2g0K1ZzaEczbEwzMTFYZzhGdHl3dFBMb09kQnZtL3QwQmZk?=
 =?utf-8?B?VHo4T2RnWDY4a0F0Yng3UU9LYzJDdS80RlJaMGExVG5SWjd0MVZKMmVlNUFD?=
 =?utf-8?B?WDBZTmpiZ09yczduT0F0RHFCTzZFWFpkVkRMMFJ5WEE4cEZuK25FSnJuc0lt?=
 =?utf-8?B?U25UUjlDcCtFbkU0WXVzWUhaVjhUSG9rZUJ2YjlhMTRGVk9pcENVcFFJaitV?=
 =?utf-8?B?T1M1OGRRL3RKK1hqWmg3SE9rK3UwZVU5NEZpc1N2Z2ZGN3NXcWhFRVRyTkhI?=
 =?utf-8?B?TGtoaUFrVC83VjkwSHpDUTdUaVIxd2VXUXhRUkJpMkl6bUFHZDlpbUZ0azhm?=
 =?utf-8?B?cW9aYzUrSXl2b3dRMHpaQXExR3BxTCs5OGNUeG9pSzNCM05WaDhURVUvaXNZ?=
 =?utf-8?B?WFk1cDF6R1NORURTNWljSk9Xd2VnM2pJdTM1YVJCZzJIWGJ6R1NHQjNZMmU3?=
 =?utf-8?B?bVFUZHFDLzRPaUpEYUE3ZUc2dnpCUVdoTVY4eVFGeVpSR3ZlVmtRUVpZbGdF?=
 =?utf-8?B?ZTFuVVZOem9TS0pyeWpDVm1YNkJ5U3VtTXlIdUh0RklRejI1UUtNK2FCd2pU?=
 =?utf-8?B?aGJhajVNb2pWOFdHc09zQThuUTJMM25WM1NJWi9FTFE0Y1NHQm5pWGNTa2pS?=
 =?utf-8?B?dFdvUWlnVmlBM0toVGhMd0J5TExBOU5IVlgwejRlY0lOdVFUREJzNFM2cVNM?=
 =?utf-8?B?UlRLNllmNUkrUmtuQTFtTVNtazJ6MGpTZWR1WE9lWlZIT1hJaFJneTZIRi85?=
 =?utf-8?B?N3I2VGc5SWVGaGVYRFIyK3JDcW9jQS9jWlNCUnV2OHJvazI5ZUpvTzUrWmE0?=
 =?utf-8?B?Z3ZYSzNjL2plZXZ4MElKaHN3T3h5YlNPRFFwVmppRXFwdDRhSVlKSFpscmVK?=
 =?utf-8?B?K3djOXYyeTZSK0xNSDJOaHFPblJUcFR1Y0o2ZmZPNmgwSVdkODdSL2xQR0lV?=
 =?utf-8?B?WXcrRUFYL2ltRTIvaUtwblNpd2lsOUdSTWFqTTdZdHZiRmRESVNaTE4zSkhN?=
 =?utf-8?B?RGtrQkZGYzhtR2owR3JRb0RLWUw4RGpwNG5yaHJLaThPY25nMU5ubG5wY1JM?=
 =?utf-8?B?OUZCckppRGZiZjJtV24xejZ4eEtoRS9hcDVSYUNqbGg4R3hWcEpOMmxPQkZT?=
 =?utf-8?B?YlhlS3VwakRNM1R3TFAzR2JZOEp5ZW1UYitQVmJHOW0xV1V5Q3o4T3ZaN1Jr?=
 =?utf-8?B?QzhTL2d3L09uSDNPNUx4QWJhS0p6eWZrb3dUbzkxV2hnK0FQOWFDNVRXTmFY?=
 =?utf-8?B?US96dnl5a1QzVE1pSlVYM0VMMWJWYjMvSGQwVWtQaWtJTFkyN09aUWpGc0Y3?=
 =?utf-8?B?bGsyYVM2cXZaOHdhZTdxbXJTamFYTUVSK1U3TEpoc2FNLy9ETEhRQTBEN09m?=
 =?utf-8?B?dnkvbFg5TXFOeFZhNnhKUWVnK0hFNUpPaFJNMXc3VnhmSE5KZUxLQmZuU3VG?=
 =?utf-8?B?d29YMm1Na0NhWncwamNNRVpjdXpUc1drMXh5ajJjZTZmbFNaMHJ0M1F5U2Q1?=
 =?utf-8?B?OFo4SUU3bHNHMWwyNStvWlR4b0dIUkc5VzdmVWd5eFJrTElCdFR1RjZvbUJS?=
 =?utf-8?B?WEtRVko1Q0NhTUlObGt3Y25Qbkw2YjFRNU9sRWtvcVk5M2E3eG5SZzdDN2x6?=
 =?utf-8?B?RnloTUJZVzZBLytPMkhES0RBNytpRHBrSjllREsxRzFhNnZ5RktMUUNLL2NE?=
 =?utf-8?B?Y3dpa2dqV2I4OEJubC9IOGl4TC9ZTCtvYzI4eWZyWDVzN2xpT25ZMm0rRnBQ?=
 =?utf-8?B?Z2ZmWTRnWjVOUjF3cWV2RnJvdEk3MUUweFBxbjZQRXVtWjFuNHZaVHRGZy80?=
 =?utf-8?B?WEhCYmU0cDFTT2NpVlJPaWMxQjAwLzJlMXphTkVPczgrcDI3OEp5VytDRzMy?=
 =?utf-8?B?amwwQkc4Wk1PU1B2M1Zoa2FjODlWWTN4WWZ6dlFOcEhnWWJ0UVc2TG5kdlZE?=
 =?utf-8?B?SmZNaENSWWtJL3h1d21xZk5haks3bFdtTWZ3c0hKWVdnSU1paEh2MGFzRThM?=
 =?utf-8?B?akVraEIwaTU4YzFGMllCT3FLNWtiVHdPZjBDZkEvdUJyWS9EZW5PZCs2c0w1?=
 =?utf-8?Q?d6UUMGZGkGL3t+jby6V/VU5B6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ff1cfb-b2b1-4a0b-bb5c-08db9ca06f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:28:28.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up+u4v7oY5UjDmoOYGz7TAhXVmzldDqJ//2takFTNpJa2rQ8zXmdis40yUm+bfv8p+3gBZxcOXnLECTp8oXvsbtpMAQR6RRDt/bxi9K6z3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8308
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQ3J0IE1vcmksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBtbHg5MDYxNDogVXNl
IGkyY19nZXRfbWF0Y2hfZGF0YSgpDQo+IA0KPiBJdCBzaG91bGQgbm90IGJyZWFrIHNvbWUgYmFj
a3dhcmRzIGNvbXBhdGliaWxpdHkgc286DQoNCllvdSBtZWFuLA0KDQpGaXhlczogM2Q1ZWFkMjM4
YmM4ICgiaWlvOiBtbHg5MDYxNDogRmFjdG9yIG91ciByZWdpc3RlciBJTyBhbmQgY29uc3RhbnRz
IGludG8gbW9kZWwgc3BlY2lmaWMgZGVzY3JpcHRvciIpDQoNCkhpIEpvbmF0aGFuLA0KDQpJcyBp
dCBzb21lIHRoaW5nIHlvdSBjYW4gZG8gd2hpbGUgYXBwbHlpbmcgQ2MgaW5nIHN0YWJsZUBrZXJu
ZWwub3JnID8NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IEFja2VkLWJ5OiAiQ3J0IE1vcmkgPGNtb0Bt
ZWxleGlzLmNvbT4iDQo+IA0KPiBPbiBTYXQsIDEyIEF1ZyAyMDIzIGF0IDE4OjIyLCBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gUmVwbGFjZSBk
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoKS0+aTJjX2dldF9tYXRjaF9kYXRhKCkgdG8gZXh0ZW5kDQo+
ID4gbWF0Y2hpbmcgc3VwcG9ydCBmb3IgSUQgdGFibGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvaWlvL3RlbXBlcmF0dXJlL21seDkwNjE0LmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL21seDkwNjE0LmMNCj4gPiBiL2RyaXZlcnMvaWlvL3Rl
bXBlcmF0dXJlL21seDkwNjE0LmMNCj4gPiBpbmRleCAwN2JiNWRmMjRhYjMuLjc0MDAxOGQ0YjNk
ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9tbHg5MDYxNC5jDQo+
ID4gKysrIGIvZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbWx4OTA2MTQuYw0KPiA+IEBAIC02MDAs
NyArNjAwLDcgQEAgc3RhdGljIGludCBtbHg5MDYxNF9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50KQ0KPiA+ICAgICAgICAgZGF0YS0+Y2xpZW50ID0gY2xpZW50Ow0KPiA+ICAgICAgICAg
bXV0ZXhfaW5pdCgmZGF0YS0+bG9jayk7DQo+ID4gICAgICAgICBkYXRhLT53YWtldXBfZ3BpbyA9
IG1seDkwNjE0X3Byb2JlX3dha2V1cChjbGllbnQpOw0KPiA+IC0gICAgICAgZGF0YS0+Y2hpcF9p
bmZvID0gZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZjbGllbnQtPmRldik7DQo+ID4gKyAgICAgICBk
YXRhLT5jaGlwX2luZm8gPSBpMmNfZ2V0X21hdGNoX2RhdGEoY2xpZW50KTsNCj4gPg0KPiA+ICAg
ICAgICAgbWx4OTA2MTRfd2FrZXVwKGRhdGEpOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4g
Pg0K
