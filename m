Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0DD6508E6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 09:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiLSIwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 03:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSIwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 03:52:09 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ADE624B;
        Mon, 19 Dec 2022 00:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myDyt8lf3dDBnZ/0kuoI0ExKq841liY/d1qUughox2MVC9dcuc7punBVLjU3HKOG5yhVrJdXsLzosEUfy9o0MGZ9UHOrc76xCdrMLz/NJUjp9q2xf0fGS5hgpneMPEoKie6JHQjCK2NDO6FZ6FnHC2mnPAGMwCTDGFfevBUhxgt7OK2rSnjcQVnD4pf+VqJtZN52trlhNN6F+lRUk5dSR2q+4kPaKLrLSUFM84BT5D6NlWYbnSjgvZAiqZK1Tz1GlK5MjeTEGCOlJwB1CzKq/fy2ROSYm2KWhQ+xFFwxIy8I632ujQ/VoCRuVzkvMFTv3G6gvCIt7wH3EiIzNhpfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzFeUGkTigPo72p0YDIMDxbkrNCX9Eym295RvQLSzPE=;
 b=Ad6X835Lg4AYIbgld/lZsV/+50X3HT2w7scp66XgUOTIGq/Ln0ma1B/DZelPhVCYTUn5K/0S//+EIvP/YK1M2Byaw0boorxUp8kejrz1drzZRtyOKvZB8VcJTSBN5/wGJPL+xjk0Wa4vsbtVkiC57RplElrPmsRxadqJaORQ/eqGgZejC1DannvIzFq0Ena9WPPEUeVxI3Lgoy87R2Wlv7BrL9bBbsprNL6tZkJZ4aZW0qRL0gtYejdKi3I+B2FJe5ZJf/rhR8SVio8V5cveWLt66fUH6qYb0VXBPCZg1tMIia6WPFfGxi4ounsCZ6Zm9LComtmC+1BJAFl5xMZ2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzFeUGkTigPo72p0YDIMDxbkrNCX9Eym295RvQLSzPE=;
 b=qTYA5yXVeQQ/rfiwapAVpEYGbqvQkH3V5i+5BW2Pbm9Sx6NzBZg3zdS0v/e2u2jelMWKZuSYffFWRDhLKh/ayESiAEDeSBWHa0LgL5iAKlLUW0WxGqxIMf6uJURC715+9n0bLwvruTeJ+XLiwAHMqR6HRHkKbEgf1nZF3Scrd5E=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 08:52:03 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 08:52:03 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Thread-Topic: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation
 for NXP IMX93 ADC
Thread-Index: AQHZD8QvlDXob1CfBEKMPjB5xs9dVK5uu7QAgAYwpfA=
Date:   Mon, 19 Dec 2022 08:52:02 +0000
Message-ID: <DB7PR04MB4010275048307A186BA3D22D90E59@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
 <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
 <559fe1ef-cd12-851c-0cfd-282c4cec10ac@linaro.org>
In-Reply-To: <559fe1ef-cd12-851c-0cfd-282c4cec10ac@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8319:EE_
x-ms-office365-filtering-correlation-id: 736d3312-8cfb-4357-2cf7-08dae19e4c7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdbHErRhjHohaidWSROZsFl6AOY9B1wAaePi+vV107MMJJ4wRHgvYhryuTdH+tyowyAUVjcS4qYd/Lq/FJ/T1S0Gg9NMZ0inehX8RgzDShPbeTMFzZtKs+UUzsQue+TmBDF03ko5599jGqnv3zfv5Ds+vHHNXVBY7L2vP/zUaAhOBcmNAp6xvhiYOMck/PhLRqjM5fKI7O/pm1sue4imVVUBS3Ul7TzheTibvpdGLBssufZcCiPcYG6E2ltWARiE0LTahutLUphJVDkqHX+eigYL0x2lxfW0g/5yBqtf4Yka+Bmqi2LJ3QLK4R3fKVJjijJAGYONhK1vpLZiHmlria4LCWAjIcTaeud/KBVQtrXJXXGddxE3lFgKqubaehajwD8VJCU4HNKugDE4cd7ahlBGn3cgJzdU18N+mMQ7eV1wAXedXM8PFjeT32GHimKHkJYGm2umlKJOWMqHbU1rYKwbaul4UN8Xt3hvuBc2CAS2IpQ1OvWK65hpj7fYqtzr9g58Ea0ZOZBgwmvlQ1rIfPrx8M1vjYhPWdVoSAD5U8/wNB6zF3T3Tqd7eIz0SWIZU7LTmsSe189X7F1N+BFWy8OMYzHE4AalbnRZlKRb7y8URew8iy8vLf7oh9sM9q06t2phImgt1tYtFHy+AtwJ2iCJLT7GEe3VjDlrvKe+KDLshMD29RH5XLmSIdlILdFGdpCDgA+1tDTXI6u5yYu5S8J+4mB8jXeH+lKMBNu0dA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(84040400005)(451199015)(71200400001)(45080400002)(38070700005)(110136005)(55016003)(6506007)(7696005)(38100700002)(53546011)(26005)(186003)(9686003)(86362001)(122000001)(478600001)(33656002)(52536014)(8936002)(41300700001)(54906003)(83380400001)(316002)(2906002)(66946007)(7416002)(4326008)(5660300002)(8676002)(66556008)(76116006)(64756008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NnROTkNBdUQzWkFlcERtYjc5b1VpWTA3Z1BndXFrMjJNUWF5OExENXZyVXhH?=
 =?gb2312?B?aDZ2SERmdzhMRDdYTUhrTmk5cWxrWGFqeWdrd1ZEd1dSOWRLVGxaUW5EQ1pB?=
 =?gb2312?B?WUY5MndjMkxPcXZRT2haaFJrNXVpUXczVVQ5WVNtWW1OR0d5M2lDVjNHOFhN?=
 =?gb2312?B?TnpRK3dCMXRFSU5nNE9ocTgzTmlLbGE2S2I1Y3dXRkowNkdBZWZpV05CdHY4?=
 =?gb2312?B?Z09FNC8wL2NUemZ3S05Mdk9SOUYzemc4UWZucnEvS0ZNRzRIZVhYemZ0b1A3?=
 =?gb2312?B?b3RWaFJHOXkvZFdUOE9Sa0xJWHdTQjFvVVpORmRic2RzRE9iOFhSNStWRnNh?=
 =?gb2312?B?NTRRMjMzQVZNb3RGeXFZZCtTTkY0WmsrVVp2Y0NuL3JVZmlBTThsSVZvMXhw?=
 =?gb2312?B?TU1LRmUyK3NlcGNrSDl4NTJUcVRGTjFTNUFMdDZqd05jMjNyQXdCUytxY1dm?=
 =?gb2312?B?dXVNRGJVMkpsRitrVFkydUlmRkJySHd2TkNrMU9CQ0VHS0RPeVZhK2pROXRG?=
 =?gb2312?B?Y2JpdjNqL3FVSkV6Wnk4V05mZ1l2UWhLbHM5b0VZQzlQZ2xOUGUwTGgzRHVk?=
 =?gb2312?B?R093WlowengwbkdCam1zenc2U3EzU2lhb1d1V2haYjVBOGJtclh6MkU3d0dp?=
 =?gb2312?B?TXg5eXZqclB3MHpWSWFmWkNwSlpyVnQzYlN5RWpXMHYrQlI1MTBBNmdMMENm?=
 =?gb2312?B?T284N09ENThNa1g3bldKb3drb1R3RUZZSWhBcnh3eCs3eldjNEdqREJXUW96?=
 =?gb2312?B?bFBlSEJ6ZFdCVjVHWUhXbFFRcUFKNk1yR21XRUltcnB2OWp5UTJTOURSZVFo?=
 =?gb2312?B?QXVmQmFOL1h1dFZJOWZFbG9id0pneUVTWVg3ZThGd1E3dG10VFZueVY2T0RG?=
 =?gb2312?B?UHMwWTRFYVFJQ0YvTXdqYlRVQlF2OGxYRlhNalNBOGd3SW81TXdSVlh2a0h5?=
 =?gb2312?B?enZVelpVREQ4MTdTTGhROHNuQWRRalNmZHMwb3FKUjBwRmhQQTk2TWRsVUdG?=
 =?gb2312?B?K0RXaVZEbFN1Y21VbE44WGVQelg5bEltS0NKUHFlMnlxZHprZXY5dE1iVmZS?=
 =?gb2312?B?Wk01R2tJakJNU2xibGZWcnY0NFhkN3FrVnh4S2lDbTdlRDdzWWxaczlYbHhZ?=
 =?gb2312?B?dFRZaHBMQnBQYmlUZUhMbTRkOTFhajY4UHdQUjlMMGNkUFRnZUNmN1hjamh4?=
 =?gb2312?B?QXh5Q1BaRUhWZ2FYdFcwZCs1WmtYbERwRGNqTmZNejh1Ukk4NFJxRUtLL2ZE?=
 =?gb2312?B?TzlSVmVMYzAyM0lvOFlQMlY4OHJwclBidSswMDZSQUlpVGVMWlVXK3dSdksr?=
 =?gb2312?B?WGdHTit2SXJ4U2phZkVmY2VkZWV0MUk0aFE4WEQwaHk0ZUdnZ0Z5Y3FuOWRo?=
 =?gb2312?B?UEd3UCs2MEl6c0dKclBvc2RST3hRT1VxZXNydVhXeTFzT0lOWldlblhwYTY0?=
 =?gb2312?B?bHB3WmFtWHhRdWY4MmFIQTJ3YUd3eUJtSnNidW9qMW1keE9NcjhjU1A4dnRP?=
 =?gb2312?B?WThZT3JIZGZlRVZEVG1aWG1qQksxaXB5SXh2c2JRVk1qc0l1RG0zczJrQ21l?=
 =?gb2312?B?OVRvV1NXOUpVT3FqYmJyY1ZHUGwrMkU0ZklKL2NReklkYXRkRHJxWHJlUWFi?=
 =?gb2312?B?ZmRkWUxabFEwakovWkxBRFF0MFpOeEcvQXZKdEc4YTIxS2EwLyt4d3NieUFS?=
 =?gb2312?B?VCtZa1dPd29hTzI0VHN1L28reGhiNTMveHkrYVdoMUlLUGFrWU8xSHJDQ0Qr?=
 =?gb2312?B?dXZieWFSQ21mdmE1YVFyZFdjbERacUlHTHEvNzZIK1RXRjFseVh5TlA0VDcr?=
 =?gb2312?B?d3RZOS8vZkYwUzR1bXBCK0VIQVdUN3llN05zL3RzNi82Q2pFUm92V0pwN21L?=
 =?gb2312?B?a3FieEZKZzI1SUh4WU9lRWlSd1JTZ2lDY00zY1N3Vnd2eGJpYy9YeEhZYzdW?=
 =?gb2312?B?MXp1NU52MjlWdUl0dXNNb2RVOTBEZENua1RjVldzV2Roakx6VHhqc3Zkd2k0?=
 =?gb2312?B?eEVQd1NUWUkxa3pMNnVyVUZBUWd4MzJrN2dNV1phUTZvQ1ZLY1Jvc1BJb012?=
 =?gb2312?B?cEVKVDd4bzVFTUlWYUVneTMyeEhPOEtoOEhXUXRhNG43ZzNoTVEzTDdYUDdG?=
 =?gb2312?Q?V3aGbA9lmd9VHjqyJegw5Xdm5?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736d3312-8cfb-4357-2cf7-08dae19e4c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 08:52:02.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Wb1WEQbSv87fkB/OtD67GkAQAAarHiF+q0IFvAWorJNBIbwfyRAH0H+W0fO2Kp3c02xNXJ2LH8PWDn6qU9+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319
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
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEy1MIxNcjV
IDE4OjEyDQo+IFRvOiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBqaWMyM0BrZXJu
ZWwub3JnOyBsYXJzQG1ldGFmb28uZGU7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGZlc3RldmFtQGdt
YWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNd
IGR0LWJpbmRpbmdzOiBpaW86IGFkYzogQWRkIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3INCj4g
TlhQIElNWDkzIEFEQw0KPiANCj4gT24gMTQvMTIvMjAyMiAxNDozNSwgaGFpYm8uY2hlbkBueHAu
Y29tIHdyb3RlOg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Pg0KPiA+IFRoZSBJTVg5MyBTb0MgaGFzIGEgbmV3IEFEQyBJUCwgc28gYWRkIGJpbmRpbmcgZG9j
dW1lbnRhdGlvbiBmb3IgTlhQDQo+ID4gSU1YOTMgQURDLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmlu
ZGluZ3MvaWlvL2FkYy9ueHAsaW14OTMtYWRjLnlhbWwgICAgICAgfCA3OQ0KPiArKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vYWRjL254cCxpbXg5My1hZGMueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbnhwLGlteDkzLWFkYy55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9ueHAsaW14
OTMtYWRjLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMjI5YmI3OWUyNTVjDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL254cCxpbXg5My1hZGMueWFtbA0KPiAN
Cj4gVGhpcyB3YXMgYWxyZWFkeSBzZW50LCBzbyBJIGFtIHN1cnByaXNlZCB0byBzZWUgdGhpcyBp
biB3b3JzZSBvciB0aGUgc2FtZSBzdGF0ZS4NCj4gRG9uJ3QgZm9yY2UgdXMgdG8gcmVwZWF0IHJl
dmlldywgaXQncyBhIHdhc3RlIG9mIHRpbWUuDQoNClNvcnJ5LCBJJ20gZm9jdXMgb24gdGhlIGRy
aXZlciBzaWRlLCB3aWxsIHBheSBtdWNoIGF0dGVudGlvbiBvbiB0aGUgeWFtbCBiaW5kaW5nLg0K
DQpCeSB0aGUgd2F5LCBmb3IgeW91ciBmaXJzdCByZXZpZXcgY29tbWVudHM6DQoNCiAgID4gKw0K
ICAgPiArICBjbG9ja3M6DQogICA+ICsgICAgbWF4SXRlbXM6IDENCiAgID4gKw0KICAgPiArICBj
bG9jay1uYW1lczoNCiAgID4gKyAgICBjb25zdDogaXBnDQoNCiAgIE5vIG5lZWQgZm9yIGNsb2Nr
LW5hbWVzIGluIHN1Y2ggY2FzZS4NCg0KDQpIb3cgc2hvdWxkIEkgaGFuZGxlIHRoaXMgY2FzZSBo
ZXJlPyBJIHNlYXJjaCBpbiB0aGlzIGRpcmVjdG9yeShpaW8vYWRjKSwgYW5kIGZpbmQgbWFueSBv
dGhlciB5YW1sIGFsc28gd3JpdGUgdGhpcyB3YXkuDQpEbyB5b3UgbWVhbiBjaGFuZ2UgbGlrZSB0
aGlzOg0KICAgICBjbG9jay1uYW1lczogIHRydWUNCg0KSWYgeW91IHdpbGwsIGNhbiB5b3UgaGVs
cCB0ZWxsIHdoZXJlIGlzIHRoZSB5YW1sIGd1aWRlLCBJJ20gbm90IGZhbWlsaWFyIHdpdGggeWFt
bCBydWxlLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0KPiANCj4gPiBAQCAtMCwwICsx
LDc5IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0y
LUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+ID4gK2h0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGZGV2
aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGc2NoZW1hcyUyRmlpbyUyRmFkYyUyRm54cCUyQ2lteDkz
LWFkYy55YW1sJTIzJmFtcDtkYQ0KPiB0YT0wDQo+ID4NCj4gKzUlN0MwMSU3Q2hhaWJvLmNoZW4l
NDBueHAuY29tJTdDMGY1ZGJkZTZlOTFiNGM4ZjkyMGMwOGRhZGU4NGMyYjQNCj4gJTdDNjgNCj4g
Pg0KPiArNmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzgwNjY5NTkw
MzA2ODk5NDIlN0MNCj4gVW5rbm93bg0KPiA+DQo+ICslN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhVw0KPiB3aUxDDQo+ID4NCj4g
K0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWlHN2tMMTJFWjE3anFQeUxQ
eDhYNzkNCj4gbThNdXphdWwNCj4gPiArQ1pEdXFBbDhBeWhkdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiA+ICskc2NoZW1hOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRm1l
dGEtc2NoZW1hcyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0YT0wNSU3QzAxJTdDaGFpYg0KPiBvLmNo
ZQ0KPiA+DQo+ICtuJTQwbnhwLmNvbSU3QzBmNWRiZGU2ZTkxYjRjOGY5MjBjMDhkYWRlODRjMmI0
JTdDNjg2ZWExZDNiYzJiNGMNCj4gNmZhOTJjDQo+ID4NCj4gK2Q5OWM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM4MDY2OTU5MDMwNjg5OTQyJTdDVW5rbm93biU3Q1RXRnBiDQo+IEdac2IzZDhleUoNCj4g
Pg0KPiArV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxD
SlhWQ0k2TW4wJTNEJTcNCj4gQzMwMA0KPiA+DQo+ICswJTdDJTdDJTdDJmFtcDtzZGF0YT1mWGth
Zm1xOSUyRkx4bzJJJTJGeUlGUmNUZ3dWTUxQN3lCWFlEUHJuMA0KPiBESnp1VjQlDQo+ID4gKzNE
JmFtcDtyZXNlcnZlZD0wDQo+ID4gKw0KPiA+ICt0aXRsZTogTlhQIGlNWDkzIEFEQyBiaW5kaW5n
cw0KPiANCj4gRHJvcCBiaW5kaW5ncy4gSG93IGRpZCBpdCBhcHBlYXIgaGVyZT8gSXQgd2Fzbid0
IGluIHYxLg0KPiANCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gSGFpYm8gQ2hl
biA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAg
VGhlIEFEQyBvbiBpTVg5MyBpcyBhIDgtY2hhbm5lbCAxMi1iaXQgMU1TL3MgQURDIHdpdGggNCBj
aGFubmVscw0KPiA+ICsgIGNvbm5lY3RlZCB0byBwaW5zLiBpdCBzdXBwb3J0IG5vcm1hbCBhbmQg
aW5qZWN0IG1vZGUsIGluY2x1ZGUNCj4gPiArICBPbmUtU2hvdCBhbmQgU2NhbiAoY29udGludW91
cykgY29udmVyc2lvbnMuIFByb2dyYW1tYWJsZSBETUENCj4gPiArICBlbmFibGVzIGZvciBlYWNo
IGNoYW5uZWwgIEFsc28gdGhpcyBBREMgY29udGFpbiBhbHRlcm5hdGUgYW5hbG9nDQo+ID4gKyAg
d2F0Y2hkb2cgdGhyZXNob2xkcywgc2VsZWN0IHRocmVzaG9sZCB0aHJvdWdoIGlucHV0IHBvcnRz
LiBBbmQNCj4gPiArICBhbHNvIGhhcyBTZWxmLXRlc3QgbG9naWMgYW5kIFNvZnR3YXJlLWluaXRp
YXRlZCBjYWxpYnJhdGlvbi4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0
aWJsZToNCj4gPiArICAgIGNvbnN0OiBueHAsaW14OTMtYWRjDQo+ID4gKw0KPiA+ICsgIHJlZzoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgbGluZSAwIGZvciBXREduTCAod2F0Y2hkb2cgdGhy
ZXNob2xkKSBpbnRlcnJ1cHQgcmVxdWVzdHMuDQo+ID4gKyAgICAgIGxpbmUgMSBmb3IgV0RHbkgg
KHdhdGNoZG9nIHRocmVzaG9sZCkgaW50ZXJydXB0IHJlcXVlc3RzLg0KPiA+ICsgICAgICBsaW5l
IDIgZm9yIG5vcm1hbCBjb252ZXJzaW9uLCBpbmNsdWRlIEVPQyAoRW5kIG9mIENvbnZlcnNpb24p
DQo+ID4gKyAgICAgIGludGVycnVwdCByZXF1ZXN0LCBFQ0ggKEVuZCBvZiBDaGFpbikgaW50ZXJy
dXB0IHJlcXVlc3QsDQo+ID4gKyAgICAgIEpFT0MgKEVuZCBvZiBJbmplY3RlZCBDb252ZXJzaW9u
IG1vZGUpIGludGVycnVwdCByZXF1ZXN0DQo+ID4gKyAgICAgIGFuZCBKRUNIIChFbmQgb2YgaW5q
ZWN0ZWQgQ2hhaW4pIGludGVycnVwdCByZXF1ZXN0Lg0KPiA+ICsgICAgICBsaW5lIDMgZm9yIFNl
bGYtdGVzdGluZyBJbnRlcnJ1cHRzLg0KPiA+ICsgICAgbWF4SXRlbXM6IDQNCj4gPiArDQo+ID4g
KyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgdnJlZi1zdXBw
bHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIHJlZmVyZW5jZSB2b2x0
YWdlIHdoaWNoIHVzZWQgdG8gZXN0YWJsaXNoIGNoYW5uZWwgc2NhbGluZy4NCj4gPiArDQo+ID4g
KyAgIiNpby1jaGFubmVsLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50
ZXJydXB0cw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+ICsgIC0g
dnJlZi1zdXBwbHkNCj4gPiArICAtICIjaW8tY2hhbm5lbC1jZWxscyINCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCg==
