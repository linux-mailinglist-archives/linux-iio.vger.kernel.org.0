Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560AA3D535D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGZGMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:12:41 -0400
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:45554
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229658AbhGZGMl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Jul 2021 02:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYwwQxtzTrDtNXnuzJ27P/y8kQnXV9Lyl/ktVT0JEpqVb1Oa7YOFnSegw+IlDCAa7xpOHF48n+2iCqN+swZU22R/LJsIZ/I0beRwWvfoK7oBwgCwdy/CTxd8PdZssv54HE3pPigebnEV8VggO/f6bVQ7ZHjWuoHFtX0KkNACyDIFHMuzRENn43vZFX55Kk6yG6ZhSnggiA30VIHXsRq3IkyebfFM4eyB+0ORFGMlsJrh9ycP/6hz1ecCKTnScwFCsMcPwi7GD625GOaAD7FLva9rzbyv2FuNu4/oaTfT+rdK5I44abbqSJ9j2z0NRsGjHDv/o1qmuSeLdEyIjSgGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpPBKe+b+1p5RrXpc+Go5rDMykKrwa5n5JLD5PHlMQ=;
 b=Q+1WNy7ob1WFgCVvaRpLX/KC3SjSITb6r+Hx0MB7spKHLr+y1v2ayn5Y6lDRXr9Q1dHwv/W+kQ/SR8TsiHiOTc38Je8ZemXCLFnSLFlg4HSOFOV2e24WJ1fIQydDUqEAoSFBQuEsWCGFBFP9jM8PBBQN1XBrxHiHnoneseQEmVTm2qz8P5pwVaPNls0FQsiKZcmdDhAL71WqEqIOrw4yir5DFD/FEvKG24zB8TPQ+y+p6+M4YklLeanSiH7I64uLn0chp8i+/FGYlOo41RX09IboFbv3UxIybQ1f1phWHGVaVSXA6fdXw+zzdN/Rf7NGTrVdFFRRXgYOToCOt/S3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpPBKe+b+1p5RrXpc+Go5rDMykKrwa5n5JLD5PHlMQ=;
 b=mIq9vvwE5AQnqmfE9kjtvgDN/dglhYfVizAlLNyD2ZXp9INYDLgMiuYQhFEkS4EhauUUsobMIlHGLapsNxVkVnKdGHfAY2KqU+fcBqVV5zNlTx1UrTsqd89embWE7HMO+bpTEdJrolE0gIyfaWJcA4TslP9BQ14SqLPnwrMi1TMgvMRczstRE3dnf90ED4Y/keEUVUK3rDjnYajI1IbGI9yQDQDRWUKZb0DnEEBzKKtoMvyyCIBjubrHaBIC05tmG7tAAhP7U5NhoIqP7Xp3efvvsLKgfSWGbpR59SHHDy2PKNymGYLiTPZjeb2dT9tcimC4a65uC0PhcDDLTZ6Kww==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3715.apcprd06.prod.outlook.com (2603:1096:203:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 06:53:08 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 06:53:07 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
Thread-Topic: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
Thread-Index: AQHXf5rvaFI7lCUjSkmdExN/5MdE96tQo2UAgAS5RwA=
Date:   Mon, 26 Jul 2021 06:53:07 +0000
Message-ID: <E650AFD8-FFD1-4D87-87B0-42D20D9C3BB4@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-2-billy_tsai@aspeedtech.com>
 <20210723154456.00006744@Huawei.com>
In-Reply-To: <20210723154456.00006744@Huawei.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39ff2490-3e5a-4913-6cba-08d950020681
x-ms-traffictypediagnostic: HK0PR06MB3715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB37153ADB9CED5DA6F2A561078BE89@HK0PR06MB3715.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xsnWE0xjLT+p5EjFstL9R0D4toZzIhICOHnrGhG8S6xd/yPdfx7jvCk45njTjHBX51mowiojuPApZ/T/u+gbBJgdQKUdDJW2gFTsnIy2wr/67sYZ0IxnwUbVfxiy1b/veUA3QGTPFmlhjr4DrH9Q8mBa8VBeIAeG3gY97/yfSOIrwqt6dEpJ/OamzKh5KDMEWSKkUW0LxtSLKpRVQ1x0pmcdxX7xxY7gzj2bWyuD8HWP46CEnDjfxajkWQcj88fPPJPBHh8mPDoe3pnLu1b01hg9xDrB8Dhfz8a0xATc6sDba/Mg4lKAPnvmu304HILtjRT6MdFkVLbcaCi/hHWePIVitfUuI/hWe8t9uuq7cdV74WI44tfIALMATbCBGLJqtqO/wI+gdkJgq+MYf+pS66mJSg1w3R3OfEiSECaFyxhkNhrwiN4MGvqdzCtCT6ac0AajCTI44SJ3df47jyY40HLd6O/V21KA1ZccBxWQs43EFqaFnZeQWm3ObBZtyCzzOr3IJ6929ZM/OVk50RonzKHzljcsrzoAoDE/+idydti84+alQ/9+g3bwbJfia08GGd46Du/vNeH4DanROuvwk8IFgQK/LmliZ+ukh9mTdrYfLQ0DTNPeJCrhF6MC0D6tPvKvcSsl0/ZQcnJZ6ANNeUlKiBUAlaaknFCSOFQk+jbx7jJKxtl9CGau9pfXY2wmRyllJztSH948WQ6kdHfIAo9hIutOba3Nv5/zrSRrYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(366004)(376002)(346002)(71200400001)(8676002)(2906002)(26005)(66556008)(36756003)(5660300002)(107886003)(4744005)(55236004)(6512007)(6506007)(53546011)(316002)(66446008)(478600001)(54906003)(76116006)(91956017)(38100700002)(122000001)(8936002)(2616005)(64756008)(66476007)(66946007)(6486002)(86362001)(4326008)(6916009)(7416002)(186003)(33656002)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VllUSU1YNXpwbUt5K0FGZlorckJ3MkZ5V1NFMWljTHpnakNzeHFDbGVFczdk?=
 =?utf-8?B?cmVsY0VoNjBkYWpORkphaEMweVZjbXd2eGRZWXFpdnpGZXpoVDZTUGhDUXM2?=
 =?utf-8?B?L2xoRmw3ZndtSmtHSlJ2K2tPeVBobFRPeURLWGhkZG5jRWZ3amgrNmdGSWVu?=
 =?utf-8?B?cENjSVpzMEIxd0NUQnFIMkdwVld3eDVKWTEyTHU0RnpPMWhpUWYrRUdPR3Jq?=
 =?utf-8?B?NFltTHF0UUM1ZjFjT093T0U3dnJlU2poRWpId0E4U0JXSzJrY3NsOGJhTkJj?=
 =?utf-8?B?K3pmZXBqZkVXWVVleG55ZWZST0hhOXpvRk5rUXBQcEFsajBUQUFLdE03b0tP?=
 =?utf-8?B?TlgybFRQRW42R0ZQTWQ5SnZoMTFCZGpGbVhNMG93aFNPeERXV1JzRmlodCtE?=
 =?utf-8?B?RlpkellCcE1raytqUUtFL0pWUWkxL082cHg0MTNqUnhDUmFUMkRGUEpUSEtl?=
 =?utf-8?B?azRPaFNoQTJaOUdVQzlLa3pCMEliTEpocXJoK1RESnBBV2hrbm8veGxaVEJY?=
 =?utf-8?B?UlR5ZGd2WDhBVEoyNlE3aHNNNGN3LzVnWGxaYStSSlN2QkpJTHo2blJ4WFRB?=
 =?utf-8?B?OXR1aW1kK1ZpVlFwbngySVFlN2V1bzE1d1hESFJTKzZZb3c2MnVlc3NvRXBa?=
 =?utf-8?B?eFNZbkM3VGFzVnpYbHpXVWxvZy84ckhacitMTnRhVTFJcEluL1EvcWtxN1Jm?=
 =?utf-8?B?d3lXWHRLK1VnNVhHU3JYSVJSQ0htK24wb0p0OXBsSk5PMnpnSEtSY0tpRGhX?=
 =?utf-8?B?NzMzaUR2UGVHcnNST3hSVjNxSWVNc2hUNVVqWkdwWTBpV1cxandsSUg4VWJn?=
 =?utf-8?B?eS92NjlCNnZvcGdhNEl6c1RBOEVTeTh5bWh6TnBJMCtwdVAzMmdERGwzSDQ4?=
 =?utf-8?B?cWwzOEtrRnVnSnNsaG5YcjdyUE4xSTdiS3ZCc3E4Z1RwMWtNbWZvWGdKT2JZ?=
 =?utf-8?B?SDdZRXF1RmIxTFlUWUREN01xMEFaRmo4WFpDQ05OdVZIWS9ZL0wreWJtcG5q?=
 =?utf-8?B?K2Rwa1d4V1lqYlpDdHlHaXU1SDRweVV5Wjk0eTJoZ0hUc3lNRlRxR0lGU0tj?=
 =?utf-8?B?bDdYSU5odTMvZ083U2JSMUJoOGVFYkE1ckw1cmlqLzMxc0ltdm9LUHZxNEw1?=
 =?utf-8?B?ZTYrQVl2UytIKy9pTnoya25jVkJmRHVOSTF6WXlXVzNaMHlpY1paR0lkME1U?=
 =?utf-8?B?SFd3RUtwdHpRRVpiZXQrQXFBYXNaNWpzRllIclhGNmJrcG84bVNqVFp6c2t3?=
 =?utf-8?B?bVg0T2Y0cHZCU3BmZGl1bmh4Z0VleTJ2OUFKR2VweGlOY3JWV0c4WDVJbVJv?=
 =?utf-8?B?ZlA3U0xhZm5DYWFKbmFrYjlyODQ2c0hsQWhCQTF6STdLM2Mzd2dEa2orZUQr?=
 =?utf-8?B?NDVUOWs5TkJld0JMYUZOano4ZnhNaGI4U1JvbWtGNnZVK0dxaHU3RFlNN3NC?=
 =?utf-8?B?Z29UZkZBc1JUb29RaHRrZGZZUUh6QTNwQk5NQnl1STloRkxpMDlEQkZkZlYx?=
 =?utf-8?B?SUdrQUx6bXA0UXlOYUYzRk9wblJNSEF6ZjFwdmN2MVRMNTVicHhFTDlDcTBy?=
 =?utf-8?B?OGsvNS8vRU5KQVFZWjNnZjEzUUxnVHJEb3lqczBBRmJZdVFaTmlFVVZWaERR?=
 =?utf-8?B?VW4xaDEyamdYbGRHeGNjNVVTMzNYQ0FpdEZLeEVRTXhDLzFsdGJSRTlvcjJu?=
 =?utf-8?B?VlFTQTJQU2JTUC9hczU2L3RXUTlKOWU0dGJuUHdzei9FL0IrR3BET09uSDJQ?=
 =?utf-8?Q?MXphTo/KuZnctAV4NbA5OkmoVqlMxhsPmSBR/fe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79A5F402C0F06A4D9D63A292F75C42BA@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff2490-3e5a-4913-6cba-08d950020681
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 06:53:07.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we3Ky8dZxPpnDObDaQh2zvG0idgAa1tdPu36ROFybP9f4Ei7HRH5hiOPhh4dDgFfabSwOFWcKPGuLPa6I/RtKiIszJ6u80/NCf0szd5jUrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3715
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIDIwMjEvNy8yMywgMTA6NDUgUE0sICJKb25hdGhhbiBDYW1lcm9u
IiA8Sm9uYXRoYW4uQ2FtZXJvbkBIdWF3ZWkuY29tPiB3cm90ZToNCg0KICAgIE9uIEZyaSwgMjMg
SnVsIDIwMjEgMTY6MTY6MTQgKzA4MDANCiAgICBCaWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVl
ZHRlY2guY29tPiB3cm90ZToNCg0KICAgID4gICA+IFRoZSBhc3BlZWQsYXN0MjQwMC1hZGMueWFt
bCBub3Qgb25seSBkZXNjcmlwdG9yIHRoZSBiaW5kaW5ncyBvZiBhc3QyNDAwLg0KICAgID4gICA+
IFJlbmFtZSBpdCB0byBhc3BlZWQsYWRjLnlhbWwgZm9yIGFsbCBvZiB0aGUgYXNwZWVkIGFkYyBi
aW5kaW5ncy4NCiAgICA+ICAgPiANCiAgICA+ICAgPiBTaWduZWQtb2ZmLWJ5OiBCaWxseSBUc2Fp
IDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KDQogICAgPiAgIFdlIHRyeSB0byBhdm9pZCAn
d2lsZCcgY2FyZCB0eXBlIG5hbWluZ3MgbW9zdCBvZiB0aGUgdGltZSBhbmQgaW5zdGVhZA0KICAg
ID4gICBuYW1lIGFmdGVyIGEgcGFydGljdWxhciBwYXJ0IG51bWJlci4gIEkgc2F5IHRyeSBiZWNh
dXNlIGNsZWFybHkNCiAgICA+ICAgd2UgbGV0IGEgZmV3IGluIG92ZXIgdGhlIHllYXJzIDooDQoN
CiAgICA+ICAgSXQgaXMgdmVyeSBoYXJkIHRvIGtub3cgaWYgdGhpcyBiaW5kaW5nIHdpbGwgYXBw
bHkgdG8gJ2FsbCcgZnV0dXJlDQogICAgPiAgIGFzcGVlZCBBRENzLg0KDQogICAgPiAgIEFzIHN1
Y2ggSSdtIG5vdCBzdXJlIHRoaXMgcGFydGljdWxhciByZW5hbWUgbWFrZXMgc2Vuc2UuDQoNCklm
IEkgd2FudCB0byBleHRlbmQgdGhlIHlhbWwgZmlsZSB0byBjb21wYXRpYmxlIG1vcmUgdmVyc2lv
bnMgb2YgdGhlIGFzcGVlZCBhZGMuDQpXb3VsZCB5b3Ugc3VnZ2VzdCB0byBhZGQgbmV3IGZpbGVz
IGNhbGwgYXNwZWVkLGFzdDI2MDAtYWRjLnlhbWwgb3IganVzdCBhcHBlbmQgaXQNCnRvIHRoZSBh
c3BlZWQsYXN0MjQwMC1hZGMueWFtbD8NCg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5
IFRzYWkNCg0KDQo=
