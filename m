Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00405162E5
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiEAIoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 04:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEAIoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 04:44:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6DE2C65E;
        Sun,  1 May 2022 01:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOlGL8Xwku97jN9z1DiwmHKdle+v63s9Ag3w9PihbA4bfxRS7VbnInOI2FtgNozeAc2OCW9bUiEY9ZnSzh62t0CI3T+Z+Gfkk/1GJ+prbu4bHkIlXfXyUPw6OEq6oWy5tDrpZDQaShbm15xkx8SmQF7ZwMeyt6wVINt5ms2yl/LzY73kmFJK1d7SZ15/bke7gox6HjnCw2t0pX2xPKv3rkWoakiIyicyJkppqGQ4out7Lnft507bTq3jXqVk+3yJCWQMJ9gaunk5/ZPdBnpziowHcQXM9UlBP0MLOGguFgZjiW4Y36seS5Q4z7QDTbeHiE7dGpJetgbvVxOOAnyvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cHwk3XnvP3n+/dCGjiG6YwsZOWHgY/eqKbMzlX0sF0=;
 b=eMoP7d9tCfMUdaZUmhZey1SNXAHcBhfZmcz4bHYXuzbshPtMxNWlUO/vVLc54dkZ+IuZyW6+3RWmjEA591nBnwuknke5w9EtyMaUJ7ZBhIQLQSU7F8Gflfcim7yMWotBbNwDA4Bx2ybM2x2eLxw6M7Z5DKdRfargO+UuvYQ7P665NdZDQba7JkFY4fPd4zZ7ZB0ef01hHtF6ojz1MovMnmypjjXRSk6S1ohHol0BbaPvrpSrvniGeCQk/ErxcnuyVhwXwvehgQAHC0N1fTzzQppmzcruL/1q03S2t9/L4Jii5rXhEMc6voajcwEwkDs19o8G4WUiSOQavEA4gb9lYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cHwk3XnvP3n+/dCGjiG6YwsZOWHgY/eqKbMzlX0sF0=;
 b=AVdgye3ouDmksWgKdpEfezX9cf7/QoHK3aesuG2v6/tYf9xpXiYJuL+/QweKNgu1P0VskWl32aNB27SGFOouvP7SAgHS7zny6ghNrAdZRCLx8JhaaTccKSLSWSoIWkOLLNMTlxmxufXRWiP0MCepM/bTdUewBxpuYtw8eaqIvz4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10196.jpnprd01.prod.outlook.com (2603:1096:400:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Sun, 1 May
 2022 08:40:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Sun, 1 May 2022
 08:40:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Thread-Topic: [PATCH] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Thread-Index: AQHYXTLjzPQdKt6yXUWDNZhNR4hf060JsvkAgAAAlEA=
Date:   Sun, 1 May 2022 08:40:53 +0000
Message-ID: <OS0PR01MB59228D766976EA8063D8F0B086FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081001.21563-1-biju.das.jz@bp.renesas.com>
 <9ddec6b5-5c64-883e-5894-9a51e82cdc3d@linaro.org>
In-Reply-To: <9ddec6b5-5c64-883e-5894-9a51e82cdc3d@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae87ec9c-a7b5-45be-dc01-08da2b4e4d84
x-ms-traffictypediagnostic: TYCPR01MB10196:EE_
x-microsoft-antispam-prvs: <TYCPR01MB101966EDB59C49A2EB34431F186FE9@TYCPR01MB10196.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQ021+TQEZ9rGcfipNVm3wWPUheJQy0MX/k626V9yxO/JbYGsXbEVEBtmc2XKDy3ajrDsWuyTKq0GII3eJLnaAr4yE4GNXIPyfQQNlfZiRGjNwDc3y9cQ7mtDjfJRvMg6uObWgVLASZbKLU5r3nph2EztGPGW2pscub5KXs2zOnF9yH12ZwDIHP3VTS1ImKTl/CMfIUBt2o9n5LvnaZRcnnZXG3acfle4pJsdky3HCnmpCuQwwa0lzSFNyKOJsLwek67IIB+PSiWSEaOOKvOkmkeE5Kw4MwaK1cgZ8HYpLvgu8nUgEvGFZEbiKpMvfO7KfkDd5H0FKiBtYFGN+foWGdaFl6K930PNHTZtsmNXft9L/7sRsjTS0pIuJUdJQD2/QbLCi86l4DNBnLB2lIKtwio9/GDKlzlIxj+E88XV5tNx1oI3R91nPoENVLoBirhTqiVz/4Ddw+W/BH/A/gew4/7KzZfReTGjd55GiZFX/37IkaaMjImmdlJiQ+rxzfacE/wA7h+DMeb2timZXCOTPvIrw1l7ELVnxu3CI95PAE4QJz8XT9bprCOwL2KELVJtzXCUeRlt3AKZKItiIgY3AdDVyiaSJRlP1T7/9wtdLed4MtFsZ+s/XLaEevVDBgJO9z3H3jQOQVQGeX8XGsXb9gMJwzD53l8fYzqLh2KwemJEDG8SGnocvP5jBL8zhIWqkjoWK4DK9YwII4asgvJFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(54906003)(4326008)(8676002)(64756008)(55016003)(86362001)(53546011)(110136005)(2906002)(316002)(71200400001)(66476007)(66446008)(66556008)(52536014)(76116006)(66946007)(5660300002)(8936002)(508600001)(7696005)(6506007)(186003)(107886003)(26005)(83380400001)(9686003)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2gwVkZMS2lVR2R0NUZqdHRFckcyWXJISHlyb3FnOVZWSDJESjlsdkhPWUZZ?=
 =?utf-8?B?UEQydWFybDMwVXMyYXI2MFlJWDhPYU1vY3JCc1JWNGdqSXB4UG94eVJxQzFp?=
 =?utf-8?B?cXBhVTk4YW9nQW92cUhVOThXNXI1ZkZBWDZZRExsM2V6MDlIRUdRY1doMzhT?=
 =?utf-8?B?K3IyREJtUGxPdWpwWEppaXUvYjVZbVJkS2k4a0xNbU5MbUQ4U3M2UkhlMVk0?=
 =?utf-8?B?RGM0YkJkMEtzd0VmaFpGbjdLR2RyYit5ZStkQ2huQmRMSmFBdlNZd2JFUlEy?=
 =?utf-8?B?N3Nad3h6TDJhbmt4b21pajhSVXAzdnF4M1dMRnJZVFRWMTVCSU90SnJtUURU?=
 =?utf-8?B?cm1TM1U5bFM2cEZYVjk0RytOVEEvYlBlNWFGQnlrTnBmTkRSUGJOMEpTZUNZ?=
 =?utf-8?B?d1MvaTNxUXRjaEhTaXVYWFIvWVRyRmYwQzlJUXhscFdIRmIwWnZoZlFEb1VF?=
 =?utf-8?B?UFJWZ3hNNFFTQU1iTnBXZWlEMStYVjlBbTZBb3Bxb3F5d2xZSXc3QW5JTDBW?=
 =?utf-8?B?RmNXTkcyVlAyOXMxMVlUTmp3dzR3NXZRaGg2UDV4Wjc2bzVLamRKUFFrOXlL?=
 =?utf-8?B?cXc1cnM1enByS2JzRTNFYTZNSXc3L0dvMjh6VFdEdE5NSHpnWFlvcVZKTFVk?=
 =?utf-8?B?RnZKTFBFYjNnSy90czFEczd0UVlicER5dksrRVZuU2NPT1JCbmRvRllZakd5?=
 =?utf-8?B?cUVodEkyeFdzeWNXUjUvUU1acVNLejFNZWdaU2N5ZG5uVDBTM0tzbkw1a2ZE?=
 =?utf-8?B?cU9Wb2hxdjZUWjFRWVRsa1AwM1Z5blN6Yy9MakRDNGZ1R2JzcUgxUGEwRGVl?=
 =?utf-8?B?cXlwdmVySFVRNm1XUjhoNlEvditBU3dkNDR3SHdBRmxmNUxteDMvWjJ0NVQ4?=
 =?utf-8?B?cnExcEE1ZjJiQ2RpRjhxbWVvK0g0Qk8yTUhsakNkQk1icFY5Q1dIdkJQcXI1?=
 =?utf-8?B?UytwVjBUblYrNW5jcGM3a2Z3QU1qc3dDTTc2eC9jSUd6UnQraG9KZTIwSXVr?=
 =?utf-8?B?U1RYOHdGdmpPQS96M0dyYWxBN3Zma1lnYitZK0lobzRydTZKVFhoNUZNWEs1?=
 =?utf-8?B?U3JiOENuOEgxVTVQNzY1ODNPMG1RZldKc1ZFYWhwZndwa2x1cHV4ckNlbEtz?=
 =?utf-8?B?a2paYlpwS1RseHBHTkx1S09UUVM3T2p4V25UQnlpTkZIRDl5Y3RBcmg0YUt3?=
 =?utf-8?B?SlVGS252eEw1dGpDbHIxM2pNQVR0V3p6dHpaeXI5U2lqVFhZYUF3Z1MvWjdj?=
 =?utf-8?B?OXFxbmpRc256NWQ1Y1RMWXluY055NkUvVVF6ZnZJMWJUYUUzYy9qR1dYSUFC?=
 =?utf-8?B?L2hBUnJ0ZUVaNjJJRlN6MzNVSFQwc1MyV0VVOVZSRk54ZzczTnJ2NWN4TW5u?=
 =?utf-8?B?VHFHRFNRS09sSnI0c2hnNTlnZ1Q1ekRrWTZQdlNRRmhYS1RFSk1QKzlJdHVm?=
 =?utf-8?B?clZrMzZKMXRrdjQ5L1VWeSs3ZW1kRlQ2VmZwcWNQNnJpL25LWnJoS0ZzYW0z?=
 =?utf-8?B?cVR3QkFaZU9GRWJCcnhwOFhGQ1hFcUJuZ1hGL1BGT3JNd1hlcGUxd0hvZWRX?=
 =?utf-8?B?M1YxUDBFazNGNUIvQXZrekE0b1pTVTdReGl4bmhrYTFPVUl0ZnYvNmZzZHRR?=
 =?utf-8?B?TkdBVmdkbzJnejM4Sm5sTUY0RzJrSlp4SjhSdE91T252Rlc2NlVYSVR3UTQx?=
 =?utf-8?B?dWRYN1pkQUFZekUzZi9NQVdMU1JrVEhOOVhEK2VzZWtYYy8rc1ZRUU9ZUHcz?=
 =?utf-8?B?VnY2dGViTzFnSWl6ZGh6dUNSTTQydCsrcnBrSUpsSElXMms1NXhyV2lIK2Q1?=
 =?utf-8?B?V1RtSmhwcDVxK0lrL1JEajRjOFA2Y0hSQkJ6ZzZJT09rQmh2TWdUSUt0blRZ?=
 =?utf-8?B?MHozTVJXVzhzZmRidTNrUFJxdTMzSFVJUzQzSkx5ckNXbzBqaXNQYVBqa1B2?=
 =?utf-8?B?bXBGaEV0cktQVDhuY1RFbkpHR0psRkFBYWd5d2g4dWRhUzF6MGo4ckpYelp3?=
 =?utf-8?B?amNISTRQVDl1Vm1TNmtsdWpxU0wremFZMXZFcU9jRlJid2tONjVydUFwUWkv?=
 =?utf-8?B?RzZIWUVDY25yVUVOWm50bEVpd0ZDd2psdEJYTmQwcU5kbTdwSy9jSnZOTXNI?=
 =?utf-8?B?RzhIOXBzb3Q1UVJKSTRVTXRUV3JOd1ZINXYyS2dWNjc2OEpzZjdGMWd3VGVh?=
 =?utf-8?B?d0Z3aEdQSHZOSXRDSjJ6VDU0eGMxNHROK0owYXZqOStFMi9SU3owcG11VkNT?=
 =?utf-8?B?QXozd2FoU1Zybmp1cDUwd283SmJZZTZOQzFjNDdQK3piU2hhT3RqeWorSmFy?=
 =?utf-8?B?RWdaWndDdnJ1VmtiVDVwVlM0OERhMUJkRTg2U2ovVTY5c1c3RWxibDBvalpF?=
 =?utf-8?Q?VxyL8K15S/CDor5Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae87ec9c-a7b5-45be-dc01-08da2b4e4d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 08:40:53.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNcy+3skL0CddzCCpLWpGSxMMC5iRL7p0WCCi47dhtqwNbDq1DZNoZ+wmduV077kHFX82NdSDKaxpZRPOSrK9cNG/HtSP14U2CPxdFu9PTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBEb2N1bWVudCBSZW5l
c2FzIFJaL0cyVUwgQURDDQo+IA0KPiBPbiAwMS8wNS8yMDIyIDEwOjEwLCBCaWp1IERhcyB3cm90
ZToNCj4gPiBEb2N1bWVudCBSZW5lc2FzIFJaL0cyVUwgQURDIGJpbmRpbmdzLiBSWi9HMlVMIEFE
QyBpcyBpZGVudGljYWwgdG8NCj4gPiBSWi9HMkwgQURDIGJ1dCB3aXRoIGZld2VyIGNoYW5uZWxz
ICgyIHZzIDgpIGNvbXBhcmVkIHRvIFJaL0cyTC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jp
bmRpbmdzL2lpby9hZGMvcmVuZXNhcyxyemcybC1hZGMueWFtbCAgICB8IDE4ICsrKysrKysrKysr
Ky0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9paW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwN
Cj4gPiBpbmRleCBkNjZjMjRjYWUxZTEuLjc2N2ZiNzM0YTFiNSAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9yZW5lc2FzLHJ6ZzJsLWFk
Yy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvcmVuZXNhcyxyemcybC1hZGMueWFtbA0KPiA+IEBAIC0xNywxMSArMTcsMTUgQEAgZGVzY3Jp
cHRpb246IHwNCj4gPg0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4g
LSAgICBpdGVtczoNCj4gPiAtICAgICAgLSBlbnVtOg0KPiA+IC0gICAgICAgICAgLSByZW5lc2Fz
LHI5YTA3ZzA0NC1hZGMgICAjIFJaL0cyTA0KPiA+IC0gICAgICAgICAgLSByZW5lc2FzLHI5YTA3
ZzA1NC1hZGMgICAjIFJaL1YyTA0KPiA+IC0gICAgICAtIGNvbnN0OiByZW5lc2FzLHJ6ZzJsLWFk
Yw0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAt
IGNvbnN0OiByZW5lc2FzLHJlbmVzYXMscjlhMDdnMDQzLWFkYyAgICMgUlovRzJVTA0KPiANCj4g
SXQncyBub3QgYSBsaXN0LCBzbyBubyBpdGVtcy4NCg0KT2sgeW91IG1lYW4uIEdldCByaWQgb2Yg
SXRlbXMgYW5kIEp1c3QgdXNlIC0gY29uc3Q6IHJlbmVzYXMscmVuZXNhcyxyOWEwN2cwNDMtYWRj
ICAgIyBSWi9HMlVMDQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAg
ICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNDQtYWRj
ICAgIyBSWi9HMkwNCj4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDU0LWFkYyAg
ICMgUlovVjJMDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiByZW5lc2FzLHJ6ZzJsLWFkYw0KPiA+
DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtNzYsNyArODAsOSBA
QCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiAgICAgIHByb3BlcnRpZXM6DQo+ID4gICAgICAgIHJl
ZzoNCj4gPiAgICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+IC0gICAgICAgICAgVGhlIGNoYW5u
ZWwgbnVtYmVyLiBJdCBjYW4gaGF2ZSB1cCB0byA4IGNoYW5uZWxzIG51bWJlcmVkDQo+IGZyb20g
MCB0byA3Lg0KPiA+ICsgICAgICAgICAgVGhlIGNoYW5uZWwgbnVtYmVyLiBJdCBjYW4gaGF2ZSB1
cCB0byA4IGNoYW5uZWxzIG51bWJlcmVkDQo+IGZyb20gMCB0byA3DQo+ID4gKyAgICAgICAgICBm
b3IgUlove0cyTCxWMkx9IFNvQ3Mgb3IgMiBjaGFubmVscyBudW1iZXJlZCBmcm9tIDAgdG8gMSBm
b3INCj4gUlovRzJVTA0KPiA+ICsgICAgICAgICAgU29DLg0KPiA+ICAgICAgICAgIGl0ZW1zOg0K
PiA+ICAgICAgICAgICAgLSBtaW5pbXVtOiAwDQo+ID4gICAgICAgICAgICAgIG1heGltdW06IDcN
Cj4gDQo+IFlvdSBuZWVkIGFsbE9mOmlmOnRoZW4gcmVzdHJpY3RpbmcgdGhpcyBwZXIgdmFyaWFu
dC4NCg0KT0ssIFdpbGwgZG8uDQoNCkNoZWVycywNCkJpanUNCj4gDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0K
