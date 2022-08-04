Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7728589592
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiHDBFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 21:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHDBFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 21:05:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915C12602;
        Wed,  3 Aug 2022 18:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XolBnuyzg7L1zXqdkjaAb1Rbmpv8+eVPNGvlJIeMQ6fn3PooEfKA/BD6ZvBy7HBUjbftMAUOxRWzTSvCDG2xjW3jZc5mawqivoEncPQWoVeSS28J07sfi5N9gHwp7MRblLIStnII8aZAb/Ti0ZvQs7DbDG+ipnBmjbwpptX45znV2i1f4FjJ2ziCDQHQOOVF3sgFQCO6TmFcwSmmGDkcgzYtYLd/XrsPB9efihydlhw3slwiIj4fuHibtOjLvjA56EfIlxsJYnLDxdX37vuvlfd2WKzxdBPminhzpbwVyXaKbzwKYYYVcsgQVv6+qUphKAzJIa21fu2b+xWkOVdJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5eIPfMu/UKvsM6QFiW4Uz/J2mxBKudtIjvadF4L9B4=;
 b=I6K9eQSh2OqrF6Lty6v5v9pm1kc6OkfbwwHqP6pgZutcO7Qev1HtoP1jgv3SzH8BtAvRMBWBH04Vt5GFWJhbj8XNbacCN//tgBydsogPf2+KShqf6lPabJ1LGaj0kFOOh5WXewnjJVvo7q7wxYyUpZ8/qge1g+obzts9g1+4iPTHVPYCYUKhQAiHF/2SRvBpkmgsoO+B2PSfT7Dj/mIvKmLHuTMwf/+UVI4EuWXwhfoh9Hm7wDH7bjxUpcz3lZe/x4m4J6/uOtQPEztvc+kVxLPOqap0dEOnRUQti4Cvng2qrYKSsk6DqWUGiDB7WY4tWp3GM+7J8+/4LQspB0ZNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5eIPfMu/UKvsM6QFiW4Uz/J2mxBKudtIjvadF4L9B4=;
 b=ePtUCm6TbkCPz3xzSOwbiCQm+xgnuHOqZqcQX1P5xRsRq154i75FalNgR7QPcGwWbbL4LjEJkTPL/EdESglzy2vWPtuT5y+4fNo+QZeaxiK5FULXqm8bO0a48EfGhLcvLMrf/daUAgNB20zG0SiK7Z4bgbbg7VZxcP78RNTck6I=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM0PR04MB5217.eurprd04.prod.outlook.com (2603:10a6:208:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 01:05:41 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871%7]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 01:05:41 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Thread-Topic: [PATCH 2/3] dt-bindings: iio: adc: Add binding documentation for
 NXP IMX93 ADC
Thread-Index: AQHYpxt9KWDqyJ673EyktV6rN9jRtK2c9voAgAD2stA=
Date:   Thu, 4 Aug 2022 01:05:41 +0000
Message-ID: <VI1PR04MB4016C146F9C8EF90557B362F909F9@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
 <1659517947-11207-2-git-send-email-haibo.chen@nxp.com>
 <8afe7812-7dbd-7257-2a55-b4ae49f47381@linaro.org>
In-Reply-To: <8afe7812-7dbd-7257-2a55-b4ae49f47381@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fce8d1f1-e208-42d6-7cda-08da75b57392
x-ms-traffictypediagnostic: AM0PR04MB5217:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RprA2VY4qTOHi3PcrPDPiQaef19fvz8xRP8+96DYiAmbsB/+jAsgMQG3aEsZEUJ0miu9WyviCeSMNzWp5SbHExhqBCM4PRZtMz+xHBWjTE4VrCOC4mggCdbcqon3BvvSxmYEuKrQ+0cc9VmeV8tTRBjPyzn6zVryrDmWdpnY0j9VvrdHAKZUbaKj3Pssgdja7xVCbjbVkBqIS+/DrpxwUu7y+3qA6pdnf6XH2d7vCO5UTS1na9m9N2XBjqhKNzxhRx1NKiHMDIfnZ9V6hAXCUbuWIiEvbxOGY2yYzgwb3KkIGz4bBqYW+tm/q9CEu8/KuaVqefp2mBxHifPQJjivIgRaVnBvsJzQ+X9GzIFGLzI7WumrSjgSbZ+kLY4f1TUpJ4RAJZjkX1zDDABO0PZBii3C7YjRFMavWNN/mnyHIHxWaa5U9JVOk5ysKXVEIpTykfK7NHuIzjQqJKLkRtwAy8MSWEQWXM0IMR0DjWfRxKHCkTQgwCPL+21KOxSRCMQJGx6HGPiSGCnJVFnyx5sS7yJoWMWplXWAhYYUystmzSmTgJf6Tmag3Hpg8wvIzM+yT1TRH9Ql7mO+ot0e3+bni4ugHMNRXqC9jRQtoCHrqbuE6HdvEzO/LS3YuX4R2AA2YWGDkCxNIW6GhFVLSsMMZaOQ2hPTaaeFwyuMQuOyz5s93P5mJV/kALYAs4R/OqOnBeSOlXTBmmuKXUQlst67gFxzjJJSkk/KGiYNTdLtNMXlSp2imxv9pfkpjPEMwvJsjKijfCZF8qRL6xkBGdV9x/0/51mbdMNuHS7X2ScctW5KF+MKrwk2/o9Ipgk/KgmbyYIiYJa4+EZKZ3CX1N0AWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(9686003)(7416002)(5660300002)(26005)(186003)(66476007)(76116006)(66556008)(54906003)(110136005)(66946007)(66446008)(64756008)(4326008)(41300700001)(316002)(86362001)(33656002)(55016003)(8676002)(52536014)(6506007)(7696005)(478600001)(53546011)(8936002)(122000001)(38100700002)(38070700005)(83380400001)(45080400002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ODk1dmpMcDJrWVpRem9aWFlBWG5STE55a1FvU0pKNUJSL2NZSTlMR01yNHdP?=
 =?gb2312?B?aTZVQWN1UGxkaXB6N2dhb25zamZHQ0tCZXJkZ2xWckxtaGZLTFA1T3kyNmV2?=
 =?gb2312?B?V0x4UVVNR1BJWEE3NGhGU01mVXVLUnQ4VTVaK0p6ZGlmWkpncTVWSDRsTXBy?=
 =?gb2312?B?azhEZXZsUFdtYndqTzBhL2FiWXN6c3hqaU9jOVE5Q0dRNnNvazlsMjRaTldN?=
 =?gb2312?B?U0F6dkVYamIxVGFaZWpJMGtFSUJ3S0VxbHNOVHZhdkNWM3czbTlFclJOcGkx?=
 =?gb2312?B?NEdINTZFcWlXekMwYVg3dFJ5WXdxYTgrSXFtTWk3R0xMR09iejlQTTlvTzdP?=
 =?gb2312?B?Zm9tMWdka1NvbGJMeWFPbFdrZjV6NnZ5eG82dzV4STZXUHFlMysxeUNJV1Y4?=
 =?gb2312?B?alFpVGRjUlBDWFc3TGgxRlpVdlFlZW5oMktnSHVsdzNGZldLc3IveGd0MWtU?=
 =?gb2312?B?T3BSWHAvYTZhRExOMkx2ZHNPeDFJVzlkQWpIczNFazlNejhRcnY4OWNsRFJ2?=
 =?gb2312?B?MldLYXVuQ0pVaDF4MmxGKy9mY1ZTR1NVbzZvNzdyZFFqMVg4N3hWQk5BQlp5?=
 =?gb2312?B?UW1TNU1hY3dQWUUxeEc1ZzlPS3EyVVBKVWVjOWoyWHVGa3o0NUdzaXl1MGVF?=
 =?gb2312?B?ZnduaGZYNCtOVWNSR2ZWaSs0SkRsb09nL2N5blBpZ01BbGFkZzdmSW5UeXlS?=
 =?gb2312?B?L2FLMUxINFl2bDE5emptR2VpejNrS0lpaFd6UVQvT2ovdkxpTS9OMjNvcW1K?=
 =?gb2312?B?ZUZhdmtWYXBLVVlsaHZLY0dteThRRDlneFF2WVhUS01yeGNmTlVXQisvL0lr?=
 =?gb2312?B?Z2Y3S2l3cGtzcjRVM2p5QTlhRGJXeHh4dDJRYzhFMkRQbkJ5dEY2OGRnMVU5?=
 =?gb2312?B?cURIaklEaXYrRy9ZZys4Z2ttckhQWkhLMmFVV1lGWnBwWnMrZ05KTDFIUmQw?=
 =?gb2312?B?bVhmc3JkaDZkU0JVMzgrTDkxL0dzUGM0YzYrTzNsQjMvWlRRZTB4YkpBNDQy?=
 =?gb2312?B?RXNYc2tsaVIyb20vV2JwODdQTmFwMHA4WU9HanJ3VkJuNjBkVnh2bXh5cUhX?=
 =?gb2312?B?NzF5NTR1cFUyTE1oalZJN0d3Q1ZFcVh3SVMxQVRoZE1wNUpRMmpHUGhWQ0tY?=
 =?gb2312?B?RTZBdExobHFzNTE4QWRXT1RTcndTaUE4b3czU3VoeUR3Y2srUnE0RlNxRmdh?=
 =?gb2312?B?V2NxVy9QVFVPTkJHd0RMeXpmd1Z5V1gySGticWN4MGE4eFkyZ05qcGNhYkRh?=
 =?gb2312?B?dS81UEVESk1LZnptdXhtNERJQVY1a3llMjQveWQwL0tIYWI3UGROK21xS2tr?=
 =?gb2312?B?RWhKaDFmd0FSb2RZRlBzbk1EVFNzcGpIYkpXRG0rbWRuVVkwdS9QVG01RkE1?=
 =?gb2312?B?QUo4aGtnU1UzVDFjazhHZmFGL3VDbEh4ZFAzWEdzeCtLTEtFSzVoL3V1VHZz?=
 =?gb2312?B?N0NhMDU1QmJiMGRqakRPL1FMSWt4SitrYnJEZktmZWt4UlVlVlUxTWtuTkwx?=
 =?gb2312?B?RzRMeDA2OTZWeFdJM2ZLZEh5YUpYTWxtTHFQUlBYQkQ5M2UraUJQZWc2WmFm?=
 =?gb2312?B?QTM3SEw1VGlDYWhtUDRHZUU4aW9XbklYOE91QUhqQUp2WVhLN1UrNS80Zk9C?=
 =?gb2312?B?S1Bwd3FScFpmYnM5WHVteHc2Qm1jUjhnVVBzd09UWU1xSjJzbHFLYU5VajlB?=
 =?gb2312?B?eFNiZXE2SEdLcUJmTUEvZlNlZDNkaUY3b1RvM2RLUThTNEdCOW1nWVJFMEJx?=
 =?gb2312?B?Q1RuL2J2ZitZdTd0NEFDTnRDMTVvRHdabWtUR3V6YXZEMDNRakRYQm1WVnVV?=
 =?gb2312?B?ZmUrR3VSTjJiVXJ1YzVCZFM0S3RiNzJUZWVWMXFnWWQ3ODgxSEwrdnZSTkZs?=
 =?gb2312?B?VnNJN2g4MDNQL2FSc3YyTFJsLzFkWUQvU2NBcUhxc1N2SytiS1ZCT2lxSTBh?=
 =?gb2312?B?MUMrRGc5UkY0bWtIdS8vc0RRMlJ4RWNDK1VFMXFsUE10OFdVTndQOVltaExh?=
 =?gb2312?B?NUVWYVU3dUM2UzVnOWdvdkNvaThxbngzY3hORkttT1AyNmYvUmlsK2V2bi9E?=
 =?gb2312?B?TnZHL3liUGJIWklET0tWdDBFbjM2WlQ4K3lyamRuK1ZtZVlqcEl2VjhWaEtP?=
 =?gb2312?Q?74RIk1KDSAMKR1uS5ertDrfRd?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce8d1f1-e208-42d6-7cda-08da75b57392
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 01:05:41.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fe2S86q/EwjfUNOIfvUBi8hPEyl/rmZIBEV28u6jSTXvNWq71aydB9IpPWCZf1EW4QQgvNf68r0VoeReAh8LMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5217
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLE6jjUwjPI1SAx
ODoyMA0KPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgamljMjNAa2VybmVs
Lm9yZzsgbGFyc0BtZXRhZm9vLmRlOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gZHQtYmluZGluZ3M6IGlpbzogYWRjOiBBZGQgYmluZGluZyBkb2N1bWVudGF0
aW9uIGZvcg0KPiBOWFAgSU1YOTMgQURDDQo+IA0KPiBPbiAwMy8wOC8yMDIyIDExOjEyLCBoYWli
by5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KPiA+DQo+ID4gVGhlIElNWDkzIFNvQyBoYXMgYSBuZXcgQURDIElQLCBzbyBhZGQg
YmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBOWFANCj4gPiBJTVg5MyBBREMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIC4uLi9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg5My1hZGMueWFtbCAgICAgICB8IDY1DQo+
ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14
OTMtYWRjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
YWRjL254cCxpbXg5My1hZGMueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5lMGVhYzVhYTgxZDcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFk
Yy55YW1sDQo+ID4gQEAgLTAsMCArMSw2NSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiAr
JGlkOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRnNjaGVtYXMlMkZp
aW8lMkZhZGMlMkZueHAlMkNpbXg5My1hZGMueWFtbCUyMyZhbXA7ZA0KPiBhdGE9MA0KPiA+DQo+
ICs1JTdDMDElN0NoYWliby5jaGVuJTQwbnhwLmNvbSU3Q2ExMWNkMTI4Zjg4MTQ5Mjk2ODRiMDhk
YTc1MzliDQo+IGRiYyU3QzY4DQo+ID4NCj4gKzZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM3OTUxMTg4MTAxNDkxNjY5JQ0KPiA3Q1Vua25vd24NCj4gPg0KPiArJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYQ0KPiBXd2lMQw0KPiA+DQo+ICtKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtz
ZGF0YT1KRk5yNHRlbGI0QW92RTYyWWFIUXUNCj4gS05yMXl3TCUyDQo+ID4gK0JsYzBkSk1GTk4x
T0ExVSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ICskc2NoZW1hOg0KPiA+ICtodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkN
Cj4gPg0KPiArY2V0cmVlLm9yZyUyRm1ldGEtc2NoZW1hcyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0
YT0wNSU3QzAxJTdDaGFpYg0KPiBvLmNoZQ0KPiA+DQo+ICtuJTQwbnhwLmNvbSU3Q2ExMWNkMTI4
Zjg4MTQ5Mjk2ODRiMDhkYTc1MzliZGJjJTdDNjg2ZWExZDNiYzINCj4gYjRjNmZhOTJjDQo+ID4N
Cj4gK2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3OTUxMTg4MTAxNDkxNjY5JTdDVW5rbm93biU3
Q1RXRg0KPiBwYkdac2IzZDhleUoNCj4gPg0KPiArV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJQ0KPiA3QzMwMA0KPiA+DQo+ICsw
JTdDJTdDJTdDJmFtcDtzZGF0YT1BMVBQbFNrT3NTN25XRk9QQW9reUExRjglMkJZRlNaajVkWSUy
Rk8NCj4gYmxtMFU0VUElDQo+ID4gKzNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gKw0KPiA+ICt0aXRs
ZTogTlhQIEFEQyBmb3VuZCBvbiB0aGUgaW14OTMgU29DDQo+IA0KPiBIb3cgZGlmZmVyZW50IGl0
IGlzIGZyb20gQURDIGluIGlteDhxeHA/DQoNClRoZXkgYXJlIHRvdGFsbHkgdHdvIGRpZmZlcmVu
dCBBREMgSVAsIG5vIHNpbWlsYXIgd2l0aCBlYWNoIG90aGVyLg0KDQo+IA0KPiA+ICsNCj4gPiAr
bWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25z
dDogbnhwLGlteDkzLWFkYw0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gDQo+
IFlvdSBuZWVkIHRvIGRlc2NyaWJlIGl0ZW1zLg0KDQpXaWxsIGFkZC4NCg0KPiANCj4gPiArDQo+
ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2st
bmFtZXM6DQo+ID4gKyAgICBjb25zdDogaXBnDQo+IA0KPiBObyBuZWVkIGZvciBjbG9jay1uYW1l
cyBpbiBzdWNoIGNhc2UuDQoNCk9rYXkNCg0KPiANCj4gPiArDQo+ID4gKyAgdnJlZi1zdXBwbHk6
IHRydWUNCj4gDQo+IE1pc3NpbmcgZGVzY3JpcHRpb24uDQoNCldpbGwgYWRkDQoNCj4gDQo+ID4g
Kw0KPiA+ICsgICIjaW8tY2hhbm5lbC1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsN
Cj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiAr
ICAtIGludGVycnVwdHMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4g
PiArICAtIHZyZWYtc3VwcGx5DQo+ID4gKyAgLSAiI2lvLWNoYW5uZWwtY2VsbHMiDQo+ID4gKw0K
PiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0K
PiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2lycS5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2lteDkz
LWNsb2NrLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgc29jIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArICAgICAg
ICBhZGNANDQ1MzAwMDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxpbXg5
My1hZGMiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MHg0NDUzMDAwMCAweDEwMDAwPjsNCj4g
PiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIxNyBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDIxOCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDIx
OSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIDxH
SUNfU1BJIDI2OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArICAgICAgICAgICAgY2xvY2tz
ID0gPCZjbGsgSU1YOTNfQ0xLX0FEQzFfR0FURT47DQo+ID4gKyAgICAgICAgICAgIGNsb2NrLW5h
bWVzID0gImlwZyI7DQo+ID4gKyAgICAgICAgICAgIHZyZWYtc3VwcGx5ID0gPCZyZWdfdnJlZl8x
djg+Ow0KPiA+ICsgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiANCj4gTm8gc3Rh
dHVzIGluIHRoZSBleGFtcGxlLg0KDQpPa2F5Lg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4N
Cj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
