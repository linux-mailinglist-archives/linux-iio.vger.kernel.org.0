Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B9675FABF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGXPYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXPYt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:24:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838FE5A;
        Mon, 24 Jul 2023 08:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgwwN36oW40az81RBKPMhPlPj2WSGWGfzyfZrQHVw0y+Q/JNV7kklQjnJnrs67t93dOhRtZdiPF9l92qq/zPOiZ+dz0TlMGWy51+oeBGDSUsRijzncXOHE62zeZZUrMgXa5Bav0IH1fKZaUA3PBfRhofiMjfpZbRNQYguuta/ui4YtNjBm4Dh1G9za3uUKmzHinSauHLUrJfXCtUzUfvW+BW/BQfjdr7pRTiu5kzHVNSdh8bC4QCB/2Vay1SbaQ00L116tzEZXzVt+RJWu12EdiG5bWVWs1CHL/lQjbzMEkBR+Y7TaFuhHHioSOCebcrC0uav0QwWsD8MX68ljwX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S57/JsXQrZPIeKKxnKRLkIm7j2nCCmptXI8f+UbCPf0=;
 b=d1PuEwh5kP8qQgE49Lj1wk7sEDZJn3+uPMEuDiQmGJWLNRgBhXU6HonEppK7faApufE2SV5z4AdYfuZIGmZovrWv9Q8O0bS3gDGbgJglwQT4kTf9CBb5Uvc+jnN1du5G7FafQ2GzKf7J0oIwI91KndXfsb1aL6gNTu1xr3ZsjWCbz6ADDSKUcC2gYVYNNdiT9gB7uC3Ghj8vW0t9SMZPerNB0mruhZlni3T9EPom8nYyujXlqJPuOZubSv/q9/IyVEjNOxaYDknddQ3l+9kclKhjrGCOP8kA6QqJ9oIoN87bq+0a13WgAc7aL1eSXnOjZ5GCSYu9rJBni0ZFpKLC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S57/JsXQrZPIeKKxnKRLkIm7j2nCCmptXI8f+UbCPf0=;
 b=X4gJCZvYm8tetpBL51DUYF32A2VpzyGtwMbLOCH0Aif35ziaD0k2Hb6ZBI1H7768O3fM7/K1QoAV4pAAooSchozetxNsz0wFAXxiGANhnyp6MKws+jKfPT89EDQTK8p1y/0bLatxMnihzBIxpk/FHe9CcRExRHGvad/Mi/NYcLY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5826.jpnprd01.prod.outlook.com (2603:1096:604:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:24:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:24:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v2 1/6] dt-bindings: timer: renesas,rz-mtu3: Improve
 documentation
Thread-Topic: [PATCH v2 1/6] dt-bindings: timer: renesas,rz-mtu3: Improve
 documentation
Thread-Index: AQHZvg/6YcrnDw/8NECIsn8fM/OTTK/JB1wAgAACIRA=
Date:   Mon, 24 Jul 2023 15:24:44 +0000
Message-ID: <OS0PR01MB59223CE43CBB9C2FA2BF4DAD8602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com>
 <20230724091927.123847-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdU1MpE+m+=pBxMQifmScYHd+Z5RkjGXkbZB+peLLQNUcg@mail.gmail.com>
In-Reply-To: <CAMuHMdU1MpE+m+=pBxMQifmScYHd+Z5RkjGXkbZB+peLLQNUcg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5826:EE_
x-ms-office365-filtering-correlation-id: b3ee4b8a-0363-4469-1790-08db8c5a1c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quIvI4xt6fS7WBXz+Isi0lFDCLVkS8QyTSSL61tdM6YsVgyeh7x3WxSzVoZxmARAjw2vNjlm1CLcgjIu0sFm38pQE1wk7WJ2TDrP9RQ49yoUN+Lzdfkkd2dBu7W2n4qh1IJQjx/kxiI6e2gFGzGz2OMNEeQMVug9xT5AAXuGOtgjnuWXwGGbdX0Vh4DuDBebNdy4/PzSOrDKhJEKr/kYON6rjFkft38oBGRFfSXZaL8Y9UiySU2kYRRUilRXe7jodFD1Xek53j5lxN/mzswos/FntsAmRWTOomYnqKRu5tx2kCiiR7aAGwy6/vQrq8r3+gBBDdYXCUtatGoB8amPlI/DMCXdVvWJ7mT3h4211v/vCaJOII2RtyXk1cd/XHRDTlABbtiIZowSeQI1r390qvfjlkv8svJhGwppEUEG46VwqszhwMzWUROccBPbdWBs3hWVGqusz0fkUT5owrWmTFugzplBZiS99P8COe16Qtb2yoK1USOvq3Rp2eWWDNMkM3PJJG3iMkf6o8CfObZhdOWV60onWpuDnYGgWz6qoD/EvbUlsEQqrE9PGEl3dJAxJiYKVZQwbh3u3K3/cBmlmuu0+iv3woaUKfNTZg8YrOIlfVCM+FDUrrYjzE6VJBxC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(55016003)(7696005)(71200400001)(9686003)(478600001)(122000001)(86362001)(53546011)(6506007)(33656002)(5660300002)(52536014)(38070700005)(7416002)(41300700001)(8936002)(8676002)(4326008)(316002)(2906002)(38100700002)(54906003)(76116006)(66946007)(6916009)(64756008)(66446008)(66476007)(66556008)(4744005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpzMjFrSEo3VW5sYk9ReXRuZUpFQmZLYWd3bEZaOHFzM3phWllsbEdGR3pa?=
 =?utf-8?B?UDQvS2swWG1ueUZPQm1YeXZoOWZ4ZjBUNjE0enkydDdsbEN3Rk5KL09JenYy?=
 =?utf-8?B?M0lQOSs2VnJwUFZaYTNyS0lCRzNkeXFFcVFyRlhjc1NNZS80SlZ5cC9QSmV6?=
 =?utf-8?B?ZlBkbnM1ZDBERnVjYm1PODl0UWlZTkdHUWFWMmlyR1hSQ0pESXNPTjJXNkFX?=
 =?utf-8?B?V3RvbVJ2eGEvRkhFVHRtN0MyTE5HWmFJZGZtODVMSXRzNUpxSlFJTHBSbGs5?=
 =?utf-8?B?eXNtcE5uYzZaQ0xZZFVlZ0lzdm1YemNYSmdFT0E0WG1HTzlmTFJJSkZUNnU4?=
 =?utf-8?B?MlFVMC9QWHV3dFo5OTMzMytjdVIwanpqQUNXNEMxUm1qVjZPaFptNHFoZjl1?=
 =?utf-8?B?OVc1N0E2K3llYWdEazZNbG9oVXZ1TEZGOUd2UkhZcEZicU1Ham9FMS9ZbWM1?=
 =?utf-8?B?YXRpQmVEYUF0bEFJbStyanY4Q2JsUWEvTkpPd3dOZDdoU2ovemtPcmcyL04y?=
 =?utf-8?B?NTBGNy90M1pjWjJEWU51MW9YWnRncG1rNUR5ajNrSTlQblNsTXQ5SVVydDNG?=
 =?utf-8?B?cldsOWs2N3VGN2ZaeUg1OGRtLzFMUWw3S0NMSkVNZ0JPMTR2VDVPdXlOTjNE?=
 =?utf-8?B?QnEzbXVYLzB5TVN2bWFkYkMxSzZYeE1kditHRlVYTnVKd0FIMWJic002Zm9w?=
 =?utf-8?B?OUt1bW5MWEx6YkVyV3gyQnJvampQV3V5TXh1dXB4em5kSzk2K3VaU3B0cTJj?=
 =?utf-8?B?dFJGWWhNbUkyRWI5enJjcS9Obzc2S3R3WTVoT0dkK0lPRXpGY1hzcXpZZ2ZV?=
 =?utf-8?B?UHZ6WERZZXA4TDcrdGpNdDRadWFmQ0pOd3d1VnF2cFBXT29PTHl0d294dHI4?=
 =?utf-8?B?Nm12ZUpoNFFGeU9lOE9Td1BzM1BlZ0FZMmhPR1BLVG5EdCt0UGZBMXljWVlI?=
 =?utf-8?B?NVl1aElSbDh3WEFFU0d0YnQ2eXlnWi9EWUwrbm81d3NZaWpZRWFwY1lIUXd5?=
 =?utf-8?B?MnZBNmhIdjIwWStwM2RHVEkydFJtcWJMd3dtNHoyeHRGRTFUcW5XL3NvWnk4?=
 =?utf-8?B?ckhydEo0RTh2TEJPQ2ovRzZMR3hadDhuQWxtbUFiT0lxeW9TZzcwOXl5YXdB?=
 =?utf-8?B?c0h1b1hVS0ZNZHMyQUF6UkZOQWxiRkR1YUd4MGlTQkNXRDZtTitpNlJQSWx2?=
 =?utf-8?B?aVRaQS9lYXpyMmZxQVF1bWFrMWVUS3RVTWxyMzNDQ2cyZElhQnh6UEE5M2VY?=
 =?utf-8?B?UkZGa3VwTE41OURCb2crSzVQSGxnckZVUysweUJSckNkSGhLMERkRkRNZHNa?=
 =?utf-8?B?aThjNUxIUm01L0Z5WW53Qll2RmlBRWpHRXk1WlNIU3hsQ1dnMlZYdkx4RS9T?=
 =?utf-8?B?YkQvU3pULzNRcTJyNVFUeWFQaERmb1dLVnhaK1hwcVlheVZDdDdqQkpzaTNs?=
 =?utf-8?B?UWtGSlpaNEZBNHBlRUV2ZllEOTVlcVYwT2JGYXhOUzdRQzNMaGtNOS9xc3Yv?=
 =?utf-8?B?MjAyNnZkeFo2QW9hTzFQL1RwYmxvOU0vKys1bFpYSHFpelB1WjlRcnFZZ1Jy?=
 =?utf-8?B?SHRneEVLdE5YdmxEYnlxMXBJbzJSUWdCdXpwbm91R3krVktJOVRDc2pnalpY?=
 =?utf-8?B?WXpZdGpsV1c4cU9wckpzalhHTWFWUmFGNTJ0VXRKWmJmTUxWUlVzb0x2d0xy?=
 =?utf-8?B?OXNaNFpLVGE5R3JxaHNtZVA5WVFKTzkxb2ZtYzFRVnJkVUFFZGhjN285YzY5?=
 =?utf-8?B?WmpZaCtxcGZoekVud2swN1NzTTZCSENxZ0J5Tk4vTVBOZ0tuU01XeDMxRWZB?=
 =?utf-8?B?TTVJZTVYa3I3K2xlT3ZYeVc3bGxrTGNsSDF2ejNoeFpnakN3N1RrcGY1RTZW?=
 =?utf-8?B?amZyZHYzY3F6c2hSZlVoOUt5dEdtOFdqVVhLT296dVhveXdFTXUvdjBrd3ZH?=
 =?utf-8?B?dTZnZGVZVEZjUndCSE5kWnF3dkJEUG42VzhmK0NESkFVdjcydG8xeU5oT3Zn?=
 =?utf-8?B?d3ZDZUc1RnBOMUV5MjBzV0ttTHZmcUtZdWppbStBRzZTWGtId2tRUmdlMzJm?=
 =?utf-8?B?WldEK0RkUlFwMkNreE9FaVhXNldFWnVNeGJKQXhRZGdCNjVtQWZSZTFZZ0FZ?=
 =?utf-8?Q?1qDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee4b8a-0363-4469-1790-08db8c5a1c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:24:44.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8C5bYYP/4CMZOEq8+TIMoGrbmNWxLHJprpZLuaWL5dJfoEpYRPUeYdfwuxyMaXeZEGP860jm10RAhwVInwCAxfYLNNTQpLXprk2DXoggYQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5826
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS82XSBkdC1iaW5kaW5nczogdGltZXI6IHJlbmVzYXMscnotbXR1MzogSW1wcm92
ZQ0KPiBkb2N1bWVudGF0aW9uDQo+IA0KPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAxMToxOeKA
r0FNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4g
Rml4IHRoZSBkb2N1bWVudGF0aW9uIGlzc3VlcyBwb2ludGVkIGJ5IFBhdmVsIHdoaWxlIGJhY2tw
b3J0aW5nIGl0IHRvDQo+ID4gNi4xLnktY2lwLg0KPiA+ICAtIFJlcGxhY2UgJzMyLSBiaXQnLT4n
MzItYml0Jw0KPiA+ICAtIENvbnNpc3RlbnRseSByZW1vdmUgJy4nIGF0IHRoZSBlbmQgb2YgbGlu
ZSBmb3IgdGhlIHNwZWNpZmljYXRpb25zDQo+ID4gIC0gUmVwbGFjZSAnICAgICAgICAgIChleGNs
dWRpbmcgTVRVOCknLT4gJyhleGNsdWRpbmcgTVRVOCknDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTog
UGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiA+IENsb3NlczoNCj4gDQo+IFdyb25nIGxp
bmsuDQoNCk9LLCB3aWxsIHVzZSB0aGUgbGluayB0byBsb3JlLg0KDQpDaGVlcnMsDQpCaWp1DQoN
Cj4gICAgIENsb3NlczoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IEFja2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVu
IC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4g
bTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwg
cGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBCdXQgd2hlbiBJJ20gdGFsa2luZyB0
byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcNCj4gbGlr
ZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZh
bGRzDQo=
