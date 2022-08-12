Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A9D5910A6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiHLMQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiHLMQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 08:16:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FB979C5;
        Fri, 12 Aug 2022 05:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6wWONf5F3frePLZZPw10bzoDkP7mWkYcQn4xTKvYGrD8sR4xH6R8OnlkJIrv0El7v26kDr7YHaWWMuZODak0NX2JW1hDSMN+ZIg46nQfOizxn/p6iRZyqSS7q1DOHjsEP5uAy15tt02aWosfbvPWCrWal28MQyxujmuUNnk2qeQmcR+lgLXJqW3vQ+8b/dAS646v5SBqaNSycWW3oqLRG2vrKz25kSH2gJDdvB6PJizDJkxTTj4MVy3DXldTb8KYjvF73WE0DksXr1CB46FeXjNVLuMjbJwEQ8h0FZmD4oMXQMU+mEijwwtSpGGyLLrmIAtkBVSzLkKX0wTGNLvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4hNuLVz1yuHh16u7VGWVDm7dvhhksKEL76e1OiDkmE=;
 b=HlFFAZ095gXfed+mtWQ8EUFeD/ln4y6n6HaaWgrkHebXocmtNv/wSHR0TWUVm7SJ6D70cFqmi/MbGEs6TO5eLJwksTTtfggT3bzzuIwCzEQ8vRzpoUtFSMbE1PxjaJpr5e1ArcN+jJXvcvc+kEFY3A2jkCici1vp9Ry82q/q1ppSm4kqnGOyd62+3x4+kqET2vLiHHLiro5n1YgNXKHJ6Q7nYOqxweUjz3yDtyvsPcG4kLn40kO+xopM+SDD3fSeEwecBOnaW/L1ydkG70n42RskcxvvjM0XMFFU2heNduLGg/tsl/T0Iuf1PFJ5C/obCOuRrY0UwuNGY0NJVKsFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4hNuLVz1yuHh16u7VGWVDm7dvhhksKEL76e1OiDkmE=;
 b=qtKMeel9c7vSRzbbslnt88uC+IZ49yhkuwZoNssB9d2FWNuph05Bvr/xtq9Jhe1sMazMpfsrJftiPwXu7/816f0IbsHKZiwpVhVwhmPgCxi6e9A1PA05n0fnqkmyxOl4mmND4CbyfQOCecT0vUvf5+wTa9fx1yFaO5FBCIXNxZQ=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 12:16:03 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b020:6e17:a5ef:8871%7]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 12:16:03 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: adc: add imx93 adc support
Thread-Topic: [PATCH 1/3] iio: adc: add imx93 adc support
Thread-Index: AQHYpxt8yI8fkFGGv0SarAxSnuMWwq2iDa2AgAkop/A=
Date:   Fri, 12 Aug 2022 12:16:03 +0000
Message-ID: <VI1PR04MB4016391B2B65023A5ABAF30E90679@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
 <20220806170237.1c664675@jic23-huawei>
In-Reply-To: <20220806170237.1c664675@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7332ccc5-06fb-4eaf-0c46-08da7c5c6cf0
x-ms-traffictypediagnostic: AM0PR04MB6964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiwVAslB4oiL8GYAR//1xCQ5OCOofOnQnUyonrOhePXmXCMQAZf9lAFnxIdmu+Qr+qCm2Sls0HyBqIFzb93a43+X3Ug4EEhrkGq1Ar3IUyg6Tb/LjBOb9b9uvJ6WOEoJtO4OQSQEhoVPQ0aDylP0acU28OwooJbg3xqnsOfnxszKUbUMAFXHDPpP5YSgdNF1AbCqCKVxA4XcsuKbnKjUiGTHOH8GI/c9NqPffr+LyVB74+CtnitW8NOliH/AgGOhKCbjT3RiTLeL/o7KlyqB5/n/hzzGNjB/dZ5wv6tUI1WPU3CzOycxyvcoB4p1mYH1Nt4NPG2FQ70OKCN++c6h/KV6rJN+m7oeGl23WhTi2YUYOCK88CSfAqlUxAL3jdL/DYE5Nmwi8CA6LY/0r0p5GwqWUvOn9X3qx7m4fXmzqZonMqrPBgThyh3DwLAZREAk/FJfcTWTckCQg9Zib/tsN79ioX8Bop1Kl2FFiwedbWltf/+/w/yPEYGOwPhrdijurxRXz6Hs1G++e1WB66h1EyJarXH1PezbrBRSZ+Y+NAizX+g+prqvio8H4HWS+LwgBXxgLm/e4+N+fm8iYEXl03H47I9j0PW17VJxKgg6a5QjIMuUSwIeYpIFBTPBOM9z03ezZsPL2nlL+tAWdmGKytJODgxSMd88r3jNrVPFhxylVS5xuu48cEmjTijVEIO35J/jlj1HCm5fJY0lNaFoklbRFzvlQTrdRXHvKtx02ZAGckrD2QUYEQ2/oVhFCkCGeG8SqUiWYQQcRL5ep+W9BAB3lljG13nQFqNB2TM1LuUxg7aCYtJC5DxpNKFnKug8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(5660300002)(41300700001)(64756008)(66556008)(4326008)(2906002)(186003)(66446008)(66946007)(76116006)(6916009)(54906003)(8676002)(55016003)(38100700002)(316002)(122000001)(26005)(9686003)(53546011)(6506007)(478600001)(8936002)(33656002)(71200400001)(7696005)(38070700005)(52536014)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SFA5TjV5b2dwRlNUMkhObERCczh2dS9hS0R1WVlaT1Q3V0xvczJ6UDNOa0xP?=
 =?gb2312?B?T0tCWURxMUdSNmRFQVQybitCd0FVbnFIcHVoMlhwUlcrTFJvN2pNYkFwaDlD?=
 =?gb2312?B?YzRoTHZGa2gzazZhckl2aGpBSkxTcXpmRStGNzh4ekdJYU5yRWxMT092YjdB?=
 =?gb2312?B?dTRnTEJHN2NzaXMrZjdQOU45RGxNWm8wTXVRVi8zZUg4c05LU2ZrZnZhNk9V?=
 =?gb2312?B?N1MwYk4rWHJRRHloVkhwUWdNTldmb3M0blZQaGZudXQ1OTMyREx0czNFcDF5?=
 =?gb2312?B?b0w3K1hMODV0dUhud2hCZ2E3OEVsTEhBV1R5cDBmZFllVWIyQUp2U2hVZnlm?=
 =?gb2312?B?SHB4L2VSR1J0bVBIVzR5UmJQU0tFNnh4RURjVXZDT2RLTE1wc1Y5UWZUeHlD?=
 =?gb2312?B?Y2paTnJkQnMxaExKdUZadXFuVjhDbC8zb2xkOUlTUEg5UjBSeG5NSURQMVJt?=
 =?gb2312?B?MnlSYmpWdTNwS1FJWEppbDVKeXlCaURPTEcvMFZ6TUUrUEE2RnFjZ3BiZldW?=
 =?gb2312?B?N2FkTC9aUkoza0RkckRMbVFxMTgybm1PWVFnNzZGUTVZU3dhOGtLR2JSaWgv?=
 =?gb2312?B?TENvaG0zVVVBL2lNTDRVK3ovL3pEc2pmd0htVURUY2o0VnhHdTVuSUV6dDYz?=
 =?gb2312?B?SngyYjU0VXFDSmgxekROZ1lPbk9IekV2TVkvSkRhQnRrVnlrTzRCTWE2T3BL?=
 =?gb2312?B?OXR0dUdNWFpUMHFzRk5RcnZ1aUgxQTlhRzAzcDE1c2d1RUNxbWxYUjBxaEZa?=
 =?gb2312?B?aEF1WWZoYUdUUm9ObnlQWTQ0RnNiZERvUzhHcWRodEVYdHRqaDhUMGdIZlJT?=
 =?gb2312?B?QW9pa2djR3QwRWxwK3hhQnNXWGlQOThSQkRZeDNId3dabys3UkhkbDNSaWVz?=
 =?gb2312?B?SWR6VUt4dWdZd0NQeG1JM1A5Qk1rcDBjSFY1WjFxSWpaazFuOW5Pc3dPSEQr?=
 =?gb2312?B?ZjVmN01tY29NVkF1Y3hEYnRSR3dMMGtKb1lCOVl1aENNRGlqT1RTVTJKVXZl?=
 =?gb2312?B?WjhNdlZkaUdKaXZVbVNpOVZGTUk2b0ZRc2c0QXVSc1lsRTRPdWFzcEMxZWU0?=
 =?gb2312?B?OXp5UVpnaG1ldnA2S0VnWEtPMTNLUkR3VWNwTHNLUlNib3luVVNEa0YrREhH?=
 =?gb2312?B?cTV5OE9XMHVkVXp2TjMvdmZTRk9Od1l3MFR0N1NXZkZydVpJaHJxRCszYUVV?=
 =?gb2312?B?OXdHMmwzcVVuOFNCTS9WckRGaGt3M3BRY3VSM0lHM282ci90WHpiMFFxZUxO?=
 =?gb2312?B?SnlEUnVxR0ZnUjh1bzUvYnFZM2dsOWkrTW9RV2ErZFYySnhRMjU0ckRQOFc4?=
 =?gb2312?B?dXMvdTcyWDJrKzYrZGptcm1QSXZNOHdtYm1UYkgxTm56bzVwYmJyYVVpMU9P?=
 =?gb2312?B?K0V1S1I1a1pTKzVSclhiZTRSSzVzMEc5eG1RNlY4Q0l3dXJWaW9sV3hVTFh4?=
 =?gb2312?B?d3dadG4zeGhFMERkN0Y4RERGRGdwb2NSdWVpK1NaOFV3SzJhSTVxbDRpYjV3?=
 =?gb2312?B?WVBJVFhHWXRoQU1LOFZ2R2pPSGhtdjBWakxWVVBxYkkzTDVPTlZMOCs5L3VJ?=
 =?gb2312?B?MWJTS1IrcWFYdkxqMnMrOU01b1RqVlFMVjdpeHlMUEFpWHBMOFhuVEZwUzk1?=
 =?gb2312?B?UXVCUWpyS3RDdGtkMDhGaFZRWk1iOFZRSlhlRlJUaDl5YWo3UzFTSHZISC9F?=
 =?gb2312?B?Ym9IY1Y0Q0lKMTV2OEQ5cGdFM3VKcTAvaEUyczBLbE15SHlIMmk5dXYvSFBx?=
 =?gb2312?B?TzdRMWVQZmp1KzEvM3JNclpTY2lzdFpRSnJlZ0hYOVorR0pSeEhTWWhHT0NG?=
 =?gb2312?B?MlNvbVJEeGU1TUpUVkNpNTVSd2hidG5sRTNHanRrVXpUeDdpMHQ3WmpocmY3?=
 =?gb2312?B?TlNXNkNNVXNLK0s0SFRlSVRibHJrMlFmRWxqUHQ5d042ZmgwaHZvWmszYmhw?=
 =?gb2312?B?c2d2dUlOY3RsVUtsM1BmZ2l0YjFoTUdiVTUrR1gwOEd3aUp0NnNxK3hCMVJ2?=
 =?gb2312?B?RThPL0FrK3k5dGVlZGNNbHNMYklKYVJXSGhqbVoyVUVMWmJYRGdKK1U0eGhi?=
 =?gb2312?B?YnVNajZQN0ZFeFZmVFZMcFVBT0xrVm4wMXVDaHJOVWFodUVsYlAvVHorSSs2?=
 =?gb2312?Q?tvd9GzHxOs7Mp1YnwL0M2UvtY?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332ccc5-06fb-4eaf-0c46-08da7c5c6cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 12:16:03.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwVJ2jV07UmO3z54X1uJXI9d3w4QfZyqiRjt8ah0MhBy0hUWHczKGWLKSxoazfVOGJOluUzqmpJ3roUZASOM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo41MI3yNUgMDowMw0KPiBUbzogQm91Z2gg
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogbGFyc0BtZXRhZm9vLmRlOyByb2JoK2R0
QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gaWlvOiBhZGM6IGFkZCBpbXg5MyBhZGMg
c3VwcG9ydA0KPiANCj4gT24gV2VkLCAgMyBBdWcgMjAyMiAxNzoxMjoyNSArMDgwMA0KPiBoYWli
by5jaGVuQG54cC5jb20gd3JvdGU6DQo+IA0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBBREMgaW4gaS5teDkzIGlzIGEgdG90YWwgbmV3IEFE
QyBJUCwgYWRkIGEgZHJpdmVyIHRvIHN1cHBvcnQgdGhpcw0KPiA+IEFEQy4NCj4gPg0KPiA+IEN1
cnJlbnRseSwgb25seSBzdXBwb3J0IG9uZSBzaG90IG5vcm1hbCBjb252ZXJzaW9uIHRyaWdnZXJl
ZCBieQ0KPiA+IHNvZnR3YXJlLiBGb3Igb3RoZXIgbW9kZSwgd2lsbCBhZGQgaW4gZnV0dXJlLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0K
PiANCj4gTmljZS4NCj4gDQo+IEEgZmV3IGNvbW1lbnRzIGlubGluZS4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEpvbmF0aGFuDQo+IA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L2lteDkzX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMDAwLi42ZTNjZjZkM2U2MjkNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jDQo+ID4gQEAgLTAs
MCArMSw0NDggQEANCj4gDQo+IC4uDQoNCi4NCi4uLg0KDQo+ID4gK3N0YXRpYyBpbnQgaW14OTNf
YWRjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKwlzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKwlz
dHJ1Y3QgaW14OTNfYWRjICphZGMgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsJc3RydWN0
IGRldmljZSAqZGV2ID0gYWRjLT5kZXY7DQo+ID4gKw0KPiA+ICsJcG1fcnVudGltZV9nZXRfc3lu
YyhkZXYpOw0KPiANCj4gSSB3b3VsZCBwcmVmZXIgdG8gc2VlICB0aGUgcnVudGltZSBwbSB0ZWFy
IGRvd24gYWxsIHVwIGhlcmUgYXMgaXQgY29ycmVzcG9uZHMNCj4gdG8gdGhlIHNldHVwIGF0IHRo
ZSBlbmQgb2YgcHJvYmUoKSBJIGRvbid0IGl0IHdpbGwgbWFrZSBhbnkgZnVuY3Rpb25hbCBkaWZm
ZXJlbmNlDQo+IGFuZCBpdCBtYWtlcyB0aGUgY29kZSBlYXNpZXIgdG8gcmVhc29uIGFib3V0IGlu
IHRlcm1zIG9mIG9yZGVyaW5nIG9mIGNhbGxzLg0KDQpIaSBKb25hdGhhbiwNCg0KSSBjYW4ndCBn
ZXQgeW91ciBwb2ludCBoZXJlLCB5b3UgbWVhbiBjYWxsIHBtX3J1bnRpbWVfZGlzYWJsZSBhbmQg
cG1fcnVudGltZV9wdXRfbm9pZGxlIGhlcmU/DQpJIGdldCBzeW5jIHRoZSBydW50aW1lIHBtIGhl
cmUsIGJlY2F1c2UgdGhlcmUgYXJlIHJlZ2lzdGVyIG9wZXJhdGlvbiBpbiBpbXg5M19hZGNfcG93
ZXJfZG93bigpLCBuZWVkIHRvIG1ha2Ugc3VyZSBjbG9jayBpcyBvbi4NCg0KQmVzdCBSZWdhcmRz
DQpIYWlibyBDaGVuDQo+IA0KPiA+ICsNCj4gPiArCWlpb19kZXZpY2VfdW5yZWdpc3RlcihpbmRp
b19kZXYpOw0KPiA+ICsJaW14OTNfYWRjX3Bvd2VyX2Rvd24oYWRjKTsNCj4gPiArCWNsa19kaXNh
YmxlX3VucHJlcGFyZShhZGMtPmlwZ19jbGspOw0KPiA+ICsJcmVndWxhdG9yX2Rpc2FibGUoYWRj
LT52cmVmKTsNCj4gPiArDQo+ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiArCXBt
X3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KDQo=
