Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C36EDAA7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Apr 2023 05:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjDYD3X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 23:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYD3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 23:29:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6DBD;
        Mon, 24 Apr 2023 20:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXEHi+tnmPFxkCWe2FTds8V+IE8BIG84AoEY0lBSuuc3U7wRpZ8FhQhplV+TIEZuCh4VctP7hHEFuPPnSWiShR8r5U+wphXqUHkJNtq3XHGlHjqxhZTXbwgZTScblIo3rLeec8fg1IHNHkOoQZjgcF05vNtHwtnBfbDChRtqBvo+uEx39+ek23oeo+T0j+O9M69x/2C6EVHcyVnUcWoJ+BrHj1vWRIrHX2swL009MJTgHDI7XvYXrsl4r5F56Yn8cFjl9tt11oxtjOFa0BJrk7r2VSlbl+QU/akkVU4jiXnqY2z0RmdI9mD5GhPvdb4MsAhz9G4zXa6T5AceWj9xVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPmjNdksrSGu2gH4H2nHtIjuazylqoRMWfUbsI1XdAw=;
 b=cgbLlx4HcS0kTNyxHAVk/XBNyZaFpqp9OU35ruZsUZPiT35zD2Gk6qhxD8OpB42k16zxp8SpnJsxeeZiUGH/88HbS0gBLSxsV2AJPq+o+DZe6BdPIeTRS0NtARS5FeASWlmoK/JXAUGoo9nQqKVG8VLhn1DKVquCgFJREcS5DLZ13Iim6UfPM1xkQYdFH2FZhtu0vwPvvPUkZrV2vrCgW7ByBLKI+dS4awWEWKXm9nqVaa5jzXRD+PtEF4+vAER8+vxzIq2I3EmVtF996d7ChtyzIyKTGR70+stpeKseHCCcj3i094wtvexRcmWmXVrYRmst7CnpbXPxLeC4KVZTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPmjNdksrSGu2gH4H2nHtIjuazylqoRMWfUbsI1XdAw=;
 b=BU5iVl992UHPbJEAxfdxBcOooL3V+gca54XW6LFmiNNzlntABEtDm1V/6qnJiQIzyhGHB4gDa3Y9UGXZ/akrfbfajzAaD1e/boL8Oyb0FRPXQouHrNFFCcAg0OjBLRUqZa0HMnCz2ZMDWxJ/T27ZPEfF9CDUDjw5BOw7wvW+mNM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Tue, 25 Apr 2023 03:29:17 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 03:29:17 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: RE: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing
 vref-supply
Thread-Topic: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing
 vref-supply
Thread-Index: AQHZdo5qmQydsCpGvU2DpntjpXe89q87Xu/w
Date:   Tue, 25 Apr 2023 03:29:17 +0000
Message-ID: <DB7PR04MB40101993E84C82B8FAC7DFEB90649@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230424092312.61746-1-alexander.stein@ew.tq-group.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU0PR04MB9467:EE_
x-ms-office365-filtering-correlation-id: 286ab9ce-0c88-486a-c435-08db453d3fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fg+9u7nfXT22TOB0+gZyplkZxeMZ8S++IwcaoYf1CIoKc31AvFK5urCzUtJ7UL5GL4/Y6Y1WIap+7e6NGeHVDvhoAOrYeh6WCeEGEf0eb8SDNSrDAceUkTsQkeM5A8zfdtfvhBprNCBi0sKEYjz/d2iJF/w7kFjnXs3/Erj0cN0gV/QLkZGAwpBb8jCres3sDmr87KaUm1GHiiS4bPmlXTWWa3clBHuQELHAWEP9J5oYj5o+LRIvR9SUB/w6RNEiJRH7b1XDLbts/+RHpUVgbz4Ai2CGzQMTIYYJyAZ12pZ5vAxH3ZWKF/kB00PJb1DcPeMFrQuJdjBAXC6H1elnYAg1WTC2iCY1mSgTL4LdZVYBeHGnyWzjyi9lTpFaDzQ9nGEp8P2ieOX3Dg4HCsKQOcGYF6S7JKymEIN3htB0h7K+Lbs282/BSEL4vsoLKeLIrM9Qwe4MCxfzUOWifK3o/c/V0WuadlieLvSHPrycj69NQsIH/YDTU5dS+iny+KBXDYAkR6y3Z8DJee8qFG5TXJ9RkjNWfdFjisUh/rMNkSNmpTE+6KvtlFqiBy+FQgXTW1359BAvLFqdWkwZj+Q2MceVbJFryz5BrOeo0MgwQMXRNQFkqpDYoxBtUxevOxSP6339cU333szCrG5kTc7+sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(54906003)(110136005)(38070700005)(478600001)(76116006)(316002)(4326008)(66446008)(66476007)(66556008)(55016003)(66946007)(64756008)(122000001)(7416002)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(86362001)(186003)(6506007)(26005)(53546011)(9686003)(33656002)(7696005)(71200400001)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?akNaWjVnemgzUTBKc2M3TGZUbmsvVCtCdVRYdU50QVdMSXlIdytlWVY3d0da?=
 =?gb2312?B?YVA0TUk0c28zMEU3Mkp2NmNPL0V2a2FUdUxWODdBRFFNRU1BR2VtWXdDMEp4?=
 =?gb2312?B?VmRpeityMjVmaWhMWDFGUW1rM2dVenhVSkJ2ZjZVNk5NeXZVTXdMU3lMYlhV?=
 =?gb2312?B?dURxNTNYSzB2ejg5bkI4K3lJQ2FramhlT0VVbkJIcUc2QlFXUWR0ZlhUOWVk?=
 =?gb2312?B?TnFNT2kzdEkwZk41ZW13bHNxK2ZpZThrZjZIVVFVNGM5R0pVV0Nkc3k1amxh?=
 =?gb2312?B?WU9TckkvM29QRTJnaEcySERWK3ZoSlV4ek96d3ZQbHRySTF4bm1hK0Vqbnpm?=
 =?gb2312?B?d05GdFg4MW5GWEw3VmJRRmt1YnVieTdKUDBWSUk0ZWF1THk4cmZqQ2V5L0FD?=
 =?gb2312?B?YWsvQU9mV2d3SzV2QW1FWG9zdnFQaHNFRHBORExmNmJzOW1adzBvQThoNmxa?=
 =?gb2312?B?QkFydHFsOWRacUZrZk9wSHFhaEw4V0phMm1KdGxIUVRXRTBpNzF4cm84Q2NH?=
 =?gb2312?B?OGEzQktnMmdBMytWOFJLZUhSWFIyUDhUWFRPOUpnbnU5Z24xazY3cUJKUTJk?=
 =?gb2312?B?eTJoMEhZcTB5TU1sVDMya3VzTlJjWUtkYVgyNTdWZlpYRHZEcHY4VVdZSnRs?=
 =?gb2312?B?NHE1OHFZNmJoVUtYMERuWjFtc1ZzQkFzdXRnQkJRK3ZFbTVKTTQ5WDBBZDA0?=
 =?gb2312?B?WHova21Kc1l3Uks3N1pPWDduMytTcFJBV3BiVUFCNUVKV1BKVWJHei9GMUJL?=
 =?gb2312?B?V2Zyb2dTVUZRNVFnVkZ3QUxSYjNDZ0NGLy93VW1BTEE1MzNwNGU5QnltSU9O?=
 =?gb2312?B?dytBQ3ZlR0JPazJlZjRmbjRYb3RCdWxrdG1CZm9iYk1qc0NIcTRmSmlJYXFK?=
 =?gb2312?B?NTZVZ3RHK2ZNRTlIWGhmeTlOVmpCbmJyMWNTOGhpeTZ1SGpyaldwY2pKZElF?=
 =?gb2312?B?VlNkejNKYURQeWhTTFJNYlJrbG9UcWlsOWp6cjNidy9UUjFjUW83T1JxMzRl?=
 =?gb2312?B?a1NrZHh6eE9kd1pwVFh2aTVkNXcyYkdCQ2pMalFFS0xnWjVqa25KZWtucGNP?=
 =?gb2312?B?Q0Z2OHBvZXdyeEJRblAwWjRoazUxTmdiRFNIQ2ppRDVSZHlzVkJDblBUa0h1?=
 =?gb2312?B?cDR2VEF4MTJwdXVDOEEwcThvZ0xXeFRQcVBTZXBQZndGeUJaYXhQSDBQNDlw?=
 =?gb2312?B?QVVxVmRSTlRBQjFoUkgzZ3BoZlhsMElxQzNiK3ltVk0rZmg0dFVGSmh0NWp1?=
 =?gb2312?B?bldreWx0a3FaVENyRnpLL3B5aEtOWWNPQnhPc0l1Yzd5dG5iSkxJa1Z4NVJ0?=
 =?gb2312?B?aDdRbzhJSWpya0VqRTVEU3lXVFBhNW5qRzhvc0RmSUJBbUdaTS9RNGFFVS8x?=
 =?gb2312?B?SHdyaVRSbmlsRDh3Njc0R2tDWUFjVEpaSWpkZTA3RzZKczNDWlVZOUE0cWFY?=
 =?gb2312?B?blFHcStPOUhMWXJRU3ZYNU5kRnYxTHoyS1JlaEZsZFVleWFKNmFTUzJRNUgv?=
 =?gb2312?B?cEFiZEdSdy9DWWpqZnUwNTVXdG1ZY3FGRldZR24rdDl0SER0Y2xNNWliL0dY?=
 =?gb2312?B?bk02TVNSRm9xaUkwaXFvWWJCZXdTTDk0TWNkSmZmQUlZSHR5ZjBJY2piNGdZ?=
 =?gb2312?B?dWx5TzNYb2J3VmpIbVlsc1liMzNEd0NkQzlaK3Q3YlpVTDNTLzZDRkpaSVpu?=
 =?gb2312?B?YmV1ekNFb1p1OHlQZ2UwbTRaN2RnVGZtY202Z1ZPTzl4eGVyZ1NWSDdvYTQ2?=
 =?gb2312?B?eVJ6UzFEa1JVb1BUR0EydXpHVG1CTHFqOTI3MzhTTy9OUHRreVRsNVBVcFUz?=
 =?gb2312?B?YmdaLytXSkNCRFE5Sm1CUHpvYkROL2RwTTludTl2ZzJtT3hta1dsc2xrT3FT?=
 =?gb2312?B?VldXTUo1eHZWWTE5aDJ4QWVSQ2cybmtnam54Mit1enk1M0tsQ3FWeVB6c2dZ?=
 =?gb2312?B?aStaL0R5ak9nWjQ0bUZyREV4akFRaWNUY2RSSFArV3VHNDFsbG5YRHdRdUxs?=
 =?gb2312?B?ZWRBVnNMa3JtNzRjNEc2dW1CbVlseXFDRzl1bllWVzVvbWlTNUR4UVp4UkdN?=
 =?gb2312?B?NHdFZGFzNHpjNnhnbitESkZHTElFOUdlb2dLWFU5VSt4MnJISHQxS3RKNjAx?=
 =?gb2312?Q?PvDY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286ab9ce-0c88-486a-c435-08db453d3fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 03:29:17.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMKqmpCXkxnkv4svIDZzM4OsBSZD/XNDbhqOTXfTefwlW7YWgwvyEVjGGf31AucMY7uCBN+b1arIjkHYJv4kzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFs
ZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IDIwMjPE6jTUwjI0yNUgMTc6
MjMNCj4gVG86IENhaSBIdW9xaW5nIDxjYWkuaHVvcWluZ0BsaW51eC5kZXY+OyBCb3VnaCBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwu
b3JnPjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Ow0KPiBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3Jn
PjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZh
bQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBDYzogQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5k
ZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPjsgUGVuZ3V0cm9uaXggS2VybmVsDQo+IFRlYW0gPGtl
cm5lbEBwZW5ndXRyb25peC5kZT47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0K
PiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBNYXJjbyBGZWxzY2ggPG0u
ZmVsc2NoQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8xXSBkdC1iaW5k
aW5nczogaWlvOiBpbXg4cXhwLWFkYzogYWRkIG1pc3NpbmcgdnJlZi1zdXBwbHkNCj4gDQo+IEFs
dGhvdWdoIHRoaXMgcHJvcGVydHkgaXMgdXNlZCByaWdodCBub3cgZm9yIElJT19DSEFOX0lORk9f
U0NBTEUsIHRoaXMgQURDDQo+IGhhcyB0d28gaW50ZXJuYWwgcmVmZXJlbmNlIHZvbHRhZ2VzLCB3
aGljaCB0aGUgZHJpdmVyIGN1cnJlbnRseSBkb2Vzbid0IG1ha2UgdXNlDQo+IG9mLg0KPiANCj4g
Rml4ZXM6IGRiNzM0MTlkOGMwNiAoImR0LWJpbmRpbmdzOiBpaW86IGFkYzogQWRkIGJpbmRpbmcg
ZG9jdW1lbnRhdGlvbiBmb3IgTlhQDQo+IElNWDhRWFAgQURDIikNCj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KDQpUaGFu
a3MhIA0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KPiAt
LS0NCj4gVGhhbmtzIGZvciB5b3VyIGlucHV0cy4gVGhpcyBpbXByb3ZlZCBkZXNjcml0cGlvbiBz
aG91bGQgbWFrZSBpdCBjbGVhciB0aGF0IHRoaXMNCj4gcHJvcGVydHkgaXMgb25seSBhYm91dCB0
aGUgZXh0ZXJuYWwgcmVmZXJlbmNlIHZvbHRhZ2UsIG5vdCBhYm91dCB0aGUgb3B0aW9uYWwsDQo+
IGludGVybmFsIHZvbHRhZ2VzLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gKiBJbXByb3ZlZCBj
b21taXQgbWVzc2FnZSBzdWJqZWN0IGFzIHN1Z2dlc3RlZA0KPiAqIEFkZCBoaW50IGFib3V0IGZl
YXR1cmUgZmxhZyByZWdhcmRpbmcgbXVsdGlwbGUsIGludGVybmFsLCByZWZlcmVuY2UNCj4gICB2
b2x0YWdlcw0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDhx
eHAtYWRjLnlhbWwgICAgICAgfCA3ICsrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL2FkYy9ueHAsaW14OHF4cC1hZGMueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg4cXhwLWFkYy55YW1sDQo+IGluZGV4IDYz
MzY5YmEzODhlNC4uODc4ZTY3MDU0ZDdjIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14OHF4cC1hZGMueWFtbA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14OHF4cC1hZGMu
eWFtbA0KPiBAQCAtMzksNiArMzksMTIgQEAgcHJvcGVydGllczoNCj4gICAgcG93ZXItZG9tYWlu
czoNCj4gICAgICBtYXhJdGVtczogMQ0KPiANCj4gKyAgdnJlZi1zdXBwbHk6DQo+ICsgICAgZGVz
Y3JpcHRpb246IHwNCj4gKyAgICAgIEV4dGVybmFsIEFEQyByZWZlcmVuY2Ugdm9sdGFnZSBzdXBw
bHkgb24gVlJFRkggcGFkLiBJZiBWRVJJRFtNVkldIGlzDQo+ICsgICAgICBzZXQsIHRoZXJlIGFy
ZSBhZGRpdGlvbmFsLCBpbnRlcm5hbCByZWZlcmVuY2Ugdm9sdGFnZXMgc2VsZWN0YWJsZS4NCj4g
KyAgICAgIFZSRUZIMSBpcyBhbHdheXMgZnJvbSBWUkVGSCBwYWQuDQo+ICsNCj4gICAgIiNpby1j
aGFubmVsLWNlbGxzIjoNCj4gICAgICBjb25zdDogMQ0KPiANCj4gQEAgLTcyLDYgKzc4LDcgQEAg
ZXhhbXBsZXM6DQo+ICAgICAgICAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVhfU0Nf
Ul9BRENfMD47DQo+ICAgICAgICAgICAgICBhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwyNDAwMDAw
MD47DQo+ICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9BRENfMD47
DQo+ICsgICAgICAgICAgICB2cmVmLXN1cHBseSA9IDwmcmVnXzF2OD47DQo+ICAgICAgICAgICAg
ICAjaW8tY2hhbm5lbC1jZWxscyA9IDwxPjsNCj4gICAgICAgICAgfTsNCj4gICAgICB9Ow0KPiAt
LQ0KPiAyLjM0LjENCg0K
