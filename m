Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6C60CE11
	for <lists+linux-iio@lfdr.de>; Tue, 25 Oct 2022 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJYN7C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Oct 2022 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJYN6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2022 09:58:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B9C17E20D;
        Tue, 25 Oct 2022 06:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk2gW1mJd6Sywv/A/L9B8h9mnvh3M3eskigyffUcrsI0LPXVpICcwGrxpnOBHIHyA6JWj7GR7RrFh9ZR5UixQ59IzUR9sXoIIxaS+J41relipoK/q+MrkNJq15tMbAM6djOyYWLqpE8ZePDUrsky4Gqlgg6CmPHtnl3fs6ZhKdPdX5QIdAO0RFw87TYJ63fPogka2cFFZXx6/A1RMscxQUyqAqZYpdNeeRELN57VH2cLdIkP+XxZ8PxlFtDNwnYdWK5kvBfDmNWc969GZx+TXgpSqT8YtD3Su/kQPd/l8TlV3R6yll+jIpW4onO34IYTu8hTMD9HQx2PdyLOb3l6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErNeVYilYSjbxcTGr/zlgGrdzwNM2xbqPunVehLgYsA=;
 b=HGQKdeLCWa/h2N+yCu/xkvm6O3MAqBcpAe6k5npRTQ62iH2t4glW1EKNq8D3xDgJ945Hkk1B14P75YjacZyOnlPDoYCt0i0/og+K73Gt3+UbWzXvsbpYnmQefZmrcQ+/hFUUmxmxJVTWTy5B3F5IdBrtLbYOpjRZMdcjbndj/UfugZ9gZSIqUdBnhxaorrRbOZ9qMHl/WcIwGcSBwKUtMbW+sMj7brG3QhWI3IpUxlwSw8mt32gEUO4DmbtPnK4rA73X/IKQQF5w3S/F6UNNlXSJN2NwSqrkddcBfiFJoztL9jYxMFnlpn1tDafpihlX0FYegfd4W3wJja/6rywHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErNeVYilYSjbxcTGr/zlgGrdzwNM2xbqPunVehLgYsA=;
 b=mK+460aNiljwUlTj4BX34vyLj668YGR7tQHk6KZ9IndHJ38tf0p87Q/vpZz52CoajkrKZ1tMTbMO+zdTcgTHD1MaeYDWJfxTsYDRlrWkU7+Qh8zOAepxnDLMRcJH+M1xXr8ZHnv48vb3IY0dSr3dYE5feSL9yvvnyhhgviF2IG8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB10755.jpnprd01.prod.outlook.com (2603:1096:400:322::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 13:58:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fea0:9039:b0b3:968f%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 13:58:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY3LfzxAH4GWaxPkOP7/sIRCsbj64fOAEAgAAAaeA=
Date:   Tue, 25 Oct 2022 13:58:49 +0000
Message-ID: <OS0PR01MB5922D83585226D90A46DB4C186319@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdVyTzJVCnTTT1XKzXjLCETFEEeyc6PVLLtvNRcmQuxOpg@mail.gmail.com>
In-Reply-To: <CAMuHMdVyTzJVCnTTT1XKzXjLCETFEEeyc6PVLLtvNRcmQuxOpg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY1PR01MB10755:EE_
x-ms-office365-filtering-correlation-id: ffd68480-8214-47e8-eeca-08dab6910aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oG/EV/E6k6tEhOD+js0lHilRRWBj0mGi+H5MAP6Trmx7GpXguh77z9FodowAbAMqsc8Jygib2LhGiUYNlvLcrEMyZJIcoe+EchbLsTHCIFStu+HBesyhLLTcMuGksAxcZMKD5JjYpRRfwdWrnzM9Rues7BC/2XJUl4AZTKvghUraczc9dLwp7eLxVykMsxa1S7pU/hmgYbsT1ziNutjXANpJkSm3PXiCkg9Ua3HMZDulQhsBHnsV+hZxOlfWp07FA1oub9V6+2LzlRsBpE8g7W8iW6b7IaK8kNM0UDk0gAXJwHKxW2JKWbgByXe7glEgKNXD/lZPNIxW/SIUmHsaQE8m2laJuq2+UQGXa/BKWf6d3RxaeG+FDoHXvu7UurSTkguA+IylFTsS3fdZ6dgaigxfUV4Fht4zGiczNTZSq4mnbyEj6yFrPxEU5l9aCd2psIBHEc93CnJbqlseehwVco3AZIGfpJ6okU+FhIpUnb4GnrdtPpw5y0wsxW03RxGEOEo0uNJ733kObWaDT9nJOaACI0GKqnoHffiSF8FPq4ZdinDmM8+0G/1v7kUtwGNZyKkMHSBe/fyUJk4DMY0ywkJcpehZQr5GTrOZEaEFF1rW0c9VmRguIQt+8szt+0jBmXVFodB0G32MiLVCMLESvxb15OEnb9+8jusC5/8WjKWUQ06xuUo0vdxdsx/tfGFoe5oU2F43P/dXoNHgwSYyNI+4K5xLuItL4ZUgQ4SOroodev43tZKwmWnSPLP8KpJzA0nMZRHJdWaInIjfQsaS/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(2906002)(52536014)(4326008)(8676002)(64756008)(66446008)(86362001)(66476007)(66556008)(186003)(316002)(6916009)(54906003)(5660300002)(66946007)(76116006)(33656002)(41300700001)(6506007)(53546011)(71200400001)(55016003)(7696005)(8936002)(38100700002)(9686003)(122000001)(26005)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnVsZVl2WUdvUnNCTk16QkFPR3BDY3BDcFZCMzNSQmV0VkpvRlhYemtZSUdq?=
 =?utf-8?B?d0pJWlQvMTZZZTJoT1pXY0VFU2F2UDFKek9SY1NNTXB2aHdvM1NXSWdzT3Ft?=
 =?utf-8?B?c1pRS1Rta1VFRG03NmFzTGRwZzVjT00xQ3VYWGxNRXRMM2lOR2lXMWxmeEF5?=
 =?utf-8?B?UXpWbG5zVnBjRWxvc0N2Z1hHQ3JiOG1mTlcyL2tXUldXK1hOakxDeFlFNVgv?=
 =?utf-8?B?ZjhhN0Q2VjV0bWthTG5xZHpnb1A1ZDNNVWlmdTFoc1lncWdOQXJaQ045S29l?=
 =?utf-8?B?U2xpWE5BN0tBTEJaUjdwbzVLeWZsc1MzbFdhc0JXQkRrSW5kOEpaUnk1VlFD?=
 =?utf-8?B?SVp1ZExIR05EakNVOG1wZDZraEk5WUhRSlM4bmtJejBRRTZScmk1ZUxHVlQ4?=
 =?utf-8?B?b2VyQ2t4WmxMT3N1T09QTUhpNzdhemMwWUt0SjVNcTdEZHlnV014Z083T1hW?=
 =?utf-8?B?V2UyU1dZaUM5MS9sWkV4aVNxZG44M0gvT1hXeWFXYVk3QkNtTTcyTUowbXpP?=
 =?utf-8?B?b0ZCNzJMdVgzRkpncnlvZGE1UmxjVGVQNjlCSVBuaGw1WGdqWVY4TjhJejZG?=
 =?utf-8?B?NTM0dVJSUTEzWHhEWEQ3RGg0Wk4zZmZncVJ6Sm9ONG84NFBBZmM4TU5BRTBi?=
 =?utf-8?B?MXZNVG0vN0gxTEhIVGJVY2F1dkhwQnNuVEJ5T0tKeDV4QnViWFlsNkRJaWl0?=
 =?utf-8?B?WG95dUNSK1JpanN4cGFvNGhNZjAwRm1GNDZQSmppUnBaUG16Ymc0VGh4WkM0?=
 =?utf-8?B?ZzQzbHJwUm5yOEVlYlZnRjNQTW0vMHFiZ01CQUdZV1dhUDZlQTl0dWVnUFNh?=
 =?utf-8?B?WjY2eGw3YlhXc2NmYjB3VWVQa2VKWGpEUG11MlErOGtReGxud0s2bnpzTFBn?=
 =?utf-8?B?YVhSeGg2UnFyMW1SdENBMTVGUGF5ZkRpcUUybVlzN1pXNnlHWUxpUEJPcml5?=
 =?utf-8?B?WEVQQ0NqUW5qRHJYV0RXcGRqaktKSG45amVUcGU1QzU0MWVyQXpjLytCM2U4?=
 =?utf-8?B?QkpPdHQ4MnluY1MzWXpocHVpMzQwNmRwb0Z5aUNjRzN6c2diVmJ6NU9rdy9v?=
 =?utf-8?B?K2dkMlI0YWcrY3BxeWZsS2hSYnRGdnFVNWxqL1BYVnl6eVdRaHdZNGpYSWMx?=
 =?utf-8?B?ME5vV0F2OG5uZThMZW1XZVp0Yk5yUzdNVlFlMlE5Y3dyUjBaTWU3WjNyeUVQ?=
 =?utf-8?B?WVBSNkRaUi8zNHE0Sk9mZEUrQUJtbGFqOXo1b1VvUFkzSk91ejBaUWRGNVlC?=
 =?utf-8?B?NFV0RlptRzRndnpvSW55T2NDRnR3ZnJUY3pkbEtmU3VnVmFRbU5vWmIySjFQ?=
 =?utf-8?B?QmxqaWNRc0swSkVINzc3TWJJTmtoZWlnOXZpdjIydCtPcW5sVm5DVDBFdU5t?=
 =?utf-8?B?RFoyZi8rcjlWV0IwT2k2NXdhU0pPaGVNUmo2Tkhid0xmeTZRcHRmNUpGelhC?=
 =?utf-8?B?T2F1YXEzeVk4c2lBdHZ2NE5lRm9yN2ZtbFlWaTM2c2lBdXBvMWJHa3NaZHBj?=
 =?utf-8?B?QnhhaGJvRFBiWHI0alNObmU5TnJPZEQ4WDNVaUlPdkp3cGtueWkwSHZaOHFY?=
 =?utf-8?B?QmE3cW9VZWZGRzhERTArMTNOQzlMUTFZZzg3S0xxL05QTm0zVXcyRTl2cUIr?=
 =?utf-8?B?NXZqL3o3aVlJZUtxQ3VQNWo2b0RpcndFTVFhNzIzWFJUeEE5RlNjSEk0L0hU?=
 =?utf-8?B?anR6NFhtQXN3ak9KVnFRRWduTllyVzIxUjl0cyt0bzRkNXk1UVMyOUd6ZXJU?=
 =?utf-8?B?S2VlNWdXMllzSDRzdHJpZjVEemQyUXpaL290dWhJY2lyaDJBYThUUDdQVVFz?=
 =?utf-8?B?V2hrVXJXdlNTa2VyUmxzRzc0NFNxbkczS2FIRGlFbzNiR2N6aGZ6VkFhdmo2?=
 =?utf-8?B?UVl5U3ZQRy9uOFQyQ2RWL3RUNzl5RnN4S2hOdS9MQ0orVFo3U2lGZytwRVhC?=
 =?utf-8?B?V21mL05Tc3M1L1VDdEpVejR4a2tOU0Jwc2JMMFVZd3FBUWJIbVdrY2l6Tnhs?=
 =?utf-8?B?UWgvMkR5dzIvSlVJUkFQN29NemlIcGZlQUpBSmx2b0dpd0ZGMWhoTU1KOStR?=
 =?utf-8?B?RnZuM1k2RUNtdFFkdTdSSXliQzJybHlHSDM4L3VJQVBxNHM5UEhiZy9hT0sz?=
 =?utf-8?B?blVxbklMR2UvaExPWVBjdzlVdTdSamlvU1d2aTRzRTB5VG1QV1NiSElkemVP?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd68480-8214-47e8-eeca-08dab6910aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 13:58:49.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1VOcJEYuO36p6iE47VuUbKS86Y+MKwykQOT+e2oxrhJ8ydK7RebkrU0miZ4hjHqoPbDGbH0qMRoh8SvTupKy4Zzay8GKsC1zoiNqPt8G2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10755
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMy80XSBtZmQ6IEFkZCBSWi9HMkwgTVRVMyBjb3VudGVyIGRyaXZlcg0KPiANCj4g
SGkgQmlqdSwNCj4gDQo+IE9uIE1vbiwgT2N0IDEwLCAyMDIyIGF0IDQ6NTMgUE0gQmlqdSBEYXMg
PGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBBZGQgUlovRzJMIE1U
VTMgY291bnRlciBkcml2ZXIuIFRoaXMgSVAgc3VwcG9ydHMgdGhlIGZvbGxvd2luZyBwaGFzZQ0K
PiA+IGNvdW50aW5nIG1vZGVzIG9uIE1UVTEgYW5kIE1UVTIgY2hhbm5lbHMNCj4gPg0KPiA+IDEp
IDE2LWJpdCBwaGFzZSBjb3VudGluZyBtb2RlcyBvbiBNVFUxIGFuZCBNVFUyIGNoYW5uZWxzLg0K
PiA+IDIpIDMyLWJpdCBwaGFzZSBjb3VudGluZyBtb2RlIGJ5IGNhc2NhZGluZyBNVFUxIGFuZCBN
VFUyLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIDMgY291bnRlcnMgYnkgY3JlYXRpbmcgMyBs
b2dpY2FsIGNoYW5uZWxzDQo+ID4gICAgICAgICBjb3VudGVyMDogMTYtYml0IHBoYXNlIGNvdW50
ZXIgb24gTVRVMSBjaGFubmVsDQo+ID4gICAgICAgICBjb3VudGVyMTogMTYtYml0IHBoYXNlIGNv
dW50ZXIgb24gTVRVMiBjaGFubmVsDQo+ID4gICAgICAgICBjb3VudGVyMjogMzItYml0IHBoYXNl
IGNvdW50ZXIgYnkgY2FzY2FkaW5nIE1UVTEgYW5kIE1UVTINCj4gPiAgICAgICAgICAgICAgICAg
ICBjaGFubmVscy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4g
LS0tIGEvZHJpdmVycy9tZmQvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvbWZkL0tjb25maWcN
Cj4gPiBAQCAtMTk4Niw2ICsxOTg2LDE0IEBAIGNvbmZpZyBNRkRfUlpfTVRVMw0KPiA+ICAgICAg
ICAgICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0
aGUNCj4gPiAgICAgICAgICAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIHJ6LW10dTMuDQo+ID4NCj4g
PiArY29uZmlnIE1GRF9SWl9NVFUzX0NOVA0KPiA+ICsgICAgICAgdHJpc3RhdGUgIlJaL0cyTCBN
VFUzIGNvdW50ZXIgZHJpdmVyIg0KPiANCj4gImRlcGVuZHMgb24gQ09VTlRFUiIsIGVsc2UgaXQg
ZmFpbHMgdG8gbGluay4NCg0KT0ssIHdpbGwgYWRkIHRoaXMgZGVwZW5kZW5jeSBpbiBjb3VudGVy
L0tjb25maWcuDQoNCkFzIHB3bS9jb3VudGVyIG1haW50YWluZXJzIGFncmVlZCB0byBtb3ZlIHRo
ZSBjb3JlIHRvIHRpbWVyIGJpbmRpbmdzLg0KYW5kIGluc3RhbnRpYXRlIGNoaWxkIGRldmljZXMg
dXNpbmcgbWZkX2FkZF9kZXZpY2UoKS4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQoNCj4gDQo+ID4gKyAg
ICAgICBkZXBlbmRzIG9uIE1GRF9SWl9NVFUzIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsgICAgICAg
aGVscA0KPiA+ICsgICAgICAgICBFbmFibGUgc3VwcG9ydCBmb3IgTVRVMyBjb3VudGVyIGRyaXZl
ciBmb3VuZCBvbiBSZW5lc2FzDQo+IFJaL0cyTCBhbGlrZQ0KPiA+ICsgICAgICAgICBTb0NzLiBU
aGlzIElQIHN1cHBvcnRzIGJvdGggMTYtYml0IGFuZCAzMi1iaXQgcGhhc2UNCj4gY291bnRpbmcg
bW9kZQ0KPiA+ICsgICAgICAgICBzdXBwb3J0Lg0KPiA+ICsNCj4gPiAgY29uZmlnIE1GRF9TVE0z
Ml9MUFRJTUVSDQo+ID4gICAgICAgICB0cmlzdGF0ZSAiU3VwcG9ydCBmb3IgU1RNMzIgTG93LVBv
d2VyIFRpbWVyIg0KPiA+ICAgICAgICAgZGVwZW5kcyBvbiAoQVJDSF9TVE0zMiAmJiBPRikgfHwg
Q09NUElMRV9URVNUDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhl
cmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tDQo+IGdlZXJ0QGxpbnV4LW02OGsub3Jn
DQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhDQo+IGhhY2tlci4gQnV0IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3INCj4gc29tZXRoaW5nIGxpa2UgdGhhdC4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
