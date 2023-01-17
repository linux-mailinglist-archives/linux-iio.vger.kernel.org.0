Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1AD66D944
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjAQJGG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 04:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjAQJFW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 04:05:22 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F023D87;
        Tue, 17 Jan 2023 01:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM0mFNEgXki5wrtN5eCjZaG7m+gM6ki+EGodq8uG3q3Iljz5S2BaZ5w9uBy2BfI9uAcYaVSzuwbXY7Ul6qTKDkH0c0/CiGS2HyBRuAH0R2+7EnkzE+XNtCt2npUPncmvwO1NKp4YRYcVPY1fxyj4est8phmHNmvolSedVKAqstVajBIW1PeTvzpj/Cje0VNsAVzAzc/p6sC+YDWbN/PJBxY/QnqQBEZWXkg46Wtg3An1PlJKy0OJNLB4qg3wMTQkjwzethYMOnExGsBsLwHONxc2hAzuUN8KrmlRZa4jbuJK+5mH6KItTfWP1zF5cJq/nBjr+NCQhatW/Jf5XVZnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYhdNJkqJJZyFTjx8+JIvPDh+rRbHN0PbsgCqoumpvk=;
 b=lHfgOQdBUYP64d+onTNlksSQYjwn8peqNpwZpVKgQgbXTZ4FO1PUlKzxT2L421jxvfZD9enRpN2cQLssHqf8lo20Hx71eRTeByuTI4DgrWYQzOSOL50Ui7CGI2N6aOELMrWv60pKpbA7arKB2vfof2cAavEdGjGHMflDOmE3L0r1fqtnH/jTdRk1qzaapTBbc7RtaLPp/ynGrbx4uQ+XgmqG8ZYOIqE/0SyaC/5hD87hzIOpa0TPahJcoSSDtMo0Pw/BrFt+0sNCY9kUrPq008Ps9WKe+KuzMR49IQGHJ4CTOFego1I0+sT6l9LCx5MKoQ/vBApgTwlBkR3OZCwg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYhdNJkqJJZyFTjx8+JIvPDh+rRbHN0PbsgCqoumpvk=;
 b=s2lKN4fbo7jHPoCTBNFILFPOrY+GH/37E/4t+v6Qr5Q7PRtA4GGMVdK4cj1b3oNT1ln2sqewdG0j2Np5SZFiBmNSds/eQYUY+n6xt4FG+O7qmq6OPy0rKGte8tP8r2fhJG54pMoEWI971zrq3hQxv38rlcbaXJ/pfb7ZjH4l6Fg=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 09:00:50 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 09:00:50 +0000
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
Subject: RE: [PATCH v5 0/3] add imx93 adc support
Thread-Topic: [PATCH v5 0/3] add imx93 adc support
Thread-Index: AQHZH2iRj6k+IgEHSk6WLlRdmX/9E66Uh6CAgA3PmeA=
Date:   Tue, 17 Jan 2023 09:00:50 +0000
Message-ID: <DB7PR04MB40106A96C5ABF81CA6613C8790C69@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
 <20230108131505.0a51fe46@jic23-huawei>
In-Reply-To: <20230108131505.0a51fe46@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB7798:EE_
x-ms-office365-filtering-correlation-id: 97233431-553f-4fcd-74db-08daf86954ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNkDYQoYVDbmfXN2jaU2dKpzQvo57BrEcygNInKQTu4gZwzlGC3lgk8biUaBanMdEgOaU+GYodIaUCh66CrCDEoKkjuRepH6FZ8/gC5Gt46XKJCOqC61RptK0QF6OUy4MZr4HMVY4opIdtvClx/EvWTenePeY5lvgG0uEae7AWd4TUhtWBP4ZfrYWkLDJGFTyXNHPsRbBCFBTLkrGc5HCVC3kmG2Sn82GtlCpTybVG2XwZvHQm/EBBYGsv4u6uh0NdEzr5hG5wByYB6v6abOMCvKWucJZA16Yt618De1Kc/lnBKX8Q3XflI5LiV8Z2tgy8gXdwCd+C7Mn4pL7sJepBT9N2SGw5Aoubmz7gA/JfSHhmJtzNokX+R7wU0//tSrLBOUYbUfL7lrrDCqTlTEc0zoMTjWcZ8Hv4BN9cAtFbfLQ0dm8q8txCquZ52bZnuPqI/GSl5SNuk/6MO/crW7Ez7LmY4VdUqcNHfOKY7h47pczYT1Y+hlrpJO0H+MAvMu1YcwePkwH3uzCwD2vrqz+bFCHA8OdhBMjE6jlSNmnIuXGsOFAUfXvGK/mYABYLU0xeofTXoH2AewB1EcHtDmo12PcGMEUWuGY0wtEhzNvKbFZcnzpVGrpM1qqVJRu+BflD19eR72pIo0F48+vtLBi4tN6XEppxi2KjPjda/nmmZG/UH/cWWYWy0hVQkzc3QVy0kcpV0Q/kG1/jkwkWfPWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(83380400001)(2906002)(33656002)(38100700002)(122000001)(8936002)(38070700005)(86362001)(5660300002)(55016003)(66946007)(4326008)(7416002)(6916009)(66446008)(8676002)(66476007)(66556008)(64756008)(76116006)(52536014)(41300700001)(186003)(53546011)(26005)(6506007)(9686003)(54906003)(478600001)(71200400001)(7696005)(316002)(66899015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YUdGdnNSbTdId1hiTWVzRXh5OFg4L3J0SlQwL2t0ZUVEOU9mM0N6R2I4bkh0?=
 =?gb2312?B?RzlkUng1enpqYzZxb1dNbTlYa0NLTzZNaFB6NU9BbHU1UmdXaGQ1RDBQWm9K?=
 =?gb2312?B?eTFoWk9ZMWoxNzQ0dXU3MW9CU09YZDAyU3hrT2x4ZUFRYVVCNzAveGJNb0wv?=
 =?gb2312?B?eU9Pb1hHRVNRYUV2SldNd2tZUmpWSHlzUHJwU01kZllKMmlvT1BIOCtUMXpi?=
 =?gb2312?B?aVc2Wng2MVVkQWFlWTVXU1Z5dUJhUzhwdHhUK0d0N0t5eEo1dlFuKzMwNTll?=
 =?gb2312?B?eTZWS1FzTjFmaUtCMmlScDMyWWc0d2dwNDZaU1lmUGMvVFErMmVoeHVZcjkx?=
 =?gb2312?B?MlNDNzR2NjhMTzkyNU9hYzZKTGpuQ1I0Z1ZUQVNJYWlseWpkaCtVRVl4OURU?=
 =?gb2312?B?SmM4YUVjVmkrbWUrUkx3WlozTU01UHMwN3M0aEw5eHZ4eEVBM1hEVHpXZHRV?=
 =?gb2312?B?NHhMZEU5WEtQZUQwOE9SZytSWXcyQ1FIcEI4QVBkVWl6NWxGRExzUWZ5bnhS?=
 =?gb2312?B?ejhDQXI0UlhiOWN2dzNvOHprUUNxOVI2dldUalNjeTI4Y1lBYUFCTnVYbFQ3?=
 =?gb2312?B?NSswU1J4QTBMc1IwSm94b05rdXptOUc0VUFtaDNRMEZkSXludFk1M1FwYUFy?=
 =?gb2312?B?RUFCcktKcHI3VG5ZajFOeWVoWTB4b3pQRmdjZnFkWkdKSTZXMUowaEZUbGE4?=
 =?gb2312?B?UG0yMTBOYW9KU0lMQUd1TGdQclk5WWsvRGdNTEdwaktuMVdpbEtxMkhPb0w1?=
 =?gb2312?B?RWxOZHJHM1BuUDArbDB5QndVdS85VXJIUGxEUHV3ZVExdysrUXhXN2tWcDBW?=
 =?gb2312?B?aTNySkpSdzhhYVZQdkg0Uk1lWjI4TC9VYlduZnpETy9pMUJIUVBoYUJrREYz?=
 =?gb2312?B?Um9wM1JsYmdPQSsrem1tdU0rYTBuU1RMSmxmeU43aW5FT3pmYmVtTnU4SU1X?=
 =?gb2312?B?c2RvcWpORW5VS25IRStYWXBNOTJjMEdnWVhLZ0JFYzFIeUQ0dnVnVFUzR3lq?=
 =?gb2312?B?ZEphUzZseTkrc2dac1l6L2JucWU5WTJKNTVRVGVJV3NpV3FEbHY5ODJvNVBw?=
 =?gb2312?B?NnkyV202SGxRZzZ3S2g5T3R4Nk5iV0dvdjlab2xFSDVCWnFnMUo1QW9zT2tP?=
 =?gb2312?B?N1p0cWNoaXgyWnNtVHJLL1BHdExNME12bEF3MlhYRjZZOC9lSTJnbU1ueVRX?=
 =?gb2312?B?dWtXcE9rOW9ZbHYwNVEyVXBoSHFCTFllOWxGajZvMFNTQjBQMGRIZjU3bTI4?=
 =?gb2312?B?Q2hRK2NHWm1CWGdXT2FBM25nTmlnOGhJWVJLRDE0WndwU1dDTW1FeVZVSHpx?=
 =?gb2312?B?aUlwVUR3SXQ5VTNuZWNaYXNlaHdHb0dmM2JJUUQxMkVPV1RVd0t4UlFKZ0Er?=
 =?gb2312?B?WTkyVjB2WDFiUkt5NUxrUGJ0QWtudnBtSE55MktMRzJOb1hXVlNMV0krUTZl?=
 =?gb2312?B?NlBnYk40eW5GTjZXb0pWeVNjNEhEVlNyeFlVbGZkcWpWd0FubzQ2WUJRSEpp?=
 =?gb2312?B?WmR5SkF5a2t2WG5SYmpDaktDa0V5bFY3bEs4SFpnNTNqalVHVC9Ua0FBTlZN?=
 =?gb2312?B?Y0JEN3hZR1VMNzVaZWkxemdIRUN2dDRMcHMrdEdBaGJ0cUZsVjJpQ1NPQ1R0?=
 =?gb2312?B?RUhCdU9abzFRSW1FSEhmRE1uNEl3bmhFVmk1SHVxc3o5T3pSU29LYTkveFRD?=
 =?gb2312?B?d0I4NjZMbkkrTk5UZHFtSG1qcGJ3eGFyL1ZhVCtrdXNlRzRyRWFCUFp6SHQv?=
 =?gb2312?B?aGxHU3kra2c2WDdFZUF4cXB0YUFLMDV4NWlSdFY2VGhKV1JLU29ZN1hJb2Zk?=
 =?gb2312?B?KzdxK2dpR25OTURvbGRwZE1JWlM2SExrOXUvcUZONDNGODlRR2dQWW13WnRX?=
 =?gb2312?B?OXE5Y0tBTHhMYWRIbGxJVkhRQUNRa2YvN2xERjdvditiVjNNNjlmMEIxQ1Z4?=
 =?gb2312?B?Qm5FdmhLYWtCdW5MWEhpTWtGUm5qNFhaa1pGNnZRWXdMd2tOZ1BxZjJhUjA1?=
 =?gb2312?B?djNwVHpGdFV5TEMrQno3WGlrZmprM1VLazkvRlNwZHNKb0Irc1RhZWZRSUJo?=
 =?gb2312?B?MzRFQVJ0Q1ZiNEozbGxCaWdQb2NZYWFLdnZnVWdqVitIRWZjUnUrTEpVYm14?=
 =?gb2312?Q?6J8qkN/jqFgA3zEyurIR0i8m4?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97233431-553f-4fcd-74db-08daf86954ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 09:00:50.6111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScdqR6TnShsqhYQtleptLqqt+nV+r1aM4Huug2XgFGDATxztIK8l5vlKfOeYLf64ZiASDhfZAz2fbracfRON3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOox1MI4yNUgMjE6MTUNCj4gVG86IEJvdWdo
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGxhcnNAbWV0YWZvby5kZTsgcm9iaCtk
dEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzNdIGFkZCBpbXg5MyBhZGMgc3VwcG9y
dA0KPiANCj4gT24gVHVlLCAgMyBKYW4gMjAyMyAxOTo0Mzo1NSArMDgwMA0KPiBoYWliby5jaGVu
QG54cC5jb20gd3JvdGU6DQo+IA0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT4NCj4gPg0KPiA+IFY1Og0KPiA+ICAgLUZvciBBREMgZHJpdmVyLCB1c2UgZGV2X2Vycl9w
cm9iZSgpIHRvIHJlcGxhY2UgZGV2X2VycigpIGluDQo+IGRldl9lcnJfcHJvYmUoKS4NCj4gPiAg
IC1BZGQgaW14OTNfYWRjX3Bvd2VyX2Rvd24oKSBpbiB0aGUgcHJvYmUgZXJyb3IgcGF0aC4NCj4g
PiAgIC1SZS1vcmRlciB0aGUgZnVuY3Rpb24gaW4gaW14OTNfYWRjX3JlbW92ZSgpLCBtYWtlIHRo
ZW0gaW52ZXJzZSBpbg0KPiBwcm9iZSgpLg0KPiA+ICAgLVJlbW92ZSB0aGUgcG1fcnVudGltZV9n
ZXRfc3luYyhkZXYpIGluIGlteDkzX2FkY19yZW1vdmUoKSwgYmVjYXVzZQ0KPiB0aGlzIGRyaXZl
cg0KPiA+ICAgIGVuYWJsZSB0aGUgcG1fcnVudGltZSBhdXRvc3VzcGVuZCBmZWF0dXJlLCBhbmQg
Y29uZmlnIHRoZSBkZWxheSBhcw0KPiA1MG1zLiBTbyB3aGVuDQo+ID4gICAgY2FsbGVkIGlteDkz
X2FkY19yZW1vdmUoKSwgdGhpcyBkZXZpY2Ugc3RpbGwgaW4gcnVudGltZSByZXN1bWUgc3RhdGUs
IG5vDQo+IG5lZWQgdG8NCj4gPiAgICBmb3JjZSByZXN1bWUgdGhlIGRldmljZSBiYWNrLg0KPiBJ
IGRvbid0IGZvbGxvdyB0aGlzIHBvaW50LiAgUGVyaGFwcyB0YWxrIG1lIHRocm91Z2ggaW4gbW9y
ZSBkZXRhaWwgb24gd2h5IHRoZQ0KPiBkZXZpY2Ugd2lsbCBiZSBpbiBhIHJ1bnRpbWUgcmVzdW1l
ZCBzdGF0ZSB3aGVuIGV2ZXIgd2UgaGl0IHJlbW92ZT8NCg0KSGkgSm9uYXRoYW4sDQoNClNvcnJ5
IGZvciBkZWxheS4NCg0KVGhpcyBkcml2ZXIgdXNlIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIsIHNv
IHdoZW4gZG8gcm1tb2Qgb3IgdW5iaW5kIG9wZXJhdGlvbg0KVGhlIGZ1bmN0aW9uIGNhbGwgc3Rl
cHMgYXJlIGFzIGJlbG93aW5nOg0KcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXINCiAgLS0+IGRy
aXZlcl91bnJlZ2lzdGVyDQogICAgIC0tPiBidXNfcmVtb3ZlX2RyaXZlcg0KICAgICAgICAtLT4g
ZHJpdmVyX2RldGFjaA0KICAgICAgICAgICAtLT4gZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVy
bmFsDQogICAgICAgICAgICAgIC0tPiBfX2RldmljZV9yZWxlYXNlX2RyaXZlcg0KDQpJbiBfX2Rl
dmljZV9yZWxlYXNlX2RyaXZlciB7DQogICAgICAgIHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsN
CiAgICAgICAgLi4uDQogICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsNCiAgICAgICAg
ZGV2aWNlX3JlbW92ZShkZXYpOyAgICAgLT4gY2FsbCBpbXg5M19hZGNfcmVtb3ZlKCkNCiAgICAg
ICAgLi4uDQp9DQoNClNpbmNlIGluIHRoaXMgaW14OTMgYWRjIGRyaXZlciwgd2UgdXNlIDUwbXMg
YXV0byBzdXNwZW5kIGRlYWx5LA0KICAgICAgcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVs
YXkoZGV2LCA1MCk7DQoNCmFuZCBoZXJlIGlzIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGlzIEFQSSAg
KERvY3VtZW50YXRpb24vcG93ZXIvcnVudGltZV9wbS5yc3QpOg0KICBgdm9pZCBwbV9ydW50aW1l
X3NldF9hdXRvc3VzcGVuZF9kZWxheShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBkZWxheSk7YA0K
ICAgIC0gc2V0IHRoZSBwb3dlci5hdXRvc3VzcGVuZF9kZWxheSB2YWx1ZSB0byAnZGVsYXknIChl
eHByZXNzZWQgaW4NCiAgICAgIG1pbGxpc2Vjb25kcyk7IGlmICdkZWxheScgaXMgbmVnYXRpdmUg
dGhlbiBydW50aW1lIHN1c3BlbmRzIGFyZQ0KICAgICAgcHJldmVudGVkOyBpZiBwb3dlci51c2Vf
YXV0b3N1c3BlbmQgaXMgc2V0LCBwbV9ydW50aW1lX2dldF9zeW5jIG1heSBiZQ0KICAgICAgY2Fs
bGVkIG9yIHRoZSBkZXZpY2UncyB1c2FnZSBjb3VudGVyIG1heSBiZSBkZWNyZW1lbnRlZCBhbmQN
CiAgICAgIHBtX3J1bnRpbWVfaWRsZSBjYWxsZWQgZGVwZW5kaW5nIG9uIGlmIHBvd2VyLmF1dG9z
dXNwZW5kX2RlbGF5IGlzDQogICAgICBjaGFuZ2VkIHRvIG9yIGZyb20gYSBuZWdhdGl2ZSB2YWx1
ZTsgaWYgcG93ZXIudXNlX2F1dG9zdXNwZW5kIGlzIGNsZWFyLA0KICAgICAgcG1fcnVudGltZV9p
ZGxlIGlzIGNhbGxlZA0KDQphbmQgdGhlIGRlc2NyaXB0aW9uIG9mIHBtX3J1bnRpbWVfcHV0X3N5
bmMuDQovKioNCiAqIHBtX3J1bnRpbWVfcHV0X3N5bmMgLSBEcm9wIGRldmljZSB1c2FnZSBjb3Vu
dGVyIGFuZCBydW4gImlkbGUgY2hlY2siIGlmIDAuDQogKiBAZGV2OiBUYXJnZXQgZGV2aWNlLg0K
ICoNCiAqIERlY3JlbWVudCB0aGUgcnVudGltZSBQTSB1c2FnZSBjb3VudGVyIG9mIEBkZXYgYW5k
IGlmIGl0IHR1cm5zIG91dCB0byBiZQ0KICogZXF1YWwgdG8gMCwgaW52b2tlIHRoZSAiaWRsZSBj
aGVjayIgY2FsbGJhY2sgb2YgQGRldiBhbmQsIGRlcGVuZGluZyBvbiBpdHMNCiAqIHJldHVybiB2
YWx1ZSwgc2V0IHVwIGF1dG9zdXNwZW5kIG9mIEBkZXYgb3Igc3VzcGVuZCBpdCAoZGVwZW5kaW5n
IG9uIHdoZXRoZXINCiAqIG9yIG5vdCBhdXRvc3VzcGVuZCBoYXMgYmVlbiBlbmFibGVkIGZvciBp
dCkuDQogKg0KICogVGhlIHBvc3NpYmxlIHJldHVybiB2YWx1ZXMgb2YgdGhpcyBmdW5jdGlvbiBh
cmUgdGhlIHNhbWUgYXMgZm9yDQogKiBwbV9ydW50aW1lX2lkbGUoKSBhbmQgdGhlIHJ1bnRpbWUg
UE0gdXNhZ2UgY291bnRlciBvZiBAZGV2IHJlbWFpbnMNCiAqIGRlY3JlbWVudGVkIGluIGFsbCBj
YXNlcywgZXZlbiBpZiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUuDQogKi8NCnN0YXRpYyBpbmxp
bmUgaW50IHBtX3J1bnRpbWVfcHV0X3N5bmMoc3RydWN0IGRldmljZSAqZGV2KQ0Kew0KICAgICAg
ICByZXR1cm4gX19wbV9ydW50aW1lX2lkbGUoZGV2LCBSUE1fR0VUX1BVVCk7DQp9DQoNClRoaXMg
bWVhbnMgYWZ0ZXIgY2FsbCB0aGUgcG1fcnVudGltZV9wdXRfc3luYyBpbiBfX2RldmljZV9yZWxl
YXNlX2RyaXZlcigpLCBpbXg5M19hZGMgd2lsbCBub3QgY2FsbCBpbXg5M19hZGNfcnVudGltZV9z
dXNwZW5kKCkgaW1tZWRpYXRlbHksIHdpbGwgZG8gaXQgYWZ0ZXIgNTBtcywgYnV0IGp1c3QgdGhl
biwgY2FsbCB0aGUgaW14OTNfYWRjX3JlbW92ZSgpLCBzbyB0aGlzIG1lYW5zIHdoZW4gaW14OTNf
YWRjX3JlbW92ZSgpIGV4ZWN1dGUsIHRoZSBBREMgcmVsYXRlZCBjbG9ja3Mga2VlcCBvbi4NCg0K
QmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0KPiA+ICAgLW5vIGNoYW5nZXMgZm9yIGJpbmRp
bmcgZG9jIGFuZCBkdHMuDQo+ID4NCj4gPiBWNDoNCj4gPiAgIEZvciBBREMgZHJpdmVyLCByZS1k
ZWZpbmUgdGhlIEFEQyBzdGF0dXMgc2hvdyB0aGUgcmVsYXRpb24gdG8gc3BlY2lmaWMNCj4gcmVn
aXN0ZXIgYml0Lg0KPiA+ICAgUmVkbyB0aGUgaW14OTNfYWRjX3JlbW92ZSgpLCBjaGFuZ2UgdGhl
IHJldHVybiBlcnJvciBzZXF1ZW5jZSBpbg0KPiBpbXg5M19hZGNfcmVhZF9yYXcoKSwNCj4gPiAg
IGFuZCB1c2UgYSBkaXJlY3Qgc3RyaW5nIGZvciBpbmRpb19kZXYtPm5hbWUuDQo+ID4gICBGb3Ig
ZHQtYmluZ3MsIGNoYW5nZSB0aGUgY29tbWl0IHRpdGxlIGFuZCBhZGQgbWFpbnRhaW5lcidzIHJl
dmlld2VkIGJ5DQo+IHRhZw0KPiA+ICAgRm9yIGR0cywgbm8gY2hhbmdlLg0KPiA+DQo+ID4gVjM6
DQo+ID4gICBGb3IgZHQtYmluZ3MsIGFkZCBzb21lIGNoYW5nZSBhY2NvcmRpbmcgdG8gcmV2aWV3
IGNvbW1lbnRzLCBhbmQgcGFzcw0KPiBkdF9iaW5kaW5nX2NoZWNrLg0KPiA+ICAgRm9yIGR0cywg
YWRkICNpby1jaGFubmVsLWNlbGxzID0gPDE+OyB0byBwYXNzIGR0YnNfY2hlY2sNCj4gPiAgIEZv
ciBBREMgZHJpdmVyLCBubyBjaGFuZ2UuDQo+ID4NCj4gPiBWMjoNCj4gPiAgIEZvciBBREMgZHJp
dmVyLCBhZGQgY2hhbmdlIGFjY29yZGluZyB0byBtYXRhaW5lcidzIGNvbW1ldHMuDQo+ID4NCj4g
PiBIYWlibyBDaGVuICgzKToNCj4gPiAgIGlpbzogYWRjOiBhZGQgaW14OTMgYWRjIHN1cHBvcnQN
Cj4gPiAgIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogQWRkIE5YUCBJTVg5MyBBREMNCj4gPiAgIGFy
bTY0OiBkdHM6IGlteDkzOiBhZGQgQURDIHN1cHBvcnQNCj4gPg0KPiA+ICAuLi4vYmluZGluZ3Mv
aWlvL2FkYy9ueHAsaW14OTMtYWRjLnlhbWwgICAgICAgfCAgODEgKysrDQo+ID4gIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KPiA+ICAuLi4v
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMgICAgfCAgMTIgKw0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpICAgICAgfCAgMTMgKw0KPiA+
ICBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKw0K
PiA+ICBkcml2ZXJzL2lpby9hZGMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiA+ICBkcml2ZXJzL2lpby9hZGMvaW14OTNfYWRjLmMgICAgICAgICAgICAgICAgICAgfCA0
NzcNCj4gKysrKysrKysrKysrKysrKysrDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwgNTk3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg5My1hZGMueWFtbA0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vYWRjL2lteDkzX2FkYy5jDQo+ID4NCg0K
