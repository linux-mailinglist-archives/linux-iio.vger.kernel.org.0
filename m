Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A566278C7D3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjH2Om6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjH2Omi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 10:42:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B8CC;
        Tue, 29 Aug 2023 07:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEOF47Ll8z9v0dO6bee0kIS40T/J9Rlt2uj1zJ/hjWCraVwOW0NrdxPmiUy5aM+wlDAGvRz+CNzIQmoFDl9UDyTck9TNSgBwADacfbcDVx9x3Qvz50brSyFNIQW+jNqmoQYjlPIeeU94iL/XLvuU5arCMjUjOJbOMH+XctduNigCr8+58sYNnMCih+U/21tb1HOWheIw3ubLdu+/Vv1cNmh0pAHKslJ9+rDGSktv1Qh81w58AFIq/gxLpTCHxK10cqpBv/4sys0aG8ZgcwXt4pILtFLuEHXkTlMWji+9/irqcrEOV2K9WzwqclFl1h7j5ggJkUJQRQ9fq+A6S/1I5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HfmFZfDzjOLdgGNIlpjx6t94QBlzjWfoTk8CHS7bbY=;
 b=Eau/NoSz+r37v9sPLhs2O8y6KC7APwC0JWHzdefUIE9P8cco2lMaM3YV7NdbxztHFJYOez3ewWdXS/XDfFt2CPkHc/9J8Zzl9it+RxOvGbWAVpIxDIp0Ch3UNKpxaTKwBlRPkP6fKevYD72updrr8/ggL8B2v5bo+xaaqJkl77JY5kS87JMj3iR7uWef9SgU8iFSj0LZDvOP6jYj1EB0ghTrbB4SAFepu50Y2r3cPZW8cCZFjlIPkhRb67rx0s2UFv2fFDwq1z8Iv78pjHKhKv7hSjNl4oAP/UDs8GcBWxfyZTZghEyEOqR7DeuhcvJFkFmFk8HoazhPK4XY7nMU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HfmFZfDzjOLdgGNIlpjx6t94QBlzjWfoTk8CHS7bbY=;
 b=QUIGEIsBrTffCjcwPerTdXch4GCGAx0XKXxD3E+ZTK3gcB4N1dJXmOUTSFHKOgOQIzeWuc4QajPibIqmJdmdA6/JKbD9NskuDJ14az6hbvfIWr8W26PnFdX1NytrzSP75lig1/6Y7dUOmD+WqdsFetPDtF2Mg9gUE4rLBO+DdTw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8912.jpnprd01.prod.outlook.com (2603:1096:604:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:42:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:42:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iio: dac: ti-dac5571: Use i2c_get_match_data()
Thread-Topic: [PATCH v2 1/2] iio: dac: ti-dac5571: Use i2c_get_match_data()
Thread-Index: AQHZ0frrVhmbbAHj+Ei/VbehnAKbwa//x6IAgAGiGAA=
Date:   Tue, 29 Aug 2023 14:42:32 +0000
Message-ID: <OS0PR01MB59228C9222CB2A8702FCA67C86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
 <20230818173907.323640-2-biju.das.jz@bp.renesas.com>
 <20230828134442.GL14596@pendragon.ideasonboard.com>
In-Reply-To: <20230828134442.GL14596@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8912:EE_
x-ms-office365-filtering-correlation-id: 4b50945d-05b3-4bcc-c4bf-08dba89e2d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QhmtrBi71oynB/CH16erfE9mYVpCeewmzsH4u3419As7qUD+p9P8Ov9JPf7Axjy2rOOTjQ6SxDhUaJpN/fnYVedBaPnBQV2NZIbBXXo4HPYWerKr+rgSbbbYncgn4of1hQX7r14o4fO1PR4dZikSN0uy+WNZj2TXjOEvDqYRcdtzVoXTjmOncPc0sYrsR7fXnjEIve2lGLI1TKDb/hJ5nh4jSgkUDeBwM43QH+/7Fu17GnpaTSspfZ4BPEih/5+xf5minzjDtGB+gE98C+4ep5tzWXTYTK7CtozdNhHihQW7B3uoP8UG05k9hiq3wGGdjYQfo016E9ZUcfwnpLemvVXKtNnBzTKXcRyxR3OuCBcCOnJjOlwd8YRtNKxj2EyNAp6YD36RJ6uEA5Y/6oYCI9nucgEXpkrN8XUvUncrCDefTaMqtSkw1I2KbSLUz+Um8ICBGx+Wcx/QDxVgEoc2tdZD+avy6FcSEb/o6JXU1rwN8iorq+yD/d2wszrMfDzvr55Jhpl6p3b7tc8MVeMxdAy3b4z8M4Nn3b+PUme+EK2+853cd/NhITCq/KdrK4vSFOBUiZn+JJ/OHs8uGsMX1HlN5+gfyi+ItI0ItDlpaDD8fdy/ULSZGRYg4TKL+ll5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(451199024)(1800799009)(71200400001)(6506007)(9686003)(7696005)(478600001)(83380400001)(2906002)(76116006)(316002)(64756008)(54906003)(6916009)(66446008)(66946007)(66476007)(8936002)(52536014)(66556008)(5660300002)(41300700001)(8676002)(4326008)(86362001)(33656002)(122000001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0xoRVdZTzkvVWhsY2daSTdFS1puYnZpYVpDSnpZdEtJQXMyTHRzNCsxTVV4?=
 =?utf-8?B?WWF3blV5QzB5MUUwUGxBL2JFdktqZVc5VU50WGxReTBJMm1MZS95d2ZlS3N1?=
 =?utf-8?B?azhwWG44K255a0hXZmEzaVNmUlEzaklnYmFoc1M2ZVFQRFRwbjJrbnRtR2lI?=
 =?utf-8?B?V3pCVkxWeTlPcTlka2pmT1dTMlNkQ1U3Zm5pUXR6RHFEZE1GSXp6TmFhWHRY?=
 =?utf-8?B?RTFIUlNNTTd5SlUxREhiTG05eE5tQXNzYTJxVmRhZlMvMTUxV3g4YThabVVG?=
 =?utf-8?B?bnpGdHJmNitnN1pTZjJEcDIrN1ltWG1FbFhVSTNoQVo0VzNENTc3NE12Y0xy?=
 =?utf-8?B?T1VleU1sRCs3RUtrZFlqL0VBKzZUVUlRMDN5cklTcHpXYTR3UHF6S1lmZEc5?=
 =?utf-8?B?QUlIUFBIQ3hIZXhibDBOUnMzcVQ3dlRHeGFuQ2xxbVIxVG1PdGFFWVhWU1p1?=
 =?utf-8?B?aDJqYWhRMFdKT2FLTlhDRzREeFNqUGJXOHcvTExETzh4cEFiV2Y1MmdzNWYv?=
 =?utf-8?B?QWhXWGZGWERyZ2tNclVXY204bS8yNVpyMktTa3dtYTNKR2pBOEV1U010RnZl?=
 =?utf-8?B?UU5lUCtHSVlCNGNYQ1c0TW56aDF6WmN3Sy9aaW92d1JmOVc2YndiRkJvUGlO?=
 =?utf-8?B?Wll6VUFyeW84ZDNDVzEwcU1TSThMSzhNRmd1UXdTNGpTVDFsZXEvOUZ4a1Na?=
 =?utf-8?B?enV3bjVIZ01LNjVxMm9LN2Y5V2JBOE5YU09WcXdoY0dQTzY4cVBqMWxPTXpU?=
 =?utf-8?B?eFkvVTRsWmhSOXpESjI2RkZxWVpUZHdyQjdtcUUxdi9JdzZPTzJFRGowbzVm?=
 =?utf-8?B?SGUxdmtKVnhSL2JjcHA0YTJsZmNUeXpKV0FCUGYyb3EyVjhQem9UU3dhRWtY?=
 =?utf-8?B?Ym1BZVJiOGZPQkFHb0JPSTIzM1YvamNxMmNTQUJRNEpBOTFzUE1EUDJyVDEv?=
 =?utf-8?B?Y0F5UXFTdndMMTBaNUphRGs2dU1kaGZKMVBSeWNVbTRHVmNGemUzaVMzTzMy?=
 =?utf-8?B?QzVWZkhFL1RkVE5aVWtjRnBkd2Q2YUxKd2U4NFRubTMrb0Rac0JaSk44bVl6?=
 =?utf-8?B?bEJkWngxWGsyRndrSVR3aVNOOUxTV0NmZGdoRWtlRFVzdS9Jbldjd09SenVE?=
 =?utf-8?B?UVZjY25ob1dVTDJHVE5ROXM5Ym11MVNMdXJsZFB6elNNT211amhEWk5Pc3Iz?=
 =?utf-8?B?bDFuRVhMQnhXdGZiOE51S01HZTB3VGFLZTZWenVibFVkc3JYcS9vZFNVeDdM?=
 =?utf-8?B?RHRNWEhNRWVrTnRXSHlmeUorSHpoL08wWk5zRnN1S1NJNk9GaFFPQ0F6Wisy?=
 =?utf-8?B?L203ZkZTMkx6V1g2K3VJVzk1VEw2Rm95eStUQnM5UnFmVmJ0aGJvdmdiRThx?=
 =?utf-8?B?V015WWN5eWpYTTlHbDR2dzZSVlZvMjdJUmVpZ0U2T1ZkanhWQXNXUkZtVXA0?=
 =?utf-8?B?a29Ca09oblNuVWJianJKbVJnbnlyNXlSeDc2Y0gzVUN4L2RBc1lvNWd5NG9t?=
 =?utf-8?B?V245akdQbksrTW9aa1gvMjVkRjlvQ3pxcHk2NVhJUjh2R3hVc0hOaWd6eGp6?=
 =?utf-8?B?N2ZiL3dXQUxDV3Jvb0NJS1RWSmc5aGszY1dwTUQvSktyekRLRGZVTmFidUVN?=
 =?utf-8?B?cXZ3dEtSRjhCWWwyM0cwaUVFV2c2akh3bklpRkxVejI4RTNlRHhLVzJYSEpr?=
 =?utf-8?B?SmNlUWlhOVdtR1BSRjlRbnlnd0FpK3VoUSt2UW1XZDcrK1ZkVlorSmxzMklj?=
 =?utf-8?B?NGhKZEE2UVVMVWNFYTFRZGttVlcvdk1JR2h4NklOS2pQZDY5Wmhka1ZRd3ZY?=
 =?utf-8?B?YlVzSm5VTU9zUkpPNWF1a1JiZ1pLajQ3SWJ2M1FuNHF2TUE0aWNmSXNWSjZP?=
 =?utf-8?B?NFJ0YWgzaVYzRHZLMEJCWWNUWENaRzMvVERVcG5xTzNiUUEyMm10WnlWQ2FC?=
 =?utf-8?B?TzB2WGRUUjBxL0NNRWJFSERmcDF1REpKSDN3RW1nMXhQUTI4dDRTd2JoeXgr?=
 =?utf-8?B?SlZZTGh0YWl3cEhwa21mVURiRzJiR2M0V09yTzhna0g3aUlOMENRQmdtR3dG?=
 =?utf-8?B?aks2ZmJlbytSQjViUVpCTGxrOUt1REl0YjVmTkNneENoZlQ0WUhBb0hIM2M2?=
 =?utf-8?Q?65WM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b50945d-05b3-4bcc-c4bf-08dba89e2d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:42:32.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkUjvkcTovhmGc3LZrFv0BdiWLyc8JXNZm0dVI/Y5DvXOGMXTjLcJOGSGx7NBsQOgrLAm3sUmbGWFTgHRSw+wdmjlH9sE/7ZPkYVPOeF6fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8912
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTGF1cmVudCBQaW5jaGFydCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gaWlv
OiBkYWM6IHRpLWRhYzU1NzE6IFVzZSBpMmNfZ2V0X21hdGNoX2RhdGEoKQ0KPiANCj4gSGkgQmlq
dSwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPiANCj4gT24gRnJpLCBBdWcgMTgs
IDIwMjMgYXQgMDY6Mzk6MDZQTSArMDEwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gUmVwbGFjZSBk
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSBhbmQgaWQgbG9va3VwIGZvciByZXRyaWV2aW5nIG1hdGNo
DQo+ID4gZGF0YSBieSBpMmNfZ2V0X21hdGNoX2RhdGEoKSBieSBjb252ZXJ0aW5nIGVudW0tPnBv
aW50ZXIgZm9yIGRhdGEgaW4NCj4gPiB0aGUgbWF0Y2ggdGFibGUuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGUg
Y2hhbmdlIGxvb2tzIGZpbmUsIGJ1dCBhIGNvbW1pdCBtZXNzYWdlIHRoYXQgZXhwbGFpbnMgd2h5
IHdvdWxkIGJlDQo+IG5pY2UsIHRoZSBzYW1lIHdheSB5b3UgaGF2ZSBkb25lIHdpdGggYSBzaW1p
bGFyIG1vZGlmaWNhdGlvbiBpbiBhIERSTQ0KPiBicmlkZ2UgZHJpdmVyLg0KDQpCYXNpY2FsbHks
IGl0IHNpbXBsaWZpZXMgdGhlIHByb2JlKCkuIEkgd2lsbCBhZGQgdGhpcyBpbmZvLg0KDQpDaGVl
cnMsDQpCaWp1DQoNCj4gDQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+ICAqIE5vIGNoYW5nZS4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vZGFjL3RpLWRhYzU1NzEuYyB8IDQ4DQo+ID4gKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9kYWMvdGktZGFjNTU3MS5jDQo+ID4gYi9kcml2ZXJzL2lpby9kYWMvdGktZGFj
NTU3MS5jIGluZGV4IGJhYjExYjlhZGMyNS4uMmJiM2Y3NjU2OWVlIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaWlvL2RhYy90aS1kYWM1NTcxLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9kYWMv
dGktZGFjNTU3MS5jDQo+ID4gQEAgLTMxMyw3ICszMTMsNiBAQCBzdGF0aWMgaW50IGRhYzU1NzFf
cHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkNCj4gPiAgCWNvbnN0IHN0cnVjdCBkYWM1
NTcxX3NwZWMgKnNwZWM7DQo+ID4gIAlzdHJ1Y3QgZGFjNTU3MV9kYXRhICpkYXRhOw0KPiA+ICAJ
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gPiAtCWVudW0gY2hpcF9pZCBjaGlwX2lkOw0K
PiA+ICAJaW50IHJldCwgaTsNCj4gPg0KPiA+ICAJaW5kaW9fZGV2ID0gZGV2bV9paW9fZGV2aWNl
X2FsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSk7IEBAIC0zMjksMTINCj4gPiArMzI4LDcgQEAgc3Rh
dGljIGludCBkYWM1NTcxX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ID4gIAlp
bmRpb19kZXYtPm1vZGVzID0gSU5ESU9fRElSRUNUX01PREU7DQo+ID4gIAlpbmRpb19kZXYtPmNo
YW5uZWxzID0gZGFjNTU3MV9jaGFubmVsczsNCj4gPg0KPiA+IC0JaWYgKGRldl9md25vZGUoZGV2
KSkNCj4gPiAtCQljaGlwX2lkID0gKHVpbnRwdHJfdClkZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2
KTsNCj4gPiAtCWVsc2UNCj4gPiAtCQljaGlwX2lkID0gaWQtPmRyaXZlcl9kYXRhOw0KPiA+IC0N
Cj4gPiAtCXNwZWMgPSAmZGFjNTU3MV9zcGVjW2NoaXBfaWRdOw0KPiA+ICsJc3BlYyA9IGkyY19n
ZXRfbWF0Y2hfZGF0YShjbGllbnQpOw0KPiA+DQo+ID4gIAlpbmRpb19kZXYtPm51bV9jaGFubmVs
cyA9IHNwZWMtPm51bV9jaGFubmVsczsNCj4gPiAgCWRhdGEtPnNwZWMgPSBzcGVjOw0KPiA+IEBA
IC0zOTIsMzEgKzM4NiwzMSBAQCBzdGF0aWMgdm9pZCBkYWM1NTcxX3JlbW92ZShzdHJ1Y3QgaTJj
X2NsaWVudA0KPiA+ICppMmMpICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgZGFjNTU3MV9vZl9pZFtdID0gew0KPiA+IC0Jey5jb21wYXRpYmxlID0gInRpLGRh
YzU1NzEiLCAuZGF0YSA9ICh2b2lkICopc2luZ2xlXzhiaXR9LA0KPiA+IC0Jey5jb21wYXRpYmxl
ID0gInRpLGRhYzY1NzEiLCAuZGF0YSA9ICh2b2lkICopc2luZ2xlXzEwYml0fSwNCj4gPiAtCXsu
Y29tcGF0aWJsZSA9ICJ0aSxkYWM3NTcxIiwgLmRhdGEgPSAodm9pZCAqKXNpbmdsZV8xMmJpdH0s
DQo+ID4gLQl7LmNvbXBhdGlibGUgPSAidGksZGFjNTU3NCIsIC5kYXRhID0gKHZvaWQgKilxdWFk
XzhiaXR9LA0KPiA+IC0Jey5jb21wYXRpYmxlID0gInRpLGRhYzY1NzQiLCAuZGF0YSA9ICh2b2lk
ICopcXVhZF8xMGJpdH0sDQo+ID4gLQl7LmNvbXBhdGlibGUgPSAidGksZGFjNzU3NCIsIC5kYXRh
ID0gKHZvaWQgKilxdWFkXzEyYml0fSwNCj4gPiAtCXsuY29tcGF0aWJsZSA9ICJ0aSxkYWM1NTcz
IiwgLmRhdGEgPSAodm9pZCAqKXF1YWRfOGJpdH0sDQo+ID4gLQl7LmNvbXBhdGlibGUgPSAidGks
ZGFjNjU3MyIsIC5kYXRhID0gKHZvaWQgKilxdWFkXzEwYml0fSwNCj4gPiAtCXsuY29tcGF0aWJs
ZSA9ICJ0aSxkYWM3NTczIiwgLmRhdGEgPSAodm9pZCAqKXF1YWRfMTJiaXR9LA0KPiA+IC0Jey5j
b21wYXRpYmxlID0gInRpLGRhYzEyMWMwODEiLCAuZGF0YSA9ICh2b2lkICopc2luZ2xlXzEyYml0
fSwNCj4gPiArCXsuY29tcGF0aWJsZSA9ICJ0aSxkYWM1NTcxIiwgLmRhdGEgPSAmZGFjNTU3MV9z
cGVjW3NpbmdsZV84Yml0XSB9LA0KPiA+ICsJey5jb21wYXRpYmxlID0gInRpLGRhYzY1NzEiLCAu
ZGF0YSA9ICZkYWM1NTcxX3NwZWNbc2luZ2xlXzEwYml0XSB9LA0KPiA+ICsJey5jb21wYXRpYmxl
ID0gInRpLGRhYzc1NzEiLCAuZGF0YSA9ICZkYWM1NTcxX3NwZWNbc2luZ2xlXzEyYml0XSB9LA0K
PiA+ICsJey5jb21wYXRpYmxlID0gInRpLGRhYzU1NzQiLCAuZGF0YSA9ICZkYWM1NTcxX3NwZWNb
cXVhZF84Yml0XSB9LA0KPiA+ICsJey5jb21wYXRpYmxlID0gInRpLGRhYzY1NzQiLCAuZGF0YSA9
ICZkYWM1NTcxX3NwZWNbcXVhZF8xMGJpdF0gfSwNCj4gPiArCXsuY29tcGF0aWJsZSA9ICJ0aSxk
YWM3NTc0IiwgLmRhdGEgPSAmZGFjNTU3MV9zcGVjW3F1YWRfMTJiaXRdIH0sDQo+ID4gKwl7LmNv
bXBhdGlibGUgPSAidGksZGFjNTU3MyIsIC5kYXRhID0gJmRhYzU1NzFfc3BlY1txdWFkXzhiaXRd
IH0sDQo+ID4gKwl7LmNvbXBhdGlibGUgPSAidGksZGFjNjU3MyIsIC5kYXRhID0gJmRhYzU1NzFf
c3BlY1txdWFkXzEwYml0XSB9LA0KPiA+ICsJey5jb21wYXRpYmxlID0gInRpLGRhYzc1NzMiLCAu
ZGF0YSA9ICZkYWM1NTcxX3NwZWNbcXVhZF8xMmJpdF0gfSwNCj4gPiArCXsuY29tcGF0aWJsZSA9
ICJ0aSxkYWMxMjFjMDgxIiwgLmRhdGEgPSAmZGFjNTU3MV9zcGVjW3NpbmdsZV8xMmJpdF0NCj4g
PiArfSwNCj4gPiAgCXt9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGRh
YzU1NzFfb2ZfaWQpOw0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9p
ZCBkYWM1NTcxX2lkW10gPSB7DQo+ID4gLQl7ImRhYzU1NzEiLCBzaW5nbGVfOGJpdH0sDQo+ID4g
LQl7ImRhYzY1NzEiLCBzaW5nbGVfMTBiaXR9LA0KPiA+IC0JeyJkYWM3NTcxIiwgc2luZ2xlXzEy
Yml0fSwNCj4gPiAtCXsiZGFjNTU3NCIsIHF1YWRfOGJpdH0sDQo+ID4gLQl7ImRhYzY1NzQiLCBx
dWFkXzEwYml0fSwNCj4gPiAtCXsiZGFjNzU3NCIsIHF1YWRfMTJiaXR9LA0KPiA+IC0JeyJkYWM1
NTczIiwgcXVhZF84Yml0fSwNCj4gPiAtCXsiZGFjNjU3MyIsIHF1YWRfMTBiaXR9LA0KPiA+IC0J
eyJkYWM3NTczIiwgcXVhZF8xMmJpdH0sDQo+ID4gLQl7ImRhYzEyMWMwODEiLCBzaW5nbGVfMTJi
aXR9LA0KPiA+ICsJeyJkYWM1NTcxIiwgKGtlcm5lbF91bG9uZ190KSZkYWM1NTcxX3NwZWNbc2lu
Z2xlXzhiaXRdIH0sDQo+ID4gKwl7ImRhYzY1NzEiLCAoa2VybmVsX3Vsb25nX3QpJmRhYzU1NzFf
c3BlY1tzaW5nbGVfMTBiaXRdIH0sDQo+ID4gKwl7ImRhYzc1NzEiLCAoa2VybmVsX3Vsb25nX3Qp
JmRhYzU1NzFfc3BlY1tzaW5nbGVfMTJiaXRdIH0sDQo+ID4gKwl7ImRhYzU1NzQiLCAoa2VybmVs
X3Vsb25nX3QpJmRhYzU1NzFfc3BlY1txdWFkXzhiaXRdIH0sDQo+ID4gKwl7ImRhYzY1NzQiLCAo
a2VybmVsX3Vsb25nX3QpJmRhYzU1NzFfc3BlY1txdWFkXzEwYml0XSB9LA0KPiA+ICsJeyJkYWM3
NTc0IiwgKGtlcm5lbF91bG9uZ190KSZkYWM1NTcxX3NwZWNbcXVhZF8xMmJpdF0gfSwNCj4gPiAr
CXsiZGFjNTU3MyIsIChrZXJuZWxfdWxvbmdfdCkmZGFjNTU3MV9zcGVjW3F1YWRfOGJpdF0gfSwN
Cj4gPiArCXsiZGFjNjU3MyIsIChrZXJuZWxfdWxvbmdfdCkmZGFjNTU3MV9zcGVjW3F1YWRfMTBi
aXRdIH0sDQo+ID4gKwl7ImRhYzc1NzMiLCAoa2VybmVsX3Vsb25nX3QpJmRhYzU1NzFfc3BlY1tx
dWFkXzEyYml0XSB9LA0KPiA+ICsJeyJkYWMxMjFjMDgxIiwgKGtlcm5lbF91bG9uZ190KSZkYWM1
NTcxX3NwZWNbc2luZ2xlXzEyYml0XSB9LA0KPiA+ICAJe30NCj4gPiAgfTsNCj4gPiAgTU9EVUxF
X0RFVklDRV9UQUJMRShpMmMsIGRhYzU1NzFfaWQpOw0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4g
DQo+IExhdXJlbnQgUGluY2hhcnQNCg==
