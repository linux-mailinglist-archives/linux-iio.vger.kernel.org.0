Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1D6628AD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 15:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjAIOiw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 09:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAIOiu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 09:38:50 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223201D0D4;
        Mon,  9 Jan 2023 06:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLLOJf9dnVeMYX/wvLwOw2Q+/6ZvYGnNWQLQf0j4M7IYaH/QACuzo9h3vrpNc2zdO4IEtFpXl/UQg3pT7HvrLEJSyJLu94kJKY7NQz3ppGm/3TD03AuvC34/+MnMsArTeio0y11Dmdx9bqEMxRl3/b4XWqF82Qjn0vZ0YVN62kiu+HoQ9sZQF+bgBqjGNFZkuSpAapXEeYMqa+oR5R294BwGnvEccH3zmqglRBduSYRfxkzIZ+W3XbUgT1sA1fdEheOdV4NXTTo73+GyOhPqgV6ljah2pAA78UfOACTpw5IK0oySYvnM5IInfxE4UzBGoGNSGNQiUV2Us62OUjaH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZzqeEAzflSKM8+R/hmA4Pz5IpXm2YVDiIHgTn53Y5g=;
 b=kSKFjogzDGY5feeiFpZlEqz4WwgBVhgbppymm8bUR4BXBiQkca0qgLc70I8Tf2BcKLwtC5MI55HOFCpy/gBnl5SFxkMBWEFKelbJ9dg3DSXTtBdajt8s310OIBExYeRPlsCRhqp7wAAWI5sjXbW5yuyLiMK9kogcokfizedb6xqqEoKkh0gEYDv/mGFqVATxoc9BndMHpPGD8nnNwdo67VsqlYIgVSkcuWHmZ/jBTIOcNybG+PJMZNAmC7C1BDVGT60Z5mNWzgf8usGNjJJoPgA3DCf1qgxPE6D4TIJcFTCsNEj0+JYo2Zu28xahYfVSwiB8Wx0tJNMZqXpEeLxvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZzqeEAzflSKM8+R/hmA4Pz5IpXm2YVDiIHgTn53Y5g=;
 b=eMSzn3wFUSftY++HpBFUTeQQ2cPezosr+wh1SQY/orTx2yUj3Hi7Qt1kOFRT5buGGyjDrKliUOGAatnbzb5RzPNM8TBVXyaCTUd2F7RKyrPo7AozYW/8KDfJW0NRACcKIq7WG3BQkyQEvIvtZVybH6u95jVzLNVIq+sH+4ThGPM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9712.jpnprd01.prod.outlook.com (2603:1096:400:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:38:46 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:38:46 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Topic: [PATCH v10 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Thread-Index: AQHZEZAUiq0ZEMlrLEO1YySNLLmjlK505+CAgCFhM5CAAAOi4A==
Date:   Mon, 9 Jan 2023 14:38:46 +0000
Message-ID: <OS0PR01MB5922239622CE8CCE96C988DF86FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221216205028.340795-1-biju.das.jz@bp.renesas.com>
 <20221216205028.340795-5-biju.das.jz@bp.renesas.com>
 <CAMuHMdXLqgWLb5B7=Orf6aMtcaXgejftHbOZAmg_yDX6QkCjnA@mail.gmail.com>
 <OS0PR01MB592297092D63FDAA16D46AC086FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592297092D63FDAA16D46AC086FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9712:EE_
x-ms-office365-filtering-correlation-id: 93e20b5b-c9f4-417e-0882-08daf24f36f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6fy1teCMfgzQJTXbbgp0H/JaLys+0YsTjzh+uWnEoKtQZpat/oZTuNOi6bAE1+bUWPRymfZtXys2b0X8xsmE1yqEp31t2FG24iQJgFXq56N0ba9mivSL/RruwbuaQouaq8PdoZ0L2hs1ji+2wTBsf0BbXhIBA+7irhEYAaPnisJz324cJfPgN0q5ry358695ChTuBlMUAEUD35XK+zthKmNO91jY1zb2JGWLuemKMBJUqxdT90SbbnXwrYt9Lm/b9Eq3kqvKyKzcVwoF21FTdbXI/oFxbLpHjYbIOSlC7U/PgunwlsMTJUgiD7SXAY73V6kWuHKsRkTZZftg2BXqKf4G/ZePPKbNo/7DlddX8aNfqknjSVffblC36Mya/C9R8v10uQRcsjCo2Ub1Gluf7Znnm0a5Wqf8TK+yoq0QoSEuoOy7smwjrOccJqkhqoGJ8aq28U+0+pqnw9UymJIqFeBlmHZrShgV5v+gL/lXgCkjStUz3gtsRXgkIghqLvdRQ90sGDYW9+Fvzzr8Eo8l4vYRjKbGawI+X+3TlHBVdATXQTGtL9u2Mszi1z9V59MIrtgFI6ILgi1Zhw7WBoUaTeooTTVn2VblmWUSJxYtQg0Jw4zI+x7dDEGOQc8LDHrA1qKixuo1IaMPwmzBFmOc8hcWeDe2fOhw6SgInAdIoMzIciINdmqyBzsCvtiusoDrSLgPVX5Gxzvpdh3ueVxrq4Feu8xwPwNCSfh8GryFUzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(53546011)(186003)(122000001)(8936002)(52536014)(26005)(6506007)(54906003)(2940100002)(9686003)(55016003)(5660300002)(66946007)(33656002)(7696005)(66446008)(66476007)(64756008)(66556008)(6916009)(4326008)(316002)(86362001)(38070700005)(71200400001)(76116006)(38100700002)(478600001)(41300700001)(8676002)(2906002)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1dGOUlIRkxFWlNGL2w3cTl2Y1JNY3lET2JyenhrKytPbGdXZzFSZzJFaGZw?=
 =?utf-8?B?OGNMZWFuSTZJcTd6UG1HSHdBeFZOWUlWUWcxMDdKRWJ2aXU0WGlKK05sSGdp?=
 =?utf-8?B?bWtTY2w0c3JFYTFKeHJjQnJVMzVXMnJnaTRVak03bUVIK29RZFN2anFkL2g2?=
 =?utf-8?B?YUkzOWNVRHZrbUp0c1FuZnpvay9kVzlTRmJic085ZnRZOXZNTVNjVktGeTZX?=
 =?utf-8?B?M3Z1TFlndDQ5bytwNDI2Snc5UzRVcUkvL3U5NE1YRVlMT09YcFdUR1JHeWwz?=
 =?utf-8?B?UU1NcElzV1drMnN5TUVyc1lQRWR2RGwwOG9NODdvMHpaZVU5cCtlUWVGOHpI?=
 =?utf-8?B?V2FhSUlkMzdQb0RSTDBxTStlTEpiZWFaMmJxYXpET0pkZjRBdzQ4N0pQeXdV?=
 =?utf-8?B?N3RpdnpUaS8rbk5nKzdiZlRFVlZzR2xpZTlwaXRWaEpXQ0thV0N2MmVqQ3Jo?=
 =?utf-8?B?VG9aaThhV1B5R0QxdmlBZFBpRlk1V2Y0eG9HZFk1YkRpQko3aFd0TjZjMmVJ?=
 =?utf-8?B?STRRY0NvWEV6RU9UVzI5RHZGRHlUY08vWTVwT2prQ0RjcmFuNXUzWEtmM1h6?=
 =?utf-8?B?VFJ5eFcxaGF1VnZZU09JcTZkMXJHYTU0Skl5NEgvZHhBYXlvOXFHTG5xL2pR?=
 =?utf-8?B?V0NzSVl0eU5FbndweFVXaUFwdE1VbElNL1M2VmFpeXA0czBRbTRZZzNwVVVi?=
 =?utf-8?B?MFZIeHozclFwL25HNm5Rdk5FVFovME1haXVkMWxCa1c5dHJYRmp0NEJ4QWkv?=
 =?utf-8?B?VmJuL3g5OUEzL3d3NC96dzgzMExmQkZEaUkvV0hkdHRDb0FJN0lhUUJWNVVk?=
 =?utf-8?B?a09nV2FEL3NsaDczbTZWV1VSdlRpNXEwY3BsRXFNZktDelBWUkEvNERHdUxY?=
 =?utf-8?B?V1ozd2pDQVBzTUNvcDRYMFdZdjhaRlg3cWZ4RmY2dXNkYkZ4b0FCbW1MZDdQ?=
 =?utf-8?B?cUl0UTZCYWNMamEzZzhUMmJxQUEveXFUZFVQSVNHanJHc1hjaEgrQi8vQ0tR?=
 =?utf-8?B?bVdqa0lNQU5iMFpsdEUxbDd5aXAwc3JacmhDeUlUWDZ1U3VCNFF5Z05hKzEr?=
 =?utf-8?B?ZlQ5dzZzQ3p0Rk1jcXYvUmRTZlRyRWRXTVFxVExmYkVvdldPMkRnZ3ZZR0ti?=
 =?utf-8?B?TXFzTUZkQWJOMTRTVElncmd0c0o2aVo2UGVkcDFrOGEvcytxSldJbDFHUUpM?=
 =?utf-8?B?Q0hHQ2p6dWFiUCtHcytsbTF5elRpR21UMFZ3YjFLazNqelRLYXBYVHdGTjlI?=
 =?utf-8?B?UEVJQVZCbnVYdnF2TUt3WG5rYllOYnhFbGdHWmJQRnFVaHpjM29wbmdFZjZl?=
 =?utf-8?B?VExiNTVibXBDbXBzcVl3VVJkdTgrWXBGY2RLSGZIdDNudGM2MXlUZVFzeGsv?=
 =?utf-8?B?dHZiQll4em5VcDQ4cThWQnFySForc0lQb0x4NFpOVGRMZ2o5bXFURGJPR21L?=
 =?utf-8?B?b29ybFlUdTZRS3JPdjJqZ2tJbWlJUXVhOGJZalpaMUdCdy82NmlmSE1INzhE?=
 =?utf-8?B?VGhiUFhCQmJCSUgxNTVmbUVvbFZDTnVyeENuQ3p3c1ExZ2F6S0MrQVUwZm9z?=
 =?utf-8?B?MkJWaXlzNzkrdWtMeTlKQkFIRUpSdEV3TUtvb2tFajJHZFpaWUdBQzBlQVh3?=
 =?utf-8?B?OGgrYXBVRXdoSW5yVFNPYnJBNUtFK01lWHR5cFB5NkdwdFZjTmVYTDkrTlpt?=
 =?utf-8?B?dDVZNytkYVFiOFoxaHhtNlBSTllFSTBBdW80OTRmOXpBclg1eUkvQlpZSkRM?=
 =?utf-8?B?MkNESFFTVFZBSFJ6dGtTWWpJaEJtL29sRGM0WDNVUWN4L3doS0xhT0c1RHZD?=
 =?utf-8?B?U3hLdi9LNFVDRi9EcFVwKzR3eXp1Y3hkbzlUZTV1aStKMndrc2JkNitLN3ZB?=
 =?utf-8?B?OU82ZzZkRy83WHFwSU9GOC9BOFFhRXZFeXBOWUtnUWI4ekxScnoxNUZSOGRx?=
 =?utf-8?B?ZjdVTm9qZkVMdUFXTVU4bkdNaDI5WWl4cG5SZGwzaEFsZFlpbitHYTVFbzNj?=
 =?utf-8?B?YW0xNkRrU3Yrd0Zac1UzSGRyTzVCZytDOG5ZdUxVWGtzQVhTa20zcGRtZnkr?=
 =?utf-8?B?dG5QR0FLQVFOUmlsUmZIOURtbHA5QlYxVTlCN1JpamVuZzBCblM0a1haczF1?=
 =?utf-8?B?VVFCb0p1TEpIeHA4b01kRzFBaHpmRHJkL0w1bXp0alVHZXV5Z1VZa01UdnpG?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e20b5b-c9f4-417e-0882-08daf24f36f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 14:38:46.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buEij1rm/it+LPtsDYl8FavRHblz8WQ3UjBybkUb4ut9Nk0n72fU/AqJ/I9mVlsHZwwmYEpYyhmAtEeATZHXOSUKB5J6mo6vL+TiNJX19rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9712
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTZW50OiAwOSBKYW51YXJ5IDIwMjMgMTQ6MjgNCj4g
VG86IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IENjOiBXaWxs
aWFtIEJyZWF0aGl0dCBHcmF5IDx3aWxsaWFtLmdyYXlAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBp
aW9Admdlci5rZXJuZWwub3JnOyBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVz
YXMuY29tPjsgUHJhYmhha2FyDQo+IE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+OyBsaW51eC1yZW5lc2FzLQ0KPiBzb2NAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEwIDQvNV0gY291bnRlcjogQWRkIFJlbmVzYXMgUlov
RzJMIE1UVTNhIGNvdW50ZXINCj4gZHJpdmVyDQo+IA0KPiBIaSBHZWVydCwNCj4gDQo+IFRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4g
U2VudDogMTkgRGVjZW1iZXIgMjAyMiAwODo0MA0KPiA+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4gQ2M6IFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkgPHdpbGxp
YW0uZ3JheUBsaW5hcm8ub3JnPjsgbGludXgtDQo+ID4gaWlvQHZnZXIua2VybmVsLm9yZzsgQ2hy
aXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+ID4gUHJhYmhha2Fy
IE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+Ow0K
PiA+IGxpbnV4LXJlbmVzYXMtIHNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMCA0LzVdIGNvdW50ZXI6IEFkZCBSZW5lc2FzIFJaL0cyTCBNVFUzYSBjb3VudGVy
DQo+ID4gZHJpdmVyDQo+ID4NCj4gPiBIaSBCaWp1LA0KPiA+DQo+ID4gT24gRnJpLCBEZWMgMTYs
IDIwMjIgYXQgOTo1MCBQTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+
IHdyb3RlOg0KPiA+ID4gQWRkIFJaL0cyTCBNVFUzYSBjb3VudGVyIGRyaXZlci4gVGhpcyBJUCBz
dXBwb3J0cyB0aGUgZm9sbG93aW5nDQo+ID4gPiBwaGFzZSBjb3VudGluZyBtb2RlcyBvbiBNVFUx
IGFuZCBNVFUyIGNoYW5uZWxzDQo+ID4gPg0KPiA+ID4gMSkgMTYtYml0IHBoYXNlIGNvdW50aW5n
IG1vZGVzIG9uIE1UVTEgYW5kIE1UVTIgY2hhbm5lbHMuDQo+ID4gPiAyKSAzMi1iaXQgcGhhc2Ug
Y291bnRpbmcgbW9kZSBieSBjYXNjYWRpbmcgTVRVMSBhbmQgTVRVMiBjaGFubmVscy4NCj4gPiA+
DQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgMyBjb3VudGVyIHZhbHVlIGNoYW5uZWxzLg0KPiA+ID4g
ICAgICAgICBjb3VudDA6IDE2LWJpdCBwaGFzZSBjb3VudGVyIHZhbHVlIGNoYW5uZWwgb24gTVRV
MQ0KPiA+ID4gICAgICAgICBjb3VudDE6IDE2LWJpdCBwaGFzZSBjb3VudGVyIHZhbHVlIGNoYW5u
ZWwgb24gTVRVMg0KPiA+ID4gICAgICAgICBjb3VudDI6IDMyLWJpdCBwaGFzZSBjb3VudGVyIHZh
bHVlIGNoYW5uZWwgYnkgY2FzY2FkaW5nDQo+ID4gPiAgICAgICAgICAgICAgICAgTVRVMSBhbmQg
TVRVMiBjaGFubmVscy4NCj4gPiA+DQo+ID4gPiBUaGUgZXh0ZXJuYWwgaW5wdXQgcGhhc2UgY2xv
Y2sgcGluIGZvciB0aGUgY291bnRlciB2YWx1ZSBjaGFubmVscw0KPiA+ID4gYXJlIGFzIGZvbGxv
d3M6DQo+ID4gPiAgICAgICAgIGNvdW50MDogIk1UQ0xLQS1NVENMS0IiDQo+ID4gPiAgICAgICAg
IGNvdW50MTogIk1UQ0xLQS1NVENMS0IiIG9yICJNVENMS0MtTVRDTEtEIg0KPiA+ID4gICAgICAg
ICBjb3VudDI6ICJNVENMS0EtTVRDTEtCIiBvciAiTVRDTEtDLU1UQ0xLRCINCj4gPiA+DQo+ID4g
PiBVc2UgdGhlIHN5c2ZzIHZhcmlhYmxlICJleHRlcm5hbF9pbnB1dF9waGFzZV9jbG9ja19zZWxl
Y3QiIHRvIHNlbGVjdA0KPiA+ID4gdGhlIGV4dGVybmFsIGlucHV0IHBoYXNlIGNsb2NrIHBpbiBh
bmQgImNhc2NhZGVfY291bnRzX2VuYWJsZSIgdG8NCj4gPiA+IGVuYWJsZS8gZGlzYWJsZSBjYXNj
YWRpbmcgb2YgY2hhbm5lbHMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2OS0+djEwOg0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiA+DQo+ID4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gPiArKysgYi9kcml2ZXJzL2NvdW50ZXIvcnotbXR1My1jbnQuYw0KPiA+DQo+ID4gPiAr
c3RhdGljIGludCByel9tdHUzX2NvdW50X3JlYWQoc3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3Vu
dGVyLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGNvdW50ZXJf
Y291bnQgKmNvdW50LCB1NjQgKnZhbCkgew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcnpfbXR1M19j
aGFubmVsICpjb25zdCBjaCA9IHJ6X210dTNfZ2V0X2NoKGNvdW50ZXIsDQo+ID4gPiArY291bnQt
DQo+ID4gPmlkKTsNCj4gPiA+ICsgICAgICAgc3RydWN0IHJ6X210dTNfY250ICpjb25zdCBwcml2
ID0gY291bnRlcl9wcml2KGNvdW50ZXIpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBtdXRleF9s
b2NrKCZwcml2LT5sb2NrKTsNCj4gPiA+ICsgICAgICAgaWYgKGNoLT5pc19idXN5ICYmICFwcml2
LT5jb3VudF9pc19lbmFibGVkW2NvdW50LT5pZF0pIHsNCj4gPiA+ICsgICAgICAgICAgICAgICBt
dXRleF91bmxvY2soJnByaXYtPmxvY2spOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGlmIChyel9t
dHUzX2lzX2NvdW50ZXJfaW52YWxpZChjb3VudGVyLCBjb3VudC0+aWQpKSB7DQo+ID4gPiArICAg
ICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsNCj4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVCVVNZOw0KPiA+ID4gKyAgICAgICB9DQo+ID4NCj4gPiBBcyB0aGUgbG9j
a2luZyBhbmQgdGhlIGFib3ZlIHR3byBjaGVja3MgYXJlIGR1cGxpY2F0ZWQgbXVsdGlwbGUgdGlt
ZXMsDQo+ID4gcGVyaGFwcyB0aGV5IGNhbiBiZSByZXBsYWNlZCBieSBhbiByel9tdHUzX2xvY2tf
aWZfY291bnRlcl9pc192YWxpZCgpDQo+ID4gaGVscGVyIGZ1bmN0aW9uPw0KPiANCj4gT0sgd2ls
bCB1c2UgdGhlIGhlbHBlciBmdW5jdGlvbiAiIHJ6X210dTNfbG9ja19pZl9jb3VudGVyX2lzX3Zh
bGlkIg0KPiANCj4gK3N0YXRpYyBpbnQgcnpfbXR1M19sb2NrX2lmX2NvdW50ZXJfaXNfdmFsaWQo
c3RydWN0IGNvdW50ZXJfZGV2aWNlICpjb3VudGVyLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByel9tdHUzX2NoYW5uZWwgKmNvbnN0DQo+IGNo
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBy
el9tdHUzX2NudCAqY29uc3QgcHJpdiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgaWQpIHsNCj4gKyAgICAgICBpZiAoY2gtPmlzX2J1c3kgJiYgIXBy
aXYtPmNvdW50X2lzX2VuYWJsZWRbaWRdKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ICsNCj4gKyAgICAgICBpZiAocnpfbXR1M19pc19jb3VudGVyX2ludmFsaWQoY291bnRl
ciwgaWQpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gKw0KPiArICAgICAg
IG11dGV4X2xvY2soJnByaXYtPmxvY2spOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9
DQoNCkl0IHdpbGwgYmUgdXBkYXRlZCBhcywNCg0Kc3RhdGljIGludCByel9tdHUzX2xvY2tfaWZf
Y291bnRlcl9pc192YWxpZChzdHJ1Y3QgY291bnRlcl9kZXZpY2UgKmNvdW50ZXIsDQoJCQkJCSAg
ICBzdHJ1Y3QgcnpfbXR1M19jaGFubmVsICpjb25zdCBjaCwNCgkJCQkJICAgIHN0cnVjdCByel9t
dHUzX2NudCAqY29uc3QgcHJpdiwNCgkJCQkJICAgIGludCBpZCkNCnsNCgltdXRleF9sb2NrKCZw
cml2LT5sb2NrKTsNCg0KCWlmIChjaC0+aXNfYnVzeSAmJiAhcHJpdi0+Y291bnRfaXNfZW5hYmxl
ZFtpZF0pIHsNCgkJbXV0ZXhfdW5sb2NrKCZwcml2LT5sb2NrKTsNCgkJcmV0dXJuIC1FSU5WQUw7
DQoJfQ0KDQoJaWYgKHJ6X210dTNfaXNfY291bnRlcl9pbnZhbGlkKGNvdW50ZXIsIGlkKSkgew0K
CQltdXRleF91bmxvY2soJnByaXYtPmxvY2spOw0KCQlyZXR1cm4gLUVCVVNZOw0KCX0NCg0KCXJl
dHVybiAwOw0KfQ0KDQpDaGVlcnMsDQpCaWp1DQo=
